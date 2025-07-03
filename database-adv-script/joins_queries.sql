-- This query will only return rows where there is a match in both the bookings table and the users table based on user_id. This means only bookings that are linked to an existing user will be retrieved.

SELECT * FROM bookings AS b
SELECT user_id FROM users as u
INNER JOIN u ON b.user_id = u.user_id;


SELECT property_id FROM properties as p
SELECT * FROM reviews AS r
LEFT JOIN p ON p.property_id = r.property_id
ORDER BY p.property_id ASC, r.review_date DESC;


SELECT * FROM users as u 
SELECT * FROM bookings AS b
FULL OUTER JOIN b ON u.user_id = b.user_id;




