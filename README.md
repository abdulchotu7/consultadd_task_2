# 🎮 Movie Streaming Platform

## 📚 Overview
This project implements a **PostgreSQL relational database** for a streaming platform, managing **users, profiles, movies, actors, billing, watch history, and support tickets** while ensuring data consistency and relationships.

---
## 🔗 Features
- **User & Profile Management**
- **Movie & Actor Database**
- **Watch History Tracking**
- **Billing & Subscription System**
- **Support Ticketing System**
- **Liked Movies & Actor-Movie Relationships**

---
## 🛠️ Database Design
The system follows a **relational model** with multiple interrelated tables ensuring data integrity.

### ✅ **ER Diagram**
![ER Diagram](ER_Diagram.jpg)

### ✅ **Class Diagram**
![Class Diagram](Class_Diagram.jpg)

---
## 📂 Database Schema
### **1. Users & Profiles**
```sql
CREATE TABLE User (
    userId SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Profile (
    profileId SERIAL PRIMARY KEY,
    userId INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(10) CHECK (type IN ('Child', 'Guest', 'Adult')) NOT NULL,
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);
```

### **2. Movies & Actors**
```sql
CREATE TABLE Movie (
    movieId SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    rating DECIMAL(3,1),
    year INT,
    boxOffice DECIMAL(12,2),
    liked BOOLEAN DEFAULT FALSE
);

CREATE TABLE Actor (
    actorId SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dateOfBirth DATE,
    bio TEXT
);
```

### **3. Many-to-Many Relationships**
```sql
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
```

### **4. Watch History & Billing**
```sql
CREATE TABLE WatchHistory (
    watchId SERIAL PRIMARY KEY,
    profileId INT NOT NULL,
    movieId INT NOT NULL,
    startTime TIMESTAMP NOT NULL,
    currentTime TIMESTAMP NOT NULL,
    status VARCHAR(10) CHECK (status IN ('Watching', 'Watched')) NOT NULL,
    FOREIGN KEY (profileId) REFERENCES Profile(profileId) ON DELETE CASCADE,
    FOREIGN KEY (movieId) REFERENCES Movie(movieId)
);

CREATE TABLE Billing (
    billingId SERIAL PRIMARY KEY,
    userId INT UNIQUE NOT NULL,
    planType VARCHAR(10) CHECK (planType IN ('Monthly', 'Yearly')) NOT NULL,
    privilegeType VARCHAR(10) CHECK (privilegeType IN ('VVIP', 'VIP', 'Basic')) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);
```

### **5. Support System & Admin Management**
```sql
CREATE TABLE SupportTicket (
    ticketId SERIAL PRIMARY KEY,
    userId INT NOT NULL,
    description TEXT NOT NULL,
    dateCreated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(10) CHECK (status IN ('Open', 'Closed')) DEFAULT 'Open',
    resolution TEXT,
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);

CREATE TABLE Admin (
    adminId SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
```

---
## 📈 Sample Queries

### ✨ **1. Insert Sample Data**
```sql
INSERT INTO User (username, password, email) VALUES ('john_doe', 'hashed_pass', 'john@example.com');
INSERT INTO Profile (userId, name, type) VALUES (1, 'John Kid', 'Child');
INSERT INTO Movie (title, rating, year, boxOffice, liked) VALUES ('Inception', 8.8, 2010, 829895144, TRUE);
INSERT INTO Actor (name, dateOfBirth, bio) VALUES ('Leonardo DiCaprio', '1974-11-11', 'Hollywood actor');
INSERT INTO MovieActor (movieId, actorId) VALUES (1, 1);
INSERT INTO LikedMovies (profileId, movieId) VALUES (1, 1);
```

### ✨ **2. Fetch All Movies**
```sql
SELECT * FROM Movie;
```

### ✨ **3. Get Liked Movies of a Profile**
```sql
SELECT m.title FROM Movie m
JOIN LikedMovies lm ON m.movieId = lm.movieId
WHERE lm.profileId = 1;
```

### ✨ **4. Watch History of a Profile**
```sql
SELECT w.*, m.title FROM WatchHistory w
JOIN Movie m ON w.movieId = m.movieId
WHERE w.profileId = 1;
```

### ✨ **5. Retrieve All Users with Their Profiles**
```sql
SELECT u.username, p.name, p.type FROM User u
JOIN Profile p ON u.userId = p.userId;
```

### ✨ **6. Sort Movies by Rating**
```sql
SELECT * FROM Movie ORDER BY rating DESC;
```

### ✨ **7. Filter Movies Released After 2000**
```sql
SELECT * FROM Movie WHERE year > 2000;
```

---
## 👤 Author
**Abdul Rahim**
March 2025

