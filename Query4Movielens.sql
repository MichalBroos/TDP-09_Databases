USE movielens;
SELECT COUNT(id) FROM movies;

#1.	List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, release_date FROM movies WHERE release_date >= '1983-01-01' and release_date < '1993-01-01' ORDER BY release_date DESC;

#2.	Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT title, avg_rating FROM movies m JOIN (SELECT movie_id, AVG(rating) AS avg_rating FROM ratings GROUP BY movie_id) averages ON m.id = averages.movie_id WHERE avg_rating <= 1;

#3.	List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT * FROM movies;
SELECT * FROM genres_movies;
SELECT * FROM genres;
SELECT * FROM ratings;
SELECT * FROM users;
# all movie ids which are scifi + their ratings
SELECT * FROM users u JOIN (SELECT r.user_id, r.movie_id, r.rating FROM ratings r JOIN (SELECT movie_id FROM genres_movies gm JOIN genres g ON gm.genre_id = g.id WHERE `name` = 'Sci-Fi') scifi ON r.movie_id = scifi.movie_id WHERE rating = 5) AS users_scifi_5star ON u.id = users_scifi_5star.user_id;-- WHERE users_scifi_5star.age = 24 & users_scifi_5star.gender = 'M';
SELECT * FROM (SELECT movie_id, COUNT(movie_id) AS no_of_5star_ratings/*age, gender, movie_id, rating*/ FROM users u JOIN (SELECT r.user_id, r.movie_id, r.rating FROM ratings r JOIN (SELECT movie_id FROM genres_movies gm JOIN genres g ON gm.genre_id = g.id WHERE `name` = 'Sci-Fi') scifi ON r.movie_id = scifi.movie_id WHERE rating = 5) AS users_scifi_5star ON u.id = users_scifi_5star.user_id WHERE u.age = 24 AND u.gender = 'M' GROUP BY movie_id) AS final_wo_names WHERE no_of_5star_ratings = 1;
# includes non-students
SELECT movie_id, title FROM (SELECT movie_id, COUNT(movie_id) AS no_of_5star_ratings FROM users u JOIN (SELECT r.user_id, r.movie_id, r.rating FROM ratings r JOIN (SELECT movie_id FROM genres_movies gm JOIN genres g ON gm.genre_id = g.id WHERE `name` = 'Sci-Fi') scifi ON r.movie_id = scifi.movie_id WHERE rating = 5) AS users_scifi_5star ON u.id = users_scifi_5star.user_id WHERE u.age = 24 AND u.gender = 'M' GROUP BY movie_id) AS final_wo_names JOIN movies ON final_wo_names.movie_id = movies.id WHERE no_of_5star_ratings = 1;
# attempt 2 - different interpretation of unique
SELECT
    movie_id, title
FROM
    (SELECT 
        movie_id, COUNT(movie_id) AS no_of_5star_ratings
    FROM
        users u
    JOIN (SELECT 
        r.user_id, r.movie_id, r.rating
    FROM
        ratings r
    JOIN (SELECT 
        movie_id
    FROM
        genres_movies gm
    JOIN genres g ON gm.genre_id = g.id
    WHERE
        `name` = 'Sci-Fi') scifi ON r.movie_id = scifi.movie_id
    WHERE
        rating = 5) AS users_scifi_5star ON u.id = users_scifi_5star.user_id
    WHERE
        u.age = 24 AND u.gender = 'M' AND u.occupation_id = (SELECT occupations.id FROM occupations WHERE `name` = 'Student') # no need to do another join because Student will only ever link to 1 id
    GROUP BY movie_id) AS final_wo_names
        JOIN
    movies ON final_wo_names.movie_id = movies.id;

# Aswene
SELECT DISTINCT m.title
FROM users u
JOIN occupations o ON u.occupation_id = o.id
JOIN ratings r ON u.id = r.user_id
JOIN movies m ON r.movie_id = m.id
JOIN genres_movies gm ON gm.movie_id = m.id
JOIN genres g ON g.id = gm.genre_id
WHERE gender = 'M' AND g.`name` = 'Sci-Fi' AND o.`name` = 'Student' AND rating = 5 AND age = 24;

#4.	List the unique titles of each of the movies released on the most popular release day.


#5.	Find the total number of movies in each genre; list the results in ascending numeric order.



