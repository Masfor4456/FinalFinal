--Mason Ford
--SDC250 final
SELECT description,
       course_no,
       TO_CHAR(cost, '$9,999.99') AS cost
FROM course
WHERE cost < (SELECT AVG(cost) FROM course)
ORDER BY cost DESC;
SELECT DISTINCT
       c.course_no,
       c.description,
       c.cost,
       s.start_date_time
FROM course c
JOIN section s
  ON c.course_no = s.course_no
ORDER BY c.course_no, c.description;
SELECT z.zip,
       COUNT(i.instructor_id) AS instructor_count
FROM zipcode z
LEFT JOIN instructor i
  ON z.zip = i.zip
GROUP BY z.zip
ORDER BY z.zip;
SELECT s.student_id,
       s.first_name,
       s.last_name,
       s.street_address,
       z.state,
       s.zip
FROM student s
JOIN zipcode z
  ON s.zip = z.zip
WHERE UPPER(z.city) = 'BROOKLYN'
ORDER BY s.last_name, s.first_name;
SELECT i.first_name,
       i.last_name,
       COUNT(s.section_id) AS sections_taught
FROM instructor i
LEFT JOIN section s
  ON i.instructor_id = s.instructor_id
GROUP BY i.first_name, i.last_name
ORDER BY sections_taught DESC;
SELECT first_name,
       last_name,
       street_address,
       zip
FROM student
WHERE zip =
      (SELECT zip
       FROM instructor
       WHERE first_name = 'Tom'
       AND last_name = 'Wojick');
       SELECT student_id,
       salutation,
       first_name,
       last_name
FROM student
WHERE registration_date <
      (SELECT registration_date
       FROM student
       WHERE first_name = 'Vera'
       AND last_name = 'Wetcel');
       SELECT s.student_id
FROM student s
LEFT JOIN enrollment e
  ON s.student_id = e.student_id
WHERE e.student_id IS NULL;
CREATE VIEW all_people_view AS
SELECT salutation,
       first_name || ' ' || last_name AS full_name,
       street_address,
       zip,
       phone
FROM student
UNION
SELECT salutation,
       first_name || ' ' || last_name,
       street_address,
       zip,
       phone
FROM instructor;
SELECT s.first_name,
       s.last_name,
       s.student_id
FROM student s
JOIN enrollment e
  ON s.student_id = e.student_id
WHERE e.final_grade =
      (SELECT MAX(final_grade) FROM enrollment);
      SELECT c.course_no,
       c.description,
       COUNT(s.section_id) AS number_of_sections
FROM course c
JOIN section s
  ON c.course_no = s.course_no
GROUP BY c.course_no, c.description
HAVING COUNT(s.section_id) > 5;
SELECT c.course_no,
       c.description,
       c.cost,
       p.course_no AS prereq_course_no,
       p.description AS prereq_description
FROM course c
LEFT JOIN course p
  ON c.prerequisite = p.course_no
ORDER BY c.course_no;
SELECT c.course_no,
       c.description,
       COUNT(s.section_id) AS number_of_sections
FROM course c
JOIN section s
  ON c.course_no = s.course_no
GROUP BY c.course_no, c.description
HAVING COUNT(s.section_id) =
       (SELECT MAX(COUNT(*))
        FROM section
        GROUP BY course_no);
        SELECT c.course_no,
       c.description,
       s.start_date_time,
       s.capacity,
       COUNT(e.student_id) AS enrolled_students
FROM course c
JOIN section s
  ON c.course_no = s.course_no
JOIN enrollment e
  ON s.section_id = e.section_id
GROUP BY c.course_no,
         c.description,
         s.start_date_time,
         s.capacity
HAVING COUNT(e.student_id) > s.capacity;