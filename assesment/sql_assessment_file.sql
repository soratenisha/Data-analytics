drop database movie_platform;
create database movie_platform;
USE movie_platform;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT
);

CREATE TABLE ratings (
    user_id INT,
    movie_id INT,
    rating INT,
    rating_date DATE
);

CREATE TABLE watch_history (
    user_id INT,
    movie_id INT,
    watch_date DATE
);

INSERT INTO users VALUES
(1,'Aarav','India'),
(2,'Emma','USA'),
(3,'Liam','Canada'),
(4,'Noah','UK'),
(5,'Olivia','Australia'),
(6,'Kabir','India'),
(7,'Sophia','USA'),
(8,'Mason','Canada'),
(9,'Isabella','UK'),
(10,'Lucas','Germany'),
(11,'Mia','France'),
(12,'Ethan','India'),
(13,'Amelia','USA'),
(14,'James','Canada'),
(15,'Harper','UK'),
(16,'Benjamin','India'),
(17,'Charlotte','Australia'),
(18,'Henry','USA'),
(19,'Evelyn','Germany'),
(20,'Alexander','France'),
(21,'Arjun','India'),
(22,'Daniel','USA'),
(23,'Michael','Canada'),
(24,'Saanvi','India'),
(25,'David','UK'),
(26,'Ava','Australia'),
(27,'Elijah','Germany'),
(28,'William','France'),
(29,'Ananya','India'),
(30,'Logan','USA');

INSERT INTO movies VALUES
(101,'The Last War','Action',2019),
(102,'Love Forever','Romance',2021),
(103,'Space Odyssey','Sci-Fi',2022),
(104,'Laugh Out Loud','Comedy',2023),
(105,'The Haunted','Horror',2020),
(106,'Fast Strike','Action',2022),
(107,'Deep Love','Romance',2023),
(108,'Galaxy War','Sci-Fi',2021),
(109,'Funny Days','Comedy',2018),
(110,'Night Fear','Horror',2024),
(111,'Hero Rise','Action',2023),
(112,'Heart Beat','Romance',2022),
(113,'Alien Planet','Sci-Fi',2024),
(114,'Comic World','Comedy',2021),
(115,'Dark House','Horror',2019),
(116,'Action King','Action',2024),
(117,'True Love','Romance',2018),
(118,'Star Future','Sci-Fi',2023),
(119,'Smile Please','Comedy',2022),
(120,'Ghost Town','Horror',2021),
(121,'Mission Fire','Action',2023),
(122,'Romantic Saga','Romance',2024),
(123,'Mars Trip','Sci-Fi',2022),
(124,'Crazy Comedy','Comedy',2020),
(125,'Scary Night','Horror',2023),
(126,'War Zone','Action',2021),
(127,'Love Story','Romance',2019),
(128,'Future World','Sci-Fi',2024),
(129,'Joke Master','Comedy',2023),
(130,'The Curse','Horror',2022),
(131,'Action Blast','Action',2024),
(132,'Pure Love','Romance',2023),
(133,'Sci Mystery','Sci-Fi',2021),
(134,'Comedy King','Comedy',2024),
(135,'Fear House','Horror',2023),
(136,'Speed Attack','Action',2022),
(137,'Forever Love','Romance',2021),
(138,'Space War','Sci-Fi',2023),
(139,'Fun Unlimited','Comedy',2024),
(140,'Haunted Night','Horror',2024);

INSERT INTO watch_history VALUES
(1,101,'2024-01-10'),
(1,101,'2024-01-15'), 
(2,102,'2024-02-11'),
(3,103,'2024-03-12'),
(4,104,'2024-01-20'),
(5,105,'2024-04-01'),
(6,106,'2024-02-10'),
(7,107,'2024-03-14'),
(8,108,'2024-02-18'),
(9,109,'2024-01-25'),
(10,110,'2024-04-05'),
(11,111,'2024-03-02'),
(12,112,'2024-03-03'),
(13,113,'2024-02-20'),
(14,114,'2024-01-18'),
(15,115,'2024-02-28'),
(16,116,'2024-03-10'),
(17,117,'2024-04-15'),
(18,118,'2024-02-08'),
(19,119,'2024-03-09'),
(20,120,'2024-01-05'),
(21,121,'2024-02-06'),
(22,122,'2024-03-07'),
(23,123,'2024-04-08'),
(24,124,'2024-01-09'),
(25,125,'2024-02-11'),
(26,126,'2024-03-12'),
(27,127,'2024-04-13'),
(28,128,'2024-02-14'),
(29,129,'2024-03-15'),
(30,130,'2024-04-16'),

-- Extra watches for multi-country condition
(2,101,'2024-04-01'),
(3,101,'2024-04-02'),
(4,101,'2024-04-03'),
(5,101,'2024-04-04'),
(6,101,'2024-04-05'),
(7,101,'2024-04-06');

INSERT INTO ratings VALUES
(1,101,5,'2024-01-11'),
(1,106,5,'2024-01-12'),
(1,111,5,'2024-01-13'),
(1,116,5,'2024-01-14'),
(1,121,5,'2024-01-15'),
(1,126,5,'2024-01-16'),
(1,131,5,'2024-01-17'),
(1,136,5,'2024-01-18'),

(2,102,4,'2024-02-12'),
(3,103,5,'2024-03-13'),
(4,104,3,'2024-01-21'),
(5,105,4,'2024-04-02'),
(6,106,5,'2024-02-11'),
(7,107,5,'2024-03-15'),
(8,108,4,'2024-02-19'),
(9,109,5,'2024-01-26'),
(10,110,3,'2024-04-06'),

-- Ratings without watching 
(11,132,4,'2024-04-10'),
(12,133,5,'2024-04-11'),
(13,134,5,'2024-04-12'),
(14,135,4,'2024-04-13');

-- 1.Top 3 most-watched genres per country.
SELECT u.country, m.genre, COUNT(*) AS total_watches
FROM watch_history w
JOIN users u ON w.user_id = u.user_id
JOIN movies m ON w.movie_id = m.movie_id
GROUP BY u.country, m.genre
ORDER BY total_watches DESC
LIMIT 3;

-- 2.Identify users who rated more than 20 movies.
SELECT user_id, COUNT(movie_id) AS total_ratings
FROM ratings
GROUP BY user_id;

-- 3. Find movies released after 2020 that have never been watched.
SELECT m.movie_id, m.title, m.release_year
FROM movies m
LEFT JOIN watch_history w 
ON m.movie_id = w.movie_id
WHERE m.release_year > 2020
AND w.movie_id IS NULL;

-- 4. Compute the average rating per genre.
SELECT m.genre, AVG(r.rating) AS avg_rating
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id
GROUP BY m.genre;

-- 5. List users who gave 5-star ratings to all movies in a genre.
SELECT r.user_id, m.genre
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id

-- 6. Identify movies watched by users from at least 5 different countries.
SELECT movie_id
FROM watch_history w
JOIN users u ON w.user_id = u.user_id
GROUP BY movie_id
HAVING COUNT(DISTINCT u.country) >= 5;

-- 7. Find the average number of movies watched per user per month.
SELECT 
COUNT(*) / 
(COUNT(DISTINCT user_id) * COUNT(DISTINCT MONTH(watch_date))) 
AS avg_movies_per_user_per_month
FROM watch_history;

-- 8. List users who watched the same movie more than once.
SELECT user_id, movie_id
FROM watch_history
GROUP BY user_id, movie_id
HAVING COUNT(*) > 1;

-- 9. Count how many movies have ratings but were never watched.
SELECT COUNT(DISTINCT r.movie_id) AS movies_count
FROM ratings r
LEFT JOIN watch_history w 
ON r.movie_id = w.movie_id
WHERE w.movie_id IS NULL;

-- 10. Identify the genre with the highest average 5-star rating count.
SELECT m.genre, COUNT(*) AS five_star_count
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id
WHERE r.rating = 5
GROUP BY m.genre
ORDER BY five_star_count DESC
LIMIT 5;
