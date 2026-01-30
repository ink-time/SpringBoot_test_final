package com.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnectionMySQL {
    public static Connection getConnection() throws Exception {

        try {
            String URL = "jdbc:mysql://localhost:3307/cinesdb";
//            "jdbc:mysql://localhost:3307/pascual_mercadona_db"
            String username = "root";
            String password = "";
            // returns the com.connection to the database
            return DriverManager.getConnection(URL, username, password);
        } catch (SQLException e) {
            throw e;

        }

    }
}
