package com.example.controller;

import com.example.model.M_User;
import com.example.model.M_VienChuc;
import com.example.model.M_KeHoachHeader;
import com.example.model.M_KeHoachDetail;
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

@WebServlet(name = "C_ManageKetQuaServlet", value = "/quanlyketqua")
public class C_ManageKetQuaServlet extends HttpServlet {
    private M_PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new M_PlanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        // Bảo mật: Yêu cầu đăng nhập và có quyền quản trị/trưởng đơn vị
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=quanlyketqua");
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
        M_Bcdvc evaluation = null;

        if (selectedMsvc != null) {
            targetVC = planDAO.getVienChucByMsvc(selectedMsvc);
            header = planDAO.getKeHoachHeader(selectedMsvc, namhoc);
            if (header != null) {
                details = planDAO.getKeHoachDetails(header.getMskhvc());
            }
            evaluation = planDAO.getOrCreateEvaluation(selectedMsvc, namhoc);
        }

        // Truyền dữ liệu sang JSP
        request.setAttribute("listVienChuc", listVC);
        request.setAttribute("listNamHoc", listNamHoc);
        request.setAttribute("selectedMsvc", selectedMsvc);
        request.setAttribute("selectedNamHoc", namhoc);
        request.setAttribute("targetVC", targetVC);
        request.setAttribute("planHeader", header);
        request.setAttribute("planDetails", details);
        request.setAttribute("evaluation", evaluation);

        request.getRequestDispatcher("/WEB-INF/views/V_ManageKetQua.jsp").forward(request, response);
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
        String msvc = request.getParameter("msvc");
        String namhoc = request.getParameter("namhoc");
        String capthamquyenxeploai = request.getParameter("capthamquyenxeploai");
        String nhanxetctq = request.getParameter("nhanxetctq");
        String duyet = request.getParameter("duyet") != null ? "1" : "0";

        M_Bcdvc bcd = planDAO.getEvaluation(msvc, namhoc);
        if (bcd == null) {
            bcd = planDAO.getOrCreateEvaluation(msvc, namhoc);
        }

        if (bcd != null) {
            bcd.setCapthamquyenxeploai(capthamquyenxeploai);
            bcd.setNhanxetctq(nhanxetctq);
            bcd.setDuyet(duyet);
            planDAO.saveBcdvc(bcd);
        }

        // Cập nhật đánh giá chi tiết cho từng dòng kế hoạch
        M_KeHoachHeader header = planDAO.getKeHoachHeader(msvc, namhoc);
        if (header != null) {
            List<M_KeHoachDetail> details = planDAO.getKeHoachDetails(header.getMskhvc());
            if (details != null) {
                for (M_KeHoachDetail d : details) {
                    String rating = request.getParameter("danhgia_" + d.getMuc());
                    if (rating != null) {
                        planDAO.updateKeHoachDetailDanhGia(header.getMskhvc(), d.getMuc(), rating.trim());
                    }
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/quanlyketqua?msvc=" + msvc + "&namhoc=" + response.encodeURL(namhoc) + "&success=1");
    }
}
