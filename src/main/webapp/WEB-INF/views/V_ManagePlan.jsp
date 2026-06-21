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
    <title>Quản lý kế hoạch công tác - QLVC Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
            color: #ffffff;
            font-weight: 700;
            letter-spacing: 1px;
            border-radius: 8px;
            padding: 15px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }
        .plan-table {
            border-collapse: collapse;
            font-size: 0.92rem;
        }
        .plan-table th {
            background-color: #1e3a8a;
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
        .table-input {
            width: 100%;
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 4px 8px;
            font-size: 0.88rem;
            transition: all 0.2s ease-in-out;
        }
        .table-input:focus {
            border-color: #3b82f6;
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
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
        }
        .btn-insert {
            background-color: #10b981;
            color: #ffffff;
            border: none;
            font-size: 0.82rem;
            font-weight: 600;
        }
        .btn-insert:hover {
            background-color: #059669;
        }
        .btn-delete {
            background-color: #ef4444;
            color: #ffffff;
            border: none;
            font-size: 0.82rem;
            font-weight: 600;
        }
        .btn-delete:hover {
            background-color: #dc2626;
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
            <a class="navbar-brand fw-bold" href="home">Hệ Thống QLVC - Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarAdmin">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarAdmin">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active fw-bold text-warning" href="quanlykehoach?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Kế Hoạch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlythuchien?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Quản Lý Thực Hiện</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="quanlydanhgia?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Đánh Giá Viên Chức</a>
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
            <h3 class="fw-bold text-dark mb-4">TRANG QUẢN LÝ KẾ HOẠCH CỦA ADMIN</h3>

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

            <!-- Banner tiêu đề -->
            <div class="admin-banner text-center mb-4">
                HỆ THỐNG PHÊ DUYỆT & QUẢN LÝ BẢNG KẾ HOẠCH
            </div>

            <!-- Form Thêm công việc mẫu vào hệ thống (Template) -->
            <div class="card shadow-sm border-0 mb-4 bg-light">
                <div class="card-body p-4">
                    <h5 class="fw-bold text-primary mb-3">Thêm Công Việc Mẫu Vào Hệ Thống (Master Template)</h5>
                    <form action="quanlykehoach" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="addTemplate">
                        <input type="hidden" name="msvc" value="<%= selectedMsvc %>">
                        <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
                        <div class="col-md-3">
                            <label class="form-label fw-semibold text-secondary">Mục (Ví dụ: I.4, II.12...)</label>
                            <input type="text" name="muc" class="form-control form-control-sm" placeholder="Nhập mục..." required>
                        </div>
                        <div class="col-md-7">
                            <label class="form-label fw-semibold text-secondary">Nội dung công việc mẫu</label>
                            <input type="text" name="congviec" class="form-control form-control-sm" placeholder="Nhập nội dung công việc mẫu..." required>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-success btn-sm w-100 py-2 fw-semibold">Thêm Mẫu</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Form Thêm Đợt Lập Kế Hoạch Mới -->
            <div class="card shadow-sm border-0 mb-4 bg-light border-start border-success border-4">
                <div class="card-body p-4">
                    <h5 class="fw-bold text-success mb-3">Thêm Đợt Lập Kế Hoạch Mới (Năm học/Kỳ học mới)</h5>
                    <form action="quanlykehoach" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="addPeriod">
                        <input type="hidden" name="msvc" value="<%= selectedMsvc %>">
                        <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
                        <div class="col-md-9">
                            <label class="form-label fw-semibold text-secondary">Tên năm học / đợt lập kế hoạch mới (Ví dụ: 2026-2027, 2025-2026/HK2...)</label>
                            <input type="text" name="newNamHoc" class="form-control form-control-sm" placeholder="Nhập tên đợt mới..." required>
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button type="submit" class="btn btn-success btn-sm w-100 py-2 fw-semibold text-white">Thêm Đợt Kế Hoạch</button>
                        </div>
                    </form>
                </div>
            </div>

            <% if (!hasPlan) { %>
                <div class="alert alert-warning text-center p-5 border-0 rounded-3 shadow-sm">
                    <h4 class="fw-bold text-warning-emphasis">Viên chức chưa khởi tạo kế hoạch cho năm học <%= selectedNamHoc %></h4>
                    <p class="text-secondary mb-4">Bạn có thể khởi tạo kế hoạch thay cho viên chức bằng nút dưới đây.</p>
                    <form action="kehoach" method="POST">
                        <input type="hidden" name="action" value="initialize">
                        <input type="hidden" name="msvc" value="<%= selectedMsvc %>">
                        <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
                        <!-- Redirect ngược lại trang quản lý sau khi init -->
                        <button type="submit" class="btn btn-primary btn-lg px-5 rounded-pill shadow-sm">Khởi tạo kế hoạch cho viên chức</button>
                    </form>
                </div>
            <% } else { %>
                <!-- Panel phê duyệt kế hoạch cho Admin -->
                <div class="card shadow-sm border-0 mb-4 bg-light border-start border-primary border-4">
                    <div class="card-body p-4">
                        <h5 class="fw-bold text-dark mb-3">Phê Duyệt Kế Hoạch (Mã KH: <%= header.getMskhvc() %>)</h5>
                        <form action="quanlykehoach" method="POST" class="row g-3 align-items-center">
                            <input type="hidden" name="action" value="approve">
                            <input type="hidden" name="msvc" value="<%= selectedMsvc %>">
                            <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
                            <input type="hidden" name="mskhvc" value="<%= header.getMskhvc() %>">
                            
                            <div class="col-md-3">
                                <label class="form-label fw-semibold text-secondary">Danh hiệu đăng ký</label>
                                <% String currentDH = header.getDanhhieu() != null ? header.getDanhhieu() : ""; %>
                                <select name="danhhieu" class="form-select form-select-sm">
                                    <option value="" <%= currentDH.isEmpty() ? "selected" : "" %>>-- Chọn danh hiệu --</option>
                                    <option value="Lao động tiên tiến" <%= "Lao động tiên tiến".equals(currentDH) ? "selected" : "" %>>Lao động tiên tiến</option>
                                    <option value="Chiến sĩ thi đua cấp cơ sở" <%= "Chiến sĩ thi đua cấp cơ sở".equals(currentDH) ? "selected" : "" %>>Chiến sĩ thi đua cấp cơ sở</option>
                                    <option value="Chiến sĩ thi đua cấp Bộ" <%= "Chiến sĩ thi đua cấp Bộ".equals(currentDH) ? "selected" : "" %>>Chiến sĩ thi đua cấp Bộ</option>
                                    <option value="Chiến sĩ thi đua toàn quốc" <%= "Chiến sĩ thi đua toàn quốc".equals(currentDH) ? "selected" : "" %>>Chiến sĩ thi đua toàn quốc</option>
                                </select>
                            </div>
                            
                            <div class="col-md-3">
                                <label class="form-label fw-semibold text-secondary">Khen thưởng đăng ký</label>
                                <input type="text" name="khenthuong" class="form-control form-control-sm" value="<%= header.getKhenthuong() != null ? header.getKhenthuong() : "" %>" placeholder="Bằng khen, giấy khen...">
                            </div>

                            <div class="col-md-2 text-center">
                                <div class="form-check d-inline-block text-start">
                                    <input class="form-check-input" type="checkbox" name="xacnhan" id="xacnhanCheck" <%= "1".equals(header.getXacnhan()) ? "checked" : "" %>>
                                    <label class="form-check-label fw-semibold text-secondary" for="xacnhanCheck">Đã Xác Nhận</label>
                                </div>
                            </div>

                            <div class="col-md-2 text-center">
                                <div class="form-check d-inline-block text-start">
                                    <input class="form-check-input" type="checkbox" name="duyet" id="duyetCheck" <%= "1".equals(header.getDuyet()) ? "checked" : "" %>>
                                    <label class="form-check-label fw-semibold text-secondary" for="duyetCheck">Đã Duyệt</label>
                                </div>
                            </div>

                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary btn-sm w-100 py-2 fw-semibold">Lưu Phê Duyệt</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Bảng chi tiết kế hoạch -->
                <div class="table-responsive">
                    <table class="table table-hover plan-table align-middle">
                        <thead>
                            <tr>
                                <th style="width: 4%">STT</th>
                                <th style="width: 6%">Mục</th>
                                <th style="width: 25%">Công việc</th>
                                <th style="width: 15%">Kế hoạch thực hiện</th>
                                <th style="width: 10%">Chỉ tiêu</th>
                                <th style="width: 10%">Thời gian KH</th>
                                <th style="width: 12%">Sản phẩm kế hoạch</th>
                                <th style="width: 10%">Ghi chú</th>
                                <th style="width: 5%">Đã kiểm tra</th>
                                <th style="width: 15%">Thao tác</th>
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
                                    <td>
                                        <textarea id="congviec_<%= muc %>" class="form-control form-control-sm table-input" rows="2"><%= d.getCongviec() %></textarea>
                                    </td>
                                    <td>
                                        <textarea id="kehoachthuchien_<%= muc %>" class="form-control form-control-sm table-input" rows="2"><%= d.getKehoachthuchien() %></textarea>
                                    </td>
                                    <td>
                                        <input type="text" id="chitieu_<%= muc %>" class="table-input" value="<%= d.getChitieu() %>">
                                    </td>
                                    <td>
                                        <input type="text" id="thoigiankh_<%= muc %>" class="table-input" value="<%= d.getThoigiankh() %>">
                                    </td>
                                    <td>
                                        <textarea id="sanphamkh_<%= muc %>" class="form-control form-control-sm table-input" rows="2"><%= d.getSanphamkh() %></textarea>
                                    </td>
                                    <td>
                                        <input type="text" id="ghichu_<%= muc %>" class="table-input" value="<%= d.getGhichu() %>">
                                    </td>
                                    <td class="text-center">
                                        <!-- Checkbox đã kiểm tra (Admin có thể sửa) -->
                                        <input type="checkbox" id="kiemtra_<%= muc %>" class="form-check-input" <%= "1".equals(d.getKiemtra()) ? "checked" : "" %>>
                                    </td>
                                    <td>
                                        <div class="d-flex flex-column gap-1">
                                            <button class="btn btn-update btn-sm rounded" onclick="updateRow('<%= header.getMskhvc() %>', '<%= muc %>')">Update</button>
                                            <button class="btn btn-insert btn-sm rounded text-white" onclick="insertRow('<%= header.getMskhvc() %>', '<%= muc %>')">Insert</button>
                                            <button class="btn btn-delete btn-sm rounded" onclick="deleteRow('<%= header.getMskhvc() %>', '<%= muc %>')">Delete</button>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>

            <div class="mt-4 pt-3 border-top text-end">
                <a href="home" class="btn btn-secondary rounded-pill px-4 me-2">Quay lại Trang Chủ</a>
                <a href="kehoach" class="btn btn-outline-primary rounded-pill px-4">Đến Trang Xem Kế Hoạch Viên Chức</a>
            </div>
        </div>
    </div>

    <!-- Hidden Action Form for JS submissions -->
    <form id="actionForm" action="quanlykehoach" method="POST" style="display:none;">
        <input type="hidden" name="action" id="formAction">
        <input type="hidden" name="msvc" value="<%= selectedMsvc %>">
        <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
        <input type="hidden" name="mskhvc" id="formMskhvc">
        <input type="hidden" name="muc" id="formMuc">
        <input type="hidden" name="congviec" id="formCongViec">
        <input type="hidden" name="kehoachthuchien" id="formKeHoachThucHien">
        <input type="hidden" name="chitieu" id="formChiTieu">
        <input type="hidden" name="thoigiankh" id="formThoiGianKh">
        <input type="hidden" name="sanphamkh" id="formSanPhamKh">
        <input type="hidden" name="ghichu" id="formGhiChu">
        <input type="hidden" name="kiemtra" id="formKiemTra">
    </form>

    <script>
        function changeFilter() {
            var msvc = document.getElementById('vcSelector').value;
            var namhoc = document.getElementById('namhocSelector').value;
            window.location.href = "quanlykehoach?msvc=" + msvc + "&namhoc=" + encodeURIComponent(namhoc);
        }

        function updateRow(mskhvc, muc) {
            document.getElementById('formAction').value = 'update';
            document.getElementById('formMskhvc').value = mskhvc;
            document.getElementById('formMuc').value = muc;
            document.getElementById('formCongViec').value = document.getElementById('congviec_' + muc).value;
            document.getElementById('formKeHoachThucHien').value = document.getElementById('kehoachthuchien_' + muc).value;
            document.getElementById('formChiTieu').value = document.getElementById('chitieu_' + muc).value;
            document.getElementById('formThoiGianKh').value = document.getElementById('thoigiankh_' + muc).value;
            document.getElementById('formSanPhamKh').value = document.getElementById('sanphamkh_' + muc).value;
            document.getElementById('formGhiChu').value = document.getElementById('ghichu_' + muc).value;
            
            var chk = document.getElementById('kiemtra_' + muc);
            document.getElementById('formKiemTra').value = (chk && chk.checked) ? '1' : '0';
            
            document.getElementById('actionForm').submit();
        }

        function deleteRow(mskhvc, muc) {
            if (confirm('Bạn có chắc chắn muốn xóa dòng công việc này khỏi kế hoạch của viên chức?')) {
                document.getElementById('formAction').value = 'delete';
                document.getElementById('formMskhvc').value = mskhvc;
                document.getElementById('formMuc').value = muc;
                document.getElementById('actionForm').submit();
            }
        }

        function insertRow(mskhvc, currentMuc) {
            var newMuc = prompt("Nhập ký hiệu mục mới (ví dụ: " + currentMuc + ".1 hoặc " + currentMuc + "a):", currentMuc + ".");
            if (newMuc === null || newMuc.trim() === "") return;
            
            var newCongViec = prompt("Nhập nội dung công việc mới cho viên chức:");
            if (newCongViec === null || newCongViec.trim() === "") return;

            document.getElementById('formAction').value = 'insert';
            document.getElementById('formMskhvc').value = mskhvc;
            document.getElementById('formMuc').value = newMuc.trim();
            document.getElementById('formCongViec').value = newCongViec.trim();
            document.getElementById('formKeHoachThucHien').value = '';
            document.getElementById('formChiTieu').value = '';
            document.getElementById('formThoiGianKh').value = '';
            document.getElementById('formSanPhamKh').value = '';
            document.getElementById('formGhiChu').value = '';
            document.getElementById('formKiemTra').value = '0';
            
            document.getElementById('actionForm').submit();
        }
    </script>
</body>
</html>
