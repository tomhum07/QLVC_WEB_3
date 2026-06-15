<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Quản Lý - QLVC</title>
    <!-- Nhúng Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            backdrop-filter: blur(10px);
            background-color: rgba(33, 37, 41, 0.9) !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .main-card {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.075);
            background: #ffffff;
            border: none;
        }
        .header-gradient {
            background: linear-gradient(45deg, #11998e, #38ef7d);
            color: white;
            padding: 30px;
        }
        .table {
            border-radius: 12px;
            overflow: hidden;
        }
        .table thead {
            background-color: #343a40;
            color: #ffffff;
        }
        .badge-username {
            background-color: #e9ecef;
            color: #495057;
            font-family: monospace;
            font-size: 0.95rem;
            padding: 4px 8px;
            border-radius: 6px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home">Hệ Thống QLVC</a>
            <div class="navbar-nav ms-auto">
                <%
                    M_User user = (M_User) session.getAttribute("currentUser");
                %>
                <span class="navbar-text me-3 text-light">Xin chào, <strong><%= user.getFullName() %></strong></span>
                <a class="btn btn-outline-light btn-sm px-3 rounded-pill" href="login?action=logout">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="card main-card shadow">
            <div class="header-gradient text-center">
                <h1 class="fw-bold mb-1">Trang Quản Lý Hệ Thống</h1>
                <p class="mb-0 opacity-75">Bảo mật nâng cao qua Controller điều hướng</p>
            </div>
            <div class="card-body p-5">
                <div class="alert alert-info border-0 shadow-sm rounded-3 text-dark">
                    <h5 class="alert-heading fw-bold">Thông tin phiên đăng nhập</h5>
                    Chào mừng <strong><%= user.getFullName() %></strong>. Bạn đã được cấp quyền truy cập vào phân vùng quản trị hệ thống dưới tệp tin JSP an toàn: <code>/WEB-INF/views/V_Manage.jsp</code>.
                </div>

                <div class="mt-5">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="fw-bold text-dark mb-0">Danh sách người dùng truy xuất từ MySQL</h3>
                        <span class="badge bg-success rounded-pill px-3 py-2">Dữ liệu thời gian thực</span>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col" style="width: 40%">Tên đăng nhập (Username)</th>
                                    <th scope="col" style="width: 30%">Mật khẩu (Đã ẩn)</th>
                                    <th scope="col" style="width: 30%">Họ và tên (Full Name)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<M_User> userList = (List<M_User>) request.getAttribute("userList");
                                    if (userList != null && !userList.isEmpty()) {
                                        for (M_User u : userList) {
                                %>
                                    <tr>
                                        <td>
                                            <span class="badge-username"><%= u.getUsername() %></span>
                                        </td>
                                        <td>
                                            <span class="text-muted"><%= u.getPassword() != null ? "•".repeat(Math.min(u.getPassword().length(), 8)) : "" %></span>
                                        </td>
                                        <td class="fw-semibold text-secondary">
                                            <%= u.getFullName() %>
                                        </td>
                                    </tr>
                                <%
                                        }
                                    } else {
                                %>
                                    <tr>
                                        <td colspan="3" class="text-center py-4 text-muted fs-5">
                                            <div class="spinner-border text-danger mb-2" role="status"></div>
                                            <div>Không có dữ liệu hoặc kết nối tới MySQL thất bại!</div>
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="mt-4 pt-3 border-top text-end">
                    <a href="home" class="btn btn-primary px-4 rounded-pill">Quay lại Trang Chủ</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
