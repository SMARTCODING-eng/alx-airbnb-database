SELECT 
    booking_id,
    check_in_date,
    check_out_date,
    total_price, AS booking_total_price,
    user_id,
    first_name, AS user_first_name,
    last_name,  AS user_last_name,
    title, AS property_title,
    price, AS propperty_base_price,
    payment_id,
    amount AS payment_amount,
    payment_date,
    status AS payment_status
FROM bookings AS b
INNER JOIN users AS u ON b.user_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON b.booking_id = pay.booking_id
ORDER BY b.check_in_date BESC;




EXPLAIN ANALYZE
SELECT 
    booking_id,
    check_in_date,
    check_out_date,
    total_price, AS booking_total_price,
    user_id,
    first_name, AS user_first_name,
    last_name,  AS user_last_name,
    title, AS property_title,
    price, AS propperty_base_price,
    payment_id,
    amount AS payment_amount,
    payment_date,
    status AS payment_status
FROM bookings AS b 
INNER JOIN users AS u ON b.user_id = u.user_id
ORDER BY 
    b.check_in_date DESC;
