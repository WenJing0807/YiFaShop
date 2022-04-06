using prjYiFaShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace prjYiFaShop.Controllers
{
    [Authorize] //指定控制器所有的動作方法必須通過授權才能執行
    public class AdminController : Controller
    {
        YiFaDBEntities db = new YiFaDBEntities();
        // GET: Admin
        public ActionResult Index()
        {
            //取得所有訂單放入orders
            var orders = db.tOrder.OrderByDescending(m => m.fId).ToList();
            //Index.cshtml 檢視套用 _LayoutAdmin 版面配置，同時使用orders模型
            return View("../Admin/AOrderList", "_LayoutAdmin", orders);
        }

        public ActionResult List()
        {
            IEnumerable<tProduct> datas = null;
            string keyword = Request.Form["txtKeyword"]; //抓取使用者輸入的關鍵字
            if (string.IsNullOrEmpty(keyword))
            {
                datas = from p in db.tProduct
                        select p;
            }
            else
            {
                datas = db.tProduct.Where(p => p.fName.Contains(keyword)); //找出產品中含有關鍵字的項目
            }
            return View(datas);
        }

        //Get:Admin/Logout
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("ALogin", "Home");
        }

        //Get:Admin/OrderList
        public ActionResult AOrderList()
        {
            //將查詢結果指定給orders
            var orders = db.tOrder.OrderByDescending(m => m.fDate).ToList();
            //目前會員的訂單主檔OrderList.cshtml檢視使用orders模型
            return View(orders);
        }

        //Get:Admin/OrderDetail
        public ActionResult AOrderDetail(string fOrderGuid)
        {
            //根據fOrderGuid 找出和訂單主檔關聯的訂單明細，並指定給 orderDetails
            var orderDetails = db.tOrderDetail.Where(m => m.fOrderGuid == fOrderGuid).ToList();
            return View(orderDetails);
        }

        //public ActionResult AFinshOrder(string fOrderGuid, string fPId)
        //{
        //    //找到管理者選取之訂單明細
        //    var orderDetail = db.tOrderDetail.Where(d => d.fOrderGuid == fOrderGuid && d.fPId == fPId).ToList();
        //    //修改訂單狀態為已完成
        //    foreach(var item in orderDetail)
        //    {
        //        item.fIsApproved = "已完成";
        //    }
            
        //    db.SaveChanges();
        //    return RedirectToAction("AOrderList");
        //}

        public ActionResult EditStatus(string fOrderGuid) //修改訂單狀態
        {
            //根據fOrderGuid 找出和訂單主檔關聯的訂單明細，並指定給 orderDetails
            var orderDetails = db.tOrder.Where(m => m.fOrderGuid == fOrderGuid).ToList();
            //修改訂單狀態為已完成
            foreach (var item in orderDetails)
            {
                item.fStatus = "已完成";
            }
            db.SaveChanges();
            return RedirectToAction("AOrderList");
        }

        public ActionResult DeleteOrderDetail(int fId) //刪除訂單明細項目
        {
            //依fId 找到要刪除之產品項目
            var orderDetail = db.tOrderDetail.Where(m => m.fId == fId).FirstOrDefault();
            //刪除產品
            db.tOrderDetail.Remove(orderDetail);
            db.SaveChanges();
            return RedirectToAction("AOrderList");
        }

        public ActionResult EditOrderDetail(string fOrderGuid, string fPId) //編輯訂單明細
        {
            //找到管理者選取之訂單明細
            tOrderDetail orderDetail = db.tOrderDetail.FirstOrDefault(d => d.fOrderGuid == fOrderGuid && d.fPId == fPId);
            if(orderDetail != null)
            {
                return View(orderDetail);
            }
            return RedirectToAction("AOrderList");
        }
        [HttpPost]
        public ActionResult EditOrderDetail(tOrderDetail editOrderDetail) //編輯訂單明細
        {
            //找到管理者選取之訂單明細
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
            return RedirectToAction("AOrderList");
        }

        public ActionResult CreateProduct()
        {
            return View();
        }
        [HttpPost]
        public ActionResult CreateProduct(tProduct p) //新增產品
        {
            if(p != null)
            {
                db.tProduct.Add(p);
                db.SaveChanges();
            }
            return RedirectToAction("List");
        }

        public ActionResult EditProduct(int? fId) //編輯產品資訊
        {
            if (fId != null)
            {
                
                tProduct prod = db.tProduct.FirstOrDefault(p => p.fId == (int)fId);
                if (prod != null)
                    return View(prod);
            }
            return RedirectToAction("List");
        }

        [HttpPost]
        public ActionResult EditProduct(tProduct editProduct)
        {

            tProduct prod = db.tProduct.FirstOrDefault(p => p.fId == editProduct.fId);
            if (prod != null)
            {
                prod.fPId = editProduct.fPId;
                prod.fName = editProduct.fName;
                prod.fPrice = editProduct.fPrice;
                db.SaveChanges();
            }
            return RedirectToAction("List");
        }

        public ActionResult DeleteProduct(int fId) //刪除產品資訊
        {
            //依fId 找到要刪除之產品項目
            var deleteproduct = db.tProduct.Where(m => m.fId == fId).FirstOrDefault();
            //刪除產品
            db.tProduct.Remove(deleteproduct);
            db.SaveChanges();
            return RedirectToAction("List");
        }
    }
}