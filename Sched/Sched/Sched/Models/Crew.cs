using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Sched.Models
{
    public class Crew
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int work_area_id { get; set; }
        public DateTime start_Time { get; set; }
        public DateTime end_Time { get; set; }
        public DateTime created_at{ get; set; }
        public DateTime modified_at { get; set; }

    }
}