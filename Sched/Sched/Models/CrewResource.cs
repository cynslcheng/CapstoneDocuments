using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sched.Models
{
    public class CrewResource
    {
        [Key, Column(Order = 1)]
        public int resourcesid { get; set; }
        [Key, Column(Order = 2)]
        public int crewID { get; set; }
    }
}