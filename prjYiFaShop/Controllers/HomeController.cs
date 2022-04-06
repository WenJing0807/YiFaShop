using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using prjYiFaShop.Models;
using System.Web.Security; //Web應用程式的表單驗證服務

namespace prjYiFaShop.Controllers
{
    public class HomeController : Controller
    {
        YiFaDBEntities db = new YiFaDBEntities();
        //GET: Home/Index
        public ActionResult Index()
        {
            //取得所有產品放入products
            var products = db.tProduct.OrderByDescending(m => m.fId).ToList();
            return View(products);
        }

        //Get: Home/Login
        public ActionResult Login()
        {
            return View();
        }

        //Post: Home/Login
        [HttpPost]
        public ActionResult Login(string fUserId, string fPwd)
        {
            //依帳號密碼取得會員指定給member
            var member = db.tMember.Where(m => m.fUserId == fUserId && m.fPwd == fPwd).FirstOrDefault();
            //若member為null，表示會員未註冊
            if(member == null)
            {
                ViewBag.Message = "帳密錯誤，登入失敗";
                return View();
            }
            //使用Session變數記錄歡迎詞
            Session["WelCome"] = member.fName + "歡迎光臨";
            //指定使用者帳號通過登入驗證
            FormsAuthentication.RedirectFromLoginPage(fUserId, true);
            return RedirectToAction("Index","Member");
        }

        //Get:Home/Register
        public ActionResult Register()
        {
            return View();
        }
        //Post:Home/Register
        [HttpPost]
        public ActionResult Register(tMember pMember)
        {
            //沒有通過驗證會顯示目前的View
            if(ModelState.IsValid == false)
            {
                return View();
            }
            //依帳號取得會員並指定給member
            var member = db.tMember.Where(m => m.fUserId == pMember.fUserId).FirstOrDefault();
            //若member為null，表示會員未註冊
            if(member == null)
            {
                //將會員紀錄新增到tMember資料表
                db.tMember.Add(pMember);
                db.SaveChanges();
                //執行Home Controller Login方法
                return RedirectToAction("Login");
            }
            ViewBag.Message = "此帳號已有人使用，註冊失敗";
            return View();
        }

        //Get: Admin/Login
        public ActionResult ALogin()
        {
            return View();
        }

        //Post: Admin/Login
        [HttpPost]
        public ActionResult ALogin(string fAdminId, string fPwd)
        {
            //依帳號密碼取得管理者指定給admin
            var admin = db.tAdmin.Where(a => a.fAdminId == fAdminId && a.fPwd == fPwd).FirstOrDefault();
            //若admin為null，表示無此管理者
            if (admin == null)
            {
                ViewBag.Message = "帳密錯誤，登入失敗";
                return View();
            }
            //使用Session變數記錄歡迎詞
            Session["WelCome"] = admin.fName + "歡迎";
            //指定使用者帳號通過登入驗證
            FormsAuthentication.RedirectFromLoginPage(fAdminId, true);
            return RedirectToAction("AOrderList", "Admin");
        }
    }
}