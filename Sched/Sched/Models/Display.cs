using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sched.Models
{
    public class Display
    {
        partial class WorkOrder
        {
            private int id { get; }
            private DateTime minStartTime { get; }
            private DateTime maxStartTime { get; }
            private int workAreaId { get; }
            private List<int> jobIds { get; }


        }
        partial class Job
        {
            private int id { get; }
            private int jobType { get; }
            private int workOrderId { get; }
        }
        partial class JobCrew
        {
            private int id { get; }
            private DateTime startTime { get; }
            private DateTime endTime { get; }
            private int statusId { get; }
        }
        partial class WorkArea
        {
            private int id { get; }
            private string province { get; }
            private string country { get; }
            private string region { get; }
            private string description { get; }
        }
        partial class JobTypes
        {
            private int id { get; }
            private string name { get; }
            private string description { get; }
        }
        partial class ResourceTypes
        {
            private int id { get; }
            private string name { get; }
            private string description { get; }
        }
        partial class Skill
        {
            private int id { get; }
            private string name { get; }
            private string description { get; }
        }
        partial class TechnicianTypes
        {
            private int id { get; }
            private string name { get; }
            private string description { get; }
        }
        partial class TechnicianSkills
        {
            private int technicianId { get; }
            private int skillId { get; }
            private int skillRating { get; }
        }
        partial class Technician
        {
            private int id { get; }
            private int technicianTypeId { get; }
            private string firstName { get; }
            private string lastName { get; }
            private string address { get; }
            private string postalCode { get; }
            private string city { get; }
            private string province { get; }
            private int workAreaId { get; }
            private string liscenceNumber { get; }
        }
        partial class Resources
        {
            private int id { get; }
            private int resourceTypeId{ get; } 

        }
    }
}