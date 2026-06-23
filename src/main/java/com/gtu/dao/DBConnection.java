package com.gtu.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - Handles MySQL database connection for GTU Student Portal
 * 
 * SETUP:
 *   1. Install MySQL and create database: CREATE DATABASE gtu_student_db;
 *   2. Change DB_URL, DB_USER, DB_PASSWORD below to match your setup
 *   3. Place mysql-connector-j-X.X.X.jar in WEB-INF/lib/
 */
public class DBConnection {

    // =============================================
    //  CHANGE THESE TO MATCH YOUR LOCAL MYSQL SETUP
    // =============================================
    private static final String DB_HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
    private static final String DB_USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
    private static final String DB_PASS = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "password";
    private static final String DB_URL  = "jdbc:mysql://" + DB_HOST + ":3306/gtu_student_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    // =============================================

    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    /**
     * Returns a live MySQL Connection object.
     * Always close the connection after use (preferably in a finally block or try-with-resources).
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(JDBC_DRIVER);
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found! Add mysql-connector-j.jar to WEB-INF/lib", e);
        }
    }
}
