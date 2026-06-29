package com.example.controller;

import com.example.model.M_User;
import com.example.model.M_VienChuc;
import com.example.model.M_KeHoachHeader;
import com.example.model.M_KeHoachDetail;
import com.example.model.M_Bcdvc;
import com.example.model.M_PlanDAO;
import com.example.model.M_ChiTietDanhGia;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

// TẦNG CONTROLLER: Admin Đánh Giá và Xếp Loại Viên Chức
@WebServlet(name = "C_ManageDanhGiaServlet", value = "/quanlydanhgia")
public class C_ManageDanhGiaServlet extends HttpServlet {
    private M_PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new M_PlanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        // BẢO MẬT: Bắt buộc đăng nhập và có quyền quản trị viên/trưởng đơn vị
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=quanlydanhgia");
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
        M_Bcdvc evaluation = null;
        List<M_ChiTietDanhGia> criteriaDetails = null;

        if (selectedMsvc != null) {
            targetVC = planDAO.getVienChucByMsvc(selectedMsvc);
            header = planDAO.getKeHoachHeader(selectedMsvc, namhoc);
            evaluation = planDAO.getOrCreateEvaluation(selectedMsvc, namhoc);
            criteriaDetails = planDAO.getChiTietDanhGiaList(evaluation.getMsbcdvc());
        }

        // Truyền dữ liệu sang JSP
        request.setAttribute("listVienChuc", listVC);
        request.setAttribute("listNamHoc", listNamHoc);
        request.setAttribute("selectedMsvc", selectedMsvc);
        request.setAttribute("selectedNamHoc", namhoc);
        request.setAttribute("targetVC", targetVC);
        request.setAttribute("planHeader", header);
        request.setAttribute("evaluation", evaluation);
        request.setAttribute("criteriaDetails", criteriaDetails);

        request.getRequestDispatcher("/WEB-INF/views/V_ManageDanhGia.jsp").forward(request, response);
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

        if ("saveEvaluation".equals(action)) {
            String msbcdvc = request.getParameter("msbcdvc");
            
            // Lặp qua 10 tiêu chí để lưu điểm của cấp thẩm quyền đánh giá
            float calculatedTotal = 0.0f;
            for (String[] def : M_PlanDAO.CRITERIA_DEFS) {
                String id = def[0];
                float maxPoint = Float.parseFloat(def[2]);
                
                float score = 0.0f;
                try {
                    String scoreStr = request.getParameter("diem_ctqdanhgia_" + id);
                    if (scoreStr != null && !scoreStr.trim().isEmpty()) {
                        score = Float.parseFloat(scoreStr);
                        if (score < 0) score = 0;
                        if (score > maxPoint) score = maxPoint;
                    }
                } catch (Exception e) {}
                
                calculatedTotal += score;
                
                M_ChiTietDanhGia item = new M_ChiTietDanhGia();
                item.setMsbcdvc(msbcdvc);
                item.setTieuchi_id(id);
                item.setDiem_ctqdanhgia(score);
                
                planDAO.updateChiTietDanhGiaCtqDanhGia(item);
            }
            
            String tuxeploai = request.getParameter("tuxeploai");
            String capthamquyenxeploai = request.getParameter("capthamquyenxeploai");
            String duyetEva = request.getParameter("duyetEvaluation") != null ? "1" : "0";
            String nhanxetctq = request.getParameter("nhanxetctq");

            M_Bcdvc bcd = new M_Bcdvc();
            bcd.setMsbcdvc(msbcdvc);
            bcd.setMsvc(msvc);
            bcd.setNamhoc(namhoc);
            bcd.setTongdiem(Math.round(calculatedTotal)); // Lưu tổng điểm làm tròn
            bcd.setTuxeploai(tuxeploai);
            bcd.setCapthamquyenxeploai(capthamquyenxeploai);
            bcd.setDuyet(duyetEva);
            bcd.setNhanxetctq(nhanxetctq);

            planDAO.saveBcdvc(bcd);
        }

        // Quay lại trang quản lý đánh giá với bộ lọc hiện tại
        response.sendRedirect(request.getContextPath() + "/quanlydanhgia?msvc=" + msvc + "&namhoc=" + response.encodeURL(namhoc));
    }
}
