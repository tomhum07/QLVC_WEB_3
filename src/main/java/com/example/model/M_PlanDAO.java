package com.example.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * TẦNG MODEL: DAO xử lý các nghiệp vụ liên quan đến Kế hoạch viên chức
 */
public class M_PlanDAO {

    /**
     * Lấy thông tin chi tiết viên chức theo tên đăng nhập (ten)
     */
    public M_VienChuc getVienChucByUsername(String username) {
        String sql = "SELECT vc.msvc, vc.hoten, cv.tenchucvu, dv.tendonvi, vc.quyen " +
                     "FROM vienchuc vc " +
                     "LEFT JOIN chucvu cv ON vc.mschucvu = cv.mschucvu " +
                     "LEFT JOIN donvi dv ON vc.msdonvi = dv.msdonvi " +
                     "WHERE vc.ten = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new M_VienChuc(
                        rs.getString("msvc"),
                        rs.getString("hoten"),
                        rs.getString("tenchucvu"),
                        rs.getString("tendonvi"),
                        rs.getString("quyen")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy thông tin chi tiết viên chức theo mã viên chức (msvc)
     */
    public M_VienChuc getVienChucByMsvc(String msvc) {
        String sql = "SELECT vc.msvc, vc.hoten, cv.tenchucvu, dv.tendonvi, vc.quyen " +
                     "FROM vienchuc vc " +
                     "LEFT JOIN chucvu cv ON vc.mschucvu = cv.mschucvu " +
                     "LEFT JOIN donvi dv ON vc.msdonvi = dv.msdonvi " +
                     "WHERE vc.msvc = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, msvc);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new M_VienChuc(
                        rs.getString("msvc"),
                        rs.getString("hoten"),
                        rs.getString("tenchucvu"),
                        rs.getString("tendonvi"),
                        rs.getString("quyen")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy danh sách tất cả viên chức trong hệ thống
     */
    public List<M_VienChuc> getAllVienChuc() {
        List<M_VienChuc> list = new ArrayList<>();
        String sql = "SELECT vc.msvc, vc.hoten, cv.tenchucvu, dv.tendonvi, vc.quyen " +
                     "FROM vienchuc vc " +
                     "LEFT JOIN chucvu cv ON vc.mschucvu = cv.mschucvu " +
                     "LEFT JOIN donvi dv ON vc.msdonvi = dv.msdonvi " +
                     "ORDER BY vc.msvc";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new M_VienChuc(
                    rs.getString("msvc"),
                    rs.getString("hoten"),
                    rs.getString("tenchucvu"),
                    rs.getString("tendonvi"),
                    rs.getString("quyen")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy thông tin Header Kế Hoạch của 1 viên chức trong 1 năm học
     */
    public M_KeHoachHeader getKeHoachHeader(String msvc, String namhoc) {
        String sql = "SELECT mskhvc, msvc, ngay, namhoc, danhhieu, khenthuong, xacnhan, duyet " +
                     "FROM kehoachvc " +
                     "WHERE msvc = ? AND namhoc = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, msvc);
            ps.setString(2, namhoc);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new M_KeHoachHeader(
                        rs.getString("mskhvc"),
                        rs.getString("msvc"),
                        rs.getString("ngay"),
                        rs.getString("namhoc"),
                        rs.getString("danhhieu"),
                        rs.getString("khenthuong"),
                        rs.getString("xacnhan"),
                        rs.getString("duyet")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy danh sách chi tiết các công việc của 1 Kế hoạch
     */
    public List<M_KeHoachDetail> getKeHoachDetails(String mskhvc) {
        List<M_KeHoachDetail> list = new ArrayList<>();
        String sql = "SELECT mskhvc, muc, congviec, kehoachthuchien, chitieu, thoigiankh, sanphamkh, ghichu, kiemtra " +
                     "FROM chitietkhthvcgv " +
                     "WHERE mskhvc = ? " +
                     "ORDER BY muc";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, mskhvc);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new M_KeHoachDetail(
                        rs.getString("mskhvc"),
                        rs.getString("muc"),
                        rs.getString("congviec"),
                        rs.getString("kehoachthuchien"),
                        rs.getString("chitieu"),
                        rs.getString("thoigiankh"),
                        rs.getString("sanphamkh"),
                        rs.getString("ghichu"),
                        rs.getString("kiemtra")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Khởi tạo Kế hoạch mới: Tạo Header và tự động sao chép các công việc từ mẫu (noidungkhvcgv)
     */
    public String initializeKeHoach(String msvc, String namhoc) {
        String mskhvc = generateMskhvc();
        String insertHeaderSql = "INSERT INTO kehoachvc (mskhvc, msvc, ngay, namhoc, danhhieu, khenthuong, xacnhan, duyet) " +
                                 "VALUES (?, ?, CURRENT_DATE(), ?, '', '', '0', '0')";
        String getTemplateSql = "SELECT muc, congviec FROM noidungkhvcgv ORDER BY stt";
        String insertDetailSql = "INSERT INTO chitietkhthvcgv (mskhvc, muc, congviec, kehoachthuchien, chitieu, thoigiankh, thoigianth, sanphamkh, sanphamth, ketqua, ghichu, minhchung, kiemtra, tuxacnhan, donvixacnhan) " +
                                 "VALUES (?, ?, ?, '', '', '', '', '', '', '', '', '', '0', '0', '0')";

        try (Connection conn = DBConnection.getConnection()) {
            // Tắt auto commit để thực hiện giao dịch (Transaction)
            conn.setAutoCommit(false);
            try {
                // 1. Thêm Header
                try (PreparedStatement psHeader = conn.prepareStatement(insertHeaderSql)) {
                    psHeader.setString(1, mskhvc);
                    psHeader.setString(2, msvc);
                    psHeader.setString(3, namhoc);
                    psHeader.executeUpdate();
                }

                // 2. Lấy mẫu công việc và sao chép vào Chi tiết kế hoạch
                List<String[]> templates = new ArrayList<>();
                try (PreparedStatement psTemplate = conn.prepareStatement(getTemplateSql);
                     ResultSet rs = psTemplate.executeQuery()) {
                    while (rs.next()) {
                        templates.add(new String[]{rs.getString("muc"), rs.getString("congviec")});
                    }
                }

                try (PreparedStatement psDetail = conn.prepareStatement(insertDetailSql)) {
                    for (String[] t : templates) {
                        psDetail.setString(1, mskhvc);
                        psDetail.setString(2, t[0]);
                        psDetail.setString(3, t[1]);
                        psDetail.addBatch();
                    }
                    psDetail.executeBatch();
                }

                conn.commit(); // Thành công thì commit
                return mskhvc;
            } catch (SQLException e) {
                conn.rollback(); // Lỗi thì hoàn tác
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật một dòng chi tiết kế hoạch
     */
    public boolean updateKeHoachDetail(M_KeHoachDetail detail) {
        String sql = "UPDATE chitietkhthvcgv " +
                     "SET congviec = ?, kehoachthuchien = ?, chitieu = ?, thoigiankh = ?, sanphamkh = ?, ghichu = ?, kiemtra = ? " +
                     "WHERE mskhvc = ? AND muc = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, detail.getCongviec());
            ps.setString(2, detail.getKehoachthuchien());
            ps.setString(3, detail.getChitieu());
            ps.setString(4, detail.getThoigiankh());
            ps.setString(5, detail.getSanphamkh());
            ps.setString(6, detail.getGhichu());
            ps.setString(7, detail.getKiemtra());
            ps.setString(8, detail.getMskhvc());
            ps.setString(9, detail.getMuc());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Chèn thêm một dòng công việc mới vào chi tiết kế hoạch của viên chức
     */
    public boolean insertKeHoachDetail(M_KeHoachDetail detail) {
        String sql = "INSERT INTO chitietkhthvcgv (mskhvc, muc, congviec, kehoachthuchien, chitieu, thoigiankh, thoigianth, sanphamkh, sanphamth, ketqua, ghichu, minhchung, kiemtra, tuxacnhan, donvixacnhan) " +
                     "VALUES (?, ?, ?, ?, ?, ?, '', ?, '', '', ?, '', ?, '0', '0')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, detail.getMskhvc());
            ps.setString(2, detail.getMuc());
            ps.setString(3, detail.getCongviec());
            ps.setString(4, detail.getKehoachthuchien());
            ps.setString(5, detail.getChitieu());
            ps.setString(6, detail.getThoigiankh());
            ps.setString(7, detail.getSanphamkh());
            ps.setString(8, detail.getGhichu());
            ps.setString(9, detail.getKiemtra());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa một dòng công việc khỏi chi tiết kế hoạch
     */
    public boolean deleteKeHoachDetail(String mskhvc, String muc) {
        String sql = "DELETE FROM chitietkhthvcgv WHERE mskhvc = ? AND muc = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, mskhvc);
            ps.setString(2, muc);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật thông tin Header kế hoạch (ví dụ khi admin Duyệt hoặc xếp loại danh hiệu)
     */
    public boolean updateKeHoachHeader(M_KeHoachHeader header) {
        String sql = "UPDATE kehoachvc " +
                     "SET danhhieu = ?, khenthuong = ?, xacnhan = ?, duyet = ? " +
                     "WHERE mskhvc = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, header.getDanhhieu());
            ps.setString(2, header.getKhenthuong());
            ps.setString(3, header.getXacnhan());
            ps.setString(4, header.getDuyet());
            ps.setString(5, header.getMskhvc());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Thêm công việc mới vào danh mục mẫu (noidungkhvcgv)
     */
    public boolean addTemplateWorkItem(String muc, String congviec) {
        String getMaxSttSql = "SELECT MAX(stt) AS max_stt FROM noidungkhvcgv";
        String sql = "INSERT INTO noidungkhvcgv (stt, muc, congviec) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            int nextStt = 1;
            try (PreparedStatement psMax = conn.prepareStatement(getMaxSttSql);
                 ResultSet rs = psMax.executeQuery()) {
                if (rs.next()) {
                    nextStt = rs.getInt("max_stt") + 1;
                }
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, nextStt);
                ps.setString(2, muc);
                ps.setString(3, congviec);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy toàn bộ danh sách các đợt lập kế hoạch (Năm học)
     */
    public List<String> getAllNamHoc() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT namhoc FROM dotkehoach ORDER BY namhoc DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("namhoc"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Thêm một đợt lập kế hoạch mới (Năm học mới)
     */
    public boolean addNamHoc(String namhoc) {
        String sql = "INSERT IGNORE INTO dotkehoach (namhoc, trang_thai) VALUES (?, 1)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, namhoc);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Viên chức tự đăng ký danh hiệu thi đua và khen thưởng
     */
    public boolean registerDanhHieu(String mskhvc, String danhhieu, String khenthuong) {
        String sql = "UPDATE kehoachvc SET danhhieu = ?, khenthuong = ? WHERE mskhvc = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, danhhieu);
            ps.setString(2, khenthuong);
            ps.setString(3, mskhvc);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Sinh tự động mã mskhvc tiếp theo
     */
    private String generateMskhvc() {
        String sql = "SELECT mskhvc FROM kehoachvc ORDER BY mskhvc DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("mskhvc");
                if (lastId != null && lastId.startsWith("KH")) {
                    try {
                        int num = Integer.parseInt(lastId.substring(2));
                        return "KH" + String.format("%03d", num + 1);
                    } catch (NumberFormatException e) {
                        // ignore and fallback
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "KH001";
    }

    /**
     * Lấy thông tin Bảng chấm điểm đánh giá (bcdvc) của 1 viên chức trong 1 năm học
     */
    public M_Bcdvc getEvaluation(String msvc, String namhoc) {
        String sql = "SELECT b.msbcdvc, b.msvc, b.namhoc, b.ngay, b.tongdiem, b.tuxeploai, b.capthamquyenxeploai, b.duyet, b.nhanxetctq, " +
                     "vc.hoten, cv.tenchucvu, dv.tendonvi " +
                     "FROM bcdvc b " +
                     "LEFT JOIN vienchuc vc ON b.msvc = vc.msvc " +
                     "LEFT JOIN chucvu cv ON vc.mschucvu = cv.mschucvu " +
                     "LEFT JOIN donvi dv ON vc.msdonvi = dv.msdonvi " +
                     "WHERE b.msvc = ? AND b.namhoc = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, msvc);
            ps.setString(2, namhoc);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    M_Bcdvc b = new M_Bcdvc(
                        rs.getString("msbcdvc"),
                        rs.getString("msvc"),
                        rs.getString("namhoc"),
                        rs.getString("ngay"),
                        rs.getInt("tongdiem"),
                        rs.getString("tuxeploai"),
                        rs.getString("capthamquyenxeploai"),
                        rs.getString("duyet"),
                        rs.getString("nhanxetctq")
                    );
                    b.setHoten(rs.getString("hoten"));
                    b.setTenchucvu(rs.getString("tenchucvu"));
                    b.setTendonvi(rs.getString("tendonvi"));
                    return b;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy danh sách toàn bộ Bảng đánh giá của tất cả viên chức trong 1 năm học (dành cho Admin / Trưởng đơn vị)
     */
    public List<M_Bcdvc> getAllEvaluations(String namhoc) {
        List<M_Bcdvc> list = new ArrayList<>();
        String sql = "SELECT b.msbcdvc, b.msvc, b.namhoc, b.ngay, b.tongdiem, b.tuxeploai, b.capthamquyenxeploai, b.duyet, b.nhanxetctq, " +
                     "vc.hoten, cv.tenchucvu, dv.tendonvi " +
                     "FROM bcdvc b " +
                     "LEFT JOIN vienchuc vc ON b.msvc = vc.msvc " +
                     "LEFT JOIN chucvu cv ON vc.mschucvu = cv.mschucvu " +
                     "LEFT JOIN donvi dv ON vc.msdonvi = dv.msdonvi " +
                     "WHERE b.namhoc = ? " +
                     "ORDER BY b.msvc";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, namhoc);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    M_Bcdvc b = new M_Bcdvc(
                        rs.getString("msbcdvc"),
                        rs.getString("msvc"),
                        rs.getString("namhoc"),
                        rs.getString("ngay"),
                        rs.getInt("tongdiem"),
                        rs.getString("tuxeploai"),
                        rs.getString("capthamquyenxeploai"),
                        rs.getString("duyet"),
                        rs.getString("nhanxetctq")
                    );
                    b.setHoten(rs.getString("hoten"));
                    b.setTenchucvu(rs.getString("tenchucvu"));
                    b.setTendonvi(rs.getString("tendonvi"));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
