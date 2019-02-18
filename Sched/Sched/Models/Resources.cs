using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sched.Models
{
    public class Resources
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int resource_type { get; set; }
        public int work_area_id { get; set; }
        [Timestamp]

        public byte[] modified_at { get; set; }

    }
}