CREATE TABLE Users (
    userId SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Step 1: Create ENUM type for 'type' column
CREATE TYPE profile_type AS ENUM ('Child', 'Guest', 'Adult');

-- Step 2: Create the Profile table
CREATE TABLE Profile (
    profileId SERIAL PRIMARY KEY,
    userId INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    type profile_type NOT NULL,  -- Use the ENUM type
    FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE
);

-- Step 1: Create ENUM types for planType and privilegeType
CREATE TYPE plan_type AS ENUM ('Monthly', 'Yearly');
CREATE TYPE privilege_type AS ENUM ('VVIP', 'VIP', 'Basic');

-- Step 2: Create the Billing table
CREATE TABLE Billing (
    billingId SERIAL PRIMARY KEY,
    userId INT UNIQUE NOT NULL,
    planType plan_type NOT NULL,
    privilegeType privilege_type NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE
);

CREATE TABLE Movie (
    movieId SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    rating NUMERIC(3,1),  -- PostgreSQL uses NUMERIC instead of DECIMAL
    year INT,
    boxOffice NUMERIC(12,2),
    liked BOOLEAN DEFAULT FALSE
);

-- Step 1: Create ENUM type for genre name
CREATE TYPE genre_type AS ENUM ('Action', 'Romance', 'SciFi');

-- Step 2: Create the Genre table
CREATE TABLE Genre (
    genreId SERIAL PRIMARY KEY,
    name genre_type UNIQUE NOT NULL
);

CREATE TABLE Actor (
    actorId SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dateOfBirth DATE,
    bio TEXT
);

-- Step 1: Create ENUM type for status
CREATE TYPE watch_status AS ENUM ('Watching', 'Watched');

-- Step 2: Create the WatchHistory table
CREATE TABLE WatchHistory (
    watchId SERIAL PRIMARY KEY,
    profileId INT NOT NULL,
    movieId INT NOT NULL,
    startTime TIMESTAMP NOT NULL,
    currentTime TIMESTAMP NOT NULL,
    status watch_status NOT NULL,
    FOREIGN KEY (profileId) REFERENCES Profile(profileId) ON DELETE CASCADE,
    FOREIGN KEY (movieId) REFERENCES Movie(movieId)
);
-- Step 1: Create ENUM type for ticket status
CREATE TYPE ticket_status AS ENUM ('Open', 'Closed');

-- Step 2: Create the SupportTicket table
CREATE TABLE SupportTicket (
    ticketId SERIAL PRIMARY KEY,
    userId INT NOT NULL,
    description TEXT NOT NULL,
    dateCreated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ticket_status DEFAULT 'Open',
    resolution TEXT,
    FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE
);


CREATE TABLE Admin (
    adminId SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE MovieActor (
    movieId INT NOT NULL,
    actorId INT NOT NULL,
    PRIMARY KEY (movieId, actorId),
    FOREIGN KEY (movieId) REFERENCES Movie(movieId) ON DELETE CASCADE,
    FOREIGN KEY (actorId) REFERENCES Actor(actorId) ON DELETE CASCADE
);
CREATE TABLE LikedMovies (
    profileId INT NOT NULL,
    movieId INT NOT NULL,
    PRIMARY KEY (profileId, movieId),
    FOREIGN KEY (profileId) REFERENCES Profile(profileId) ON DELETE CASCADE,
    FOREIGN KEY (movieId) REFERENCES Movie(movieId) ON DELETE CASCADE
);
