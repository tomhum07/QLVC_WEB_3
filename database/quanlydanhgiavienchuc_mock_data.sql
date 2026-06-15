-- =========================================================================
-- MOCK DATA: 5 bản ghi cho mỗi bảng của cơ sở dữ liệu quanlydanhgiavc
-- =========================================================================

USE quanlydanhgiavc;

-- Tắt kiểm tra khóa ngoại tạm thời để tránh lỗi xung đột thứ tự import
SET FOREIGN_KEY_CHECKS = 0;

-- Xóa dữ liệu cũ nếu có (Sử dụng DELETE thay thế cho TRUNCATE vì InnoDB chặn TRUNCATE bảng có khóa ngoại)
DELETE FROM ChiTietBangChamDiem;
DELETE FROM BanChamDiemVienChuc;
DELETE FROM ChiTietKetQuaThucHien;
DELETE FROM KetQuaThucHienVienChuc;
DELETE FROM ChiTietKeHoachVienChuc;
DELETE FROM KeHoachVienChuc;
DELETE FROM TacGiaBaiBao;
DELETE FROM BaiBaoKhoaHoc;
DELETE FROM ThamGiaDeTai;
DELETE FROM DeTaiKhoaHoc;
DELETE FROM HopDong;
DELETE FROM VienChuc_BangCap;
DELETE FROM BangCap;
DELETE FROM TaiKhoan;
DELETE FROM BanDanhGiaVienChuc;
DELETE FROM VienChuc;
DELETE FROM NgachLuong;
DELETE FROM ChucVu;
DELETE FROM DonVi;

-- Reset giá trị AUTO_INCREMENT để bắt đầu từ 1
ALTER TABLE ChiTietBangChamDiem AUTO_INCREMENT = 1;
ALTER TABLE BanChamDiemVienChuc AUTO_INCREMENT = 1;
ALTER TABLE ChiTietKetQuaThucHien AUTO_INCREMENT = 1;
ALTER TABLE KetQuaThucHienVienChuc AUTO_INCREMENT = 1;
ALTER TABLE ChiTietKeHoachVienChuc AUTO_INCREMENT = 1;
ALTER TABLE KeHoachVienChuc AUTO_INCREMENT = 1;
ALTER TABLE TacGiaBaiBao AUTO_INCREMENT = 1;
ALTER TABLE BaiBaoKhoaHoc AUTO_INCREMENT = 1;
ALTER TABLE ThamGiaDeTai AUTO_INCREMENT = 1;
ALTER TABLE DeTaiKhoaHoc AUTO_INCREMENT = 1;
ALTER TABLE HopDong AUTO_INCREMENT = 1;
ALTER TABLE VienChuc_BangCap AUTO_INCREMENT = 1;
ALTER TABLE BangCap AUTO_INCREMENT = 1;
ALTER TABLE TaiKhoan AUTO_INCREMENT = 1;
ALTER TABLE BanDanhGiaVienChuc AUTO_INCREMENT = 1;
ALTER TABLE VienChuc AUTO_INCREMENT = 1;
ALTER TABLE NgachLuong AUTO_INCREMENT = 1;
ALTER TABLE ChucVu AUTO_INCREMENT = 1;
ALTER TABLE DonVi AUTO_INCREMENT = 1;

-- Bật lại kiểm tra khóa ngoại
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- 1. Bảng cơ sở: DonVi (Đơn Vị)
-- =============================================
INSERT INTO DonVi (id, ma_donvi, ten_donvi, loai_donvi, mo_ta, trang_thai) VALUES
(1, 'DV001', 'Khoa Công nghệ thông tin', 'Khoa', 'Đào tạo công nghệ thông tin và truyền thông', 1),
(2, 'DV002', 'Khoa Kinh tế và Quản trị kinh doanh', 'Khoa', 'Đào tạo kinh tế, quản trị tài chính doanh nghiệp', 1),
(3, 'DV003', 'Phòng Tổ chức cán bộ', 'Phòng', 'Quản lý nhân sự và hồ sơ cán bộ viên chức', 1),
(4, 'DV004', 'Phòng Đào tạo', 'Phòng', 'Quản lý chương trình đào tạo và sinh viên', 1),
(5, 'DV005', 'Khoa Điện - Điện tử', 'Khoa', 'Đào tạo kỹ thuật điện, điện tử và tự động hóa', 1);

-- =============================================
-- 2. Bảng cơ sở: ChucVu (Chức Vụ)
-- =============================================
INSERT INTO ChucVu (id, ma_chucvu, ten_chucvu, he_so_phu_cap) VALUES
(1, 'CV001', 'Hiệu trưởng', 1.00),
(2, 'CV002', 'Trưởng khoa', 0.60),
(3, 'CV003', 'Phó trưởng khoa', 0.40),
(4, 'CV004', 'Trưởng bộ môn', 0.30),
(5, 'CV005', 'Giảng viên', 0.00);

-- =============================================
-- 3. Bảng cơ sở: NgachLuong (Ngạch Lương)
-- =============================================
INSERT INTO NgachLuong (id, ma_ngach, ten_ngach, bac_luong, he_so_luong) VALUES
(1, 'V.07.01.01', 'Giảng viên cao cấp (Hạng I)', 1, 6.20),
(2, 'V.07.01.02', 'Giảng viên chính (Hạng II)', 1, 4.40),
(3, 'V.07.01.03', 'Giảng viên (Hạng III)', 1, 2.34),
(4, '01.002', 'Chuyên viên chính', 2, 4.74),
(5, '01.003', 'Chuyên viên', 2, 2.68);

-- =============================================
-- 4. Viên chức & Tài khoản: VienChuc (Viên Chức)
-- =============================================
INSERT INTO VienChuc (id, ma_vienchuc, ho_ten, ngay_sinh, gioi_tinh, email, so_dien_thoai, dia_chi, donvi_id, chucvu_id, ngachluong_id, ngay_vao_lam, ngay_nghi, trang_thai) VALUES
(1, 'VC001', 'Nguyễn Văn An', '1980-01-15', 'Nam', 'an.nv@school.edu.vn', '0901234567', '12 Lạc Long Quân, Hà Nội', 1, 2, 1, '2010-09-01', NULL, 1),
(2, 'VC002', 'Trần Thị Bình', '1985-05-20', 'Nữ', 'binh.tt@school.edu.vn', '0902345678', '45 Trần Hưng Đạo, Đà Nẵng', 1, 4, 2, '2012-09-01', NULL, 1),
(3, 'VC003', 'Lê Văn Cường', '1975-10-10', 'Nam', 'cuong.lv@school.edu.vn', '0903456789', '78 Nguyễn Huệ, TP. Hồ Chí Minh', 3, 1, 1, '2005-09-01', NULL, 1),
(4, 'VC004', 'Phạm Minh Dũng', '1990-12-25', 'Nam', 'dung.pm@school.edu.vn', '0904567890', '102 Lê Lợi, Hải Phòng', 4, 5, 3, '2018-09-01', NULL, 1),
(5, 'VC005', 'Hoàng Thu Thủy', '1992-03-30', 'Nữ', 'thuy.ht@school.edu.vn', '0905678901', '89 Lý Tự Trọng, Cần Thơ', 2, 3, 2, '2019-09-01', NULL, 1);

-- =============================================
-- 5. Viên chức & Tài khoản: TaiKhoan (Tài Khoản)
-- Mật khẩu mặc định là '123' đã băm bằng thuật toán BCrypt: $2a$10$Wf9xCj624jjWEhac.coPb.XLZA/4HtXU1pbvDqQNy/wONXtFDbbei
-- =============================================
INSERT INTO TaiKhoan (id, username, password_hash, vienchuc_id, vai_tro, trang_thai, last_login) VALUES
(1, 'an.nv', '$2a$10$Wf9xCj624jjWEhac.coPb.XLZA/4HtXU1pbvDqQNy/wONXtFDbbei', 1, 'TRUONGDONVI', 1, '2026-06-15 08:00:00'),
(2, 'binh.tt', '$2a$10$Wf9xCj624jjWEhac.coPb.XLZA/4HtXU1pbvDqQNy/wONXtFDbbei', 2, 'VIENCHUC', 1, '2026-06-14 14:30:00'),
(3, 'cuong.lv', '$2a$10$Wf9xCj624jjWEhac.coPb.XLZA/4HtXU1pbvDqQNy/wONXtFDbbei', 3, 'HIEUTHUONG', 1, '2026-06-15 07:45:00'),
(4, 'dung.pm', '$2a$10$Wf9xCj624jjWEhac.coPb.XLZA/4HtXU1pbvDqQNy/wONXtFDbbei', 4, 'ADMIN', 1, '2026-06-15 08:30:00'),
(5, 'thuy.ht', '$2a$10$Wf9xCj624jjWEhac.coPb.XLZA/4HtXU1pbvDqQNy/wONXtFDbbei', 5, 'VIENCHUC', 1, '2026-06-12 09:15:00');

-- =============================================
-- 6. Bằng cấp & Hợp đồng: BangCap (Bằng Cấp)
-- =============================================
INSERT INTO BangCap (id, ten_bangcap, chuyen_nganh, cap_bac) VALUES
(1, 'Tiến sĩ', 'Khoa học máy tính', 'Tiến sĩ'),
(2, 'Thạc sĩ', 'Kỹ thuật phần mềm', 'Thạc sĩ'),
(3, 'Tiến sĩ', 'Quản trị kinh doanh', 'Tiến sĩ'),
(4, 'Đại học', 'Công nghệ thông tin', 'Cử nhân'),
(5, 'Thạc sĩ', 'Quản lý giáo dục', 'Thạc sĩ');

-- =============================================
-- 7. Bằng cấp & Hợp đồng: VienChuc_BangCap (Bằng Cấp Viên Chức)
-- =============================================
INSERT INTO VienChuc_BangCap (id, vienchuc_id, bangcap_id, ngay_cap, noi_cap) VALUES
(1, 1, 1, '2015-06-30', 'Đại học Bách Khoa Hà Nội'),
(2, 2, 2, '2013-12-15', 'Đại học Công nghệ - ĐHQGHN'),
(3, 3, 3, '2008-05-20', 'Đại học Kinh tế Quốc dân'),
(4, 4, 4, '2012-06-25', 'Đại học Hàng hải Việt Nam'),
(5, 5, 5, '2017-11-10', 'Đại học Sư phạm TP.HCM');

-- =============================================
-- 8. Bằng cấp & Hợp đồng: HopDong (Hợp Đồng)
-- =============================================
INSERT INTO HopDong (id, vienchuc_id, loai_hopdong, ngay_bat_dau, ngay_ket_thuc, trang_thai) VALUES
(1, 1, 'Hợp đồng làm việc không xác định thời hạn', '2015-09-01', NULL, 1),
(2, 2, 'Hợp đồng làm việc xác định thời hạn 3 năm', '2024-09-01', '2027-08-31', 1),
(3, 3, 'Hợp đồng làm việc không xác định thời hạn', '2005-09-01', NULL, 1),
(4, 4, 'Hợp đồng làm việc xác định thời hạn 2 năm', '2025-01-01', '2026-12-31', 1),
(5, 5, 'Hợp đồng làm việc xác định thời hạn 3 năm', '2024-09-01', '2027-08-31', 1);

-- =============================================
-- 9. Nghiên cứu khoa học: DeTaiKhoaHoc (Đề Tài Khoa Học)
-- =============================================
INSERT INTO DeTaiKhoaHoc (id, ma_detai, ten_detai, nam_hoc, kinh_phi, trang_thai) VALUES
(1, 'DT001', 'Nghiên cứu ứng dụng Học máy trong chuẩn đoán y tế', '2025-2026', 150000000.00, 'DangThucHien'),
(2, 'DT002', 'Xây dựng hệ thống bài giảng tương tác thông minh', '2025-2026', 80000000.00, 'DangThucHien'),
(3, 'DT003', 'Đánh giá mức độ hài lòng của khách hàng trong thương mại điện tử', '2024-2025', 50000000.00, 'DaNghiemThu'),
(4, 'DT004', 'Nghiên cứu thiết kế mạch tích hợp chuyên dụng công suất thấp', '2025-2026', 220000000.00, 'DangThucHien'),
(5, 'DT005', 'Nâng cao kỹ năng chuyển đổi số cho viên chức giáo dục', '2024-2025', 30000000.00, 'DaNghiemThu');

-- =============================================
-- 10. Nghiên cứu khoa học: ThamGiaDeTai (Tham Gia Đề Tài)
-- =============================================
INSERT INTO ThamGiaDeTai (id, detai_id, vienchuc_id, vai_tro) VALUES
(1, 1, 1, 'ChuNhiem'),
(2, 1, 2, 'ThanhVien'),
(3, 2, 2, 'ChuNhiem'),
(4, 3, 5, 'ChuNhiem'),
(5, 4, 1, 'ThanhVien');

-- =============================================
-- 11. Nghiên cứu khoa học: BaiBaoKhoaHoc (Bài Báo Khoa Học)
-- =============================================
INSERT INTO BaiBaoKhoaHoc (id, ten_baibao, tapchi, nam_xuatban) VALUES
(1, 'Machine Learning Models in Healthcare: A Comprehensive Survey', 'IEEE Access', 2025),
(2, 'Interactive Virtual Classrooms: Platforms and Frameworks', 'International Journal of Educational Technology', 2025),
(3, 'The Impact of Social Media Marketing on GenZ Purchasing Behavior', 'Journal of Business Research', 2024),
(4, 'Ultra-Low Power VLSI Circuits Design for IoT Devices', 'IEEE Transactions on VLSI Systems', 2026),
(5, 'Capacity Building for Public Officers in the Digital Era', 'Journal of Public Personnel Management', 2024);

-- =============================================
-- 12. Nghiên cứu khoa học: TacGiaBaiBao (Tác Giả Bài Báo)
-- =============================================
INSERT INTO TacGiaBaiBao (id, baibao_id, vienchuc_id, vai_tro) VALUES
(1, 1, 1, 'Tác giả chính (First Author)'),
(2, 1, 2, 'Đồng tác giả (Co-Author)'),
(3, 2, 2, 'Tác giả chính (First Author)'),
(4, 3, 5, 'Tác giả chính (First Author)'),
(5, 4, 1, 'Đồng tác giả (Co-Author)');

-- =============================================
-- 13. Kế hoạch & Kết quả thực hiện: KeHoachVienChuc (Kế Hoạch Viên Chức)
-- =============================================
INSERT INTO KeHoachVienChuc (id, vienchuc_id, nam_hoc, ky, ngay_lap) VALUES
(1, 1, '2025-2026', 1, '2025-09-05'),
(2, 2, '2025-2026', 1, '2025-09-06'),
(3, 4, '2025-2026', 1, '2025-09-07'),
(4, 5, '2025-2026', 1, '2025-09-08'),
(5, 1, '2025-2026', 2, '2026-02-10');

-- =============================================
-- 14. Kế hoạch & Kết quả thực hiện: ChiTietKeHoachVienChuc (Chi Tiết Kế Hoạch)
-- =============================================
INSERT INTO ChiTietKeHoachVienChuc (id, kehoach_id, noi_dung, chi_tieu, trong_so) VALUES
(1, 1, 'Giảng dạy lý thuyết môn Tin học đại cương cho các lớp CNTT', 'Hoàn thành 90 tiết dạy, chuẩn bị đầy đủ bài giảng', 0.40),
(2, 1, 'Viết và xuất bản 01 bài báo khoa học thuộc danh mục uy tín', 'Đăng thành công trên tạp chí quốc tế', 0.30),
(3, 2, 'Hướng dẫn tốt nghiệp cho 03 sinh viên ngành kỹ thuật phần mềm', '100% sinh viên hoàn thành đề tài đúng hạn', 0.30),
(4, 3, 'Hỗ trợ các công tác hành chính đào tạo và văn phòng khoa', 'Hoàn thành tốt các nhiệm vụ trưởng đơn vị giao', 0.20),
(5, 4, 'Xây dựng và cập nhật đề cương môn học Hệ thống thông tin mới', 'Được hội đồng khoa học khoa thông qua', 0.30);

-- =============================================
-- 15. Kế hoạch & Kết quả thực hiện: KetQuaThucHienVienChuc (Kết Quả Thực Hiện)
-- =============================================
INSERT INTO KetQuaThucHienVienChuc (id, vienchuc_id, nam_hoc, ky, ngay_nop) VALUES
(1, 1, '2025-2026', 1, '2026-01-15'),
(2, 2, '2025-2026', 1, '2026-01-16'),
(3, 4, '2025-2026', 1, '2026-01-17'),
(4, 5, '2025-2026', 1, '2026-01-18'),
(5, 1, '2025-2026', 2, '2026-06-10');

-- =============================================
-- 16. Kế hoạch & Kết quả thực hiện: ChiTietKetQuaThucHien (Chi Tiết Kết Quả Thực Hiện)
-- =============================================
INSERT INTO ChiTietKetQuaThucHien (id, ketqua_id, noi_dung_kehoach, ket_qua_thuc_hien, minh_chung) VALUES
(1, 1, 'Giảng dạy lý thuyết môn Tin học đại cương cho các lớp CNTT', 'Đã giảng dạy hoàn thành 92 tiết lý thuyết, nộp bài điểm đúng hạn', 'Lịch giảng dạy & Bảng điểm sổ tay điện tử'),
(2, 1, 'Viết và xuất bản 01 bài báo khoa học thuộc danh mục uy tín', 'Đã xuất bản bài báo khoa học trên tạp chí IEEE Access tháng 12/2025', 'Liên kết bài báo và chứng nhận đăng bài'),
(3, 2, 'Hướng dẫn tốt nghiệp cho 03 sinh viên ngành kỹ thuật phần mềm', 'Hướng dẫn 3 sinh viên bảo vệ thành công đồ án đạt điểm Giỏi', 'Quyết định thành lập hội đồng & Biên bản chấm đồ án'),
(4, 3, 'Hỗ trợ các công tác hành chính đào tạo và văn phòng khoa', 'Hỗ trợ tổ chức thành công 02 buổi hội thảo khoa học cấp khoa', 'Kế hoạch tổ chức và báo cáo tổng kết hội thảo'),
(5, 4, 'Xây dựng và cập nhật đề cương môn học Hệ thống thông tin mới', 'Đã hoàn thành biên soạn và được hội đồng khoa học phê duyệt', 'Nghị quyết phê duyệt đề cương chi tiết môn học');

-- =============================================
-- 17. Đánh giá viên chức: BanChamDiemVienChuc (Bản Chấm Điểm)
-- =============================================
INSERT INTO BanChamDiemVienChuc (id, ten_bangcham, nam_hoc, ky, mo_ta) VALUES
(1, 'Phiếu tự đánh giá hiệu quả giảng viên - Học kỳ 1', '2025-2026', 1, 'Áp dụng cho giảng viên cơ hữu thuộc khối giảng dạy lý thuyết thực hành'),
(2, 'Phiếu tự đánh giá hiệu quả giảng viên - Học kỳ 2', '2025-2026', 2, 'Áp dụng cho giảng viên cơ hữu thuộc khối giảng dạy lý thuyết thực hành'),
(3, 'Phiếu đánh giá hiệu quả công việc chuyên viên - Học kỳ 1', '2025-2026', 1, 'Áp dụng cho chuyên viên hành chính, phục vụ đào tạo các phòng ban'),
(4, 'Phiếu đánh giá hiệu quả công việc chuyên viên - Học kỳ 2', '2025-2026', 2, 'Áp dụng cho chuyên viên hành chính, phục vụ đào tạo các phòng ban'),
(5, 'Phiếu tự đánh giá giảng viên lịch sử', '2024-2025', 2, 'Áp dụng cho giảng viên các khoa trong năm học trước');

-- =============================================
-- 18. Đánh giá viên chức: ChiTietBangChamDiem (Chi Tiết Bản Chấm Điểm)
-- =============================================
INSERT INTO ChiTietBangChamDiem (id, banchamdiem_id, noi_dung, diem_toi_da, trong_so) VALUES
(1, 1, 'Thực hiện đầy đủ nhiệm vụ giảng dạy và kế hoạch đào tạo (số giờ dạy học thực tế)', 50.00, 1.00),
(2, 1, 'Hoàn thành các chỉ tiêu nghiên cứu khoa học, viết sách giáo trình, bài báo khoa học', 30.00, 1.00),
(3, 1, 'Chấp hành đầy đủ chủ trương đường lối của Đảng, quy chế của nhà trường và kỷ luật lao động', 20.00, 1.00),
(4, 3, 'Chất lượng và tiến độ hoàn thành các công việc chuyên môn được phân công', 70.00, 1.00),
(5, 3, 'Thái độ phục vụ người học, thực hiện văn hóa giao tiếp công sở và nội quy cơ quan', 30.00, 1.00);

-- =============================================
-- 19. Đánh giá viên chức: BanDanhGiaVienChuc (Bản Đánh Giá)
-- =============================================
INSERT INTO BanDanhGiaVienChuc (id, vienchuc_id, nam_hoc, ky, nguoi_danhgia_id, loai_danhgia, tong_diem, xep_loai, ngay_danhgia, ghi_chu) VALUES
(1, 1, '2025-2026', 1, 1, 'TuDanhGia', 92.50, 'Xuất sắc', '2026-01-20', 'Cá nhân tự đánh giá hoàn thành xuất sắc nhiệm vụ kỳ 1'),
(2, 1, '2025-2026', 1, 3, 'CapTren', 90.00, 'Xuất sắc', '2026-01-22', 'Trưởng đơn vị nhất trí xếp loại Xuất sắc, có nhiều đóng góp nghiên cứu khoa học'),
(3, 2, '2025-2026', 1, 2, 'TuDanhGia', 96.00, 'Xuất sắc', '2026-01-20', 'Cá nhân hoàn thành vượt mức giờ giảng và số lượng bài báo khoa học'),
(4, 2, '2025-2026', 1, 1, 'CapTren', 96.00, 'Xuất sắc', '2026-01-22', 'Trưởng khoa đánh giá xuất sắc năng lực chuyên môn và nghiên cứu khoa học'),
(5, 4, '2025-2026', 1, 4, 'TuDanhGia', 82.00, 'Tốt', '2026-01-20', 'Tự đánh giá hoàn thành nhiệm vụ hỗ trợ văn phòng tốt');
