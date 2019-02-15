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
        public string address { get; set; }
        public string postal_code { get; set; }
        public int estimated_time_minutes { get; set; }
        public DateTime created_at { get; set; }
        
        [Timestamp]

        public byte[] modified_at { get; set; }

    }

    public class WOHeader
    {
        public int customer_number { get; set; }
        public int job_type { get; set; }
        public int word_order_id { get; set; }
    }
}