using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication5.Data;
using WebApplication5.Interfaces;
using WebApplication5.Models;

namespace WebApplication5.Controllers
{
    public class HomeController : Controller
    {
        private IDataRepository _iDR;

        public HomeController(IDataRepository iDR)
        {
            this._iDR = iDR;
        }

        [HttpGet]
        public ActionResult Index()
        {
            TempData["data"] = _iDR.getData();
            return View();
        }

        [HttpPost]
        public ActionResult InsertData(tblTest objDD)
        {
            try
            {
                var msg = _iDR.InsertData(objDD);
                return Json(new { Result = msg }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Result = "error" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public ActionResult DeleteData(int Id)
        {
            try
            {
                var msg = _iDR.DeleteData(Id);
                return Json(new { Result = msg }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Result = "error" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public ActionResult getDataByDates(clsData objGD)
        {
            var msg = "";
            try
            {
                var data = _iDR.getDataByDates(objGD);
                return Json(new { Result = data }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception)
            {
                msg = "error";
                return Json(new { Result = msg }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}