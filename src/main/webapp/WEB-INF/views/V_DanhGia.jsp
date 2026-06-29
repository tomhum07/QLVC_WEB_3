<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.M_User" %>
<%@ page import="com.example.model.M_VienChuc" %>
<%@ page import="com.example.model.M_Bcdvc" %>
<%@ page import="com.example.model.M_ChiTietDanhGia" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tự Đánh Giá & Xếp Loại Viên Chức - QLVC</title>
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
        .scorecard-header {
            border-bottom: 2px double #dee2e6;
            margin-bottom: 25px;
            padding-bottom: 15px;
        }
        .scorecard-table {
            font-size: 0.92rem;
            border-collapse: collapse;
        }
        .scorecard-table th {
            background-color: #0f172a;
            color: #ffffff;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #cbd5e1;
            padding: 10px;
        }
        .scorecard-table td {
            vertical-align: middle;
            border: 1px solid #cbd5e1;
            padding: 10px;
        }
        .row-group-header {
            background-color: #f1f5f9;
            font-weight: 700;
            color: #1e293b;
        }
        .row-subgroup-header {
            background-color: #f8fafc;
            font-weight: 600;
            color: #334155;
            padding-left: 20px;
        }
        .table-input {
            width: 100%;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 0.88rem;
            transition: all 0.2s ease;
        }
        .table-input:focus {
            border-color: #3b82f6;
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }
        .score-display {
            font-weight: 700;
            font-size: 1.1rem;
            color: #2563eb;
        }
    </style>
</head>
<body>
    <%
        M_VienChuc vc = (M_VienChuc) request.getAttribute("vienchuc");
        String selectedNamHoc = (String) request.getAttribute("selectedNamHoc");
        M_Bcdvc evaluation = (M_Bcdvc) request.getAttribute("evaluation");
        List<M_ChiTietDanhGia> details = (List<M_ChiTietDanhGia>) request.getAttribute("details");
        
        boolean isApproved = (evaluation != null && "1".equals(evaluation.getDuyet()));
        boolean isSuccess = "1".equals(request.getParameter("success"));
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
                        <a class="nav-link active fw-bold text-warning" href="danhgia?namhoc=<%= response.encodeURL(selectedNamHoc) %>">Tự Đánh Giá</a>
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
            <!-- Thông báo thành công -->
            <% if (isSuccess) { %>
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i><strong>Thành công!</strong> Báo cáo tự đánh giá của bạn đã được cập nhật thành công.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <!-- Tiêu đề biểu mẫu theo hình -->
            <div class="scorecard-header">
                <div class="row align-items-center text-center text-md-start mb-3">
                    <div class="col-md-6 border-end-md">
                        <div class="fw-bold text-uppercase small text-secondary">TRƯỜNG ĐẠI HỌC KIÊN GIANG</div>
                        <div class="fw-bold text-dark">ĐƠN VỊ: <span class="text-decoration-underline"><%= vc.getTendonvi() %></span></div>
                    </div>
                    <div class="col-md-6 text-md-end mt-2 mt-md-0">
                        <div class="fw-bold small">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</div>
                        <div class="fw-bold small text-decoration-underline">Độc lập - Tự do - Hạnh phúc</div>
                    </div>
                </div>

                <div class="text-center my-4">
                    <h4 class="fw-bold text-dark mb-1">BẢNG ĐIỂM ĐÁNH GIÁ, XẾP LOẠI CHẤT LƯỢNG VIÊN CHỨC,</h4>
                    <h4 class="fw-bold text-dark mb-2">NGƯỜI LAO ĐỘNG NĂM HỌC: <%= selectedNamHoc %></h4>
                    <div class="text-muted fst-italic">(Dành cho giảng viên, trợ giảng)</div>
                </div>

                <!-- Bộ lọc chọn Năm học -->
                <div class="d-flex align-items-center justify-content-center bg-light p-3 rounded mb-3">
                    <label for="namhocSelector" class="me-2 fw-semibold text-secondary">Chọn Năm Học Cần Đánh Giá:</label>
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

                <!-- Thông tin người dùng -->
                <div class="row g-3 px-3 py-2 bg-light rounded shadow-sm">
                    <div class="col-md-4">
                        <span class="text-secondary">Họ và tên:</span> <strong class="text-dark"><%= vc.getHoten() %></strong>
                    </div>
                    <div class="col-md-4">
                        <span class="text-secondary">Đơn vị công tác:</span> <strong class="text-dark"><%= vc.getTendonvi() %></strong>
                    </div>
                    <div class="col-md-4">
                        <span class="text-secondary">Ngạch/Chức danh nghề nghiệp:</span> <strong class="text-dark"><%= vc.getTenchucvu() %></strong>
                    </div>
                </div>
            </div>

            <!-- Form Tự Đánh giá -->
            <form action="danhgia" method="POST" id="danhgiaForm">
                <input type="hidden" name="action" value="submitSelfEvaluation">
                <input type="hidden" name="msvc" value="<%= vc.getMsvc() %>">
                <input type="hidden" name="namhoc" value="<%= selectedNamHoc %>">
                <input type="hidden" name="msbcdvc" value="<%= evaluation.getMsbcdvc() %>">

                <div class="table-responsive">
                    <table class="table scorecard-table align-middle">
                        <thead>
                            <tr>
                                <th style="width: 5%">TT</th>
                                <th style="width: 35%">Nội dung, tiêu chí đánh giá</th>
                                <th style="width: 25%">Sản phẩm đạt được</th>
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
                                if (details != null) {
                                    for (M_ChiTietDanhGia item : details) { 
                                        sumTu += item.getDiem_tudanhgia();
                                        sumCtq += item.getDiem_ctqdanhgia();
                                        sumMax += item.getDiem_toida();
                            %>
                                <tr>
                                    <td class="text-center fw-bold"><%= stt++ %></td>
                                    <td class="fw-semibold text-dark"><%= item.getTen_tieuchi() %></td>
                                    <td>
                                        <textarea name="sanpham_<%= item.getTieuchi_id() %>" class="form-control form-control-sm table-input" rows="2" <%= isApproved ? "readonly" : "" %> placeholder="Mô tả sản phẩm/kết quả đạt được..."><%= item.getSanpham() != null ? item.getSanpham() : "" %></textarea>
                                    </td>
                                    <td class="text-center fw-semibold text-primary"><%= (int)item.getDiem_toida() %></td>
                                    <td>
                                        <input type="number" name="diem_tudanhgia_<%= item.getTieuchi_id() %>" 
                                               id="diem_<%= item.getTieuchi_id() %>"
                                               class="form-control form-control-sm table-input text-center diem-tu-input" 
                                               step="0.5" min="0" max="<%= item.getDiem_toida() %>"
                                               data-max="<%= item.getDiem_toida() %>"
                                               value="<%= item.getDiem_tudanhgia() %>" 
                                               <%= isApproved ? "readonly" : "" %>
                                               onchange="calculateTotal()">
                                    </td>
                                    <td class="text-center fw-bold text-success">
                                        <%= isApproved ? (int)item.getDiem_ctqdanhgia() : "-" %>
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
                                <td class="text-center"><span id="tongDiemTu" class="score-display text-warning">0</span></td>
                                <td class="text-center">
                                    <span class="score-display text-warning">
                                        <%= isApproved ? (int)sumCtq : "-" %>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Phần tự xếp loại của Viên Chức -->
                <div class="card bg-light border-0 shadow-sm my-4">
                    <div class="card-body p-4">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <label for="tuxeploai" class="form-label fw-bold text-dark"><i class="bi bi-person-check-fill me-2 text-primary"></i>Cá nhân tự xếp loại chất lượng:</label>
                                <select name="tuxeploai" id="tuxeploai" class="form-select form-select-sm" <%= isApproved ? "disabled" : "" %> required>
                                    <option value="" <%= (evaluation.getTuxeploai() == null || evaluation.getTuxeploai().isEmpty()) ? "selected" : "" %>>-- Chọn mức tự xếp loại --</option>
                                    <option value="Hoàn thành xuất sắc nhiệm vụ" <%= "Hoàn thành xuất sắc nhiệm vụ".equals(evaluation.getTuxeploai()) ? "selected" : "" %>>Hoàn thành xuất sắc nhiệm vụ</option>
                                    <option value="Hoàn thành tốt nhiệm vụ" <%= "Hoàn thành tốt nhiệm vụ".equals(evaluation.getTuxeploai()) ? "selected" : "" %>>Hoàn thành tốt nhiệm vụ</option>
                                    <option value="Hoàn thành nhiệm vụ" <%= "Hoàn thành nhiệm vụ".equals(evaluation.getTuxeploai()) ? "selected" : "" %>>Hoàn thành nhiệm vụ</option>
                                    <option value="Không hoàn thành nhiệm vụ" <%= "Không hoàn thành nhiệm vụ".equals(evaluation.getTuxeploai()) ? "selected" : "" %>>Không hoàn thành nhiệm vụ</option>
                                </select>
                            </div>
                            <div class="col-md-4 text-md-end text-center mt-3 mt-md-0">
                                <% if (!isApproved) { %>
                                    <button type="submit" class="btn btn-primary btn-sm px-4 py-2 rounded-pill fw-semibold"><i class="bi bi-send-fill me-1"></i>Nộp phiếu tự đánh giá</button>
                                <% } else { %>
                                    <span class="badge bg-success rounded-pill px-3 py-2 fs-6">Đã phê duyệt đánh giá</span>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <!-- Kết quả chính thức từ cấp thẩm quyền (nếu đã được duyệt) -->
            <% if (isApproved) { %>
                <div class="card border-0 bg-success-subtle text-success-emphasis mb-4 shadow-sm border-start border-success border-4">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-3"><i class="bi bi-award-fill me-2 text-success"></i>KẾT QUẢ ĐÁNH GIÁ CHÍNH THỨC</h5>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <strong>Tổng điểm đánh giá chính thức:</strong> <span class="fs-5 fw-bold text-primary"><%= evaluation.getTongdiem() %></span> điểm
                            </div>
                            <div class="col-md-8">
                                <strong>Xếp loại chính thức:</strong> <span class="fs-5 fw-bold text-success"><%= evaluation.getCapthamquyenxeploai() %></span>
                            </div>
                            <div class="col-12 mt-3 pt-3 border-top">
                                <strong>Nhận xét của Cấp thẩm quyền:</strong>
                                <p class="mb-0 mt-1 bg-white p-3 rounded text-dark small border fst-italic"><%= (evaluation.getNhanxetctq() != null && !evaluation.getNhanxetctq().isEmpty()) ? evaluation.getNhanxetctq() : "Không có nhận xét bổ sung." %></p>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>

            <div class="text-center mt-4">
                <a href="home" class="btn btn-secondary rounded-pill px-4"><i class="bi bi-house-door me-1"></i>Quay lại Trang Chủ</a>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function changeNamHoc(val) {
            window.location.href = "danhgia?namhoc=" + encodeURIComponent(val);
        }

        function calculateTotal() {
            let total = 0;

            document.querySelectorAll('.diem-tu-input').forEach(input => {
                let val = parseFloat(input.value) || 0;
                let max = parseFloat(input.getAttribute('data-max')) || 0;
                if (val > max) {
                    alert('Điểm nhập vào (' + val + ') không được vượt quá điểm tối đa (' + max + ') củ tiêu chí!');
                    input.value = max;
                    val = max;
                }
                if (val < 0) {
                    input.value = 0;
                    val = 0;
                }
                total += val;
            });

            document.getElementById('tongDiemTu').innerText = total;
        }

        // Chạy tính toán tổng điểm ban đầu khi tải trang
        document.addEventListener("DOMContentLoaded", function() {
            calculateTotal();
        });
    </script>
</body>
</html>
