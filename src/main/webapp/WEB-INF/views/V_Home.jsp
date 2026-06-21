<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ - QLVC</title>
    <!-- Nhúng Bootstrap CSS & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
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
            <a class="navbar-brand fw-bold" href="home"><i class="bi bi-award-fill me-2 text-warning"></i>Hệ Thống QLVC</a>
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
                    <span class="navbar-text me-3 text-light">Xin chào, <strong><%= user.getFullName() %></strong></span>
                    <a class="btn btn-outline-light" href="login?action=logout">Đăng xuất</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Nội dung chính (Hero Section) -->
    <div class="container mt-5">
        <div class="p-5 mb-4 bg-light rounded-3 shadow-sm border">
            <div class="container-fluid py-3">
                <h2 class="fw-bold text-dark mb-4"><i class="bi bi-grid-fill text-primary me-2"></i>Bảng Chức Năng Hệ Thống</h2>

                <!-- PHẦN 1: DÀNH CHO VIÊN CHỨC -->
                <div class="mb-4">
                    <h5 class="fw-bold text-secondary mb-3"><i class="bi bi-person-workspace me-2 text-info"></i>Dành cho Viên chức / Nghiệp vụ cá nhân</h5>
                    <div class="d-flex flex-wrap gap-3">
                        <!-- Nút 1: Trang Kế Hoạch -->
                        <button class="btn btn-info btn-lg px-4 text-white fw-semibold" 
                                onclick="handleAccess(<%= isLoggedIn %>, 'kehoach', 'Bạn cần đăng nhập để lập Kế Hoạch!')">
                            <i class="bi bi-calendar-event me-2"></i>Trang Kế Hoạch
                        </button>

                        <!-- Nút 2: Thực Hiện -->
                        <button class="btn btn-success btn-lg px-4 text-white fw-semibold" 
                                onclick="handleAccess(<%= isLoggedIn %>, 'thuchien', 'Bạn cần đăng nhập để báo cáo kết quả Thực Hiện!')">
                            <i class="bi bi-journal-check me-2"></i>Trực tiếp Thực Hiện
                        </button>

                        <!-- Nút 3: Tự Đánh Giá -->
                        <button class="btn btn-warning btn-lg px-4 text-dark fw-semibold" 
                                onclick="handleAccess(<%= isLoggedIn %>, 'danhgia', 'Bạn cần đăng nhập để Tự Đánh Giá!')">
                            <i class="bi bi-award me-2"></i>Tự Đánh Giá
                        </button>

                        <!-- Nút 4: Kết Quả -->
                        <button class="btn btn-secondary btn-lg px-4 fw-semibold" 
                                onclick="handleAccess(<%= isLoggedIn %>, 'ketqua', 'Bạn cần đăng nhập để truy cập trang Kết Quả!')">
                            <i class="bi bi-receipt me-2"></i>Kết Quả
                        </button>

                        <!-- Nút 5: Hehehe -->
                        <button class="btn btn-dark btn-lg px-4 fw-semibold" 
                                onclick="handleAccess(<%= isLoggedIn %>, 'Hehehe', 'Bạn cần đăng nhập để truy cập trang Hehehe!')">
                            <i class="bi bi-emoji-smile me-2"></i>Hehehe
                        </button>
                    </div>
                </div>

                <!-- PHẦN 2: DÀNH CHO QUẢN LÝ / ADMIN -->
                <% if (isLoggedIn && ("1".equals(user.getQuyen()) || "2".equals(user.getQuyen()))) { %>
                <div class="mt-4 pt-4 border-top">
                    <h5 class="fw-bold text-secondary mb-3"><i class="bi bi-shield-lock-fill me-2 text-danger"></i>Chức năng Quản lý / Admin</h5>
                    <div class="d-flex flex-wrap gap-3">
                        <!-- Nút 1: Quản Lý Tài Khoản (Chỉ Admin quyen = 1) -->
                        <% if ("1".equals(user.getQuyen())) { %>
                            <button class="btn btn-primary btn-lg px-4 fw-semibold" 
                                    onclick="window.location.href='quanly'">
                                <i class="bi bi-people me-2"></i>Quản Lý Tài Khoản
                            </button>
                        <% } %>

                        <!-- Nút 2: Quản Lý Kế Hoạch -->
                        <button class="btn btn-outline-primary btn-lg px-4 fw-semibold" 
                                onclick="window.location.href='quanlykehoach'">
                            <i class="bi bi-calendar-check me-2"></i>Quản Lý Kế Hoạch
                        </button>

                        <!-- Nút 3: Quản Lý Thực Hiện -->
                        <button class="btn btn-outline-success btn-lg px-4 fw-semibold" 
                                onclick="window.location.href='quanlythuchien'">
                            <i class="bi bi-clipboard-data me-2"></i>Quản Lý Thực Hiện
                        </button>

                        <!-- Nút 4: Đánh Giá Viên Chức -->
                        <button class="btn btn-outline-warning btn-lg px-4 text-dark fw-semibold" 
                                onclick="window.location.href='quanlydanhgia'">
                            <i class="bi bi-star me-2"></i>Đánh Giá Viên Chức
                        </button>

                        <!-- Nút 5: Thống Kê Đánh Giá -->
                        <button class="btn btn-outline-info btn-lg px-4 text-dark fw-semibold" 
                                onclick="window.location.href='thongke'">
                            <i class="bi bi-bar-chart me-2"></i>Thống Kê Đánh Giá
                        </button>
                    </div>
                </div>
                <% } %>



                </div>
            </div>
        </div>
    </div>

    <!-- Nhúng Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
