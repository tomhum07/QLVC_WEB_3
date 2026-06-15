<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - QLVC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card shadow border-0">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-4">Đăng Nhập</h3>

                        <%-- Nhận và hiển thị thông điệp báo lỗi nếu có --%>
                        <% String error = (String) request.getAttribute("error"); %>
                        <% if (error != null) { %>
                            <div class="alert alert-danger small"><%= error %></div>
                        <% } %>

                        <%-- Lấy biến redirect từ request scope để lưu trữ --%>
                        <% String redirect = (String) request.getAttribute("redirect"); %>

                        <form action="login" method="POST">
                            <%-- Trường ẩn (Hidden field) để lưu lại trang cũ cần quay về sau khi đăng nhập thành công --%>
                            <input type="hidden" name="redirect" value="<%= redirect != null ? redirect : "" %>">

                            <div class="mb-3">
                                <label class="form-label">Tài khoản</label>
                                <input type="text" name="username" class="form-control" placeholder="admin ,vienchuc, truongkhoa" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mật khẩu</label>
                                <input type="password" name="password" class="form-control" placeholder="123456" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 mb-2">Đăng nhập</button>
                            
                            <a href="home" class="btn btn-outline-secondary w-100">Quay lại trang chủ</a>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
