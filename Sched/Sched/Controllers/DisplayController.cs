using Sched.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sched.Controllers
{
    public class DisplayController : Controller
    {
        SchedContext dbContext = new SchedContext();
        
        public ActionResult Index()
        {

            ViewBag.Test = "Hello";
           // WorkOrder workOrder = dbContext.WorkOrder.FirstOrDefault();
            return View();
        }
        public ActionResult NewWorkOrder()
        {
            Display display = new Display();
            WorkOrder workOrder = new WorkOrder();
            workOrder.maximum_start_time = DateTime.Now;
            workOrder.minimum_start_time = DateTime.Now;
            workOrder.work_area_id = 7;
            List<WorkOrder> workOrders = new List<WorkOrder>();
            List<Job> potentialJobs = new List<Job>();
            potentialJobs = dbContext.job.ToList();
            workOrders.Add(workOrder);
            return View("Index");
        }
        //public ActionResult NewWorkOrder(WorkOrder workOrder)
        //{
        //    if (ValidateWorkOrder(workOrder))
        //    {

        //    }
        //    //        ViewBag.WorkOrder = workOrder;
        //    else
        //    {

        //    }
        //    return View();
        //}
        //public ActionResult AssignResource()
        //{
        //    dbContext.jobCrew
        //}

        //public ActionResult AssignTechnician()
        //{

        //}

        //public ActionResult Book()
        //{

        //    ValidateWorkOrder();

        //    //update the status of the work order
        //    return View();
        //}

        //public bool ValidateWorkOrder(WorkOrder workOrder)
        //{

        //    //check if all resources and technicians are free, if yes continue
        //    return false;
        //}
        //public bool technicianSkillCheck(JobCrew jobCrew)
        //{

        //    //get list of jobs
        //    //get list of technicians in crew
        //    //for loop through list of jobs
        //    //if a technician or resource meets that requirement remove requirement from list
        //    //if list is 0 return true;


        //}
        //public bool resourceSkillCheck()
        //{
        //    //get list of resources
        //}
        //public bool timeCheck()
        //{

        //    //check if all resources and technicians are free for the job
        //}
        public void assignWorkOrder()
        {

        }
        
        public ActionResult createWorkOrder()
        {

            return View();
        }
    }
}