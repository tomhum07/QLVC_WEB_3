package com.example.controller;

import com.example.model.M_User;
import com.example.model.M_VienChuc;
import com.example.model.M_Bcdvc;
import com.example.model.M_ChiTietDanhGia;
import com.example.model.M_PlanDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

// TẦNG CONTROLLER: Xử lý Tự Đánh Giá của Viên Chức
@WebServlet(name = "C_DanhGiaServlet", value = "/danhgia")
public class C_DanhGiaServlet extends HttpServlet {
    private M_PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new M_PlanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        // Bảo mật: Yêu cầu đăng nhập
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=danhgia");
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

        // Lấy năm học được chọn
        String namhoc = request.getParameter("namhoc");
        if (namhoc == null || namhoc.trim().isEmpty()) {
            if (listNamHoc != null && !listNamHoc.isEmpty()) {
                namhoc = listNamHoc.get(0);
            } else {
                namhoc = "2025-2026/HK1";
            }
        }

        // Lấy hoặc tự động tạo mới Bản chấm điểm đánh giá (bcdvc) cho viên chức
        M_Bcdvc evaluation = planDAO.getOrCreateEvaluation(vc.getMsvc(), namhoc);
        
        // Lấy danh sách chi tiết chấm điểm theo 10 tiêu chí
        List<M_ChiTietDanhGia> details = planDAO.getChiTietDanhGiaList(evaluation.getMsbcdvc());

        // Truyền dữ liệu sang JSP
        request.setAttribute("vienchuc", vc);
        request.setAttribute("listNamHoc", listNamHoc);
        request.setAttribute("selectedNamHoc", namhoc);
        request.setAttribute("evaluation", evaluation);
        request.setAttribute("details", details);

        request.getRequestDispatcher("/WEB-INF/views/V_DanhGia.jsp").forward(request, response);
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

        if ("submitSelfEvaluation".equals(action)) {
            String msbcdvc = request.getParameter("msbcdvc");
            
            // Lặp qua 10 tiêu chí để lưu
            for (String[] def : M_PlanDAO.CRITERIA_DEFS) {
                String id = def[0];
                float maxPoint = Float.parseFloat(def[2]);
                
                String sanpham = request.getParameter("sanpham_" + id);
                if (sanpham == null) sanpham = "";
                
                float score = 0.0f;
                try {
                    String scoreStr = request.getParameter("diem_tudanhgia_" + id);
                    if (scoreStr != null && !scoreStr.trim().isEmpty()) {
                        score = Float.parseFloat(scoreStr);
                        if (score < 0) score = 0;
                        if (score > maxPoint) score = maxPoint; // Giới hạn điểm tối đa của tiêu chí
                    }
                } catch (Exception e) {}
                
                M_ChiTietDanhGia item = new M_ChiTietDanhGia(msbcdvc, id, sanpham, score, 0.0f);
                planDAO.updateChiTietDanhGiaTuDanhGia(item);
            }
            
            // Lưu mức tự xếp loại của cá nhân viên chức
            String tuxeploai = request.getParameter("tuxeploai");
            M_Bcdvc bcd = planDAO.getEvaluation(msvc, namhoc);
            if (bcd != null) {
                bcd.setTuxeploai(tuxeploai);
                planDAO.saveBcdvc(bcd);
            }
        }

        response.sendRedirect(request.getContextPath() + "/danhgia?namhoc=" + response.encodeURL(namhoc) + "&success=1");
    }
}
