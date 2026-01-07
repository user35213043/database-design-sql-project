/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T6-oo-json.sql

--Student ID: 35213043
--Student Name: George Gabriel Widjaja



-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SET PAGESIZE 100

SELECT
  JSON_OBJECT(
    '_id'               VALUE p.passenger_id,
    'passenger_name'    VALUE TRIM(p.passenger_fname || ' ' || p.passenger_lname),
    'passenger_dob'     VALUE TO_CHAR(p.passenger_dob, 'DD-Mon-YYYY'),
    'passenger_contact' VALUE NVL(p.passenger_contact, '-'),
    'guardian_name'     VALUE NVL((
                             SELECT TRIM(g.passenger_fname || ' ' || g.passenger_lname)
                             FROM   passenger g
                             WHERE  g.passenger_id = p.guardian_id
                           ), '-'),
    'address'           VALUE JSON_OBJECT(
                           'street'   VALUE a.address_street,
                           'town'     VALUE a.address_town,
                           'postcode' VALUE a.address_pcode,
                           'country'  VALUE co.country_name
                         ),
    'no_of_cruises'     VALUE (
                             SELECT COUNT(*)
                             FROM   manifest m
                             WHERE  m.passenger_id = p.passenger_id
                           ),
    'cruises'           VALUE (
      SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                 'cruise_id'      VALUE cr.cruise_id,
                 'cruise_name'    VALUE cr.cruise_name,
                 'board_datetime' VALUE NVL(TO_CHAR(m.manifest_board_datetime,'DD-Mon-YYYY HH24:MI'), '-'),
                 'ship_code'      VALUE m.ship_code,
                 'cabin_no'       VALUE m.cabin_no
               )
             )
      FROM   manifest m
             JOIN cruise cr ON cr.cruise_id = m.cruise_id
      WHERE  m.passenger_id = p.passenger_id
    )
  ) AS json_doc
FROM   passenger p
JOIN   address  a ON a.address_id     = p.address_id
JOIN   country  co ON co.country_code = a.country_code
ORDER  BY p.passenger_id;