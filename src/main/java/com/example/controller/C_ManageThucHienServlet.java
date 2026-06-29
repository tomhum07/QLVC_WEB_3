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

// TẦNG CONTROLLER: Dành riêng cho Admin quản lý kết quả Thực Hiện của Viên Chức
@WebServlet(name = "C_ManageThucHienServlet", value = "/quanlythuchien")
public class C_ManageThucHienServlet extends HttpServlet {
    private M_PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new M_PlanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        // BẢO MẬT: Bắt buộc đăng nhập và phải có quyền Admin/Trưởng đơn vị
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=quanlythuchien");
            return;
        }

        if (!"1".equals(user.getQuyen()) && !"2".equals(user.getQuyen())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy danh sách tất cả Viên Chức
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

        request.getRequestDispatcher("/WEB-INF/views/V_ManageThucHien.jsp").forward(request, response);
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

        if ("updateThucHienByAdmin".equals(action)) {
            String mskhvc = request.getParameter("mskhvc");
            String muc = request.getParameter("muc");
            String thoigianth = request.getParameter("thoigianth");
            String sanphamth = request.getParameter("sanphamth");
            String minhchung = request.getParameter("minhchung");
            String donvixacnhan = request.getParameter("donvixacnhan") != null ? "1" : "0";

            M_KeHoachDetail detail = new M_KeHoachDetail();
            detail.setMskhvc(mskhvc);
            detail.setMuc(muc);
            detail.setThoigianth(thoigianth);
            detail.setSanphamth(sanphamth);
            detail.setMinhchung(minhchung);
            detail.setDonvixacnhan(donvixacnhan);

            planDAO.updateThucHienDetailByAdmin(detail);
        }

        // Quay lại trang quản lý thực hiện với bộ lọc hiện tại
        response.sendRedirect(request.getContextPath() + "/quanlythuchien?msvc=" + msvc + "&namhoc=" + response.encodeURL(namhoc));
    }
}
