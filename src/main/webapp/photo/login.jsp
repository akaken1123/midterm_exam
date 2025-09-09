<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String lang = (String) session.getAttribute("language");
    if (lang == null) lang = "ja";

    String loginTitle = "ログイン";
    String usernameLabel = "ユーザー名";
    String loginButton = "ログイン";

    if ("en".equals(lang)) {
        loginTitle = "Login";
        usernameLabel = "Username";
        loginButton = "Login";
    }
%>
<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <title><%= loginTitle %></title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h1><%= loginTitle %></h1>
    <form method="post" action="LoginServlet">
        <p>
            <label for="username"><%= usernameLabel %></label>
            <input type="text" name="username" id="username" required>
        </p>
        <div class="button-group">
            <input type="submit" value="<%= loginButton %>" class="button">
            <a href="photo_home.jsp" class="button secondary">ホームに戻る</a>
        </div>
    </form>
</div>
</body>
</html>
