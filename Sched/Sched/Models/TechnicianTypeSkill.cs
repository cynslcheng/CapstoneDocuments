using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Sched.Models
{
    public class TechnicianTypeSkill
    {
        [Key, Column(Order = 1)]
        public int technician_typeid { get; set; }
        [Key, Column(Order = 2)]
        public int skillid { get; set; }
    }
}