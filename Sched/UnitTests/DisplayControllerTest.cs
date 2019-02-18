using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sched.Models;
using NUnit.Framework;
using System.Web;
using System.Web.SessionState;
using System.IO;
using System.Reflection;

namespace UnitTests
{
    [TestFixture]
    public class DisplayControllerTest
    {
  //because of modified_at column
        [Test]
        public void CreateWorkOrderTest()
        {
            //
            //  Assert.AreEqual(1, 1);
            //TestSetup();
           
          

                SchedContext dbContext = new SchedContext();
                Sched.Controllers.DisplayController controller = new Sched.Controllers.DisplayController();
                WorkOrder userWorkOrderInputModel = new WorkOrder();
            int expected = dbContext.WorkOrder.Count() + 1;
            WorkOrder result = new WorkOrder();
                int userInputJobType = 1;
                string userInputStreet = "test";
                string userInputHouseNumber = "123";


            userWorkOrderInputModel.Id = dbContext.WorkOrder.OrderByDescending(x => x.Id).First().Id+1;
                userWorkOrderInputModel.address = userInputHouseNumber + " " + userInputStreet;
                userWorkOrderInputModel.created_at = DateTime.Now;
                userWorkOrderInputModel.estimated_time_minutes = 10;
                userWorkOrderInputModel.maximum_start_time = DateTime.Now.AddDays(2);
                userWorkOrderInputModel.minimum_start_time = DateTime.Now.AddDays(1);
                userWorkOrderInputModel.priority = 1;
                userWorkOrderInputModel.postal_code = "n1n 1n4";
                userWorkOrderInputModel.work_area_id = 7;
                 userWorkOrderInputModel.status_id = 1;


                DateTime userInputCreatedAt = DateTime.Now;

                DateTime userInputMaximum_start_time = DateTime.Now.AddDays(2);
                DateTime userInputMinimum_start_time = DateTime.Now.AddDays(1);
                
            //controller.s
            controller.successfulCreate(userWorkOrderInputModel.minimum_start_time, userWorkOrderInputModel.maximum_start_time,
                    userWorkOrderInputModel.priority.ToString(),
                    userInputJobType, userWorkOrderInputModel.work_area_id, userInputHouseNumber, userInputStreet,
                    userWorkOrderInputModel.postal_code, userWorkOrderInputModel.estimated_time_minutes);
            result = dbContext.WorkOrder.OrderByDescending(x => x.Id).First();
            //int result = dbContext.WorkOrder.Count();
            Assert.AreEqual(userWorkOrderInputModel.Id, result.Id);
            Assert.AreEqual(userWorkOrderInputModel.status_id , result.status_id);

            //cant do asserts for the datetime as they vary during execution

            //Assert.AreEqual(userWorkOrderInputModel.maximum_start_time, result.maximum_start_time);
            //Assert.AreEqual(userWorkOrderInputModel.minimum_start_time, result.minimum_start_time);
            Assert.AreEqual(userWorkOrderInputModel.postal_code, result.postal_code);
            Assert.AreEqual(userWorkOrderInputModel.address, result.address);
            //Assert.AreEqual(userWorkOrderInputModel.created_at, result.created_at);
            Assert.AreEqual(userWorkOrderInputModel.estimated_time_minutes, result.estimated_time_minutes);

            Job removeJob = dbContext.job.Where(x => x.work_order_id == result.Id).First();
            dbContext.job.Remove(removeJob);
            dbContext.WorkOrder.Remove(result);
            dbContext.SaveChanges();
           // Assert.AreEqual(expected, result);
        }
               
            
           


            //int expected = dbContext.WorkOrder.Count();
        
        [Test]
        public void EditWorkOrderTest()
        {
            SchedContext dbContext = new SchedContext();
            Sched.Controllers.DisplayController controller = new Sched.Controllers.DisplayController();
            WorkOrder userWorkOrderInputModel = new WorkOrder();
            int expected = dbContext.WorkOrder.Count() + 1;
            WorkOrder result = new WorkOrder();
            int userInputJobType = 1;
            string userInputStreet = "testtest";
            string userInputHouseNumber = "123321";


            userWorkOrderInputModel.Id = dbContext.WorkOrder.OrderByDescending(x => x.Id).First().Id;
            userWorkOrderInputModel.address = userInputHouseNumber + " " + userInputStreet;
            userWorkOrderInputModel.created_at = DateTime.Now;
            userWorkOrderInputModel.estimated_time_minutes = 10;
            userWorkOrderInputModel.maximum_start_time = DateTime.Now.AddDays(2);
            userWorkOrderInputModel.minimum_start_time = DateTime.Now.AddDays(1);
            userWorkOrderInputModel.priority = 2;
            userWorkOrderInputModel.postal_code = "n1n 1n4";
            userWorkOrderInputModel.work_area_id = 8;

            //set a status Id purely to avoid database constraint errors
            userWorkOrderInputModel.status_id = 1;


            DateTime userInputCreatedAt = DateTime.Now;

            DateTime userInputMaximum_start_time = DateTime.Now.AddDays(2);
            DateTime userInputMinimum_start_time = DateTime.Now.AddDays(1);

            //controller.s
            controller.successfulUpdate(userWorkOrderInputModel.Id,userWorkOrderInputModel.minimum_start_time, userWorkOrderInputModel.maximum_start_time,
                    userWorkOrderInputModel.priority.ToString(),
                    userInputJobType, userWorkOrderInputModel.work_area_id, userInputHouseNumber, userInputStreet,
                    userWorkOrderInputModel.postal_code, userWorkOrderInputModel.estimated_time_minutes);
            result = dbContext.WorkOrder.OrderByDescending(x => x.Id).First();
            //int result = dbContext.WorkOrder.Count();
            Assert.AreEqual(userWorkOrderInputModel.Id, result.Id);
            //Assert.AreEqual(userWorkOrderInputModel.status_id, result.status_id);

            //cant do asserts for the datetime as they vary during execution

            //Assert.AreEqual(userWorkOrderInputModel.maximum_start_time, result.maximum_start_time);
            //Assert.AreEqual(userWorkOrderInputModel.minimum_start_time, result.minimum_start_time);
            Assert.AreEqual(userWorkOrderInputModel.postal_code, result.postal_code);
            Assert.AreEqual(userWorkOrderInputModel.address, result.address);
            //Assert.AreEqual(userWorkOrderInputModel.created_at, result.created_at);
            Assert.AreEqual(userWorkOrderInputModel.estimated_time_minutes, result.estimated_time_minutes);
        }
        [Test]
        public void CancelWorkOrderTest()
        {

            SchedContext dbContext = new SchedContext();
            Sched.Controllers.DisplayController controller = new Sched.Controllers.DisplayController();
            WorkOrder userWorkOrderInputModel = new WorkOrder();
            //string expected = dbContext.status.Where(x => x.description == "cancelled").First().description;
            int cancelId = dbContext.status.Where(x => x.description == "cancelled").First().Id;
            WorkOrder workOrder = dbContext.WorkOrder.OrderByDescending(x => x.Id).First();

            controller.isSuccesfulCancel(workOrder, cancelId);
            int result = dbContext.WorkOrder.Where(x => x.Id == workOrder.Id).First().status_id;
            Assert.AreEqual(cancelId, result);


        }
        [Test]
        public void AssignResourceTest()
        {

            SchedContext dbContext = new SchedContext();
            Sched.Controllers.DisplayController controller = new Sched.Controllers.DisplayController();

            WorkOrder userWorkOrderInputModel = dbContext.WorkOrder.OrderByDescending(x => x.Id).First();
            Job job = dbContext.job.Where(x => x.work_order_id == userWorkOrderInputModel.Id).First();
            Resources resource = dbContext.resources.OrderByDescending(x => x.Id).First();
            bool expected = true;
            bool result = controller.isSuccesfulAssignResource(userWorkOrderInputModel, resource.Id, userWorkOrderInputModel.minimum_start_time);
            Assert.AreEqual(expected, result);
        }
        [Test]
        public void AssignTechnicianTest()
        {

            SchedContext dbContext = new SchedContext();
            Sched.Controllers.DisplayController controller = new Sched.Controllers.DisplayController();
            WorkOrder userWorkOrderInputModel = dbContext.WorkOrder.OrderByDescending(x => x.Id).First();
            Technician technician = dbContext.technician.OrderByDescending(x => x.Id).First();
            bool expected = true;
            bool result = controller.isSuccessfulAssignTechnician(userWorkOrderInputModel, technician.Id, userWorkOrderInputModel.minimum_start_time);
            Assert.AreEqual(expected, result);
        }
        [Test]
        public void BookTest()
        {

            SchedContext dbContext = new SchedContext();
            Sched.Controllers.DisplayController controller = new Sched.Controllers.DisplayController();
            WorkOrder userWorkOrderInputModel = dbContext.WorkOrder.OrderByDescending(x => x.Id).First();
            int jobId = dbContext.job.Where(x => x.work_order_id == userWorkOrderInputModel.Id).First().Id;
            IEnumerable<Job> jobs = dbContext.job.Where(x => x.work_order_id == userWorkOrderInputModel.Id);
            bool expected = true;
            bool result = controller.isSuccessfulBook(jobId, userWorkOrderInputModel, jobs);
        }
    }
}
