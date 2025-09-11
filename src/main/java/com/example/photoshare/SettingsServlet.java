package com.example.photoshare;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SettingsServlet")
public class SettingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String lang = request.getParameter("lang");
        HttpSession session = request.getSession();
        if (lang != null) {
            session.setAttribute("language", lang);
        }

        // 設定画面に戻る
        response.sendRedirect(request.getContextPath() + "/photo/settings.jsp");
    }
}
