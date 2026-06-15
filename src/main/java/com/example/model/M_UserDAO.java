package com.example.model;

import org.mindrot.jbcrypt.BCrypt;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// TẦNG MODEL: Data Access Object (DAO) - Chịu trách nhiệm tương tác và truy xuất dữ liệu từ Cơ sở dữ liệu thực tế
public class M_UserDAO {

    /**
     * Nghiệp vụ kiểm tra thông tin đăng nhập trực tiếp từ MySQL Database
     * @param username tên tài khoản người dùng gửi lên
     * @param password mật khẩu người dùng gửi lên (chưa mã hóa)
     * @return Đối tượng M_User nếu khớp thông tin; null nếu sai tài khoản hoặc mật khẩu
     */
    public M_User checkLogin(String username, String password) {
        // Câu lệnh truy vấn SQL lấy thông tin viên chức trực tiếp từ bảng viên chức trong DB danhgiavienchuc
        String sql = "SELECT ten AS username, matkhau AS password_hash, hoten AS ho_ten, quyen " +
                     "FROM vienchuc " +
                     "WHERE ten = ?";

        // Sử dụng try-with-resources để tự động đóng kết nối sau khi thực thi
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String passwordHash = rs.getString("password_hash");
                    
                    // So sánh mật khẩu (Hỗ trợ cả BCrypt băm và mật khẩu văn bản thường)
                    boolean match = false;
                    if (passwordHash != null && (passwordHash.startsWith("$2a$") || passwordHash.startsWith("$2b$") || passwordHash.startsWith("$2y$"))) {
                        try {
                            match = BCrypt.checkpw(password, passwordHash);
                        } catch (IllegalArgumentException e) {
                            match = password.equals(passwordHash);
                        }
                    } else {
                        match = password != null && password.equals(passwordHash);
                    }

                    if (match) {
                        String fullName = rs.getString("ho_ten");
                        if (fullName == null || fullName.trim().isEmpty()) {
                            fullName = "Quản trị viên"; // Giá trị mặc định nếu tài khoản Admin không gắn với viên chức cụ thể
                        }
                        
                        // Trả về đối tượng M_User tương ứng
                        return new M_User(rs.getString("username"), "", fullName, rs.getString("quyen"));
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi hệ thống khi thực hiện truy vấn đăng nhập!");
            e.printStackTrace();
        }
        
        return null; // Trả về null nếu thông tin không chính xác hoặc xảy ra lỗi
    }

    /**
     * Lấy danh sách tất cả tài khoản người dùng từ MySQL
     * @return List<M_User> danh sách người dùng
     */
    public List<M_User> getAllUsers() {
        List<M_User> list = new ArrayList<>();
        String sql = "SELECT ten AS username, hoten AS ho_ten FROM vienchuc";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                String fullName = rs.getString("ho_ten");
                if (fullName == null || fullName.trim().isEmpty()) {
                    fullName = "Quản trị viên";
                }
                list.add(new M_User(rs.getString("username"), "********", fullName));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách người dùng từ CSDL!");
            e.printStackTrace();
        }
        return list;
    }
}
