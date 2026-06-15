package com.example.model;

/**
 * Model đại diện cho thông tin phần đầu (Header) của Kế Hoạch Viên Chức
 */
public class M_KeHoachHeader {
    private String mskhvc;
    private String msvc;
    private String ngay;
    private String namhoc;
    private String danhhieu;
    private String khenthuong;
    private String xacnhan;
    private String duyet;

    public M_KeHoachHeader() {}

    public M_KeHoachHeader(String mskhvc, String msvc, String ngay, String namhoc, String danhhieu, String khenthuong, String xacnhan, String duyet) {
        this.mskhvc = mskhvc;
        this.msvc = msvc;
        this.ngay = ngay;
        this.namhoc = namhoc;
        this.danhhieu = danhhieu;
        this.khenthuong = khenthuong;
        this.xacnhan = xacnhan;
        this.duyet = duyet;
    }

    public String getMskhvc() { return mskhvc; }
    public void setMskhvc(String mskhvc) { this.mskhvc = mskhvc; }

    public String getMsvc() { return msvc; }
    public void setMsvc(String msvc) { this.msvc = msvc; }

    public String getNgay() { return ngay; }
    public void setNgay(String ngay) { this.ngay = ngay; }

    public String getNamhoc() { return namhoc; }
    public void setNamhoc(String namhoc) { this.namhoc = namhoc; }

    public String getDanhhieu() { return danhhieu; }
    public void setDanhhieu(String danhhieu) { this.danhhieu = danhhieu; }

    public String getKhenthuong() { return khenthuong; }
    public void setKhenthuong(String khenthuong) { this.khenthuong = khenthuong; }

    public String getXacnhan() { return xacnhan; }
    public void setXacnhan(String xacnhan) { this.xacnhan = xacnhan; }

    public String getDuyet() { return duyet; }
    public void setDuyet(String duyet) { this.duyet = duyet; }
}
