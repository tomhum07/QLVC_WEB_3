-- Tạo Database
CREATE DATABASE IF NOT EXISTS qlvc_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE qlvc_db;

-- Tạo bảng users
CREATE TABLE IF NOT EXISTS users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    fullname VARCHAR(100) NOT NULL
);

-- Thêm dữ liệu mẫu
INSERT INTO users (username, password, fullname) VALUES 
('admin', '123', 'Quản trị viên'),
('user', '123', 'Người dùng thường')
ON DUPLICATE KEY UPDATE fullname=fullname;
