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

            /*  In order of steps for recommendations:
            *   a job requirements
            *   b technician availability
            *   c resource requirements
            *   d geographic proximity of preceding job site
            *   e geographic proximity of project work
            *   f gamification incentives
            *  eligible technician and resource rows should 
            *  be colour coded to indicate their proximity from their previous job site 
            *  (ex. the closest technician would have a dark green colour, the next-closest a lighter green etc...)
            */
            // (a) Find job associated to work order
            Job job = new Job();
            job = dbContext.job.Where(x => x.workOrderId == workOrder.Id).FirstOrDefault();
            List<JobTypes> jobTypes = dbContext.jobTypes.ToList();
            // (a)Filter technicians based on dispatch area
            List<Technician> technicians = dbContext.technician.Where(t => t.workAreaId == workOrder.work_area_id).ToList();
            // (a) Find technicians that meet job requirements
            List<Technician> eligibleTechnicians = GetEligibleTechnicians(workOrder, job, jobTypes, technicians);

            // (b) Find available technicians from eligibleTechnicians
            List<Technician> availableTechnicians = GetAvailableTechnicians(job, jobTypes, eligibleTechnicians);

            // (c) Filter resources based on dispatch area
            List<Resources> resources = dbContext.resources.Where(r => r.workAreaId == workOrder.work_area_id).ToList();
            // (c) Find required resources
            List<Resources> recommendedResources = GetRecommendedResources(workOrder, job, jobTypes, resources);

            // (d) Get proximity of preceding job site
            // (e) Get proximity of project work
            // (g) Apply gammification incentives
            
            //Create recommendations model
            var recommendationsModel = CreateReccomendationsModel(technicians, eligibleTechnicians, availableTechnicians,
                resources);
            
            //Send Recommendations to view
            return View(recommendationsModel);
        }

        private List<Technician> GetEligibleTechnicians(WorkOrder workOrder, Job job, List<JobTypes> jobTypes, List<Technician> technicians)
        {
            //Get list of available technicians
            //Find technician types associated to job
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
            //Find skills associated to technician type
            List<TechnicianTypeSkill> technicianTypeSkills = dbContext.technicianTypeSkill.ToList();
            List<Skill> skills = dbContext.skill.ToList();
            List<Skill> requiredSkills = new List<Skill>();
            foreach (var technicianType in jobTypesTechnicianTypes)
            {
                foreach (var skill in technicianTypeSkills)
                {
                    if (skill.technician_Type_ID == technicianType.technicianTypeID)
                    {
                        skills.Where(s => s.Id == skill.skillid).ToList();
                        foreach (var requiredSkill in skills)
                        {
                            if (!requiredSkills.Contains(requiredSkill))
                            {
                                requiredSkills.Add(requiredSkill);
                            }
                        }
                    }
                }
            }
            //Find technicians have the required skills to complete job
            List<Technician> eligibleTechnicians = new List<Technician>();
            foreach (var technicianType in jobTypesTechnicianTypes)
            {
                foreach (Technician technician in technicians)
                {
                    if (technician.technicianTypeId == technicianType.technicianTypeID
                        && !eligibleTechnicians.Contains(technician))
                    {
                        eligibleTechnicians.Add(technician);
                    }
                }
            }
            return eligibleTechnicians;
        }

        private List<Technician> GetAvailableTechnicians(Job job, List<JobTypes> jobTypes, List<Technician> eligibleTechnicians)
        {
            //Filter eligible technicians for availability
            List<Technician> availableTechnicians = new List<Technician>();
            List<Technician> eligibleTechniciansInCrew = new List<Technician>();
            List<CrewTechnician> crewTechnicians = dbContext.crew_technician.ToList();
            //Check if eligible technicians have work/availability during desired timeframe, if no work add to available
            foreach (var technician in eligibleTechnicians)
            {
                foreach (var crewTechnician in crewTechnicians)
                {
                    if (technician.Id == crewTechnician.technicanid && !eligibleTechniciansInCrew.Contains(technician))
                    {
                        eligibleTechniciansInCrew.Add(technician);
                    }
                }
                if (!eligibleTechniciansInCrew.Contains(technician))
                {
                    availableTechnicians.Add(technician);
                }
            }
            //If technician working, check schedule between desired timeframe if available for workOrder estimated time
            //add if times available
            List<JobCrew> jobCrews = dbContext.jobCrew.ToList();
            foreach (var crewTechnician in eligibleTechniciansInCrew)
            {
                
            }
            return availableTechnicians;
        }

        private List<Resources> GetRecommendedResources(WorkOrder workOrder, Job job, List<JobTypes> jobTypes, List<Resources> resources)
        {
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

        private Recommendations CreateReccomendationsModel(List<Technician> technicians, 
            List<Technician> eligibleTechnicians, 
            List<Technician> availableTechnicians, 
            List<Resources> resources)
        {
            //Create all technicians list

            //Create all resources list

            //Create reccomended technicians list

            //Create reccomended resources list

            var recommendationsModel = new Recommendations {
                reccomendedTechnicians = ,
                reccomendedResources = ,
                allTechnicians = ,
                allResources =  
                };

            return recommendationsModel;
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
