<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="com.example.model.M_VienChuc" %>
<%@ page import="com.example.model.M_KeHoachHeader" %>
<%@ page import="com.example.model.M_KeHoachDetail" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Báo cáo thực hiện công việc - QLVC</title>
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
            padding: 30px;
        }
        .system-banner {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: #ffffff;
            font-weight: 700;
            letter-spacing: 1px;
            border-radius: 8px;
            padding: 15px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }
        .plan-table {
            border-collapse: collapse;
            font-size: 0.9rem;
        }
        .plan-table th {
            background-color: #1e3c72;
            color: #ffffff;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #dee2e6;
        }
        .plan-table td {
            vertical-align: middle;
            border: 1px solid #dee2e6;
            padding: 8px;
        }
        .plan-info-col {
            background-color: #f8f9fa;
            color: #495057;
        }
        .thuchien-input-col {
            background-color: #fffdf5;
        }
        .table-input {
            width: 100%;
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 4px 8px;
            font-size: 0.88rem;
            transition: all 0.2s ease-in-out;
        }
        .table-input:focus {
            border-color: #2a5298;
            outline: none;
            box-shadow: 0 0 0 3px rgba(42, 82, 152, 0.15);
        }
        .btn-update {
            background-color: #ffc107;
            color: #212529;
            border: none;
            font-size: 0.82rem;
            font-weight: 600;
        }
        .btn-update:hover {
            background-color: #e0a800;
            color: #212529;
        }
    </style>
</head>
<body>
    <%
        M_VienChuc vc = (M_VienChuc) request.getAttribute("vienchuc");
        String selectedNamHoc = (String) request.getAttribute("selectedNamHoc");
        M_KeHoachHeader header = (M_KeHoachHeader) request.getAttribute("planHeader");
        List<M_KeHoachDetail> details = (List<M_KeHoachDetail>) request.getAttribute("planDetails");
        boolean hasPlan = (header != null);
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home"><i class="bi bi-journal-check me-2"></i>Hệ Thống QLVC</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarVienChuc">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarVienChuc">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="kehoach?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Lập Kế Hoạch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active fw-bold text-warning" href="thuchien?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Báo Cáo Thực Hiện</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="danhgia?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Tự Đánh Giá</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ketqua?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Kết Quả</a>
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
            <!-- Header thông tin thực hiện -->
            <div class="row align-items-center mb-4">
                <div class="col-md-6">
                    <h3 class="fw-bold text-dark mb-0">THỰC HIỆN KẾ HOẠCH & BÁO CÁO KẾT QUẢ</h3>
                    <!-- Bộ chọn Năm học -->
                    <div class="d-flex align-items-center mt-3">
                        <label for="namhocSelector" class="me-2 fw-semibold text-secondary text-nowrap">Chọn Năm Học:</label>
                        <select id="namhocSelector" class="form-select form-select-sm w-auto" onchange="changeNamHoc(this.value)">
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
                <div class="col-md-6 text-md-end text-start mt-3 mt-md-0">
                    <span class="badge bg-primary p-2 fs-6">
                        <%= vc.getMsvc() %> - <%= vc.getHoten() %> - <%= vc.getTendonvi() %>
                    </span>
                </div>
            </div>

            <!-- Banner xanh hệ thống -->
            <div class="system-banner text-center mb-4">
                NHẬP SỐ LIỆU THỰC TẾ & MINH CHỨNG HOÀN THÀNH CÔNG VIỆC
            </div>

            <% if (!hasPlan) { %>
                <div class="alert alert-warning text-center p-5 border-0 rounded-3 shadow-sm">
                    <h4 class="fw-bold text-warning-emphasis">Chưa có kế hoạch công tác cho năm học <%= selectedNamHoc %></h4>
                    <p class="text-secondary mb-3">Bạn cần lập kế hoạch công tác trước khi cập nhật kết quả thực hiện.</p>
                    <a href="kehoach?namhoc=<%= selectedNamHoc %>" class="btn btn-primary rounded-pill px-4">Đến trang lập kế hoạch</a>
                </div>
            <% } else { %>
                <!-- Trạng thái duyệt kế hoạch -->
                <div class="alert alert-light border shadow-sm mb-4">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <span class="fw-bold text-secondary">Trạng thái duyệt kế hoạch:</span>
                            <% if ("1".equals(header.getDuyet())) { %>
                                <span class="badge bg-success rounded-pill px-3 ms-2"><i class="bi bi-check-circle-fill me-1"></i>Đã duyệt</span>
                            <% } else { %>
                                <span class="badge bg-warning text-dark rounded-pill px-3 ms-2"><i class="bi bi-clock-history me-1"></i>Chờ duyệt</span>
                            <% } %>
                        </div>
                        <div class="col-md-6 text-md-end text-start mt-2 mt-md-0">
                            <span class="text-muted small">Mã kế hoạch: <strong><%= header.getMskhvc() %></strong></span>
                        </div>
                    </div>
                </div>

                <!-- Bảng chi tiết thực hiện -->
                <div class="table-responsive">
                    <table class="table table-hover plan-table align-middle">
                        <thead>
                            <tr>
                                <th rowspan="2" style="width: 3%">STT</th>
                                <th rowspan="2" style="width: 5%">Mục</th>
                                <th colspan="5" class="bg-primary text-white">NỘI DUNG KẾ HOẠCH</th>
                                <th colspan="3" class="bg-warning text-dark">KẾT QUẢ THỰC HIỆN</th>
                                <th rowspan="2" style="width: 8%">Thao tác</th>
                            </tr>
                            <tr>
                                <th style="width: 15%">Công việc</th>
                                <th style="width: 10%">Kế hoạch thực hiện</th>
                                <th style="width: 8%">Chỉ tiêu</th>
                                <th style="width: 8%">Thời gian KH</th>
                                <th style="width: 10%">Sản phẩm KH</th>
                                <th style="width: 12%">Thực hiện</th>
                                <th style="width: 12%">Sản phẩm thực tế</th>
                                <th style="width: 12%">Minh chứng sản phẩm</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int stt = 1;
                                for (M_KeHoachDetail d : details) {
                                    String muc = d.getMuc();
                            %>
                                <tr>
                                    <td class="text-center font-monospace fw-semibold text-secondary"><%= stt++ %></td>
                                    <td class="text-center font-monospace fw-semibold"><%= muc %></td>
                                    <!-- Phần Kế hoạch (Read-only) -->
                                    <td class="plan-info-col"><%= d.getCongviec() != null ? d.getCongviec() : "" %></td>
                                    <td class="plan-info-col"><%= d.getKehoachthuchien() != null ? d.getKehoachthuchien() : "" %></td>
                                    <td class="plan-info-col text-center"><%= d.getChitieu() != null ? d.getChitieu() : "" %></td>
                                    <td class="plan-info-col text-center"><%= d.getThoigiankh() != null ? d.getThoigiankh() : "" %></td>
                                    <td class="plan-info-col"><%= d.getSanphamkh() != null ? d.getSanphamkh() : "" %></td>
                                    
                                    <!-- Phần Thực hiện (Editable) -->
                                    <td class="thuchien-input-col">
                                        <textarea id="thoigianth_<%= muc %>" class="form-control form-control-sm table-input" rows="2" placeholder="Ví dụ: Đã thực hiện được 150 giờ"><%= d.getThoigianth() != null ? d.getThoigianth() : "" %></textarea>
                                    </td>
                                    <td class="thuchien-input-col">
                                        <textarea id="sanphamth_<%= muc %>" class="form-control form-control-sm table-input" rows="2" placeholder="Sản phẩm thực tế"><%= d.getSanphamth() != null ? d.getSanphamth() : "" %></textarea>
                                    </td>
                                    <td class="thuchien-input-col">
                                        <textarea id="minhchung_<%= muc %>" class="form-control form-control-sm table-input" rows="2" placeholder="Link hoặc tên tài liệu minh chứng"><%= d.getMinhchung() != null ? d.getMinhchung() : "" %></textarea>
                                    </td>
                                    <td>
                                        <button class="btn btn-update btn-sm w-100 rounded shadow-sm" onclick="updateThucHien('<%= header.getMskhvc() %>', '<%= muc %>')">
                                            <i class="bi bi-save me-1"></i>Lưu
                                        </button>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>

            <div class="mt-4 pt-3 border-top text-end">
                <a href="home" class="btn btn-secondary rounded-pill px-4 me-2">Quay lại Trang Chủ</a>
                <a href="kehoach?namhoc=<%= selectedNamHoc %>" class="btn btn-info text-white rounded-pill px-4">Xem Kế Hoạch</a>
            </div>
        </div>
    </div>

    <!-- Hidden Action Form for JS submissions -->
    <form id="actionForm" action="thuchien" method="POST" style="display:none;">
        <input type="hidden" name="action" value="updateThucHien">
        <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
        <input type="hidden" name="mskhvc" id="formMskhvc">
        <input type="hidden" name="muc" id="formMuc">
        <input type="hidden" name="thoigianth" id="formThoiGianTh">
        <input type="hidden" name="sanphamth" id="formSanPhamTh">
        <input type="hidden" name="minhchung" id="formMinhChung">
    </form>

    <!-- JavaScript logic -->
    <script>
        function changeNamHoc(value) {
            window.location.href = "thuchien?namhoc=" + encodeURIComponent(value);
        }

        function updateThucHien(mskhvc, muc) {
            document.getElementById('formMskhvc').value = mskhvc;
            document.getElementById('formMuc').value = muc;
            document.getElementById('formThoiGianTh').value = document.getElementById('thoigianth_' + muc).value;
            document.getElementById('formSanPhamTh').value = document.getElementById('sanphamth_' + muc).value;
            document.getElementById('formMinhChung').value = document.getElementById('minhchung_' + muc).value;
            
            document.getElementById('actionForm').submit();
        }
    </script>
</body>
</html>
