using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;


namespace Sched.Models
{
    public class WorkOrder
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public DateTime minimum_start_time { get; set; }
        public DateTime maximum_start_time { get; set; }
        public int priority { get; set; }
        public int status_id{get;set;}
        public int work_area_id { get; set; }
        
        public int estimated_time_minutes { get; set; }
        public DateTime created_at { get; set; }
        public Byte[] modified_at { get; set; }

    }
}