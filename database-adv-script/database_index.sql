-- Indexes for 'users' table
CREATE UNIQUE INDEX idx_users_email ON users (email);
EXPLAIN ANALYZE
    SELECT user_id, first_name FROM users WHERE email = 'test.user@example.com';


-- Indexes for 'properties' table
CREATE INDEX idx_properties_owner_id ON properties (owner_id);
-- Compound index for common search filters. Order matters: high cardinality first.
CREATE INDEX idx_properties_location_type ON properties (city, state, country, type);
-- Index on price for sorting and range queries.
CREATE INDEX idx_properties_price ON properties (price);
EXPLAIN ANALYZE
    SELECT property_id, title, price FROM properties WHERE city = 'Lagos' AND type = 'apartment';


-- Indexes for 'bookings' table
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
-- Index on property_id for fast retrieval of all bookings for a specific property (crucial for availability).
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_bookings_dates ON bookings (check_in_date, check_out_date);
 EXPLAIN ANALYZE
        SELECT booking_id, check_in_date, first_name    
        FROM bookings AS b         
        JOIN users AS u ON b.user_id = u.user_id        
        WHERE u.user_id = 'some_user_uuid';
            


-- Indexes for 'reviews' table
CREATE INDEX idx_reviews_property_id ON reviews (property_id);
EXPLAIN ANALYZE
        SELECT property_id, price, title
        FROM properties AS p
        WHERE p.property_id IN(SELECT r.property_id FROM reviews AS r GROUP BY r.property_id HAVING AVG(r.rating)> 4.0);
-- Index on rating for filtering reviews by rating, or for aggregation/ranking.
CREATE INDEX idx_reviews_rating ON reviews (rating);
EXPLAIN ANALYZE
        SELECT property_id, property_title, total_bookings, RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank   
        FROM (
            SELECT
                property_id, title AS property_title, COUNT(b.booking_id) AS total_bookings
            FROM
                properties AS p
            LEFT JOIN
                bookings AS b ON p.property_id = b.property_id
            GROUP BY
                p.property_id, p.title
        ) AS PropertyBookings
        ORDER BY
            booking_rank ASC;
