<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 15/06/26
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.M_User" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <title>Hehehe</title>
</head>
<body>
        <%
            M_User user = (M_User) session.getAttribute("currentUser");
        %>
        <h1>Hehehe</h1>
        <p>Chào mừng <strong><%= user.getFullName() %></strong> đã đăng nhập thành công vào đây!</p>
        <button class="btn btn-secondary btn-lg px-4" onclick="window.location.href='home'">
            Home
        </button>


</body>
</html>
