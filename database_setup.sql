-- Drop table if it already exists (uncomment if you want to recreate)
-- DROP TABLE IF EXISTS bookings;

-- Create the bookings table for your taxi application
CREATE TABLE bookings (
    id VARCHAR(36) PRIMARY KEY,                         -- Unique ID for the booking (UUID)
    customer_name VARCHAR(100) NOT NULL,                -- Client's name
    customer_phone VARCHAR(50) NOT NULL,               -- Client's phone number
    customer_telegram VARCHAR(100),                     -- Client's Telegram username (without @)
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
CREATE INDEX idx_bookings_date_status ON bookings(booking_date, status);