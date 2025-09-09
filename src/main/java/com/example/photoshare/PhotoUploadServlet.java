package com.example.photoshare;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/photo/PhotoUploadServlet")
@MultipartConfig(fileSizeThreshold = 1024*1024*2, maxFileSize = 1024*1024*10, maxRequestSize = 1024*1024*50)
public class PhotoUploadServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";
    private final PhotoDAO dao = new PhotoDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String visibility = request.getParameter("visibility");
        String title = request.getParameter("title");

        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = new File(filePart.getSubmittedFileName()).getName();
            String appPath = request.getServletContext().getRealPath("");
            String savePath = appPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(savePath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(savePath + File.separator + fileName);

            Photo photo = new Photo(fileName, username, new Date(), visibility, title);
            dao.insertPhoto(photo);
        }

        response.sendRedirect("photo_home.jsp");
    }
}
