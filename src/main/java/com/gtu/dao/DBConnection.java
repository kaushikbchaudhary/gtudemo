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
    private static final String DB_PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
    private static final String DB_NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "gtu_student_db";
    private static String DB_USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
    private static String DB_PASS = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "password";

    private static String DB_URL;
    static {
        String envUrl = System.getenv("DB_URL");
        if (envUrl == null) {
            envUrl = System.getenv("MYSQL_URL");
        }
        if (envUrl == null) {
            envUrl = System.getenv("DATABASE_URL");
        }

        if (envUrl != null) {
            // Clean up and convert protocol if necessary
            if (envUrl.startsWith("mysql://")) {
                envUrl = "jdbc:mysql://" + envUrl.substring(8);
            }
            
            // If the URL contains username/password: jdbc:mysql://user:pass@host:port/database
            if (envUrl.contains("@")) {
                String prefix = "jdbc:mysql://";
                int prefixIdx = envUrl.indexOf(prefix);
                if (prefixIdx != -1) {
                    String afterPrefix = envUrl.substring(prefixIdx + prefix.length());
                    int atIdx = afterPrefix.indexOf("@");
                    if (atIdx != -1) {
                        String credentials = afterPrefix.substring(0, atIdx);
                        String hostAndDb = afterPrefix.substring(atIdx + 1);
                        
                        int colonIdx = credentials.indexOf(":");
                        DB_USER = colonIdx != -1 ? credentials.substring(0, colonIdx) : credentials;
                        DB_PASS = colonIdx != -1 ? credentials.substring(colonIdx + 1) : "";
                        
                        envUrl = "jdbc:mysql://" + hostAndDb;
                    }
                }
            }
            DB_URL = envUrl;
        } else {
            DB_URL = "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        }
    }
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
