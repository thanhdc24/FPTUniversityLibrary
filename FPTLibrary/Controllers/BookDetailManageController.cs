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
    public class BookDetailManageController : Controller
    {
        private BookLibraryEntities db = new BookLibraryEntities();

        public bool isStaff()
        {
            if (Session["USER"] == null)
                return false;
            tblAccount acc = (tblAccount)Session["USER"];
            if (acc.Type != 1)
                return false;
            return true;
        }

        // GET: BookDetailManage/Create
        // nhan Book ID tu BookManage de Add Instance Book
        public ActionResult Create(string ID)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            if (ID == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tblBook tblBook = db.tblBooks.Find(ID);
            if (tblBook == null)
            {
                return HttpNotFound();
            }
            ViewBag.BookName = tblBook.Name;
            return View();
        }

        // POST: BookDetailManage/Create
        // BookID + SubID -> Instance ID -> Add
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(string BookID, string SubID)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            if (ModelState.IsValid)
            {
                //check param
                if (BookID == null || SubID == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                tblBook tblBook = db.tblBooks.Find(BookID);
                if (tblBook == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                ViewBag.BookName = tblBook.Name;

                //Check Instance ID already exist
                string ID = BookID + SubID;
                tblBookDetail tblBookDetail = db.tblBookDetails.Find(ID);
                if (tblBookDetail != null)
                {
                    ViewBag.CreateMessage = "This ID Instance already exist!";
                    return View();
                }

                //Success Add ! Return to Add New
                tblBookDetail = new tblBookDetail();
                tblBookDetail.BookID = BookID;
                tblBookDetail.SubID = ID;
                tblBookDetail.Status = "Free"; //Default is Free
                db.tblBookDetails.Add(tblBookDetail);
                db.SaveChanges();


                ViewBag.CreateMessage = "Successfully!";
                return View();
            }

            return View();
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
