package com.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Điều hướng từ đường dẫn cũ /KeHoach (chữ hoa) sang đường dẫn chuẩn mới /kehoach (chữ thường)
 */
@WebServlet(name = "C_KeHoach", value = "/KeHoach")
public class C_KeHoach extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/kehoach");
    }
}
