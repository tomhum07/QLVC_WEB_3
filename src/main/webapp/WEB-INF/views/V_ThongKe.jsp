<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="com.example.model.M_Bcdvc" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thống kê đánh giá xếp loại viên chức - QLVC Admin</title>
    <!-- Nhúng Bootstrap 5 & Google Fonts & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Outfit', sans-serif;
            background-color: #f1f5f9;
            color: #1e293b;
        }
        .navbar {
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .main-container {
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.03);
            padding: 35px;
        }
        .dashboard-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            color: #ffffff;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 30px;
        }
        .metric-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        .metric-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        }
        .stat-table th {
            background-color: #0f172a;
            color: #ffffff;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #e2e8f0;
        }
        .stat-table td {
            vertical-align: middle;
            border: 1px solid #e2e8f0;
            padding: 10px 12px;
        }
        .progress {
            height: 12px;
            border-radius: 6px;
        }
    </style>
</head>
<body>
    <%
        M_User currentUser = (M_User) session.getAttribute("currentUser");
        String selectedNamHoc = (String) request.getAttribute("selectedNamHoc");
        List<M_Bcdvc> evaluations = (List<M_Bcdvc>) request.getAttribute("evaluations");

        // Tính toán số liệu thống kê
        int total = (evaluations != null) ? evaluations.size() : 0;
        int countXuatSac = 0;
        int countTot = 0;
        int countHoanThanh = 0;
        int countKhongHoanThanh = 0;
        int countChoDanhGia = 0;
        double sumScore = 0;
        int hasScoreCount = 0;

        if (evaluations != null) {
            for (M_Bcdvc b : evaluations) {
                String xl = b.getCapthamquyenxeploai();
                if (xl == null || xl.trim().isEmpty()) {
                    countChoDanhGia++;
                } else if (xl.contains("xuất sắc") || xl.contains("Xuất sắc")) {
                    countXuatSac++;
                } else if (xl.contains("tốt") || xl.contains("Tốt")) {
                    countTot++;
                } else if (xl.contains("Không hoàn thành") || xl.contains("không hoàn thành")) {
                    countKhongHoanThanh++;
                } else if (xl.contains("Hoàn thành") || xl.contains("hoàn thành")) {
                    countHoanThanh++;
                } else {
                    countChoDanhGia++;
                }

                if (b.getTongdiem() > 0) {
                    sumScore += b.getTongdiem();
                    hasScoreCount++;
                }
            }
        }

        double avgScore = (hasScoreCount > 0) ? (sumScore / hasScoreCount) : 0.0;
        
        // Tính phần trăm
        double pctXS = (total > 0) ? ((double) countXuatSac / total * 100) : 0;
        double pctTot = (total > 0) ? ((double) countTot / total * 100) : 0;
        double pctHT = (total > 0) ? ((double) countHoanThanh / total * 100) : 0;
        double pctKHT = (total > 0) ? ((double) countKhongHoanThanh / total * 100) : 0;
        double pctCho = (total > 0) ? ((double) countChoDanhGia / total * 100) : 0;
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home"><i class="bi bi-bar-chart-line me-2"></i>Hệ Thống QLVC - Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarAdmin">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarAdmin">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="quanlykehoach?namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Kế Hoạch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlythuchien?namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Thực Hiện</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlydanhgia?namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Đánh Giá Viên Chức</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlyketqua?namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Kết Quả</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active fw-bold text-warning" href="thongke?namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Thống Kê Đánh Giá</a>
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
            <!-- Dashboard Header -->
            <div class="dashboard-header d-flex flex-column flex-md-row justify-content-between align-items-md-center">
                <div>
                    <h2 class="fw-bold mb-1"><i class="bi bi-pie-chart-fill me-2 text-warning"></i>Báo Cáo Thống Kê Xếp Loại Viên Chức</h2>
                    <p class="mb-0 opacity-75">Dữ liệu tổng hợp xếp loại và kết quả đánh giá viên chức toàn đơn vị</p>
                </div>
                <!-- Bộ chọn Năm học -->
                <div class="d-flex align-items-center mt-3 mt-md-0 bg-white bg-opacity-10 p-2 rounded-3">
                    <label for="namhocSelector" class="me-2 fw-semibold text-white text-nowrap mb-0">Năm Học:</label>
                    <select id="namhocSelector" class="form-select form-select-sm w-auto border-0 bg-white" onchange="changeNamHoc(this.value)">
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

            <!-- Stats Metric Cards Row -->
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <div class="metric-card text-center shadow-sm">
                        <span class="text-muted d-block mb-1 text-uppercase fw-bold small">Tổng số viên chức</span>
                        <h2 class="fw-bold text-slate-800 mb-0"><%= total %></h2>
                        <span class="badge bg-secondary rounded-pill mt-2">Nhân sự toàn đơn vị</span>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="metric-card text-center shadow-sm">
                        <span class="text-muted d-block mb-1 text-uppercase fw-bold small">Đã đánh giá</span>
                        <h2 class="fw-bold text-success mb-0"><%= total - countChoDanhGia %></h2>
                        <span class="badge bg-success rounded-pill mt-2">Hoàn thành đánh giá</span>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="metric-card text-center shadow-sm">
                        <span class="text-muted d-block mb-1 text-uppercase fw-bold small">Chờ đánh giá</span>
                        <h2 class="fw-bold text-warning mb-0"><%= countChoDanhGia %></h2>
                        <span class="badge bg-warning text-dark rounded-pill mt-2">Đang xử lý</span>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="metric-card text-center shadow-sm">
                        <span class="text-muted d-block mb-1 text-uppercase fw-bold small">Điểm trung bình</span>
                        <h2 class="fw-bold text-primary mb-0"><%= String.format("%.2f", avgScore) %></h2>
                        <span class="badge bg-primary rounded-pill mt-2">Thang điểm 100</span>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <!-- Phân bố xếp loại (Progress bars) -->
                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm p-4 h-100 bg-light">
                        <h5 class="fw-bold mb-4 text-dark"><i class="bi bi-graph-up-arrow me-2 text-primary"></i>Phân Bố Tỷ Lệ Xếp Loại Chất Lượng</h5>
                        
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-1 small fw-semibold">
                                <span>Hoàn thành xuất sắc nhiệm vụ</span>
                                <span><%= countXuatSac %> / <%= total %> (<%= String.format("%.1f", pctXS) %>%)</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: <%= pctXS %>%" aria-valuenow="<%= pctXS %>" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-1 small fw-semibold">
                                <span>Hoàn thành tốt nhiệm vụ</span>
                                <span><%= countTot %> / <%= total %> (<%= String.format("%.1f", pctTot) %>%)</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: <%= pctTot %>%" aria-valuenow="<%= pctTot %>" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-1 small fw-semibold">
                                <span>Hoàn thành nhiệm vụ</span>
                                <span><%= countHoanThanh %> / <%= total %> (<%= String.format("%.1f", pctHT) %>%)</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-warning text-dark" role="progressbar" style="width: <%= pctHT %>%" aria-valuenow="<%= pctHT %>" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-1 small fw-semibold">
                                <span>Không hoàn thành nhiệm vụ</span>
                                <span><%= countKhongHoanThanh %> / <%= total %> (<%= String.format("%.1f", pctKHT) %>%)</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-danger" role="progressbar" style="width: <%= pctKHT %>%" aria-valuenow="<%= pctKHT %>" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>

                        <div class="mb-2">
                            <div class="d-flex justify-content-between mb-1 small fw-semibold">
                                <span>Chờ xếp loại</span>
                                <span><%= countChoDanhGia %> / <%= total %> (<%= String.format("%.1f", pctCho) %>%)</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-secondary" role="progressbar" style="width: <%= pctCho %>%" aria-valuenow="<%= pctCho %>" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tóm tắt nhanh thông tin hành động -->
                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm p-4 h-100 bg-light">
                        <h5 class="fw-bold mb-3 text-dark"><i class="bi bi-info-circle me-2 text-warning"></i>Thông Tin Lưu Ý Đánh Giá</h5>
                        <p class="text-secondary small mb-3">Theo hướng dẫn đánh giá xếp loại viên chức năm học <%= selectedNamHoc %>:</p>
                        <ul class="text-secondary small mb-4">
                            <li class="mb-2"><strong>Hoàn thành xuất sắc nhiệm vụ (HTXSNV):</strong> Điểm đạt được trên 90 điểm và các tiêu chí cụ thể phải đạt điểm tuyệt đối.</li>
                            <li class="mb-2"><strong>Hoàn thành tốt nhiệm vụ (HTTNV):</strong> Điểm đánh giá đạt từ trên 80 đến 90 điểm.</li>
                            <li class="mb-2"><strong>Hoàn thành nhiệm vụ (HTNV):</strong> Điểm đánh giá đạt từ trên 70 đến 80 điểm.</li>
                            <li class="mb-2"><strong>Không hoàn thành nhiệm vụ (KHTNV):</strong> Điểm đánh giá đạt từ 70 điểm trở xuống.</li>
                        </ul>
                        <div class="d-flex gap-2">
                            <a href="quanlykehoach?namhoc=<%= selectedNamHoc %>" class="btn btn-outline-primary w-100 fw-semibold btn-sm"><i class="bi bi-pencil-square me-1"></i>Vào Trang Đánh Giá Viên Chức</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bảng chi tiết danh sách đánh giá của các viên chức -->
            <h5 class="fw-bold mb-3 text-dark"><i class="bi bi-list-stars me-2 text-primary"></i>Chi Tiết Kết Quả Đánh Giá Từng Viên Chức</h5>
            <div class="table-responsive">
                <table class="table table-hover stat-table align-middle">
                    <thead>
                        <tr>
                            <th style="width: 5%">STT</th>
                            <th style="width: 10%">Mã VC</th>
                            <th style="width: 18%">Họ và Tên</th>
                            <th style="width: 15%">Chức vụ / Chức danh</th>
                            <th style="width: 15%">Đơn vị</th>
                            <th style="width: 10%">Tổng điểm</th>
                            <th style="width: 12%">Tự xếp loại</th>
                            <th style="width: 15%">Cấp có thẩm quyền xếp loại</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (evaluations == null || evaluations.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="8" class="text-center text-muted py-4">Không có dữ liệu đánh giá nào cho năm học <%= selectedNamHoc %></td>
                            </tr>
                        <%
                            } else {
                                int stt = 1;
                                for (M_Bcdvc b : evaluations) {
                                    String xl = b.getCapthamquyenxeploai();
                                    String badgeClass = "bg-secondary";
                                    if (xl != null) {
                                        if (xl.contains("xuất sắc") || xl.contains("Xuất sắc")) badgeClass = "bg-success";
                                        else if (xl.contains("tốt") || xl.contains("Tốt")) badgeClass = "bg-primary";
                                        else if (xl.contains("Không hoàn thành") || xl.contains("không hoàn thành")) badgeClass = "bg-danger";
                                        else if (xl.contains("Hoàn thành") || xl.contains("hoàn thành")) badgeClass = "bg-warning text-dark";
                                    }
                        %>
                            <tr>
                                <td class="text-center font-monospace fw-semibold text-secondary"><%= stt++ %></td>
                                <td class="text-center font-monospace"><%= b.getMsvc() %></td>
                                <td class="fw-bold"><%= b.getHoten() != null ? b.getHoten() : "" %></td>
                                <td><%= b.getTenchucvu() != null ? b.getTenchucvu() : "Viên chức" %></td>
                                <td><%= b.getTendonvi() != null ? b.getTendonvi() : "" %></td>
                                <td class="text-center fw-bold text-primary"><%= b.getTongdiem() %></td>
                                <td><%= b.getTuxeploai() != null ? b.getTuxeploai() : "Chưa tự đánh giá" %></td>
                                <td class="text-center">
                                    <% if (xl != null && !xl.isEmpty()) { %>
                                        <span class="badge <%= badgeClass %> px-3 py-2 rounded-pill"><%= xl %></span>
                                    <% } else { %>
                                        <span class="badge bg-secondary px-3 py-2 rounded-pill">Chờ đánh giá</span>
                                    <% } %>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="mt-4 pt-3 border-top text-end">
                <a href="home" class="btn btn-secondary rounded-pill px-4">Quay lại Trang Chủ</a>
            </div>
        </div>
    </div>

    <script>
        function changeNamHoc(value) {
            window.location.href = "thongke?namhoc=" + encodeURIComponent(value);
        }
    </script>
</body>
</html>
