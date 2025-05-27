CREATE TABLE theatres (
  theatre_id   INT PRIMARY KEY,
  name         VARCHAR(100) NOT NULL,
  location     VARCHAR(255)
);

CREATE TABLE movies (
  movie_id   INT PRIMARY KEY,
  title      VARCHAR(200) NOT NULL,
  language   VARCHAR(100) NOT NULL
);

CREATE TABLE formats (
  format_id    INT PRIMARY KEY,
  format_name  VARCHAR(50) NOT NULL
);

CREATE TABLE shows (
  show_id      INT PRIMARY KEY,
  theatre_id   INT NOT NULL,
  movie_id     INT NOT NULL,
  format_id    INT NOT NULL,
  show_date    DATE NOT NULL,
  FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id),
  FOREIGN KEY (movie_id)    REFERENCES movies(movie_id),
  FOREIGN KEY (format_id)   REFERENCES formats(format_id)
);

CREATE TABLE show_times (
  show_time_id  INT PRIMARY KEY,
  show_id       INT NOT NULL,
  start_time    TIME NOT NULL,
  FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

-- Theatres
INSERT INTO theatres VALUES (1, 'PVR Cinemas', 'Mumbai');
INSERT INTO theatres VALUES (2, 'Cinepolis', 'Delhi');

-- Movies (with languages)
INSERT INTO movies VALUES (1, 'Inception', 'English');
INSERT INTO movies VALUES (2, 'Spirited Away', 'Japanese');
INSERT INTO movies VALUES (3, '3 Idiots', 'Hindi');

-- Formats
INSERT INTO formats VALUES (1, '2D');
INSERT INTO formats VALUES (2, '3D');

-- Shows (movie-format at theatre on a date)
INSERT INTO shows VALUES (1, 1, 1, 1, '2025-05-27');  -- PVR, Inception, English, 2D on 2025-05-27
INSERT INTO shows VALUES (2, 1, 2, 2, '2025-05-27');  -- PVR, Spirited Away, Japanese, 3D on 2025-05-27
INSERT INTO shows VALUES (3, 2, 3, 1, '2025-05-28');  -- Cinepolis, 3 Idiots, Hindi, 2D on 2025-05-28

-- Show times (multiple times per show)
INSERT INTO show_times VALUES (1, 1, '10:00');
INSERT INTO show_times VALUES (2, 1, '14:30');
INSERT INTO show_times VALUES (3, 1, '19:00');
INSERT INTO show_times VALUES (4, 2, '11:00');
INSERT INTO show_times VALUES (5, 2, '15:45');
INSERT INTO show_times VALUES (6, 3, '13:00');
INSERT INTO show_times VALUES (7, 3, '18:30');


-- To list all shows at a given theatre on a specific date, we join the tables and filter by theatre and date. 
-- For example, to find all shows at “PVR Cinemas” on 2025-05-27, we can use:

SELECT
  m.title        AS Movie,
  m.language     AS Language,
  f.format_name  AS Format,
  st.start_time  AS ShowTime
FROM shows s
JOIN theatres t ON s.theatre_id = t.theatre_id
JOIN movies m   ON s.movie_id = m.movie_id
JOIN formats f  ON s.format_id = f.format_id
JOIN show_times st ON st.show_id = s.show_id
WHERE t.name = 'PVR Cinemas'
  AND s.show_date = '2025-05-27'
ORDER BY st.start_time;
