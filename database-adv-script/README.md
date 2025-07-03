# SQL queries for the specified join types

Let's assume the following simplified table structures for the purpose of these queries:

**users table:**

user_id (Primary Key)

first_name

last_name

email

**properties table:**

property_id (Primary Key)

title

owner_id (Foreign Key referencing users.user_id)

price

**bookings table:**

booking_id (Primary Key)

user_id (Foreign Key referencing users.user_id)

property_id (Foreign Key referencing properties.property_id)

check_in_date

check_out_date

total_price

**reviews table:**

review_id (Primary Key)

property_id (Foreign Key referencing properties.property_id)

user_id (Foreign Key referencing users.user_id)

rating

comment

review_date