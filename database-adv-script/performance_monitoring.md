EXPLAIN ANALYZE
SELECT
    b.booking_id, b.check_in_date, b.check_out_date, p.title AS property_title, u.first_name AS user_first_name, u.last_name AS user_last_name
FROM
    bookings AS b
INNER JOIN users AS u ON b.user_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
WHERE
    u.user_id = 'a_specific_user_uuid'
    AND b.check_in_date >= '2025-01-01'
    AND b.check_in_date < '2025-04-01'
ORDER BY
    b.check_in_date DESC;