package com.dental.dao;

import com.dental.model.User;
import com.dental.util.DBConnection;

import java.sql.*;

import static com.dental.util.DBConnection.getConnection;

public class UserDAO {

    public User getUserByUsernameAndPassword(String username, String password) {
        System.out.println("🔍 [UserDAO] Called with username='" + username + "', password='" + password + "'");

        String sql = "SELECT id, username, password, role FROM user WHERE username = ? AND password = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            System.out.println("🔍 [UserDAO] Executing SQL: " + sql.replace("?", "'" + username + "' and '" + password + "'"));

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                System.out.println("✅ [UserDAO] User FOUND: " + user.getUsername() + " (ID: " + user.getId() + ", Role: " + user.getRole() + ")");
                return user;
            } else {
                System.out.println("❌ [UserDAO] NO USER FOUND for username='" + username + "'");
                return null;
            }
        } catch (SQLException e) {
            System.err.println("🔥 [UserDAO] SQL ERROR: " + e.getMessage());
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // ✅ NEW METHOD: Add new user
    public void addUser(User user) throws Exception {
        String sql = "INSERT INTO user (username, password, role) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
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