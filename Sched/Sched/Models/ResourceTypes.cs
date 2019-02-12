using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sched.Models
{
    public class ResourceTypes
    {
        [Key]
        private int id { get; }
        private string name { get; }
        private string description { get; }
    }
}