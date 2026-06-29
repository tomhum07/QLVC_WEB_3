package com.example.controller;

import com.example.model.M_User;
import com.example.model.M_VienChuc;
import com.example.model.M_KeHoachHeader;
import com.example.model.M_KeHoachDetail;
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

@WebServlet(name = "C_KetQuaServlet", value = "/ketqua")
public class C_KetQuaServlet extends HttpServlet {
    private M_PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new M_PlanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=ketqua");
            return;
        }

        M_VienChuc vc = planDAO.getVienChucByUsername(user.getUsername());
        if (vc == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        List<String> listNamHoc = planDAO.getAllNamHoc();
        String namhoc = request.getParameter("namhoc");
        if (namhoc == null || namhoc.trim().isEmpty()) {
            if (listNamHoc != null && !listNamHoc.isEmpty()) {
                namhoc = listNamHoc.get(0);
            } else {
                namhoc = "2025-2026/HK1";
            }
        }

        M_Bcdvc evaluation = planDAO.getOrCreateEvaluation(vc.getMsvc(), namhoc);
        List<M_ChiTietDanhGia> details = planDAO.getChiTietDanhGiaList(evaluation.getMsbcdvc());

        // Tính toán xếp hạng cá nhân
        List<M_Bcdvc> allEvas = planDAO.getAllEvaluations(namhoc);
        allEvas.sort((b1, b2) -> Integer.compare(b2.getTongdiem(), b1.getTongdiem()));

        int rank = 1;
        int totalStaff = allEvas.size();
        int staffRank = -1;

        for (int i = 0; i < allEvas.size(); i++) {
            if (i > 0 && allEvas.get(i).getTongdiem() < allEvas.get(i - 1).getTongdiem()) {
                rank = i + 1;
            }
            if (allEvas.get(i).getMsvc().equals(vc.getMsvc())) {
                staffRank = rank;
                break;
            }
        }

        // Lấy thông tin Kế hoạch và Thực hiện của viên chức
        M_KeHoachHeader planHeader = planDAO.getKeHoachHeader(vc.getMsvc(), namhoc);
        List<M_KeHoachDetail> planDetails = null;
        if (planHeader != null) {
            planDetails = planDAO.getKeHoachDetails(planHeader.getMskhvc());
        }

        request.setAttribute("vienchuc", vc);
        request.setAttribute("listNamHoc", listNamHoc);
        request.setAttribute("selectedNamHoc", namhoc);
        request.setAttribute("evaluation", evaluation);
        request.setAttribute("details", details);
        request.setAttribute("staffRank", staffRank);
        request.setAttribute("totalStaff", totalStaff);
        request.setAttribute("planDetails", planDetails);

        request.getRequestDispatcher("/WEB-INF/views/V_KetQua.jsp").forward(request, response);
    }
}
