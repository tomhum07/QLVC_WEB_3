package com.example.controller;

import com.example.model.M_User;
import com.example.model.M_VienChuc;
import com.example.model.M_KeHoachHeader;
import com.example.model.M_KeHoachDetail;
import com.example.model.M_PlanDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

// TẦNG CONTROLLER: Xử lý các yêu cầu liên quan đến Kế Hoạch của Viên Chức
@WebServlet(name = "C_PlanServlet", value = "/kehoach")
public class C_PlanServlet extends HttpServlet {
    private M_PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new M_PlanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        // BẢO MẬT: Nếu chưa đăng nhập, bắt buộc quay lại trang login
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=kehoach");
            return;
        }

        // Lấy thông tin chi tiết viên chức
        M_VienChuc vc = planDAO.getVienChucByUsername(user.getUsername());
        if (vc == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy danh sách các đợt lập kế hoạch (Năm học)
        List<String> listNamHoc = planDAO.getAllNamHoc();

        // Lấy năm học cần xem
        String namhoc = request.getParameter("namhoc");
        if (namhoc == null || namhoc.trim().isEmpty()) {
            if (listNamHoc != null && !listNamHoc.isEmpty()) {
                namhoc = listNamHoc.get(0);
            } else {
                namhoc = "2025-2026/HK1";
            }
        }

        // Lấy Header kế hoạch của năm học
        M_KeHoachHeader header = planDAO.getKeHoachHeader(vc.getMsvc(), namhoc);
        List<M_KeHoachDetail> details = null;
        if (header != null) {
            details = planDAO.getKeHoachDetails(header.getMskhvc());
        }

        // Đính kèm dữ liệu chuyển tiếp sang View
        request.setAttribute("vienchuc", vc);
        request.setAttribute("listNamHoc", listNamHoc);
        request.setAttribute("selectedNamHoc", namhoc);
        request.setAttribute("planHeader", header);
        request.setAttribute("planDetails", details);

        request.getRequestDispatcher("/WEB-INF/views/V_Plan.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String msvc = request.getParameter("msvc");
        String namhoc = request.getParameter("namhoc");

        if ("initialize".equals(action)) {
            // Khởi tạo kế hoạch mới bằng cách sao chép từ mẫu
            planDAO.initializeKeHoach(msvc, namhoc);
        } 
        else if ("update".equals(action)) {
            // Cập nhật một dòng kế hoạch
            String mskhvc = request.getParameter("mskhvc");
            String muc = request.getParameter("muc");
            String congviec = request.getParameter("congviec");
            String kehoachthuchien = request.getParameter("kehoachthuchien");
            String chitieu = request.getParameter("chitieu");
            String thoigiankh = request.getParameter("thoigiankh");
            String sanphamkh = request.getParameter("sanphamkh");
            String ghichu = request.getParameter("ghichu");
            String kiemtra = request.getParameter("kiemtra"); // checkbox
            if (kiemtra == null) {
                kiemtra = "0";
            }

            M_KeHoachDetail detail = new M_KeHoachDetail(mskhvc, muc, congviec, kehoachthuchien, chitieu, thoigiankh, sanphamkh, ghichu, kiemtra);
            planDAO.updateKeHoachDetail(detail);
        } 
        else if ("insert".equals(action)) {
            // Chèn thêm công việc mới vào kế hoạch
            String mskhvc = request.getParameter("mskhvc");
            String muc = request.getParameter("muc");
            String congviec = request.getParameter("congviec");
            String kehoachthuchien = request.getParameter("kehoachthuchien");
            String chitieu = request.getParameter("chitieu");
            String thoigiankh = request.getParameter("thoigiankh");
            String sanphamkh = request.getParameter("sanphamkh");
            String ghichu = request.getParameter("ghichu");
            String kiemtra = request.getParameter("kiemtra");
            if (kiemtra == null) {
                kiemtra = "0";
            }

            M_KeHoachDetail detail = new M_KeHoachDetail(mskhvc, muc, congviec, kehoachthuchien, chitieu, thoigiankh, sanphamkh, ghichu, kiemtra);
            planDAO.insertKeHoachDetail(detail);
        } 
        else if ("delete".equals(action)) {
            // Xóa một dòng công việc khỏi kế hoạch
            String mskhvc = request.getParameter("mskhvc");
            String muc = request.getParameter("muc");
            planDAO.deleteKeHoachDetail(mskhvc, muc);
        }
        else if ("registerDanhHieu".equals(action)) {
            String mskhvc = request.getParameter("mskhvc");
            String danhhieu = request.getParameter("danhhieu");
            String khenthuong = request.getParameter("khenthuong");
            planDAO.registerDanhHieu(mskhvc, danhhieu, khenthuong);
        }

        // Quay lại trang kế hoạch với năm học hiện tại
        response.sendRedirect(request.getContextPath() + "/kehoach?namhoc=" + response.encodeURL(namhoc));
    }
}
