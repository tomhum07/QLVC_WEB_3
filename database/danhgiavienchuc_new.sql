-- =============================================
-- DATABASE: danhgiavienchuc (EXACT SCHEMA FROM IMAGES WITH utf8mb4)
-- =============================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS danhgiavienchuc;
CREATE DATABASE danhgiavienchuc 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE danhgiavienchuc;

-- =============================================
-- 1. Bảng donvi
-- =============================================
DROP TABLE IF EXISTS donvi;
CREATE TABLE donvi (
    msdonvi         VARCHAR(2) PRIMARY KEY,
    tendonvi        VARCHAR(100) NOT NULL,
    nhom            VARCHAR(1) NULL,
    songuoi         INT DEFAULT 0,
    ghichu          VARCHAR(100) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 2. Bảng chucvu
-- =============================================
DROP TABLE IF EXISTS chucvu;
CREATE TABLE chucvu (
    mschucvu        VARCHAR(2) PRIMARY KEY,
    tenchucvu       VARCHAR(100) NOT NULL,
    msnhomvc        INT NULL,
    phucap          DOUBLE DEFAULT 0.0,
    ghichu          VARCHAR(100) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 3. Bảng ngach
-- =============================================
DROP TABLE IF EXISTS ngach;
CREATE TABLE ngach (
    msngach         VARCHAR(8) PRIMARY KEY,
    tenngach        VARCHAR(50) NOT NULL,
    hang            INT NULL,
    ghichu          VARCHAR(50) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 4. Bảng nhomvc
-- =============================================
DROP TABLE IF EXISTS nhomvc;
CREATE TABLE nhomvc (
    msnhomvc        VARCHAR(2) PRIMARY KEY,
    tennhomvc       VARCHAR(50) NOT NULL,
    ghichu          VARCHAR(50) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 5. Bảng vienchuc
-- =============================================
DROP TABLE IF EXISTS vienchuc;
CREATE TABLE vienchuc (
    msvc            VARCHAR(10) PRIMARY KEY,
    hoten           VARCHAR(100) NOT NULL,
    ngaysinh        VARCHAR(10) NULL,
    phai            VARCHAR(1) NULL, -- '1' for Nam, '0' for Nữ
    noisinh         VARCHAR(100) NULL,
    msngach         VARCHAR(8) NULL,
    mschucvu        VARCHAR(2) NOT NULL,
    msdonvi         VARCHAR(2) NOT NULL,
    msnhomvc        VARCHAR(2) NULL,
    vc_nld          VARCHAR(1) NULL,
    ten             VARCHAR(50) UNIQUE NOT NULL, -- Tên đăng nhập
    matkhau         VARCHAR(100) NOT NULL, -- Mật khẩu
    quyen           VARCHAR(1) NOT NULL, -- '1' = Admin, '2' = Trưởng đơn vị, '3' = Viên chức
    ghichuvc        VARCHAR(100) NULL,
    
    FOREIGN KEY (msdonvi) REFERENCES donvi(msdonvi),
    FOREIGN KEY (mschucvu) REFERENCES chucvu(mschucvu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 6. Bảng detaikhoahoc (NCKH)
-- =============================================
DROP TABLE IF EXISTS detaikhoahoc;
CREATE TABLE detaikhoahoc (
    madt            VARCHAR(20) PRIMARY KEY,
    tendetai        VARCHAR(255) NOT NULL,
    cap             VARCHAR(50) NOT NULL,
    ngaynghiemthu   DATE NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 7. Bảng thamgia
-- =============================================
DROP TABLE IF EXISTS thamgia;
CREATE TABLE thamgia (
    madt            VARCHAR(20) NOT NULL,
    msvc            VARCHAR(10) NOT NULL,
    PRIMARY KEY (madt, msvc),
    FOREIGN KEY (madt) REFERENCES detaikhoahoc(madt) ON DELETE CASCADE,
    FOREIGN KEY (msvc) REFERENCES vienchuc(msvc) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 8. Bảng baibaokhoahoc
-- =============================================
DROP TABLE IF EXISTS baibaokhoahoc;
CREATE TABLE baibaokhoahoc (
    mabbkh          VARCHAR(20) PRIMARY KEY,
    tenbaibao       VARCHAR(255) NOT NULL,
    ngaydangbaibao  DATE NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 9. Bảng tacgia
-- =============================================
DROP TABLE IF EXISTS tacgia;
CREATE TABLE tacgia (
    msvc            VARCHAR(10) NOT NULL,
    mabbkh          VARCHAR(20) NOT NULL,
    PRIMARY KEY (msvc, mabbkh),
    FOREIGN KEY (msvc) REFERENCES vienchuc(msvc) ON DELETE CASCADE,
    FOREIGN KEY (mabbkh) REFERENCES baibaokhoahoc(mabbkh) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 10. Bảng bangcap
-- =============================================
DROP TABLE IF EXISTS bangcap;
CREATE TABLE bangcap (
    mabc            VARCHAR(20) PRIMARY KEY,
    tenbangcap      VARCHAR(100) NOT NULL,
    nam             INT NOT NULL,
    truongcap       VARCHAR(150) NULL,
    msvc            VARCHAR(10) NOT NULL,
    FOREIGN KEY (msvc) REFERENCES vienchuc(msvc) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 11. Bảng hopdong
-- =============================================
DROP TABLE IF EXISTS hopdong;
CREATE TABLE hopdong (
    mahd            VARCHAR(20) PRIMARY KEY,
    tenhopdong      VARCHAR(150) NOT NULL,
    ngay            DATE NOT NULL,
    noidung         TEXT NULL,
    msvc            VARCHAR(10) NOT NULL,
    FOREIGN KEY (msvc) REFERENCES vienchuc(msvc) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 12. Bảng noidungkhvcgv (22 dòng từ hình 1)
-- =============================================
DROP TABLE IF EXISTS noidungkhvcgv;
CREATE TABLE noidungkhvcgv (
    stt             INT NOT NULL,
    muc             VARCHAR(6) PRIMARY KEY,
    congviec        TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 13. Bảng noidungkhvchc (dành cho hành chính)
-- =============================================
DROP TABLE IF EXISTS noidungkhvchc;
CREATE TABLE noidungkhvchc (
    stt             INT NOT NULL,
    muc             VARCHAR(6) PRIMARY KEY,
    congviec        TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 14. Bảng kehoachvc
-- =============================================
DROP TABLE IF EXISTS kehoachvc;
CREATE TABLE kehoachvc (
    mskhvc          VARCHAR(6) PRIMARY KEY,
    msvc            VARCHAR(10) NOT NULL,
    ngay            VARCHAR(10) NOT NULL,
    namhoc          VARCHAR(20) NOT NULL, -- Năm học + học kỳ (VD: '2025-2026/HK1')
    danhhieu        VARCHAR(50) NULL,
    khenthuong      VARCHAR(50) NULL,
    xacnhan         VARCHAR(1) DEFAULT '0', -- '0' = Chưa nộp, '1' = Đã nộp
    duyet           VARCHAR(1) DEFAULT '0', -- '0' = Chưa duyệt, '1' = Đã duyệt
    
    FOREIGN KEY (msvc) REFERENCES vienchuc(msvc) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 15. Bảng chitietkhthvcgv (Chi tiết kế hoạch giảng viên)
-- =============================================
DROP TABLE IF EXISTS chitietkhthvcgv;
CREATE TABLE chitietkhthvcgv (
    mskhvc          VARCHAR(6) NOT NULL,
    muc             VARCHAR(6) NOT NULL,
    congviec        TEXT NULL,
    kehoachthuchien TEXT NULL,
    chitieu         TEXT NULL,
    thoigiankh      VARCHAR(50) NULL,
    thoigianth      VARCHAR(50) NULL,
    sanphamkh       TEXT NULL,
    sanphamth       TEXT NULL,
    ketqua          TEXT NULL,
    ghichu          TEXT NULL,
    minhchung       TEXT NULL,
    kiemtra         VARCHAR(1) DEFAULT '0',
    tuxacnhan       VARCHAR(1) DEFAULT '0',
    donvixacnhan    VARCHAR(1) DEFAULT '0',
    
    PRIMARY KEY (mskhvc, muc),
    FOREIGN KEY (mskhvc) REFERENCES kehoachvc(mskhvc) ON DELETE CASCADE,
    FOREIGN KEY (muc) REFERENCES noidungkhvcgv(muc)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- 16. Bảng bcdvc (Bảng đánh giá / chấm điểm viên chức)
-- =============================================
DROP TABLE IF EXISTS bcdvc;
CREATE TABLE bcdvc (
    msbcdvc         VARCHAR(8) PRIMARY KEY,
    msvc            VARCHAR(10) NOT NULL,
    namhoc          VARCHAR(20) NOT NULL,
    ngay            VARCHAR(10) NOT NULL,
    tongdiem        INT DEFAULT 0,
    tuxeploai       VARCHAR(30) NULL,
    capthamquyenxeploai VARCHAR(30) NULL,
    duyet           VARCHAR(1) DEFAULT '0',
    nhanxetctq      VARCHAR(255) NULL,
    
    FOREIGN KEY (msvc) REFERENCES vienchuc(msvc) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;


-- =========================================================================
-- MOCK DATA: Chèn dữ liệu mẫu tiếng Việt chuẩn không lỗi font
-- =========================================================================

-- 1. Bảng donvi
INSERT INTO donvi (msdonvi, tendonvi, nhom, songuoi, ghichu) VALUES
('CN', 'Khoa Công nghệ thông tin', 'A', 25, 'Đào tạo công nghệ'),
('KT', 'Phòng Kế toán', 'B', 10, 'Hành chính kế toán');

-- 2. Bảng chucvu
INSERT INTO chucvu (mschucvu, tenchucvu, msnhomvc, phucap, ghichu) VALUES
('GV', 'Giảng viên', 1, 0.20, 'Giảng dạy lý thuyết thực hành'),
('TK', 'Trưởng khoa', 1, 0.50, 'Quản lý đào tạo cấp khoa'),
('CV', 'Chuyên viên', 2, 0.00, 'Hành chính phục vụ');

-- 3. Bảng ngach
INSERT INTO ngach (msngach, tenngach, hang, ghichu) VALUES
('V1', 'Giảng viên cao cấp', 1, 'Hạng I'),
('V2', 'Giảng viên chính', 2, 'Hạng II'),
('V3', 'Giảng viên', 3, 'Hạng III');

-- 4. Bảng nhomvc
INSERT INTO nhomvc (msnhomvc, tennhomvc, ghichu) VALUES
('G', 'Giảng dạy', 'Khối giảng viên'),
('H', 'Hành chính', 'Khối chuyên viên');

-- 5. Bảng vienchuc
INSERT INTO vienchuc (msvc, hoten, ngaysinh, phai, noisinh, msngach, mschucvu, msdonvi, msnhomvc, vc_nld, ten, matkhau, quyen, ghichuvc) VALUES
('VC001', 'Nguyễn Văn Anh', '1990-05-15', '1', 'Đồng Tháp', 'V1', 'GV', 'CN', 'G', '1', 'Anh', '123456', '1', 'Giảng viên khoa CNTT'),
('VC002', 'Trần Thị Mỹ', '1995-10-20', '0', 'Hồ Chí Minh', 'V2', 'TK', 'CN', 'G', '1', 'My', '123456', '2', 'Trưởng khoa CNTT kiêm Quản lý'),
('VC003', 'Lê Văn Bình', '1993-02-12', '1', 'Đà Nẵng', 'V3', 'GV', 'CN', 'G', '1', 'Binh', '123456', '3', 'Giảng viên giảng dạy cơ hữu');

-- 6. Bảng detaikhoahoc
INSERT INTO detaikhoahoc (madt, tendetai, cap, ngaynghiemthu) VALUES
('DT001', 'Nghiên cứu ứng dụng học máy trong chuỗi cung ứng', 'Cấp Bộ', '2026-05-10'),
('DT002', 'Xây dựng hệ thống học tập trực tuyến bằng bài giảng tương tác thông minh', 'Cấp Trường', '2026-06-01'),
('DT003', 'Đánh giá mức độ hài lòng của khách hàng trong thương mại điện tử', 'Cấp Trường', '2025-04-15'),
('DT004', 'Nghiên cứu thiết kế mạch tích hợp chuyên dụng công suất thấp', 'Cấp Tỉnh', NULL),
('DT005', 'Nâng cao kỹ năng chuyển đổi số cho viên chức giáo dục', 'Cấp Bộ', '2025-11-20');

-- 7. Bảng thamgia
INSERT INTO thamgia (madt, msvc) VALUES
('DT001', 'VC003'),
('DT002', 'VC003'),
('DT003', 'VC002'),
('DT004', 'VC003'),
('DT005', 'VC001');

-- 8. Bảng baibaokhoahoc
INSERT INTO baibaokhoahoc (mabbkh, tenbaibao, ngaydangbaibao) VALUES
('BB001', 'Ứng dụng học máy cải thiện chẩn đoán y khoa', '2025-12-15'),
('BB002', 'Xây dựng giảng đường thông minh dựa trên IoT', '2025-10-20'),
('BB003', 'Khảo sát hành vi người tiêu dùng GenZ', '2024-05-18'),
('BB004', 'Thiết kế vi mạch tích hợp tiết kiệm năng lượng', '2026-03-22'),
('BB005', 'Chuyển đổi số trong đào tạo đại học', '2024-08-30');

-- 9. Bảng tacgia
INSERT INTO tacgia (msvc, mabbkh) VALUES
('VC003', 'BB001'),
('VC003', 'BB002'),
('VC002', 'BB003'),
('VC003', 'BB004'),
('VC001', 'BB005');

-- 10. Bảng bangcap
INSERT INTO bangcap (mabc, tenbangcap, nam, truongcap, msvc) VALUES
('BC001', 'Tiến sĩ Khoa học máy tính', 2018, 'Đại học Bách Khoa Hà Nội', 'VC001'),
('BC002', 'Thạc sĩ Hệ thống thông tin', 2020, 'Đại học Công nghệ', 'VC002'),
('BC003', 'Thạc sĩ Kỹ thuật phần mềm', 2021, 'Đại học Đà Nẵng', 'VC003');

-- 11. Bảng hopdong
INSERT INTO hopdong (mahd, tenhopdong, ngay, noidung, msvc) VALUES
('HD001', 'Hợp đồng làm việc không xác định thời hạn', '2018-09-01', 'Giảng dạy và nghiên cứu khoa học chuyên trách tại Khoa CNTT', 'VC001'),
('HD002', 'Hợp đồng làm việc xác định thời hạn 3 năm', '2020-09-01', 'Giảng dạy và thực hiện nhiệm vụ quản lý khoa', 'VC002'),
('HD003', 'Hợp đồng thử việc', '2021-09-01', 'Giảng dạy và nghiên cứu cơ bản', 'VC003');

-- 12. Bảng noidungkhvcgv
INSERT INTO noidungkhvcgv (stt, muc, congviec) VALUES
(1, 'I.1', 'Giảng dạy hệ chính quy'),
(2, 'I.2', 'Giảng dạy liên thông'),
(3, 'I.3', 'Giảng dạy các loại hình khác'),
(4, 'II.1', 'Đề tài nghiên cứu khoa học'),
(5, 'II.2', 'Hướng dẫn đề tài nghiên cứu khoa học của sinh viên'),
(6, 'II.3', 'Tham gia hội đồng khoa học'),
(7, 'II.4', 'Tham gia Hội đồng thẩm định'),
(8, 'II.5', 'Tham dự Hội thảo khoa học, Semina...'),
(9, 'II.6', 'Bài báo khoa học'),
(10, 'II.7', 'Phát minh, sáng kiến'),
(11, 'II.8', 'Sách chuyên khảo, giáo trình, sách tham khảo, sách chuyên ngành'),
(12, 'II.9', 'Biên soạn, chỉnh sửa bài giảng'),
(13, 'II.10', 'Hướng dẫn sinh viên đạt các giải thưởng khoa học'),
(14, 'II.11', 'Hoạt động NCKH khác'),
(15, 'III.1', 'Thư ký kỳ thi'),
(16, 'III.2', 'Giám sát kỳ thi'),
(17, 'III.3', 'Ra đề thi'),
(18, 'III.4', 'Chấm thi, chấm chuyên đề học phần, tiểu luận'),
(19, 'III.5', 'Coi thi'),
(20, 'IV', 'Công tác phục vụ cộng đồng (ủng hộ, tự nguyện, ứng phó thiên tai, xã hội...)'),
(21, 'V', 'Công tác học tập, bồi dưỡng, tập huấn nâng cao trình độ'),
(22, 'VI', 'Các hoạt động khác');

-- 13. Bảng kehoachvc
INSERT INTO kehoachvc (mskhvc, msvc, ngay, namhoc, danhhieu, khenthuong, xacnhan, duyet) VALUES
('KH001', 'VC003', '2026-06-15', '2025-2026/HK1', 'Chiến sĩ thi đua', 'Bằng khen cấp Bộ', '1', '1'),
('KH002', 'VC001', '2026-06-15', '2025-2026/HK1', 'Lao động tiên tiến', 'Giấy khen cấp Trường', '1', '0');

-- 14. Bảng chitietkhthvcgv
INSERT INTO chitietkhthvcgv (mskhvc, muc, congviec, kehoachthuchien, chitieu, thoigiankh, thoigianth, sanphamkh, sanphamth, ketqua, ghichu, minhchung, kiemtra, tuxacnhan, donvixacnhan) VALUES
('KH001', 'I.1', 'Giảng dạy các lớp Kỹ thuật phần mềm', 'Hoàn thành đầy đủ số tiết giảng dạy lý thuyết', '150 giờ', 'Tháng 9 - Tháng 1', 'Tháng 9 - Tháng 1', 'Đầy đủ bài giảng và sổ tay điện tử', 'Hoàn thành xuất sắc', 'Đạt yêu cầu', '', 'Lịch giảng dạy & Bảng điểm sổ tay', '1', '1', '1'),
('KH001', 'I.2', 'Giảng dạy liên thông lớp đêm', 'Giảng dạy và hướng dẫn đồ án tốt nghiệp', '100 giờ', 'Tháng 10 - Tháng 1', 'Tháng 10 - Tháng 1', 'Sổ điểm học phần', 'Hoàn thành đúng hạn', 'Đạt yêu cầu', '', 'Bảng điểm lớp liên thông', '1', '1', '1'),
('KH001', 'II.6', 'Viết và đăng bài báo khoa học', 'Viết và công bố bài báo khoa học về AI', '1 bài báo', 'Tháng 9 - Tháng 12', 'Tháng 10 - Tháng 12', 'Bài báo khoa học đăng tạp chí', 'Đã xuất bản bài báo khoa học trên IEEE Access', 'Đạt yêu cầu', '', 'Bài báo bản in & Link bài báo', '1', '1', '1'),
('KH002', 'I.1', 'Giảng dạy các lớp mạng máy tính', 'Hoàn thành 120 tiết giảng dạy mạng máy tính', '120 giờ', 'Tháng 9 - Tháng 1', 'Tháng 9 - Tháng 1', 'Đầy đủ giáo án điện tử', 'Đã hoàn thành', 'Đạt', '', 'Sổ điểm', '0', '1', '0');

-- 15. Bảng bcdvc
INSERT INTO bcdvc (msbcdvc, msvc, namhoc, ngay, tongdiem, tuxeploai, capthamquyenxeploai, duyet, nhanxetctq) VALUES
('BC001', 'VC003', '2025-2026/HK1', '2026-06-15', 92, 'Xuất sắc', 'Xuất sắc', '1', 'Hoàn thành vượt định mức chỉ tiêu đề ra');
