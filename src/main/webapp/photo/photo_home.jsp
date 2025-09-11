<%@ page import="java.util.ArrayList, java.util.List, java.sql.*, com.example.photoshare.Photo" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    String lang = (String) session.getAttribute("language");
    if (lang == null) lang = "ja";

    String titleText = "PhotoShare";
    String uploadText = "アップロード";
    String settingsText = "設定";
    String logoutText = "ログアウト";
    String contactText = "お問い合わせ";
    String galleryTitle = "ギャラリー";
    String ownerText = "所有者";
    String visibilityText = "公開設定";
    String loginPrompt = "閲覧するにはログインしてください";

    if ("en".equals(lang)) {
        uploadText = "Upload";
        settingsText = "Settings";
        logoutText = "Logout";
        contactText = "Contact";
        galleryTitle = "Gallery";
        ownerText = "Owner";
        visibilityText = "Visibility";
        loginPrompt = "Please log in to view";
    }

    List<Photo> photoList = new ArrayList<>();
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/photos", "username", "password");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT filename, uploader, is_public, title, upload_date FROM photos");

        while(rs.next()){
            String fileName = rs.getString("filename");
            String user = rs.getString("uploader");
            boolean isPublic = rs.getBoolean("is_public");
            String title = rs.getString("title");

            // ここで java.util.Date に変換
            java.util.Date uploadDate = new java.util.Date(rs.getTimestamp("upload_date").getTime());

            photoList.add(new Photo(fileName, user, uploadDate, isPublic ? "public" : "private", title));
        }

        rs.close(); stmt.close(); conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <title><%= titleText %></title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <h1><%= titleText %></h1>
    <div class="button-group">
        <a href="upload.jsp" class="button"><%= uploadText %></a>
        <a href="settings.jsp" class="button secondary"><%= settingsText %></a>
        <% if (username != null) { %>
            <a href="login.jsp?logout=true" class="button secondary"><%= logoutText %></a>
        <% } else { %>
            <a href="login.jsp" class="button secondary"><%= logoutText %></a>
        <% } %>
        <a href="../index.jsp" class="button secondary"><%= contactText %></a>
    </div>

    <div class="gallery" style="margin-top: 30px;">
        <h2><%= galleryTitle %></h2>
        <% if(username == null){ %>
            <p style="color:red;"><%= loginPrompt %></p>
        <% } %>

        <%
            for(Photo p : photoList){
                boolean canView = "public".equals(p.getVisibility()) || (username != null && username.equals(p.getUser()));
                if(canView){
        %>
            <div class="photo-item" style="margin-bottom:20px;">
                <img src="uploads/<%= p.getFileName() %>" alt="<%= p.getTitle() %>" style="max-width:100%; border-radius:6px; border:1px solid #ccc;">
                <p><strong><%= p.getTitle() %></strong></p>
                <p><%= ownerText %>: <%= p.getUser() %></p>
                <p><%= visibilityText %>: <%= p.getVisibility() %></p>
            </div>
        <% } } %>
    </div>
</div>
</body>
</html>
