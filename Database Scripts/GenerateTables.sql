
CREATE TABLE resources (
  id            int IDENTITY NOT NULL, 
  resource_type int NOT NULL, 
  work_area_id  int NOT NULL, 
  created_at    datetime NOT NULL, 
  modified_at   datetime NULL, 
  cost_code_id  int NULL, 
  PRIMARY KEY (id));
CREATE TABLE job (
  id                     int IDENTITY NOT NULL, 
  job_type_id            int NOT NULL, 
  status_id              int NOT NULL, 
  estimated_time_minutes int NOT NULL, 
  work_order_id          int NOT NULL, 
  created_at             datetime NOT NULL, 
  modified_at            datetime NULL, 
  PRIMARY KEY (id));
CREATE TABLE technician (
  id              int IDENTITY NOT NULL, 
  technician_type int NOT NULL, 
  first_name      varchar(60) NULL, 
  last_name       varchar(60) NULL, 
  address         varchar(255) NULL, 
  postal_code     varchar(8) NOT NULL, 
  city            varchar(100) NULL, 
  province        varchar(60) NULL, 
  work_area_id    int NOT NULL, 
  license_number  varchar(255) NULL, 
  created_at      datetime NOT NULL, 
  modified_at     datetime NULL, 
  cost_code_id    int NULL, 
  PRIMARY KEY (id));
CREATE TABLE work_order (
  id                     int IDENTITY NOT NULL, 
  minimum_start_time     datetime NOT NULL, 
  maximum_start_time     datetime NOT NULL, 
  priority               int NOT NULL, 
  work_area_id           int NOT NULL, 
  status_id              int NOT NULL, 
  address                varchar(255) NULL, 
  postal_code            varchar(8) NOT NULL, 
  estimated_time_minutes int NOT NULL, 
  created_at             datetime NOT NULL, 
  modified_at            datetime NULL, 
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
  modified_at timestamp NULL, 
  PRIMARY KEY (id));
CREATE TABLE work_area (
  id          int IDENTITY NOT NULL, 
  province    varchar(75) NOT NULL, 
  country     varchar(50) NOT NULL, 
  region      varchar(75) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at datetime NULL, 
  CONSTRAINT pk_work_area_id 
    PRIMARY KEY (id));
CREATE TABLE resource_type (
  id          int IDENTITY NOT NULL, 
  name        varchar(50) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at datetime NULL, 
  PRIMARY KEY (id));
CREATE TABLE technician_type (
  id          int IDENTITY NOT NULL, 
  name        varchar(100) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at datetime NULL, 
  PRIMARY KEY (id));
CREATE TABLE status (
  id          int IDENTITY NOT NULL, 
  name        varchar(25) NOT NULL, 
  description varchar(255) NULL, 
  created_at  datetime NOT NULL, 
  modified_at datetime NULL, 
  PRIMARY KEY (id));
CREATE TABLE technician_skills (
  technician_id int NOT NULL, 
  skills_id     int NOT NULL, 
  skill_rating  int NULL, 
  expires_at    datetime NULL, 
  created_at    datetime NOT NULL, 
  modified_at   datetime NULL, 
  PRIMARY KEY (technician_id, 
  skills_id));
CREATE TABLE job_types_resource_type (
  job_types_id     int NOT NULL, 
  resource_type_id int NOT NULL, 
  quantity         int NULL, 
  PRIMARY KEY (job_types_id, 
  resource_type_id));
CREATE TABLE job_types_technician_type (
  job_types_id       int NOT NULL, 
  technician_type_id int NOT NULL, 
  quantity           int NULL, 
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
  modified_at  datetime NULL, 
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
  modified_at datetime NULL, 
  PRIMARY KEY (jobid, 
  crewid));
CREATE TABLE notes (
  id            int IDENTITY NOT NULL, 
  work_order_id int NOT NULL, 
  note          varchar(255) NOT NULL, 
  created_at    datetime NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE cost_code (
  id                    int IDENTITY NOT NULL, 
  cost_code_description varchar(50) NULL, 
  cost_code_rate        float(10) NOT NULL, 
  created_at            datetime NOT NULL, 
  modified_at           datetime NULL, 
  CONSTRAINT id 
    PRIMARY KEY (id));
CREATE TABLE technician_kpi (
  tech_id     int NOT NULL, 
  kpi         int NULL, 
  created_at  datetime NOT NULL, 
  modified_at datetime NULL, 
  CONSTRAINT tech_id 
    PRIMARY KEY (tech_id));
CREATE TABLE dispatcher (
  id                     int IDENTITY NOT NULL, 
  first_name             varchar(50) NOT NULL, 
  last_name              varchar(50) NOT NULL, 
  original_dispatcher_id int NOT NULL, 
  created_at             datetime NOT NULL, 
  modified_at            datetime NULL, 
  last_work_area_id      int NULL, 
  PRIMARY KEY (id));
CREATE TABLE postal_code (
  postal_code varchar(8) NOT NULL, 
  latitude    float(10) NOT NULL, 
  longitude   float(10) NOT NULL, 
  PRIMARY KEY (postal_code));
ALTER TABLE job ADD CONSTRAINT FKjob58212 FOREIGN KEY (work_order_id) REFERENCES work_order (id);
ALTER TABLE work_order ADD CONSTRAINT FKwork_order805279 FOREIGN KEY (work_area_id) REFERENCES work_area (id);
ALTER TABLE job ADD CONSTRAINT FKjob354358 FOREIGN KEY (job_type_id) REFERENCES job_types (id);
ALTER TABLE job ADD CONSTRAINT FKjob396678 FOREIGN KEY (status_id) REFERENCES status (id);
ALTER TABLE work_order ADD CONSTRAINT FKwork_order341947 FOREIGN KEY (status_id) REFERENCES status (id);
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
ALTER TABLE notes ADD CONSTRAINT FKnotes154679 FOREIGN KEY (work_order_id) REFERENCES work_order (id);
ALTER TABLE technician ADD CONSTRAINT FKtechnician856772 FOREIGN KEY (cost_code_id) REFERENCES cost_code (id);
ALTER TABLE resources ADD CONSTRAINT FKresources786605 FOREIGN KEY (cost_code_id) REFERENCES cost_code (id);
ALTER TABLE technician_kpi ADD CONSTRAINT FKtechnician98734 FOREIGN KEY (tech_id) REFERENCES technician (id);
ALTER TABLE dispatcher ADD CONSTRAINT FKdispatcher377804 FOREIGN KEY (last_work_area_id) REFERENCES work_area (id);
ALTER TABLE work_order ADD CONSTRAINT FKwork_order198291 FOREIGN KEY (postal_code) REFERENCES postal_code (postal_code);
ALTER TABLE technician ADD CONSTRAINT FKtechnician4784 FOREIGN KEY (postal_code) REFERENCES postal_code (postal_code);
