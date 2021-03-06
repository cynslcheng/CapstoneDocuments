﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sched.Models
{
    public class Recommendations
    {
        public IQueryable<TechniciansList> reccomendedTechnicians { get; set; }
        public IQueryable<ResourcesList> reccomendedResources { get; set; }
        public IQueryable<TechniciansList> allTechnicians { get; set; }
        public IQueryable<ResourcesList> allResources { get; set; }
        public WorkOrder workOrder { get; set; }
    }

    public class TechnicianAvailability
    {
        public DateTime startTime { get; set; }
        public DateTime endTime { get; set; }
        public int technicianId { get; set; }
        public DateTime nextStart { get; set; }
        public int freeTime { get; set; }
    }

    public class ResourceAvailability
    {
        public DateTime startTime { get; set; }
        public DateTime endTime { get; set; }
        public int resourcesId { get; set; }
        public DateTime nextStart { get; set; }
        public int freeTime { get; set; }
    }

    public class TechniciansList
    {
        public Technician technician { get; set; }
        public int reccomendationLevel { get; set; }
    }

    public class ResourcesList
    {
        public Resources resources { get; set; }
        public int reccomendationLevel { get; set; }
        public string resourceName { get; set; }
    }
}