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
    
    // Các trường Thực hiện
    private String thoigianth;
    private String sanphamth;
    private String ketqua;
    private String minhchung;
    private String tuxacnhan;
    private String donvixacnhan;

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

    public M_KeHoachDetail(String mskhvc, String muc, String congviec, String kehoachthuchien, String chitieu, 
                           String thoigiankh, String sanphamkh, String ghichu, String kiemtra, 
                           String thoigianth, String sanphamth, String ketqua, String minhchung, 
                           String tuxacnhan, String donvixacnhan) {
        this.mskhvc = mskhvc;
        this.muc = muc;
        this.congviec = congviec;
        this.kehoachthuchien = kehoachthuchien;
        this.chitieu = chitieu;
        this.thoigiankh = thoigiankh;
        this.sanphamkh = sanphamkh;
        this.ghichu = ghichu;
        this.kiemtra = kiemtra;
        this.thoigianth = thoigianth;
        this.sanphamth = sanphamth;
        this.ketqua = ketqua;
        this.minhchung = minhchung;
        this.tuxacnhan = tuxacnhan;
        this.donvixacnhan = donvixacnhan;
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

    public String getThoigianth() { return thoigianth; }
    public void setThoigianth(String thoigianth) { this.thoigianth = thoigianth; }

    public String getSanphamth() { return sanphamth; }
    public void setSanphamth(String sanphamth) { this.sanphamth = sanphamth; }

    public String getKetqua() { return ketqua; }
    public void setKetqua(String ketqua) { this.ketqua = ketqua; }

    public String getMinhchung() { return minhchung; }
    public void setMinhchung(String minhchung) { this.minhchung = minhchung; }

    public String getTuxacnhan() { return tuxacnhan; }
    public void setTuxacnhan(String tuxacnhan) { this.tuxacnhan = tuxacnhan; }

    public String getDonvixacnhan() { return donvixacnhan; }
    public void setDonvixacnhan(String donvixacnhan) { this.donvixacnhan = donvixacnhan; }
}
