package com.dental.util;

import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            System.out.println("✅ SUCCESS: Connected to MySQL database!");
        } catch (Exception e) {
            System.err.println("❌ ERROR: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    System.out.println("✅ Connection closed.");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}