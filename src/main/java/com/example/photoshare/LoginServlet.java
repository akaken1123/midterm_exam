package com.example.photoshare;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/photo/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:postgresql://localhost:5432/photos";
    private static final String DB_USER = "postgres";
    private static final String DB_PASS = "postgres";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("org.postgresql.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = conn.prepareStatement(
                     "SELECT * FROM users WHERE username=? AND \"password\"=?"
                 )) {

                ps.setString(1, username);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    response.sendRedirect("photo_home.jsp");
                } else {
                    request.setAttribute("error", "ユーザー名かパスワードが違います");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "処理中にエラーが発生しました");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
