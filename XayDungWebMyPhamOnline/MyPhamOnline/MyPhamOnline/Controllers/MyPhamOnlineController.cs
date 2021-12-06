using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyPhamOnline.Models;


using PagedList;
using PagedList.Mvc;
namespace MyPhamOnline.Controllers
{
    public class MyPhamOnlineController : Controller
    {
        dbMyPhamOnlineDataContext data = new dbMyPhamOnlineDataContext();
        /// <summary>
        /// LaySachMoi
        /// </summary>
        /// <param name="count">int</param>
        /// <returns>List</returns>
        private List<SANPHAM> SANPHAMMOI(int count)
        {
            return data.SANPHAMs.OrderByDescending(a => a.NgayCapNhat).Take(count).ToList();
        }

        public ActionResult Index()
        {
            var listSanPhamMoi = SANPHAMMOI(9);
            return View(listSanPhamMoi);
        }

        private List<SANPHAM> LaySanPhamBanNhieu(int count)
        {
            return data.SANPHAMs.OrderByDescending(a => a.SoLuongBan).Take(count).ToList();
        }


        public ActionResult SanPhamBanNhieuPartial()
        {
            var listSanPhamBanNhieu = LaySanPhamBanNhieu(8);
            return PartialView(listSanPhamBanNhieu);
        }


        /// <summary>
        /// LaySPBanNhieu
        /// </summary>
        /// <param name="count">int</param>
        /// <returns>List</returns>


        /// <summary>
        /// GetChuDe
        /// </summary>
        /// <returns>ReturnsDanhSachSP</returns>
        public ActionResult DanhSachSPPartial()
        {
            var listDanhSach = from ds in data.DANHSACHSPs select ds;
            return PartialView(listDanhSach);
        }
        public ActionResult DanhSachSanPham(int iMaDS, int? page)
        {
            ViewBag.MaDS = iMaDS;
            // tao bien quy dinh so san pham moi trang
            int iSize = 3;
            // tao bien so trang
            int iPageNum = (page ?? 1);
            var sanpham = from s in data.SANPHAMs where s.MaDS == iMaDS select s;
            return View(sanpham.ToPagedList(iPageNum, iSize));
        }

        public ActionResult ThuongHieuPartial()
        {
            var listThuongHieu = from th in data.THUONGHIEUs select th;
            return PartialView(listThuongHieu);
        }
        public ActionResult SanPhamThuongHieu(int iMaTH, int? page)
        {
            ViewBag.MaTH = iMaTH;
            int iSize = 3;
            int iPageNum = (page ?? 1);
            var sanpham = from s in data.SANPHAMs where s.MaTH == iMaTH select s;
            return View(sanpham.ToPagedList(iPageNum, iSize));
        }

        public ActionResult ChiTietSanPham(int id)
        {
            var sanpham = from s in data.SANPHAMs where s.MaSP == id select s;
            return View(sanpham.Single());
        }

        public ActionResult NavbarPartial()
        {
            var listDanhSach = from ds in data.DANHSACHSPs select ds;
            return PartialView(listDanhSach);
        }


    }
}

