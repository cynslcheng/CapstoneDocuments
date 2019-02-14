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
        private string province { get; }
        private string country { get; }
        private string region { get; }
        private string description { get; }
        public DateTime created_at { get; set; }
        public DateTime modified_at { get; set; }
    }
}