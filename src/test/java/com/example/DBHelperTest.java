package com.example;

import com.example.model.DBConnection;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

public class DBHelperTest {
    @Test
    public void testInspectDatabase() {
        System.out.println("--- RESETTING TEMPLATE AND CREATING TABLES ---");
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Disable foreign key checks
            stmt.execute("SET FOREIGN_KEY_CHECKS = 0");
            
            // Clear old data
            stmt.execute("DELETE FROM chitietkhthvcgv");
            stmt.execute("DELETE FROM kehoachvc");
            stmt.execute("DELETE FROM bcdvc");
            stmt.execute("DELETE FROM noidungkhvcgv");
            
            // Insert 3 main criteria
            stmt.execute("INSERT INTO noidungkhvcgv (stt, muc, congviec) VALUES (1, 'I', 'Giảng dạy')");
            stmt.execute("INSERT INTO noidungkhvcgv (stt, muc, congviec) VALUES (2, 'II', 'Nghiên cứu khoa học')");
            stmt.execute("INSERT INTO noidungkhvcgv (stt, muc, congviec) VALUES (3, 'III', 'Phục vụ cộng đồng')");
            
            // Create chitietdanhgia table
            stmt.execute("CREATE TABLE IF NOT EXISTS chitietdanhgia (" +
                         "msbcdvc VARCHAR(50) NOT NULL, " +
                         "tieuchi_id VARCHAR(10) NOT NULL, " +
                         "sanpham TEXT, " +
                         "diem_tudanhgia FLOAT DEFAULT 0, " +
                         "diem_ctqdanhgia FLOAT DEFAULT 0, " +
                         "PRIMARY KEY (msbcdvc, tieuchi_id)" +
                         ") ENGINE=InnoDB");
            
            // Re-enable foreign key checks
            stmt.execute("SET FOREIGN_KEY_CHECKS = 1");
            
            System.out.println("Reset and table creation complete. Tables in database:");
            try (ResultSet rs = conn.getMetaData().getTables("danhgiavienchuc", null, "%", new String[]{"TABLE"})) {
                while (rs.next()) {
                    System.out.println(" - " + rs.getString("TABLE_NAME"));
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
