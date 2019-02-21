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




        /// <summary>
        /// Populates new work order form
        /// </summary>
        /// <returns></returns>

        public ActionResult NewWorkOrder()
        {
            SetSessionMessages("WorkOrderFormType", "Create");
            SetSessionMessages("Success", "");
            SetSessionMessages("Error", "");
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


            SetSessionMessages("WorkOrderFormType", "Select");

            //incase work order has been changed in between dispatcher clicking and when this method is called
            //workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrder.Id).First();
            Session["SelectedWorkOrder"] = workOrder;
            SetSessionMessages("workOrder", "");
            SetSessionMessages("Success", "");
            SetSessionMessages("Error", "");
            return View(workOrder);
        }

        

        /// <summary>
        /// Populates select Lists for job types, priority, and work area
        /// </summary>
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
            List<SelectListItem> priorityList = new List<SelectListItem>();
            for (int i = 1; i < 5; i++)
            {
                if (i == priority)
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

        /// <summary>
        /// If creates messages for user depending on if the work order was created or not
        /// </summary>
        /// <param name="minimum"></param>
        /// <param name="maximum"></param>
        /// <param name="priority"></param>
        /// <param name="jobType"></param>
        /// <param name="workArea"></param>
        /// <param name="houseNumber"></param>
        /// <param name="street"></param>
        /// <param name="postalCode"></param>
        /// <param name="estimatedTime"></param>
        /// <returns></returns>
        public ActionResult CreateWorkOrder(DateTime minimum, DateTime maximum, string priority, int jobType, int workArea, string address, string postalCode, int estimatedTime)
        {

            if (validateWorkOrder(minimum, maximum, address, postalCode, estimatedTime))
            {
                try
                {

                    //this will work when constraints on database are changed
                    SetSessionMessages("WorkOrderFormType", "");
                    SetSessionMessages("NewWorkOrder", "");
                    SetSessionMessages("Success", "Work order Created");
                    successfulCreate(minimum,maximum,priority,jobType,workArea,address,postalCode,estimatedTime);

                }
                catch (Exception e)
                {

                    Session["Error"] = "Unexpected error occured: " + e.Message;
                    return RedirectToAction("Index", "Home");
                }

            }
            else
            {
                Session["workOrder"] = null;
                return RedirectToAction("Index", "Home");


            }
            return RedirectToAction("Index", "Home");
            //        ViewBag.WorkOrder = workOrder;

        }
        /// <summary>
        /// Inserts workorder model into database
        /// returns true if successful
        /// </summary>
        /// <param name="minimum"></param>
        /// <param name="maximum"></param>
        /// <param name="priority"></param>
        /// <param name="jobType"></param>
        /// <param name="workArea"></param>
        /// <param name="houseNumber"></param>
        /// <param name="street"></param>
        /// <param name="postalCode"></param>
        /// <param name="estimatedTime"></param>
        /// <returns></returns>
        public bool successfulCreate(DateTime minimum, DateTime maximum, string priority, int jobType, int workArea, string address, string postalCode, int estimatedTime)
        {
            try
            {
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
                workOrder.estimated_time_minutes = estimatedTime;
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
                dbContext.SaveChanges();
                SetSessionMessages("WOHeader", "");
                return true;
            }
            catch (Exception e)
            {

                Session["Error"] = "Error creating work order: " + e.Message;
                return false;
            }


        }
        public ActionResult Update()
        {
            Session["Error"] = null;
            Session["Success"] = null;
            WorkOrder workOrder = (WorkOrder)Session["workOrder"];
            int workOrderId = workOrder.Id;
           
            workOrder.address = workOrder.address;
            //WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrderId).First();
            Session["WorkOrderFormType"] = "Update";
            //Session["workOrder"] = workOrder;
            Session["MaxDateTime"] = workOrder.maximum_start_time;
            Session["MinDateTime"] = workOrder.minimum_start_time;

            //It seems the address get's cut off when displaying in view as a whole variable
            //not sure what causes this

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
                    successfulUpdate(oldWorkOrder.Id, minDate, maxDate, priority, jobType, workArea, address, postalCode, estimatedTime);
                    SetSessionMessages("Success", "Work order updated!");
                    SetSessionMessages("WorkOrderFormType", "");
                    SetSessionMessages("workOrder", "");
                    SetSessionMessages("WOHeader", "");
                    return RedirectToAction("Index", "Home");
                }
                catch (Exception e)
                {
                    SetSessionMessages("Error", "Unexpected error occured: " + e.Message);

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
        /// <summary>
        /// Updates work order in the database
        /// returns true if succesful
        /// </summary>
        /// <param name="id"></param>
        /// <param name="minDate"></param>
        /// <param name="maxDate"></param>
        /// <param name="priority"></param>
        /// <param name="jobType"></param>
        /// <param name="workArea"></param>
        /// <param name="houseNumber"></param>
        /// <param name="street"></param>
        /// <param name="postalCode"></param>
        /// <param name="estimatedTime"></param>
        /// <returns></returns>
        public bool successfulUpdate(int id, DateTime minDate, DateTime maxDate, string priority, int jobType, int workArea, string address, string postalCode, int estimatedTime)
        {
            try
            {
                WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == id).FirstOrDefault();
                workOrder.minimum_start_time = minDate;
                workOrder.maximum_start_time = maxDate;
                workOrder.priority = Convert.ToInt32(priority);
                workOrder.work_area_id = workArea;
                workOrder.address = address;
                workOrder.postal_code = postalCode;
                workOrder.status_id = 1;
                workOrder.estimated_time_minutes = estimatedTime;
                Job job = dbContext.job.Where(x => x.work_order_id == workOrder.Id).First();
                job.job_type_id = jobType;
                dbContext.Entry(job).State = System.Data.Entity.EntityState.Modified;
                dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                dbContext.SaveChanges();

                return true;
            }
            catch (Exception e)
            {
                SetSessionMessages("Error", "Error update work order: " + e.Message);

                return false;

            }
        }
        /// <summary>
        /// validates the user created model
        /// </summary>
        /// <param name="minimum"></param>
        /// <param name="maximum"></param>
        /// <param name="street"></param>
        /// <param name="houseNumber"></param>
        /// <param name="postalCode"></param>
        /// <param name="estimatedTime"></param>
        /// <returns></returns>
        public bool validateWorkOrder(DateTime minimum, DateTime maximum, string address, string postalCode, int estimatedTime)
        {
            string validationExpression = @"^[ABCEGHJ-NPRSTVXY]{1}[0-9]{1}[ABCEGHJ-NPRSTV-Z]{1}[ ]?[0-9]{1}[ABCEGHJ-NPRSTV-Z]{1}[0-9]{1}$";
            string addressValidationExpression = @"^\d+[ ](?:[A-Za-z0-9.-]+[ ]?)+(?:Avenue|Lane|Road|Boulevard|Drive|Street|Ave|Dr|Rd|Blvd|Ln|St)\.?$";

            Regex addressRegex = new Regex(addressValidationExpression, RegexOptions.Compiled | RegexOptions.IgnoreCase);
            var addressMatches = Regex.Match(address, validationExpression);


            Regex regex = new Regex(validationExpression, RegexOptions.Compiled | RegexOptions.IgnoreCase);
            var matches = Regex.Match(postalCode, validationExpression);
            if (postalCode.Trim() == "")
            {
                Session["Error"] += "Invalid Postal Code";
                return false;
            }
           
            if (estimatedTime < 1)
            {
                Session["Error"] += "A job can't be less than 1 minute!<br/>";
                return false;
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
           
            if (addressRegex.IsMatch(address.Trim())==false)
            {
                Session["Error"] += "Invalid Address";
                return false;
            }

           

            if (regex.IsMatch(postalCode.Trim()) == false)
            {
                Session["Error"] += "Invalid Postal Code";
                return false;
            }
            return true;
        }
        /// <summary>
        /// populates cancel form
        /// </summary>
        /// <returns></returns>
        public ActionResult Cancel()
        {
            SetSessionMessages("Error", "");
            SetSessionMessages("Success", "");
            SetSessionMessages("WorkOrderFormType", "Cancel");


            //WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == id).FirstOrDefault();

            return RedirectToAction("index", "Home");
            // Session["WorkOrderCrud"] = workOrder;
            //get confirmation message
        }
        /// <summary>
        /// Pulls database information to be used for 
        /// isSuccessfulCancel method
        ///
        /// </summary>
        /// <returns></returns>
        public ActionResult cancelWorkOrder(string value)
        {
            SetSessionMessages("Error", "");
            SetSessionMessages("Success", "");

            WorkOrder workOrder = (WorkOrder)Session["workOrder"];
            if (value=="Yes")
            {
                int cancelStatus = dbContext.status.Where(x => x.name.ToLower().Equals("cancelled")).FirstOrDefault().Id;

                if (isSuccesfulCancel(workOrder, cancelStatus))
                {
                    SetSessionMessages("WorkOrderFormType", "");
                    SetSessionMessages("workOrder", "");
                    SetSessionMessages("Success", "Work Order Cancelled");
                }
            }

            else
            {
                SetSessionMessages("WorkOrderFormType", "");
                SetSessionMessages("workOrder", "");
                SetSessionMessages("WOHeader", "");
                
            }
           
            return RedirectToAction("Index", "Home");
        }
        /// <summary>
        /// Changes workorder status to cancel in database
        /// returns true if successful
        /// </summary>
        /// <param name="workOrder"></param>
        /// <param name="cancelStatus"></param>
        /// <returns></returns>
        public bool isSuccesfulCancel(WorkOrder workOrder, int cancelStatus)
        {
            try
            {
                workOrder.status_id = cancelStatus;
                IEnumerable<Job> jobs = dbContext.job.Where(x => x.work_order_id == workOrder.Id);
                foreach (Job job in jobs)
                {
                    job.status_id = cancelStatus;
                    dbContext.Entry(job).State = System.Data.Entity.EntityState.Modified;
                }
                dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                dbContext.SaveChanges();

            }
            catch (Exception e)
            {

                SetSessionMessages("Error", e.Message);
            }
            return true;
        }

        /// <summary>
        /// Grabs data for the isSucccessfulAssignResource method
        /// </summary>
        /// <param name="workOrderId"></param>
        /// <param name="resourceId"></param>
        /// <param name="startTime"></param>
        /// <returns></returns>
        public ActionResult AssignResource(int workOrderId, int resourceId, DateTime startTime)
        {
            //when the list of workorders is up and running 
            //dbContext.crewTechnician()
            //check jobcrew
            //this should change work order to bap when successful


            Session["Error"] = null;
            Session["Success"] = null;
            if (startTime==null)
            {
                SetSessionMessages("Error", "Set a start time");
                return RedirectToAction("Index", "Home");
            }
            bool validateResource = ValidateTechnician(workOrderId, resourceId, startTime);
            if (!validateResource)
            {
                Session["Error"] = "Resource already booked for this time, please try again";
                return RedirectToAction("Index", "Home");
            }

            //INSERT CALL TO CYNTHIA VALIDATION******
            SetSessionMessages("Error", "");
            SetSessionMessages("Success", "");

            WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrderId).First();
            isSuccesfulAssignResource(workOrder, resourceId, startTime);


            return RedirectToAction("Index", "Home");
            //  return View("Index");
        }
        /// <summary>
        /// assigns a resource in the database
        /// returns true if successful
        /// </summary>
        /// <param name="workOrder"></param>
        /// <param name="resourceId"></param>
        /// <param name="startTime"></param>
        /// <returns></returns>
        public bool isSuccesfulAssignResource(WorkOrder workOrder, int resourceId, DateTime startTime)
        {
            int updateId = dbContext.status.Where(x => x.name == "BAPP").First().Id;
            Job job = dbContext.job.Where(x => x.work_order_id == workOrder.Id).First();
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
                return true;
            }
            catch (Exception e)
            {
                SetSessionMessages("Error", e.Message);
                return false;

            }
        }
        /// <summary>
        /// Populates session variables with a string
        /// </summary>
        /// <param name="name"></param>
        /// <param name="message"></param>
        public void SetSessionMessages(string name, string message)
        {
            if (message == "")
            {
                message = null;
            }
            Session[name] = message;
        }

        /// <summary>
        /// grabs information for isSuccessfulAssignTechnician
        /// </summary>
        /// <param name="workOrderId"></param>
        /// <param name="technicianId"></param>
        /// <param name="startTime"></param>
        /// <returns></returns>
        public ActionResult AssignTechnician(int workOrderId, int technicianId, DateTime startTime)
        {
            SetSessionMessages("Success", "");
            SetSessionMessages("Error", "");
            if (startTime==null)
            {
                SetSessionMessages("Error", "Set a start time");
                return RedirectToAction("Index", "Home");
            }
            bool validateTechnician = ValidateTechnician(workOrderId, technicianId, startTime);
            if (!validateTechnician)
            {
                Session["Error"] = "Technician already booked for this time, please try again";
                return RedirectToAction("Index", "Home");
            }

            WorkOrder workOrder = dbContext.WorkOrder.Where(x => x.Id == workOrderId).First();
            var notCompletedStatus = new List<String> { "completed", "cancelled", "deleted" };
            IQueryable<Status> notCompletedStatusIds = dbContext.status.Where(x => notCompletedStatus.Contains(x.description));
            foreach (Status notCompleteId in notCompletedStatusIds)
            {
                if (notCompleteId.Id == workOrder.status_id)
                {
                    SetSessionMessages("Error", "This work order is already cancelled, deleted or completed");
                    return RedirectToAction("index", "Home");
                }
            }

            if (isSuccessfulAssignTechnician(workOrder, technicianId, startTime) == true)
            {
                SetSessionMessages("Success", "Technician Added");
            }

            return RedirectToAction("index", "Home");
        }

        /// <summary>
        /// Assigns technician to a work order
        /// returns true if successful
        /// </summary>
        /// <param name="workOrder"></param>
        /// <param name="technicianId"></param>
        /// <param name="startTime"></param>
        /// <returns></returns>
        public bool isSuccessfulAssignTechnician(WorkOrder workOrder, int technicianId, DateTime startTime)
        {
            
            Job job = dbContext.job.Where(x => x.work_order_id == workOrder.Id).First();
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
                    return true;
                }
                catch (Exception e)
                {

                    SetSessionMessages("Error", "Server error: " + e.Message);
                    return false;
                }

            }
            else
            {
                try
                {
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
                    return true;
                }
                catch (Exception e)
                {

                    SetSessionMessages("Error", "Server error: " + e.Message);
                    return false;
                }
                //check if crews exist for this job

            }
        }
        /// <summary>
        /// Grabs all variables needed for isSuccessfulBook from database
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult Book()
        {
            //
            // validateWorkOrder(DateTime.Now, maxDay, 1, 1, 7, 34, "111 test ave", "n2n 1n1", 30);
            //string address, string postalCode, int estimatedTime
            SetSessionMessages("Success", "");
            SetSessionMessages("Error", "");
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
                    if (isSuccessfulBook(job.Id, workOrder, jobs))
                    {
                        SetSessionMessages("Success", "Work order Dispatched");
                        SetSessionMessages("WorkOrder", "");
                        SetSessionMessages("WOHeader", "");
                    }

                }
            }


            return RedirectToAction("Index", "Home");
        }
        
        /// <summary>
        /// Changes the statuses of the job crew, job and work order to dispatched
        /// returns true if successful
        /// </summary>
        /// <param name="jobId"></param>
        /// <param name="workOrder"></param>
        /// <param name="jobs"></param>
        /// <returns></returns>
        public bool isSuccessfulBook(int jobId, WorkOrder workOrder, IEnumerable<Job> jobs)
        {
            try
            {
                int updateStatus = dbContext.status.Where(x => x.name == "DIS").FirstOrDefault().Id;

                var crews = dbContext.jobCrew.Where(x => x.jobId == jobId).ToList();
                crews.ForEach(x => x.status_id = updateStatus);

                var jobList = jobs.ToList();
                jobList.ForEach(x => x.status_id = updateStatus);
                workOrder.status_id = updateStatus;
                dbContext.Entry(workOrder).State = System.Data.Entity.EntityState.Modified;
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception e)
            {

                SetSessionMessages("Error", "Error booking: " + e.Message);
                return false;
            }

        }

        /// <summary>
        /// Validates if a technician is already booked for the requested time
        /// </summary>
        /// <param name="workOrderId"></param>
        /// <param name="technicianId"></param>
        /// <param name="requestedStartTime"></param>
        /// <returns></returns>
        public bool ValidateTechnician(int workOrderId, int technicianId, DateTime requestedStartTime)
        {
            bool validate = false;

            var techniciansToValidate = dbContext.job
                .Join(dbContext.jobCrew, j => j.Id, jc => jc.jobId,
                (j, jc) => new { Job = j, JobCrew = jc })
                .Join(dbContext.crew_technician, jjc => jjc.JobCrew.crewId, ct => ct.crewid,
                (jjc, ct) => new { JobJobCrew = jjc, CrewTechnician = ct })
                .Select(s => new
                {
                    technicianId = s.CrewTechnician.technicianid,
                    jobId = s.JobJobCrew.Job.Id,
                    jobStartTime = s.JobJobCrew.JobCrew.start_time,
                    jobEndTime = s.JobJobCrew.JobCrew.end_time,
                    estimatedJobTimeMinutes = s.JobJobCrew.Job.estimated_time_minutes
                }).ToList();

            var technicianToValidate = techniciansToValidate
                .Where(st => st.technicianId == technicianId
                    && ((st.jobStartTime <= requestedStartTime
                    && st.jobEndTime >= requestedStartTime.AddMinutes(st.estimatedJobTimeMinutes))
                    || (st.jobStartTime <= requestedStartTime
                    && st.jobEndTime >= requestedStartTime
                    && st.jobEndTime <= requestedStartTime.AddMinutes(st.estimatedJobTimeMinutes))
                    || (st.jobStartTime >= requestedStartTime
                    && st.jobEndTime >= requestedStartTime.AddMinutes(st.estimatedJobTimeMinutes))
                    || (st.jobStartTime >= requestedStartTime
                    && st.jobEndTime <= requestedStartTime.AddMinutes(st.estimatedJobTimeMinutes))))
                .FirstOrDefault();

            if (technicianToValidate == null)
            {
                validate = true;
            }

            return validate;
        }

        /// <summary>
        /// Validates if a resource is already booked for the requested time
        /// </summary>
        /// <param name="workOrderId"></param>
        /// <param name="resourceId"></param>
        /// <param name="requestedStartTime"></param>
        /// <returns></returns>
        public bool ValidateResource(int workOrderId, int resourceId, DateTime requestedStartTime)
        {
            bool validate = false;

            var resourcesToValidate = dbContext.job
                .Join(dbContext.jobCrew, j => j.Id, jc => jc.jobId,
                (j, jc) => new { Job = j, JobCrew = jc })
                .Join(dbContext.crew_resources, jjc => jjc.JobCrew.crewId, cr => cr.crewID,
                (jjc, cr) => new { JobJobCrew = jjc, CrewResource = cr })
                .Select(s => new
                {
                    resourceId = s.CrewResource.resourcesid,
                    jobId = s.JobJobCrew.Job.Id,
                    jobStartTime = s.JobJobCrew.JobCrew.start_time,
                    jobEndTime = s.JobJobCrew.JobCrew.end_time,
                    estimatedJobTimeMinutes = s.JobJobCrew.Job.estimated_time_minutes
                }).ToList();

            var resourceToValidate = resourcesToValidate
                .Where(rtv => rtv.resourceId == resourceId
                    && ((rtv.jobStartTime <= requestedStartTime
                    && rtv.jobEndTime >= requestedStartTime.AddMinutes(rtv.estimatedJobTimeMinutes))
                    || (rtv.jobStartTime <= requestedStartTime
                    && rtv.jobEndTime >= requestedStartTime
                    && rtv.jobEndTime <= requestedStartTime.AddMinutes(rtv.estimatedJobTimeMinutes))
                    || (rtv.jobStartTime >= requestedStartTime
                    && rtv.jobEndTime >= requestedStartTime.AddMinutes(rtv.estimatedJobTimeMinutes))
                    || (rtv.jobStartTime >= requestedStartTime
                    && rtv.jobEndTime <= requestedStartTime.AddMinutes(rtv.estimatedJobTimeMinutes))))
                .FirstOrDefault();

            if (resourceToValidate.jobId != 0)
            {
                validate = true;
            }

            return validate;
        }

    }
}