using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;


namespace Sched.Models
{
    public class Resources
    {
        [Key]
        private int id { get; }
        private int resourceTypeId { get; }

    }
}