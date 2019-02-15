using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sched.Models
{
    [Table("job")]
    public class Job
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int status_id { get; set; }
        public int job_type_id { get; set; }
        public int estimated_time_minutes { get; set; }
        public DateTime created_At { get; set; }
        [Timestamp]
        public byte[] modified_At { get; set; }

        public int work_order_id { get; set; }

    }
}