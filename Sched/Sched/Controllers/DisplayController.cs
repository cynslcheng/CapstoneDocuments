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
        
        public ActionResult SelectedWorkOrder (WorkOrder workOrder)
        {
            if (workOrder == null)
            {
                return View("Index");
            }

            //Thomases for display details required in the same method

            //Find job associated to work order
            Job job = new Job();
            job = dbContext.job.Where(x => x.workOrderId == workOrder.Id).FirstOrDefault();
            List<JobTypes> jobTypes = dbContext.jobTypes.ToList();
            List<Technician> recommendedTechnicians = GetRecommendedTechnicians(workOrder, job, jobTypes);
            List<Resources> recommendedResources = GetRecommendedResources(workOrder, job, jobTypes);
            
            //send Recommendations to view

            return View("Index");
        }

        private List<Resources> GetRecommendedResources(WorkOrder workOrder, Job job, List<JobTypes> jobTypes)
        {
            //Filter resources based on dispatch area
            List<Resources> resources = dbContext.resources.Where(r => r.workAreaId == workOrder.work_area_id).ToList();
            //Find resource types associated to job
            List<JobTypesResourceType> jobTypesResourceTypes = dbContext.job_types_resource_type.ToList();
            jobTypesResourceTypes = jobTypes
                .Join(jobTypesResourceTypes, jt => jt.Id, jtrt => jtrt.jobTypeID,
                (jt, jtrt) => new { jobTypes = jt, JobTypeResourceType = jtrt })
                .Select(s => new JobTypesResourceType
                {
                    jobTypeID = s.JobTypeResourceType.jobTypeID,
                    resourceTypeId = s.JobTypeResourceType.resourceTypeId
                })
                .Where(jt => jt.jobTypeID == job.jobType).ToList();
            //Find resources that are associated to the resources types required for job
            List<Resources> recommendedResources = new List<Resources>();
            foreach (var resourceType in jobTypesResourceTypes)
            {
                foreach (Resources resource in resources)
                {
                    if (resource.resourceTypeId == resourceType.resourceTypeId
                        && !recommendedResources.Contains(resource))
                    {
                        recommendedResources.Add(resource);
                    }
                }
            }
            //Filter resources for availability

            //Sort by cost ratio and distance from preceding job site (if any)
            return recommendedResources;
        }

        private List<Technician> GetRecommendedTechnicians(WorkOrder workOrder, Job job, List<JobTypes> jobTypes)
        {
            //Filter technicians based on dispatch area
            List<Technician> technicians = dbContext.technician.Where(t => t.workAreaId == workOrder.work_area_id).ToList();
            //Find technicians types associated to job
            List<JobTypesTechnicianType> jobTypesTechnicianTypes = dbContext.job_types_technician_type.ToList();
            jobTypesTechnicianTypes = jobTypes
                .Join(jobTypesTechnicianTypes, jt => jt.Id, jttt => jttt.jobTypeID,
                (jt, jttt) => new { jobTypes = jt, JobTypesTechnicianType = jttt })
                .Select(s => new JobTypesTechnicianType
                {
                    jobTypeID = s.JobTypesTechnicianType.jobTypeID,
                    technicianTypeID = s.JobTypesTechnicianType.technicianTypeID
                })
                .Where(jt => jt.jobTypeID == job.jobType).ToList();
            //Find technicians that are associated to the technician types required for job
            List<Technician> recommendedTechnicians = new List<Technician>();
            foreach (var technicianType in jobTypesTechnicianTypes)
            {
                foreach (Technician technician in technicians)
                {
                    if (technician.technicianTypeId == technicianType.technicianTypeID
                        && !recommendedTechnicians.Contains(technician))
                    {
                        recommendedTechnicians.Add(technician);
                    }
                }
            }
            //Filter technicians for availability and skills

            //Sort by cost ratio and distance from preceding job site (if any)
            return recommendedTechnicians;
        }
    }
}