package dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dentistdao {
    public Connection dbConnection(){
        Connection con = null;

        String url = "jdbc:mysql://localhost:3306/smilecare";
        String user = "root";
        String password = "root";

        try {
            Class.forName("com.sql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url,user,password);
            System.out.println("Connected to database successfully");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }

        return con;
    }
}
