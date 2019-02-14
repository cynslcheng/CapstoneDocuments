using Sched.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
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
            
           // validateWorkOrder(DateTime.Now, maxDay, 1, 1, 7, 34, "111 test ave", "n2n 1n1", 30);
         //  WorkOrder workOrder = dbContext.WorkOrder.FirstOrDefault();
            
            return View();
        }
        /// <summary>
        /// create new work order
        /// </summary>
        /// <returns></returns>
        public ActionResult NewWorkOrder()
        {
           
            WorkOrder workOrder = new WorkOrder();
            workOrder.maximum_start_time = DateTime.Now;
            workOrder.minimum_start_time = DateTime.Now;
            workOrder.work_area_id = 7;
            //workOrder.modified_at = DateTime.Now;
            
            workOrder.status_id = 34;

            Session["NewWorkOrder"] = workOrder;
            return View("Index");
        }

        /// <summary>
        /// populate form with details of single work order
        /// </summary>
        /// <param name="workOrder"></param>
        /// <returns></returns>
        public ActionResult SelectWorkOrder(WorkOrder workOrder)
        {
            Session["SelectedWorkOrder"] = workOrder;
            return View("index");
        }
        public ActionResult CreateWorkOrder(DateTime minimum, DateTime maximum, int priority,int jobType,int workArea, int status,string address,string postalCode,int estimatedTime)
        {
            //use model binding https://www.completecsharptutorial.com/mvc-articles/4-ways-to-collect-form-data-in-controller-class-in-asp-net-mvc-5.php
            //if (ValidateWorkOrder(workOrder))
            if(validateWorkOrder(minimum,maximum,address,postalCode,estimatedTime))
            {
                //check that dates are in the future
                Job job = new Job();
                job.job_type_id = jobType;
                job.created_At = DateTime.Now;
                WorkOrder workOrder = new WorkOrder();              
                workOrder.maximum_start_time = maximum;
                workOrder.minimum_start_time = minimum;
                workOrder.created_at = DateTime.Now;
                workOrder.priority = priority;
                workOrder.work_area_id = workArea;
                workOrder.status_id = status;
                
                //validateWorkOrder()
                
                dbContext.WorkOrder.Add(workOrder);
                dbContext.SaveChanges();
                int lastId = dbContext.WorkOrder.OrderByDescending(p => p.Id).FirstOrDefault().Id;
                job.work_order_id = lastId;
                job.status_id = status;
                dbContext.job.Add(job);

                //this will work when constraints on database are changed
                Session["NewWorkOrder"] = null;
                dbContext.SaveChanges();
                
            }
            return View("index");
            //        ViewBag.WorkOrder = workOrder;
            
        }
        public ActionResult updateWorkOrder(int id,DateTime minimum, DateTime maximum, int priority, int jobType, int workArea, int status, string address, string postalCode, int estimatedTime)
        {
           // validateWorkOrder(minimum, maximum, priority, jobType, workArea, status, address, postalCode, estimatedTime);
            if (validateWorkOrder(minimum, maximum, address, postalCode, estimatedTime)==true)
            {
                WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == id).FirstOrDefault();
                workOrder.minimum_start_time = minimum;
                workOrder.maximum_start_time = maximum;
                workOrder.priority = priority;
                workOrder.work_area_id = workArea;
                workOrder.estimated_time_minutes = estimatedTime;
                dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
            }
            else
            {
                ViewBag.WorkOrderError = "Invalid";
                //return error message
            }
            return View("index");
            
        }
        public bool validateWorkOrder(DateTime minimum, DateTime maximum,  string address, string postalCode, int estimatedTime)
        {
            string validationExpression = @"^[ABCEGHJ-NPRSTVXY]{1}[0-9]{1}[ABCEGHJ-NPRSTV-Z]{1}[ ]?[0-9]{1}[ABCEGHJ-NPRSTV-Z]{1}[0-9]{1}$";
            

            Regex regex = new Regex(validationExpression,RegexOptions.Compiled | RegexOptions.IgnoreCase);
            var matches = Regex.Match(postalCode, validationExpression);
            if ( maximum==DateTime.Now||maximum<DateTime.Now)
            {
                ViewBag.WorkOrderError += "Invalid Dates<br/>";
                return false;
            }
           else if(minimum>maximum)
            {
                ViewBag.WorkOrderError += "Invalid Dates<br/>";
                return false;
            }
          else  if(minimum.Date<DateTime.Now.Date)
            {
                ViewBag.WorkOrderError += "Invalid Dates<br/>";
                return false;
            }
            if(regex.IsMatch(postalCode.Trim())== false)
            {
                ViewBag.WorkOrderError += "Invalid Postal Code";
                return false;
            }
            return true;
        }
        public void cancelWorkOrderConfirmation()
        {
            //get confirmation message
        }
        public ActionResult cancelWorkOrder(WorkOrder workOrder)
        {
            int cancelStatus = dbContext.status.Where(x => x.name.ToLower().Equals("cancelled")).FirstOrDefault().Id;
            workOrder.status_id = cancelStatus;
            IEnumerable<Job> jobs = dbContext.job.Where(x => x.work_order_id == workOrder.Id);
            foreach (Job job in jobs)
            {
                job.status_id = cancelStatus;
                dbContext.Entry(job).State = System.Data.Entity.EntityState.Modified;
            }
            dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
            dbContext.SaveChanges();
            return View("index");
        }

        //need cynthia code
        //public bool TimeCheckTechnician()
        //{
        //    return false;
        //}
        //public bool TimeCheckResource()
        //{
        //    return false;
        //}
        ////
        public ActionResult AssignResource(int workOrderId, int resouceId,DateTime startTime)
        {
            //when the list of workorders is up and running 
            //dbContext.crewTechnician()
            //check jobcrew
            //this should change work order to bap when successful
            WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.work_area_id == workOrderId).First();
            Job job = dbContext.job.Where(x => x.work_order_id == workOrderId).First();
            if (dbContext.jobCrew.Where(x=>x.jobId==job.Id).Count()==0)
            {

                //check if crews exist for this job
                Crew crew = new Crew();
                crew.work_area_id = workOrder.work_area_id;
                crew.start_Time = startTime;
                crew.end_Time = startTime.AddMinutes(job.estimated_time_minutes);
                //crew.work_area_id
                crew.created_at = DateTime.Now;
                dbContext.crew.Add(crew);
                dbContext.SaveChanges();

                JobCrew jobCrew = new JobCrew();
                jobCrew.jobId = job.Id;
                jobCrew.crewId = dbContext.crew.OrderByDescending(x => x.Id).FirstOrDefault().Id;
                jobCrew.created_at = DateTime.Now;
                jobCrew.startTime = startTime;
                jobCrew.endTime = startTime.AddMinutes(job.estimated_time_minutes);
                jobCrew.statusId = workOrder.status_id;
                dbContext.jobCrew.Add(jobCrew);
                dbContext.SaveChanges();

                CrewResource crewResource = new CrewResource();
                crewResource.resourceid = resouceId;
                crewResource.crewID = jobCrew.crewId;
                dbContext.crew_resources.Add(crewResource);
                dbContext.SaveChanges();

                workOrder.status_id = 36;

            }
            else
            {
                //crew for whole day?

                JobCrew jobCrew = dbContext.jobCrew.Where(x => x.jobId == job.Id).First();

                //jobCrew.jobId
                Crew crew = dbContext.crew.Where(x => x.Id == jobCrew.crewId).First();
                CrewResource cR = new CrewResource();
                cR.crewID = crew.Id;
                cR.resourceid = resouceId;
                dbContext.crew_resources.Add(cR);
                dbContext.SaveChanges();
                //find job crew
                //
            }
            return View("Index");
        }

        public ActionResult AssignTechnician(int workOrderId, int technicianId, DateTime startTime)
        {
            //when the list of workorders is up and running 
            //dbContext.crewTechnician()
            //check jobcrew
            //this should change work order to bap when successful
            WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.work_area_id == workOrderId).First();
            Job job = dbContext.job.Where(x => x.work_order_id == workOrderId).First();
            if (dbContext.jobCrew.Where(x => x.jobId == job.Id).Count() == 0)
            {

                //check if crews exist for this job
                Crew crew = new Crew();
                crew.work_area_id = workOrder.work_area_id;
                crew.start_Time = startTime;
                crew.end_Time = startTime.AddMinutes(job.estimated_time_minutes);
                //crew.work_area_id
                crew.created_at = DateTime.Now;
                dbContext.crew.Add(crew);
                dbContext.SaveChanges();

                JobCrew jobCrew = new JobCrew();
                jobCrew.jobId = job.Id;
                jobCrew.crewId = dbContext.crew.OrderByDescending(x => x.Id).FirstOrDefault().Id;
                jobCrew.created_at = DateTime.Now;
                jobCrew.startTime = startTime;
                jobCrew.endTime = startTime.AddMinutes(job.estimated_time_minutes);
                jobCrew.statusId = workOrder.status_id;
                dbContext.jobCrew.Add(jobCrew);
                dbContext.SaveChanges();

                crewTechnician cT = new crewTechnician();
                cT.technicanid = technicianId;
                cT.crewid = jobCrew.crewId;
                dbContext.crewTechnician.Add(cT);
                dbContext.SaveChanges();

                workOrder.status_id = 36;

            }
            else
            {
                //crew for whole day?

                JobCrew jobCrew = dbContext.jobCrew.Where(x => x.jobId == job.Id).First();

                //jobCrew.jobId
                Crew crew = dbContext.crew.Where(x => x.Id == jobCrew.crewId).First();
                crewTechnician cT = new crewTechnician();
                cT.crewid = crew.Id;
                cT.technicanid = technicianId;
                dbContext.crewTechnician.Add(cT);
                dbContext.SaveChanges();
                //find job crew
                //
            }
            return View("Index");
        }

        

        public ActionResult Book(WorkOrder workOrder)
        {
            //
            // validateWorkOrder(DateTime.Now, maxDay, 1, 1, 7, 34, "111 test ave", "n2n 1n1", 30);
            //string address, string postalCode, int estimatedTime
            
            
            IEnumerable < Job > jobs = dbContext.job.Where(x => x.work_order_id == workOrder.Id);
            bool check = true;
            bool checkResource = true;
            foreach (Job job in jobs)
            {
                
                // JobCrew jobCrew = dbContext.jobCrew.Where(x => x.jobId == job.Id).FirstOrDefault();


                var query =(from technican in dbContext.technician
                            join crewTechnician in dbContext.crewTechnician on technican.Id equals crewTechnician.technicanid
                            join jobCrew in dbContext.jobCrew on crewTechnician.crewid equals jobCrew.crewId

                            where jobCrew.jobId == job.Id
                            select new  { technican.technicianTypeId }).ToArray();
                
                JobTypesTechnicianType[] requiredTechnicianTypes = dbContext.job_types_technician_type.Where(x => x.jobTypeID == job.job_type_id).ToArray();
                ;
                for (int i = 0; i < query.Length; i++)
                {
                    if (requiredTechnicianTypes[i].technicianTypeID.ToString() != query[i].ToString())
                    {
                        check = false;
                        break;
                    }
                }
                if (check == false)
                {
                    ViewBag.Error = "Insufficient Technicians scheduled<br/>";
                    break;
                }



                var queryResources = (from resources in dbContext.resources
                             join CrewResource in dbContext.crewTechnician on resources.Id equals CrewResource.technicanid
                             join jobCrew in dbContext.jobCrew on CrewResource.crewid equals jobCrew.crewId
                             where jobCrew.jobId == job.Id
                             select new { resources.resource }).ToArray();

                JobTypesResourceType[] requiredResourceTypes = dbContext.job_types_resource_type.Where(x => x.jobTypeID == job.job_type_id).ToArray();
                
                for (int i = 0; i < query.Length; i++)
                {
                    if (requiredResourceTypes[i].resourceTypeId.ToString() != query[i].ToString())
                    {
                        checkResource = false;
                        break;
                    }
                }
                if (checkResource == false)
                {
                    ViewBag.Error += "Insufficient Resources scheduled";
                    break;
                }
               
            }
            if (check && checkResource)
            {
                int updateStatus = dbContext.status.Where(x => x.name == "DIS").FirstOrDefault().Id;
                foreach (Job job in jobs)
                {
                    var crews = dbContext.jobCrew.Where(x => x.jobId == job.Id).ToList();
                    crews.ForEach(x => x.statusId = updateStatus);
                }
                var jobList= jobs.ToList();
                jobList.ForEach(x => x.status_id = updateStatus);
                workOrder.status_id = updateStatus;
                dbContext.SaveChanges();
                
            }
            //figure out how to check if a job has technician that meets the requirements
            //update the status of the work order
            return View("index");
        }

       

    }
}