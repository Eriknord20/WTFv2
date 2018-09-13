DROP TABLE IF EXISTS students CASCADE;

CREATE TABLE students(
        id SERIAL PRIMARY KEY,
        first_name  VARCHAR(255) NOT NULL,
        last_name VARCHAR(200) NOT NULL,
        username VARCHAR(50) NOT NULL,
        password CHAR(60) NOT NULL
);

INSERT INTO students(first_name, last_name, username, password) VALUES ('john','doe', 'joe', 'doe'), ('johnny','downy', 'joey', 'downy');
