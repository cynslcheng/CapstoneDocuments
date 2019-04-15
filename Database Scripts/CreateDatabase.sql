USE [master]
GO

/****** Object:  Database [SchedIteration2]    Script Date: 4/15/2019 3:44:42 PM ******/
CREATE DATABASE [SchedIteration2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchedIteration2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SchedIteration2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SchedIteration2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SchedIteration2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [SchedIteration2] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SchedIteration2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [SchedIteration2] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [SchedIteration2] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [SchedIteration2] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [SchedIteration2] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [SchedIteration2] SET ARITHABORT OFF 
GO

ALTER DATABASE [SchedIteration2] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [SchedIteration2] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [SchedIteration2] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [SchedIteration2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [SchedIteration2] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [SchedIteration2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [SchedIteration2] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [SchedIteration2] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [SchedIteration2] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [SchedIteration2] SET  DISABLE_BROKER 
GO

ALTER DATABASE [SchedIteration2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [SchedIteration2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [SchedIteration2] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [SchedIteration2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [SchedIteration2] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [SchedIteration2] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [SchedIteration2] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [SchedIteration2] SET RECOVERY FULL 
GO

ALTER DATABASE [SchedIteration2] SET  MULTI_USER 
GO

ALTER DATABASE [SchedIteration2] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [SchedIteration2] SET DB_CHAINING OFF 
GO

ALTER DATABASE [SchedIteration2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [SchedIteration2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [SchedIteration2] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [SchedIteration2] SET QUERY_STORE = OFF
GO

USE [SchedIteration2]
GO

ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [SchedIteration2] SET  READ_WRITE 
GO




USE [SchedIteration2]
GO
/****** Object:  Table [dbo].[job]    Script Date: 4/15/2019 3:28:28 PM ******/
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
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_types]    Script Date: 4/15/2019 3:28:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [timestamp] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_types_resource_type]    Script Date: 4/15/2019 3:28:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_types_resource_type](
	[job_types_id] [int] NOT NULL,
	[resource_type_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[job_types_id] ASC,
	[resource_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_types_technician_type]    Script Date: 4/15/2019 3:28:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_types_technician_type](
	[job_types_id] [int] NOT NULL,
	[technician_type_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[job_types_id] ASC,
	[technician_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_work_order_jobs_info]    Script Date: 4/15/2019 3:28:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  VIEW [dbo].[v_work_order_jobs_info]
AS 
(SELECT job.work_order_id, job_types.name as job, SUM(jtr.quantity) as resources, SUM(jttt.quantity) AS technicians FROM job 
	JOIN job_types ON job.job_type_id = job_types.id
	JOIN job_types_resource_type jtr ON job.job_type_id = jtr.job_types_id
	JOIN job_types_technician_type jttt ON job_type_id = jttt.job_types_id 
GROUP BY work_order_id, name);
GO
/****** Object:  View [dbo].[v_work_order_table_info]    Script Date: 4/15/2019 3:28:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[v_work_order_table_info]  AS  
(SELECT j.work_order_id, job_types.name as job, SUM(jtr.quantity) as resources, SUM(jttt.quantity) AS technicians
,  
resource_types = STUFF((SELECT N','+ cast(jtr.resource_type_id as nvarchar(max))
  FROM job as j2 
  JOIN job_types_resource_type jtr ON j.job_type_id = jtr.job_types_id  
  where j2.work_order_id= j.work_order_id
  order by resource_type_id
  FOR XML PATH(N''),TYPE).value(N'.',N'nvarchar(max)'),1,1,N''),
  technician_types = STUFF((SELECT N','+ cast(jttt.technician_type_id as nvarchar(max))
  FROM job as j2 
  JOIN job_types_technician_type jttt ON j.job_type_id = jttt.job_types_id 
  where j2.work_order_id= j.work_order_id
  order by technician_type_id
  FOR XML PATH(N''),TYPE).value(N'.',N'nvarchar(max)'),1,1,N'')
 FROM job as j
 LEFT JOIN job_types ON j.job_type_id = job_types.id   
 LEFT JOIN job_types_resource_type jtr ON j.job_type_id = jtr.job_types_id  
  LEFT JOIN job_types_technician_type jttt ON j.job_type_id = jttt.job_types_id 
  GROUP BY work_order_id, name, j.work_order_id, j.job_type_id);

GO
/****** Object:  Table [dbo].[work_order]    Script Date: 4/15/2019 3:28:28 PM ******/
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
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status]    Script Date: 4/15/2019 3:28:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_work_order_display]    Script Date: 4/15/2019 3:28:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_work_order_display] as
(
SELECT        wo.id, wo.minimum_start_time, wo.maximum_start_time, wo.priority, wo.work_area_id, wo.status_id, wo.address, wo.postal_code, wo.estimated_time_minutes, wo.created_at, wo.modified_at, s.name AS status, v.job, 
                         v.resources, v.resource_types, v.technicians, v.technician_types
FROM            work_order AS wo LEFT OUTER JOIN
                         status AS s ON wo.status_id = s.id LEFT OUTER JOIN
                             (SELECT        work_order_id, job, COALESCE (SUM(resources), 0) AS resources, COALESCE (SUM(technicians), 0) AS technicians,  resource_types= STUFF((SELECT N','+ cast(jtr.resource_type_id as nvarchar(max))
  FROM job as j2 
  JOIN job_types_resource_type jtr ON j2.job_type_id = jtr.job_types_id  
  where j2.work_order_id= bobSaget.work_order_id
  order by resource_type_id
  FOR XML PATH(N''),TYPE).value(N'.',N'nvarchar(max)'),1,1,N''),
														 technician_types= STUFF((SELECT N','+ cast(jttt.technician_type_id as nvarchar(max))
  FROM job as j2 
  JOIN job_types_technician_type jttt ON j2.job_type_id = jttt.job_types_id  
  where j2.work_order_id= bobSaget.work_order_id
  order by technician_type_id
  FOR XML PATH(N''),TYPE).value(N'.',N'nvarchar(max)'),1,1,N'')
                               FROM            (SELECT        job.work_order_id, job_types.name AS job, 0 AS resources, jttt.quantity AS technicians, NULL AS resource_types, jttt.technician_type_id AS technician_types
                                                         FROM            job INNER JOIN
                                                                                   job_types ON job.job_type_id = job_types.id INNER JOIN
                                                                                   job_types_technician_type AS jttt ON job.job_type_id = jttt.job_types_id
                                                         UNION
                                                         SELECT        job.work_order_id, job_types.name AS job, jtr.quantity AS resources, 0 AS technicians, jtr.resource_type_id AS resource_types, NULL AS technician_types
                                                         FROM            job INNER JOIN
                                                                                  job_types ON job.job_type_id = job_types.id INNER JOIN
                                                                                  job_types_resource_type AS jtr ON job.job_type_id = jtr.job_types_id) AS bobSaget
                               GROUP BY work_order_id, job) AS v ON wo.id = v.work_order_id)
GO
/****** Object:  Table [dbo].[cost_code]    Script Date: 4/15/2019 3:28:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cost_code](
	[Id] [int] NOT NULL,
	[cost_code_description] [varchar](50) NOT NULL,
	[cost_code_rate] [float] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[crew]    Script Date: 4/15/2019 3:28:28 PM ******/
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
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[crew_resources]    Script Date: 4/15/2019 3:28:28 PM ******/
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
/****** Object:  Table [dbo].[crew_technician]    Script Date: 4/15/2019 3:28:28 PM ******/
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
/****** Object:  Table [dbo].[dispatcher]    Script Date: 4/15/2019 3:28:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dispatcher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[last_work_area_id] [int] NULL,
	[original_dispatcher_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_crew]    Script Date: 4/15/2019 3:28:29 PM ******/
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
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[jobid] ASC,
	[crewid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[notes]    Script Date: 4/15/2019 3:28:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[work_order_id] [int] NOT NULL,
	[note] [text] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[postal_code]    Script Date: 4/15/2019 3:28:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[postal_code](
	[postal_code] [varchar](50) NOT NULL,
	[latitude] [float] NOT NULL,
	[longitude] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[postal_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resource_type]    Script Date: 4/15/2019 3:28:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resource_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resource_type_skill]    Script Date: 4/15/2019 3:28:29 PM ******/
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
/****** Object:  Table [dbo].[resources]    Script Date: 4/15/2019 3:28:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resources](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[resource_type] [int] NOT NULL,
	[work_area_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NULL,
	[cost_code_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[skill]    Script Date: 4/15/2019 3:28:29 PM ******/
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
/****** Object:  Table [dbo].[technician]    Script Date: 4/15/2019 3:28:29 PM ******/
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
	[modified_at] [datetime] NULL,
	[cost_code_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technician_kpi]    Script Date: 4/15/2019 3:28:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[technician_kpi](
	[tech_id] [int] NOT NULL,
	[kpi] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tech_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technician_skills]    Script Date: 4/15/2019 3:28:29 PM ******/
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
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[technician_id] ASC,
	[skills_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technician_type]    Script Date: 4/15/2019 3:28:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[technician_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technician_type_skill]    Script Date: 4/15/2019 3:28:29 PM ******/
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
/****** Object:  Table [dbo].[work_area]    Script Date: 4/15/2019 3:28:30 PM ******/
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
	[modified_at] [datetime] NULL,
 CONSTRAINT [pk_work_area_id] PRIMARY KEY CLUSTERED 
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
ALTER TABLE [dbo].[dispatcher]  WITH CHECK ADD  CONSTRAINT [FK_Dispatcher_ToWorkArea] FOREIGN KEY([last_work_area_id])
REFERENCES [dbo].[work_area] ([id])
GO
ALTER TABLE [dbo].[dispatcher] CHECK CONSTRAINT [FK_Dispatcher_ToWorkArea]
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
ALTER TABLE [dbo].[notes]  WITH CHECK ADD  CONSTRAINT [FKnotes154679] FOREIGN KEY([work_order_id])
REFERENCES [dbo].[work_order] ([id])
GO
ALTER TABLE [dbo].[notes] CHECK CONSTRAINT [FKnotes154679]
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
ALTER TABLE [dbo].[resources]  WITH CHECK ADD  CONSTRAINT [FK_resources_To_cost_code] FOREIGN KEY([cost_code_id])
REFERENCES [dbo].[cost_code] ([Id])
GO
ALTER TABLE [dbo].[resources] CHECK CONSTRAINT [FK_resources_To_cost_code]
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
ALTER TABLE [dbo].[technician]  WITH CHECK ADD  CONSTRAINT [FK_technician_To_Cost_Code] FOREIGN KEY([cost_code_id])
REFERENCES [dbo].[cost_code] ([Id])
GO
ALTER TABLE [dbo].[technician] CHECK CONSTRAINT [FK_technician_To_Cost_Code]
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
ALTER TABLE [dbo].[technician_kpi]  WITH CHECK ADD  CONSTRAINT [FK_tech_kpi_ToTechnician] FOREIGN KEY([tech_id])
REFERENCES [dbo].[technician] ([id])
GO
ALTER TABLE [dbo].[technician_kpi] CHECK CONSTRAINT [FK_tech_kpi_ToTechnician]
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
