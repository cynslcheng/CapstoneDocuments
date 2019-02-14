using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Sched.Models
{
    public class JobCrew
    {
        [Key, Column(Order = 1)]
        public int jobId { get; set; }
        [Key, Column(Order = 2)]
        public int crewId { get; set; }
        public DateTime startTime { get; set; }
        public DateTime endTime { get; set; }
        public int statusId { get; set; }
        public DateTime created_at { get; set; }
        public DateTime modified_at { get; set; }
    }
}