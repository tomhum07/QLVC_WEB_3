package com.example.controller;


import com.example.model.M_User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "C_HeheheServlet", value = "/Hehehe")

public class C_HeheheServlet extends HttpServlet {
    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws jakarta.servlet.ServletException, java.io.IOException {
        // lay sesion
        HttpSession session = request.getSession(false);
        M_User user = (session != null) ? (M_User) session.getAttribute("currentUser") : null;

        //kiem tra dang nhap
        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=Hehehe");
            return;
        }
        // neu da dang nhap, cho phep toi trang hehe
        request.getRequestDispatcher("/WEB-INF/views/V_Hehehe.jsp").forward(request, response);
    }

}
