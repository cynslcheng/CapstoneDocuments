using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Sched.Models;

namespace Sched.Controllers
{
    public class RecommendationsController : Controller
    {
        private SchedContext dbContext = new SchedContext();

        // GET: Recommendations
        public async Task<ActionResult> Index(WorkOrder workOrder)
        {
            if (workOrder == null)
            {
                return View("Index");
            }

            //Find job associated to work order
            Job job = new Job();
            job = dbContext.job.Where(x => x.workOrderId == workOrder.Id).FirstOrDefault();
            List<JobTypes> jobTypes = dbContext.jobTypes.ToList();
            List<Technician> recommendedTechnicians = GetRecommendedTechnicians(workOrder, job, jobTypes);
            List<Resources> recommendedResources = GetRecommendedResources(workOrder, job, jobTypes);

            //send Recommendations to view

            return View("Index");
        }

        // GET: Recommendations/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Technician technician = await dbContext.technician.FindAsync(id);
            if (technician == null)
            {
                return HttpNotFound();
            }
            return View(technician);
        }

        // GET: Recommendations/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Recommendations/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id")] Technician technician)
        {
            if (ModelState.IsValid)
            {
                dbContext.technician.Add(technician);
                await dbContext.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(technician);
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
        
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                dbContext.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
