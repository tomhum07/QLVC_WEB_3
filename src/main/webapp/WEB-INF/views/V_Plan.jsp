<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="com.example.model.M_VienChuc" %>
<%@ page import="com.example.model.M_KeHoachHeader" %>
<%@ page import="com.example.model.M_KeHoachDetail" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kế hoạch công tác viên chức - QLVC</title>
    <!-- Nhúng Bootstrap 5 & Google Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
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
            background: linear-gradient(135deg, #0d3b66 0%, #001f3f 100%);
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
            background-color: #0d3b66;
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
            border-color: #0d3b66;
            outline: none;
            box-shadow: 0 0 0 3px rgba(13, 59, 102, 0.15);
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
            background-color: #17a2b8;
            color: #ffffff;
            border: none;
            font-size: 0.82rem;
            font-weight: 600;
        }
        .btn-insert:hover {
            background-color: #138496;
        }
        .btn-delete {
            background-color: #dc3545;
            color: #ffffff;
            border: none;
            font-size: 0.82rem;
            font-weight: 600;
        }
        .btn-delete:hover {
            background-color: #c82333;
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
            <a class="navbar-brand fw-bold" href="home">Hệ Thống QLVC</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarVienChuc">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarVienChuc">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active fw-bold text-warning" href="kehoach?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Lập Kế Hoạch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="thuchien?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Báo Cáo Thực Hiện</a>
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
            <!-- Header thông tin công tác -->
            <div class="row align-items-center mb-4">
                <div class="col-md-5">
                    <h3 class="fw-bold text-dark mb-0">KẾ HOẠCH CÔNG TÁC CỦA VIÊN CHỨC</h3>
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
                <div class="col-md-7 text-md-end text-start mt-3 mt-md-0">
                    <span class="badge bg-secondary p-2 fs-6">
                        <%= vc.getMsvc() %> - <%= vc.getHoten() %> - <%= vc.getTenchucvu() %> - <%= vc.getTendonvi() %> - Năm học: <%= selectedNamHoc %>
                    </span>
                </div>
            </div>

            <!-- Banner xanh hệ thống -->
            <div class="system-banner text-center mb-4">
                HỆ THỐNG ĐÁNH GIÁ XẾP LOẠI VIÊN CHỨC
            </div>

            <% if (!hasPlan) { %>
                <!-- Form khởi tạo kế hoạch nếu chưa có -->
                <div class="alert alert-warning text-center p-5 border-0 rounded-3 shadow-sm">
                    <h4 class="fw-bold text-warning-emphasis">Chưa có kế hoạch công tác cho năm học <%= selectedNamHoc %></h4>
                    <p class="text-secondary mb-4">Nhấp vào nút bên dưới để khởi tạo tự động bảng kế hoạch công tác từ danh mục mẫu của trường.</p>
                    <form action="kehoach" method="POST">
                        <input type="hidden" name="action" value="initialize">
                        <input type="hidden" name="msvc" value="<%= vc.getMsvc() %>">
                        <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
                        <button type="submit" class="btn btn-primary btn-lg px-5 rounded-pill shadow-sm">Khởi tạo kế hoạch mới</button>
                    </form>
                </div>
            <% } else { %>
                <!-- Đăng ký danh hiệu & Trạng thái duyệt -->
                    <div class="card-body py-3 px-4">
                        <div class="row align-items-center mb-3">
                            <div class="col-md-6">
                                <span class="fw-bold text-secondary">TRẠNG THÁI PHÊ DUYỆT KẾ HOẠCH:</span>
                                <% if ("1".equals(header.getDuyet())) { %>
                                    <span class="badge bg-success rounded-pill px-3 ms-2">Đã duyệt</span>
                                <% } else { %>
                                    <span class="badge bg-warning text-dark rounded-pill px-3 ms-2">Chờ duyệt</span>
                                <% } %>
                            </div>
                        </div>
                        <form action="kehoach" method="POST" class="row g-3 align-items-end">
                            <input type="hidden" name="action" value="registerDanhHieu">
                            <input type="hidden" name="mskhvc" value="<%= header.getMskhvc() %>">
                            <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
                            <div class="col-md-4">
                                <label class="form-label fw-semibold text-secondary mb-1">Đăng ký Danh hiệu thi đua:</label>
                                <% String currentDH = header.getDanhhieu() != null ? header.getDanhhieu() : ""; %>
                                <select name="danhhieu" class="form-select form-select-sm" <%= "1".equals(header.getDuyet()) ? "disabled" : "" %>>
                                    <option value="" <%= currentDH.isEmpty() ? "selected" : "" %>>-- Chọn danh hiệu --</option>
                                    <option value="Lao động tiên tiến" <%= "Lao động tiên tiến".equals(currentDH) ? "selected" : "" %>>Lao động tiên tiến</option>
                                    <option value="Chiến sĩ thi đua cấp cơ sở" <%= "Chiến sĩ thi đua cấp cơ sở".equals(currentDH) ? "selected" : "" %>>Chiến sĩ thi đua cấp cơ sở</option>
                                    <option value="Chiến sĩ thi đua cấp Bộ" <%= "Chiến sĩ thi đua cấp Bộ".equals(currentDH) ? "selected" : "" %>>Chiến sĩ thi đua cấp Bộ</option>
                                    <option value="Chiến sĩ thi đua toàn quốc" <%= "Chiến sĩ thi đua toàn quốc".equals(currentDH) ? "selected" : "" %>>Chiến sĩ thi đua toàn quốc</option>
                                </select>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-semibold text-secondary mb-1">Đăng ký Khen thưởng:</label>
                                <input type="text" name="khenthuong" class="form-control form-control-sm" value="<%= header.getKhenthuong() != null ? header.getKhenthuong() : "" %>" <%= "1".equals(header.getDuyet()) ? "readonly" : "" %> placeholder="Bằng khen, giấy khen...">
                            </div>
                            <% if (!"1".equals(header.getDuyet())) { %>
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-primary btn-sm w-100 fw-semibold">Cập nhật Đăng ký</button>
                                </div>
                            <% } %>
                        </form>
                    </div>
                </div>

                <!-- Bảng chi tiết kế hoạch -->
                <div class="table-responsive">
                    <%
                        boolean isApproved = "1".equals(header.getDuyet());
                        if (isApproved) {
                    %>
                        <div class="alert alert-info border-0 shadow-sm mb-4">
                            <strong>Thông báo:</strong> Kế hoạch đã được phê duyệt. Tất cả các cột kế hoạch đã bị khóa (chỉ đọc) và không thể chỉnh sửa.
                        </div>
                    <% } %>
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
                                        <textarea id="congviec_<%= muc %>" class="form-control form-control-sm table-input" rows="2" <%= isApproved ? "readonly" : "" %>><%= d.getCongviec() %></textarea>
                                    </td>
                                    <td>
                                        <textarea id="kehoachthuchien_<%= muc %>" class="form-control form-control-sm table-input" rows="2" <%= isApproved ? "readonly" : "" %>><%= d.getKehoachthuchien() %></textarea>
                                    </td>
                                    <td>
                                        <input type="text" id="chitieu_<%= muc %>" class="table-input" value="<%= d.getChitieu() %>" <%= isApproved ? "readonly" : "" %>>
                                    </td>
                                    <td>
                                        <input type="text" id="thoigiankh_<%= muc %>" class="table-input" value="<%= d.getThoigiankh() %>" <%= isApproved ? "readonly" : "" %>>
                                    </td>
                                    <td>
                                        <textarea id="sanphamkh_<%= muc %>" class="form-control form-control-sm table-input" rows="2" <%= isApproved ? "readonly" : "" %>><%= d.getSanphamkh() %></textarea>
                                    </td>
                                    <td>
                                        <input type="text" id="ghichu_<%= muc %>" class="table-input" value="<%= d.getGhichu() %>" <%= isApproved ? "readonly" : "" %>>
                                    </td>
                                    <td class="text-center">
                                        <input type="checkbox" id="kiemtra_<%= muc %>" class="form-check-input" <%= "1".equals(d.getKiemtra()) ? "checked" : "" %> disabled>
                                    </td>
                                    <td>
                                        <div class="d-flex flex-column gap-1">
                                            <% if (isApproved) { %>
                                                <button class="btn btn-secondary btn-sm rounded" disabled>Đã khóa</button>
                                            <% } else { %>
                                                <button class="btn btn-update btn-sm rounded" onclick="updateRow('<%= header.getMskhvc() %>', '<%= muc %>')">Update</button>
                                            <% } %>
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
                <% if ("1".equals(vc.getQuyen()) || "2".equals(vc.getQuyen())) { %>
                    <a href="quanlykehoach" class="btn btn-primary rounded-pill px-4">Đến Trang Quản Lý Kế Hoạch</a>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Hidden Action Form for JS submissions -->
    <form id="actionForm" action="kehoach" method="POST" style="display:none;">
        <input type="hidden" name="action" id="formAction">
        <input type="hidden" name="msvc" value="<%= vc.getMsvc() %>">
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

    <!-- JavaScript logic -->
    <script>
        function changeNamHoc(value) {
            window.location.href = "kehoach?namhoc=" + encodeURIComponent(value);
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
            
            // Checkbox đã kiểm tra là read-only đối với viên chức, nên lấy giá trị hiện tại
            var chk = document.getElementById('kiemtra_' + muc);
            document.getElementById('formKiemTra').value = (chk && chk.checked) ? '1' : '0';
            
            document.getElementById('actionForm').submit();
        }

        function deleteRow(mskhvc, muc) {
            if (confirm('Bạn có chắc chắn muốn xóa dòng công việc này khỏi kế hoạch?')) {
                document.getElementById('formAction').value = 'delete';
                document.getElementById('formMskhvc').value = mskhvc;
                document.getElementById('formMuc').value = muc;
                document.getElementById('actionForm').submit();
            }
        }

        function insertRow(mskhvc, currentMuc) {
            var newMuc = prompt("Nhập ký hiệu mục mới (ví dụ: " + currentMuc + ".1 hoặc " + currentMuc + "a):", currentMuc + ".");
            if (newMuc === null || newMuc.trim() === "") return;
            
            var newCongViec = prompt("Nhập nội dung công việc mới:");
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
