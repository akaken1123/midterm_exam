package com.example.photoshare;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/photo/SettingsServlet")
public class SettingsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String lang = request.getParameter("lang");
        String notifyEmail = request.getParameter("notifyEmail");
        String adminPass = request.getParameter("adminPass");

        request.getSession().setAttribute("language", lang);
        request.getSession().setAttribute("notifyEmail", notifyEmail);

        if ("admin123".equals(adminPass)) {
            request.getSession().setAttribute("isAdmin", true);
        } else {
            request.getSession().setAttribute("isAdmin", false);
        }

        response.sendRedirect(request.getContextPath() + "/photo/settings.jsp?success=true");
    }
}
