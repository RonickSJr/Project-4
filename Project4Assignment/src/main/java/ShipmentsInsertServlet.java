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

public class ShipmentsInsertServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/project4";
    private static final String USER = "root";
    private static final String PASS = "password"; // Change this to your actual password

    private final static String INSERT_INTO_SHIPMENTS = "INSERT INTO shipments VALUES(?,?,?,?)";
    private final static String UPDATE_SUPPLIERS = "UPDATE suppliers SET status = status + 5 WHERE snum = ?";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String snum = req.getParameter("snum");
        String pnum = req.getParameter("pnum");
        String jnum = req.getParameter("jnum");
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        Connection connection = null;
        String message = "";
        int rowsUpdated = 0;
        int blRowsUpdated = 0;
        PreparedStatement ps = null;
        PreparedStatement bl = null;

        try {
            // Establishing the database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, USER, PASS);

            // Executing the INSERT statement for shipments
            ps = connection.prepareStatement(INSERT_INTO_SHIPMENTS);
            ps.setString(1, snum);
            ps.setString(2, pnum);
            ps.setString(3, jnum);
            ps.setInt(4, quantity);

            rowsUpdated = ps.executeUpdate();

            // Executing the UPDATE statement for suppliers if applicable
            bl = connection.prepareStatement(UPDATE_SUPPLIERS);
            bl.setString(1, snum);
            if (rowsUpdated != 0 && quantity >= 100) {
                blRowsUpdated = bl.executeUpdate();

                if (blRowsUpdated != 0) {
                    message = "updated " + blRowsUpdated + " supplier(s)";
                } else {
                    message = "unable to update supplier(s)";
                }
            } else if (rowsUpdated != 0) {
                message = "insert successful";
            } else {
                message = "no records updated";
            }

        } catch (ClassNotFoundException | SQLException sqlEx) {
            message = "Error executing the SQL statement: <br>" + sqlEx.getMessage();
        } finally {
            // Closing resources in a finally block to ensure they are always closed
            try {
                if (ps != null) {
                    ps.close();
                }
                if (bl != null) {
                    bl.close();
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

        session.setAttribute("shipments_results", message);
        session.setAttribute("shipments_rows_updated", rowsUpdated);
        dispatcher.forward(req, resp);
    }
}