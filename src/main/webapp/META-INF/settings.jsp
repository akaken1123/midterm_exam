<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>設定画面</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h1>アプリ設定</h1>

    <%-- 成功メッセージ --%>
    <%
        String success = request.getParameter("success");
        if ("true".equals(success)) {
    %>
        <div class="success-message">設定を保存しました！</div>
    <%
        }
    %>

    <form action="saveSettings" method="post">
        <p>
            <label for="language">言語(Language):</label>
            <select name="language" id="language">
                <option value="ja" <%= "ja".equals(session.getAttribute("language")) ? "selected" : "" %>>日本語</option>
                <option value="en" <%= "en".equals(session.getAttribute("language")) ? "selected" : "" %>>English</option>
            </select>
        </p>

        <p>
            <label for="notifyEmail">通知メールアドレス(Notification Email):</label>
            <input type="email" name="notifyEmail" id="notifyEmail"
                   value="<%= session.getAttribute("notifyEmail") != null ? session.getAttribute("notifyEmail") : "" %>" required>
        </p>

        <div class="button-group">
            <input type="submit" value="保存">
        </div>
    </form>
</div>
</body>
</html>
