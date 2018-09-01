using AlaFortanFoni.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;

namespace AlaFortanFoni.Controllers
{
    public class UserController : Controller
    {
        MvcDB db = new MvcDB();
        // GET: User
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult Login()
        {

            return View();
        }

        [HttpPost]
        public ActionResult Login(User user)
        {
            //maile göre üye bilgileirni çektim
            var login = db.User.Where(u => u.Mail == user.Mail).SingleOrDefault();
            
            // password ve mail doğrulandığı takdirede giriş yapacaktır. ve yetkisini b
            if (login.Password == user.Password && login.Mail == user.Mail) 
            {
                //Kişinin id sine göre oturum açacaktır. session da bunun için kulllandım.
                Session["userid"] = login.UserId; 
                Session["username"] = login.UserName;
                Session["roleid"] = login.RoleId;
                return RedirectToAction("Index", "Home");
            }

            else
            {
                ViewBag.uyari = "Yanlış Parola veya Email girdiniz.Lütfen Kontrol Edip Tekrar Deneyiniz";
                return View();
            }

        }

        //çıkış işlemi yaptık
        public ActionResult Logout()
        {
            Session["userid"] = null;
            Session.Abandon(); //Tüm sessionları sonlandırıp kişiye ait oturumu kapatır. üye olmayan kullanıcı sayfasına yönlendirir.
            return RedirectToAction("Index", "Home");

        }


        public ActionResult Create()
        {

            return View();

        }

        [HttpPost] // User Bilgilerini Post metodu ile kaydediyoruz.
        public ActionResult Create(User user, HttpPostedFileBase Photo)
        {
            if (ModelState.IsValid)
            {
                //Fotoğraf null omasa da olur ama diğer password, mail, ve username gerekli olduğu için girişi buna bağlı kıldık
                if (Photo != null && user.Password != null && user.Mail != null && user.UserName != null)
                {
                    WebImage img = new WebImage(Photo.InputStream);
                    FileInfo photoinfo = new FileInfo(Photo.FileName);
                    string newphoto = Guid.NewGuid().ToString() + photoinfo.Extension;
                    img.Resize(150, 150);
                    img.Save("~/UpLoads/UserPhoto/" + newphoto);
                    user.UserPhoto = "/UpLoads/UserPhoto/" + newphoto;

                    user.RoleId = 2; // RoleId'si 1 olanlar admin  2 olanlar user olduğu için burada RoleId yi 2 ye eşitledim. 
                    db.User.Add(user);
                    db.SaveChanges();

                    Session["userid"] = user.UserId;
                    Session["username"] = user.UserName;

                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("Uyarı", "Boş Alanları Doldurunuz");
                }

            }
            return View(user);
        }
    }
}
