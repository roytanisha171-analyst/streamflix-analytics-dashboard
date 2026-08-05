CREATE DATABASE Streamflix;
USE Streamflix;
CREATE TABLE Subscription_plans (
plan_id INT PRIMARY KEY,
plan_name VARCHAR (50) NOT NULL,
monthly_fee DECIMAL (8,2) NOT NULL,
plan_duration_days INT NOT NULL );

CREATE TABLE Genres (
genre_id INT PRIMARY KEY,
genre_name VARCHAR (50) NOT NULL UNIQUE );

CREATE TABLE Users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR (50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
gender VARCHAR (50) NOT NULL,
date_of_birth DATE NOT NULL,
city VARCHAR (50) NOT NULL,
state VARCHAR (50) NOT NULL,
country VARCHAR (50) NOT NULL,
email VARCHAR (50) NOT NULL UNIQUE,
join_date DATE NOT NUll,
plan_id INT  NOT NULL,
FOREIGN KEY (plan_id)
REFERENCES 
Subscription_plans(plan_id) );

CREATE TABLE Shows (
show_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR (50) NOT NULL,
genre_id INT NOT NULL,
show_language VARCHAR (50) NOT NULL,
release_year YEAR NOT NULL,
content_type
ENUM ('Movie', 'Series') NOT NULL,
age_rating VARCHAR (50),
FOREIGN KEY (genre_id)
REFERENCES Genres (genre_id) 
);

CREATE TABLE Episodes (
episode_id INT AUTO_INCREMENT PRIMARY KEY,
show_id INT NOT NULL,
season_number INT NOT NULL,
episode_number INT NOT NULL,
episode_title VARCHAR (50) NOT NULL,
duuration_minutes INT NOT NULL,
FOREIGN KEY (show_id)
REFERENCES Shows (show_id)
ON DELETE CASCADE 
);

CREATE TABLE Payments (
payment_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
plan_id INT NOT NULL,
amount DECIMAL (8,2) NOT NULL,
payment_date DATE NOT NULL,
payment_method 
ENUM ('UPI', 'CREDIT CARD', 'DEBIT CARD', 'NETBANKING') NOT NULL,
payment_status 
ENUM ('SUCCESS', 'FAILURE', 'PENDING') NOT NULL,
FOREIGN KEY (user_id)
REFERENCES Users(user_id),

FOREIGN KEY (plan_id)
REFERENCES Subscription_plans(plan_id)
);

CREATE TABLE Viewing_History (
viewing_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
episode_id INT NOT NULL,
watch_date DATE NOT NULL,
watch_start_time TIME NOT NULL,
watch_duration_minutes INT NOT NULL,
device 
ENUM( 'MOBILE', 'LAPTOP', 'TELEVISION', 'TABLET') NOT NULL,
completion_percentage DECIMAL (5,2) NOT NULL,

FOREIGN KEY (user_id)
REFERENCES Users (user_id),

FOREIGN KEY (episode_id)
REFERENCES Episodes (episode_id)
ON DELETE CASCADE
);

CREATE TABLE Ratings (
rating_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
show_id INT  NOT NULL,
rating INT NOT NULL CHECK (RATING BETWEEN 1 AND 2),
review TEXT,
rating_date DATE NOT NULL,

FOREIGN KEY (user_id)
REFERENCES Users (user_id),

FOREIGN KEY (show_id)
REFERENCES Shows (show_id)
);


INSERT INTO Subscription_plans
(plan_id, plan_name, monthly_fee, plan_duration_days)
VALUES
(1,'Basic', '199', '30'),
(2,'Standard', '299', '30'),
(3,'Premium', '399', '30');


INSERT INTO Genres 
(genre_id, genre_name)
VALUES
(1,'Action'),
(2,'Comedy'),
(3,'Crime'),
(4,'Drama'),
(5,'Thriller'),
(6,'Horror'),
(7,'Romance'),
(8,'Sci-Fi'),
(9,'Fantasy'),
(10,'Animation'),
(11,'Documentary'),
(12,'Mystery');
