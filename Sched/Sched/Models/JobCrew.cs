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
        public DateTime start_time { get; set; }
        public DateTime end_time { get; set; }
        public int status_id { get; set; }
        public DateTime created_at { get; set; }
        public byte[] modified_at { get; set; }
    }
}