package com.example.photoshare;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PhotoDAO {
    private final String url = "jdbc:postgresql://localhost:5432/yourdb";
    private final String user = "youruser";
    private final String pass = "yourpassword";

    public PhotoDAO() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void insertPhoto(Photo photo) {
        String sql = "INSERT INTO photos(file_name, username, upload_date, visibility, title) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, photo.getFileName());
            ps.setString(2, photo.getUser());
            ps.setTimestamp(3, new Timestamp(photo.getUploadDate().getTime()));
            ps.setString(4, photo.getVisibility());
            ps.setString(5, photo.getTitle());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Photo> getPhotosForUser(String username) {
        List<Photo> list = new ArrayList<>();
        String sql = "SELECT * FROM photos WHERE visibility='public' OR username=?";
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Photo p = new Photo(
                        rs.getString("file_name"),
                        rs.getString("username"),
                        rs.getTimestamp("upload_date"),
                        rs.getString("visibility"),
                        rs.getString("title")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
