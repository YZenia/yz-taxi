-- Drop tables if they already exist (uncomment if you want to recreate)
-- DROP TABLE IF EXISTS bookings;
-- DROP TABLE IF EXISTS booking_users;

-- Create the booking_users table
CREATE TABLE IF NOT EXISTS booking_users (
    id VARCHAR(36) PRIMARY KEY,                         -- Unique ID for the user (UUID)
    full_name VARCHAR(150) UNIQUE NOT NULL,             -- User's full name (acting as login username)
    password_hash VARCHAR(255) NOT NULL,                -- User's password (stored securely)
    phone VARCHAR(50),                                  -- Default phone number
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP      -- Account creation timestamp
);

-- Create the bookings table for your taxi application
CREATE TABLE IF NOT EXISTS bookings (
    id VARCHAR(36) PRIMARY KEY,                         -- Unique ID for the booking (UUID)
    user_id VARCHAR(36) REFERENCES booking_users(id),   -- Optional reference to the registered user
    customer_name VARCHAR(100) NOT NULL,                -- Client's name
    customer_phone VARCHAR(50) NOT NULL,                -- Client's phone number
    booking_date DATE NOT NULL,                         -- Date of the ride (Format: 'YYYY-MM-DD')
    booking_time VARCHAR(5) NOT NULL,                   -- Time of the ride (Format: 'HH:MM')
    pickup_address TEXT NOT NULL,                       -- Departure address
    destination_address TEXT NOT NULL,                  -- Arrival address
    estimated_distance REAL NOT NULL,                   -- Calculated route distance in km
    price REAL NOT NULL,                                -- Initial locked price in PLN
    status VARCHAR(30) DEFAULT 'pending',               -- Current status: 'pending', 'confirmed', 'counter_offer', 'rejected'
    proposed_price REAL,                                -- Modified counter-offer price from driver in PLN
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP      -- Timestamp when booking request was made
);

-- Indexing for speed optimization when checking occupied slots by date
CREATE INDEX IF NOT EXISTS idx_bookings_date_status ON bookings(booking_date, status);
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);