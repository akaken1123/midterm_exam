<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ログイン</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h1>ログイン</h1>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <p style="color:red;"><%= error %></p>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/photo/LoginServlet">
    <p>
        <label for="username">ユーザー名</label>
        <input type="text" name="username" id="username" required>
    </p>
    <p>
        <label for="password">パスワード</label>
        <input type="password" name="password" id="password" required>
    </p>
    <div class="button-group">
        <input type="submit" value="ログイン" class="button">
        <a href="photo_home.jsp" class="button secondary">ホームに戻る</a>
    </div>
</form>

</div>
</body>
</html>
