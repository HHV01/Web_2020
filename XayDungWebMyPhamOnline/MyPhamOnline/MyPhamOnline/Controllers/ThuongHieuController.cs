using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyPhamOnline.Models;

namespace MyPhamOnline.Controllers
{
    public class ThuongHieuController : Controller
    {
       dbMyPhamOnlineDataContext data = new dbMyPhamOnlineDataContext();
        // GET: ThuongHieu

        public ActionResult Index()
        {
            return View(from th in data.THUONGHIEUs select th);
        }
        public ActionResult Details()
        {
            int math = int.Parse(Request.QueryString["id"]);
            var result = data.THUONGHIEUs.Where(th => th.MaTH == math).SingleOrDefault();
            return View(result);
        }
        public THUONGHIEU GetTH(int id)
        {
            return (data.THUONGHIEUs.OrderBy(n => n.TenTH).Where(n => n.MaTH == id).SingleOrDefault());
        }
        [HttpGet]
        public ActionResult Edit(int id)
        {
            //NHAXUATBAN nxb = data.NHAXUATBANs.Where(n => n.MaNXB == id).SingleOrDefault();
            //return View(nxb);
            return View(GetTH(id));
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit()
        {
            if (ModelState.IsValid)
            {
                var th = GetTH(int.Parse(Request.Form["MaTH"]));
                th.TenTH = Request.Form["TenTH"];
                th.TieuSu = Request.Form["TieuSu"];
                //UpdateModel(nxb);
                data.SubmitChanges();
                return RedirectToAction("Index");
            }
            else
            {
                return RedirectToAction("Edit");
            }
        }
        [HttpGet]
        public ActionResult Delete(int id)
        {
            return View(GetTH(id));
        }
        [HttpPost]
        public ActionResult Delete(int id, FormCollection f)
        {
            var sach = GetTH(id);
            if (sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            //var ctdh = data.CHITIETDATHANGs.Where(ct => ct.MaSach == id).ToList();
            //if (ctdh != null)
            //{
            //    ViewBag.ThongBao = "Sách này đang có trong bảng Chi tiết đặt hàng!";
            //    return RedirectToAction("Delete");
            //}
            data.THUONGHIEUs.DeleteOnSubmit(sach);
            data.SubmitChanges();
            return RedirectToAction("Index");
        }
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(FormCollection f)
        {
            if (ModelState.IsValid)
            {
                THUONGHIEU th = new THUONGHIEU();
                th.MaTH = int.Parse(Request.Form["MaTH"]);
                th.TenTH = Request.Form["TenTH"];
                th.TieuSu = Request.Form["TieuSu"];
                data.SubmitChanges();
                data.THUONGHIEUs.InsertOnSubmit(th);
                data.SubmitChanges();
                return RedirectToAction("Index");
            }
            else
            {
                return RedirectToAction("Delete");
            }
        }
    }
}