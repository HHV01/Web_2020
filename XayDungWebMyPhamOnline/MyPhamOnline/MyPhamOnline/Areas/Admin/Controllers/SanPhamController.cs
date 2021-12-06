using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyPhamOnline.Models;
using PagedList;
using PagedList.Mvc;
using System.IO;


namespace MyPhamOnline.Areas.Admin.Controllers
{
    public class SanPhamController : Controller
    {
        dbMyPhamOnlineDataContext db = new dbMyPhamOnlineDataContext();
        // GET: Admin/SanPham
        public ActionResult Index(int? page)
        {
            int iPageNum = (page ?? 1);
            int iPageSize = 7;
            var lst = db.SANPHAMs.ToList().OrderBy(n => n.MaSP).ToPagedList(iPageNum, iPageSize);
            return View(lst);
        }
        public ActionResult Create()
        {
            ViewBag.MaDS = new SelectList(db.DANHSACHSPs.ToList().OrderBy(n => n.TenDS), "MaDS", "TenDS");
            ViewBag.MaTH = new SelectList(db.THUONGHIEUs.ToList().OrderBy(n => n.TenTH), "MaTH", "TenTH");
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(SANPHAM sanpham, FormCollection f, HttpPostedFileBase fFileUpload)
        {
            ViewBag.MaDS = new SelectList(db.DANHSACHSPs.ToList().OrderBy(n => n.TenDS), "MaDS", "TenDS");
            ViewBag.MaTH = new SelectList(db.THUONGHIEUs.ToList().OrderBy(n => n.TenTH), "MaTH", "TenTH");


            if (fFileUpload == null)
            {
                ViewBag.ThongBao = "Hãy chọn ảnh bìa.";
                ViewBag.TenSP = f["sTenSP"];
                ViewBag.MoTa = f["sMoTa"];
                ViewBag.SoLuong = int.Parse(f["iSoLuong"]);
                ViewBag.GiaBan = decimal.Parse(f["mGiaBan"]);
                ViewBag.MaDS = new SelectList(db.DANHSACHSPs.ToList().OrderBy(n => n.TenDS), "MaDS", "TenDS", int.Parse(f["MaDS"]));
                ViewBag.MaTH = new SelectList(db.THUONGHIEUs.ToList().OrderBy(n => n.TenTH), "MaTH", "TenTH", int.Parse(f["MaTH"]));
                return View();
            }
            else
            {
                if (ModelState.IsValid)
                {
                    var sFileName = Path.GetFileName(fFileUpload.FileName);
                    var path = Path.Combine(Server.MapPath("~/Images"), sFileName);
                    {
                        fFileUpload.SaveAs(path);
                    }
                    sanpham.TenSP = f["sTenSp"];
                    sanpham.MoTa = f["sMoTa"].Replace("<p>", "").Replace("</p>", "\n");
                    sanpham.AnhBia = sFileName;
                    sanpham.NgayCapNhat = Convert.ToDateTime(f["dNgayCapNhat"]); 
                    sanpham.SoLuongBan = int.Parse(f["iSoLuong"]);
                    sanpham.GiaBan = decimal.Parse(f["mGiaBan"]); 
                    sanpham.MaDS = int.Parse(f["MaDS"]);
                    sanpham.MaTH = int.Parse(f["MaTH"]); 
                    db.SANPHAMs.InsertOnSubmit(sanpham); 
                    db.SubmitChanges();
                    return RedirectToAction("Index");
                }
                return View();
            }
        }
                public ActionResult DeTails(int id)
        {
            var sanpham = db.SANPHAMs.SingleOrDefault(n => n.MaSP == id);
            if (sanpham == null)
            {
                Response.StatusCode = 404;
            }
            return View(sanpham);
        }
        public ActionResult Delete(int id)
        {
            var sanpham = db.SANPHAMs.SingleOrDefault(n => n.MaSP == id);
            if (sanpham == null)
            {
                Response.StatusCode = 404;
            }
            return View(sanpham);
        }

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirm(int id, FormCollection f)
        {
            var sanpham = db.SANPHAMs.SingleOrDefault(n => n.MaSP == id);

            if (sanpham == null)
            {
                Response.StatusCode = 404; return null;
            }
            var ctdh = db.CHITIETDATHANGs.Where(ct => ct.MaSP == id); if (ctdh.Count() > 0)
            {
                ViewBag.ThongBao = "Sách này đang có trong bảng Chi tiết đặt hàng <br>" + " Nếu muốn xóa thì phải xóa hết mã sách này trong bảng Chi tiết đặt hàng";
                return View(sanpham);
            }

            var sanxuat = db.SANXUATs.Where(vs => vs.MaSP == id).ToList();
            if (sanxuat != null)
            {
                db.SANXUATs.DeleteAllOnSubmit(sanxuat);
                db.SubmitChanges();
            }
             return RedirectToAction("Index");
        }
        public ActionResult Edit()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Edit(int id)
        {
            var sanpham = db.SANPHAMs.SingleOrDefault(n => n.MaSP == id); if (sanpham == null)
            {
                Response.StatusCode = 404; return null;
            }
            ViewBag.MaDS = new SelectList(db.DANHSACHSPs.ToList().OrderBy(n => n.TenDS), "MaDS", "TenDS", sanpham.MaDS);
            ViewBag.MaTH = new SelectList(db.THUONGHIEUs.ToList().OrderBy(n => n.TenTH), "MaTH", "TenTH", sanpham.MaTH);
            return View(sanpham);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(FormCollection f, HttpPostedFileBase fFileUpload)
        {
            var sanpham = db.SANPHAMs.SingleOrDefault(n => n.MaSP == int.Parse(f["iMaSP"])); ViewBag.MaCD = new SelectList(db.DANHSACHSPs.ToList().OrderBy(n => n.TenDS),
            "MaDS", "TenDS", sanpham.MaDS);
            ViewBag.MaTH = new SelectList(db.THUONGHIEUs.ToList().OrderBy(n => n.TenTH), "MaTH", "TenTH", sanpham.MaTH);

            if (ModelState.IsValid)
            {
                if (fFileUpload != null)
                {
                    var sFileName = Path.GetFileName(fFileUpload.FileName);
                    var path = Path.Combine(Server.MapPath("~/Images"), sFileName);
                    {
                        fFileUpload.SaveAs(path);
                    }
                    sanpham.AnhBia = sFileName;
                }
                sanpham.MoTa = f["sMoTa"].Replace("<p>", "").Replace("</p>", "\n");

                sanpham.NgayCapNhat = Convert.ToDateTime(f["dNgayCapNhat"]); sanpham.SoLuongBan = int.Parse(f["iSoLuong"]);
                sanpham.GiaBan = decimal.Parse(f["mGiaBan"]); sanpham.MaDS = int.Parse(f["MaDS"]); sanpham.MaTH = int.Parse(f["MaTH"]); db.SubmitChanges();
                return RedirectToAction("Index");
            }
            return View(sanpham);
        }
    }
}