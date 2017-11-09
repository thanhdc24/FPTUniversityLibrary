using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FPTLibrary.Models;
using System.Data.Entity.Core.Objects;
using System.Text.RegularExpressions;
using System.IO;

namespace FPTLibrary.Controllers
{
    public class BookManageController : Controller
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

        // GET: BookManage
        // View all Book for Staff
        public ActionResult Index()
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            return View(db.tblBooks.ToList());
        }

        // GET: BookManage/Details/5
        // View Book Details for Staff
        public ActionResult Details(string id)
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
            return View(tblBook);
        }

        // GET: BookManage/Create
        public ActionResult Create()
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            return View();
        }

        // POST: BookManage/Create
        // Create new Book - use HttpPostedFileBase to upload file
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(tblBook tblBook, HttpPostedFileBase file)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            if (ModelState.IsValid)
            {
                //check params, check duplicate
                if (tblBook.ID == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                tblBook book = db.tblBooks.Find(tblBook.ID);
                if (book != null)
                {
                    ViewBag.CreateMessage = "Book ID is already exist";
                    return View();
                }

                //pass check - create new

                //save file
                string textPath = "/Images/no_image.jpg"; //default is noimages
                if (file != null)
                {
                    string path = Path.Combine(Server.MapPath("~/Images"), tblBook.ID + Path.GetFileName(file.FileName));
                    file.SaveAs(path);
                    textPath = "/Images/" + tblBook.ID + file.FileName;
                }

                book = new tblBook()
                {
                    Name = tblBook.Name,
                    AddDate = DateTime.Now,
                    Author = tblBook.Author,
                    Catagories = tblBook.Catagories,
                    Description = tblBook.Description,
                    ID = tblBook.ID,
                    Place = tblBook.Place,
                    Status = tblBook.Status,
                    CoverPicture = textPath
                };
                db.tblBooks.Add(book);
                db.SaveChanges();

                return RedirectToAction("Index");
            }

            return View(tblBook);
        }

        // GET: BookManage/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tblBook tblBook = db.tblBooks.Find(id);
            if (tblBook == null)
            {
                return HttpNotFound();
            }
            return View(tblBook);
        }

        // POST: BookManage/Edit/5
        // Edit Book info
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(tblBook tblBook, HttpPostedFileBase file)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            if (ModelState.IsValid)
            {
                if (file != null)
                {
                    string path = Path.Combine(Server.MapPath("~/Images"), tblBook.ID + Path.GetFileName(file.FileName));
                    file.SaveAs(path);
                    tblBook.CoverPicture = "/Images/" + tblBook.ID + file.FileName;
                }

                db.Entry(tblBook).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tblBook);
        }

        //Search book for Staff
        public ActionResult Search(string searchValue)
        {
            if (!isStaff())
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            if (searchValue == null || searchValue.Trim().Length < 1)
            {
                List<tblBook> model = new List<tblBook>();
                return View("Index", model);
            }

            //use Regular Expression to search more effectively
            //example:
            //param: java guide
            //pattern : .*java.*guide.*
            //search all book have word "java" and "guide"
            searchValue = ".*" + searchValue.ToLower().Trim().Replace(" ", ".*") + ".*";
            Regex pattern = new Regex(searchValue);

            var bookName = db.tblBooks.Select(book => book.Name.ToLower()).AsEnumerable();
            var matchName = bookName.Where(name => pattern.IsMatch(name)).ToList();

            var matchBook = db.tblBooks.Where(book => matchName.Contains(book.Name.ToLower())).ToList();

            return View("Index", matchBook);
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
