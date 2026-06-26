-- ============================================================
--  GTU Student Portal Demo — Database Setup
--  Run this in MySQL Workbench or phpMyAdmin or terminal:
--    mysql -u root -p < db/setup.sql
-- ============================================================

-- 1. Create the database
CREATE DATABASE IF NOT EXISTS gtu_student_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gtu_student_db;

-- 2. Create the students table
CREATE TABLE IF NOT EXISTS students (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_no    VARCHAR(20) NOT NULL UNIQUE,
    password         VARCHAR(100) NOT NULL,         -- plain-text for demo only
    full_name        VARCHAR(100) NOT NULL,
    email            VARCHAR(100),
    mobile           VARCHAR(15),
    dob              VARCHAR(20),
    gender           VARCHAR(10),
    branch           VARCHAR(100),
    program          VARCHAR(100),
    college_name     VARCHAR(200),
    current_semester INT DEFAULT 1,
    admission_year   VARCHAR(10),
    cgpa             DECIMAL(4,2) DEFAULT 0.00,
    backlogs         INT DEFAULT 0,
    category         VARCHAR(50),
    abc_id           VARCHAR(20) DEFAULT '574852927287',
    aadhaar_no       VARCHAR(20) DEFAULT '702894088420',
    parent_mobile    VARCHAR(15) DEFAULT '9427816752',
    parent_email     VARCHAR(100) DEFAULT 'patelvedang2000@icloud.com',
    account_detail   VARCHAR(255) DEFAULT '29875258151 , IFSC : SBIN0002637',
    address          VARCHAR(255) DEFAULT 'AT POST DEBHARI (patelvada) TA VIRPUR DIST MAHISAGAR',
    profile_pic      LONGTEXT,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Insert sample/dummy student data for testing
INSERT INTO students (
    enrollment_no, password, full_name, email, mobile,
    dob, gender, branch, program, college_name,
    current_semester, admission_year, cgpa, backlogs, category,
    abc_id, aadhaar_no, parent_mobile, parent_email, account_detail, address
) VALUES
-- Test Student 1 (login: 226170307001 / demo123)
(
    '226170307001', 'demo123',
    'Ravi Patel', 'ravi.patel@student.gtu.ac.in', '9876543210',
    '15-Aug-2004', 'Male',
    'Computer Engineering', 'B.E.',
    'Sardar Patel College of Engineering, Bakrol',
    5, '2022', 8.15, 0, 'General',
    '574852927287', '702894088420', '9427816752', 'ravi.parent@icloud.com', '29875258151 , IFSC : SBIN0002637', 'AT POST DEBHARI (patelvada) TA VIRPUR DIST MAHISAGAR'
),
-- Test Student 2 (login: 226170307002 / test456)
(
    '226170307002', 'test456',
    'Priya Shah', 'priya.shah@student.gtu.ac.in', '9988776655',
    '20-Mar-2004', 'Female',
    'Information Technology', 'B.E.',
    'L.D. College of Engineering, Ahmedabad',
    5, '2022', 7.80, 1, 'OBC',
    '574852927288', '702894088421', '9427816753', 'priya.parent@icloud.com', '29875258152 , IFSC : SBIN0002637', 'L.D. Hostel, Ahmedabad, Gujarat'
),
-- Test Student 3 (login: 226170307003 / pass789)
(
    '226170307003', 'pass789',
    'Harsh Mehta', 'harsh.mehta@student.gtu.ac.in', '9123456789',
    '05-Nov-2003', 'Male',
    'Mechanical Engineering', 'B.E.',
    'Vishwakarma Government Engineering College, Chandkheda',
    6, '2021', 7.25, 0, 'SC',
    '574852927289', '702894088422', '9427816754', 'harsh.parent@icloud.com', '29875258153 , IFSC : SBIN0002637', 'Chandkheda Campus, Ahmedabad, Gujarat'
),
-- Test Student 4 (login: 216640307036 / 62914366) - Parth BE
(
    '216640307036', '62914366',
    'PATEL PARTH KUMAR SURESH BHAI', 'parth.patel@student.gtu.ac.in', '9898767654',
    '12-Dec-2003', 'Male',
    'Computer Engineering', 'B.E.',
    'Sardar Patel College of Engineering, Bakrol',
    8, '2021', 8.24, 0, 'General',
    '574852927290', '702894088423', '9427816755', 'parth.parent@icloud.com', '29875258154 , IFSC : SBIN0002637', 'Ahmedabad, Gujarat'
),
-- Test Student 5 (login: 186640307036 / 62914366) - Parth Diploma
(
    '186640307036', '62914366',
    'PATEL PARTH KUMAR SURESH BHAI', 'parth.patel@student.gtu.ac.in', '9898767654',
    '12-Dec-2000', 'Male',
    'Computer Engineering', 'DI',
    'Sardar Patel College of Engineering, Bakrol',
    6, '2018', 7.51, 0, 'General',
    '574852927291', '702894088424', '9427816755', 'parth.parent@icloud.com', '29875258154 , IFSC : SBIN0002637', 'Ahmedabad, Gujarat'
);

-- 4. Verify the insert
SELECT id, enrollment_no, full_name, branch, current_semester, cgpa FROM students;

-- 5. Create Exam Results and Subjects tables
CREATE TABLE IF NOT EXISTS exam_results (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_no    VARCHAR(20) NOT NULL,
    exam_key         VARCHAR(50) NOT NULL,
    declared_date    VARCHAR(50) NOT NULL,
    exam_name        VARCHAR(100) NOT NULL,
    sem_backlog      VARCHAR(10) NOT NULL,
    tot_backlog      VARCHAR(10) NOT NULL,
    spi              VARCHAR(10) NOT NULL,
    cpi              VARCHAR(10) NOT NULL,
    cgpa             VARCHAR(10) NOT NULL,
    exam_status      VARCHAR(255) NOT NULL,
    passed           BOOLEAN NOT NULL,
    FOREIGN KEY (enrollment_no) REFERENCES students(enrollment_no) ON DELETE CASCADE,
    UNIQUE KEY unique_student_exam (enrollment_no, exam_key)
);

CREATE TABLE IF NOT EXISTS exam_subjects (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    exam_result_id   INT NOT NULL,
    subject_code     VARCHAR(20) NOT NULL,
    subject_name     VARCHAR(255) NOT NULL,
    ese_ab           VARCHAR(5) NOT NULL,
    theory_ese       VARCHAR(5) NOT NULL,
    theory_pa        VARCHAR(5) NOT NULL,
    theory_total     VARCHAR(5) NOT NULL,
    practical_ese    VARCHAR(5) NOT NULL,
    practical_pa     VARCHAR(5) NOT NULL,
    practical_total  VARCHAR(5) NOT NULL,
    subject_grade    VARCHAR(5) NOT NULL,
    FOREIGN KEY (exam_result_id) REFERENCES exam_results(id) ON DELETE CASCADE
);

-- 6. Insert results for Ravi Patel (226170307001)
-- Sem 6 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('226170307001', 'sem6_reg', '30 Jul 2022', 'DIPL SEM 6 - Regular (MAY 2022)', '0', '0', '7.84', '7.54', '7.51', 'Congratulation!! You have passed this exam.', TRUE);
SET @sem6_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@sem6_id, '3360701', 'Advance Java Programming', '-', 'DD', 'CD', 'DD', 'BC', 'AA', 'AB', 'BC'),
(@sem6_id, '3360702', 'Professional Practices Using Database', '-', '-', '-', '-', 'BC', 'AB', 'AB', 'AB'),
(@sem6_id, '3360703', 'Networking Management & Administration', '-', 'BC', 'BC', 'BC', 'AA', 'AB', 'AB', 'BB'),
(@sem6_id, '3360704', 'Mobile Computing And Application Development', '-', 'DD', 'CD', 'DD', 'BC', 'AB', 'BB', 'CC'),
(@sem6_id, '3360707', 'PROJECT-II', '-', '-', '-', '-', 'AB', 'AA', 'AA', 'AA');

-- Sem 5 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('226170307001', 'sem5_reg', '11 Feb 2022', 'DIPL SEM 5 - Regular (DEC 2021)', '0', '0', '7.47', '7.47', '7.40', 'Congratulation!! You have passed this exam.', TRUE);
SET @sem5_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@sem5_id, '3350701', 'Computer Maintenance And Trouble Shooting', '-', 'DD', 'CD', 'DD', 'AB', 'AB', 'AB', 'CC'),
(@sem5_id, '3350702', 'Dynamic Web Page Development', '-', 'DD', 'CC', 'CD', 'AB', 'AB', 'AB', 'BC'),
(@sem5_id, '3350703', 'Java Programming', '-', 'DD', 'CD', 'DD', 'AA', 'AA', 'AA', 'BB'),
(@sem5_id, '3350704', 'Computer And Network Security', '-', 'DD', 'CD', 'DD', 'AB', 'AB', 'AB', 'BC'),
(@sem5_id, '3350706', 'PROJECT-I', '-', '-', '-', '-', 'AA', 'AA', 'AA', 'AA');

-- Sem 4 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('226170307001', 'sem4_reg', '07 Oct 2021', 'DIPL SEM 4 - Regular (MAY 2021)', '0', '2', '7.90', '6.66', '5.79', 'Congratulation!! You have passed this exam.', TRUE);
SET @sem4_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@sem4_id, '3340701', 'Advanced Database Management System', '-', 'CD', 'BC', 'CC', 'AB', 'BB', 'AB', 'BC'),
(@sem4_id, '3340702', 'Computer Networks', '-', 'BC', 'AA', 'BB', 'AB', 'BB', 'AB', 'BB'),
(@sem4_id, '3340704', '.net Programming', '-', 'CC', 'AB', 'BC', 'AB', 'BB', 'AB', 'BB'),
(@sem4_id, '3340705', 'Computer Organization And Architecture', '-', 'BC', 'AA', 'BB', '-', '-', '-', 'BB'),
(@sem4_id, '3340708', 'Web Development Tools', '-', '-', '-', '-', 'AA', 'AB', 'AB', 'AB'),
(@sem4_id, '3341603', 'Fundamentals Of Software Development', '-', 'CC', 'BB', 'BC', 'AB', 'AB', 'AB', 'BB');

-- Sem 3 Remedial
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('226170307001', 'sem3_rem', '25 Oct 2021', 'DIPL SEM 3 - Remedial (MAY 2021)', '0', '0', '6.84', '7.48', '7.37', 'Congratulation!! You have passed this exam.', TRUE);
SET @sem3_rem_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@sem3_rem_id, '3330703', 'Database Management System', '-', 'DD', 'BB', 'CC', 'AB', 'AA', 'AB', 'BC'),
(@sem3_rem_id, '3330704', 'Data Structure', '-', 'DD', 'AB', 'CC', 'AA', 'AB', 'AB', 'BC');

-- Sem 3 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('226170307001', 'sem3_reg', '04 May 2021', 'DIPL SEM 3 - Regular (JAN 2021)', '2', '2', '3.68', '6.22', '3.68', 'Sorry! You have not cleared this exam.', FALSE);
SET @sem3_reg_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@sem3_reg_id, '3330701', 'Operating System', '-', 'DD', 'AA', 'CC', 'BB', 'BC', 'BC', 'CC'),
(@sem3_reg_id, '3330702', 'Programming In C++', '-', 'CC', 'BB', 'CC', 'BB', 'AB', 'BB', 'BC'),
(@sem3_reg_id, '3330703', 'Database Management System', '-', 'FF', 'BB', 'FF', 'AB', 'AA', 'AB', 'FF'),
(@sem3_reg_id, '3330704', 'Data Structure', '-', 'FF', 'AB', 'FF', 'AA', 'AB', 'AB', 'FF'),
(@sem3_reg_id, '3330705', 'Microprocessor & Assembly Language Programming', '-', 'DD', 'AA', 'CC', 'BB', 'BB', 'BB', 'BC');

-- Sem 2 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('226170307001', 'sem2_reg', '27 Jul 2019', 'DIPL SEM 2 - Regular (MAY 2020)', '0', '0', '8.17', '7.59', '', 'Congratulation!! You have passed this exam.', TRUE);
SET @sem2_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@sem2_id, '3300005', 'BASIC PHYSICS (GROUP-2)', '-', 'BC', 'AB', 'BB', 'AB', 'AB', 'AB', 'BB'),
(@sem2_id, '3320002', 'ADVANCED MATHEMATICS (GROUP-1)', '-', 'CC', 'CC', 'CC', '-', '-', '-', 'CC'),
(@sem2_id, '3320701', 'Basic Electronics', '-', 'BB', 'AA', 'BB', 'AB', 'AB', 'AB', 'AB'),
(@sem2_id, '3320702', 'Advanced Computer Programming', '-', 'CC', 'CC', 'CC', 'AB', 'AB', 'AB', 'BB'),
(@sem2_id, '3320703', 'Static Web Page Designing', '-', '-', '-', '-', 'AB', 'AB', 'AB', 'AB'),
(@sem2_id, '3990001', 'Contributor Personality Development', '-', 'BB', 'AA', 'BB', 'AB', 'AB', 'AB', 'AB');

-- Sem 1 Remedial
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('226170307001', 'sem1_rem', '12 Mar 2020', 'DIPL SEM 1 - Remedial (DEC 2019)', '0', '0', '-', '7.00', '', 'Congratulation!! You have passed this exam.', TRUE);
SET @sem1_rem_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@sem1_rem_id, '3310701', 'Computer Programming', '-', 'CD', 'CD', 'CD', 'AB', 'AA', 'AB', 'BC'),
(@sem1_rem_id, '3310702', 'Fundamental Of Digital Electronics', '-', 'CD', 'BB', 'CC', 'AA', 'AA', 'AA', 'BB');

-- Sem 1 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('226170307001', 'sem1_reg', '16 Mar 2019', 'DIPL SEM 1 - Regular (DEC 2018)', '2', '2', '3.93', '3.93', '', 'Sorry! You have not cleared this exam.', FALSE);
SET @sem1_reg_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@sem1_reg_id, '3300001', 'Basic Mathematics', '-', 'DD', 'CC', 'CD', '-', '-', '-', 'CD'),
(@sem1_reg_id, '3300002', 'English', '-', 'DD', 'CD', 'DD', 'AB', 'BB', 'BB', 'CC'),
(@sem1_reg_id, '3300003', 'Environment Conservation And Hazard Management', '-', 'CC', 'AA', 'BC', '-', '-', '-', 'BC'),
(@sem1_reg_id, '3310701', 'Computer Programming', '-', 'FF', 'CD', 'FF', 'AB', 'AA', 'AB', 'FF'),
(@sem1_reg_id, '3310702', 'Fundamental Of Digital Electronics', '-', 'FF', 'BB', 'FF', 'AA', 'AA', 'AA', 'FF'),
(@sem1_reg_id, '3310703', 'Fundamental Of Computer Application', '-', '-', '-', '-', 'AB', 'AA', 'AB', 'AB');

-- 7. Insert Diploma results for Patel Parth (186640307036) - identical to Ravi Patel's
-- Sem 6 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('186640307036', 'sem6_reg', '30 Jul 2022', 'DIPL SEM 6 - Regular (MAY 2022)', '0', '0', '7.84', '7.54', '7.51', 'Congratulation!! You have passed this exam.', TRUE);
SET @p_sem6_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@p_sem6_id, '3360701', 'Advance Java Programming', '-', 'DD', 'CD', 'DD', 'BC', 'AA', 'AB', 'BC'),
(@p_sem6_id, '3360702', 'Professional Practices Using Database', '-', '-', '-', '-', 'BC', 'AB', 'AB', 'AB'),
(@p_sem6_id, '3360703', 'Networking Management & Administration', '-', 'BC', 'BC', 'BC', 'AA', 'AB', 'AB', 'BB'),
(@p_sem6_id, '3360704', 'Mobile Computing And Application Development', '-', 'DD', 'CD', 'DD', 'BC', 'AB', 'BB', 'CC'),
(@p_sem6_id, '3360707', 'PROJECT-II', '-', '-', '-', '-', 'AB', 'AA', 'AA', 'AA');

-- Sem 5 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('186640307036', 'sem5_reg', '11 Feb 2022', 'DIPL SEM 5 - Regular (DEC 2021)', '0', '0', '7.47', '7.47', '7.40', 'Congratulation!! You have passed this exam.', TRUE);
SET @p_sem5_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@p_sem5_id, '3350701', 'Computer Maintenance And Trouble Shooting', '-', 'DD', 'CD', 'DD', 'AB', 'AB', 'AB', 'CC'),
(@p_sem5_id, '3350702', 'Dynamic Web Page Development', '-', 'DD', 'CC', 'CD', 'AB', 'AB', 'AB', 'BC'),
(@p_sem5_id, '3350703', 'Java Programming', '-', 'DD', 'CD', 'DD', 'AA', 'AA', 'AA', 'BB'),
(@p_sem5_id, '3350704', 'Computer And Network Security', '-', 'DD', 'CD', 'DD', 'AB', 'AB', 'AB', 'BC'),
(@p_sem5_id, '3350706', 'PROJECT-I', '-', '-', '-', '-', 'AA', 'AA', 'AA', 'AA');

-- Sem 4 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('186640307036', 'sem4_reg', '07 Oct 2021', 'DIPL SEM 4 - Regular (MAY 2021)', '0', '2', '7.90', '6.66', '5.79', 'Congratulation!! You have passed this exam.', TRUE);
SET @p_sem4_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@p_sem4_id, '3340701', 'Advanced Database Management System', '-', 'CD', 'BC', 'CC', 'AB', 'BB', 'AB', 'BC'),
(@p_sem4_id, '3340702', 'Computer Networks', '-', 'BC', 'AA', 'BB', 'AB', 'BB', 'AB', 'BB'),
(@p_sem4_id, '3340704', '.net Programming', '-', 'CC', 'AB', 'BC', 'AB', 'BB', 'AB', 'BB'),
(@p_sem4_id, '3340705', 'Computer Organization And Architecture', '-', 'BC', 'AA', 'BB', '-', '-', '-', 'BB'),
(@p_sem4_id, '3340708', 'Web Development Tools', '-', '-', '-', '-', 'AA', 'AB', 'AB', 'AB'),
(@p_sem4_id, '3341603', 'Fundamentals Of Software Development', '-', 'CC', 'BB', 'BC', 'AB', 'AB', 'AB', 'BB');

-- Sem 3 Remedial
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('186640307036', 'sem3_rem', '25 Oct 2021', 'DIPL SEM 3 - Remedial (MAY 2021)', '0', '0', '6.84', '7.48', '7.37', 'Congratulation!! You have passed this exam.', TRUE);
SET @p_sem3_rem_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@p_sem3_rem_id, '3330703', 'Database Management System', '-', 'DD', 'BB', 'CC', 'AB', 'AA', 'AB', 'BC'),
(@p_sem3_rem_id, '3330704', 'Data Structure', '-', 'DD', 'AB', 'CC', 'AA', 'AB', 'AB', 'BC');

-- Sem 3 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('186640307036', 'sem3_reg', '04 May 2021', 'DIPL SEM 3 - Regular (JAN 2021)', '2', '2', '3.68', '6.22', '3.68', 'Sorry! You have not cleared this exam.', FALSE);
SET @p_sem3_reg_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@p_sem3_reg_id, '3330701', 'Operating System', '-', 'DD', 'AA', 'CC', 'BB', 'BC', 'BC', 'CC'),
(@p_sem3_reg_id, '3330702', 'Programming In C++', '-', 'CC', 'BB', 'CC', 'BB', 'AB', 'BB', 'BC'),
(@p_sem3_reg_id, '3330703', 'Database Management System', '-', 'FF', 'BB', 'FF', 'AB', 'AA', 'AB', 'FF'),
(@p_sem3_reg_id, '3330704', 'Data Structure', '-', 'FF', 'AB', 'FF', 'AA', 'AB', 'AB', 'FF'),
(@p_sem3_reg_id, '3330705', 'Microprocessor & Assembly Language Programming', '-', 'DD', 'AA', 'CC', 'BB', 'BB', 'BB', 'BC');

-- Sem 2 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('186640307036', 'sem2_reg', '27 Jul 2019', 'DIPL SEM 2 - Regular (MAY 2020)', '0', '0', '8.17', '7.59', '', 'Congratulation!! You have passed this exam.', TRUE);
SET @p_sem2_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@p_sem2_id, '3300005', 'BASIC PHYSICS (GROUP-2)', '-', 'BC', 'AB', 'BB', 'AB', 'AB', 'AB', 'BB'),
(@p_sem2_id, '3320002', 'ADVANCED MATHEMATICS (GROUP-1)', '-', 'CC', 'CC', 'CC', '-', '-', '-', 'CC'),
(@p_sem2_id, '3320701', 'Basic Electronics', '-', 'BB', 'AA', 'BB', 'AB', 'AB', 'AB', 'AB'),
(@p_sem2_id, '3320702', 'Advanced Computer Programming', '-', 'CC', 'CC', 'CC', 'AB', 'AB', 'AB', 'BB'),
(@p_sem2_id, '3320703', 'Static Web Page Designing', '-', '-', '-', '-', 'AB', 'AB', 'AB', 'AB'),
(@p_sem2_id, '3990001', 'Contributor Personality Development', '-', 'BB', 'AA', 'BB', 'AB', 'AB', 'AB', 'AB');

-- Sem 1 Remedial
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('186640307036', 'sem1_rem', '12 Mar 2020', 'DIPL SEM 1 - Remedial (DEC 2019)', '0', '0', '-', '7.00', '', 'Congratulation!! You have passed this exam.', TRUE);
SET @p_sem1_rem_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@p_sem1_rem_id, '3310701', 'Computer Programming', '-', 'CD', 'CD', 'CD', 'AB', 'AA', 'AB', 'BC'),
(@p_sem1_rem_id, '3310702', 'Fundamental Of Digital Electronics', '-', 'CD', 'BB', 'CC', 'AA', 'AA', 'AA', 'BB');

-- Sem 1 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('186640307036', 'sem1_reg', '16 Mar 2019', 'DIPL SEM 1 - Regular (DEC 2018)', '2', '2', '3.93', '3.93', '', 'Sorry! You have not cleared this exam.', FALSE);
SET @p_sem1_reg_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@p_sem1_reg_id, '3300001', 'Basic Mathematics', '-', 'DD', 'CC', 'CD', '-', '-', '-', 'CD'),
(@p_sem1_reg_id, '3300002', 'English', '-', 'DD', 'CD', 'DD', 'AB', 'BB', 'BB', 'CC'),
(@p_sem1_reg_id, '3300003', 'Environment Conservation And Hazard Management', '-', 'CC', 'AA', 'BC', '-', '-', '-', 'BC'),
(@p_sem1_reg_id, '3310701', 'Computer Programming', '-', 'FF', 'CD', 'FF', 'AB', 'AA', 'AB', 'FF'),
(@p_sem1_reg_id, '3310702', 'Fundamental Of Digital Electronics', '-', 'FF', 'BB', 'FF', 'AA', 'AA', 'AA', 'FF'),
(@p_sem1_reg_id, '3310703', 'Fundamental Of Computer Application', '-', '-', '-', '-', 'AB', 'AA', 'AB', 'AB');

-- 8. Insert BE results for Patel Parth (216640307036)
-- Sem 8 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('216640307036', 'sem8_reg', '28 Jul 2025', 'B.E. SEM 8 - Regular (MAY 2025)', '0', '0', '9.00', '8.39', '8.38', 'Congratulation!! You have passed this exam.', TRUE);
SET @be_sem8_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@be_sem8_id, '102000801', 'Industrial Internship', '-', '-', '-', '-', 'AA', 'AA', 'AA', 'AA');

-- Sem 7 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('216640307036', 'sem7_reg', '18 Feb 2025', 'B.E. SEM 7 - Regular (DEC 2024)', '0', '0', '8.50', '8.31', '8.30', 'Congratulation!! You have passed this exam.', TRUE);
SET @be_sem7_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@be_sem7_id, '102046707', 'Data Science and Visualization', '-', 'AB', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA'),
(@be_sem7_id, '102046710', 'Introduction to Cloud Computing', '-', 'BB', 'AA', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem7_id, '102046712', 'Mobile Application Development', '-', 'AB', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA'),
(@be_sem7_id, '102047801', 'Advanced Software Engineering', '-', 'BC', 'AB', 'BB', 'AA', 'AA', 'AA', 'BB'),
(@be_sem7_id, '102046715', 'UI/UX Design', '-', 'BB', 'AA', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem7_id, '102000701', 'Summer Training', '-', '-', '-', '-', 'AA', 'AA', 'AA', 'AA');

-- Sem 6 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('216640307036', 'sem6_reg', '05 Aug 2024', 'B.E. SEM 6 - Regular (MAY 2024)', '0', '0', '8.35', '8.28', '8.27', 'Congratulation!! You have passed this exam.', TRUE);
SET @be_sem6_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@be_sem6_id, '102046708', 'Information and Network Security', '-', 'BB', 'AA', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem6_id, '102046709', 'Internet of Things', '-', 'BC', 'AB', 'BB', 'AA', 'AA', 'AA', 'BB'),
(@be_sem6_id, '102045609', 'Machine Learning', '-', 'BC', 'AA', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem6_id, '102046701', 'Advanced Web Development', '-', 'AB', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA'),
(@be_sem6_id, '102030622', 'Smart Cities Planning and Management', '-', 'CC', 'BC', 'BC', 'AA', 'AA', 'AA', 'BC'),
(@be_sem6_id, '102040601', 'Mini Project', '-', '-', '-', '-', 'AA', 'AA', 'AA', 'AA');

-- Sem 5 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('216640307036', 'sem5_reg', '22 Feb 2024', 'B.E. SEM 5 - Regular (DEC 2023)', '0', '0', '8.40', '8.25', '8.25', 'Congratulation!! You have passed this exam.', TRUE);
SET @be_sem5_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@be_sem5_id, '102045601', 'Design and Analysis of Algorithms', '-', 'BC', 'AA', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem5_id, '102044504', 'Programming with Python', '-', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA'),
(@be_sem5_id, '102045602', 'Software Engineering', '-', 'BB', 'AB', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem5_id, '102044505', 'Web Development', '-', 'AB', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA'),
(@be_sem5_id, '102045607', 'Cyber Security', '-', 'BC', 'AB', 'BB', 'AA', 'AA', 'AA', 'BB'),
(@be_sem5_id, '102050522', 'Energy Systems', '-', 'CC', 'BC', 'CD', 'AA', 'AA', 'AA', 'CD');

-- Sem 4 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('216640307036', 'sem4_reg', '15 Oct 2023', 'B.E. SEM 4 - Regular (MAY 2023)', '0', '0', '8.25', '8.18', '', 'Congratulation!! You have passed this exam.', TRUE);
SET @be_sem4_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@be_sem4_id, '102044502', 'Programming with Java', '-', 'BC', 'AA', 'BB', 'AA', 'AA', 'AA', 'BB'),
(@be_sem4_id, '102044501', 'Computer Networks', '-', 'BB', 'AB', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem4_id, '102040401', 'Computer Organization and Architecture', '-', 'BC', '-', 'BC', '-', '-', '-', 'BC'),
(@be_sem4_id, '102040402', 'Operating Systems', '-', 'BB', 'AB', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem4_id, '102003404', 'Technical Writing and Soft Skills', '-', 'AB', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA'),
(@be_sem4_id, '102003405', 'Entrepreneur Skills', '-', 'BB', 'AB', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem4_id, '102040404', 'Seminar', '-', '-', '-', '-', 'AA', 'AA', 'AA', 'AA');

-- Sem 3 Regular
INSERT INTO exam_results (enrollment_no, exam_key, declared_date, exam_name, sem_backlog, tot_backlog, spi, cpi, cgpa, exam_status, passed)
VALUES ('216640307036', 'sem3_reg', '12 May 2023', 'B.E. SEM 3 - Regular (DEC 2022)', '0', '0', '8.12', '8.12', '', 'Congratulation!! You have passed this exam.', TRUE);
SET @be_sem3_id = LAST_INSERT_ID();

INSERT INTO exam_subjects (exam_result_id, subject_code, subject_name, ese_ab, theory_ese, theory_pa, theory_total, practical_ese, practical_pa, practical_total, subject_grade) VALUES
(@be_sem3_id, '102003402', 'Fundamentals of Economics and Business Management', '-', 'BB', 'AA', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem3_id, '102000303', 'Probability - Statistics and Numerical Methods', '-', 'BC', 'AB', 'BB', 'AA', 'AA', 'AA', 'BB'),
(@be_sem3_id, '102040303', 'Digital Fundamentals', '-', 'CC', 'AB', 'BC', 'AA', 'AA', 'AA', 'BC'),
(@be_sem3_id, '102040301', 'Data Structures', '-', 'BC', 'AA', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem3_id, '102040302', 'Database Management Systems', '-', 'BB', 'AA', 'AB', 'AA', 'AA', 'AA', 'AB'),
(@be_sem3_id, '102003403', 'Indian Ethos and Value Education', '-', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA', 'AA'),
(@be_sem3_id, '900009901', 'Creativity, Problem Solving and Innovation', '-', '-', '-', '-', 'AA', 'AA', 'AA', 'AA');

-- ============================================================
--  DEMO LOGIN CREDENTIALS:
--  Enrollment: 226170307001   Password: demo123
--  Enrollment: 226170307002   Password: test456
--  Enrollment: 226170307003   Password: pass789
--  Enrollment: 216640307036   Password: 62914366
--  Enrollment: 186640307036   Password: 62914366
-- ============================================================


