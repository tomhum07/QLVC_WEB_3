<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 15/06/26
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.M_User" %>
<html>
<head>
    <title>Kết quả thực hiện công viêc - QLVC</title>
</head>
<body>
      <div>
          <h1>Kết quả thực hiện công viêc</h1>
          <p>Xin chào, <%= ((M_User) session.getAttribute("currentUser")).getFullName() %>!</p>
          <p>Đây là trang hiển thị kết quả thực hiện công việc của bạn.</p>
          <!-- Thêm nội dung hiển thị kết quả công việc tại đây -->
      </div>


</body>
</html>
