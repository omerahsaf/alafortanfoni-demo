using AlaFortanFoni.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using PagedList.Mvc;
using PagedList;

namespace AlaFortanFoni.Controllers
{
    //Makale insert, delete, update, create ve bazı işlemleri için Admin Controller açıldı. 
    public class AdminArticleController : Controller
    {
        //Database bağlantımızı yaptık.
        MvcDB db = new MvcDB();


        // GET: AdminArticle // Article(makalelerimizi) ilk on tanesini listeledim
        public ActionResult Index(int Page = 1)
        {
            var articles = db.Article.OrderByDescending(a => a.ArticleId).ToPagedList(Page, 10);
            return View(articles);
        }

        // GET: AdminArticle/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: AdminArticle/Create
        public ActionResult Create()
        {
            // Makale eklemek için gerekli registerleri listeledik ve kategori id ye göre kategori isimlerini çağırdık.
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CategoryName");
            return View();
        }

        // POST: AdminArticle/Create
        [HttpPost]  // Girilen bilgilerin post edilmesi ve kaydedilmesi burada oluşacak.
        public ActionResult Create(Article article, HttpPostedFileBase Photo)
        {
            if (ModelState.IsValid)
            {
                if (Photo != null)
                {
                    WebImage img = new WebImage(Photo.InputStream);
                    FileInfo photoinfo = new FileInfo(Photo.FileName);
                    string newphoto = Guid.NewGuid().ToString() + photoinfo.Extension;
                    img.Resize(800, 350);

                    //Foto eklemek için Uploads Klasörü açıldı ve yolunu verildi. foto kayıtları buraya gelecek database'e de  yolunu gönderildi.
                    img.Save("~/UpLoads/ArticlePhoto/" + newphoto);
                    article.ArticlePhoto = "/UpLoads/ArticlePhoto/" + newphoto;

                    article.UserId = Convert.ToInt32(Session["userid"]); //oturumu açmış admin kişinin makale eklemesi için 
                    db.Article.Add(article);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }


            }
            return View(article);

        }

        // GET: AdminArticle/Edit/5

        public ActionResult Edit(int id)
        {
            //Edit etmek için önce id ye göre makaleyi çekiyoruz.
            var article = db.Article.Where(a => a.ArticleId == id).SingleOrDefault();
            if (article == null)
            {
                return HttpNotFound();
            }

            //Makelenin kategorisini çekiyerouz.
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CategoryName", article.CategoryId);

            return View(article);
        }

        // POST: AdminArticle/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, HttpPostedFileBase Photo, Article article)
        {
            try
            {
                //güncelleme işlemi için yeni bir değişken (articles) atayıp. bu değişken üzerinden yeni veriler eklenecek
                var articles = db.Article.Where(a => a.ArticleId == id).SingleOrDefault();

                // Fotoğrafın Update yapılması için kod bloğu
                if (Photo != null)
                {
                    if (System.IO.File.Exists(Server.MapPath(articles.ArticlePhoto)))
                    {
                        System.IO.File.Delete(Server.MapPath(articles.ArticlePhoto));
                    }

                    WebImage img = new WebImage(Photo.InputStream);
                    FileInfo photoinfo = new FileInfo(Photo.FileName);
                    string newphoto = Guid.NewGuid().ToString() + photoinfo.Extension;
                    img.Resize(800, 350);

                    img.Save("~/UpLoads/ArticlePhoto/" + newphoto);
                    articles.ArticlePhoto = "/UpLoads/ArticlePhoto/" + newphoto;

                    // eski bilgileri articles değişkenine atadık. (article değişkeninden article(s) değişkenine)
                    articles.Text = article.Text;
                    articles.Title = article.Title;
                    articles.CategoryId = article.CategoryId;
                    db.SaveChanges();

                }
                return RedirectToAction("Index");

            }
            catch
            {

                return View(article);
            }
        }

        // GET: AdminArticle/Delete/5
        public ActionResult Delete(int id)
        {
            var article = db.Article.Where(a => a.ArticleId == id).SingleOrDefault();
            if (article == null)
            {
                return HttpNotFound();
            }
            return View(article);
        }

        // POST: AdminArticle/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {     //makelemizi id ye göre çağırdık silme işlemini id ye göre yapacağız.
                var article = db.Article.Where(a => a.ArticleId == id).SingleOrDefault();
                if (article == null)
                {
                    return HttpNotFound();
                }

                //Fotoyu siler
                if (System.IO.File.Exists(Server.MapPath(article.ArticlePhoto)))
                {
                    System.IO.File.Delete(Server.MapPath(article.ArticlePhoto));
                }

                // Yapılan yorumları siler 
                foreach (var i in article.Comment.ToList())
                {
                    db.Comment.Remove(i);
                }

                db.Article.Remove(article); 
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
