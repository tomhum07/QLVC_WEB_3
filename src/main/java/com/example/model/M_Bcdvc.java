package com.example.model;

/**
 * Model đại diện cho Bản chấm điểm viên chức (bcdvc)
 */
public class M_Bcdvc {
    private String msbcdvc;
    private String msvc;
    private String namhoc;
    private String ngay;
    private int tongdiem;
    private String tuxeploai;
    private String capthamquyenxeploai;
    private String duyet;
    private String nhanxetctq;
    
    // Các trường bổ sung phục vụ hiển thị
    private String hoten;
    private String tenchucvu;
    private String tendonvi;

    public M_Bcdvc() {}

    public M_Bcdvc(String msbcdvc, String msvc, String namhoc, String ngay, int tongdiem, 
                   String tuxeploai, String capthamquyenxeploai, String duyet, String nhanxetctq) {
        this.msbcdvc = msbcdvc;
        this.msvc = msvc;
        this.namhoc = namhoc;
        this.ngay = ngay;
        this.tongdiem = tongdiem;
        this.tuxeploai = tuxeploai;
        this.capthamquyenxeploai = capthamquyenxeploai;
        this.duyet = duyet;
        this.nhanxetctq = nhanxetctq;
    }

    public String getMsbcdvc() { return msbcdvc; }
    public void setMsbcdvc(String msbcdvc) { this.msbcdvc = msbcdvc; }

    public String getMsvc() { return msvc; }
    public void setMsvc(String msvc) { this.msvc = msvc; }

    public String getNamhoc() { return namhoc; }
    public void setNamhoc(String namhoc) { this.namhoc = namhoc; }

    public String getNgay() { return ngay; }
    public void setNgay(String ngay) { this.ngay = ngay; }

    public int getTongdiem() { return tongdiem; }
    public void setTongdiem(int tongdiem) { this.tongdiem = tongdiem; }

    public String getTuxeploai() { return tuxeploai; }
    public void setTuxeploai(String tuxeploai) { this.tuxeploai = tuxeploai; }

    public String getCapthamquyenxeploai() { return capthamquyenxeploai; }
    public void setCapthamquyenxeploai(String capthamquyenxeploai) { this.capthamquyenxeploai = capthamquyenxeploai; }

    public String getDuyet() { return duyet; }
    public void setDuyet(String duyet) { this.duyet = duyet; }

    public String getNhanxetctq() { return nhanxetctq; }
    public void setNhanxetctq(String nhanxetctq) { this.nhanxetctq = nhanxetctq; }

    public String getHoten() { return hoten; }
    public void setHoten(String hoten) { this.hoten = hoten; }

    public String getTenchucvu() { return tenchucvu; }
    public void setTenchucvu(String tenchucvu) { this.tenchucvu = tenchucvu; }

    public String getTendonvi() { return tendonvi; }
    public void setTendonvi(String tendonvi) { this.tendonvi = tendonvi; }
}
