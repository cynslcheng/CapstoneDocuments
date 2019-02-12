ALTER TABLE job DROP CONSTRAINT FKjob58212;
ALTER TABLE work_order DROP CONSTRAINT FKwork_order805279;
ALTER TABLE job DROP CONSTRAINT FKjob354358;
ALTER TABLE job DROP CONSTRAINT FKjob396678;
ALTER TABLE work_order DROP CONSTRAINT FKwork_order341947;
ALTER TABLE job DROP CONSTRAINT FKjob855462;
ALTER TABLE resources DROP CONSTRAINT FKresources681939;
ALTER TABLE technician DROP CONSTRAINT FKtechnician611772;
ALTER TABLE resources DROP CONSTRAINT FKresources821121;
ALTER TABLE technician DROP CONSTRAINT FKtechnician13398;
ALTER TABLE technician_skills DROP CONSTRAINT FKtechnician509322;
ALTER TABLE technician_skills DROP CONSTRAINT FKtechnician347430;
ALTER TABLE job_types_resource_type DROP CONSTRAINT FKjob_types_167822;
ALTER TABLE job_types_resource_type DROP CONSTRAINT FKjob_types_492886;
ALTER TABLE job_types_technician_type DROP CONSTRAINT FKjob_types_905511;
ALTER TABLE job_types_technician_type DROP CONSTRAINT FKjob_types_882885;
ALTER TABLE resource_type_skill DROP CONSTRAINT FKresource_t763805;
ALTER TABLE resource_type_skill DROP CONSTRAINT FKresource_t546952;
ALTER TABLE technician_type_skill DROP CONSTRAINT FKtechnician430338;
ALTER TABLE technician_type_skill DROP CONSTRAINT FKtechnician816449;
ALTER TABLE crew_technician DROP CONSTRAINT FKcrew_techn363840;
ALTER TABLE crew_technician DROP CONSTRAINT FKcrew_techn708002;
ALTER TABLE crew_resources DROP CONSTRAINT FKcrew_resou791084;
ALTER TABLE crew_resources DROP CONSTRAINT FKcrew_resou488653;
ALTER TABLE job_crew DROP CONSTRAINT FKjob_crew146519;
ALTER TABLE job_crew DROP CONSTRAINT FKjob_crew209421;
ALTER TABLE job_crew DROP CONSTRAINT FKjob_crew261667;
ALTER TABLE crew DROP CONSTRAINT FKcrew154869;
DROP TABLE resources;
DROP TABLE job;
DROP TABLE technician;
DROP TABLE work_order;
DROP TABLE skill;
DROP TABLE job_types;
DROP TABLE work_area;
DROP TABLE resource_type;
DROP TABLE technician_type;
DROP TABLE status;
DROP TABLE technician_skills;
DROP TABLE job_types_resource_type;
DROP TABLE job_types_technician_type;
DROP TABLE resource_type_skill;
DROP TABLE technician_type_skill;
DROP TABLE crew;
DROP TABLE crew_technician;
DROP TABLE crew_resources;
DROP TABLE job_crew;
CREATE TABLE resources (
  id            int IDENTITY NOT NULL, 
  resource_type int NOT NULL, 
  work_area_id  int NOT NULL, 
  created_at    datetime NOT NULL, 
  modified_at   timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE job (
  id                     int IDENTITY NOT NULL, 
  job_type_id            int NOT NULL, 
  status_id              int NOT NULL, 
  estimated_time_minutes int NOT NULL, 
  work_order_id          int NOT NULL, 
  created_at             datetime NOT NULL, 
  modified_at            timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE technician (
  id              int IDENTITY NOT NULL, 
  technician_type int NOT NULL, 
  first_name      varchar(60) NULL, 
  last_name       varchar(60) NULL, 
  address         varchar(255) NULL, 
  postal_code     varchar(8) NULL, 
  city            varchar(100) NULL, 
  province        varchar(60) NULL, 
  work_area_id    int NOT NULL, 
  license_number  varchar(255) NULL, 
  created_at      datetime NOT NULL, 
  modified_at     timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE work_order (
  id                     int IDENTITY NOT NULL, 
  minimum_start_time     datetime NOT NULL, 
  maximum_start_time     datetime NOT NULL, 
  priority               int NOT NULL, 
  work_area_id           int NOT NULL, 
  status_id              int NOT NULL, 
  address                varchar(255) NULL, 
  postal_code            varchar(8) NULL, 
  estimated_time_minutes int NOT NULL, 
  created_at             datetime NOT NULL, 
  modified_at            timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE skill (
  id          int IDENTITY NOT NULL, 
  name        varchar(50) NOT NULL, 
  description varchar(255) NULL, 
  PRIMARY KEY (id));
CREATE TABLE job_types (
  id          int IDENTITY NOT NULL, 
  name        varchar(100) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE work_area (
  id          int IDENTITY NOT NULL, 
  province    varchar(75) NOT NULL, 
  country     varchar(50) NOT NULL, 
  region      varchar(75) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at timestamp NOT NULL, 
  CONSTRAINT pk_work_area_id 
    PRIMARY KEY (id));
CREATE TABLE resource_type (
  id          int IDENTITY NOT NULL, 
  name        varchar(50) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE technician_type (
  id          int IDENTITY NOT NULL, 
  name        varchar(100) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE status (
  id          int IDENTITY NOT NULL, 
  name        varchar(25) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE technician_skills (
  technician_id int NOT NULL, 
  skills_id     int NOT NULL, 
  skill_rating  int NULL, 
  expires_at    datetime NULL, 
  created_at    datetime NOT NULL, 
  modified_at   timestamp NOT NULL, 
  PRIMARY KEY (technician_id, 
  skills_id));
CREATE TABLE job_types_resource_type (
  job_types_id     int NOT NULL, 
  resource_type_id int NOT NULL, 
  PRIMARY KEY (job_types_id, 
  resource_type_id));
CREATE TABLE job_types_technician_type (
  job_types_id       int NOT NULL, 
  technician_type_id int NOT NULL, 
  PRIMARY KEY (job_types_id, 
  technician_type_id));
CREATE TABLE resource_type_skill (
  resource_typeid int NOT NULL, 
  skillid         int NOT NULL, 
  PRIMARY KEY (resource_typeid, 
  skillid));
CREATE TABLE technician_type_skill (
  technician_typeid int NOT NULL, 
  skillid           int NOT NULL, 
  PRIMARY KEY (technician_typeid, 
  skillid));
CREATE TABLE crew (
  id           int IDENTITY NOT NULL, 
  work_area_id int NOT NULL, 
  start_time   datetime NOT NULL, 
  end_time     datetime NOT NULL, 
  created_at   datetime NOT NULL, 
  modified_at  timestamp NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE crew_technician (
  crewid       int NOT NULL, 
  technicianid int NOT NULL, 
  PRIMARY KEY (crewid, 
  technicianid));
CREATE TABLE crew_resources (
  resourcesid int NOT NULL, 
  crewid      int NOT NULL, 
  PRIMARY KEY (resourcesid, 
  crewid));
CREATE TABLE job_crew (
  jobid       int NOT NULL, 
  crewid      int NOT NULL, 
  start_time  datetime NOT NULL, 
  end_time    datetime NULL, 
  status_id   int NOT NULL, 
  created_at  datetime NOT NULL, 
  modified_at timestamp NOT NULL, 
  PRIMARY KEY (jobid, 
  crewid));
ALTER TABLE job ADD CONSTRAINT FKjob58212 FOREIGN KEY (work_order_id) REFERENCES work_order (id);
ALTER TABLE work_order ADD CONSTRAINT FKwork_order805279 FOREIGN KEY (work_area_id) REFERENCES work_area (id);
ALTER TABLE job ADD CONSTRAINT FKjob354358 FOREIGN KEY (job_type_id) REFERENCES job_types (id);
ALTER TABLE job ADD CONSTRAINT FKjob396678 FOREIGN KEY (status_id) REFERENCES status (id);
ALTER TABLE work_order ADD CONSTRAINT FKwork_order341947 FOREIGN KEY (status_id) REFERENCES status (id);
ALTER TABLE job ADD CONSTRAINT FKjob855462 FOREIGN KEY (work_order_id) REFERENCES work_area (id);
ALTER TABLE resources ADD CONSTRAINT FKresources681939 FOREIGN KEY (work_area_id) REFERENCES work_area (id);
ALTER TABLE technician ADD CONSTRAINT FKtechnician611772 FOREIGN KEY (work_area_id) REFERENCES work_area (id);
ALTER TABLE resources ADD CONSTRAINT FKresources821121 FOREIGN KEY (resource_type) REFERENCES resource_type (id);
ALTER TABLE technician ADD CONSTRAINT FKtechnician13398 FOREIGN KEY (technician_type) REFERENCES technician_type (id);
ALTER TABLE technician_skills ADD CONSTRAINT FKtechnician509322 FOREIGN KEY (technician_id) REFERENCES technician (id);
ALTER TABLE technician_skills ADD CONSTRAINT FKtechnician347430 FOREIGN KEY (skills_id) REFERENCES skill (id);
ALTER TABLE job_types_resource_type ADD CONSTRAINT FKjob_types_167822 FOREIGN KEY (job_types_id) REFERENCES job_types (id);
ALTER TABLE job_types_resource_type ADD CONSTRAINT FKjob_types_492886 FOREIGN KEY (resource_type_id) REFERENCES resource_type (id);
ALTER TABLE job_types_technician_type ADD CONSTRAINT FKjob_types_905511 FOREIGN KEY (job_types_id) REFERENCES job_types (id);
ALTER TABLE job_types_technician_type ADD CONSTRAINT FKjob_types_882885 FOREIGN KEY (technician_type_id) REFERENCES technician_type (id);
ALTER TABLE resource_type_skill ADD CONSTRAINT FKresource_t763805 FOREIGN KEY (resource_typeid) REFERENCES resource_type (id);
ALTER TABLE resource_type_skill ADD CONSTRAINT FKresource_t546952 FOREIGN KEY (skillid) REFERENCES skill (id);
ALTER TABLE technician_type_skill ADD CONSTRAINT FKtechnician430338 FOREIGN KEY (technician_typeid) REFERENCES technician_type (id);
ALTER TABLE technician_type_skill ADD CONSTRAINT FKtechnician816449 FOREIGN KEY (skillid) REFERENCES skill (id);
ALTER TABLE crew_technician ADD CONSTRAINT FKcrew_techn363840 FOREIGN KEY (crewid) REFERENCES crew (id);
ALTER TABLE crew_technician ADD CONSTRAINT FKcrew_techn708002 FOREIGN KEY (technicianid) REFERENCES technician (id);
ALTER TABLE crew_resources ADD CONSTRAINT FKcrew_resou791084 FOREIGN KEY (resourcesid) REFERENCES resources (id);
ALTER TABLE crew_resources ADD CONSTRAINT FKcrew_resou488653 FOREIGN KEY (crewid) REFERENCES crew (id);
ALTER TABLE job_crew ADD CONSTRAINT FKjob_crew146519 FOREIGN KEY (jobid) REFERENCES job (id);
ALTER TABLE job_crew ADD CONSTRAINT FKjob_crew209421 FOREIGN KEY (crewid) REFERENCES crew (id);
ALTER TABLE job_crew ADD CONSTRAINT FKjob_crew261667 FOREIGN KEY (status_id) REFERENCES status (id);
ALTER TABLE crew ADD CONSTRAINT FKcrew154869 FOREIGN KEY (work_area_id) REFERENCES work_area (id);
SET IDENTITY_INSERT work_area ON;
INSERT INTO work_area(id, province, country, region, description, created_at, modified_at) VALUES (1, 'on', 'canada', 'waterloo', null, '2019-02-12 00:00:00', 2019-02-12 00:10:00);
SET IDENTITY_INSERT work_area OFF;
SET IDENTITY_INSERT status ON;
INSERT INTO status(id, name, description, created_at, modified_at) VALUES (1, 'wsched', 'waiting to be scheduled', '2019-02-12 00:00:00', 2019-02-12 20:00:00);
INSERT INTO status(id, name, description, created_at, modified_at) VALUES (2, 'dispatched', 'dispatched job', '2019-02-12 00:00:00', 2019-02-12 12:00:00);
SET IDENTITY_INSERT status OFF;
SET IDENTITY_INSERT work_order ON;
INSERT INTO work_order(id, minimum_start_time, maximum_start_time, priority, work_area_id, status_id, address, postal_code, estimated_time_minutes, created_at, modified_at) VALUES (1, '2019/01/01 20:20:20', '2020/01/01 21:21:21', 4, 1, 1, '3 black rd', '0k 1m0', 2, '2019-02-12 00:00:00', 2019-02-12 00:10:00);
SET IDENTITY_INSERT work_order OFF;
