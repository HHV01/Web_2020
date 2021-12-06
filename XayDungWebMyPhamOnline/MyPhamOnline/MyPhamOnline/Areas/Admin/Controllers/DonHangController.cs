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
    public class DonHangController : Controller
    {
        dbMyPhamOnlineDataContext db = new dbMyPhamOnlineDataContext();
        // GET: Admin/KhachHang
        public ActionResult Index(int? page)
        {
            int iPageNum = (page ?? 1);
            int iPageSize = 7;
            var lst = db.DONDATHANGs.ToList().OrderBy(n => n.MaDonHang).ToPagedList(iPageNum, iPageSize);
            return View(lst);
        }
    }
}