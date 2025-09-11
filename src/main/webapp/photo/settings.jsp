<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String lang = (String) session.getAttribute("language");
    if (lang == null) lang = "ja";

    String settingsTitle = "設定画面";
    String langLabel = "表示言語";
    String saveButton = "保存";
    String homeButton = "ホームに戻る";

    if ("en".equals(lang)) {
        settingsTitle = "Settings";
        langLabel = "Language";
        saveButton = "Save";
        homeButton = "Back to Home";
    }
%>
<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <title><%= settingsTitle %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="container">
    <h1><%= settingsTitle %></h1>

    <form method="post" action="<%= request.getContextPath() %>/SettingsServlet">
        <p>
            <label for="lang"><%= langLabel %></label>
            <select name="lang" id="lang">
                <option value="ja" <%= "ja".equals(lang) ? "selected" : "" %>>日本語</option>
                <option value="en" <%= "en".equals(lang) ? "selected" : "" %>>English</option>
            </select>
        </p>

        <div class="button-group">
            <input type="submit" value="<%= saveButton %>" class="button">
            <a href="<%= request.getContextPath() %>/photo/photo_home.jsp" class="button secondary"><%= homeButton %></a>
        </div>
    </form>
</div>
</body>
</html>
