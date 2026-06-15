<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ - QLVC</title>
    <!-- Nhúng Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        // Hàm kiểm tra quyền truy cập của người dùng tại Client
        function handleAccess(isLoggedIn, targetUrl, alertMessage) {
            if (isLoggedIn) {
                // Đã đăng nhập: Chuyển hướng trình duyệt sang trang yêu cầu (quanly hoặc kehoach)
                window.location.href = targetUrl;
            } else {
                // Chưa đăng nhập: Hiện thông báo và chuyển hướng sang login kèm tham số redirect quay lại trang cũ
                alert(alertMessage);
                window.location.href = "login?redirect=" + targetUrl;
            }
        }
    </script>
</head>
<body>
    <!-- Thanh điều hướng (Navbar) -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="home">Hệ Thống QLVC</a>
            <div class="navbar-nav ms-auto">
                <%
                    // Lấy đối tượng người dùng hiện tại từ Session scope
                    M_User user = (M_User) session.getAttribute("currentUser");
                    boolean isLoggedIn = (user != null);
                    if (!isLoggedIn) {
                %>
                    <!-- Nếu CHƯA đăng nhập: Hiển thị liên kết dẫn trực tiếp sang trang Login -->
                    <a class="btn btn-primary" href="login">Đăng nhập</a>
                <% } else { %>
                    <!-- Nếu ĐÃ đăng nhập: Hiển thị lời chào từ dữ liệu của Model và nút Đăng xuất -->
                    <span class="navbar-text me-3">Xin chào, <strong><%= user.getFullName() %></strong></span>
                    <a class="btn btn-outline-light" href="login?action=logout">Đăng xuất</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Nội dung chính (Hero Section) -->
    <div class="container mt-5">
        <div class="p-5 mb-4 bg-light rounded-3 shadow-sm">
            <div class="container-fluid py-5">
                <!-- BÀI TẬP: CÁC NÚT ĐIỀU HƯỚNG CÓ KIỂM TRA ĐĂNG NHẬP -->
                <div class="d-flex gap-3 mt-4">
                    <!-- Nút 1: Trang Quản Lý -->
                    <% if (isLoggedIn && ("1".equals(user.getQuyen()) )) { %>
                    <button class="btn btn-primary btn-lg px-4"
                            onclick="window.location.href='quanly'">
                        Quản Lý Tài Khoản
                    </button>
                    <% } %>

                    <!-- Nút 2: Trang Kế Hoạch -->
                    <button class="btn btn-info btn-lg px-4 text-white" 
                            onclick="handleAccess(<%= isLoggedIn %>, 'kehoach', 'Bạn cần đăng nhập để truy cập trang Kế Hoạch!')">
                        Trang Kế Hoạch
                    </button>

                    <% if (isLoggedIn && ("1".equals(user.getQuyen()) || "2".equals(user.getQuyen()))) { %>
                        <!-- Nút 3: Quản Lý Kế Hoạch (Dành cho Admin/Trưởng đơn vị) -->
                        <button class="btn btn-primary btn-lg px-4" 
                                onclick="window.location.href='quanlykehoach'">
                            Quản Lý Kế Hoạch (Admin)
                        </button>
                    <% } %>

                    <button class="btn btn-secondary btn-lg px-4" onclick="handleAccess(<%= isLoggedIn %>, 'ketqua', 'Bạn cần đăng nhập để truy cập trang Kết Quả!')">
                        Kết Quả
                    </button>

                    <button class="btn btn-secondary btn-lg px-4" onclick="handleAccess(<%= isLoggedIn %>, 'Hehehe', 'Bạn cần đăng nhập để truy cập trang Hehehe!')">
                        Hehehe
                    </button>



                </div>
            </div>
        </div>
    </div>

    <!-- Nhúng Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
