using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sched.Models;
using NUnit.Framework;
namespace UnitTests
{
    [TestFixture]
    public class DisplayControllerTest
    {
        [Test]
        public void CreateWorkOrderTest()
        {
            SchedContext dbContext = new SchedContext();
            Sched.Controllers.DisplayController controller = new Sched.Controllers.DisplayController();
            WorkOrder userInputModel = new WorkOrder();
            int expected = dbContext.WorkOrder.Count() + 1;
            userInputModel.address = "123 test";
            userInputModel.created_at = DateTime.Now;
            userInputModel.estimated_time_minutes = 10;
            userInputModel.maximum_start_time = DateTime.Now.AddDays(2);
            userInputModel.minimum_start_time = DateTime.Now.AddDays(1);


            //int expected = dbContext.WorkOrder.Count();
        }
    }
}
