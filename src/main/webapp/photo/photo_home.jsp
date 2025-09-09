<%@ page import="java.util.*, com.example.photoshare.Photo" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String username = (String) session.getAttribute("username");

    // サンプル写真リスト（本来はDBから取得）
    List<Photo> photoList = new ArrayList<>();
    photoList.add(new Photo("image1.jpg", "alice", new Date(), "public", "Mountain"));
    photoList.add(new Photo("image2.jpg", "bob", new Date(), "private", "Home"));
    photoList.add(new Photo("image3.jpg", username != null ? username : "guest", new Date(), "private", "My Secret"));
%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>PhotoShare Home</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <!-- 上部 UI -->
    <h1>PhotoShare</h1>
    <div class="button-group">
        <a href="upload.jsp" class="button">アップロード</a>
        <a href="settings.jsp" class="button secondary">設定</a>
        <a href="login.jsp" class="button secondary">ログアウト</a>
        <a href="../index.jsp" class="button secondary">お問い合わせ</a>
    </div>

<!-- ギャラリー -->
<div class="gallery" style="margin-top: 30px;">
    <h2>ギャラリー</h2>
    <%
        if (username == null) {
    %>
        <p>
            閲覧するにはログインしてください。
            <a href="login.jsp" class="button secondary" style="margin-left:10px;">ログイン</a>
        </p>
    <%
        } else {
            for (Photo p : photoList) {
                boolean canView = "public".equals(p.getVisibility()) || username.equals(p.getUser());
                if (canView) {
    %>
        <div class="photo-item" style="margin-bottom:20px;">
            <img src="uploads/<%= p.getFileName() %>" alt="<%= p.getTitle() %>" style="max-width:100%; border-radius:6px; border:1px solid #ccc;">
            <p><strong><%= p.getTitle() %></strong></p>
            <p>所有者: <%= p.getUser() %></p>
            <p>公開設定: <%= p.getVisibility() %></p>
        </div>
    <%
                }
            }
        }
    %>
</div>
</div>
</body>
</html>
