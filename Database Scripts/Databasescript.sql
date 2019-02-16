USE [master]
GO
/****** Object:  Database [Sched]    Script Date: 15-Feb-19 7:12:43 PM ******/
CREATE DATABASE [Sched]
 WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS
GO
ALTER DATABASE [Sched] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sched].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sched] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sched] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sched] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sched] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sched] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sched] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sched] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sched] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sched] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sched] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sched] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sched] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sched] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sched] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sched] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sched] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [Sched] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sched] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Sched] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sched] SET  MULTI_USER 
GO
ALTER DATABASE [Sched] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sched] SET ENCRYPTION ON
GO
ALTER DATABASE [Sched] SET QUERY_STORE = ON
GO
ALTER DATABASE [Sched] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [Sched]
GO
/****** Object:  Table [dbo].[crew]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[crew](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[work_area_id] [int] NOT NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[crew_resources]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[crew_resources](
	[resourcesid] [int] NOT NULL,
	[crewid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[resourcesid] ASC,
	[crewid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[crew_technician]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[crew_technician](
	[crewid] [int] NOT NULL,
	[technicianid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[crewid] ASC,
	[technicianid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_type_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[estimated_time_minutes] [int] NOT NULL,
	[work_order_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_crew]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_crew](
	[jobid] [int] NOT NULL,
	[crewid] [int] NOT NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NULL,
	[status_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[jobid] ASC,
	[crewid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_types]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_types_resource_type]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_types_resource_type](
	[job_types_id] [int] NOT NULL,
	[resource_type_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[job_types_id] ASC,
	[resource_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_types_technician_type]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_types_technician_type](
	[job_types_id] [int] NOT NULL,
	[technician_type_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[job_types_id] ASC,
	[technician_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resource_type]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resource_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resource_type_skill]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resource_type_skill](
	[resource_typeid] [int] NOT NULL,
	[skillid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[resource_typeid] ASC,
	[skillid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resources]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resources](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[resource_type] [int] NOT NULL,
	[work_area_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[skill]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technician]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[technician](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[technician_type] [int] NOT NULL,
	[first_name] [varchar](60) NULL,
	[last_name] [varchar](60) NULL,
	[address] [varchar](255) NULL,
	[postal_code] [varchar](8) NULL,
	[city] [varchar](100) NULL,
	[province] [varchar](60) NULL,
	[work_area_id] [int] NOT NULL,
	[license_number] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technician_skills]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[technician_skills](
	[technician_id] [int] NOT NULL,
	[skills_id] [int] NOT NULL,
	[skill_rating] [int] NULL,
	[expires_at] [datetime] NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[technician_id] ASC,
	[skills_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technician_type]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[technician_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technician_type_skill]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[technician_type_skill](
	[technician_typeid] [int] NOT NULL,
	[skillid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[technician_typeid] ASC,
	[skillid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[work_area]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[work_area](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[province] [varchar](75) NOT NULL,
	[country] [varchar](50) NOT NULL,
	[region] [varchar](75) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
 CONSTRAINT [pk_work_area_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[work_order]    Script Date: 15-Feb-19 7:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[work_order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[minimum_start_time] [datetime] NOT NULL,
	[maximum_start_time] [datetime] NOT NULL,
	[priority] [int] NOT NULL,
	[work_area_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[address] [varchar](255) NULL,
	[postal_code] [varchar](8) NULL,
	[estimated_time_minutes] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[crew]  WITH CHECK ADD  CONSTRAINT [FKcrew154869] FOREIGN KEY([work_area_id])
REFERENCES [dbo].[work_area] ([id])
GO
ALTER TABLE [dbo].[crew] CHECK CONSTRAINT [FKcrew154869]
GO
ALTER TABLE [dbo].[crew_resources]  WITH CHECK ADD  CONSTRAINT [FKcrew_resou488653] FOREIGN KEY([crewid])
REFERENCES [dbo].[crew] ([id])
GO
ALTER TABLE [dbo].[crew_resources] CHECK CONSTRAINT [FKcrew_resou488653]
GO
ALTER TABLE [dbo].[crew_resources]  WITH CHECK ADD  CONSTRAINT [FKcrew_resou791084] FOREIGN KEY([resourcesid])
REFERENCES [dbo].[resources] ([id])
GO
ALTER TABLE [dbo].[crew_resources] CHECK CONSTRAINT [FKcrew_resou791084]
GO
ALTER TABLE [dbo].[crew_technician]  WITH CHECK ADD  CONSTRAINT [FKcrew_techn363840] FOREIGN KEY([crewid])
REFERENCES [dbo].[crew] ([id])
GO
ALTER TABLE [dbo].[crew_technician] CHECK CONSTRAINT [FKcrew_techn363840]
GO
ALTER TABLE [dbo].[crew_technician]  WITH CHECK ADD  CONSTRAINT [FKcrew_techn708002] FOREIGN KEY([technicianid])
REFERENCES [dbo].[technician] ([id])
GO
ALTER TABLE [dbo].[crew_technician] CHECK CONSTRAINT [FKcrew_techn708002]
GO
ALTER TABLE [dbo].[job]  WITH CHECK ADD  CONSTRAINT [FKjob354358] FOREIGN KEY([job_type_id])
REFERENCES [dbo].[job_types] ([id])
GO
ALTER TABLE [dbo].[job] CHECK CONSTRAINT [FKjob354358]
GO
ALTER TABLE [dbo].[job]  WITH CHECK ADD  CONSTRAINT [FKjob396678] FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[job] CHECK CONSTRAINT [FKjob396678]
GO
ALTER TABLE [dbo].[job]  WITH CHECK ADD  CONSTRAINT [FKjob58212] FOREIGN KEY([work_order_id])
REFERENCES [dbo].[work_order] ([id])
GO
ALTER TABLE [dbo].[job] CHECK CONSTRAINT [FKjob58212]
GO
ALTER TABLE [dbo].[job_crew]  WITH CHECK ADD  CONSTRAINT [FKjob_crew146519] FOREIGN KEY([jobid])
REFERENCES [dbo].[job] ([id])
GO
ALTER TABLE [dbo].[job_crew] CHECK CONSTRAINT [FKjob_crew146519]
GO
ALTER TABLE [dbo].[job_crew]  WITH CHECK ADD  CONSTRAINT [FKjob_crew209421] FOREIGN KEY([crewid])
REFERENCES [dbo].[crew] ([id])
GO
ALTER TABLE [dbo].[job_crew] CHECK CONSTRAINT [FKjob_crew209421]
GO
ALTER TABLE [dbo].[job_crew]  WITH CHECK ADD  CONSTRAINT [FKjob_crew261667] FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[job_crew] CHECK CONSTRAINT [FKjob_crew261667]
GO
ALTER TABLE [dbo].[job_types_resource_type]  WITH CHECK ADD  CONSTRAINT [FKjob_types_167822] FOREIGN KEY([job_types_id])
REFERENCES [dbo].[job_types] ([id])
GO
ALTER TABLE [dbo].[job_types_resource_type] CHECK CONSTRAINT [FKjob_types_167822]
GO
ALTER TABLE [dbo].[job_types_resource_type]  WITH CHECK ADD  CONSTRAINT [FKjob_types_492886] FOREIGN KEY([resource_type_id])
REFERENCES [dbo].[resource_type] ([id])
GO
ALTER TABLE [dbo].[job_types_resource_type] CHECK CONSTRAINT [FKjob_types_492886]
GO
ALTER TABLE [dbo].[job_types_technician_type]  WITH CHECK ADD  CONSTRAINT [FKjob_types_882885] FOREIGN KEY([technician_type_id])
REFERENCES [dbo].[technician_type] ([id])
GO
ALTER TABLE [dbo].[job_types_technician_type] CHECK CONSTRAINT [FKjob_types_882885]
GO
ALTER TABLE [dbo].[job_types_technician_type]  WITH CHECK ADD  CONSTRAINT [FKjob_types_905511] FOREIGN KEY([job_types_id])
REFERENCES [dbo].[job_types] ([id])
GO
ALTER TABLE [dbo].[job_types_technician_type] CHECK CONSTRAINT [FKjob_types_905511]
GO
ALTER TABLE [dbo].[resource_type_skill]  WITH CHECK ADD  CONSTRAINT [FKresource_t546952] FOREIGN KEY([skillid])
REFERENCES [dbo].[skill] ([id])
GO
ALTER TABLE [dbo].[resource_type_skill] CHECK CONSTRAINT [FKresource_t546952]
GO
ALTER TABLE [dbo].[resource_type_skill]  WITH CHECK ADD  CONSTRAINT [FKresource_t763805] FOREIGN KEY([resource_typeid])
REFERENCES [dbo].[resource_type] ([id])
GO
ALTER TABLE [dbo].[resource_type_skill] CHECK CONSTRAINT [FKresource_t763805]
GO
ALTER TABLE [dbo].[resources]  WITH CHECK ADD  CONSTRAINT [FKresources681939] FOREIGN KEY([work_area_id])
REFERENCES [dbo].[work_area] ([id])
GO
ALTER TABLE [dbo].[resources] CHECK CONSTRAINT [FKresources681939]
GO
ALTER TABLE [dbo].[resources]  WITH CHECK ADD  CONSTRAINT [FKresources821121] FOREIGN KEY([resource_type])
REFERENCES [dbo].[resource_type] ([id])
GO
ALTER TABLE [dbo].[resources] CHECK CONSTRAINT [FKresources821121]
GO
ALTER TABLE [dbo].[technician]  WITH CHECK ADD  CONSTRAINT [FKtechnician13398] FOREIGN KEY([technician_type])
REFERENCES [dbo].[technician_type] ([id])
GO
ALTER TABLE [dbo].[technician] CHECK CONSTRAINT [FKtechnician13398]
GO
ALTER TABLE [dbo].[technician]  WITH CHECK ADD  CONSTRAINT [FKtechnician611772] FOREIGN KEY([work_area_id])
REFERENCES [dbo].[work_area] ([id])
GO
ALTER TABLE [dbo].[technician] CHECK CONSTRAINT [FKtechnician611772]
GO
ALTER TABLE [dbo].[technician_skills]  WITH CHECK ADD  CONSTRAINT [FKtechnician347430] FOREIGN KEY([skills_id])
REFERENCES [dbo].[skill] ([id])
GO
ALTER TABLE [dbo].[technician_skills] CHECK CONSTRAINT [FKtechnician347430]
GO
ALTER TABLE [dbo].[technician_skills]  WITH CHECK ADD  CONSTRAINT [FKtechnician509322] FOREIGN KEY([technician_id])
REFERENCES [dbo].[technician] ([id])
GO
ALTER TABLE [dbo].[technician_skills] CHECK CONSTRAINT [FKtechnician509322]
GO
ALTER TABLE [dbo].[technician_type_skill]  WITH CHECK ADD  CONSTRAINT [FKtechnician430338] FOREIGN KEY([technician_typeid])
REFERENCES [dbo].[technician_type] ([id])
GO
ALTER TABLE [dbo].[technician_type_skill] CHECK CONSTRAINT [FKtechnician430338]
GO
ALTER TABLE [dbo].[technician_type_skill]  WITH CHECK ADD  CONSTRAINT [FKtechnician816449] FOREIGN KEY([skillid])
REFERENCES [dbo].[skill] ([id])
GO
ALTER TABLE [dbo].[technician_type_skill] CHECK CONSTRAINT [FKtechnician816449]
GO
ALTER TABLE [dbo].[work_order]  WITH CHECK ADD  CONSTRAINT [FKwork_order341947] FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[work_order] CHECK CONSTRAINT [FKwork_order341947]
GO
ALTER TABLE [dbo].[work_order]  WITH CHECK ADD  CONSTRAINT [FKwork_order805279] FOREIGN KEY([work_area_id])
REFERENCES [dbo].[work_area] ([id])
GO
ALTER TABLE [dbo].[work_order] CHECK CONSTRAINT [FKwork_order805279]
GO
USE [master]
GO
ALTER DATABASE [Sched] SET  READ_WRITE 
GO
