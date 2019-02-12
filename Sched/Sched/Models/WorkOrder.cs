using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;


namespace Sched.Models
{
    public class WorkOrder
    {
        [Key]
        private int id { get; }
        private DateTime minStartTime { get; set; }
        private DateTime maxStartTime { get; set; }
        private int workAreaId { get; set; }
        private List<int> jobIds { get; set; }


    }
}