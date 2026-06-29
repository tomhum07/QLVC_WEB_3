package com.example.model;

/**
 * Model đại diện cho một dòng chi tiết của Bảng chấm điểm đánh giá (chitietdanhgia)
 */
public class M_ChiTietDanhGia {
    private String msbcdvc;
    private String tieuchi_id;
    private String sanpham;
    private float diem_tudanhgia;
    private float diem_ctqdanhgia;
    
    // Các trường bổ sung phục vụ hiển thị
    private String ten_tieuchi;
    private float diem_toida;

    public M_ChiTietDanhGia() {}

    public M_ChiTietDanhGia(String msbcdvc, String tieuchi_id, String sanpham, float diem_tudanhgia, float diem_ctqdanhgia) {
        this.msbcdvc = msbcdvc;
        this.tieuchi_id = tieuchi_id;
        this.sanpham = sanpham;
        this.diem_tudanhgia = diem_tudanhgia;
        this.diem_ctqdanhgia = diem_ctqdanhgia;
    }

    public String getMsbcdvc() { return msbcdvc; }
    public void setMsbcdvc(String msbcdvc) { this.msbcdvc = msbcdvc; }

    public String getTieuchi_id() { return tieuchi_id; }
    public void setTieuchi_id(String tieuchi_id) { this.tieuchi_id = tieuchi_id; }

    public String getSanpham() { return sanpham; }
    public void setSanpham(String sanpham) { this.sanpham = sanpham; }

    public float getDiem_tudanhgia() { return diem_tudanhgia; }
    public void setDiem_tudanhgia(float diem_tudanhgia) { this.diem_tudanhgia = diem_tudanhgia; }

    public float getDiem_ctqdanhgia() { return diem_ctqdanhgia; }
    public void setDiem_ctqdanhgia(float diem_ctqdanhgia) { this.diem_ctqdanhgia = diem_ctqdanhgia; }

    public String getTen_tieuchi() { return ten_tieuchi; }
    public void setTen_tieuchi(String ten_tieuchi) { this.ten_tieuchi = ten_tieuchi; }

    public float getDiem_toida() { return diem_toida; }
    public void setDiem_toida(float diem_toida) { this.diem_toida = diem_toida; }
}
