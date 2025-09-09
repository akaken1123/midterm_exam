<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.example.photoshare.Photo, com.example.photoshare.PhotoDAO" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>PhotoShare App - アップロード履歴</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <h1>アップロード履歴</h1>

    <%
        // PhotoDAOから履歴取得（サンプル）
        PhotoDAO photoDAO = new PhotoDAO();
        List<Photo> photoList = photoDAO.getAllPhotos(); // Photoクラスに fileName, uploadDate, user, visibility などを想定
    %>

    <div class="display-info">
        <% for (Photo p : photoList) { %>
            <p>
                <strong><%= p.getFileName() %></strong> -
                アップロード: <%= p.getUploadDate() %> -
                ユーザー: <%= p.getUser() %> -
                公開範囲: <%= p.getVisibility() %>
            </p>
        <% } %>
        <% if (photoList.isEmpty()) { %>
            <p>まだアップロードされた写真はありません。</p>
        <% } %>
    </div>

    <div class="button-group">
        <a href="../photo/home.jsp" class="button">ホームに戻る</a>
        <a href="../photo/upload.jsp" class="button">写真アップロード</a>
        <a href="../photo/settings.jsp" class="button">設定画面</a>
        <a href="../index.jsp" class="button">お問い合わせフォーム</a>
    </div>
</div>
</body>
</html>
