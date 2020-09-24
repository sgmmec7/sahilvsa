using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication5.Data;
using WebApplication5.Interfaces;
using WebApplication5.Models;

namespace WebApplication5.Repository
{
    public class DataRepository : IDataRepository
    {
        public IEnumerable<tblTest> getData()
        {
            List<tblTest> lstObj = new List<tblTest>();
            try
            {
                using (var db = new vsaTestEntities())
                {
                    var data = db.tblTests.ToList();
                    return data;
                }
            }
            catch (Exception)
            {
                return lstObj;
            }
        }

        public string InsertData(tblTest objTest)
        {
            try
            {
                using (var db = new vsaTestEntities())
                {
                    db.tblTests.Add(objTest);
                    db.SaveChanges();
                }
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public string DeleteData(int Id)
        {
            try
            {
                using (var db = new vsaTestEntities())
                {
                    tblTest test = db.tblTests.Find(Id);
                    db.tblTests.Remove(test);
                    db.SaveChanges();
                }
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public List<tblTest> getDataByDates(clsData objGD)
        {
            List<tblTest> lstTest = new List<tblTest>();
            tblTest objTest = new tblTest();
            try
            {
                using (var db = new vsaTestEntities())
                {
                    if (objGD.DueDate != null)
                    {
                        var data = db.spGetDataByDates(null, null, Convert.ToDateTime(objGD.DueDate));

                        DateTime dd = data.FirstOrDefault().ReceivedDate;

                        objTest.ReceivedDate = data.FirstOrDefault().ReceivedDate;
                        objTest.SentDate = data.FirstOrDefault().SentDate;
                        objTest.DueDate = data.FirstOrDefault().DueDate;
                        objTest.Name = data.FirstOrDefault().Name;
                        objTest.Description = data.FirstOrDefault().Description;
                        objTest.ClaimsAdministrator = data.FirstOrDefault().ClaimsAdministrator;
                        objTest.Employer = data.FirstOrDefault().Employer;
                        objTest.Request = data.FirstOrDefault().Request;


                    }
                    else if (objGD.SentDate != null && objGD.ReceiveDate != null)
                    {
                        var data = db.spGetDataByDates(Convert.ToDateTime(objGD.ReceiveDate), Convert.ToDateTime(objGD.SentDate), null);
                        objTest.ReceivedDate = data.FirstOrDefault().ReceivedDate;
                        objTest.SentDate = data.FirstOrDefault().SentDate;
                        objTest.DueDate = data.FirstOrDefault().DueDate;
                        objTest.Name = data.FirstOrDefault().Name;
                        objTest.Description = data.FirstOrDefault().Description;
                        objTest.ClaimsAdministrator = data.FirstOrDefault().ClaimsAdministrator;
                        objTest.Employer = data.FirstOrDefault().Employer;
                        objTest.Request = data.FirstOrDefault().Request;
                    }
                    lstTest.Add(objTest);
                    return lstTest;
                }
            }
            catch (Exception)
            {
                return lstTest;
            }
        }
    }
}