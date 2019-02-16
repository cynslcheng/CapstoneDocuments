using Sched.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace Sched.Controllers
{
    /// <summary>
    /// Use session variables to tell view which forms to load
    /// also use session variables to keep forms populated while other actions/methods are occuring in other controllers
    /// </summary>
    public class DisplayController : Controller
    {
        SchedContext dbContext = new SchedContext();


        public ActionResult Index()
        {
            dbContext.jobTypes.Select(x => new { Id = x.Id, Type = x.name });
            //  ViewBag.Test = "Hello";

            return View();
        }
        /// <summary>
        /// create new work order
        /// </summary>
        /// <returns></returns>



        public ActionResult NewWorkOrder()
        {
            Session["WorkOrderFormType"] = "Create";

            WorkOrder workOrder = new WorkOrder();
            workOrder.maximum_start_time = DateTime.Now;
            workOrder.minimum_start_time = DateTime.Now;
            // workOrder.work_area_id = 7;
            //workOrder.modified_at = DateTime.Now;
            int newWorkOrderStats = dbContext.status.Where(x => x.name == "WSCHED").First().Id;
            workOrder.status_id = newWorkOrderStats;
            populateSelectList();
            // //Session["WorkArea"]=
            // Session["NewWorkOrder"] = workOrder;
            // Session["WorkOrderFormType"] = "Create";
            // return View();
            return RedirectToAction("Index", "Home");
        }

        /// <summary>
        /// populate form with details of single work order
        /// </summary>
        /// <param name="workOrder"></param>
        /// <returns></returns>
        [ChildActionOnly]
        public ActionResult SelectWorkOrder()
        {
            WorkOrder workOrder = (WorkOrder)Session["workOrder"];
            Session["WorkOrderFormType"] = "Select";

            //incase work order has been changed in between dispatcher clicking and when this method is called
            //workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrder.Id).First();
            Session["SelectedWorkOrder"] = workOrder;
            Session["Error"] = null;
            Session["Success"] = null;
            return View(workOrder);
        }
        private void populateSelectList()
        {

            List<SelectListItem> jobSelectList = new List<SelectListItem>();
            var jobSelectItems = dbContext.jobTypes;
            bool update = false;
            int jobTypeId = 0;
            int workAreaId = 0;
            int priority = 1;
            WorkOrder workOrder = (WorkOrder)Session["workOrder"];
            if (Session["WorkOrderFormType"].ToString() == "Update")
            {
                update = true;
                jobTypeId = dbContext.job.Where(x => x.work_order_id == workOrder.Id).First().job_type_id;
                workAreaId = dbContext.WorkOrder.Where(x => x.work_area_id == workOrder.work_area_id).First().work_area_id;
                priority = dbContext.WorkOrder.Where(x => x.Id == workOrder.Id).First().priority;

            }
            List<SelectListItem> priorityList= new List<SelectListItem>();
            for (int i = 1; i < 5; i++)
            {
                if (i==priority)
                {
                    priorityList.Add(new SelectListItem { Text = i.ToString(), Value = i.ToString(), Selected = true });
                }
                else
                {

                    priorityList.Add(new SelectListItem { Text = i.ToString(), Value = i.ToString(), Selected = true });

                }
            }
            foreach (var selectItemJob in jobSelectItems)
            {
                if (update && selectItemJob.Id == jobTypeId)
                {
                    jobSelectList.Add(new SelectListItem { Text = selectItemJob.name, Value = selectItemJob.Id.ToString(), Selected = true });
                }
                else
                {
                    jobSelectList.Add(new SelectListItem { Text = selectItemJob.name, Value = selectItemJob.Id.ToString() });
                }

            }

            List<SelectListItem> workAreaList = new List<SelectListItem>();
            var workAreaSelectItems = dbContext.workArea;
            foreach (var selectItemWorkArea in workAreaSelectItems)
            {
                if (update && selectItemWorkArea.Id == workAreaId)
                {
                    workAreaList.Add(new SelectListItem { Text = selectItemWorkArea.region, Value = selectItemWorkArea.Id.ToString(), Selected = true });
                }
                workAreaList.Add(new SelectListItem { Text = selectItemWorkArea.region, Value = selectItemWorkArea.Id.ToString() });

            }

            Session["WorkAreaList"] = workAreaList;
            Session["JobSelectList"] = jobSelectList;
            Session["PriorityList"] = priorityList;
        }

        public ActionResult CreateWorkOrder(DateTime minimum, DateTime maximum, string priority, int jobType, int workArea, string address, string postalCode, int estimatedTime)
        {
            Session["Error"] = null;
            Session["Success"] = null;
            //use model binding https://www.completecsharptutorial.com/mvc-articles/4-ways-to-collect-form-data-in-controller-class-in-asp-net-mvc-5.php
            //if (ValidateWorkOrder(workOrder))
            int statusId = dbContext.status.Where(x => x.name == "WSCHED").First().Id;
            WorkOrder workOrder = new WorkOrder();
            workOrder.maximum_start_time = maximum;
            workOrder.minimum_start_time = minimum;
            workOrder.created_at = DateTime.Now;
            workOrder.priority = Convert.ToInt32(priority);
            workOrder.work_area_id = workArea;
            workOrder.status_id = statusId;
            workOrder.address = address;
            workOrder.postal_code = postalCode;
            if (validateWorkOrder(minimum, maximum, address, postalCode, estimatedTime))
            {
                try
                {
                    
                    //check that dates are in the future
                    Job job = new Job();
                    job.job_type_id = jobType;
                    job.created_At = DateTime.Now;
                    job.estimated_time_minutes = estimatedTime;

                    //validateWorkOrder()

                    dbContext.WorkOrder.Add(workOrder);
                    dbContext.SaveChanges();

                    int lastId = dbContext.WorkOrder.OrderByDescending(p => p.Id).FirstOrDefault().Id;
                    job.work_order_id = lastId;
                    job.status_id = statusId;
                    dbContext.job.Add(job);

                    //this will work when constraints on database are changed
                    Session["WorkOrderFormType"] = null;
                    Session["NewWorkOrder"] = null;
                    dbContext.SaveChanges();
                    Session["Success"] = "Work order Created";
                }
                catch (Exception e)
                {

                    Session["Error"] = "Unexpected error occured: " + e.Message;
                    return RedirectToAction("Index", "Home");
                }

            }
            else
            {
                Session["workOrder"] = workOrder;
                return RedirectToAction("Index", "Home");

                //ViewBag.Error=""
            }
            return RedirectToAction("Index", "Home");
            //        ViewBag.WorkOrder = workOrder;

        }
        public ActionResult update()
        {
            Session["Error"] = null;
            Session["Success"] = null;
            WorkOrder workOrder = (WorkOrder)Session["workOrder"];
            int workOrderId = workOrder.Id;
            workOrder.postal_code=workOrder.postal_code.Replace(' ', '-');
            workOrder.address=workOrder.address.Replace(' ', '-');
            //WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrderId).First();
            Session["WorkOrderFormType"] = "Update";
            //Session["workOrder"] = workOrder;
            Session["MaxDateTime"] = workOrder.maximum_start_time;
            Session["MinDateTime"] = workOrder.minimum_start_time;
            Session["workOrder"] = workOrder;
            populateSelectList();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult updateWorkOrder(DateTime? minimum, DateTime? maximum, string priority, int jobType, int workArea, string address, string postalCode, int estimatedTime)
        {
            Session["Error"] = null;
            Session["Success"] = null;
            DateTime maxDate;
            DateTime minDate;
            WorkOrder oldWorkOrder = (WorkOrder)Session["workOrder"];
            if (maximum == null)
            {
                maxDate = oldWorkOrder.maximum_start_time;
            }
            else
            {
                maxDate = (DateTime)maximum;
            }
            if (minimum == null)
            {
                minDate = oldWorkOrder.minimum_start_time;

            }
            else
            {
                minDate = (DateTime)minimum;
            }

            // validateWorkOrder(minimum, maximum, priority, jobType, workArea, status, address, postalCode, estimatedTime);
            if (validateWorkOrder(minDate, maxDate, address, postalCode, estimatedTime) == true)
            {
                try
                {
                    WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == oldWorkOrder.Id).FirstOrDefault();
                    workOrder.minimum_start_time = minDate;
                    workOrder.maximum_start_time = maxDate;
                    workOrder.priority = Convert.ToInt32(priority);
                    workOrder.work_area_id = workArea;
                    workOrder.address = address;
                    workOrder.postal_code = postalCode;
                    workOrder.estimated_time_minutes = estimatedTime;
                    dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                    dbContext.SaveChanges();
                    Session["Success"] = "Work order updated!";
                    
                    Session["WorkOrderFormType"] = null;
                    Session["workOrder"] = null;
                    return RedirectToAction("Index", "Home");
                }
                catch (Exception e)
                {

                    Session["Error"] = "Unexpected error occured: " + e.Message;
                    return RedirectToAction("Index", "Home");
                }
            }


            else
            {
                //orkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == id).FirstOrDefault();
                // ViewBag.WorkOrderError = "Invalid";
                return RedirectToAction("Index", "Home");
                //return error message
            }
            // return View("index");

        }

        public bool validateWorkOrder(DateTime minimum, DateTime maximum, string address, string postalCode, int estimatedTime)
        {
            string validationExpression = @"^[ABCEGHJ-NPRSTVXY]{1}[0-9]{1}[ABCEGHJ-NPRSTV-Z]{1}[ ]?[0-9]{1}[ABCEGHJ-NPRSTV-Z]{1}[0-9]{1}$";


            Regex regex = new Regex(validationExpression, RegexOptions.Compiled | RegexOptions.IgnoreCase);
            var matches = Regex.Match(postalCode, validationExpression);
            if (postalCode.Trim()=="")
            {
                Session["Error"] += "Invalid Postal Code";
                return false;
            }
            else
            {
              postalCode=  postalCode.Replace('-', ' ');
            }
            if (maximum == DateTime.Now || maximum < DateTime.Now)
            {
                Session["Error"] += "Invalid Dates<br/>";
                return false;
            }
            else if (minimum > maximum)
            {
                Session["Error"] += "Invalid Dates<br/>";
                return false;
            }
            else if (minimum.Date < DateTime.Now.Date)
            {
                Session["Error"] += "Invalid Dates<br/>";
                return false;
            }
            if (address == "")
            {
                Session["Error"] += "Invalid Address<br/>";
                return false;
            }
            else
            {
                address = address.Replace('-', ' ');
            }
            if (regex.IsMatch(postalCode.Trim()) == false)
            {
                Session["Error"] += "Invalid Postal Code";
                return false;
            }
            return true;
        }
        public ActionResult Cancel()
        {
            Session["Error"] = null;
            Session["Success"] = null;
            Session["WorkOrderFormType"] = "Cancel";
            //WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == id).FirstOrDefault();
            Session["WorkOrderFormType"] = "Cancel";
            return RedirectToAction("index", "Home");
            // Session["WorkOrderCrud"] = workOrder;
            //get confirmation message
        }
        public ActionResult cancelWorkOrder()
        {
            Session["Error"] = null;
            Session["Success"] = null;
            WorkOrder workOrder = (WorkOrder)Session["workOrder"];
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
            Session["WorkOrderFormType"] = null;
            Session["workOrder"] = null;
            return View("index", "Home");
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

        public ActionResult AssignResource(int workOrderId, int resourceId, DateTime startTime)
        {
            //when the list of workorders is up and running 
            //dbContext.crewTechnician()
            //check jobcrew
            //this should change work order to bap when successful

            //INSERT CALL TO CYNTHIA VALIDATION******
            Session["Error"] = null;
            Session["Success"] = null;
            WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrderId).First();
            Job job = dbContext.job.Where(x => x.work_order_id == workOrderId).First();
            int updateId = dbContext.status.Where(x => x.name == "BAPP").First().Id;
            try
            {
                if (dbContext.jobCrew.Where(x => x.jobId == job.Id).Count() != 0)
                {
                    JobCrew jobCrew = dbContext.jobCrew.Where(x => x.jobId == job.Id).First();

                    //jobCrew.jobId
                    Crew crew = dbContext.crew.Where(x => x.Id == jobCrew.crewId).First();
                    CrewResource cR = new CrewResource();
                    cR.crewID = crew.Id;
                    cR.resourcesid = resourceId;
                    dbContext.crew_resources.Add(cR);
                    //int updateId = dbContext.status.Where(x => x.name == "BAPP").First().Id;
                    workOrder.status_id = updateId;
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
                    // int 
                    jobCrew.status_id = updateId;
                    dbContext.jobCrew.Add(jobCrew);
                    dbContext.SaveChanges();

                    CrewResource crewResource = new CrewResource();
                    crewResource.resourcesid = resourceId;
                    crewResource.crewID = jobCrew.crewId;
                    dbContext.crew_resources.Add(crewResource);


                    workOrder.status_id = updateId;
                    dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                    dbContext.SaveChanges();
                }

            }
            catch (Exception e)
            {

                Session["Error"] = e.Message;
            }
            return RedirectToAction("Index", "Home");
            //  return View("Index");
        }

        public ActionResult AssignTechnician(int workOrderId, int technicianId, DateTime startTime)
        {
            Session["Error"] = null;
            Session["Success"] = null;
            //when the list of workorders is up and running 
            //dbContext.crewTechnician()
            //check jobcrew
            //this should change work order to bap when successful

            //INSERT CALL TO CYNTHIA VALIDATION

            WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrderId).First();
            Job job = dbContext.job.Where(x => x.work_order_id == workOrderId).First();
            int updateId = dbContext.status.Where(x => x.name == "BAPP").First().Id;
            if (dbContext.jobCrew.Where(x => x.jobId == job.Id).Count() != 0)
            {
                try
                {
                    JobCrew jobCrew = dbContext.jobCrew.Where(x => x.jobId == job.Id).First();

                    //jobCrew.jobId
                    Crew crew = dbContext.crew.Where(x => x.Id == jobCrew.crewId).First();
                    CrewTechnician cT = new CrewTechnician();
                    cT.crewid = crew.Id;
                    cT.technicianid = technicianId;
                    dbContext.crew_technician.Add(cT);
                    workOrder.status_id = updateId;
                    dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                    dbContext.SaveChanges();
                }
                catch (Exception e)
                {

                    Session["Error"] = "SQL Server error: " + e.Message;
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

                CrewTechnician cT = new CrewTechnician();
                cT.technicianid = technicianId;
                cT.crewid = jobCrew.crewId;
                dbContext.crew_technician.Add(cT);
                workOrder.status_id = updateId;
                dbContext.SaveChanges();



            }

            return RedirectToAction("index", "Home");
        }



        public ActionResult Book()
        {
            //
            // validateWorkOrder(DateTime.Now, maxDay, 1, 1, 7, 34, "111 test ave", "n2n 1n1", 30);
            //string address, string postalCode, int estimatedTime
            Session["Error"] = null;
            Session["Success"] = null;
            WorkOrder workOrder = (WorkOrder)Session["workOrder"];


            IEnumerable<Job> jobs = dbContext.job.Where(x => x.work_order_id == workOrder.Id);
            bool check = true;
            bool checkResource = true;
            Job job = dbContext.job.Where(x => x.work_order_id == workOrder.Id).First();
            if (workOrder.status_id == dbContext.status.Where(x => x.name == "DIS").First().Id)
            {
                Session["Error"] = "It was already dispatched!";
                return RedirectToAction("Index", "Home");
            }
            if (dbContext.jobCrew.Where(x => x.jobId == job.Id).Count() != 0)
            {
                var query = (from technican in dbContext.technician
                             join crewTechnician in dbContext.crew_technician on technican.Id equals crewTechnician.technicianid
                             join jobCrew in dbContext.jobCrew on crewTechnician.crewid equals jobCrew.crewId

                             where jobCrew.jobId == job.Id
                             select new { technican.technician_type }).ToArray();



                JobTypesTechnicianType[] requiredTechnicianTypes = dbContext.job_types_technician_type.Where(x => x.job_types_id == job.job_type_id).ToArray();
                ;
                for (int i = 0; i < query.Length; i++)
                {
                    if (requiredTechnicianTypes[i].technician_type_id.ToString().Trim() != query[i].technician_type.ToString().Trim())
                    {
                        check = false;
                        break;
                    }
                }
                if (check == false)
                {
                    Session["Error"] = "Insufficient Technicians scheduled<br/>";

                }



                var queryResources = (from resources in dbContext.resources
                                      join CrewResource in dbContext.crew_technician on resources.Id equals CrewResource.technicianid
                                      join jobCrew in dbContext.jobCrew on CrewResource.crewid equals jobCrew.crewId
                                      where jobCrew.jobId == job.Id
                                      select new { resources.resource_type }).ToArray();

                JobTypesResourceType[] requiredResourceTypes = dbContext.job_types_resource_type.Where(x => x.job_types_id == job.job_type_id).ToArray();

                for (int i = 0; i < query.Length; i++)
                {
                    if (requiredResourceTypes.Count() != queryResources.Count())
                    {
                        checkResource = false;
                        break;
                    }
                    if (requiredResourceTypes[i].resource_type_id.ToString() != queryResources[i].resource_type.ToString().Trim())
                    {
                        checkResource = false;
                        break;
                    }
                }
                if (checkResource == false)
                {
                    Session["Error"] += "Insufficient Resources scheduled";

                }


                if (Session["Error"] == null)
                {
                    int updateStatus = dbContext.status.Where(x => x.name == "DIS").FirstOrDefault().Id;

                    var crews = dbContext.jobCrew.Where(x => x.jobId == job.Id).ToList();
                    crews.ForEach(x => x.status_id = updateStatus);

                    var jobList = jobs.ToList();
                    jobList.ForEach(x => x.status_id = updateStatus);
                    workOrder.status_id = updateStatus;
                    dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                    dbContext.SaveChanges();
                    Session["Success"] = "Work order Dispatched";
                    workOrder = null;
                }
            }

            //figure out how to check if a job has technician that meets the requirements
            //update the status of the work order

            return RedirectToAction("Index", "Home");
        }



    }
}