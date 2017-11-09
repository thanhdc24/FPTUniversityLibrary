using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FPTLibrary.Models;
using System.Text.RegularExpressions;

namespace FPTLibrary.Controllers
{
    public class BookExploreController : Controller
    {
        private BookLibraryEntities db = new BookLibraryEntities();

        // GET: BookExplore
        // Find book and View for User
        public ActionResult Index()
        {
            var bookList = db.tblBooks.Where(book => book.Status.Equals("Available"));
            foreach (tblBook book in bookList)
            {
                int count = book.tblBookDetails.Count(a => a.Status.Equals("Free"));
                if (count > 0)
                {
                    book.InstanceStatus = "Available";
                } else
                {
                    book.InstanceStatus = "Out of Stock";
                }
            }
            return View(bookList);
        }

        // GET: BookExplore/Details/5
        // View Book Details
        public ActionResult Details(string id)
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

        // Search bookList -> View at Index
        public ActionResult Search(string searchValue)
        {
            //check params
            if (searchValue == null || searchValue.Trim().Length < 1)
            {
                List<tblBook> model = new List<tblBook>();
                return View("Index", model);
            }

            //use Regular Expression to Search effectively
            searchValue = ".*" + searchValue.ToLower().Trim().Replace(" ", ".*") + ".*";
            Regex pattern = new Regex(searchValue);

            var bookName = db.tblBooks.Select(book => book.Name.ToLower()).AsEnumerable();
            var matchName = bookName.Where(name => pattern.IsMatch(name)).ToList();

            var matchBook = db.tblBooks.Where(book => matchName.Contains(book.Name.ToLower()) && book.Status.Equals("Available")).ToList();

            //Count to knows Out of Stock Book
            foreach (tblBook book in matchBook)
            {
                int count = book.tblBookDetails.Count(a => a.Status.Equals("Free"));
                if (count > 0)
                {
                    book.InstanceStatus = "Available";
                }
                else
                {
                    book.InstanceStatus = "Out of Stock";
                }
            }

            return View("Index", matchBook);
        }
        
        //View book in different catagories -> View at Index
        public ActionResult Catagory(string value)
        {
            //check param if null - search ALL
            if (value == null || value.Trim().Length < 1)
            {
                value = "All";
            }

            if (value.Trim().ToLower().Equals("all"))
            {
                return RedirectToAction("Index");
            }

            //search with catagory
            var bookList = db.tblBooks.Where(book => book.Status.Equals("Available") && book.Catagories.ToLower().Equals(value));
            foreach (tblBook book in bookList)
            {
                int count = book.tblBookDetails.Count(a => a.Status.Equals("Free"));
                if (count > 0)
                {
                    book.InstanceStatus = "Available";
                }
                else
                {
                    book.InstanceStatus = "Out of Stock";
                }
            }
            return View("Index", bookList);
        }

        //filter new book - order by book.AddDate - Take 15 book
        public ActionResult News()
        {
            var bookList = db.tblBooks.Where(book => book.Status.Equals("Available")).OrderByDescending(book => book.AddDate).Take(15);
            foreach (tblBook book in bookList)
            {
                int count = book.tblBookDetails.Count(a => a.Status.Equals("Free"));
                if (count > 0)
                {
                    book.InstanceStatus = "Available";
                }
                else
                {
                    book.InstanceStatus = "Out of Stock";
                }
            }
            return View("Index", bookList);
        }

        //filter - book which is the most borrowed ones
        public ActionResult TopTrend()
        {
            //get newest 100 borrows transaction
            var nearBorrow = db.tblBorrows.OrderByDescending(borrow => borrow.CreateDate).Take(100);

            //count transaction group by book
            var listBook = nearBorrow.GroupBy(b => b.tblBookDetail.BookID).Select(n => new { BookID = n.Key , Count = n.Count()});

            //join to get full infomation of book
            var topBook = from book in db.tblBooks join b in listBook on book.ID equals b.BookID orderby b.Count descending select book;

            foreach (tblBook book in topBook)
            {
                int count = book.tblBookDetails.Count(a => a.Status.Equals("Free"));
                if (count > 0)
                {
                    book.InstanceStatus = "Available";
                }
                else
                {
                    book.InstanceStatus = "Out of Stock";
                }
            }
            return View("Index", topBook.ToList());
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
