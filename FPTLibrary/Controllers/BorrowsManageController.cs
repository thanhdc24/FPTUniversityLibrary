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
    public class BorrowsManageController : Controller
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

        // GET: BorrowsManage
        // Show all Borrows Transaction for Staff
        public ActionResult Index()
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            var tblBorrows = db.tblBorrows.Include(t => t.tblAccount).Include(t => t.tblBookDetail).Where(t => t.IsEnd.Equals(false));
            return View(tblBorrows.ToList());
        }

        // GET: BorrowsManage/Create
        public ActionResult CreateBorrow(string id)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tblBook tblBook = db.tblBooks.Find(id);
            if (tblBook == null)
            {
                return HttpNotFound();
            }
            ViewBag.BookName = tblBook.Name;
            ViewBag.BookID = id;
            return View("Create");
        }

        // POST: BorrowsManage/Create
        // Create new transaction for Borrowing
        public ActionResult Create(string BookID, string SubID, string Email)
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

                //neu book khong available thi return va bao loi
                if (!tblBook.Status.Equals("Available"))
                {
                    ViewBag.BookID = BookID;
                    ViewBag.CreateMessage = "This Book is not available to borrow!";
                    return View();
                }

                //neu Book Instance ID khong ton tai thi return ve View va bao loi
                // Book InstanceID = BookID + SubID
                string InstanceID = BookID + SubID;
                tblBookDetail tblBookDetail = db.tblBookDetails.Find(InstanceID);
                if (tblBookDetail == null)
                {
                    ViewBag.BookID = BookID;
                    ViewBag.CreateMessage = "This Instance ID does not exist!";
                    return View();
                }

                //BookInstance is Lost or Borrowed
                if (tblBookDetail.Status != "Free")
                {
                    ViewBag.BookID = BookID;
                    ViewBag.CreateMessage = "This Book Instance does not available!";
                    return View();
                }

                //neu Email khong ton tai thi return View va bao loi
                tblAccount tblAccount = db.tblAccounts.Find(Email);
                if (tblAccount == null)
                {
                    ViewBag.BookID = BookID;
                    ViewBag.CreateMessage = "This Email does not exist";
                    return View();
                }
                //end validate

                //Add
                tblBookDetail.Status = "Borrowed";
                db.Entry(tblBookDetail).State = EntityState.Modified;
                

                tblBorrow tblBorrow = new tblBorrow();
                tblBorrow.BorrowerEmail = Email;
                tblBorrow.BookSubID = InstanceID;
                tblBorrow.ExtendNumber = 3;
                tblBorrow.CreateDate = DateTime.Now;
                tblBorrow.ReturnDate = DateTime.Now.AddDays(10);
                tblBorrow.IsEnd = false;

                db.tblBorrows.Add(tblBorrow);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View();
        }

        // GET: BorrowsManage/End/5
        // When student return book! Staff End borrows
        public ActionResult EndBorrow(int? id)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tblBorrow tblBorrow = db.tblBorrows.Find(id);
            if (tblBorrow == null)
            {
                return HttpNotFound();
            }

            int date = (int) Math.Round((tblBorrow.ReturnDate - DateTime.Now).TotalDays);

            if (date < 0)
            {
                ViewBag.DayMessage = Math.Abs(date) + " DAYS OVER";
            } else
            {
                if (date == 0)
                {
                    ViewBag.DayMessage = "NO DAY LEFT";
                } else
                {
                    ViewBag.DayMessage = Math.Abs(date) + " DAYS LEFT";
                }
            }
            
            return View("End", tblBorrow);
        }

        // POST: BorrowsManage/End/5
        public ActionResult End(int? BorrowId, string Status)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            if (ModelState.IsValid)
            {
                //check param
                if (BorrowId == null || Status == null)
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

                tblBorrow tblBorrow = db.tblBorrows.Find(BorrowId);
                if (tblBorrow == null)
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

                //End borrow
                tblBookDetail tblBookDetail = tblBorrow.tblBookDetail;
                tblBookDetail.Status = Status;
                tblBorrow.IsEnd = true;
                db.Entry(tblBorrow).State = EntityState.Modified;
                db.Entry(tblBookDetail).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View();
        }

        //Search Borrows Transaction is not end
        public ActionResult Search(string searchValue)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            var tblBorrows = db.tblBorrows.Include(t => t.tblAccount).Include(t => t.tblBookDetail).Where(
                t => t.IsEnd.Equals(false) && t.BorrowerEmail.Contains(searchValue));

            return View("Index", tblBorrows.ToList());
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
