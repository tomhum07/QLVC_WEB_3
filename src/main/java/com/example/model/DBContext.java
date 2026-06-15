package com.example.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp hỗ trợ kết nối Cơ sở dữ liệu MySQL trên XAMPP
 */
public class DBContext {
    // Cấu hình thông số kết nối MySQL trên XAMPP mặc định
    private static final String HOST = "localhost";
    private static final String PORT = "3306";
    private static final String DB_NAME = "danhgiavienchuc";
    private static final String USERNAME = "root";
    private static final String PASSWORD = ""; // XAMPP mặc định không có mật khẩu (chuỗi rỗng)

    /**
     * Lấy kết nối tới MySQL Database
     * @return Connection đối tượng kết nối
     * @throws SQLException nếu kết nối thất bại
     * @throws ClassNotFoundException nếu thiếu driver JDBC
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Đăng ký MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Tạo URL kết nối với cấu hình hỗ trợ Unicode tiếng Việt
        String url = String.format("jdbc:mysql://%s:%s/%s?useUnicode=true&characterEncoding=utf-8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC", 
                HOST, PORT, DB_NAME);
        
        return DriverManager.getConnection(url, USERNAME, PASSWORD);
    }
}
