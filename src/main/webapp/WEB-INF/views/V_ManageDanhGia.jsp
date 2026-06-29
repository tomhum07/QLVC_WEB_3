<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="com.example.model.M_VienChuc" %>
<%@ page import="com.example.model.M_KeHoachHeader" %>
<%@ page import="com.example.model.M_ChiTietDanhGia" %>
<%@ page import="com.example.model.M_Bcdvc" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đánh giá & Xếp loại viên chức - QLVC Admin</title>
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
        .plan-table {
            border-collapse: collapse;
            font-size: 0.9rem;
        }
        .plan-table th {
            background-color: #4f46e5;
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
            background-color: #fbfbfb;
            color: #1e293b;
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
            border-color: #6366f1;
            outline: none;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
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
        M_Bcdvc evaluation = (M_Bcdvc) request.getAttribute("evaluation");
        List<M_ChiTietDanhGia> criteriaDetails = (List<M_ChiTietDanhGia>) request.getAttribute("criteriaDetails");
        boolean hasPlan = (header != null);
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home"><i class="bi bi-award-fill me-2 text-warning"></i>Hệ Thống QLVC - Admin</a>
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
                        <a class="nav-link active fw-bold text-warning" href="quanlydanhgia?msvc=<%= selectedMsvc != null ? selectedMsvc : "" %>&namhoc=<%= response.encodeURL(selectedNamHoc != null ? selectedNamHoc : "") %>">Đánh Giá Viên Chức</a>
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
            <h3 class="fw-bold text-dark mb-4"><i class="bi bi-shield-check text-primary me-2"></i>ĐÁNH GIÁ & XẾP LOẠI CÔNG TÁC VIÊN CHỨC</h3>

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
                PHIẾU ĐÁNH GIÁ VÀ XẾP LOẠI CHẤT LƯỢNG VIÊN CHỨC
            </div>

            <% if (!hasPlan) { %>
                <div class="alert alert-warning text-center p-5 border-0 rounded-3 shadow-sm">
                    <h4 class="fw-bold text-warning-emphasis">Viên chức chưa khởi tạo kế hoạch cho năm học <%= selectedNamHoc %></h4>
                    <p class="text-secondary mb-0">Không thể thực hiện đánh giá khi chưa có thông tin kế hoạch.</p>
                </div>
            <% } else { %>
                <!-- Form Đánh giá tổng hợp chứa cả điểm từng tiêu chí -->
                <form action="quanlydanhgia" method="POST" id="danhgiaAdminForm">
                    <input type="hidden" name="action" value="saveEvaluation">
                    <input type="hidden" name="msvc" value="<%= selectedMsvc %>">
                    <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
                    <input type="hidden" name="msbcdvc" value="<%= evaluation != null ? evaluation.getMsbcdvc() : "" %>">

                    <!-- Panel Đánh giá & Xếp loại Viên chức (Lưu vào bcdvc) -->
                    <div class="card shadow-sm border-0 mb-4 bg-light border-start border-warning border-4">
                        <div class="card-body p-4">
                            <h5 class="fw-bold text-dark mb-3"><i class="bi bi-award me-2 text-warning"></i>Biểu Mẫu Chấm Điểm & Xếp Loại Chất Lượng (Bảng bcdvc)</h5>
                            
                            <div class="row g-3">
                                <div class="col-md-2">
                                    <label class="form-label fw-semibold text-secondary">Tổng Điểm Đánh Giá</label>
                                    <input type="number" name="tongdiem" id="tongDiemInput" class="form-control form-control-sm text-center fw-bold bg-white" value="<%= evaluation != null ? evaluation.getTongdiem() : 0 %>" readonly>
                                </div>
                                
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold text-secondary">Cá nhân Tự Xếp Loại</label>
                                    <input type="text" name="tuxeploai" class="form-control form-control-sm bg-light" value="<%= evaluation != null && evaluation.getTuxeploai() != null ? evaluation.getTuxeploai() : "" %>" readonly placeholder="Viên chức chưa tự xếp loại...">
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label fw-semibold text-secondary">Cấp Thẩm Quyền Xếp Loại</label>
                                    <select name="capthamquyenxeploai" class="form-select form-select-sm" required>
                                        <option value="" <%= (evaluation == null || evaluation.getCapthamquyenxeploai() == null || evaluation.getCapthamquyenxeploai().isEmpty()) ? "selected" : "" %>>-- Chọn mức xếp loại --</option>
                                        <option value="Hoàn thành xuất sắc nhiệm vụ" <%= (evaluation != null && "Hoàn thành xuất sắc nhiệm vụ".equals(evaluation.getCapthamquyenxeploai())) ? "selected" : "" %>>Hoàn thành xuất sắc nhiệm vụ</option>
                                        <option value="Hoàn thành tốt nhiệm vụ" <%= (evaluation != null && "Hoàn thành tốt nhiệm vụ".equals(evaluation.getCapthamquyenxeploai())) ? "selected" : "" %>>Hoàn thành tốt nhiệm vụ</option>
                                        <option value="Hoàn thành nhiệm vụ" <%= (evaluation != null && "Hoàn thành nhiệm vụ".equals(evaluation.getCapthamquyenxeploai())) ? "selected" : "" %>>Hoàn thành nhiệm vụ</option>
                                        <option value="Không hoàn thành nhiệm vụ" <%= (evaluation != null && "Không hoàn thành nhiệm vụ".equals(evaluation.getCapthamquyenxeploai())) ? "selected" : "" %>>Không hoàn thành nhiệm vụ</option>
                                    </select>
                                </div>

                                <div class="col-md-3 text-center d-flex align-items-center justify-content-center">
                                    <div class="form-check text-start">
                                        <input class="form-check-input" type="checkbox" name="duyetEvaluation" id="duyetEvaCheck" <%= (evaluation != null && "1".equals(evaluation.getDuyet())) ? "checked" : "" %>>
                                        <label class="form-check-label fw-semibold text-secondary" for="duyetEvaCheck">Đã duyệt Kết quả</label>
                                    </div>
                                </div>

                                <div class="col-md-9">
                                    <label class="form-label fw-semibold text-secondary">Nhận xét của Cấp thẩm quyền</label>
                                    <textarea name="nhanxetctq" class="form-control form-control-sm" rows="2" placeholder="Ghi nhận xét ưu điểm, khuyết điểm của viên chức..."><%= evaluation != null && evaluation.getNhanxetctq() != null ? evaluation.getNhanxetctq() : "" %></textarea>
                                </div>

                                <div class="col-md-3 d-flex align-items-end">
                                    <button type="submit" class="btn btn-warning btn-sm w-100 py-2 fw-semibold text-dark"><i class="bi bi-save-fill me-1"></i>Lưu phiếu đánh giá</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bảng chi tiết chấm điểm tiêu chí -->
                    <div class="table-responsive">
                        <table class="table table-hover plan-table align-middle">
                            <thead>
                                <tr>
                                    <th style="width: 5%">TT</th>
                                    <th style="width: 35%">Nội dung, tiêu chí đánh giá</th>
                                    <th style="width: 25%">Sản phẩm đạt được (Chỉ đọc)</th>
                                    <th style="width: 10%">Điểm quy định</th>
                                    <th style="width: 12%">Cá nhân tự đánh giá</th>
                                    <th style="width: 13%">Cấp thẩm quyền đánh giá</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    float sumTu = 0; 
                                    float sumCtq = 0;
                                    float sumMax = 0;
                                    int stt = 1;
                                    if (criteriaDetails != null) {
                                        for (M_ChiTietDanhGia item : criteriaDetails) { 
                                            sumTu += item.getDiem_tudanhgia();
                                            sumCtq += item.getDiem_ctqdanhgia();
                                            sumMax += item.getDiem_toida();
                                %>
                                    <tr>
                                        <td class="text-center fw-bold"><%= stt++ %></td>
                                        <td class="fw-semibold text-dark"><%= item.getTen_tieuchi() %></td>
                                        <td class="text-muted bg-light small"><%= item.getSanpham() != null ? item.getSanpham() : "" %></td>
                                        <td class="text-center fw-semibold text-primary"><%= (int)item.getDiem_toida() %></td>
                                        <td class="text-center fw-bold text-secondary"><%= (int)item.getDiem_tudanhgia() %></td>
                                        <td>
                                            <input type="number" name="diem_ctqdanhgia_<%= item.getTieuchi_id() %>" 
                                                   id="diem_<%= item.getTieuchi_id() %>"
                                                   class="form-control form-control-sm table-input text-center diem-ctq-input" 
                                                   step="0.5" min="0" max="<%= item.getDiem_toida() %>"
                                                   data-max="<%= item.getDiem_toida() %>"
                                                   value="<%= item.getDiem_ctqdanhgia() %>" 
                                                   onchange="calculateTotalAdmin()">
                                        </td>
                                    </tr>
                                <% 
                                        }
                                    } 
                                %>

                                <!-- HÀNG TỔNG CỘNG -->
                                <tr class="table-dark text-white fw-bold">
                                    <td colspan="2" class="text-center">TỔNG CỘNG ĐIỂM ĐÁNH GIÁ (Tối đa <%= (int)sumMax %> điểm)</td>
                                    <td></td>
                                    <td class="text-center"><%= (int)sumMax %></td>
                                    <td class="text-center"><span class="text-warning"><%= (int)sumTu %></span></td>
                                    <td class="text-center"><span id="tongDiemCtq" class="text-warning fs-5">0</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
            <% } %>

            <div class="mt-4 pt-3 border-top text-end">
                <a href="home" class="btn btn-secondary rounded-pill px-4 me-2">Quay lại Trang Chủ</a>
                <a href="quanlykehoach?msvc=<%= selectedMsvc %>&namhoc=<%= selectedNamHoc %>" class="btn btn-outline-primary rounded-pill px-4 me-2">Đến quản lý kế hoạch</a>
                <a href="quanlythuchien?msvc=<%= selectedMsvc %>&namhoc=<%= selectedNamHoc %>" class="btn btn-outline-success rounded-pill px-4">Đến quản lý thực hiện</a>
            </div>
        </div>
    </div>

    <script>
        function changeFilter() {
            var msvc = document.getElementById('vcSelector').value;
            var namhoc = document.getElementById('namhocSelector').value;
            window.location.href = "quanlydanhgia?msvc=" + msvc + "&namhoc=" + encodeURIComponent(namhoc);
        }

        function calculateTotalAdmin() {
            let total = 0;

            document.querySelectorAll('.diem-ctq-input').forEach(input => {
                let val = parseFloat(input.value) || 0;
                let max = parseFloat(input.getAttribute('data-max')) || 0;
                if (val > max) {
                    alert('Điểm nhập vào (' + val + ') không được vượt quá điểm tối đa (' + max + ') của tiêu chí!');
                    input.value = max;
                    val = max;
                }
                if (val < 0) {
                    input.value = 0;
                    val = 0;
                }
                total += val;
            });

            document.getElementById('tongDiemCtq').innerText = total;
            document.getElementById('tongDiemInput').value = Math.round(total);
        }

        document.addEventListener("DOMContentLoaded", function() {
            calculateTotalAdmin();
        });
    </script>
</body>
</html>
