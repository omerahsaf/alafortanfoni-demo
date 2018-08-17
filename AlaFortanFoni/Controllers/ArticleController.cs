using AlaFortanFoni.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AlaFortanFoni.Controllers
{
    public class ArticleController : Controller
    {
        MvcDB db = new MvcDB();
        // GET: Article
        public ActionResult Index()
        {
            var article = db.Article.OrderByDescending(a => a.ArticleId).ToList();
            return View(article.OrderByDescending(a=>a.Displayed));
        }
    }
}