<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="com.example.model.M_VienChuc" %>
<%@ page import="com.example.model.M_KeHoachHeader" %>
<%@ page import="com.example.model.M_KeHoachDetail" %>
<%@ page import="com.example.model.M_Bcdvc" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Kết Quả & Xếp Loại - QLVC Admin</title>
    <!-- Nhúng Bootstrap 5 & Google Fonts & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
            color: #333;
        }
        .navbar {
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }
        .main-container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            padding: 30px;
        }
        .admin-banner {
            background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
            color: #ffffff;
            font-weight: 700;
            letter-spacing: 1px;
            border-radius: 8px;
            padding: 15px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }
        .compare-table th {
            background-color: #0f172a;
            color: #ffffff;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #cbd5e1;
            padding: 10px;
        }
        .compare-table td {
            vertical-align: top;
            border: 1px solid #cbd5e1;
            padding: 10px;
        }
        .plan-bg {
            background-color: #f8fafc;
        }
        .execute-bg {
            background-color: #f0fdf4;
        }
    </style>
</head>
<body>
    <%
        M_User currentUser = (M_User) session.getAttribute("currentUser");
        List<M_VienChuc> listVC = (List<M_VienChuc>) request.getAttribute("listVienChuc");
        String selectedMsvc = (String) request.getAttribute("selectedMsvc");
        String selectedNamHoc = (String) request.getAttribute("selectedNamHoc");
        M_VienChuc targetVC = (M_VienChuc) request.getAttribute("targetVC");
        M_KeHoachHeader header = (M_KeHoachHeader) request.getAttribute("planHeader");
        List<M_KeHoachDetail> details = (List<M_KeHoachDetail>) request.getAttribute("planDetails");
        M_Bcdvc evaluation = (M_Bcdvc) request.getAttribute("evaluation");
        
        boolean hasPlan = (header != null);
        boolean isSuccess = "1".equals(request.getParameter("success"));
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home"><i class="bi bi-journal-text me-2"></i>Hệ Thống QLVC - Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarAdmin">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarAdmin">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="quanlykehoach?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Kế Hoạch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlythuchien?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Thực Hiện</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlydanhgia?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Đánh Giá Viên Chức</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active fw-bold text-warning" href="quanlyketqua?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Kết Quả</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="thongke?namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Thống Kê Đánh Giá</a>
                    </li>
                </ul>
                <div class="navbar-nav ms-auto align-items-center">
                    <span class="navbar-text me-3 text-light">Xin chào Admin, <strong><%= currentUser.getFullName() %></strong></span>
                    <a class="btn btn-outline-light btn-sm rounded-pill px-3" href="login?action=logout">Đăng xuất</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="main-container">
            <h3 class="fw-bold text-dark mb-4"><i class="bi bi-shield-check text-primary me-2"></i>QUẢN LÝ KẾT QUẢ & XẾP LOẠI VIÊN CHỨC</h3>

            <% if (isSuccess) { %>
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i><strong>Thành công!</strong> Đã lưu kết quả xếp loại và phê duyệt cho viên chức.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <!-- Bộ lọc chọn Viên chức & Năm học -->
            <div class="card shadow-sm border-0 mb-4 bg-light">
                <div class="card-body p-4 row g-3">
                    <div class="col-md-6">
                        <label for="vcSelector" class="form-label fw-bold text-secondary">Chọn Viên Chức Cần Xem:</label>
                        <select id="vcSelector" class="form-select form-select-sm" onchange="changeFilter()">
                            <% for (M_VienChuc v : listVC) { %>
                                <option value="<%= v.getMsvc() %>" <%= v.getMsvc().equals(selectedMsvc) ? "selected" : "" %>>
                                    <%= v.getMsvc() %> - <%= v.getHoten() %> (<%= v.getTendonvi() %>)
                                </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="namhocSelector" class="form-label fw-bold text-secondary">Chọn Năm Học:</label>
                        <select id="namhocSelector" class="form-select form-select-sm" onchange="changeFilter()">
                            <%
                                List<String> listNamHoc = (List<String>) request.getAttribute("listNamHoc");
                                if (listNamHoc != null) {
                                    for (String nh : listNamHoc) {
                            %>
                                <option value="<%= nh %>" <%= nh.equals(selectedNamHoc) ? "selected" : "" %>><%= nh %></option>
                            <% 
                                    }
                                } 
                            %>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Banner thông tin viên chức -->
            <% if (targetVC != null) { %>
                <div class="admin-banner mb-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="mb-1"><i class="bi bi-person-fill me-2"></i><%= targetVC.getHoten() %></h5>
                        <small>Mã VC: <%= targetVC.getMsvc() %> | Đơn vị: <%= targetVC.getTendonvi() %> | Chức vụ: <%= targetVC.getTenchucvu() %></small>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-light text-dark px-3 py-2 rounded-pill fw-bold">
                            Năm học: <%= selectedNamHoc %>
                        </span>
                    </div>
                </div>
            <% } %>

            <!-- Form bao quanh cả bảng so sánh và phần xếp loại -->
            <form action="quanlyketqua" method="POST">
                <input type="hidden" name="msvc" value="<%= selectedMsvc %>">
                <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">

                <!-- So sánh Kế hoạch & Thực hiện -->
                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-arrow-left-right text-primary me-2"></i>So Sánh Kế Hoạch & Thực Hiện Chi Tiết</h5>
                <% if (!hasPlan || details == null || details.isEmpty()) { %>
                    <div class="alert alert-warning border-0 shadow-sm p-4 mb-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>Viên chức này chưa xây dựng hoặc chưa nộp Kế Hoạch cho năm học được chọn. Không thể thực hiện so sánh đối chiếu.
                    </div>
                <% } else { %>
                    <div class="table-responsive shadow-sm rounded mb-5">
                        <table class="table table-bordered compare-table mb-0">
                            <thead>
                                <tr>
                                    <th style="width: 5%">TT</th>
                                    <th style="width: 10%">Mục</th>
                                    <th style="width: 32.5%" class="table-primary">KẾ HOẠCH ĐÃ LẬP</th>
                                    <th style="width: 32.5%" class="table-success">KẾT QUẢ THỰC HIỆN</th>
                                    <th style="width: 20%" class="table-info">ĐÁNH GIÁ CỦA ADMIN</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int stt = 1;
                                    for (M_KeHoachDetail d : details) {
                                %>
                                    <tr>
                                        <td class="text-center fw-bold"><%= stt++ %></td>
                                        <td class="text-center"><span class="badge bg-secondary"><%= d.getMuc() %></span></td>
                                        <td class="plan-bg">
                                            <div class="mb-2"><strong>Nội dung:</strong> <%= d.getCongviec() %></div>
                                            <div class="mb-2"><strong>Chỉ tiêu/Yêu cầu:</strong> <%= d.getChitieu() %></div>
                                            <div class="mb-2"><strong>Thời gian:</strong> <%= d.getThoigiankh() %></div>
                                            <div><strong>Sản phẩm đăng ký:</strong> <span class="text-primary fw-semibold"><%= d.getSanphamkh() %></span></div>
                                        </td>
                                        <td class="execute-bg">
                                            <div class="mb-2"><strong>Thời gian thực tế:</strong> <%= (d.getThoigianth() != null && !d.getThoigianth().isEmpty()) ? d.getThoigianth() : "-" %></div>
                                            <div class="mb-2"><strong>Sản phẩm đạt được:</strong> <span class="text-success fw-semibold"><%= (d.getSanphamth() != null && !d.getSanphamth().isEmpty()) ? d.getSanphamth() : "-" %></span></div>
                                            <div class="mb-2"><strong>Kết quả tự nhận:</strong> <%= (d.getKetqua() != null && !d.getKetqua().isEmpty()) ? d.getKetqua() : "-" %></div>
                                            <div class="mb-2"><strong>Minh chứng:</strong> 
                                                <% if (d.getMinhchung() != null && !d.getMinhchung().isEmpty()) { %>
                                                    <a href="<%= d.getMinhchung() %>" target="_blank" class="text-decoration-none"><i class="bi bi-link-45deg"></i> Xem minh chứng</a>
                                                <% } else { %>
                                                    -
                                                <% } %>
                                            </div>
                                            <div><strong>Trạng thái:</strong> 
                                                <% if ("1".equals(d.getDonvixacnhan())) { %>
                                                    <span class="badge bg-success"><i class="bi bi-patch-check-fill me-1"></i>Đã xác nhận</span>
                                                <% } else { %>
                                                    <span class="badge bg-secondary">Chưa xác nhận</span>
                                                <% } %>
                                            </div>
                                        </td>
                                        <td>
                                            <select name="danhgia_<%= d.getMuc() %>" class="form-select form-select-sm fw-semibold">
                                                <option value="" <%= (d.getDanhgia() == null || d.getDanhgia().isEmpty()) ? "selected" : "" %>>-- Chọn đánh giá --</option>
                                                <option value="Hoàn thành tốt" <%= "Hoàn thành tốt".equals(d.getDanhgia()) ? "selected" : "" %>>Hoàn thành tốt</option>
                                                <option value="Đạt" <%= "Đạt".equals(d.getDanhgia()) ? "selected" : "" %>>Đạt</option>
                                                <option value="Chưa đạt" <%= "Chưa đạt".equals(d.getDanhgia()) ? "selected" : "" %>>Chưa đạt</option>
                                            </select>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>

                <!-- Xếp loại kết quả đánh giá -->
                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-bookmark-star text-primary me-2"></i>Đánh Giá và Xếp Loại Của Quản Lý</h5>
                <div class="card shadow-sm border-0 bg-light mb-4">
                    <div class="card-body p-4">
                        <div class="row g-3">
                            <!-- Điểm tự đánh giá vs Điểm chính thức -->
                            <div class="col-md-4">
                                <label class="form-label fw-bold text-secondary">Tổng Điểm Chấm Hiện Tại:</label>
                                <div class="p-2 bg-white rounded border fw-bold text-primary">
                                    <%= evaluation != null ? evaluation.getTongdiem() : "0" %> điểm
                                    <span class="text-muted font-monospace fw-normal small">(tính từ trang Đánh Giá Viên Chức)</span>
                                </div>
                            </div>

                            <!-- Dropdown xếp loại chất lượng theo yêu cầu -->
                            <div class="col-md-4">
                                <label for="capthamquyenxeploai" class="form-label fw-bold text-secondary">Xếp Loại Chất Lượng:</label>
                                <select name="capthamquyenxeploai" id="capthamquyenxeploai" class="form-select" required>
                                    <option value="" <%= (evaluation == null || evaluation.getCapthamquyenxeploai() == null || evaluation.getCapthamquyenxeploai().isEmpty()) ? "selected" : "" %>>-- Chọn mức xếp loại --</option>
                                    <option value="Hoàn thành xuất sắc nhiệm vụ" <%= (evaluation != null && "Hoàn thành xuất sắc nhiệm vụ".equals(evaluation.getCapthamquyenxeploai())) ? "selected" : "" %>>Hoàn thành xuất sắc</option>
                                    <option value="Hoàn thành tốt nhiệm vụ" <%= (evaluation != null && "Hoàn thành tốt nhiệm vụ".equals(evaluation.getCapthamquyenxeploai())) ? "selected" : "" %>>Hoàn thành tốt</option>
                                    <option value="Hoàn thành nhiệm vụ" <%= (evaluation != null && "Hoàn thành nhiệm vụ".equals(evaluation.getCapthamquyenxeploai())) ? "selected" : "" %>>Hoàn thành</option>
                                    <option value="Không hoàn thành nhiệm vụ" <%= (evaluation != null && "Không hoàn thành nhiệm vụ".equals(evaluation.getCapthamquyenxeploai())) ? "selected" : "" %>>Chưa hoàn thành</option>
                                </select>
                            </div>

                            <!-- Trạng thái phê duyệt -->
                            <div class="col-md-4 d-flex align-items-end">
                                <div class="form-check pb-2">
                                    <input class="form-check-input" type="checkbox" name="duyet" id="duyetCheck" value="1" <%= (evaluation != null && "1".equals(evaluation.getDuyet())) ? "checked" : "" %>>
                                    <label class="form-check-label fw-bold text-danger-emphasis" for="duyetCheck">
                                        Phê duyệt Kết quả đánh giá & Xếp hạng
                                    </label>
                                </div>
                            </div>

                            <!-- Nhận xét chi tiết -->
                            <div class="col-12 mt-3">
                                <label for="nhanxetctq" class="form-label fw-bold text-secondary">Nhận xét của Cấp thẩm quyền:</label>
                                <textarea name="nhanxetctq" id="nhanxetctq" rows="3" class="form-control" placeholder="Ghi nhận xét đánh giá chi tiết..."><%= (evaluation != null && evaluation.getNhanxetctq() != null) ? evaluation.getNhanxetctq() : "" %></textarea>
                            </div>

                            <!-- Nút Lưu kết quả -->
                            <div class="col-12 text-end mt-4">
                                <button type="submit" class="btn btn-primary px-4 rounded-pill fw-semibold"><i class="bi bi-save me-1"></i>Lưu Xếp Loại & Phê Duyệt</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <div class="mt-4 pt-3 border-top text-end">
                <a href="home" class="btn btn-secondary rounded-pill px-4 me-2">Quay lại Trang Chủ</a>
                <a href="quanlydanhgia?msvc=<%= selectedMsvc %>&namhoc=<%= selectedNamHoc %>" class="btn btn-outline-warning rounded-pill px-4">Sang Đánh Giá Điểm Chi Tiết</a>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function changeFilter() {
            var msvc = document.getElementById('vcSelector').value;
            var namhoc = document.getElementById('namhocSelector').value;
            window.location.href = "quanlyketqua?msvc=" + msvc + "&namhoc=" + encodeURIComponent(namhoc);
        }
    </script>
</body>
</html>
