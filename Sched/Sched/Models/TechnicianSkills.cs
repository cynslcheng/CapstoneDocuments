using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sched.Models
{
    public class TechnicianSkills
    {
        private int technicianId { get; }
        private int skillId { get; }
        private int skillRating { get; }
    }
}