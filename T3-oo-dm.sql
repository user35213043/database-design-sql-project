--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-oo-dm.sql

--Student ID: 35213043
--Student Name: George Gabriel Widjaja

--(a)
-- Drop existing sequences if they exist
DROP SEQUENCE address_seq;
DROP SEQUENCE passenger_seq;
DROP SEQUENCE manifest_seq;

-- Create sequences
CREATE SEQUENCE address_seq
  START WITH 500
  INCREMENT BY 5
  NOCACHE
  NOCYCLE;

CREATE SEQUENCE passenger_seq
  START WITH 500
  INCREMENT BY 5
  NOCACHE
  NOCYCLE;

CREATE SEQUENCE manifest_seq
  START WITH 500
  INCREMENT BY 5
  NOCACHE
  NOCYCLE;


--(b)

-- (b1) Address: insert only if it doesn't already exist
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code)
SELECT address_seq.NEXTVAL, '23 Banksia Avenue', 'Melbourne', '3000', 'AUS'
FROM dual
WHERE NOT EXISTS (
  SELECT 1
  FROM address
  WHERE address_street = '23 Banksia Avenue'
    AND address_town   = 'Melbourne'
    AND address_pcode  = '3000'
    AND country_code   = 'AUS'
);

-- (b2) Dominik (father / guardian): insert if not present
INSERT INTO passenger (
  passenger_id, passenger_fname, passenger_lname, passenger_dob,
  passenger_gender, passenger_contact, passenger_specialneed,
  address_id, guardian_id
)
SELECT
  passenger_seq.NEXTVAL,
  'Dominik', 'Kohl', DATE '1985-05-10',
  'M', '+61493336312', 'N',
  (SELECT address_id
     FROM address
    WHERE address_street='23 Banksia Avenue'
      AND address_town  ='Melbourne'
      AND address_pcode ='3000'
      AND country_code  ='AUS'),
  NULL
FROM dual
WHERE NOT EXISTS (
  SELECT 1
  FROM passenger
  WHERE passenger_fname='Dominik' AND passenger_lname='Kohl'
    AND address_id = (SELECT address_id
                        FROM address
                       WHERE address_street='23 Banksia Avenue'
                         AND address_town  ='Melbourne'
                         AND address_pcode ='3000'
                         AND country_code  ='AUS')
);

-- (b3) Stella (child): insert if not present, guardian = Dominik
INSERT INTO passenger (
  passenger_id, passenger_fname, passenger_lname, passenger_dob,
  passenger_gender, passenger_contact, passenger_specialneed,
  address_id, guardian_id
)
SELECT
  passenger_seq.NEXTVAL,
  'Stella', 'Kohl', DATE '2010-08-15',
  'F', NULL, 'N',
  (SELECT address_id
     FROM address
    WHERE address_street='23 Banksia Avenue'
      AND address_town  ='Melbourne'
      AND address_pcode ='3000'
      AND country_code  ='AUS'),
  (SELECT passenger_id FROM passenger WHERE passenger_fname='Dominik' AND passenger_lname='Kohl')
FROM dual
WHERE NOT EXISTS (
  SELECT 1 FROM passenger WHERE passenger_fname='Stella' AND passenger_lname='Kohl'
);

-- (b4) Poppy (child): insert if not present, guardian = Dominik
INSERT INTO passenger (
  passenger_id, passenger_fname, passenger_lname, passenger_dob,
  passenger_gender, passenger_contact, passenger_specialneed,
  address_id, guardian_id
)
SELECT
  passenger_seq.NEXTVAL,
  'Poppy', 'Kohl', DATE '2012-09-25',
  'F', NULL, 'N',
  (SELECT address_id
     FROM address
    WHERE address_street='23 Banksia Avenue'
      AND address_town  ='Melbourne'
      AND address_pcode ='3000'
      AND country_code  ='AUS'),
  (SELECT passenger_id FROM passenger WHERE passenger_fname='Dominik' AND passenger_lname='Kohl')
FROM dual
WHERE NOT EXISTS (
  SELECT 1 FROM passenger WHERE passenger_fname='Poppy' AND passenger_lname='Kohl'
);

-- (b5) Manifest: add 3 bookings, avoid duplicates, and validate cabin 8035 on the ship
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no)
SELECT
  manifest_seq.NEXTVAL,
  p.passenger_id,
  c.cruise_id,
  NULL,                  -- future booking (no boarding yet)
  c.ship_code,           -- ship from cruise
  '8035'
FROM passenger p
JOIN cruise   c
  ON UPPER(c.cruise_name) = UPPER('MELBOURNE TO SINGAPORE')
 AND TRUNC(c.cruise_depart_dt, 'MI') = TO_DATE('30-Nov-2025 09:30','dd-Mon-yyyy hh24:mi')
JOIN cabin    ca
  ON ca.ship_code = c.ship_code
 AND ca.cabin_no  = '8035'
WHERE p.passenger_lname = 'Kohl'
  AND p.passenger_fname IN ('Dominik','Stella','Poppy')
  -- avoid duplicates on re-run
  AND NOT EXISTS (
        SELECT 1
        FROM manifest m
        WHERE m.cruise_id   = c.cruise_id
          AND m.passenger_id= p.passenger_id
      );

COMMIT;


--(c)
-- Step 1: Remove Stella’s booking for MELBOURNE TO SINGAPORE
DELETE FROM manifest
WHERE passenger_id = (
    SELECT passenger_id
    FROM passenger
    WHERE passenger_fname = 'Stella' AND passenger_lname = 'Kohl'
)
AND cruise_id = (
    SELECT cruise_id
    FROM cruise
    WHERE UPPER(cruise_name) = UPPER('MELBOURNE TO SINGAPORE')
      AND TRUNC(cruise_depart_dt, 'MI') = TO_DATE('30-Nov-2025 09:30','dd-Mon-yyyy hh24:mi')
);

-- Step 2: Update Dominik + Poppy to new cabin 9015
UPDATE manifest
SET cabin_no = '9015'
WHERE passenger_id IN (
    SELECT passenger_id
    FROM passenger
    WHERE passenger_fname IN ('Dominik','Poppy') AND passenger_lname = 'Kohl'
)
AND cruise_id = (
    SELECT cruise_id
    FROM cruise
    WHERE UPPER(cruise_name) = UPPER('MELBOURNE TO SINGAPORE')
      AND TRUNC(cruise_depart_dt, 'MI') = TO_DATE('30-Nov-2025 09:30','dd-Mon-yyyy hh24:mi')
);

COMMIT;


--(d)

DELETE FROM manifest
WHERE passenger_id IN (
    SELECT passenger_id
    FROM passenger
    WHERE passenger_fname IN ('Dominik','Poppy')
      AND passenger_lname = 'Kohl'
)
AND cruise_id = (
    SELECT cruise_id
    FROM cruise
    WHERE UPPER(cruise_name) = UPPER('MELBOURNE TO SINGAPORE')
      AND TRUNC(cruise_depart_dt, 'MI') =
          TO_DATE('30-Nov-2025 09:30','dd-Mon-yyyy hh24:mi')
);

COMMIT;
