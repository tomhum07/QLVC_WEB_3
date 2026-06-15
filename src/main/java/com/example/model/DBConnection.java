package com.example.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp thiết lập kết nối cơ sở dữ liệu MySQL
 */
public class DBConnection {
    
    private static final String URL = "jdbc:mysql://localhost:3306/danhgiavienchuc?useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // XAMPP mặc định mật khẩu là rỗng

    static {
        try {
            // Đảm bảo Driver JDBC MySQL được nạp vào bộ nhớ
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy Driver MySQL JDBC!");
            e.printStackTrace();
        }
    }

    /**
     * Trả về một kết nối mới tới MySQL database
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
