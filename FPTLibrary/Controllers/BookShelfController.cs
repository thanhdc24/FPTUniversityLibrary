using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FPTLibrary.Models;

namespace FPTLibrary.Controllers
{
    public class BookShelfController : Controller
    {
        private BookLibraryEntities db = new BookLibraryEntities();

        // GET: BookShelf
        // Select Book is Borrowed by User
        public ActionResult Index()
        {
            //get USER EMAIL
            if (Session["USER"] == null)
                return RedirectToAction("Index", "Init");

            tblAccount tblAccount = (tblAccount)Session["USER"];
            string email = tblAccount.Email;

            //query borrow transaction that is not end
            var borrow = db.tblBorrows.Where(b => b.IsEnd == false && b.BorrowerEmail.Equals(email));
            return View(borrow.ToList());
        }

        // Allow User to Extend Book Borrow Transaction
        public ActionResult Extend(int? id)
        {
            //check params
            if (id == null)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            tblBorrow tblBorrow = db.tblBorrows.Find(id);
            if (tblBorrow == null)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            //get USER EMAIL
            if (Session["USER"] == null)
                return RedirectToAction("Index", "Init");
            tblAccount tblAccount = (tblAccount)Session["USER"];
            string email = tblAccount.Email;

            //check User have permission to change 
            if (!tblBorrow.BorrowerEmail.Equals(email))
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            //check Book Transaction have right condition to change
            if (tblBorrow.ExtendNumber <= 0)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            int date = (int)Math.Round((tblBorrow.ReturnDate - DateTime.Now).TotalDays);
            if (date < -3 || date > 1)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            //pass check - extend borrow
            tblBorrow.ReturnDate = tblBorrow.ReturnDate.AddDays(10);
            tblBorrow.ExtendNumber -= 1;
            db.Entry(tblBorrow).State = EntityState.Modified;
            db.SaveChanges();

            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
