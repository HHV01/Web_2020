using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyPhamOnline.Models
{

    public class GioHang
    {
        dbMyPhamOnlineDataContext db = new dbMyPhamOnlineDataContext();
        public int iMaSP { get; set; }
        public String sTenSP { get; set; }
        public String sAnhBia { get; set; }
        public Double dDonGia { get; set; }
        public int iSoLuong { get; set; }
        public Double dThanhTien
        {
            get { return iSoLuong * dDonGia; }
        }

        //Khoi tao gio hang theo MaSach duoc truyen vao voi SoLuong mac dinh la 1
        public GioHang(int ms)
        {
            iMaSP = ms;
            SANPHAM s = db.SANPHAMs.Single(n => n.MaSP == iMaSP);
            sTenSP = s.TenSP;
            sAnhBia = s.AnhBia;
            dDonGia = double.Parse(s.GiaBan.ToString());
            iSoLuong = 1;
        }
    }
}