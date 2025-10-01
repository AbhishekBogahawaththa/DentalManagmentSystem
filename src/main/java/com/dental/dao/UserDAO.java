package com.dental.dao;

import com.dental.model.User;
import com.dental.util.DBConnection;

import java.sql.*;

public class UserDAO {

    public User getUserByUsernameAndPassword(String username, String password) {
        System.out.println("→ DAO: Searching for user: " + username);

        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));

                System.out.println("→ DAO: ✅ FOUND USER: " + user.getUsername());
                return user;
            } else {
                System.out.println("→ DAO: ❌ NO USER FOUND with username: " + username);
            }
        } catch (Exception e) {
            System.err.println("→ DAO: ❌ EXCEPTION:");
            e.printStackTrace();
        }
        return null;
    }

    // ✅ NEW METHOD: Add new user
    public void addUser(User user) throws Exception {
        String sql = "INSERT INTO user (username, password, role) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getRole());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            // Get generated ID
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
        }
    }
}