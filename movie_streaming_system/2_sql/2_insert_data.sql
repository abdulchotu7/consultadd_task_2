-- ===============================
-- INSERT SAMPLE RECORDS
-- ===============================

-- Insert Users
INSERT INTO users (username, password, email) VALUES
('john_doe', 'hashed_password1', 'john@example.com'),
('jane_smith', 'hashed_password2', 'jane@example.com');

-- Insert Profiles
INSERT INTO Profile (userId, name, type) VALUES
(1, 'JohnProfile1', 'Adult'),
(1, 'JohnProfile2', 'Child'),
(2, 'JaneProfile', 'Guest');

-- Insert Billing Records
INSERT INTO Billing (userId, planType, privilegeType, startDate, endDate) VALUES
(1, 'Monthly', 'VIP', '2025-01-01', '2025-02-01'),
(2, 'Yearly', 'Basic', '2025-01-01', '2026-01-01');

-- Insert Movies
INSERT INTO Movie (title, rating, year, boxOffice, liked) VALUES
('Inception', 8.8, 2010, 829895144.00, TRUE),
('Titanic', 7.8, 1997, 2187463944.00, TRUE),
('Interstellar', 8.6, 2014, 677471339.00, TRUE);

-- Insert Genres
INSERT INTO Genre (name) VALUES
('Action'),
('Romance'),
('SciFi');

-- Insert Actors
INSERT INTO Actor (name, dateOfBirth, bio) VALUES
('Leonardo DiCaprio', '1974-11-11', 'American actor known for Titanic, Inception, and more.'),
('Matthew McConaughey', '1969-11-04', 'American actor known for Interstellar.');

-- Insert Watch History
INSERT INTO WatchHistory (profileId, movieId, startTime, currentTime, status) VALUES
(1, 1, '2025-03-25 12:00:00', '2025-03-25 12:30:00', 'Watching'),
(2, 2, '2025-03-24 15:00:00', '2025-03-24 16:50:00', 'Watched');

-- Insert Liked Movies
INSERT INTO LikedMovies (profileId, movieId) VALUES
(1, 1),
(2, 2);

-- Insert Support Tickets
INSERT INTO SupportTicket (userId, description, dateCreated, status) VALUES
(1, 'Issue with billing', '2025-03-20', 'Open');

-- Insert Admins
INSERT INTO Admin (username, password, email) VALUES
('admin1', 'secure_password', 'admin@example.com');

-- Insert Movie-Actor Relationships
INSERT INTO MovieActor (movieId, actorId) VALUES
(1, 1), -- Inception - Leonardo DiCaprio
(2, 1), -- Titanic - Leonardo DiCaprio
(3, 2); -- Interstellar - Matthew McConaughey