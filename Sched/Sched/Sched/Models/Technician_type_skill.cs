using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Sched.Models
{
    public class Technician_type_skill
    {
        [Key, Column(Order = 1)]
        public int technician_Type_ID { get; set; }
        [Key, Column(Order = 2)]
        public int skillid { get; set; }
    }
}