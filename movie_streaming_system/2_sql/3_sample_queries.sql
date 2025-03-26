-- ===============================
-- SAMPLE QUERIES FOR VALIDATION
-- ===============================

-- 1. Retrieve All Users
SELECT * FROM Users;

-- 2. Retrieve All Movies Sorted by Rating (Descending)
SELECT * FROM Movie ORDER BY rating DESC;

-- 3. Find Movies Released After 2010
SELECT * FROM Movie WHERE year > 2010;

-- 4. Find All Users Who Have Subscribed to a VIP Plan
SELECT U.username, B.planType, B.privilegeType 
FROM users U
JOIN Billing B ON U.userId = B.userId
WHERE B.privilegeType = 'VIP';

-- 5. Get Profiles Associated with a User
SELECT P.profileId, P.name, P.type, U.username 
FROM Profile P
JOIN users U ON P.userId = U.userId
WHERE U.username = 'john_doe';

-- 6. Retrieve Movies Watched by a Profile
SELECT M.title, WH.status, WH.currentTime 
FROM WatchHistory WH
JOIN Movie M ON WH.movieId = M.movieId
WHERE WH.profileId = 1;

-- 7. Find All Liked Movies for a Specific Profile
SELECT M.title 
FROM LikedMovies LM
JOIN Movie M ON LM.movieId = M.movieId
WHERE LM.profileId = 1;

-- 8. Find Movies That a Specific Actor Starred In
SELECT M.title, A.name 
FROM MovieActor MA
JOIN Movie M ON MA.movieId = M.movieId
JOIN Actor A ON MA.actorId = A.actorId
WHERE A.name = 'Leonardo DiCaprio';

-- 9. Retrieve Open Support Tickets
SELECT * FROM SupportTicket WHERE status = 'Open';

-- 10. Find All Admins
SELECT username, email FROM Admin;

-- 11. Find the Most Recent Movie Watched by a Profile
SELECT M.title, WH.startTime 
FROM WatchHistory WH
JOIN Movie M ON WH.movieId = M.movieId
WHERE WH.profileId = 1
ORDER BY WH.startTime DESC
LIMIT 1;

-- 12. Count How Many Movies Each User Liked
SELECT P.userId, U.username, COUNT(LM.movieId) AS liked_movies_count
FROM LikedMovies LM
JOIN Profile P ON LM.profileId = P.profileId
JOIN users U ON P.userId = U.userId
GROUP BY P.userId, U.username;