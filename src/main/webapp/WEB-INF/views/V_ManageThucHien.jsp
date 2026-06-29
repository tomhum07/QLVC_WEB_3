<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="com.example.model.M_VienChuc" %>
<%@ page import="com.example.model.M_KeHoachHeader" %>
<%@ page import="com.example.model.M_KeHoachDetail" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý thực hiện công tác - QLVC Admin</title>
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
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
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
            background-color: #059669;
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
            background-color: #f9fafb;
            color: #4b5563;
        }
        .thuchien-input-col {
            background-color: #fdfdfd;
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
            border-color: #10b981;
            outline: none;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
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
        M_User currentUser = (M_User) session.getAttribute("currentUser");
        List<M_VienChuc> listVC = (List<M_VienChuc>) request.getAttribute("listVienChuc");
        String selectedMsvc = (String) request.getAttribute("selectedMsvc");
        String selectedNamHoc = (String) request.getAttribute("selectedNamHoc");
        M_VienChuc targetVC = (M_VienChuc) request.getAttribute("targetVC");
        M_KeHoachHeader header = (M_KeHoachHeader) request.getAttribute("planHeader");
        List<M_KeHoachDetail> details = (List<M_KeHoachDetail>) request.getAttribute("planDetails");
        boolean hasPlan = (header != null);
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
                        <a class="nav-link active fw-bold text-warning" href="quanlythuchien?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Thực Hiện</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlydanhgia?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Đánh Giá Viên Chức</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlyketqua?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Kết Quả</a>
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
            <h3 class="fw-bold text-dark mb-4">QUẢN LÝ THỰC HIỆN CÔNG TÁC CỦA VIÊN CHỨC</h3>

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

            <!-- Banner xanh hệ thống -->
            <div class="admin-banner text-center mb-4">
                XÁC NHẬN KẾT QUẢ THỰC HIỆN CỦA VIÊN CHỨC
            </div>

            <% if (!hasPlan) { %>
                <div class="alert alert-warning text-center p-5 border-0 rounded-3 shadow-sm">
                    <h4 class="fw-bold text-warning-emphasis">Viên chức chưa khởi tạo kế hoạch cho năm học <%= selectedNamHoc %></h4>
                    <p class="text-secondary">Không có kết quả thực hiện nào để hiển thị.</p>
                </div>
            <% } else { %>
                <!-- Bảng chi tiết thực hiện -->
                <div class="table-responsive">
                    <table class="table table-hover plan-table align-middle">
                        <thead>
                            <tr>
                                <th rowspan="2" style="width: 3%">STT</th>
                                <th rowspan="2" style="width: 5%">Mục</th>
                                <th colspan="5" class="bg-primary text-white">KẾ HOẠCH (ĐÃ DUYỆT)</th>
                                <th colspan="5" class="bg-success text-white">KẾT QUẢ THỰC HIỆN & XÁC NHẬN</th>
                                <th rowspan="2" style="width: 8%">Thao tác</th>
                            </tr>
                            <tr>
                                <th style="width: 12%">Công việc</th>
                                <th style="width: 8%">Kế hoạch</th>
                                <th style="width: 7%">Chỉ tiêu</th>
                                <th style="width: 7%">Thời gian</th>
                                <th style="width: 8%">Sản phẩm</th>
                                <th style="width: 10%">Thực hiện</th>
                                <th style="width: 10%">Sản phẩm thực tế</th>
                                <th style="width: 10%">Minh chứng</th>
                                <th style="width: 5%">Tự XN</th>
                                <th style="width: 5%">Đơn vị XN</th>
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
                                    <!-- Kế hoạch -->
                                    <td class="plan-info-col"><%= d.getCongviec() != null ? d.getCongviec() : "" %></td>
                                    <td class="plan-info-col"><%= d.getKehoachthuchien() != null ? d.getKehoachthuchien() : "" %></td>
                                    <td class="plan-info-col text-center"><%= d.getChitieu() != null ? d.getChitieu() : "" %></td>
                                    <td class="plan-info-col text-center"><%= d.getThoigiankh() != null ? d.getThoigiankh() : "" %></td>
                                    <td class="plan-info-col"><%= d.getSanphamkh() != null ? d.getSanphamkh() : "" %></td>
                                    
                                    <!-- Thực hiện (Admin có thể sửa) -->
                                    <td class="thuchien-input-col">
                                        <textarea id="thoigianth_<%= muc %>" class="form-control form-control-sm table-input" rows="2"><%= d.getThoigianth() != null ? d.getThoigianth() : "" %></textarea>
                                    </td>
                                    <td class="thuchien-input-col">
                                        <textarea id="sanphamth_<%= muc %>" class="form-control form-control-sm table-input" rows="2"><%= d.getSanphamth() != null ? d.getSanphamth() : "" %></textarea>
                                    </td>
                                    <td class="thuchien-input-col">
                                        <textarea id="minhchung_<%= muc %>" class="form-control form-control-sm table-input" rows="2"><%= d.getMinhchung() != null ? d.getMinhchung() : "" %></textarea>
                                    </td>
                                    <td class="text-center thuchien-input-col">
                                        <input type="checkbox" class="form-check-input" <%= "1".equals(d.getTuxacnhan()) ? "checked" : "" %> disabled>
                                    </td>
                                    <td class="text-center thuchien-input-col">
                                        <input type="checkbox" id="donvixacnhan_<%= muc %>" class="form-check-input" <%= "1".equals(d.getDonvixacnhan()) ? "checked" : "" %>>
                                    </td>
                                    <td>
                                        <button class="btn btn-update btn-sm w-100 rounded shadow-sm text-dark fw-bold" onclick="updateRowByAdmin('<%= header.getMskhvc() %>', '<%= muc %>')">
                                            <i class="bi bi-check2-circle me-1"></i>Lưu
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
                <a href="quanlykehoach?msvc=<%= selectedMsvc %>&namhoc=<%= selectedNamHoc %>" class="btn btn-outline-primary rounded-pill px-4">Đến quản lý kế hoạch</a>
            </div>
        </div>
    </div>

    <!-- Hidden Action Form for JS submissions -->
    <form id="actionForm" action="quanlythuchien" method="POST" style="display:none;">
        <input type="hidden" name="action" value="updateThucHienByAdmin">
        <input type="hidden" name="msvc" value="<%= selectedMsvc %>">
        <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
        <input type="hidden" name="mskhvc" id="formMskhvc">
        <input type="hidden" name="muc" id="formMuc">
        <input type="hidden" name="thoigianth" id="formThoiGianTh">
        <input type="hidden" name="sanphamth" id="formSanPhamTh">
        <input type="hidden" name="minhchung" id="formMinhChung">
        <input type="hidden" name="donvixacnhan" id="formDonViXacNhan">
    </form>

    <script>
        function changeFilter() {
            var msvc = document.getElementById('vcSelector').value;
            var namhoc = document.getElementById('namhocSelector').value;
            window.location.href = "quanlythuchien?msvc=" + msvc + "&namhoc=" + encodeURIComponent(namhoc);
        }

        function updateRowByAdmin(mskhvc, muc) {
            document.getElementById('formMskhvc').value = mskhvc;
            document.getElementById('formMuc').value = muc;
            document.getElementById('formThoiGianTh').value = document.getElementById('thoigianth_' + muc).value;
            document.getElementById('formSanPhamTh').value = document.getElementById('sanphamth_' + muc).value;
            document.getElementById('formMinhChung').value = document.getElementById('minhchung_' + muc).value;
            
            var chk = document.getElementById('donvixacnhan_' + muc);
            document.getElementById('formDonViXacNhan').value = (chk && chk.checked) ? '1' : '0';
            
            document.getElementById('actionForm').submit();
        }
    </script>
</body>
</html>
