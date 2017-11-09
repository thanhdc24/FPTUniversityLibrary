using FPTLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FPTLibrary.Controllers
{
    public class InitController : Controller
    {
        private BookLibraryEntities db = new BookLibraryEntities();

        // GET: Init
        // Website vua khoi dong hoac user request action cu the
        // Dieu huong toi cac chuc nang khac
        public ActionResult Index()
        {
            if (Session["USER"] != null)
            {
                tblAccount tblAccount = (tblAccount)Session["USER"];
                if (tblAccount.Type == 0)
                    return RedirectToAction("Index", "BookExplore");
                if (tblAccount.Type == 1)
                    return RedirectToAction("Index", "BookManage");
            }
            return RedirectToAction("Index", "Account");
        }
    }
}