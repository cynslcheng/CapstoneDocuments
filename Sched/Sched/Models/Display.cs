using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sched.Models
{

    public class Display
    {
        public IEnumerable<WorkOrder> workOrder
        {
            get; set;

        }
        public IEnumerable<Job> job
        {
            get; set;
        }
        public IEnumerable<JobCrew> jobCrew
        {
            get; set;
        }
        public IEnumerable<WorkArea> workArea
        {
            get; set;
        }
        public IEnumerable<JobTypes> jobTypes
        {
            get; set;
        }
        public IEnumerable<ResourceTypes> resourceTypes
        {
            get; set;
        }
        public IEnumerable<Skill> skills
        {
            get; set;
        }
        public IEnumerable<TechnicianTypes> technicianTypes
        {
            get; set;
        }
        public IEnumerable<TechnicianSkills> technicianSkills
        {
            get; set;
        }
        public IEnumerable<Technician> technicians
        {
            get; set;
        }

        public IEnumerable<Resources> resources {
            get; set;
        }


    }
}