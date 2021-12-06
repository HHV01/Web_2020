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
    public class DanhSachSPController : Controller
    {
        dbMyPhamOnlineDataContext db = new dbMyPhamOnlineDataContext();
        // GET: Admin/DanhSachSP
        public ActionResult Index(int? page)
        {
            int iPageNum = (page ?? 1);
            int iPageSize = 7;
            var lst = db.DANHSACHSPs.ToList().OrderBy(n => n.MaDS).ToPagedList(iPageNum, iPageSize);
            return View(lst);
        }
    }
}