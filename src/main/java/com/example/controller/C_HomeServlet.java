package com.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// TẦNG CONTROLLER: Xử lý hiển thị trang chủ của ứng dụng
@WebServlet(name = "C_HomeServlet", value = "/home")
public class C_HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng nội bộ (Forward) sang file View V_Home.jsp nằm trong thư mục bảo mật WEB-INF.
        // Việc dùng forward giúp URL trên thanh địa chỉ của trình duyệt vẫn giữ nguyên là /home,
        // đồng thời bảo vệ tệp JSP khỏi việc truy cập trực tiếp từ người dùng.
        request.getRequestDispatcher("/WEB-INF/views/V_Home.jsp").forward(request, response);
    }
}
