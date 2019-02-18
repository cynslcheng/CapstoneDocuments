/* Fill Status Table */

SET IDENTITY_INSERT [dbo].[status] ON
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (1, N'WSCHED', N'waiting to schedule', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (2, N'SCHED', N'scheduled', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (3, N'BAPP', N'booked appointment', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (4, N'NFA', N'no fixed appointment', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (5, N'ACK', N'acknowledged', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (6, N'DIS', N'dispatched', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (7, N'Enroute', N'technician / resource on the way to jobsite', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (8, N'OnSite', N'technician/resource on site', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (9, N'Suspended', N'completed', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (10, N'Cancelled', N'cancelled', N'2019-02-12 20:36:10')
INSERT INTO [dbo].[status] ([id], [name], [description], [created_at]) VALUES (11, N'deleted', N'deleted', N'2019-02-12 20:36:10')
SET IDENTITY_INSERT [dbo].[status] OFF

/* Fill Work Area Table */

SET IDENTITY_INSERT [dbo].[work_area] ON
INSERT INTO [dbo].[work_area] ([id], [province], [country], [region], [description], [created_at]) VALUES (1, N'Ontario', N'Canada', N'Waterloo', NULL, N'2019-02-12 20:36:33')
INSERT INTO [dbo].[work_area] ([id], [province], [country], [region], [description], [created_at]) VALUES (2, N'Ontario', N'Canada', N'GTA', NULL, N'2019-02-12 20:36:33')
SET IDENTITY_INSERT [dbo].[work_area] OFF

/* Fill Skills Table */

SET IDENTITY_INSERT [dbo].[skill] ON
INSERT INTO [dbo].[skill] ([id], [name], [description]) VALUES (1, N'Meter checking license', N'can check meters')
INSERT INTO [dbo].[skill] ([id], [name], [description]) VALUES (2, N'Electrician License', N'can do electrical stuff')
INSERT INTO [dbo].[skill] ([id], [name], [description]) VALUES (3, N'Plumbers License', N'can do water stuff')
SET IDENTITY_INSERT [dbo].[skill] OFF

/* Fill Job Types Table */

SET IDENTITY_INSERT [dbo].[job_types] ON
INSERT INTO [dbo].[job_types] ([id], [name], [description], [created_at]) VALUES (1, N'Check Gas Meter', NULL, N'2019-02-12 20:33:20')
INSERT INTO [dbo].[job_types] ([id], [name], [description], [created_at]) VALUES (2, N'Check Water Meter', NULL, N'2019-02-12 20:33:20')
INSERT INTO [dbo].[job_types] ([id], [name], [description], [created_at]) VALUES (3, N'Pave Driveway', NULL, N'2019-02-12 20:33:20')
INSERT INTO [dbo].[job_types] ([id], [name], [description], [created_at]) VALUES (4, N'Fix Wires', NULL, N'2019-02-12 20:36:33')
INSERT INTO [dbo].[job_types] ([id], [name], [description], [created_at]) VALUES (5, N'Fix Electric Pole', NULL, N'2019-02-12 20:36:33')
SET IDENTITY_INSERT [dbo].[job_types] OFF

/* Fill Resources Type Table */

SET IDENTITY_INSERT [dbo].[resource_type] ON
INSERT INTO [dbo].[resource_type] ([id], [name], [description], [created_at]) VALUES (1, N'Cherrypicker', N'cherrypicker', N'2019-02-14 01:44:13')
INSERT INTO [dbo].[resource_type] ([id], [name], [description], [created_at]) VALUES (2, N'Meter Checker', N'meter checker', N'2019-02-14 01:45:34')
SET IDENTITY_INSERT [dbo].[resource_type] OFF

/* Fill Resources Table */

SET IDENTITY_INSERT [dbo].[resources] ON
INSERT INTO [dbo].[resources] ([id], [resource_type], [work_area_id], [created_at]) VALUES (1, 1, 1, N'2019-02-14 01:49:04')
INSERT INTO [dbo].[resources] ([id], [resource_type], [work_area_id], [created_at]) VALUES (2, 2, 1, N'2019-02-12 20:36:33')
INSERT INTO [dbo].[resources] ([id], [resource_type], [work_area_id], [created_at]) VALUES (3, 1, 2, N'2019-02-14 01:49:04')
INSERT INTO [dbo].[resources] ([id], [resource_type], [work_area_id], [created_at]) VALUES (4, 2, 2, N'2019-02-12 20:36:33')
SET IDENTITY_INSERT [dbo].[resources] OFF

/* Fill Job Types Resource Type Table */

INSERT INTO [dbo].[job_types_resource_type] ([job_types_id], [resource_type_id]) VALUES (1, 2)
INSERT INTO [dbo].[job_types_resource_type] ([job_types_id], [resource_type_id]) VALUES (2, 2)
INSERT INTO [dbo].[job_types_resource_type] ([job_types_id], [resource_type_id]) VALUES (4, 1)

/* Fill Resource Type Skill Table */

INSERT INTO [dbo].[resource_type_skill] ([resource_typeid], [skillid]) VALUES (2, 1)

/* Fill Technician Type Table */

SET IDENTITY_INSERT [dbo].[technician_type] ON
INSERT INTO [dbo].[technician_type] ([id], [name], [description], [created_at]) VALUES (1, N'Gasfitter', N'Gasfitter', N'2019-02-14 01:49:04')
INSERT INTO [dbo].[technician_type] ([id], [name], [description], [created_at]) VALUES (2, N'Electrician', N'Electrician', N'2019-02-14 01:49:04')
SET IDENTITY_INSERT [dbo].[technician_type] OFF

/* Fill Technician Table */

SET IDENTITY_INSERT [dbo].[technician] ON
INSERT INTO [dbo].[technician] ([id], [technician_type], [first_name], [last_name], [address], [postal_code], [city], [province], [work_area_id], [license_number], [created_at]) VALUES (1, 1, N'Nicholas', N'Lee', N'108 University Avenue East', N'N2J2W2', N'Waterloo', N'ON', 7, N'11111111', N'2019-02-14 01:49:04')
INSERT INTO [dbo].[technician] ([id], [technician_type], [first_name], [last_name], [address], [postal_code], [city], [province], [work_area_id], [license_number], [created_at]) VALUES (2, 2, N'Cynthia', N'Cheng', N'460 Speedvale Ave West', N'N1H0A8', N'Guelph', N'ON', 7, N'22222222', N'2019-02-14 01:49:04')
INSERT INTO [dbo].[technician] ([id], [technician_type], [first_name], [last_name], [address], [postal_code], [city], [province], [work_area_id], [license_number], [created_at]) VALUES (3, 1, N'Thomas', N'Craig', N'150 Main Street (Suite 402)', N'N1R6P9', N'Cambridge', N'ON', 8, N'33333333', N'2019-02-14 01:49:04')
INSERT INTO [dbo].[technician] ([id], [technician_type], [first_name], [last_name], [address], [postal_code], [city], [province], [work_area_id], [license_number], [created_at]) VALUES (4, 2, N'Chris', N'Banks', N'50 Wellington Street', N'N3T2L6', N'Brantford', N'ON', 8, N'44444444', N'2019-02-14 01:49:04')
SET IDENTITY_INSERT [dbo].[technician] OFF

/* Fill Technician Skills Table */

INSERT INTO [dbo].[technician_skills] ([technician_id], [skills_id], [skill_rating], [expires_at], [created_at]) VALUES (1, 1, 2, N'2020-02-14 01:49:04', N'2019-02-14 01:49:04')
INSERT INTO [dbo].[technician_skills] ([technician_id], [skills_id], [skill_rating], [expires_at], [created_at]) VALUES (1, 3, 3, N'2020-02-14 01:49:04', N'2019-02-14 01:49:04')
INSERT INTO [dbo].[technician_skills] ([technician_id], [skills_id], [skill_rating], [expires_at], [created_at]) VALUES (2, 2, 2, N'2020-02-14 01:49:04', N'2019-02-14 01:49:04')
INSERT INTO [dbo].[technician_skills] ([technician_id], [skills_id], [skill_rating], [expires_at], [created_at]) VALUES (3, 1, 2, N'2020-02-14 01:49:04', N'2019-02-14 01:49:04')
INSERT INTO [dbo].[technician_skills] ([technician_id], [skills_id], [skill_rating], [expires_at], [created_at]) VALUES (4, 2, 4, N'2020-02-14 01:49:04', N'2019-02-14 01:49:04')

/* Fill Job Types Technician Type Table */

INSERT INTO [dbo].[job_types_technician_type] ([job_types_id], [technician_type_id]) VALUES (1, 1)
INSERT INTO [dbo].[job_types_technician_type] ([job_types_id], [technician_type_id]) VALUES (5, 2)

/* Fill Technician Type Skill Table */

INSERT INTO [dbo].[technician_type_skill] ([technician_typeid], [skillid]) VALUES (1, 1)
INSERT INTO [dbo].[technician_type_skill] ([technician_typeid], [skillid]) VALUES (2, 2)

/* Fill Work Order Table */

SET IDENTITY_INSERT [dbo].[work_order] ON
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (1, N'2019-02-12 20:39:35', N'2019-05-12 20:39:35', 3, 7, 1, N'420 Thomas Street', N'N5C 3J7', 90, N'2019-02-12 20:39:35')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (2, N'2019-02-12 20:39:35', N'2019-03-13 20:39:35', 1, 8, 1, N'420 Thomas Street', N'N5C 3J7', 90, N'2019-02-12 20:39:35')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (3, N'2019-02-14 08:34:01', N'2019-03-15 08:34:01', 2, 8, 1, N'420 Thomas Street', N'N5C 3J7', 60, N'2019-02-13 06:47:27')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (4, N'2019-02-13 06:48:15', N'2019-03-13 06:48:15', 1, 7, 1, N'420 Thomas Street', N'N5C 3J7', 60, N'2019-02-13 06:48:15')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (5, N'2019-02-13 06:50:34', N'2019-03-13 06:50:34', 3, 7, 1, N'420 Thomas Street', N'N5C 3J7', 120, N'2019-02-13 06:50:34')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (6, N'2019-02-13 06:52:14', N'2019-03-13 06:52:14', 1, 7, 1, N'420 Thomas Street', N'N5C 3J7', 60, N'2019-02-13 06:52:14')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (7, N'2019-02-13 06:53:09', N'2019-03-13 06:53:09', 4, 7, 1, N'420 Thomas Street', N'N5C 3J7', 90, N'2019-02-13 06:53:09')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (8, N'2019-02-14 09:20:53', N'2019-03-15 09:20:53', 2, 8, 1, N'420 Thomas Street', N'N5C 3J7', 120, N'2019-02-14 09:20:57')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (9, N'2019-02-14 13:52:35', N'2019-03-15 13:52:35', 3, 7, 1, N'420 Thomas Street', N'N5C 3J7', 60, N'2019-02-14 13:52:35')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (10, N'2019-02-16 13:03:00', N'2019-03-21 14:04:00', 2, 7, 1, N'420 Thomas Street', N'N5C 3J7', 90, N'2019-02-14 13:52:35')
INSERT INTO [dbo].[work_order] ([id], [minimum_start_time], [maximum_start_time], [priority], [work_area_id], [status_id], [address], [postal_code], [estimated_time_minutes], [created_at]) VALUES (11, N'2019-02-21 14:03:00', N'2019-03-23 14:04:00', 4, 7, 1, N'420 Thomas Street', N'N5C 3J7', 120, N'2019-02-15 16:57:21')
SET IDENTITY_INSERT [dbo].[work_order] OFF

/* Fill Job Table */

SET IDENTITY_INSERT [dbo].[job] ON
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (1, 1, 1, 90, 1, N'2019-02-13 06:47:27')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (2, 2, 1, 90, 2, N'2019-02-14 09:20:57')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (3, 3, 1, 60, 3, N'2019-02-14 13:52:35')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (4, 4, 1, 60, 4, N'2019-02-15 04:00:15')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (5, 5, 1, 120, 5, N'2019-02-15 16:57:21')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (6, 1, 1, 60, 6, N'2019-02-13 06:47:27')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (7, 2, 1, 90, 7, N'2019-02-14 09:20:57')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (8, 3, 1, 120, 8, N'2019-02-14 13:52:35')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (9, 4, 1, 60, 9, N'2019-02-15 04:00:15')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (10, 5, 1, 90, 10, N'2019-02-15 16:57:21')
INSERT INTO [dbo].[job] ([id], [job_type_id], [status_id], [estimated_time_minutes], [work_order_id], [created_at]) VALUES (11, 1, 1, 120, 11, N'2019-02-15 16:57:21')
SET IDENTITY_INSERT [dbo].[job] OFF
