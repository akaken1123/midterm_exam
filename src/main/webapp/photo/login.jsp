<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // セッションから言語設定を取得
    String lang = (String) session.getAttribute("language");
    if (lang == null) {
        lang = "ja"; // デフォルトは日本語
    }

    // ログアウト処理のチェック
    if (request.getParameter("logout") != null) {
        session.invalidate(); // セッションを無効化
        response.sendRedirect(request.getContextPath() + "/photo/photo_home.jsp"); // ホームへリダイレクト
        return; // これ以上処理を行わない
    }

    // 言語によって表示テキストを切り替える
    String pageTitle = "ログイン";
    String h1Title = "ログイン";
    String usernameLabel = "ユーザー名";
    String passwordLabel = "パスワード";
    String submitButtonValue = "ログイン";
    String backToHomeText = "ホームに戻る";

    // エラーメッセージの文字列
    String error = (String) request.getAttribute("error");
    if (error != null) {
        if ("en".equals(lang)) {
            // エラーメッセージを英語に変換するロジック（必要に応じて）
            // 例: if (error.equals("ログインに失敗しました")) { error = "Login failed."; }
        }
    }

    if ("en".equals(lang)) {
        pageTitle = "Login";
        h1Title = "Login";
        usernameLabel = "Username";
        passwordLabel = "Password";
        submitButtonValue = "Login";
        backToHomeText = "Back to Home";
    }
%>
<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="../style.css"> </head>
</head>
<body>
<div class="container">
    <h1><%= h1Title %></h1>

    <% if (error != null) { %>
        <p style="color:red;"><%= error %></p>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/photo/LoginServlet">
    <p>
        <label for="username"><%= usernameLabel %></label>
        <input type="text" name="username" id="username" required>
    </p>
    <p>
        <label for="password"><%= passwordLabel %></label>
        <input type="password" name="password" id="password" required>
    </p>
    <p>
        <input type="submit" value="<%= submitButtonValue %>" class="button">
        <a href="register.jsp" class="button secondary">新規登録</a>
        <a href="photo_home.jsp" class="button secondary"><%= backToHomeText %></a>
    </p>
    </form>
</div>
</body>
</html>