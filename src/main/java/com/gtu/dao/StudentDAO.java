package com.gtu.dao;

import com.gtu.model.Student;
import java.sql.*;

/**
 * StudentDAO - Data Access Object for Student table
 * All database queries related to students go here.
 */
public class StudentDAO {

    /**
     * Validates login credentials.
     * Returns a Student object if login is correct, null otherwise.
     */
    public Student login(String enrollmentNo, String password) {
        Student student = null;

        // NOTE: In production, NEVER store plain-text passwords.
        // Use BCrypt or SHA-256 hashing. For demo, plain-text is used.
        String sql = "SELECT * FROM students WHERE enrollment_no = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, enrollmentNo);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                student = mapResultSetToStudent(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return student;
    }

    /**
     * Fetch student by enrollment number (for profile page).
     */
    public Student getStudentByEnrollment(String enrollmentNo) {
        Student student = null;
        String sql = "SELECT * FROM students WHERE enrollment_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, enrollmentNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                student = mapResultSetToStudent(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return student;
    }

    /**
     * Maps a ResultSet row to a Student object.
     * Column names must match your 'students' table schema.
     */
    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        return new Student(
            rs.getInt("id"),
            rs.getString("enrollment_no"),
            rs.getString("full_name"),
            rs.getString("email"),
            rs.getString("mobile"),
            rs.getString("dob"),
            rs.getString("gender"),
            rs.getString("branch"),
            rs.getString("program"),
            rs.getString("college_name"),
            rs.getInt("current_semester"),
            rs.getString("admission_year"),
            rs.getDouble("cgpa"),
            rs.getInt("backlogs"),
            rs.getString("category"),
            rs.getString("abc_id"),
            rs.getString("aadhaar_no"),
            rs.getString("parent_mobile"),
            rs.getString("parent_email"),
            rs.getString("account_detail"),
            rs.getString("address")
        );
    }

    /**
     * Updates student profile information.
     */
    public boolean updateProfile(String enrollmentNo, String dob, String gender, 
                                 String parentMobile, String parentEmail, 
                                 String abcId, String accountDetail, String address) {
        String sql = "UPDATE students SET dob = ?, gender = ?, parent_mobile = ?, " +
                     "parent_email = ?, abc_id = ?, account_detail = ?, address = ? WHERE enrollment_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dob);
            ps.setString(2, gender);
            ps.setString(3, parentMobile);
            ps.setString(4, parentEmail);
            ps.setString(5, abcId);
            ps.setString(6, accountDetail);
            ps.setString(7, address);
            ps.setString(8, enrollmentNo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates student mobile number.
     */
    public boolean updateMobile(String enrollmentNo, String newMobile) {
        String sql = "UPDATE students SET mobile = ? WHERE enrollment_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newMobile);
            ps.setString(2, enrollmentNo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates student email address.
     */
    public boolean updateEmail(String enrollmentNo, String newEmail) {
        String sql = "UPDATE students SET email = ? WHERE enrollment_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newEmail);
            ps.setString(2, enrollmentNo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates student password.
     */
    public boolean updatePassword(String enrollmentNo, String newPassword) {
        String sql = "UPDATE students SET password = ? WHERE enrollment_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, enrollmentNo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
