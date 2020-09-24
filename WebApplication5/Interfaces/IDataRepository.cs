using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebApplication5.Data;
using WebApplication5.Models;

namespace WebApplication5.Interfaces
{
    public interface IDataRepository
    {
        IEnumerable<tblTest> getData();
        string InsertData(tblTest objTest);
        string DeleteData(int Id);
        List<tblTest> getDataByDates(clsData objData);
    }
}
