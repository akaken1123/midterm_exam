package com.example.photoshare;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/photo/PhotoUploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class PhotoUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // アップロード先フォルダ（JSP からの相対パス）
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ログイン情報取得
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/photo/login.jsp");
            return;
        }

        // ファイル取得
        Part filePart = request.getPart("file");
        String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();

        // タイトル・公開設定取得
        String title = request.getParameter("title");
        String visibility = request.getParameter("visibility"); // "public" または "private"
        boolean isPublic = "public".equalsIgnoreCase(visibility);

        // アップロード先パス
        String uploadPath = getServletContext().getRealPath("") + File.separator + "photo" + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // ファイル保存
        filePart.write(uploadPath + File.separator + fileName);

        // DB登録
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/photos", "username", "password");
            String sql = "INSERT INTO photos (filename, uploader, is_public, title) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fileName);
            ps.setString(2, username);
            ps.setBoolean(3, isPublic);
            ps.setString(4, title);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "アップロードに失敗しました: " + e.getMessage());
            request.getRequestDispatcher("/photo/upload.jsp").forward(request, response);
            return;
        } finally {
            try { if (ps != null) ps.close(); } catch(Exception e) {}
            try { if (conn != null) conn.close(); } catch(Exception e) {}
        }

        // 成功したらホームに戻る
        response.sendRedirect(request.getContextPath() + "/photo/photo_home.jsp");
    }
}
