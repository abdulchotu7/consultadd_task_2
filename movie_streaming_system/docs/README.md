# 🎬 Streaming Platform Database System

## 📖 Overview
This project implements a **PostgreSQL relational database** for a streaming platform. The system efficiently manages **users, profiles, movies, actors, billing, watch history, and support tickets** while maintaining strong data consistency and relationships.

---
## 📌 Features
- **User Authentication & Management**
- **Profile-based Viewing Preferences**
- **Movie & Actor Database**
- **Watch History Tracking**
- **Billing & Subscription Plans**
- **Support Ticket System**
- **Liked Movies & Movie Actor Relationships**

---
## 🏗️ Database Design
The system follows a **relational model** with multiple **entities and relationships** ensuring data integrity.

### **1️⃣ Entity-Relationship (ER) Diagram**
![ER Diagram](movie_streaming_system/docs/ER_Diagram.png)

- `User` has multiple `Profiles`
- `Movie` has many-to-many relationships with `Actor`
- `WatchHistory` tracks user activity
- `Billing` ensures subscription management
- `SupportTicket` allows issue tracking

### **2️⃣ Class Diagram**
![Class Diagram](https://your-image-link.com)

---
## 🗂️ Database Schema
The database consists of **multiple interrelated tables**:

### **1️⃣ Users & Profiles**
```sql
CREATE TABLE User (
    userId SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
```
```sql
CREATE TABLE Profile (
    profileId SERIAL PRIMARY KEY,
    userId INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(10) CHECK (type IN ('Child', 'Guest', 'Adult')) NOT NULL,
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);
```

### **2️⃣ Movies & Actors**
```sql
CREATE TABLE Movie (
    movieId SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    rating DECIMAL(3,1),
    year INT,
    boxOffice DECIMAL(12,2),
    liked BOOLEAN DEFAULT FALSE
);
```
```sql
CREATE TABLE Actor (
    actorId SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dateOfBirth DATE,
    bio TEXT
);
```

### **3️⃣ Many-to-Many Relationships**
```sql
CREATE TABLE MovieActor (
    movieId INT NOT NULL,
    actorId INT NOT NULL,
    PRIMARY KEY (movieId, actorId),
    FOREIGN KEY (movieId) REFERENCES Movie(movieId) ON DELETE CASCADE,
    FOREIGN KEY (actorId) REFERENCES Actor(actorId) ON DELETE CASCADE
);
```
```sql
CREATE TABLE LikedMovies (
    profileId INT NOT NULL,
    movieId INT NOT NULL,
    PRIMARY KEY (profileId, movieId),
    FOREIGN KEY (profileId) REFERENCES Profile(profileId) ON DELETE CASCADE,
    FOREIGN KEY (movieId) REFERENCES Movie(movieId) ON DELETE CASCADE
);
```

### **4️⃣ Watch History & Billing**
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
```
```sql
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

### **5️⃣ Support System & Admin Management**
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
```
```sql
CREATE TABLE Admin (
    adminId SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
```

---
## 📊 Query Examples
### 🔹 **1️⃣ Get All Profiles for a User**
```sql
SELECT * FROM Profile WHERE userId = 1;
```

### 🔹 **2️⃣ Retrieve Movies Liked by a Profile**
```sql
SELECT m.* FROM Movie m
JOIN LikedMovies lm ON m.movieId = lm.movieId
WHERE lm.profileId = 2;
```

### 🔹 **3️⃣ Fetch Watch History of a Profile**
```sql
SELECT w.*, m.title FROM WatchHistory w
JOIN Movie m ON w.movieId = m.movieId
WHERE w.profileId = 2;
```

---


