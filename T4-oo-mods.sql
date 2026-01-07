--****PLEASE ENTER YOUR DETAILS BELOW****
--T4-oo-mods.sql

--Student ID: 35213043
--Student Name: George Gabriel Widjaja


--(a)
BEGIN
  EXECUTE IMMEDIATE q'[
    CREATE TABLE maintenance_type (
      maint_type_code   CHAR(3)    CONSTRAINT maintenance_type_pk PRIMARY KEY,
      maint_type_name   VARCHAR2(40) NOT NULL
    )
  ]';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF; -- -955 = ORA-00955 name already used
END;
/

COMMENT ON TABLE maintenance_type IS 'Reference data for maintenance types used by Ocean Odyssey';
COMMENT ON COLUMN maintenance_type.maint_type_code IS 'Code: PM=Preventive, BM=Breakdown, CBM=Condition-Based';
COMMENT ON COLUMN maintenance_type.maint_type_name IS 'Human-readable maintenance type name';

-- Seed/ensure the three types exist (idempotent)
MERGE INTO maintenance_type t
USING (SELECT 'PM' AS c, 'Preventive Maintenance' AS n FROM dual UNION ALL
       SELECT 'BM',        'Breakdown Maintenance'       FROM dual UNION ALL
       SELECT 'CBM',       'Condition-Based Maintenance' FROM dual) s
ON (t.maint_type_code = s.c)
WHEN NOT MATCHED THEN
  INSERT (maint_type_code, maint_type_name) VALUES (s.c, s.n);

-- Create ship maintenance table (idempotent)
BEGIN
  EXECUTE IMMEDIATE q'[
    CREATE TABLE ship_maintenance (
      maintenance_id     NUMBER(10)   CONSTRAINT ship_maintenance_pk PRIMARY KEY,
      ship_code          NUMBER(4)    NOT NULL,
      maint_type_code    CHAR(3)      NOT NULL,
      sched_start_date   DATE         NOT NULL,
      sched_end_date     DATE         NOT NULL,
      actual_start_ts    DATE         NULL,
      actual_end_ts      DATE         NULL,
      CONSTRAINT ship_ship_maintenance_fk
        FOREIGN KEY (ship_code) REFERENCES ship (ship_code),
      CONSTRAINT mainttype_ship_maintenance_fk
        FOREIGN KEY (maint_type_code) REFERENCES maintenance_type (maint_type_code),
      -- Basic temporal sanity checks
      CONSTRAINT ship_maint_sched_chk
        CHECK (sched_end_date >= sched_start_date),
      CONSTRAINT ship_maint_actual_chk
        CHECK ( (actual_start_ts IS NULL AND actual_end_ts IS NULL)
             OR (actual_start_ts IS NOT NULL AND actual_end_ts IS NULL)
             OR (actual_start_ts IS NOT NULL AND actual_end_ts IS NOT NULL AND actual_end_ts >= actual_start_ts) )
    )
  ]';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

COMMENT ON TABLE ship_maintenance IS 'Per-ship maintenance schedule and completion timestamps';
COMMENT ON COLUMN ship_maintenance.maintenance_id  IS 'Surrogate key for maintenance record';
COMMENT ON COLUMN ship_maintenance.ship_code       IS 'FK to SHIP.ship_code';
COMMENT ON COLUMN ship_maintenance.maint_type_code IS 'FK to MAINTENANCE_TYPE.maint_type_code';
COMMENT ON COLUMN ship_maintenance.sched_start_date IS 'Scheduled maintenance start date (no time)';
COMMENT ON COLUMN ship_maintenance.sched_end_date   IS 'Scheduled maintenance end date (no time)';
COMMENT ON COLUMN ship_maintenance.actual_start_ts  IS 'Actual maintenance start datetime (nullable until started)';
COMMENT ON COLUMN ship_maintenance.actual_end_ts    IS 'Actual maintenance end datetime (nullable until finished)';

-- Optional: sequence for maintenance_id if needed for future inserts
BEGIN
  EXECUTE IMMEDIATE 'CREATE SEQUENCE ship_maintenance_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

-- Evidence (structure)
DESC maintenance_type;
DESC ship_maintenance;


--(b)
 
-- Create categories table
BEGIN
  EXECUTE IMMEDIATE q'[
    CREATE TABLE special_need_category (
      sn_cat_code    VARCHAR2(10) CONSTRAINT special_need_category_pk PRIMARY KEY,
      sn_cat_name    VARCHAR2(40) NOT NULL,
      CONSTRAINT special_need_category_name_uc UNIQUE (sn_cat_name)
    )
  ]';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

COMMENT ON TABLE special_need_category IS 'Extensible set of passenger special-need categories';
COMMENT ON COLUMN special_need_category.sn_cat_code IS 'Short stable code for category (e.g., GENERAL, MOBILITY)';
COMMENT ON COLUMN special_need_category.sn_cat_name IS 'Display name for the category';

-- Ensures baseline categories
MERGE INTO special_need_category c
USING (SELECT 'GENERAL' AS code, 'General' AS name FROM dual UNION ALL
       SELECT 'MOBILITY',        'Mobility'        FROM dual UNION ALL
       SELECT 'HEARING',         'Hearing'         FROM dual UNION ALL
       SELECT 'VISUAL',          'Visual'          FROM dual UNION ALL
       SELECT 'OTHER',           'Other'           FROM dual) s
ON (c.sn_cat_code = s.code)
WHEN NOT MATCHED THEN
  INSERT (sn_cat_code, sn_cat_name) VALUES (s.code, s.name);

-- Create associative table for passenger needs
BEGIN
  EXECUTE IMMEDIATE q'[
    CREATE TABLE passenger_need (
      passenger_id   NUMBER(6)      NOT NULL,
      sn_cat_code    VARCHAR2(10)   NOT NULL,
      need_detail    VARCHAR2(4000) NULL,
      CONSTRAINT passenger_need_pk PRIMARY KEY (passenger_id, sn_cat_code),
      CONSTRAINT passenger_passenger_need_fk
        FOREIGN KEY (passenger_id) REFERENCES passenger (passenger_id),
      CONSTRAINT sncat_passenger_need_fk
        FOREIGN KEY (sn_cat_code)  REFERENCES special_need_category (sn_cat_code)
    )
  ]';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

COMMENT ON TABLE passenger_need IS 'Per-passenger selection of special-need categories with optional detail';
COMMENT ON COLUMN passenger_need.passenger_id IS 'FK to PASSENGER.passenger_id';
COMMENT ON COLUMN passenger_need.sn_cat_code  IS 'FK to SPECIAL_NEED_CATEGORY.sn_cat_code';
COMMENT ON COLUMN passenger_need.need_detail  IS 'Optional free text describing specific need';

-- Evidence (structure)
DESC special_need_category;
DESC passenger_need;

-- One-time migration:
--  For all passengers where passenger_specialneed='Y', insert GENERAL category if not already present.
BEGIN
  SAVEPOINT sn_migration_sp;

  INSERT /*+ ignore_row_on_dupkey_index(passenger_need passenger_need_pk) */
  INTO passenger_need (passenger_id, sn_cat_code, need_detail)
  SELECT p.passenger_id, 'GENERAL', NULL
  FROM passenger p
  WHERE p.passenger_specialneed = 'Y';

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK TO sn_migration_sp;
    RAISE;
END;
/

-- Show counts and a small sample of mapped passengers
SELECT 'TOTAL_NEED_ROWS' AS label, COUNT(*) AS cnt FROM passenger_need;

SELECT pn.passenger_id, pn.sn_cat_code, pn.need_detail
FROM passenger_need pn
WHERE pn.sn_cat_code = 'GENERAL'
FETCH FIRST 10 ROWS ONLY;

ALTER TABLE passenger_need
  ADD CONSTRAINT passenger_need_uk UNIQUE (passenger_id, sn_cat_code);

COMMIT;