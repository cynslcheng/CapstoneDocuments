using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sched.Models
{
    public class JobTypesResourceType
    {
        [Key, Column(Order = 1)]
        public int jobTypeID { get; set; }
        [Key, Column(Order = 2)]
        public int resourceTypeId { get; set; }

    }
}