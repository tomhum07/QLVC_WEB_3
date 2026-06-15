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

// TẦNG CONTROLLER: Dành riêng cho Admin quản lý Kế hoạch của tất cả Viên Chức
@WebServlet(name = "C_ManagePlanServlet", value = "/quanlykehoach")
public class C_ManagePlanServlet extends HttpServlet {
    private M_PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new M_PlanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        // BẢO MẬT: Bắt buộc đăng nhập và phải có quyền Admin (quyen = 1 hoặc 2)
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=quanlykehoach");
            return;
        }

        if (!"1".equals(user.getQuyen()) && !"2".equals(user.getQuyen())) {
            // Không có quyền, quay về home
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy danh sách tất cả Viên Chức để admin chọn
        List<M_VienChuc> listVC = planDAO.getAllVienChuc();

        // Lấy mã viên chức được chọn
        String selectedMsvc = request.getParameter("msvc");
        if ((selectedMsvc == null || selectedMsvc.trim().isEmpty()) && !listVC.isEmpty()) {
            selectedMsvc = listVC.get(0).getMsvc();
        }

        // Lấy danh sách các đợt lập kế hoạch (Năm học)
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

        M_VienChuc targetVC = null;
        M_KeHoachHeader header = null;
        List<M_KeHoachDetail> details = null;

        if (selectedMsvc != null) {
            targetVC = planDAO.getVienChucByMsvc(selectedMsvc);
            header = planDAO.getKeHoachHeader(selectedMsvc, namhoc);
            if (header != null) {
                details = planDAO.getKeHoachDetails(header.getMskhvc());
            }
        }

        // Truyền dữ liệu sang JSP
        request.setAttribute("listVienChuc", listVC);
        request.setAttribute("listNamHoc", listNamHoc);
        request.setAttribute("selectedMsvc", selectedMsvc);
        request.setAttribute("selectedNamHoc", namhoc);
        request.setAttribute("targetVC", targetVC);
        request.setAttribute("planHeader", header);
        request.setAttribute("planDetails", details);

        request.getRequestDispatcher("/WEB-INF/views/V_ManagePlan.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        if (session == null || user == null || (!"1".equals(user.getQuyen()) && !"2".equals(user.getQuyen()))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String msvc = request.getParameter("msvc");
        String namhoc = request.getParameter("namhoc");

        if ("approve".equals(action)) {
            // Duyệt và xếp loại kế hoạch
            String mskhvc = request.getParameter("mskhvc");
            String danhhieu = request.getParameter("danhhieu");
            String khenthuong = request.getParameter("khenthuong");
            String xacnhan = request.getParameter("xacnhan") != null ? "1" : "0";
            String duyet = request.getParameter("duyet") != null ? "1" : "0";

            M_KeHoachHeader header = new M_KeHoachHeader(mskhvc, msvc, null, namhoc, danhhieu, khenthuong, xacnhan, duyet);
            planDAO.updateKeHoachHeader(header);
        } 
        else if ("addTemplate".equals(action)) {
            // Admin thêm công việc mới vào danh mục mẫu (Template)
            String muc = request.getParameter("muc");
            String congviec = request.getParameter("congviec");
            if (muc != null && congviec != null && !muc.trim().isEmpty() && !congviec.trim().isEmpty()) {
                planDAO.addTemplateWorkItem(muc, congviec);
            }
        }
        else if ("update".equals(action)) {
            // Admin sửa đổi trực tiếp chi tiết công việc trong kế hoạch của viên chức
            String mskhvc = request.getParameter("mskhvc");
            String muc = request.getParameter("muc");
            String congviec = request.getParameter("congviec");
            String kehoachthuchien = request.getParameter("kehoachthuchien");
            String chitieu = request.getParameter("chitieu");
            String thoigiankh = request.getParameter("thoigiankh");
            String sanphamkh = request.getParameter("sanphamkh");
            String ghichu = request.getParameter("ghichu");
            String kiemtra = request.getParameter("kiemtra") != null ? "1" : "0";

            M_KeHoachDetail detail = new M_KeHoachDetail(mskhvc, muc, congviec, kehoachthuchien, chitieu, thoigiankh, sanphamkh, ghichu, kiemtra);
            planDAO.updateKeHoachDetail(detail);
        }
        else if ("insert".equals(action)) {
            // Admin chèn thêm công việc cho viên chức
            String mskhvc = request.getParameter("mskhvc");
            String muc = request.getParameter("muc");
            String congviec = request.getParameter("congviec");
            String kehoachthuchien = request.getParameter("kehoachthuchien");
            String chitieu = request.getParameter("chitieu");
            String thoigiankh = request.getParameter("thoigiankh");
            String sanphamkh = request.getParameter("sanphamkh");
            String ghichu = request.getParameter("ghichu");
            String kiemtra = request.getParameter("kiemtra") != null ? "1" : "0";

            M_KeHoachDetail detail = new M_KeHoachDetail(mskhvc, muc, congviec, kehoachthuchien, chitieu, thoigiankh, sanphamkh, ghichu, kiemtra);
            planDAO.insertKeHoachDetail(detail);
        }
        else if ("delete".equals(action)) {
            // Admin xóa công việc khỏi kế hoạch của viên chức
            String mskhvc = request.getParameter("mskhvc");
            String muc = request.getParameter("muc");
            planDAO.deleteKeHoachDetail(mskhvc, muc);
        }
        else if ("addPeriod".equals(action)) {
            // Admin thêm đợt lập kế hoạch mới
            String newNamHoc = request.getParameter("newNamHoc");
            if (newNamHoc != null && !newNamHoc.trim().isEmpty()) {
                planDAO.addNamHoc(newNamHoc.trim());
                namhoc = newNamHoc.trim(); // Chuyển hướng xem đợt mới luôn
            }
        }

        // Quay lại trang quản lý với các bộ lọc msvc và namhoc hiện tại
        response.sendRedirect(request.getContextPath() + "/quanlykehoach?msvc=" + msvc + "&namhoc=" + response.encodeURL(namhoc));
    }
}
