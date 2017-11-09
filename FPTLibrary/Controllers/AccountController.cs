using FPTLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FPTLibrary.Controllers
{
    public class AccountController : Controller
    {
        private BookLibraryEntities db = new BookLibraryEntities();

        // GET: Account
        public ActionResult Index()
        {
            //action mac dinh duoc goi -> chuyen ve view login
            return View("Login");
        }

        public ActionResult Login(string email, string password)
        {
            //check null params
            if (email == null || password == null || email.Trim().Length == 0 || password.Trim().Length == 0)
            {
                ViewBag.LoginMessage = "Please input email or password!";
                return View();
            }
            email = email.Trim();
            password = password.Trim();


            //check email
            tblAccount tblAccount = db.tblAccounts.Find(email);
            if (tblAccount == null)
            {
                ViewBag.LoginMessage = "Invalid email - Please try again!";
                return View();
            }

            //check password va dieu huong
            if (tblAccount.Password.Equals(password))
            {
                Session["USER"] = tblAccount;
                Session["USERTYPE"] = tblAccount.Type;
                Session["ROLLNUM"] = tblAccount.Rollnumber;

                if (tblAccount.Type == 0)
                    return RedirectToAction("Index", "BookExplore");
                if (tblAccount.Type == 1)
                    return RedirectToAction("Index", "BookManage");
            }

            ViewBag.LoginMessage = "Wrong password - Please try again!";
            return View();
        }

        public ActionResult Logout()
        {
            Session.Abandon();
            return RedirectToAction("Index");
        }
    }
}