using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Sched.Models
{
    public class WorkArea
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string province { get; set; }
        public string country { get; set; }
        public string region { get; set; }
        public string description { get; set; }
        public DateTime created_at { get; set; }
        public byte[] modified_at { get; set; }
    }
}