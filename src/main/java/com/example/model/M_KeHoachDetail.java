package com.example.model;

/**
 * Model đại diện cho từng dòng chi tiết của Kế Hoạch Viên Chức
 */
public class M_KeHoachDetail {
    private String mskhvc;
    private String muc;
    private String congviec;
    private String kehoachthuchien;
    private String chitieu;
    private String thoigiankh;
    private String sanphamkh;
    private String ghichu;
    private String kiemtra; // Trạng thái đã kiểm tra (0 hoặc 1)

    public M_KeHoachDetail() {}

    public M_KeHoachDetail(String mskhvc, String muc, String congviec, String kehoachthuchien, String chitieu, String thoigiankh, String sanphamkh, String ghichu, String kiemtra) {
        this.mskhvc = mskhvc;
        this.muc = muc;
        this.congviec = congviec;
        this.kehoachthuchien = kehoachthuchien;
        this.chitieu = chitieu;
        this.thoigiankh = thoigiankh;
        this.sanphamkh = sanphamkh;
        this.ghichu = ghichu;
        this.kiemtra = kiemtra;
    }

    public String getMskhvc() { return mskhvc; }
    public void setMskhvc(String mskhvc) { this.mskhvc = mskhvc; }

    public String getMuc() { return muc; }
    public void setMuc(String muc) { this.muc = muc; }

    public String getCongviec() { return congviec; }
    public void setCongviec(String congviec) { this.congviec = congviec; }

    public String getKehoachthuchien() { return kehoachthuchien; }
    public void setKehoachthuchien(String kehoachthuchien) { this.kehoachthuchien = kehoachthuchien; }

    public String getChitieu() { return chitieu; }
    public void setChitieu(String chitieu) { this.chitieu = chitieu; }

    public String getThoigiankh() { return thoigiankh; }
    public void setThoigiankh(String thoigiankh) { this.thoigiankh = thoigiankh; }

    public String getSanphamkh() { return sanphamkh; }
    public void setSanphamkh(String sanphamkh) { this.sanphamkh = sanphamkh; }

    public String getGhichu() { return ghichu; }
    public void setGhichu(String ghichu) { this.ghichu = ghichu; }

    public String getKiemtra() { return kiemtra; }
    public void setKiemtra(String kiemtra) { this.kiemtra = kiemtra; }
}
