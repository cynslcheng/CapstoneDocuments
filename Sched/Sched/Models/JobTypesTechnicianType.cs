using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sched.Models
{
    public class JobTypesTechnicianType
    {
        [Key, Column(Order = 1)]
        public int job_types_id { get; set; }
        [Key, Column(Order = 2)]
        public int technician_type_id { get; set; }
    }
}