package com.mycompany.app;

import java.sql.*;

public class App {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }

    // Vulnerable method susceptible to SQL injection
    public void login(String username, String password) throws SQLException {
        // Intentionally constructed SQL query vulnerable to injection
        String query = "SELECT * FROM users WHERE username = '" + username + "' AND password = '" + password + "'";

        // Example database connection (replace with your actual database connection logic)
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "username", "password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Process query results (not relevant for demonstration)
        while (resultSet.next()) {
            System.out.println("User found: " + resultSet.getString("username"));
        }

        // Close resources (not relevant for demonstration)
        resultSet.close();
        statement.close();
        connection.close();
    }
}
