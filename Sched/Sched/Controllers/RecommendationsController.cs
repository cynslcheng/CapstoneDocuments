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

        /// <summary>
        /// Calculates and displays technicians and resources in a partial view when a work order is selected
        /// 
        ///  In order of steps for recommendations:
        /// * a job requirements
        /// * b technician availability
        /// * c resource requirements
        /// * d geographic proximity of preceding job site
        /// * e geographic proximity of project work
        /// * f gamification incentives
        /// * eligible technician and resource rows should
        /// * be colour coded to indicate their proximity from their previous job site
        /// * (ex.the closest technician would have a dark green colour, the next-closest a lighter green etc...)
        /// </summary>
        /// <param name="wOHeader">contains the selected work order, job type, and customer id (currently not available) </param>
        /// <returns>Model containing technicians, resources, and reccomendations to be assigned to work order</returns>
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

        /// <summary>
        /// Checks for technicians who have the skills to complete the work order
        /// </summary>
        /// <param name="job">Contains job information</param>
        /// <param name="jobTypes">Contains job types information</param>
        /// <param name="technicians">List of all technicians working in the work order's dispatch area</param>
        /// <returns>List of technicians that meet the skills required to complete work order</returns>
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

        /// <summary>
        /// Checks eligible technicians for their availability
        /// *Currently only checks if they aren't working on the specified day,
        /// all eligible technicians are still able to be selected from all technicians
        /// </summary>
        /// <param name="eligibleTechnicians">List of all technicians who meet the skills required to complete work order</param>
        /// <returns>List of all technicians who are available during the work orders
        /// desired time range (currently only check if work is scheduled for that day)</returns>
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

        /// <summary>
        /// Checks what resources are required to complete the requested work order
        /// </summary>
        /// <param name="job">Contains job information required to complete work order</param>
        /// <param name="jobTypes">Contains job types informamtion required to complete work order</param>
        /// <param name="resources">List of all resources in a work area</param>
        /// <returns>List of resources required to complete work order</returns>
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

        /// <summary>
        /// Checks if eligible resources are available to be booked during desired time period
        /// *Currently only checks if the resource is already working on the specified day,
        /// all eligible resources are still able to be selected from all resources
        /// </summary>
        /// <param name="requiredResources">List of resources required to complete work order, filtered by dispatch area</param>
        /// <returns>List of available resources required to complete work order. Currently only
        /// checks on if a resource is scheduled for the same day</returns>
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

        /// <summary>
        /// Creates a model containing available technicians, available resources, and recommended
        /// resources and technicians
        /// </summary>
        /// <param name="wordOrder">work order that was selected</param>
        /// <param name="technicians">List of all technicians in a dispatch area</param>
        /// <param name="eligibleTechnicians">List of all technicians meeting skills required for work order</param>
        /// <param name="availableEligibleTechnicians">List of all available eligible technicians (currently recommended)</param>
        /// <param name="requiredResources">List of all resources in a dispatch area that are required for work order</param>
        /// <param name="availableRequiredResources">List of all available eligible resources (currently recommended)</param>
        /// <returns>model to be sent to view containing technicians and resources</returns>
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
        
        /// <summary>
        /// Adds a reccomendation level to technicians to help front end
        /// determine coloring (not yet implemented on front end)
        /// </summary>
        /// <param name="technicians">All technicians in a dispatch area</param>
        /// <param name="eligibleTechnicians">All technicians in a dispatch area that are eligible for the work order</param>
        /// <param name="availableEligibleTechnicians">Available technicians (currently reccomended)</param>
        /// <returns>List of all technicians with a recommendation level associated to each technician</returns>
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

        /// <summary>
        /// Adds a reccomendation level to resources to help front end
        /// determine coloring (not yet implemented on front end)
        /// </summary>
        /// <param name="requiredResources">All resources in dispatch area that required for the work order</param>
        /// <param name="availableRequiredResources">Available resources (currently reccomended)</param>
        /// <returns>List of all resources with a recommendation level associated to each resource</returns>
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

        /// <summary>
        /// C#'s built in clean up functionality
        /// </summary>
        /// <param name="disposing"></param>
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
