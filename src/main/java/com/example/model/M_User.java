package com.example.model;

/**
 * Lớp Model đại diện cho người dùng (M_User)
 */
public class M_User {
    private String username;
    private String password;
    private String fullName;
    private String quyen;

    public M_User() {}

    public M_User(String username, String password, String fullName) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
    }

    public M_User(String username, String password, String fullName, String quyen) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.quyen = quyen;
    }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getQuyen() { return quyen; }
    public void setQuyen(String quyen) { this.quyen = quyen; }
}
