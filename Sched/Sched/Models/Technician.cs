using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sched.Models
{
    public class Technician
    {
        [Key]
        private int id { get; }
        private int technicianTypeId { get; }
        private string firstName { get; }
        private string lastName { get; }
        private string address { get; }
        private string postalCode { get; }
        private string city { get; }
        private string province { get; }
        private int workAreaId { get; }
        private string liscenceNumber { get; }
    }
}