--
INSERT INTO "user" (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 'hash_johndoe_password', '+1234567890', 'guest'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 'hash_janesmith_password', '+1987654321', 'guest'),
(3, 'Adewale', 'Akinnuoye', 'adewale.a@example.com', 'hash_adewale_password', '+2348012345678', 'host'),
(4, 'Chinelo', 'Okoro', 'chinelo.o@example.com', 'hash_chinelo_password', '+2349087654321', 'host'),
(5, 'Admin', 'User', 'admin@airbnb.clone', 'hash_admin_password', null, 'admin');



INSERT INTO "property" (property_id, host_id, name, description, location, price_per_night) VALUES
('001', '1', 'Serene Lakeside Villa', 'A beautiful villa with a stunning view of Jabi Lake. Perfect for a peaceful getaway.', 'Jabi, Abuja, Nigeria', 75000.00),
('002', '2', 'Luxury Apartment in Maitama', 'A modern and luxurious 2-bedroom apartment in the heart of Maitama, with 24/7 power.', 'Maitama, Abuja, Nigeria', 120000.00),
('003', '3', 'Cozy Beachfront Condo', 'A lovely condo right on the beach. Enjoy the ocean breeze and beautiful sunsets.', 'Miami, Florida, USA', 250.00),
('004', '4', 'Chic Parisian Flat', 'Experience Paris from this stylish and centrally located flat near the Eiffel Tower.', 'Paris, France', 180.00);



INSERT INTO "booking" (booking_id, property_id, user_id, start_date, end_date, status) VALUES
('book-010', '001', '1', '2025-05-10', '2025-05-15', 'confirmed'),
('book-011', '002', '2', '2025-07-20', '2025-07-25', 'confirmed'),
('book-012', '003', '3', '2025-08-01', '2025-08-05', 'canceled'),
('book-013', '004', '4', '2025-09-10', '2025-09-15', 'pending');



INSERT INTO "payment" (payment_id, booking_id, amount, payment_method) VALUES
('pay-0011', 'book-011', 600000.00, 'stripe'),
('pay-0012', 'book-011', 375000.00, 'credit_card');



INSERT INTO "review" (review_id, property_id, user_id, rating, comment) VALUES
('rev-121', '001', '1', 5, 'Absolutely fantastic apartment! It was clean, modern, and the host, Chinelo, was incredibly helpful. The 24/7 power is a huge plus in Abuja. Highly recommend!');



INSERT INTO "message" (message_id, sender_id, recipient_id, message_body) VALUES
('messa-0131', '1', '3', 'Hello Adewale, I am very excited about my upcoming stay at your villa. Is it possible to arrange for an early check-in around noon?'),
('messa-0132', '3', '2', 'Hi Jane, thank you for booking with us! A noon check-in should be fine as we don''t have guests checking out that morning. We look forward to hosting you!');