package com.example.controller;

import com.example.model.M_User;
import com.example.model.M_Bcdvc;
import com.example.model.M_PlanDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

// TẦNG CONTROLLER: Xử lý thống kê đánh giá xếp loại viên chức cho Admin / Trưởng đơn vị
@WebServlet(name = "C_ThongKeServlet", value = "/thongke")
public class C_ThongKeServlet extends HttpServlet {
    private M_PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new M_PlanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        // BẢO MẬT: Phải đăng nhập và có quyền Admin / Trưởng đơn vị (quyen = 1 hoặc 2)
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=thongke");
            return;
        }

        if (!"1".equals(user.getQuyen()) && !"2".equals(user.getQuyen())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy danh sách tất cả năm học
        List<String> listNamHoc = planDAO.getAllNamHoc();

        // Lấy năm học được chọn
        String namhoc = request.getParameter("namhoc");
        if (namhoc == null || namhoc.trim().isEmpty()) {
            if (listNamHoc != null && !listNamHoc.isEmpty()) {
                namhoc = listNamHoc.get(0);
            } else {
                namhoc = "2025-2026/HK1";
            }
        }

        // Lấy danh sách đánh giá của tất cả viên chức trong năm học
        List<M_Bcdvc> evaluations = planDAO.getAllEvaluations(namhoc);

        // Đính kèm dữ liệu chuyển tiếp sang View
        request.setAttribute("listNamHoc", listNamHoc);
        request.setAttribute("selectedNamHoc", namhoc);
        request.setAttribute("evaluations", evaluations);

        request.getRequestDispatcher("/WEB-INF/views/V_ThongKe.jsp").forward(request, response);
    }
}
