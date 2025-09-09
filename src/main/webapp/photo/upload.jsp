<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String lang = (String) session.getAttribute("language");
    if (lang == null) lang = "ja";

    String titleText = "写真アップロード";
    String fileLabel = "写真を選択";
    String titleLabel = "タイトル";
    String visibilityLabel = "公開範囲";
    String publicText = "公開";
    String privateText = "非公開";
    String uploadButton = "アップロード";
    String backHome = "ホームに戻る";

    if ("en".equals(lang)) {
        titleText = "Upload Photo";
        fileLabel = "Choose a File";
        titleLabel = "Title";
        visibilityLabel = "Visibility";
        publicText = "Public";
        privateText = "Private";
        uploadButton = "Upload";
        backHome = "Back to Home";
    }
%>

<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <title><%= titleText %></title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <h1><%= titleText %></h1>

<form method="post" action="<%= request.getContextPath() %>/photo/PhotoUploadServlet" enctype="multipart/form-data">

        <p>
            <label for="file"><%= fileLabel %></label>
            <input type="file" name="file" id="file" required>
        </p>

        <p>
            <label for="title">タイトル</label>
            <input type="text" name="title" id="title" required>
        </p>

        <p>
            <label for="visibility"><%= visibilityLabel %></label>
            <select name="visibility" id="visibility">
                <option value="public"><%= publicText %></option>
                <option value="private"><%= privateText %></option>
            </select>
        </p>

        <div class="button-group">
            <input type="submit" value="<%= uploadButton %>" class="button">
            <a href="photo_home.jsp" class="button secondary"><%= backHome %></a>
        </div>
    </form>
</div>
</body>
</html>
