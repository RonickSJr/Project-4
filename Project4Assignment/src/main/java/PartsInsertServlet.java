/*
Name: Ronick Shellman
Course: CNT 4714 - Fall 2023
Assignment title: A Three-Tier Distributed Web-Based Application
Date: Dec 2, 2023

*/
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

public class PartsInsertServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/project4";
    private static final String USER = "root";
    private static final String PASS = "password"; // Change this to your actual password

    private final static String INSERT_INTO_PARTS = "INSERT INTO parts VALUES(?,?,?,?,?)";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pnum = req.getParameter("pnum");
        String pname = req.getParameter("pname");
        String color = req.getParameter("color");
        int weight = Integer.parseInt(req.getParameter("weight"));
        String city = req.getParameter("city");

        Connection connection = null;
        int rowsUpdated = 0;
        PreparedStatement ps = null;

        try {
            // Establishing the database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, USER, PASS);

            // Executing the INSERT statement for parts
            ps = connection.prepareStatement(INSERT_INTO_PARTS);
            ps.setString(1, pnum);
            ps.setString(2, pname);
            ps.setString(3, color);
            ps.setInt(4, weight);
            ps.setString(5, city);

            rowsUpdated = ps.executeUpdate();

        } catch (ClassNotFoundException | SQLException sqlEx) {
            sqlEx.printStackTrace();
        } finally {
            // Closing resources in a finally block to ensure they are always closed
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Handling the response
        HttpSession session = req.getSession();
        RequestDispatcher dispatcher = req.getRequestDispatcher("/dataentryHome.jsp");

        session.setAttribute("parts_rows_updated", rowsUpdated);
        dispatcher.forward(req, resp);
    }
}
