package com.example.controller;

import com.example.model.M_User;
import com.example.model.M_UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

// TẦNG CONTROLLER: Xử lý hiển thị trang quản lý (yêu cầu phải đăng nhập)
@WebServlet(name = "C_ManageServlet", value = "/quanly")
public class C_ManageServlet extends HttpServlet {
    private M_UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new M_UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        // KIỂM TRA PHÂN QUYỀN / BẢO MẬT (Access Control):
        // Nếu người dùng chưa đăng nhập, redirect thẳng đến trang đăng nhập kèm trang cần quay lại (redirect=quanly)
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=quanly");
            return;
        }

        // Truy xuất danh sách người dùng từ CSDL MySQL
        List<M_User> userList = userDAO.getAllUsers();
        request.setAttribute("userList", userList);

        // Nếu đã đăng nhập thành công, cho phép truy cập và forward sang View quản lý
        request.getRequestDispatcher("/WEB-INF/views/V_Manage.jsp").forward(request, response);
    }
}
