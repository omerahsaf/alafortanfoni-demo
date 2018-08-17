using AlaFortanFoni.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using PagedList.Mvc;
using System.Xml.Linq;
using System.Xml;

namespace AlaFortanFoni.Controllers
{
    public class HomeController : Controller
    {
        MvcDB db = new MvcDB();

        // GET: Home)
        public ActionResult Index(int Page = 1)
        {  // makaleleri sınırlı şekilde sayfaya koymak içim  paget list i nugget menagger den indirdik                                                                             
            var article = db.Article.OrderByDescending(a => a.ArticleId).ToPagedList(Page, 5);
            return View(article);
        }



        //Makaleler Title lere göre aranacak. 
        public ActionResult Search(string ara = null)
        {
            var aranan = db.Article.Where(a => a.Title.Contains(ara)).ToList(); // contains ile başlıklarda yer alan harf ve ya kelimelere göre arama yapılıyor.
            return View(aranan.OrderByDescending(a=>a.Time)); // burada makaleler en yakın tarihten geçmişe doğru sıralandı.
        }



        public ActionResult Article()
        {
            return View();
        }

        //Makale detay sayfası için makale id ye göre makale çektik. 
        public ActionResult ArticleDetails(int id)
        {
            var article = db.Article.Where(a => a.ArticleId == id).SingleOrDefault();
            if (article == null)
            {
                return HttpNotFound();
            }
            return View(article);
        }


        public ActionResult Category()
        {
            return View();
        }



        // category listesi yapmak için liste çektik
        public ActionResult CategoryPartial()
        {
            return View(db.Category.ToList());
        }


        //Yorum Yapmak için parametreleri tanımladık // 
        public JsonResult YorumYap(string yorum, int Makale_Id)
        {
            var userid = Session["userid"]; // sadece Üye olan kullanıcının yorum yapması için 
            if (yorum == null) 
            {
                return Json(true, JsonRequestBehavior.AllowGet);

            }
            db.Comment.Add(new Comment { UserId = Convert.ToInt32(userid), ArticleId = Makale_Id, CommentText = yorum, CommentTime = DateTime.Now });
            db.SaveChanges();
            return Json(false, JsonRequestBehavior.AllowGet);
        }



        public ActionResult CommentDelete(int id)

        {
            var userid = Session["userid"]; //yorumu yapan kişinin yorumunu silmesi için
            var yorum = db.Comment.Where(y => y.CommentId == id).SingleOrDefault();
            var makale = db.Article.Where(m => m.ArticleId == yorum.ArticleId).SingleOrDefault();
            if (yorum.UserId == Convert.ToInt32(userid))
            {
                db.Comment.Remove(yorum);
                db.SaveChanges();
                return RedirectToAction("ArticleDetails", "Home", new { id = makale.ArticleId });
            }
            else
            {
                return HttpNotFound();
            }
        }


        //makale her görüntülendiğinde Displayedi 1 arttırmak için yazdık 

        public ActionResult OkunmaArttir(int Makale_Id)
        {
            var makale = db.Article.Where(m => m.ArticleId == Makale_Id).SingleOrDefault();

            makale.Displayed += 1;
            db.SaveChanges();
            return View();
        }


        public ActionResult ApiPartial()
        {
            string api = "741359c7e36e73868e19b69316d24c7c";
            string baglanti = "http://api.openweathermap.org/data/2.5/weather?q=İstanbul&mode=xml&lang=tr&units=metric&appid=" + api;
            XDocument Hava = XDocument.Load(baglanti);
            var sicaklik = Hava.Descendants("temperature").ElementAt(0).Attribute("value").Value;
            var icon = Hava.Descendants("weather").ElementAt(0).Attribute("icon").Value;
            var durum = Hava.Descendants("weather").ElementAt(0).Attribute("value").Value;
            ViewBag.icon = "http://openweathermap.org/img/w/" + icon + ".png";
            ViewBag.sicaklik = sicaklik + " ºC";
            ViewBag.durum = durum;
            return View();

        }
    }
}