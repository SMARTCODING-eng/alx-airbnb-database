# Entity-Relationship(ER) Daigram

Here is the ER Diagram that represent the database for the specification of Airbnb like system


**Entities and atributes:**

**User**(
    user_id INT PRIMARY KEY NOT NULL DEFAULT(UUID()),
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


**Property**(
    property_id INT PRIMARY KEY NOT NULL DEFAULT (UUID()),
    host_id INT NOT NULL,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP, DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATED CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id)
);

**Booking**(
    booking_id INT PRIMARY KEY NOT NULL DEFAULT (UUID()),
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

**Payment**(
    payment_id INT PRIMARY KEY DEFAULT (UUID()),
    booking_id INT NOT NULL,
    amount DECIMA NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe,) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);


**Review**(
    review_id INT PRIMARY KEY DEFAULT (UUID()),
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT CHECK:'rating >= 1 AND rating <= 5' NOT NULL,
    comment TEXT NOT NULL,
    ceated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);


**Message**(
    message_id INT PRIMARY KEY DEFAULT (UUID()),
    sender_id INT NOT NULL,
    recipient_id INT NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)


## Relationships:

A User(host) can have multiple propperties.(one-to-many).
A User(guest) can have multiple Bookings.(one-to-many).
A property can have multiple Bookings.(one-to-many).
A Booking has none payment.(one-to-one).
A User can write multiple Reviews.(one-to many).
A Property can have multiple Reviews.(one-to-many).
A User can send and receive multiple Messages.(one-to-many with two relationships to User).