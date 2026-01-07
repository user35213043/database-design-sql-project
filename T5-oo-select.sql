/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T5-oo-select.sql

--Student ID: 35213043
--Student Name: George Gabriel Widjaja


/* (a) */
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    co.country_code            AS COUNTRY_CODE,
    co.country_name            AS COUNTRY_NAME,
    COUNT(p.passenger_id)      AS NO_PASSENGERS,
    ROUND(
        (COUNT(p.passenger_id) /
         (SELECT COUNT(*) FROM passenger) * 100),
        1
    ) || '%'                   AS PERCENT_PASSENGERS
FROM passenger p
JOIN address a
    ON p.address_id = a.address_id
JOIN country co
    ON a.country_code = co.country_code
GROUP BY co.country_code, co.country_name
HAVING COUNT(p.passenger_id) = (
    SELECT MAX(COUNT(*))
    FROM passenger p2
    JOIN address a2 ON p2.address_id = a2.address_id
    GROUP BY a2.country_code
)
ORDER BY co.country_code;


/* (b) */
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
  t.cruise_id            AS "CRUISE_ID",
  t.cruise_name          AS "CRUISE_NAME",
  t.departure_date_time  AS "DEPARTURE_DATE_TIME",
  t.ship_details         AS "SHIP_DETAILS",
  t.category             AS "CATEGORY",
  t.passenger_count      AS "PASSENGER_COUNT"
FROM (
  -- Per-gender rows
  SELECT
    c.cruise_id,
    c.cruise_name,
    TO_CHAR(c.cruise_depart_dt, 'Dy DD Month YYYY HH:MI AM') AS departure_date_time,
    (TO_CHAR(c.ship_code) || ' ' || s.ship_name)              AS ship_details,
    CASE
      WHEN p.passenger_gender = 'F' THEN 'Female'
      WHEN p.passenger_gender = 'M' THEN 'Male'
      ELSE 'Other'
    END AS category,
    COUNT(*) AS passenger_count
  FROM manifest m
  JOIN passenger p ON p.passenger_id = m.passenger_id
  JOIN cruise    c ON c.cruise_id    = m.cruise_id
  JOIN ship      s ON s.ship_code    = c.ship_code
  GROUP BY
    c.cruise_id, c.cruise_name, c.cruise_depart_dt, s.ship_name, c.ship_code,
    CASE
      WHEN p.passenger_gender = 'F' THEN 'Female'
      WHEN p.passenger_gender = 'M' THEN 'Male'
      ELSE 'Other'
    END

  UNION ALL

  -- Total row per cruise
  SELECT
    c.cruise_id,
    c.cruise_name,
    TO_CHAR(c.cruise_depart_dt, 'Dy DD Month YYYY HH:MI AM') AS departure_date_time,
    (TO_CHAR(c.ship_code) || ' ' || s.ship_name)              AS ship_details,
    'Total Count'                                             AS category,
    COUNT(*)                                                  AS passenger_count
  FROM manifest m
  JOIN cruise c ON c.cruise_id = m.cruise_id
  JOIN ship   s ON s.ship_code = c.ship_code
  GROUP BY c.cruise_id, c.cruise_name, c.cruise_depart_dt, s.ship_name, c.ship_code
) t
ORDER BY
  t.cruise_id,
  CASE t.category
    WHEN 'Female' THEN 1
    WHEN 'Male' THEN 2
    WHEN 'Other' THEN 3
    WHEN 'Total Count' THEN 4
  END;


/* (c) */
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
WITH per_cruise AS (
  SELECT
    m.cruise_id,
    COUNT(*)                                                     AS total_passengers,
    COUNT(CASE WHEN p.guardian_id IS NOT NULL THEN 1 END)       AS minors,
    AVG( TRUNC( months_between(TRUNC(SYSDATE), p.passenger_dob) / 12, 1) )
                                                                 AS avg_age_years,
    COUNT(DISTINCT a.country_code)                               AS countries
  FROM manifest m
  JOIN passenger p ON p.passenger_id = m.passenger_id
  JOIN address   a ON a.address_id   = p.address_id
  GROUP BY m.cruise_id
),
avg_all AS (
  SELECT AVG(total_passengers) AS avg_cnt
  FROM per_cruise
)
SELECT
  (c.cruise_id || ' : ' || c.cruise_name)                           AS "CRUISE",
  ( TRUNC(c.cruise_arrive_dt - c.cruise_depart_dt)
    || ' days '
    || TRUNC(MOD( (c.cruise_arrive_dt - c.cruise_depart_dt) * 24, 24))
    || ' hours' )                                                    AS "CRUISE_DURATION",
  pc.total_passengers                                                AS "TOTAL_PASSENGERS",
  pc.minors                                                          AS "MINORS",
  TO_CHAR(ROUND(pc.avg_age_years, 1), 'FM9990.0')                    AS "AVG_AGE",
  pc.countries                                                       AS "COUNTRIES",
  TO_CHAR(c.cruise_cost_pp, 'FM$9,999,990.00')                       AS "CRUISECOST",
  s.ship_name                                                        AS "SHIP_NAME",
  o.oper_comp_name                                                   AS "OPER_COMP_NAME",
  co.country_name                                                    AS "SHIP_COUNTRY"
FROM per_cruise pc
JOIN avg_all aa   ON 1 = 1
JOIN cruise  c    ON c.cruise_id = pc.cruise_id
JOIN ship    s    ON s.ship_code = c.ship_code
JOIN operator o   ON o.oper_id   = s.oper_id
JOIN country  co  ON co.country_code = s.country_code
WHERE pc.total_passengers > aa.avg_cnt
ORDER BY pc.total_passengers DESC, c.cruise_id;

