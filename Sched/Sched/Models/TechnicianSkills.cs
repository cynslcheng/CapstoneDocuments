using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Sched.Models
{
    public class TechnicianSkills
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int technicianId { get; set; }
        public int skillId { get; set; }
        public int skillRating { get; set; }
        public DateTime expires_at { get; set; }
        public Byte[] modified_at { get; set; }

    }
}