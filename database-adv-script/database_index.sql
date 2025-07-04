-- Indexes for 'users' table
CREATE UNIQUE INDEX idx_users_email ON users (email);


-- Indexes for 'properties' table
CREATE INDEX idx_properties_owner_id ON properties (owner_id);

-- Compound index for common search filters. Order matters: high cardinality first.
CREATE INDEX idx_properties_location_type ON properties (city, state, country, type);


-- Index on price for sorting and range queries.
CREATE INDEX idx_properties_price ON properties (price);


-- Indexes for 'bookings' table
CR- EATE INDEX idx_bookings_user_id ON bookings (user_id);

-- Index on property_id for fast retrieval of all bookings for a specific property (crucial for availability).
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_bookings_dates ON bookings (check_in_date, check_out_date);


-- Indexes for 'reviews' table
CREATE INDEX idx_reviews_property_id ON reviews (property_id);
-- Index on rating for filtering reviews by rating, or for aggregation/ranking.
CREATE INDEX idx_reviews_rating ON reviews (rating);
