CREATE TABLE IF NOT EXISTS User(
    user_id INT PRIMARY KEY DEFAULT (UUID()),
    first_name VARCHAR(300) NOT NULL,
    last_name VARCHAR(300) NOT NULL,
    email VARCHAR(300) UNIQUE NOT NULL,
    password_hash VARCHAR(300) NOT NULL,
    phone_number VARCHAR NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Property(
    property_id INT PRIMARY KEY DEFAULT (UUID()),
    host_id INT NOT NULL,
    name VARCHAR(300) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(300) NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id)
);


CREATE TABLE IF NOT EXISTS Booking(
    booking_id INT PRIMARY KEY DEFAULT (UUID()),
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled')
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    CONSTRAINT checke_dates CHECK (end_date > start_date)
);

CREATE TABLE IF NOT EXISTS Payment(
    payment_id INT PRIMARY KEY DEFAULT (UUID()),
    booking_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Review(
    review_id IN PRIMARY KEY DEFAULT (UUID()),
    property_id  INT NOT NULL,
    user_id INT NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT CHECK (rating >= 1 AND rating <= 5)
);


CREATE IF NOT EXISTS Message(
    message_id INT PRIMARY KEY DEFAULT (UUID()),
    sender_id INT NOT NULL,
    recipient_id INT NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE
)




CREATE INDEX idx_user_email ON User(email);


CREATE INDEX idx_property_host_id ON Property(host_id);


CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);


CREATE INDEX idx_payment_booking_id ON Payment(booking_id);


CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);


CREATE INDEX idx_message_sender_id ON Message(sender_id);
CREATE INDEX idx_message_recipient_id ON Message(recipient_id);
