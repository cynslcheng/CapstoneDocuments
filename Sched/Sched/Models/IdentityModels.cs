using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Sched.Models
{
    public class SchedContext : DbContext
    {
        // You can add custom code to this file. Changes will not be overwritten.
        // 
        // If you want Entity Framework to drop and regenerate your database
        // automatically whenever you change your model schema, please use data migrations.
        // For more information refer to the documentation:
        // http://msdn.microsoft.com/en-us/data/jj591621.aspx

        public SchedContext() : base("name=SchedContext")
        {
        }

        public System.Data.Entity.DbSet<Sched.Models.WorkOrder> WorkOrder { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.WorkArea> workArea { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.TechnicianTypes> technicianTypes { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.TechnicianSkills> technicianSkills { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.Technician> technician { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.Skill> skill { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.ResourceTypes> resourcesTypes { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.Resources> resources { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.JobTypes> jobTypes { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.JobCrew> jobCrew { get; set; }
        public System.Data.Entity.DbSet<Sched.Models.Job> job { get; set; }


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {

            //Map entity to table
            Database.SetInitializer<SchedContext>(null);
            modelBuilder.Entity<Sched.Models.Job>().ToTable("job");
            modelBuilder.Entity<Sched.Models.JobCrew>().ToTable("job_crew");
            modelBuilder.Entity<Sched.Models.JobTypes>().ToTable("job_types");
            modelBuilder.Entity<Sched.Models.Resources>().ToTable("resouces");
            modelBuilder.Entity<Sched.Models.ResourceTypes>().ToTable("resource_type");
            modelBuilder.Entity<Sched.Models.Skill>().ToTable("skill");
            modelBuilder.Entity<Sched.Models.Technician>().ToTable("technician");
            modelBuilder.Entity<Sched.Models.TechnicianSkills>().ToTable("technicianSkills");
            modelBuilder.Entity<Sched.Models.TechnicianTypes>().ToTable("techNician_type");
            modelBuilder.Entity<Sched.Models.WorkArea>().ToTable("work_area");
            modelBuilder.Entity<Sched.Models.WorkOrder>().ToTable("work_order");
           

        }
    }
}