package com.example.model;

/**
 * Model đại diện cho thông tin chi tiết của Viên Chức
 */
public class M_VienChuc {
    private String msvc;
    private String hoten;
    private String tenchucvu;
    private String tendonvi;
    private String quyen;

    public M_VienChuc() {}

    public M_VienChuc(String msvc, String hoten, String tenchucvu, String tendonvi, String quyen) {
        this.msvc = msvc;
        this.hoten = hoten;
        this.tenchucvu = tenchucvu;
        this.tendonvi = tendonvi;
        this.quyen = quyen;
    }

    public String getMsvc() { return msvc; }
    public void setMsvc(String msvc) { this.msvc = msvc; }

    public String getHoten() { return hoten; }
    public void setHoten(String hoten) { this.hoten = hoten; }

    public String getTenchucvu() { return tenchucvu; }
    public void setTenchucvu(String tenchucvu) { this.tenchucvu = tenchucvu; }

    public String getTendonvi() { return tendonvi; }
    public void setTendonvi(String tendonvi) { this.tendonvi = tendonvi; }

    public String getQuyen() { return quyen; }
    public void setQuyen(String quyen) { this.quyen = quyen; }
}
