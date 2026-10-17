USE school;

SHOW TABLES;

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE
);

DESCRIBE enrollments;

ALTER TABLE enrollments
ADD CONSTRAINT fk_student
FOREIGN KEY (student_id)
REFERENCES students(id);

ALTER TABLE enrollments
ADD CONSTRAINT fk_course
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

DESCRIBE enrollments;

SELECT * FROM students;

SELECT * FROM courses;

INSERT INTO enrollments
(student_id, course_id, enrollment_date)
VALUES
(1, 1, '2026-10-07'),
(1, 2, '2026-10-07'),
(2, 1, '2026-10-07'),
(4, 3, '2026-10-07');

SELECT * FROM enrollments;

SELECT
    students.name,
    courses.course_name,
    enrollments.enrollment_date
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id;

SELECT
    students.name,
    courses.course_name
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
WHERE courses.course_name = 'CC6';

SELECT
    students.name,
    courses.course_name
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
ORDER BY students.name ASC;

SELECT
    students.name,
    courses.course_name
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
ORDER BY students.name DESC;

SELECT COUNT(*) AS total_students
FROM students;

SELECT COUNT(*) AS total_enrollments
FROM enrollments;

SELECT
    courses.course_name,
    COUNT(enrollments.student_id) AS number_of_students
FROM courses
LEFT JOIN enrollments
    ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name;

SELECT
    courses.course_name,
    COUNT(enrollments.student_id) AS number_of_students
FROM courses
LEFT JOIN enrollments
    ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name
ORDER BY number_of_students DESC;

SELECT
    students.id AS student_id,
    students.name AS student_name,
    courses.course_name,
    enrollments.enrollment_date
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
ORDER BY students.name;

INSERT INTO students (id, name, course, year_level) VALUES
(8, 'Andres Bonifacio', 'BSIT', 1),
(9, 'Juan Luna', 'BSCS', 2),
(10, 'Jose Rizal', 'BSIT', 3),
(11, 'Andres Marco', 'BSIT', 1),
(12, 'Juan Laluna', 'BSCS', 2),
(13, 'Jose Marichan', 'BSIT', 3);

INSERT INTO courses (course_id, course_name, description, units) VALUES
(4, 'CC16', 'IT Techno', 2),
(5, 'CC12', 'Statistics', 3),
(6, 'CC21', 'Intro to ERP', 3),
(7, 'CC9', 'Algorithms', 2),
(8, 'CC15', 'Multimedia', 3),
(9, 'CC22', 'Systems', 3);

INSERT INTO enrollments
(student_id, course_id, enrollment_date)
VALUES
(8, 1, '2026-10-07'),
(1, 2, '2026-10-07'),
(9, 1, '2026-10-07'),
(10, 3, '2026-10-07'),
(11, 4, '2026-10-07'),
(12, 8, '2026-10-07'),
(13, 9, '2026-10-07');

SELECT * FROM students;

SELECT * FROM courses;

SELECT * FROM enrollments;

SELECT students.id, students.name, courses.course_name
FROM enrollments
JOIN students ON enrollments.student_id = students.id
JOIN courses ON enrollments.course_id = courses.course_id
WHERE courses.course_name = 'CC6';

SELECT students.name, courses.course_name, courses.description
FROM enrollments
JOIN students ON enrollments.student_id = students.id
JOIN courses ON enrollments.course_id = courses.course_id
WHERE students.name = 'Juan Dela Cruz';

SELECT courses.course_name, COUNT(enrollments.student_id) AS number_of_students
FROM courses
LEFT JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name;

SELECT courses.course_name, COUNT(enrollments.student_id) AS number_of_students
FROM courses
LEFT JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name
ORDER BY number_of_students DESC
LIMIT 1;

SELECT id, name, course, year_level
FROM students
ORDER BY name ASC;

SELECT COUNT(*) AS total_enrollments
FROM enrollments;