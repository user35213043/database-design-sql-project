/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-oo-insert.sql

--Student ID: 35213043
--Student Name: George Gabriel Widjaja

/* GenAI Acknowledgement and Prompts:
   I used ChatGPT (GPT-5) to generate example test data such as random 
   passenger names, addresses, and locations for Task 2 only. 
   I reviewed and edited the data to ensure that it meets the assignment brief 
   requirements (10 address, 20 passenger, 30 manifest entries).

   Prompt Used: 
      • "Generate INSERT statements for 10 random addresses with realistic street names, 
        towns, postcodes, and country codes. Use at least three different countries."
      • “Use realistic Australian and international locations and proper Oracle SQL syntax."
      • "Generate INSERT statements for 20 passengers, including at least five minors 
        with guardian relationships, one passenger with special needs, and realistic 
        phone numbers and birth dates."
      • "Generate INSERT statements for 30 manifest records, ensuring at least two 
        passengers appear on multiple cruises, two passengers are marked as no-shows 
        (NULL boarding date), and two future cruises are included."
*/

-- Task 2 Load the ADDRESS, PASSENGER and MANIFEST tables with your own
-- test data following the data requirements expressed in the brief

-- =======================================
-- ADDRESS
-- =======================================

INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 1, '10 Collins St',        'Melbourne',    '3000', 'AUS');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 2, '88 Swanston Ave',      'Melbourne',    '3000', 'AUS');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 3, '25 Queen St',          'Auckland',     '1010', 'NZL');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 4, '5 Marina Bay',         'Singapore',    '018940','SGP');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 5, '120 George St',        'Sydney',       '2000', 'AUS');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 6, '9 Orchard Rd',         'Singapore',    '238802','SGP');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 7, '17 Jalan Sudirman',    'Jakarta',      '10270','IDN');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 8, '42 Queen St',          'Brisbane',     '4000', 'AUS');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES ( 9, '11 Queen St',          'Auckland',     '1010', 'NZL');
INSERT INTO address (address_id, address_street, address_town, address_pcode, country_code) VALUES (10, '501 5th Ave',          'New York',     '10018','USA');

-- =======================================
-- PASSENGER
-- =======================================

-- Adults
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 1, 'Liam',     'Hughes',   DATE '1988-03-12', 'M', '0400000001', 'N', 1, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 2, 'Sofia',    'Hughes',   DATE '1990-07-02', 'F', '0400000002', 'N', 1, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 3, 'Noah',     'Kumar',    DATE '1979-11-01', 'M', '0400000003', 'N', 2, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 4, 'Ava',      'Kumar',    DATE '1981-01-15', 'F', '0400000004', 'N', 2, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 5, 'Oliver',   'Ng',       DATE '1992-05-20', 'M', '0400000005', 'N', 3, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 6, 'Mia',      'Tan',      DATE '1995-02-10', 'F', '0400000006', 'N', 4, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 7, 'Lucas',    'Smith',    DATE '1987-08-08', 'M', '0400000007', 'N', 5, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 8, 'Emily',    'Smith',    DATE '1989-09-09', 'F', '0400000008', 'N', 5, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES ( 9, 'Aria',     'Lim',      DATE '1984-12-30', 'F', '0400000009', 'Y', 6, NULL); -- special need
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (10, 'James',    'Wijaya',   DATE '1983-04-04', 'M', '0400000010', 'N', 7, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (11, 'Grace',    'Wijaya',   DATE '1986-06-06', 'F', '0400000011', 'N', 7, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (12, 'Ethan',    'Lee',      DATE '1991-01-01', 'M', '0400000012', 'N', 8, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (13, 'Chloe',    'Lee',      DATE '1993-10-10', 'F', '0400000013', 'N', 8, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (14, 'Benjamin', 'Park',     DATE '1982-02-02', 'M', '0400000014', 'N', 9, NULL);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (15, 'Isla',     'Park',     DATE '1984-03-03', 'F', '0400000015', 'N', 9, NULL);
-- Minors 
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (16, 'Jack',     'Hughes',   DATE '2011-07-12', 'M', NULL, 'N', 1, 1);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (17, 'Ella',     'Hughes',   DATE '2013-11-22', 'F', NULL, 'N', 1, 2);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (18, 'Harper',   'Kumar',    DATE '2010-05-05', 'F', NULL, 'N', 2, 3);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (19, 'Leo',      'Smith',    DATE '2009-09-09', 'M', NULL, 'N', 5, 7);
INSERT INTO passenger (passenger_id, passenger_fname, passenger_lname, passenger_dob, passenger_gender, passenger_contact, passenger_specialneed, address_id, guardian_id)
VALUES (20, 'Mason',    'Wijaya',   DATE '2012-12-12', 'M', NULL, 'N', 7, 10);

-- =======================================
-- MANIFEST
-- =======================================

-- Cruise–Ship Mapping:
--   Cruises 1,4,6,9 → Ship 101
--   Cruises 2,5,10  → Ship 102
--   Cruises 3,7     → Ship 103
--   Cruise 8        → Ship 105
--
-- Boarding datetime:
--   Within 24h before departure when provided.
--   NULL = no-show or future booking.
--
-- Reference departure times:
--   C2: 16-Jun-2025 09:00 (102)
--   C3: 16-Jun-2025 09:00 (103)
--   C4: 07-Jul-2025 14:00 (101)
--   C7: 23-Oct-2025 15:00 (103)
--   C8: 30-Nov-2025 09:30 (105) [future]
--   C9: 06-Dec-2025 14:00 (101) [future]

-- c4 (ship 101)
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 1,  1, 4, TO_DATE('07-Jul-2025 13:30','dd-Mon-yyyy hh24:mi'), 101, '1001');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 2,  2, 4, TO_DATE('07-Jul-2025 13:30','dd-Mon-yyyy hh24:mi'), 101, '1002');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 3, 16, 4, TO_DATE('07-Jul-2025 13:40','dd-Mon-yyyy hh24:mi'), 101, '1011');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 4, 17, 4, TO_DATE('07-Jul-2025 13:40','dd-Mon-yyyy hh24:mi'), 101, '1011'); -- share 1011 (cap 2)

-- c2 (ship 102)
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 5,  3, 2, TO_DATE('16-Jun-2025 08:30','dd-Mon-yyyy hh24:mi'), 102, '2001');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 6,  4, 2, TO_DATE('16-Jun-2025 08:30','dd-Mon-yyyy hh24:mi'), 102, '2002');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 7, 18, 2, TO_DATE('16-Jun-2025 08:40','dd-Mon-yyyy hh24:mi'), 102, '2011');

-- c3 (ship 103)
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 8,  5, 3, TO_DATE('16-Jun-2025 08:40','dd-Mon-yyyy hh24:mi'), 103, '110');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES ( 9,  6, 3, TO_DATE('16-Jun-2025 08:45','dd-Mon-yyyy hh24:mi'), 103, '111');

-- c7 (ship 103)
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (10,  7, 7, TO_DATE('23-Oct-2025 14:30','dd-Mon-yyyy hh24:mi'), 103, '112');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (11,  8, 7, TO_DATE('23-Oct-2025 14:30','dd-Mon-yyyy hh24:mi'), 103, '113');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (12, 19, 7, TO_DATE('23-Oct-2025 14:40','dd-Mon-yyyy hh24:mi'), 103, '114');

-- c1 (ship 101) - long cruise; add a group
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (13, 12, 1, TO_DATE('02-Jun-2025 09:10','dd-Mon-yyyy hh24:mi'), 101, '2001');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (14, 13, 1, TO_DATE('02-Jun-2025 09:10','dd-Mon-yyyy hh24:mi'), 101, '2002');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (15, 14, 1, TO_DATE('02-Jun-2025 09:15','dd-Mon-yyyy hh24:mi'), 101, '2003');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (16, 15, 1, TO_DATE('02-Jun-2025 09:15','dd-Mon-yyyy hh24:mi'), 101, '2004');

-- c8 (ship 105) - future booking; include one no-show
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (17,  9, 8, NULL,                                            105, '8031'); -- future, no-show (yet)
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (18, 10, 8, NULL,                                            105, '8032'); -- future, no-show (yet)
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (19, 20, 8, NULL,                                            105, '8033'); -- future, minor with guardian (10)

-- c9 (ship 101) - future; board times still NULL (booked)
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (20,  1, 9, NULL,                                            101, '1012'); -- P1 on multiple cruises
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (21,  2, 9, NULL,                                            101, '1013'); -- P2 on multiple cruises
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (22, 16, 9, NULL,                                            101, '1011');

-- Add more completed historical bookings to reach ≥30 rows
-- c5 (ship 102)
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (23, 11, 5, TO_DATE('08-Jul-2025 10:00','dd-Mon-yyyy hh24:mi'), 102, '2003');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (24,  6, 5, TO_DATE('08-Jul-2025 10:05','dd-Mon-yyyy hh24:mi'), 102, '2004');

-- c3 (ship 103) - a couple more
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (25,  5, 3, TO_DATE('16-Jun-2025 08:35','dd-Mon-yyyy hh24:mi'), 103, '210');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (26,  4, 3, TO_DATE('16-Jun-2025 08:50','dd-Mon-yyyy hh24:mi'), 103, '211');

-- c4 (ship 101) - fill remaining
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (27,  3, 4, TO_DATE('07-Jul-2025 13:50','dd-Mon-yyyy hh24:mi'), 101, '1003');
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (28,  8, 4, TO_DATE('07-Jul-2025 13:55','dd-Mon-yyyy hh24:mi'), 101, '1004');

-- c7 (ship 103) - one more family member
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (29, 15, 7, TO_DATE('23-Oct-2025 14:45','dd-Mon-yyyy hh24:mi'), 103, '213');

-- c1 (ship 101) - extra traveller
INSERT INTO manifest (manifest_id, passenger_id, cruise_id, manifest_board_datetime, ship_code, cabin_no) VALUES (30, 13, 5, TO_DATE('08-Jul-2025 10:15','dd-Mon-yyyy hh24:mi'), 102, '2005');

COMMIT;