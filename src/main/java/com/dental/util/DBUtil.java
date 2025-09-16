package com.dental.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBUtil {
    private static final Properties props = new Properties();

    static {
        try (InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) props.load(in);
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (Exception ex) {
            throw new ExceptionInInitializerError("Failed to load DB properties: " + ex.getMessage());
        }
    }

    public static Connection getConnection() throws Exception {
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.username");
        String pass = props.getProperty("db.password");
        return DriverManager.getConnection(url, user, pass);
    }
}
