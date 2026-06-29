<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="com.example.model.M_VienChuc" %>
<%@ page import="com.example.model.M_KeHoachHeader" %>
<%@ page import="com.example.model.M_KeHoachDetail" %>
<%@ page import="com.example.model.M_Bcdvc" %>
<%@ page import="com.example.model.M_ChiTietDanhGia" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kết Quả Đánh Giá - QLVC</title>
    <!-- Nhúng Bootstrap 5 & Google Fonts & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f9;
            color: #333;
        }
        .navbar {
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }
        .main-container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            padding: 35px;
        }
        .result-card {
            border: none;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .result-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
        }
        .table-custom th {
            background-color: #0f172a;
            color: #ffffff;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #cbd5e1;
            padding: 12px;
        }
        .table-custom td {
            vertical-align: middle;
            border: 1px solid #cbd5e1;
            padding: 12px;
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
        M_VienChuc vc = (M_VienChuc) request.getAttribute("vienchuc");
        String selectedNamHoc = (String) request.getAttribute("selectedNamHoc");
        M_Bcdvc evaluation = (M_Bcdvc) request.getAttribute("evaluation");
        List<M_ChiTietDanhGia> details = (List<M_ChiTietDanhGia>) request.getAttribute("details");
        int staffRank = (Integer) request.getAttribute("staffRank");
        int totalStaff = (Integer) request.getAttribute("totalStaff");
        List<M_KeHoachDetail> planDetails = (List<M_KeHoachDetail>) request.getAttribute("planDetails");

        boolean isApproved = (evaluation != null && "1".equals(evaluation.getDuyet()));
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home"><i class="bi bi-award-fill text-warning me-2"></i>Hệ Thống QLVC</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarVienChuc">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarVienChuc">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="kehoach?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Lập Kế Hoạch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="thuchien?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Báo Cáo Thực Hiện</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="danhgia?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Tự Đánh Giá</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active fw-bold text-warning" href="ketqua?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Kết Quả</a>
                    </li>
                </ul>
                <div class="navbar-nav ms-auto align-items-center">
                    <span class="navbar-text me-3 text-light">Xin chào, <strong><%= vc.getHoten() %></strong></span>
                    <a class="btn btn-outline-light btn-sm rounded-pill px-3" href="login?action=logout">Đăng xuất</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="main-container">
            <!-- Bộ lọc năm học -->
            <div class="row align-items-center mb-4 g-3 bg-light p-3 rounded border">
                <div class="col-md-8">
                    <h4 class="fw-bold text-dark mb-0"><i class="bi bi-receipt text-primary me-2"></i>KẾT QUẢ ĐÁNH GIÁ CỦA BẠN</h4>
                </div>
                <div class="col-md-4 text-md-end">
                    <label for="namhoc" class="form-label fw-bold text-secondary me-2 d-inline-block">Chọn Năm Học:</label>
                    <select class="form-select form-select-sm d-inline-block w-auto" id="namhoc" onchange="changeNamHoc(this.value)">
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

            <!-- Tổng quan kết quả (Xếp hạng, Điểm, Xếp loại) -->
            <div class="row g-4 mb-5">
                <!-- Cột Điểm Đánh Giá -->
                <div class="col-md-4">
                    <div class="card result-card shadow-sm h-100 bg-primary-subtle text-primary-emphasis border-start border-primary border-4">
                        <div class="card-body text-center py-4">
                            <h6 class="text-uppercase fw-bold text-secondary-emphasis mb-2"><i class="bi bi-calculator me-1"></i>Tổng Điểm Đánh Giá</h6>
                            <div class="fs-1 fw-bold my-2 text-primary">
                                <%= isApproved ? evaluation.getTongdiem() : "-" %>
                            </div>
                            <span class="badge bg-primary text-white rounded-pill px-3">
                                <%= isApproved ? "Chính thức" : "Đang chờ duyệt" %>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Cột Xếp Loại Chất Lượng -->
                <div class="col-md-4">
                    <%
                        String badgeClass = "bg-warning text-dark";
                        String ratingStr = "Chưa phê duyệt";
                        if (isApproved && evaluation.getCapthamquyenxeploai() != null) {
                            ratingStr = evaluation.getCapthamquyenxeploai();
                            if (ratingStr.contains("Xuất sắc") || ratingStr.contains("xuất sắc")) {
                                badgeClass = "bg-success text-white";
                            } else if (ratingStr.contains("Tốt") || ratingStr.contains("tốt")) {
                                badgeClass = "bg-info text-white";
                            } else if (ratingStr.contains("Không hoàn thành") || ratingStr.contains("chưa hoàn thành") || ratingStr.contains("Chưa hoàn thành")) {
                                badgeClass = "bg-danger text-white";
                            } else {
                                badgeClass = "bg-primary text-white";
                            }
                        }
                    %>
                    <div class="card result-card shadow-sm h-100 bg-success-subtle text-success-emphasis border-start border-success border-4">
                        <div class="card-body text-center py-4">
                            <h6 class="text-uppercase fw-bold text-secondary-emphasis mb-2"><i class="bi bi-patch-check me-1"></i>Xếp Loại Chất Lượng</h6>
                            <div class="fs-4 fw-bold my-3 text-success text-truncate px-2">
                                <%= ratingStr %>
                            </div>
                            <span class="badge <%= badgeClass %> rounded-pill px-3">
                                <%= isApproved ? "Cấp thẩm quyền quyết định" : "Đang chờ duyệt" %>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Cột Xếp Hạng Cá Nhân -->
                <div class="col-md-4">
                    <div class="card result-card shadow-sm h-100 bg-warning-subtle text-warning-emphasis border-start border-warning border-4">
                        <div class="card-body text-center py-4">
                            <h6 class="text-uppercase fw-bold text-secondary-emphasis mb-2"><i class="bi bi-trophy me-1"></i>Xếp Hạng Cá Nhân</h6>
                            <div class="fs-1 fw-bold my-2 text-warning">
                                <%= isApproved && staffRank > 0 ? staffRank : "-" %>
                            </div>
                            <span class="badge bg-warning text-dark rounded-pill px-3">
                                <%= isApproved && staffRank > 0 ? "Thứ " + staffRank + " trên " + totalStaff + " VC" : "Chờ duyệt bảng xếp hạng" %>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Nhận xét của cấp trên -->
            <% if (isApproved && evaluation.getNhanxetctq() != null && !evaluation.getNhanxetctq().trim().isEmpty()) { %>
                <div class="card border-0 bg-light shadow-sm p-4 mb-5 border-start border-4 border-info">
                    <h5 class="fw-bold mb-2 text-info"><i class="bi bi-chat-left-quote me-2"></i>Nhận xét từ cấp thẩm quyền:</h5>
                    <p class="mb-0 text-dark fst-italic"><%= evaluation.getNhanxetctq() %></p>
                </div>
            <% } else if (!isApproved) { %>
                <div class="alert alert-info border-0 shadow-sm mb-5" role="alert">
                    <i class="bi bi-info-circle-fill me-2"></i><strong>Lưu ý:</strong> Phiếu đánh giá của bạn đang trong trạng thái chờ duyệt hoặc chưa được cấp quản lý chấm điểm chính thức. Vui lòng quay lại sau khi có thông báo.
                </div>
            <% } %>

            <!-- So sánh Kế hoạch & Thực hiện -->
            <h5 class="fw-bold text-dark mb-3"><i class="bi bi-arrow-left-right text-primary me-2"></i>So Sánh Kế Hoạch & Thực Hiện Chi Tiết</h5>
            <% if (planDetails == null || planDetails.isEmpty()) { %>
                <div class="alert alert-warning border-0 shadow-sm p-4 mb-5" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>Bạn chưa xây dựng hoặc chưa nộp Kế Hoạch cho năm học được chọn.
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
                                int sttPlan = 1;
                                for (M_KeHoachDetail d : planDetails) {
                            %>
                                <tr>
                                    <td class="text-center fw-bold"><%= sttPlan++ %></td>
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
                                    <td class="text-center fw-bold">
                                        <% if (d.getDanhgia() != null && !d.getDanhgia().isEmpty()) { 
                                            String badgeStyle = "bg-primary";
                                            if ("Hoàn thành tốt".equals(d.getDanhgia())) badgeStyle = "bg-success";
                                            else if ("Đạt".equals(d.getDanhgia())) badgeStyle = "bg-info text-dark";
                                            else if ("Chưa đạt".equals(d.getDanhgia())) badgeStyle = "bg-danger";
                                        %>
                                            <span class="badge <%= badgeStyle %> fs-6 px-3 py-2 rounded-pill"><%= d.getDanhgia() %></span>
                                        <% } else { %>
                                            <span class="text-muted fst-italic small">Chưa đánh giá</span>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>

            <!-- Bảng chi tiết chấm điểm -->
            <h5 class="fw-bold mb-3 text-dark"><i class="bi bi-list-task me-2 text-primary"></i>Chi Tiết Điểm Đánh Giá Theo Tiêu Chí</h5>
            <div class="table-responsive shadow-sm rounded">
                <table class="table table-bordered table-hover table-custom mb-0">
                    <thead>
                        <tr>
                            <th style="width: 5%">TT</th>
                            <th style="width: 25%">Tiêu chí đánh giá</th>
                            <th style="width: 35%">Sản phẩm/Kết quả đạt được</th>
                            <th style="width: 10%">Điểm tối đa</th>
                            <th style="width: 12%">Tự đánh giá</th>
                            <th style="width: 13%">Cấp trên chấm</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            float sumMax = 0;
                            float sumTu = 0;
                            float sumCtq = 0;
                            int stt = 1;
                            if (details != null) {
                                for (M_ChiTietDanhGia item : details) {
                                    sumMax += item.getDiem_toida();
                                    sumTu += item.getDiem_tudanhgia();
                                    sumCtq += item.getDiem_ctqdanhgia();
                        %>
                            <tr>
                                <td class="text-center fw-bold"><%= stt++ %></td>
                                <td class="fw-semibold text-dark"><%= item.getTen_tieuchi() %></td>
                                <td class="text-muted small"><%= item.getSanpham() != null ? item.getSanpham() : "" %></td>
                                <td class="text-center fw-semibold text-primary"><%= (int)item.getDiem_toida() %></td>
                                <td class="text-center fw-bold text-secondary"><%= (int)item.getDiem_tudanhgia() %></td>
                                <td class="text-center fw-bold text-success"><%= isApproved ? (int)item.getDiem_ctqdanhgia() : "-" %></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        <tr class="table-dark text-white fw-bold">
                            <td colspan="3" class="text-center">TỔNG CỘNG ĐIỂM</td>
                            <td class="text-center"><%= (int)sumMax %></td>
                            <td class="text-center text-warning"><%= (int)sumTu %></td>
                            <td class="text-center text-warning"><%= isApproved ? (int)sumCtq : "-" %></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="text-center mt-5">
                <a href="home" class="btn btn-secondary rounded-pill px-4 me-2"><i class="bi bi-house-door me-1"></i>Quay lại Trang Chủ</a>
                <a href="danhgia?namhoc=<%= response.encodeURL(selectedNamHoc) %>" class="btn btn-primary rounded-pill px-4"><i class="bi bi-pencil-square me-1"></i>Xem lại Tự Đánh Giá</a>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function changeNamHoc(val) {
            window.location.href = "ketqua?namhoc=" + encodeURIComponent(val);
        }
    </script>
</body>
</html>
