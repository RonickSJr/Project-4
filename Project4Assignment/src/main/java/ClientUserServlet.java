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

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * Class responsible for root user database access
 */
public class ClientUserServlet extends HttpServlet {

	  private static final String DB_URL = "jdbc:mysql://localhost:3306/project4";
	    private static final String USER = "root";
	    private static final String PASS = "password"; // Change this to your actual password

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        String query = req.getParameter("query");
        String message = "";

        String ret = null;
        Connection connection = null;
        Statement statement = null;

        try {
            // Establishing the database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, USER, PASS);

            statement = connection.createStatement();

            if (query.toLowerCase().contains("select")) {
                ResultSet resultSet = statement.executeQuery(query);
                ret = Converter.convert(resultSet);
            } else {
                statement.executeUpdate(query);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            message = ex.getMessage();
        } finally {
            // Closing resources in a finally block to ensure they are always closed
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        HttpSession session = req.getSession();
        RequestDispatcher dispatcher = req.getRequestDispatcher("/clientHome.jsp");

        session.setAttribute("query", query);
        session.setAttribute("tableContent", ret);
        session.setAttribute("message", message);
        dispatcher.forward(req, resp);
    }
}
