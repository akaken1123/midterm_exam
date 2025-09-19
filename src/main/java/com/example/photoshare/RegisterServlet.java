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

@WebServlet("/photo/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:postgresql://localhost:5432/photoshare";
    private static final String DB_USER = "postgres";
    private static final String DB_PASS = "postgres";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "パスワードと確認用パスワードが一致しません");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("org.postgresql.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // 1. ユーザー名が既に存在するかチェック
                String checkSql = "SELECT * FROM users WHERE username = ?";
                try (PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
                    checkPs.setString(1, username);
                    ResultSet rs = checkPs.executeQuery();
                    if (rs.next()) {
                        request.setAttribute("error", "このユーザー名は既に存在します");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                        return;
                    }
                }

                // 2. 新しいユーザーを登録
                String insertSql = "INSERT INTO users (username, \"password\") VALUES (?, ?)";
                try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                    insertPs.setString(1, username);
                    insertPs.setString(2, password); // パスワードをそのまま保存
                    insertPs.executeUpdate();
                }

                // 登録成功したらログインページへリダイレクト
                response.sendRedirect(request.getContextPath() + "/photo/login.jsp?registered=true");

            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "処理中にエラーが発生しました");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}