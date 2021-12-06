using MyPhamOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using PagedList.Mvc;

namespace MyPhamOnline.Controllers
{
    public class SearchController : Controller
    {
        dbMyPhamOnlineDataContext data = new dbMyPhamOnlineDataContext();
        // GET: Admin/Search
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Search(string strSearch)
        {
            ViewBag.Search = strSearch;
            if (!string.IsNullOrEmpty(strSearch))
            {
                var kq = from s in data.SANPHAMs where s.TenSP.Contains(strSearch)select s;

                return View(kq);
                // :@
            }
            return View();
        }
        public ActionResult Group()
        {
            var kq = from s in data.SANPHAMs group s by s.MaDS;



            return View(kq);
        }
        public ActionResult ThongKe()
        {

            var kq = from s in data.SANPHAMs
                     join cd in data.DANHSACHSPs on s.MaDS equals cd.MaDS
                     group s by s.MaDS into g
                     select new ReporInfo
                     {
                         Id = g.Key.ToString(),
                         Count = g.Count(),
                         Sum = g.Sum(n => n.SoLuongBan),
                         Max = g.Max(n => n.SoLuongBan),
                         Min = g.Min(n => n.SoLuongBan),
                         Avg = Convert.ToDecimal(g.Average(n => n.SoLuongBan))
                     };
            return View(kq);
        }



    }
}