<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String lang = (String) session.getAttribute("language");
    if (lang == null) {
        lang = "ja"; // デフォルトは日本語
    }

    String pageTitle = "新規登録";
    String h1Title = "新規登録";
    String usernameLabel = "ユーザー名";
    String passwordLabel = "パスワード";
    String confirmPasswordLabel = "パスワード（確認）";
    String submitButtonValue = "登録";
    String backToLoginText = "ログイン画面に戻る";
    
    // エラーメッセージの文字列
    String error = (String) request.getAttribute("error");
    
    if ("en".equals(lang)) {
        pageTitle = "Register";
        h1Title = "Register";
        usernameLabel = "Username";
        passwordLabel = "Password";
        confirmPasswordLabel = "Confirm Password";
        submitButtonValue = "Register";
        backToLoginText = "Back to Login";
    }
%>
<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="container">
    <h1><%= h1Title %></h1>

    <% if (error != null) { %>
        <p style="color:red;"><%= error %></p>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/photo/RegisterServlet">
    <p>
        <label for="username"><%= usernameLabel %></label>
        <input type="text" name="username" id="username" required>
    </p>
    <p>
        <label for="password"><%= passwordLabel %></label>
        <input type="password" name="password" id="password" required>
    </p>
    <p>
        <label for="confirmPassword"><%= confirmPasswordLabel %></label>
        <input type="password" name="confirmPassword" id="confirmPassword" required>
    </p>
    <p>
        <input type="submit" value="<%= submitButtonValue %>" class="button">
    </p>
    </form>
    <p class="link-to-home">
        <a href="<%= request.getContextPath() %>/photo/login.jsp"><%= backToLoginText %></a>
    </p>
</div>
</body>
</html>