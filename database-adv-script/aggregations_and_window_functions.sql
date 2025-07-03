SELECT * FROM users AS u
COUNT(b.booking_id) FROM bookings
WHERE u.user_id = b.user_id
GROUP BY u.user_id, u.fist_name, u.last_name, u.email



SELECT
    property_id,
    property_title,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
    SELECT
        p.property_id,
        p.title AS property_title,
        COUNT(b.booking_id) AS total_bookings
    FROM
        properties AS p
    LEFT JOIN
        bookings AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id,
        p.title
) AS PropertyBookings
ORDER BY
    booking_rank ASC, property_title ASC;





    SELECT
    property_id,
    property_title,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC, property_id ASC) AS booking_row_num
FROM (
    SELECT
        p.property_id,
        p.title AS property_title,
        COUNT(b.booking_id) AS total_bookings
    FROM
        properties AS p
    LEFT JOIN
        bookings AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id,
        p.title
) AS PropertyBookings
ORDER BY
    booking_row_num ASC;