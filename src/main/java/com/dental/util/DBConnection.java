package com.dental.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/DentalClinic?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USERNAME = "root";          // ← Update if needed
    private static final String PASSWORD = "2";  // ← UPDATE THIS!

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // ✅ DO NOT run any query here — just load the driver
            System.out.println("✅ MySQL Driver loaded successfully");
        } catch (Exception e) {
            System.err.println("❌ Failed to load MySQL driver");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}