using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using prjYiFaShop.Models;

namespace prjYiFaShop.Controllers
{
    [Authorize] //指定控制器所有的動作方法必須通過授權才能執行
    public class MemberController : Controller
    {
        YiFaDBEntities db = new YiFaDBEntities();
        // GET: Member
        public ActionResult Index()
        {
            //取得所有產品放入products
            var products = db.tProduct.OrderByDescending(m => m.fId).ToList();
            //Index.cshtml 檢視套用 _LayoutMember 版面配置，同時使用products模型
            return View("../Home/Index", "_LayoutMember", products);
        }

        //Get:Member/Logout
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Home");
        }

        public ActionResult ShoppingCar()
        {
            //取得登入會員的帳號並指定給fUserId
            string fUserId = User.Identity.Name;
            //找出未成為訂單明細的資料，及購物車內容
            var orderDetails = db.tOrderDetail.Where(m => m.fUserId == fUserId && m.fIsApproved == "否").ToList();
            //View 使用 orderDetail模型
            return View(orderDetails);
        }

        //Get:Member/addCar
        public ActionResult addCar(string fPId)
        {
            //取得會員帳號並指定給fUserId
            string fUserId = User.Identity.Name;
            //找出會員放入訂單明細的產品，該產品的fIsApproved為"否"
            //表示該產品是購物車狀態
            var currentCar = db.tOrderDetail.Where(m => m.fPId == fPId && m.fIsApproved == "否" && m.fUserId == fUserId).FirstOrDefault();
            //若currentCar 等於 null，表示會員選購的產品不是購物車狀態
            if(currentCar == null)
            {
                //找出目前選購的產品並指定給product
                var product = db.tProduct.Where(m => m.fPId == fPId).FirstOrDefault();
                //將產品放入訂單明細
                tOrderDetail orderDetail = new tOrderDetail();
                orderDetail.fUserId = fUserId;
                orderDetail.fPId = fPId;
                orderDetail.fName = product.fName;
                orderDetail.fPrice = product.fPrice;
                orderDetail.fQty = 1;
                orderDetail.fIsApproved = "否";
                db.tOrderDetail.Add(orderDetail);
            }
            else
            {
                //若產品為購物車狀態，即將該產品數量加1
                currentCar.fQty += 1;
            }
            db.SaveChanges();
            return RedirectToAction("ShoppingCar");
        }

        //Get:Member/DeleteCar
        public ActionResult DeleteCar(int fId)
        {
            //依fId 找到要刪除購物車狀態的產品
            var orderDetail = db.tOrderDetail.Where(m => m.fId == fId).FirstOrDefault();
            //刪除購物車狀態的產品
            db.tOrderDetail.Remove(orderDetail);
            db.SaveChanges();
            return RedirectToAction("ShoppingCar");
        }

        //Post:Member/ShoppingCar
        [HttpPost]
        public ActionResult ShoppingCar(string fReceiver, string fEmail, string fAddress)
        {
            //找出會員帳號並指定給fUserId
            string fUserId = User.Identity.Name;
            //建立唯一的識別值並指定給guid變數，用來當作訂單編號
            string guid = Guid.NewGuid().ToString();
            //建立訂單主檔資料
            tOrder order = new tOrder();
            order.fOrderGuid = guid;
            order.fUserId = fUserId;
            order.fReceiver = fReceiver;
            order.fEmail = fEmail;
            order.fAddress = fAddress;
            order.fDate = DateTime.Now;
            order.fStatus = "未處理";
            db.tOrder.Add(order);
            //找出目前會員在訂單明細中是購物車狀態的產品
            var carList = db.tOrderDetail.Where(m => m.fIsApproved == "否" && m.fUserId == fUserId).ToList();
            //將購物車產品狀態設為"是"，表示確認訂購產品
            foreach(var item in carList)
            {
                item.fOrderGuid = guid;
                item.fIsApproved = "是";
            }
            //更新資料庫，異動tOrder 和 tOrderDetail
            //完成訂單主檔和訂單明細的更新
            db.SaveChanges();
            return RedirectToAction("OrderList");
        }


        //Get:Member/OrderList
        public ActionResult OrderList()
        {
            //找出會員帳號並指定給fUserId
            string fUserId = User.Identity.Name;
            //找出目前會員的所有訂單主檔紀錄並依照fDate進行遞增排序
            //將查詢結果指定給orders
            var orders = db.tOrder.Where(m => m.fUserId == fUserId).OrderByDescending(m => m.fDate).ToList();
            //目前會員的訂單主檔OrderList.cshtml檢視使用orders模型
            return View(orders);
        }
        

        //Get:Member/OrderDetail
        public ActionResult OrderDetail(string fOrderGuid)
        {
            //根據fOrderGuid 找出和訂單主檔關聯的訂單明細，並指定給 orderDetails
            var orderDetails = db.tOrderDetail.Where(m => m.fOrderGuid == fOrderGuid).ToList();
            return View(orderDetails);
        }

        public ActionResult EditOrderDetail(int fId) //編輯訂單明細
        {
            //找到會員選取之訂單明細
            tOrderDetail orderDetail = db.tOrderDetail.FirstOrDefault(d => d.fId == fId);
            if (orderDetail != null)
            {
                return View(orderDetail);
            }
            return RedirectToAction("OrderList");
        }
        [HttpPost]
        public ActionResult EditOrderDetail(tOrderDetail editOrderDetail) //編輯訂單明細
        {
            //找到會員選取之訂單明細
            tOrderDetail ord = db.tOrderDetail.FirstOrDefault(d => d.fPId == editOrderDetail.fPId);
            if (ord != null)
            {
                //修改tOrderDetail資料
                ord.fOrderGuid = editOrderDetail.fOrderGuid;
                ord.fUserId = editOrderDetail.fUserId;
                ord.fPId = editOrderDetail.fPId;
                ord.fName = editOrderDetail.fName;
                ord.fPrice = editOrderDetail.fPrice;
                ord.fQty = editOrderDetail.fQty;
                ord.fIsApproved = editOrderDetail.fIsApproved;
                db.SaveChanges();
            }
            return RedirectToAction("OrderList");
        }

        public ActionResult DeleteOrderDetail(int fId) //刪除訂單明細項目
        {
            //依fId 找到要刪除之產品項目
            var orderDetail = db.tOrderDetail.Where(m => m.fId == fId).FirstOrDefault();
            //刪除產品
            db.tOrderDetail.Remove(orderDetail);
            db.SaveChanges();
            return RedirectToAction("OrderList");
        }
    }
}