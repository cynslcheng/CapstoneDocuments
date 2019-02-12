using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sched.Models
{
    public class JobCrew
    {
        [Key]
        private int id { get; }
        private DateTime startTime { get; }
        private DateTime endTime { get; }
        private int statusId { get; }
    }
}