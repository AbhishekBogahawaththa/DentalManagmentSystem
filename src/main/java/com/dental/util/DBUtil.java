package com.dental.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=clinic;encrypt=false";
    private static final String USER = "clinicuser"; // or your custom SQL username
    private static final String PASS = "Clinic@123";

    public static Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
