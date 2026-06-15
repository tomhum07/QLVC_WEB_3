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

// TẦNG CONTROLLER: Điều phối các yêu cầu liên quan đến User (Đăng nhập, đăng xuất)
@WebServlet(name = "C_UserServlet", value = {"/login-controller", "/login"})
public class C_UserServlet extends HttpServlet {

    private M_UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new M_UserDAO();
    }

    // Xử lý phương thức GET (Khi người dùng click vào link truy cập trang đăng nhập hoặc chọn đăng xuất)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Trường hợp người dùng chọn Đăng xuất (action=logout)
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                // Hủy toàn bộ session hiện tại để đảm bảo an toàn và xóa sạch dữ liệu đăng nhập
                session.invalidate();
            }
            // Quay về trang chủ /home có kèm theo Context Path để tránh lỗi đường dẫn
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy tham số trang đích cần quay lại sau khi đăng nhập (ví dụ: redirect=quanly)
        String redirect = request.getParameter("redirect");
        // Đính kèm tham số này vào request để trang JSP lấy ra lưu vào form
        request.setAttribute("redirect", redirect);

        // Chuyển tiếp (forward) nội bộ sang tệp JSP đăng nhập trực tiếp
        request.getRequestDispatcher("/WEB-INF/views/V_Login.jsp").forward(request, response);
    }

    // Xử lý phương thức POST (Khi người dùng gửi thông tin từ form đăng nhập lên)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin tài khoản và mật khẩu từ request parameters
        String userParam = request.getParameter("username");
        String passParam = request.getParameter("password");
        
        // Lấy thông tin trang đích cần quay lại (từ trường hidden trong form)
        String redirect = request.getParameter("redirect");

        // Gọi tầng Model (M_UserDAO) để kiểm tra đăng nhập
        M_User user = userDAO.checkLogin(userParam, passParam);

        if (user != null) {
            // Đăng nhập thành công:
            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", user); // Lưu Session
            
            // KIỂM TRA ĐIỀU HƯỚNG QUAY LẠI TRANG CŨ:
            // Nếu có trang đích cần quay lại (redirect không rỗng), chuyển hướng về trang đó
            if (redirect != null && !redirect.trim().isEmpty()) {
                // Đảm bảo đường dẫn redirect có chứa Context Path của ứng dụng để chạy chính xác
                if (!redirect.startsWith(request.getContextPath()) && !redirect.startsWith("http")) {
                    response.sendRedirect(request.getContextPath() + "/" + redirect);
                } else {
                    response.sendRedirect(redirect);
                }
            } else {
                // Ngược lại, mặc định quay lại trang chủ /home kèm Context Path
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            // Đăng nhập thất bại:
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            // Giữ lại tham số redirect để form tiếp tục lưu trữ nếu người dùng thử lại
            request.setAttribute("redirect", redirect);
            // Forward về View V_Login.jsp
            request.getRequestDispatcher("/WEB-INF/views/V_Login.jsp").forward(request, response);
        }
    }
}
