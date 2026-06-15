-- =============================================
-- DATABASE: QuanLyDanhGiaVienChuc
-- =============================================
CREATE DATABASE IF NOT EXISTS quanlydanhgiavc 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quanlydanhgiavc;

-- =============================================
-- 1. Bảng cơ sở
-- =============================================

CREATE TABLE DonVi (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ma_donvi        VARCHAR(20) UNIQUE NOT NULL,
    ten_donvi       VARCHAR(150) NOT NULL,
    loai_donvi      VARCHAR(50) NULL,           -- Khoa, Phòng, Bộ môn...
    mo_ta           TEXT NULL,
    trang_thai      TINYINT(1) DEFAULT 1,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE ChucVu (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ma_chucvu       VARCHAR(20) UNIQUE NOT NULL,
    ten_chucvu      VARCHAR(100) NOT NULL,
    he_so_phu_cap   FLOAT DEFAULT 0.0,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE NgachLuong (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ma_ngach        VARCHAR(20) UNIQUE NOT NULL,
    ten_ngach       VARCHAR(100) NOT NULL,
    bac_luong       INT NOT NULL,
    he_so_luong     DECIMAL(5,2) NOT NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================
-- 2. Viên chức & Tài khoản
-- =============================================

CREATE TABLE VienChuc (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    ma_vienchuc         VARCHAR(20) UNIQUE NOT NULL,
    ho_ten              VARCHAR(100) NOT NULL,
    ngay_sinh           DATE NOT NULL,
    gioi_tinh           ENUM('Nam', 'Nữ', 'Khác') NOT NULL,
    email               VARCHAR(100) UNIQUE NULL,
    so_dien_thoai       VARCHAR(15) NULL,
    dia_chi             VARCHAR(255) NULL,
    donvi_id            INT NOT NULL,
    chucvu_id           INT NULL,
    ngachluong_id       INT NULL,
    ngay_vao_lam        DATE NOT NULL,
    ngay_nghi           DATE NULL,
    trang_thai          TINYINT(1) DEFAULT 1,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (donvi_id) REFERENCES DonVi(id),
    FOREIGN KEY (chucvu_id) REFERENCES ChucVu(id),
    FOREIGN KEY (ngachluong_id) REFERENCES NgachLuong(id)
) ENGINE=InnoDB;

CREATE TABLE TaiKhoan (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(50) UNIQUE NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    vienchuc_id     INT UNIQUE NULL,
    vai_tro         ENUM('ADMIN', 'VIENCHUC', 'TRUONGDONVI', 'HIEUTHUONG') NOT NULL,
    trang_thai      TINYINT(1) DEFAULT 1,
    last_login      DATETIME NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (vienchuc_id) REFERENCES VienChuc(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- =============================================
-- 3. Bằng cấp & Hợp đồng
-- =============================================

CREATE TABLE BangCap (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ten_bangcap     VARCHAR(100) NOT NULL,
    chuyen_nganh    VARCHAR(100) NULL,
    cap_bac         VARCHAR(50) NULL
) ENGINE=InnoDB;

CREATE TABLE VienChuc_BangCap (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    vienchuc_id     INT NOT NULL,
    bangcap_id      INT NOT NULL,
    ngay_cap        DATE NOT NULL,
    noi_cap         VARCHAR(150) NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (vienchuc_id) REFERENCES VienChuc(id) ON DELETE CASCADE,
    FOREIGN KEY (bangcap_id) REFERENCES BangCap(id),
    UNIQUE KEY uk_vcbangcap (vienchuc_id, bangcap_id)
) ENGINE=InnoDB;

CREATE TABLE HopDong (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    vienchuc_id         INT NOT NULL,
    loai_hopdong        VARCHAR(100) NOT NULL,
    ngay_bat_dau        DATE NOT NULL,
    ngay_ket_thuc       DATE NULL,
    trang_thai          TINYINT(1) DEFAULT 1,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (vienchuc_id) REFERENCES VienChuc(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================
-- 4. Nghiên cứu khoa học
-- =============================================

CREATE TABLE DeTaiKhoaHoc (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ma_detai        VARCHAR(30) UNIQUE NOT NULL,
    ten_detai       VARCHAR(300) NOT NULL,
    nam_hoc         VARCHAR(9) NOT NULL,           -- ví dụ: 2025-2026
    kinh_phi        DECIMAL(15,2) DEFAULT 0,
    trang_thai      VARCHAR(50) DEFAULT 'DangThucHien',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE ThamGiaDeTai (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    detai_id        INT NOT NULL,
    vienchuc_id     INT NOT NULL,
    vai_tro         VARCHAR(50) NOT NULL,          -- ChuNhiem, ThanhVien...
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (detai_id) REFERENCES DeTaiKhoaHoc(id) ON DELETE CASCADE,
    FOREIGN KEY (vienchuc_id) REFERENCES VienChuc(id) ON DELETE CASCADE,
    UNIQUE KEY uk_thamgia (detai_id, vienchuc_id)
) ENGINE=InnoDB;

CREATE TABLE BaiBaoKhoaHoc (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ten_baibao      VARCHAR(300) NOT NULL,
    tapchi          VARCHAR(150) NULL,
    nam_xuatban     YEAR NOT NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE TacGiaBaiBao (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    baibao_id       INT NOT NULL,
    vienchuc_id     INT NOT NULL,
    vai_tro         VARCHAR(50) NOT NULL,
FOREIGN KEY (baibao_id) REFERENCES BaiBaoKhoaHoc(id) ON DELETE CASCADE,
    FOREIGN KEY (vienchuc_id) REFERENCES VienChuc(id) ON DELETE CASCADE,
    UNIQUE KEY uk_tacgia (baibao_id, vienchuc_id)
) ENGINE=InnoDB;

-- =============================================
-- 5. Kế hoạch & Kết quả thực hiện
-- =============================================

CREATE TABLE KeHoachVienChuc (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    vienchuc_id         INT NOT NULL,
    nam_hoc             VARCHAR(9) NOT NULL,
    ky                  TINYINT NOT NULL,               -- 1 hoặc 2
    ngay_lap            DATE NOT NULL,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (vienchuc_id) REFERENCES VienChuc(id),
    UNIQUE KEY uk_kehoach (vienchuc_id, nam_hoc, ky)
) ENGINE=InnoDB;

CREATE TABLE ChiTietKeHoachVienChuc (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    kehoach_id          INT NOT NULL,
    noi_dung            TEXT NOT NULL,
    chi_tieu            VARCHAR(200) NULL,
    trong_so            DECIMAL(5,2) DEFAULT 1.00,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (kehoach_id) REFERENCES KeHoachVienChuc(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE KetQuaThucHienVienChuc (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    vienchuc_id         INT NOT NULL,
    nam_hoc             VARCHAR(9) NOT NULL,
    ky                  TINYINT NOT NULL,
    ngay_nop            DATE NOT NULL,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (vienchuc_id) REFERENCES VienChuc(id),
    UNIQUE KEY uk_ketqua (vienchuc_id, nam_hoc, ky)
) ENGINE=InnoDB;

CREATE TABLE ChiTietKetQuaThucHien (
    id                      INT AUTO_INCREMENT PRIMARY KEY,
    ketqua_id               INT NOT NULL,
    noi_dung_kehoach        TEXT NULL,
    ket_qua_thuc_hien       TEXT NOT NULL,
    minh_chung              VARCHAR(255) NULL,
    created_at              DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ketqua_id) REFERENCES KetQuaThucHienVienChuc(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================
-- 6. Đánh giá viên chức
-- =============================================

CREATE TABLE BanChamDiemVienChuc (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    ten_bangcham        VARCHAR(100) NOT NULL,
    nam_hoc             VARCHAR(9) NOT NULL,
    ky                  TINYINT NOT NULL,
    mo_ta               TEXT NULL,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE ChiTietBangChamDiem (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    banchamdiem_id      INT NOT NULL,
    noi_dung            TEXT NOT NULL,
    diem_toi_da         DECIMAL(5,2) NOT NULL,
    trong_so            DECIMAL(5,2) DEFAULT 1.00,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (banchamdiem_id) REFERENCES BanChamDiemVienChuc(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE BanDanhGiaVienChuc (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    vienchuc_id         INT NOT NULL,
    nam_hoc             VARCHAR(9) NOT NULL,
    ky                  TINYINT NOT NULL,
    nguoi_danhgia_id    INT NOT NULL,
    loai_danhgia        VARCHAR(50) NOT NULL,           -- TuDanhGia, CapTren, HoiDong...
    tong_diem           DECIMAL(5,2) DEFAULT 0.00,
    xep_loai            VARCHAR(50) NULL,               -- Xuất sắc, Tốt, Đạt...
    ngay_danhgia        DATE NOT NULL,
    ghi_chu             TEXT NULL,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (vienchuc_id) REFERENCES VienChuc(id),
    FOREIGN KEY (nguoi_danhgia_id) REFERENCES VienChuc(id)
) ENGINE=InnoDB;

-- =============================================
-- Index tối ưu
-- =============================================
CREATE INDEX idx_vienchuc_donvi ON VienChuc(donvi_id);
CREATE INDEX idx_banhdanhgia_vienchuc ON BanDanhGiaVienChuc(vienchuc_id, nam_hoc, ky);
CREATE INDEX idx_kehoach_vienchuc ON KeHoachVienChuc(vienchuc_id, nam_hoc, ky);