using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyPhamOnline.Models;
using PagedList;
using PagedList.Mvc;
namespace MyPhamOnline.Areas.Admin.Views.Admin
{
    public class ThuongHieuController : Controller
    {
        dbMyPhamOnlineDataContext db = new dbMyPhamOnlineDataContext();
        // GET: Admin/KhachHang
        public ActionResult Index(int? page)
        {
            int iPageNum = (page ?? 1);
            int iPageSize = 7;
            var lst = db.THUONGHIEUs.ToList().OrderBy(n => n.MaTH).ToPagedList(iPageNum, iPageSize);
            return View(lst);
        }
    }
}