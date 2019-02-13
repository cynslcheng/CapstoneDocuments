using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Sched.Models
{
    public class Technician
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int technicianTypeId { get; }
        public string firstName { get; }
        public string lastName { get; }
        private string address { get; }
        private string postalCode { get; }
        private string city { get; }
        private string province { get; }
        public int workAreaId { get; }
        private string liscenceNumber { get; }
    }
}