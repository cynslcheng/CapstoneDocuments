using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Sched.Models
{
    public class TechnicianTypes
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        private string name { get; set; }
        private string description { get; set; }
        public DateTime created_at { get; set; }
        public DateTime modified_at { get; set; }
    }
}