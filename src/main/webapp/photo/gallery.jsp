<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.photoshare.Photo" %>
<%@ page import="com.example.photoshare.PhotoDAO" %>
<%
    // DAOから公開写真を取得
    PhotoDAO dao = new PhotoDAO();
    List<Photo> publicPhotos = dao.getPublicPhotos();

    // ログインユーザー（仮）
    String currentUser = (String) session.getAttribute("username");
    List<Photo> privatePhotos = null;

    if (currentUser != null) {
        privatePhotos = dao.getUserPrivatePhotos(currentUser);
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>公開ギャラリー</title>
    <link rel="stylesheet" href="../style.css">
    <style>
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .photo-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 10px;
            text-align: center;
        }
        .photo-card img {
            max-width: 100%;
            border-radius: 6px;
        }
        .photo-card p {
            margin: 8px 0 0;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>公開ギャラリー</h1>

    <!-- 公開写真 -->
    <h2>公開写真</h2>
    <div class="gallery">
        <%
            if (publicPhotos != null && !publicPhotos.isEmpty()) {
                for (Photo photo : publicPhotos) {
        %>
            <div class="photo-card">
                <img src="../uploads/<%= photo.getFileName() %>" 
                     alt="<%= photo.getTitle() %>">
                <p><strong><%= photo.getTitle() %></strong></p>
                <p>投稿者: <%= photo.getUser() %></p>
            </div>
        <%
                }
            } else {
        %>
            <p>公開写真はまだありません。</p>
        <%
            }
        %>
    </div>

    <!-- 非公開写真（ログインユーザーのみ） -->
    <%
        if (currentUser != null && privatePhotos != null && !privatePhotos.isEmpty()) {
    %>
    <h2>あなたの非公開写真</h2>
    <div class="gallery">
        <%
            for (Photo photo : privatePhotos) {
        %>
            <div class="photo-card">
                <img src="../uploads/<%= photo.getFileName() %>" 
                     alt="<%= photo.getTitle() %>">
                <p><strong><%= photo.getTitle() %></strong></p>
            </div>
        <%
            }
        %>
    </div>
    <%
        }
    %>

    <div class="button-group">
        <a href="photo_home.jsp" class="button">ホームに戻る</a>
    </div>
</div>
</body>
</html>
