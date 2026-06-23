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
);

-- 4. Verify the insert
SELECT id, enrollment_no, full_name, branch, current_semester, cgpa FROM students;

-- ============================================================
--  DEMO LOGIN CREDENTIALS:
--  Enrollment: 226170307001   Password: demo123
--  Enrollment: 226170307002   Password: test456
--  Enrollment: 226170307003   Password: pass789
-- ============================================================
