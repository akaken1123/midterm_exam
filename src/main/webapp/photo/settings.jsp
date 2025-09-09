<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String lang = (String) session.getAttribute("language");
    if (lang == null) lang = "ja";

    String settingsTitle = "設定画面";
    String langLabel = "表示言語";
    String emailLabel = "通知用メールアドレス";
    String adminLabel = "管理者パスワード";
    String saveButton = "保存";
    String homeButton = "ホームに戻る";
    String loginButton = "ログイン";

    if ("en".equals(lang)) {
        settingsTitle = "Settings";
        langLabel = "Language";
        emailLabel = "Notification Email";
        adminLabel = "Admin Password";
        saveButton = "Save";
        homeButton = "Back to Home";
        loginButton = "Login";
    }
%>
<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <title><%= settingsTitle %></title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <h1><%= settingsTitle %></h1>

    <form method="post" action="../LoginServlet">
        <p>
            <label for="lang"><%= langLabel %></label>
            <select name="lang" id="lang">
                <option value="ja" <%= "ja".equals(lang) ? "selected" : "" %>>日本語</option>
                <option value="en" <%= "en".equals(lang) ? "selected" : "" %>>English</option>
            </select>
        </p>

        <p>
            <label for="notifyEmail"><%= emailLabel %></label>
            <input type="email" name="notifyEmail" id="notifyEmail"
                   value="<%= session.getAttribute("notifyEmail") != null ? session.getAttribute("notifyEmail") : "" %>">
        </p>

        <p>
            <label for="adminPass"><%= adminLabel %></label>
            <input type="password" name="adminPass" id="adminPass">
        </p>

        <div class="button-group">
            <input type="submit" value="<%= saveButton %>" class="button">
            <a href="photo_home.jsp" class="button secondary"><%= homeButton %></a>
            <a href="login.jsp" class="button secondary"><%= loginButton %></a>
        </div>
    </form>
</div>
</body>
</html>
