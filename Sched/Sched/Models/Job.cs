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
        public int jobType { get; }
        public int estimatedTimeMinuntes { get; }
        public int workOrderId { get; }
    }
}