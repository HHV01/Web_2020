using MyPhamOnline;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace MyPhamOnline
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            System.IO.StreamReader stReader = new System.IO.StreamReader(Server.MapPath("LuotTruyCap.txt"));
            String s = stReader.ReadLine();
            stReader.Close();
            Application.Add("HitCounter", s);
            Application["Online"] = 0;

        }
        void Session_Start(object sender, EventArgs e)
        {
            Application.Lock();
            Application["Online"] = int.Parse(Application["Online"].ToString()) + 1;
            Application["HitCounter"] = int.Parse(Application["HitCounter"].ToString()) + 1;
            Application.UnLock();
            System.IO.StreamWriter streamWriter = new System.IO.StreamWriter(HttpContext.Current.Server.MapPath("~/LuotTruyCap.txt"));
            streamWriter.Write(Application["HitCounter"]);
            streamWriter.Close();
        }
        void Session_End(object sender, EventArgs e)
        {
            Application.Lock();
            Application["Online"] = int.Parse(Application["Online"].ToString()) - 1;
            Application.UnLock();
        }
    }
}