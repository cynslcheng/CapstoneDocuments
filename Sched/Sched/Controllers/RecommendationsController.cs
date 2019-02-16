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
        *  **Ideally update to use stored procedures
        */
        [ChildActionOnly]
        public ActionResult _ReccomendationsPartial(WOHeader wOHeader)
        {
            if (wOHeader == null)
            {
                return View("_ReccomendationsPartial");
            }
            
            // (a) Find work order assocaited to work order id in WO header
            WorkOrder workOrder = dbContext.WorkOrder.FirstOrDefault(wo => wo.Id == wOHeader.word_order_id);
            // (a) Find job associated to work order
            Job job = new Job();
            job = dbContext.job.FirstOrDefault(x => x.work_order_id == workOrder.Id);
            List<JobTypes> jobTypes = dbContext.jobTypes.ToList();
            // (a)Filter technicians based on dispatch area
            List<Technician> technicians = dbContext.technician.Where(t => t.work_area_Id == workOrder.work_area_id).ToList();
            // (a) Find technicians that meet job requirements
            List<Technician> eligibleTechnicians = GetEligibleTechnicians(job, jobTypes, technicians);

            // (b) Find available eligible technicians from eligible technicians
            List<Technician> availableEligibleTechnicians = GetAvailableTechnicians(eligibleTechnicians);

            // (c) Filter resources based on dispatch area
            List<Resources> resources = dbContext.resources.Where(r => r.work_area_id == workOrder.work_area_id).ToList();
            // (c) Find required resources for job
            List<Resources> requiredResources = GetRequiredResources(job, jobTypes, resources);
            // (c) Find available required Resources
            List<Resources> availableRequiredResources = GetAvailableResources(requiredResources);

            // (d) Get proximity of preceding job site (iter3)
            // (e) Get proximity of project work (iter3)
            // (g) Apply gammification incentives (iter3)

            //Create recommendations model
            var recommendationsModel = CreateReccomendationsModel(workOrder, technicians, eligibleTechnicians, availableEligibleTechnicians,
                requiredResources, availableRequiredResources);

            //Send Recommendations to view
            Session["RecommendNav"] = "Recommended";
            return PartialView(recommendationsModel);
        }

        private List<Technician> GetEligibleTechnicians(Job job, List<JobTypes> jobTypes, List<Technician> technicians)
        {
            //Get list of available technicians
            //Find technician types associated to job
            List<JobTypesTechnicianType> jobTypesTechnicianTypes = dbContext.job_types_technician_type.ToList();
            jobTypesTechnicianTypes = jobTypes
                .Join(jobTypesTechnicianTypes, jt => jt.Id, jttt => jttt.job_types_id,
                (jt, jttt) => new { jobTypes = jt, JobTypesTechnicianType = jttt })
                .Select(s => new JobTypesTechnicianType
                {
                    job_types_id= s.JobTypesTechnicianType.job_types_id,
                    technician_type_id = s.JobTypesTechnicianType.technician_type_id
                })
                .Where(jt => jt.job_types_id == job.job_type_id).ToList();
            //Find skills associated to technician type
            List<TechnicianTypeSkill> technicianTypeSkills = dbContext.technicianTypeSkill.ToList();
            List<Skill> skills = dbContext.skill.ToList();
            List<Skill> requiredSkills = new List<Skill>();
            foreach (var technicianType in jobTypesTechnicianTypes)
            {
                foreach (var skill in technicianTypeSkills)
                {
                    if (skill.technician_typeid == technicianType.technician_type_id)
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
            //Find technicians that have the required skills to complete job
            List<Technician> eligibleTechnicians = new List<Technician>();
            foreach (var technicianType in jobTypesTechnicianTypes)
            {
                foreach (Technician technician in technicians)
                {
                    if (technician.technician_type == technicianType.technician_type_id
                        && !eligibleTechnicians.Contains(technician))
                    {
                        eligibleTechnicians.Add(technician);
                    }
                }
            }
            return eligibleTechnicians;
        }

        private List<Technician> GetAvailableTechnicians(List<Technician> eligibleTechnicians)
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
                    if (technician.Id == crewTechnician.technicianid && !eligibleTechniciansInCrew.Contains(technician))
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
                //Code to check timeframes here, unsure how to go about
            }
            return availableTechnicians;
        }

        private List<Resources> GetRequiredResources(Job job, 
            List<JobTypes> jobTypes, 
            List<Resources> resources)
        {
            //Find resource types associated to job
            List<JobTypesResourceType> jobTypesResourceTypes = dbContext.job_types_resource_type.ToList();
            jobTypesResourceTypes = jobTypes
                .Join(jobTypesResourceTypes, jt => jt.Id, jtrt => jtrt.job_types_id,
                (jt, jtrt) => new { jobTypes = jt, JobTypeResourceType = jtrt })
                .Select(s => new JobTypesResourceType
                {
                    job_types_id = s.JobTypeResourceType.job_types_id,
                    resource_type_id = s.JobTypeResourceType.resource_type_id
                }).ToList();
            jobTypesResourceTypes = jobTypesResourceTypes
                .Where(jt => jt.job_types_id == job.job_type_id).ToList();
            //Find resources that are associated to the resources types required for job
            List<Resources> requiredResources = new List<Resources>();
            foreach (var resourceType in jobTypesResourceTypes)
            {
                foreach (Resources resource in resources)
                {
                    if (resource.resource_type == resourceType.resource_type_id
                        && !requiredResources.Contains(resource))
                    {
                        requiredResources.Add(resource);
                    }
                }
            }
            return requiredResources;
        }

        private List<Resources> GetAvailableResources(List<Resources> requiredResources)
        {
            List<Resources> availableEligibleResources = new List<Resources>();
            List<Resources> eligibleResourcesInCrew = new List<Resources>();
            List<CrewResource> crewResources = dbContext.crew_resources.ToList();
            //Check if eligible resources have work/availability during desired timeframe, if no work add to available
            foreach (var resource in requiredResources)
            {
                foreach (var crewResource in crewResources)
                {
                    if (resource.Id == crewResource.resourcesid && 
                        !eligibleResourcesInCrew.Contains(resource))
                    {
                        eligibleResourcesInCrew.Add(resource);
                    }
                }
                if (!eligibleResourcesInCrew.Contains(resource))
                {
                    availableEligibleResources.Add(resource);
                }
            }
            //If technician working, check schedule between desired timeframe if available for workOrder estimated time
            //add if times available
            List<JobCrew> jobCrews = dbContext.jobCrew.ToList();
            foreach (var crewResource in eligibleResourcesInCrew)
            {
                //Code to check timeframes here, unsure how to go about
            }

            return availableEligibleResources;
        }

        private Recommendations CreateReccomendationsModel(WorkOrder wordOrder,
            List<Technician> technicians, 
            List<Technician> eligibleTechnicians, 
            List<Technician> availableEligibleTechnicians, 
            List<Resources> requiredResources,
            List<Resources> availableRequiredResources)
        {
            //Create all technicians list
            IQueryable<TechniciansList> techniciansList = CreateAllTechniciansList(technicians, eligibleTechnicians, availableEligibleTechnicians);
            //Create all resources list
            IQueryable<ResourcesList> resourcesList = CreateAllRequiredResources(requiredResources, availableRequiredResources);
            //Create reccomended technicians list
            IQueryable<TechniciansList> recommendedTechnicians = techniciansList
                .Where(tl => tl.reccomendationLevel == 3);
            //Create reccomended resources list
            IQueryable<ResourcesList> reccomendedResources = resourcesList
                .Where(rl => rl.reccomendationLevel == 3);
            var recommendationsModel = new Recommendations {
                reccomendedTechnicians = recommendedTechnicians,
                reccomendedResources = reccomendedResources,
                allTechnicians = techniciansList,
                allResources = resourcesList,
                workOrder = wordOrder
                };

            return recommendationsModel;
        }
        
        private IQueryable<TechniciansList> CreateAllTechniciansList(List<Technician> technicians, 
            List<Technician> eligibleTechnicians, 
            List<Technician> availableEligibleTechnicians)
        {
            List<TechniciansList> techniciansList = new List<TechniciansList>();

            //Set all to not reccomended (1)
            foreach(Technician technician in technicians)
            {
                TechniciansList technicianToAdd = new TechniciansList
                {
                    technician = technician,
                    reccomendationLevel = 1
                };
                techniciansList.Add(technicianToAdd);
            }

            //Update eligible technicians (2)
            foreach(Technician eligibleTechnician in eligibleTechnicians)
            {
                Technician technicianToUpdate = techniciansList
                    .FirstOrDefault(t => t.technician.Id == eligibleTechnician.Id).technician;
                if (technicianToUpdate != null)
                {
                    techniciansList.Find(t => t.technician == technicianToUpdate).reccomendationLevel = 2;
                }
            }

            //Update available eligible technicians (3)
            foreach (Technician availableEligibleTechnician in availableEligibleTechnicians)
            {
                Technician technicianToUpdate = techniciansList
                    .FirstOrDefault(t => t.technician.Id == availableEligibleTechnician.Id).technician;
                if (technicianToUpdate != null)
                {
                    techniciansList.Find(t => t.technician == technicianToUpdate).reccomendationLevel = 3;
                }
            }

            IQueryable<TechniciansList> queryableTechniciansList = techniciansList.AsQueryable();
            return queryableTechniciansList;
        }


        private IQueryable<ResourcesList> CreateAllRequiredResources(List<Resources> requiredResources,
            List<Resources> availableRequiredResources)
        {
            List<ResourcesList> resourcesList = new List<ResourcesList>();
            //Set all to eligible (2)
            foreach (Resources resource in requiredResources)
            {
                ResourceTypes resourcesType = dbContext.resourcesTypes.FirstOrDefault(rt => rt.Id == resource.resource_type);
                ResourcesList resourceToAdd = new ResourcesList
                {
                    resources = resource,
                    reccomendationLevel = 2,
                    resourceName = resourcesType.name
                };
                resourcesList.Add(resourceToAdd);
            }

            //Update available eligible resources (3)
            foreach (Resources resource in availableRequiredResources)
            {
                Resources resourceToUpdate = resourcesList.FirstOrDefault(rl => rl.resources.Id == resource.Id).resources;
                if (resourceToUpdate != null)
                {
                    resourcesList.Find(rl => rl.resources == resourceToUpdate).reccomendationLevel = 3;
                }
            }
            IQueryable<ResourcesList> queryableResourcesList = resourcesList.AsQueryable();
            return queryableResourcesList;
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
