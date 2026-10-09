MariaDB [(none)]> USE school;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MariaDB [school]> SHOW TABLES;
+------------------+
| Tables_in_school |
+------------------+
| courses          |
| students         |
+------------------+
2 rows in set (0.000 sec)

MariaDB [school]> CREATE TABLE enrollments (
    -> enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    -> student_id INT,
    -> course_id INT,
    -> enrollment_date DATE);
Query OK, 0 rows affected (0.009 sec)

MariaDB [school]> DESCRIBE enrollments;
+-----------------+---------+------+-----+---------+----------------+
| Field           | Type    | Null | Key | Default | Extra          |
+-----------------+---------+------+-----+---------+----------------+
| enrollment_id   | int(11) | NO   | PRI | NULL    | auto_increment |
| student_id      | int(11) | YES  |     | NULL    |                |
| course_id       | int(11) | YES  |     | NULL    |                |
| enrollment_date | date    | YES  |     | NULL    |                |
+-----------------+---------+------+-----+---------+----------------+
4 rows in set (0.001 sec)

MariaDB [school]> ALTER TABLE enrollments
    -> ADD CONSTRAINT fk_student
    -> FOREIGN KEY (student_id)
    -> REFERENCES courses(course_id);
Query OK, 0 rows affected (0.021 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [school]> DESCRIBE enrollments;
+-----------------+---------+------+-----+---------+----------------+
| Field           | Type    | Null | Key | Default | Extra          |
+-----------------+---------+------+-----+---------+----------------+
| enrollment_id   | int(11) | NO   | PRI | NULL    | auto_increment |
| student_id      | int(11) | YES  | MUL | NULL    |                |
| course_id       | int(11) | YES  |     | NULL    |                |
| enrollment_date | date    | YES  |     | NULL    |                |
+-----------------+---------+------+-----+---------+----------------+
4 rows in set (0.001 sec)

MariaDB [school]> ALTER TABLE enrollments ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(course_id);
Query OK, 0 rows affected (0.018 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [school]> ALTER TABLE enrollments ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(id);
ERROR 1005 (HY000): Can't create table `school`.`enrollments` (errno: 121 "Duplicate key on write or update")
MariaDB [school]> ALTER TABLE enrollments ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(student_id);
ERROR 1005 (HY000): Can't create table `school`.`enrollments` (errno: 150 "Foreign key constraint is incorrectly formed")
MariaDB [school]> ALTER TABLE enrollments ADD FOREIGN KEY (student_id) REFERENCES students(id);
Query OK, 0 rows affected (0.017 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [school]> DESCRIBE enrollments;
+-----------------+---------+------+-----+---------+----------------+
| Field           | Type    | Null | Key | Default | Extra          |
+-----------------+---------+------+-----+---------+----------------+
| enrollment_id   | int(11) | NO   | PRI | NULL    | auto_increment |
| student_id      | int(11) | YES  | MUL | NULL    |                |
| course_id       | int(11) | YES  | MUL | NULL    |                |
| enrollment_date | date    | YES  |     | NULL    |                |
+-----------------+---------+------+-----+---------+----------------+
4 rows in set (0.002 sec)

MariaDB [school]> SELECT * FROM students;
+----+-----------------------------+--------+------------+
| id | name                        | course | year_level |
+----+-----------------------------+--------+------------+
|  1 | Juan Dela Cruz              | BSIT   |          2 |
|  2 | Maria Santos                | BSCS   |          2 |
|  4 | Alihakim Mangoda Dimacaling | BSIT   |          3 |
+----+-----------------------------+--------+------------+
3 rows in set (0.000 sec)

MariaDB [school]> SELECT * FROM courses;
+-----------+-------------+-------------------------+-------+
| course_id | course_name | description             | units |
+-----------+-------------+-------------------------+-------+
|         1 | CC6         | Emerging Technology     |     3 |
|         2 | CIT6        | Capstone Project 1      |     3 |
|         3 | CIT17       | Web Information Systems |     3 |
+-----------+-------------+-------------------------+-------+
3 rows in set (0.000 sec)

MariaDB [school]> INSERT INTO enrollments
    -> (student_id, course_id, enrollment_date)
    -> VALUES
    -> (1, 1, '2026-10-07'),
    -> (1, 2, '2026-10-07'),
    -> (2, 1, '2026-10-07'),
    -> (4, 3, '2026-10-07');
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`school`.`enrollments`, CONSTRAINT `fk_student` FOREIGN KEY (`student_id`) REFERENCES `courses` (`course_id`))
MariaDB [school]> ALTER TABLE enrollments DROP FOREIGN KEY fk_student;
Query OK, 0 rows affected (0.011 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [school]> ALTER TABLE enrollments 
    -> ADD CONSTRAINT fk_enrollments_student 
    -> FOREIGN KEY (student_id) REFERENCES students(id);
Query OK, 0 rows affected (0.019 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [school]> ALTER TABLE enrollments 
    -> ADD CONSTRAINT fk_enrollments_course 
    -> FOREIGN KEY (course_id) REFERENCES courses(course_id);
Query OK, 0 rows affected (0.017 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [school]> INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES (1, 1, '2026-10-07'), (1, 2, '2026-10-07'), (2, 1, '2026-10-07'), (4, 3, '2026-10-07');
Query OK, 4 rows affected (0.001 sec)
Records: 4  Duplicates: 0  Warnings: 0

MariaDB [school]> SELECT * FROM enrollments;
+---------------+------------+-----------+-----------------+
| enrollment_id | student_id | course_id | enrollment_date |
+---------------+------------+-----------+-----------------+
|             5 |          1 |         1 | 2026-10-07      |
|             6 |          1 |         2 | 2026-10-07      |
|             7 |          2 |         1 | 2026-10-07      |
|             8 |          4 |         3 | 2026-10-07      |
+---------------+------------+-----------+-----------------+
4 rows in set (0.000 sec)

MariaDB [school]> SELECT students.name, courses.course_name, enrollments.enrollments_date
    -> FROM enrollments
    -> JOIN students
    -> ON enrollments.student_id = students.id
    -> JOIN courses ON enrollments.course_id = courses.course_id;
ERROR 1054 (42S22): Unknown column 'enrollments.enrollments_date' in 'SELECT'
MariaDB [school]> SELECT students.name, courses.course_name, enrollments.enrollment_date FROM enrollments JOIN students ON enrollments.student_id = students.id JOIN courses ON enrollments.course_id = courses.course_id;
+-----------------------------+-------------+-----------------+
| name                        | course_name | enrollment_date |
+-----------------------------+-------------+-----------------+
| Juan Dela Cruz              | CC6         | 2026-10-07      |
| Juan Dela Cruz              | CIT6        | 2026-10-07      |
| Maria Santos                | CC6         | 2026-10-07      |
| Alihakim Mangoda Dimacaling | CIT17       | 2026-10-07      |
+-----------------------------+-------------+-----------------+
4 rows in set (0.001 sec)

MariaDB [school]> SELECT students.name, courses.course_name FROM enrollments JOIN students ON enrollments.student_id = students.id JOIN courses ON enrollments.course_id = courses.course_id WHERE courses.course_name = 'CC6';
+----------------+-------------+
| name           | course_name |
+----------------+-------------+
| Juan Dela Cruz | CC6         |
| Maria Santos   | CC6         |
+----------------+-------------+
2 rows in set (0.002 sec)

