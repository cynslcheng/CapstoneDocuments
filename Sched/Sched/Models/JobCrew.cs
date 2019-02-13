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
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public DateTime startTime { get; }
        public DateTime endTime { get; }
        public int statusId { get; }
        public DateTime created_at { get; set; }
        public DateTime modified_at { get; set; }
    }
}