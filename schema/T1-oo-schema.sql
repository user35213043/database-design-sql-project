/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T1-oo-schema.sql

--Student ID: 35213043
--Student Name: George Gabriel Widjaja

/* drop table statements - do not remove*/

DROP TABLE address CASCADE CONSTRAINTS PURGE;

DROP TABLE manifest CASCADE CONSTRAINTS PURGE;

DROP TABLE passenger CASCADE CONSTRAINTS PURGE;

/* end of drop table statements*/

-- Task 1 Add Create table statements for the Missing TABLES below.
-- The columns/attributes must be in the same order as shown in the model.
-- Ensure all column comments, and constraints (other than FK's)are included.
-- FK constraints are to be added at the end of this script.

-- ADDRESS

CREATE TABLE address (
    address_id      NUMBER(6)    NOT NULL,
    address_street  VARCHAR2(50) NOT NULL,   -- 50 per ERD
    address_town    VARCHAR2(30) NOT NULL,   -- 30 per ERD
    address_pcode   VARCHAR2(10) NOT NULL,
    country_code    CHAR(3)      NOT NULL
);

COMMENT ON COLUMN address.address_id     IS 'Address unique identifier';
COMMENT ON COLUMN address.address_street IS 'Street address (e.g., 10 Example St)';
COMMENT ON COLUMN address.address_town   IS 'Town/City name';
COMMENT ON COLUMN address.address_pcode  IS 'Postal/ZIP code';
COMMENT ON COLUMN address.country_code   IS 'ISO alpha-3 code of country';

ALTER TABLE address
  ADD CONSTRAINT address_pk PRIMARY KEY (address_id);

-- MANIFEST

CREATE TABLE manifest (
    manifest_id             NUMBER(8)   NOT NULL,  -- 8 per ERD
    passenger_id            NUMBER(6)   NOT NULL,  -- order matches ERD
    cruise_id               NUMBER(6)   NOT NULL,
    manifest_board_datetime DATE,
    ship_code               NUMBER(4)   NOT NULL,
    cabin_no                VARCHAR2(5) NOT NULL
);

COMMENT ON COLUMN manifest.manifest_id             IS 'Manifest unique identifier';
COMMENT ON COLUMN manifest.passenger_id            IS 'FK to passenger';
COMMENT ON COLUMN manifest.cruise_id               IS 'FK to cruise';
COMMENT ON COLUMN manifest.manifest_board_datetime IS 'Boarding date/time (may be NULL for future/no-show)';
COMMENT ON COLUMN manifest.ship_code               IS 'Ship code for allocated cabin';
COMMENT ON COLUMN manifest.cabin_no                IS 'Allocated cabin number on that ship';

ALTER TABLE manifest
  ADD CONSTRAINT manifest_pk PRIMARY KEY (manifest_id);

/* One booking per passenger per cruise */
ALTER TABLE manifest
  ADD CONSTRAINT manifest_uc UNIQUE (cruise_id, passenger_id);

-- PASSENGER

CREATE TABLE passenger (
    passenger_id           NUMBER(6)    NOT NULL,
    passenger_fname        VARCHAR2(25) NOT NULL,
    passenger_lname        VARCHAR2(25) NOT NULL,
    passenger_dob          DATE         NOT NULL,
    passenger_gender       CHAR(1)      NOT NULL,
    passenger_contact      VARCHAR2(15),            -- 15 per ERD
    passenger_specialneed  CHAR(1)      NOT NULL,
    address_id             NUMBER(6)    NOT NULL,
    guardian_id            NUMBER(6)
);

COMMENT ON COLUMN passenger.passenger_id          IS 'Passenger unique identifier';
COMMENT ON COLUMN passenger.passenger_fname       IS 'Passenger first name';
COMMENT ON COLUMN passenger.passenger_lname       IS 'Passenger last name';
COMMENT ON COLUMN passenger.passenger_dob         IS 'Date of birth';
COMMENT ON COLUMN passenger.passenger_gender      IS 'M=Male, F=Female, X=Other/Unspecified';
COMMENT ON COLUMN passenger.passenger_contact     IS 'Primary phone (NULL permitted for minors)';
COMMENT ON COLUMN passenger.passenger_specialneed IS 'Y=Yes, N=No';
COMMENT ON COLUMN passenger.address_id            IS 'FK to home address';
COMMENT ON COLUMN passenger.guardian_id           IS 'Self-FK to guardian (required if minor)';

ALTER TABLE passenger
  ADD CONSTRAINT passenger_pk PRIMARY KEY (passenger_id);

ALTER TABLE passenger
  ADD CONSTRAINT passenger_gender_chk
      CHECK (passenger_gender IN ('M','F','X'));

ALTER TABLE passenger
  ADD CONSTRAINT passenger_specialneed_chk
      CHECK (passenger_specialneed IN ('Y','N'));

-- Add all missing FK Constraints below here
-- You must use the default delete rule (i.e. no action/restrict) 
-- for all foreign keys.


/* ADDRESS -> COUNTRY */
ALTER TABLE address
  ADD CONSTRAINT country_address_fk
      FOREIGN KEY (country_code)
      REFERENCES country (country_code);

/* PASSENGER -> ADDRESS */
ALTER TABLE passenger
  ADD CONSTRAINT address_passenger_fk
      FOREIGN KEY (address_id)
      REFERENCES address (address_id);

/* PASSENGER (guardian self-reference) */
ALTER TABLE passenger
  ADD CONSTRAINT guardian_passenger_fk
      FOREIGN KEY (guardian_id)
      REFERENCES passenger (passenger_id);

/* MANIFEST -> PASSENGER */
ALTER TABLE manifest
  ADD CONSTRAINT passenger_manifest_fk
      FOREIGN KEY (passenger_id)
      REFERENCES passenger (passenger_id);

/* MANIFEST -> CRUISE */
ALTER TABLE manifest
  ADD CONSTRAINT cruise_manifest_fk
      FOREIGN KEY (cruise_id)
      REFERENCES cruise (cruise_id);

/* MANIFEST -> CABIN (composite) */
ALTER TABLE manifest
  ADD CONSTRAINT cabin_manifest_fk
      FOREIGN KEY (ship_code, cabin_no)
      REFERENCES cabin (ship_code, cabin_no);