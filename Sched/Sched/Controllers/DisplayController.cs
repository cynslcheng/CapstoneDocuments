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

            //  ViewBag.Test = "Hello";
            DateTime maximum = DateTime.Now;
            DateTime minimum = DateTime.Now;
            maximum = maximum.AddDays(1);
            WorkOrder workorder = dbContext.WorkOrder.Where(x => x.Id == 22).First();
           // AssignResource(22, 2, minimum);
            //AssignTechnician(22, 1, minimum);
            // validateWorkOrder(DateTime.Now, maxDay, 1, 1, 7, 34, "111 test ave", "n2n 1n1", 30);
            //  WorkOrder workOrder = dbContext.WorkOrder.FirstOrDefault();
            //updateWorkOrder(16, minimum, maximum, 1, 3, 8, 34, "123 nowhere", "n3r 1k4", 70);
          //  CreateWorkOrder(minimum, maximum, 1, 2, 7, 34, "123 test Street", "n3r 1k4", 70);
            //Book(workorder);
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

            //THIS IS WHERE THOMAS'S CONTROL EVENT SHOULD LEAD TO****************

            Session["SelectedWorkOrder"] = workOrder;
            return View("index");
        }
        public void CreateWorkOrder(DateTime minimum, DateTime maximum, int priority,int jobType,int workArea, int status,string address,string postalCode,int estimatedTime)
        {
            //use model binding https://www.completecsharptutorial.com/mvc-articles/4-ways-to-collect-form-data-in-controller-class-in-asp-net-mvc-5.php
            //if (ValidateWorkOrder(workOrder))
            if(validateWorkOrder(minimum,maximum,address,postalCode,estimatedTime))
            {
                //check that dates are in the future
                Job job = new Job();
                job.job_type_id = jobType;
                job.created_At = DateTime.Now;
                job.estimated_time_minutes = estimatedTime;
                WorkOrder workOrder = new WorkOrder();              
                workOrder.maximum_start_time = maximum;
                workOrder.minimum_start_time = minimum;
                workOrder.created_at = DateTime.Now;
                workOrder.priority = priority;
                workOrder.work_area_id = workArea;
                workOrder.status_id = status;
                workOrder.address = address;
                workOrder.postal_code = postalCode;
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
                ViewBag.SuccessCreate = "Work order Created";
            }
           // return View("index");
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
                workOrder.address = address;
                workOrder.postal_code = postalCode;
                workOrder.estimated_time_minutes = estimatedTime;
                dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                dbContext.SaveChanges();
                ViewBag.UpdateSuccess = "Work order updated!";
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
            if(address=="")
            {
                ViewBag.WorkOrderError += "Invalid Address<br/>";
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
        public void AssignResource(int workOrderId, int resouceId,DateTime startTime)
        {
            //when the list of workorders is up and running 
            //dbContext.crewTechnician()
            //check jobcrew
            //this should change work order to bap when successful

            //INSERT CALL TO CYNTHIA VALIDATION******

            WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrderId).First();
            Job job = dbContext.job.Where(x => x.work_order_id == workOrderId).First();
            try
            {
                if (dbContext.jobCrew.Where(x => x.jobId == job.Id).Count() != 0)
                {
                    JobCrew jobCrew = dbContext.jobCrew.Where(x => x.jobId == job.Id).First();

                    //jobCrew.jobId
                    Crew crew = dbContext.crew.Where(x => x.Id == jobCrew.crewId).First();
                    CrewResource cR = new CrewResource();
                    cR.crewID = crew.Id;
                    cR.resourcesid = resouceId;
                    dbContext.crew_resources.Add(cR);
                    workOrder.status_id = 36;
                    dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                    dbContext.SaveChanges();
                }
                else
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
                    jobCrew.start_time = startTime;
                    jobCrew.end_time = startTime.AddMinutes(job.estimated_time_minutes);
                    jobCrew.status_id = workOrder.status_id;
                    dbContext.jobCrew.Add(jobCrew);
                    dbContext.SaveChanges();

                    CrewResource crewResource = new CrewResource();
                    crewResource.resourcesid = resouceId;
                    crewResource.crewID = jobCrew.crewId;
                    dbContext.crew_resources.Add(crewResource);


                    workOrder.status_id = 36;
                    dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                    dbContext.SaveChanges();
                }

            }
            catch (Exception e)
            {

                ViewBag.Error = e.Message;
            }
            
          //  return View("Index");
        }

        public ActionResult AssignTechnician(int workOrderId, int technicianId, DateTime startTime)
        {
            //when the list of workorders is up and running 
            //dbContext.crewTechnician()
            //check jobcrew
            //this should change work order to bap when successful

            //INSERT CALL TO CYNTHIA VALIDATION

            WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrderId).First();
            Job job = dbContext.job.Where(x => x.work_order_id == workOrderId).First();
            if (dbContext.jobCrew.Where(x => x.jobId == job.Id).Count() != 0)
            {
                try
                {
                    JobCrew jobCrew = dbContext.jobCrew.Where(x => x.jobId == job.Id).First();

                    //jobCrew.jobId
                    Crew crew = dbContext.crew.Where(x => x.Id == jobCrew.crewId).First();
                    crewTechnician cT = new crewTechnician();
                    cT.crewid = crew.Id;
                    cT.technicianid = technicianId;
                    dbContext.crewTechnician.Add(cT);
                    workOrder.status_id = 36;
                    dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                    dbContext.SaveChanges();
                }
                catch (Exception e)
                {

                    ViewBag.Error = "SQL Server error: " + e.Message;
                }
                
            }
            else
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
                jobCrew.start_time = startTime;
                jobCrew.end_time = startTime.AddMinutes(job.estimated_time_minutes);
                jobCrew.status_id = workOrder.status_id;
                dbContext.jobCrew.Add(jobCrew);
                dbContext.SaveChanges();

                crewTechnician cT = new crewTechnician();
                cT.technicianid = technicianId;
                cT.crewid = jobCrew.crewId;
                dbContext.crewTechnician.Add(cT);
                workOrder.status_id = 36;
                dbContext.SaveChanges();

                

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
            Job job = dbContext.job.Where(x => x.work_order_id == workOrder.Id).First();
            var query = (from technican in dbContext.technician
                         join crewTechnician in dbContext.crewTechnician on technican.Id equals crewTechnician.technicianid
                         join jobCrew in dbContext.jobCrew on crewTechnician.crewid equals jobCrew.crewId

                         where jobCrew.jobId == job.Id
                         select new { technican.technician_type }).ToArray();
           
           

            JobTypesTechnicianType[] requiredTechnicianTypes = dbContext.job_types_technician_type.Where(x => x.job_types_id == job.job_type_id).ToArray();
            ;
            for (int i = 0; i < query.Length; i++)
            {
                if (requiredTechnicianTypes[i].technician_type_id.ToString() != query[i].ToString())
                {
                    check = false;
                    break;
                }
            }
            if (check == false)
            {
                ViewBag.Error = "Insufficient Technicians scheduled<br/>";
               
            }



            var queryResources = (from resources in dbContext.resources
                                  join CrewResource in dbContext.crewTechnician on resources.Id equals CrewResource.technicianid
                                  join jobCrew in dbContext.jobCrew on CrewResource.crewid equals jobCrew.crewId
                                  where jobCrew.jobId == job.Id
                                  select new { resources.resource_type }).ToArray();

            JobTypesResourceType[] requiredResourceTypes = dbContext.job_types_resource_type.Where(x => x.job_types_id == job.job_type_id).ToArray();

            for (int i = 0; i < query.Length; i++)
            {
                if (requiredResourceTypes.Count()!=queryResources.Count())
                {
                    checkResource = false;
                    break;
                }
                if (requiredResourceTypes[i].resource_type_id.ToString() != queryResources[i].ToString())
                {
                    checkResource = false;
                    break;
                }
            }
            if (checkResource == false)
            {
                ViewBag.Error += "Insufficient Resources scheduled";
               
            }

            //foreach (Job job in jobs)
            //{

            //    // JobCrew jobCrew = dbContext.jobCrew.Where(x => x.jobId == job.Id).FirstOrDefault();


            //}
            if (ViewBag.Error=="")
            {
                int updateStatus = dbContext.status.Where(x => x.name == "DIS").FirstOrDefault().Id;
                
                    var crews = dbContext.jobCrew.Where(x => x.jobId == job.Id).ToList();
                    crews.ForEach(x => x.status_id = updateStatus);
                
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