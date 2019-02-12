using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sched.Models
{
    public class WorkArea
    {
        [Key]
        private int id { get; }
        private string province { get; }
        private string country { get; }
        private string region { get; }
        private string description { get; }
    }
}