CREATE TABLE resource (
  resource_id  int NOT NULL, 
  cost_code_id int NOT NULL UNIQUE, 
  PRIMARY KEY (resource_id));
CREATE TABLE cost_code (
  cost_code_id          int IDENTITY NOT NULL, 
  cost_code_description varchar(255) NOT NULL, 
  cost_code_rate        decimal(19, 2) DEFAULT 0.00 NOT NULL, 
  is_active             bit NOT NULL, 
  create_date           datetime NOT NULL, 
  create_user           varchar(255) NOT NULL, 
  PRIMARY KEY (cost_code_id));
CREATE TABLE resource_skills (
  resource_skill_id int NOT NULL, 
  resource_id       int NOT NULL, 
  skill_id          int NOT NULL, 
  skill_rating_id   int NOT NULL, 
  expiration_date   datetime NULL, 
  is_active         bit NOT NULL, 
  create_date       datetime NOT NULL, 
  create_user       varchar(255) NOT NULL, 
  PRIMARY KEY (resource_skill_id));
CREATE TABLE skills (
  skill_id          int IDENTITY NOT NULL, 
  skill_description varchar(255) NOT NULL, 
  skill_level       int NOT NULL, 
  is_active         bit NOT NULL, 
  create_date       datetime NOT NULL, 
  create_user       varchar(255) NOT NULL, 
  PRIMARY KEY (skill_id));
CREATE TABLE skill_rating (
  skill_rating_id          int IDENTITY NOT NULL, 
  skill_rating_ratio       decimal(19, 6) NOT NULL, 
  skill_rating_description varchar(255) NOT NULL, 
  is_active                bit NOT NULL, 
  create_date              datetime NOT NULL, 
  create_user              varchar(255) NOT NULL, 
  skill_rating_col1        int NULL, 
  PRIMARY KEY (skill_rating_id));
CREATE TABLE job_code_skills (
  job_code_skills_id int IDENTITY NOT NULL, 
  job_code_id        int NOT NULL, 
  skill_id           int NOT NULL, 
  is_active          bit NOT NULL, 
  create_date        datetime NOT NULL, 
  create_user        varchar(255) NOT NULL, 
  PRIMARY KEY (job_code_skills_id));
CREATE TABLE job_code (
  job_code_id int IDENTITY NOT NULL, 
  PRIMARY KEY (job_code_id));
CREATE TABLE dbo.Appt_Rule (
  RuleID            int IDENTITY(0, 0) NOT NULL, 
  RuleName          varchar(50) NOT NULL, 
  CreatedTimestamp  datetime2(7) NOT NULL, 
  CreatedByID       int NOT NULL, 
  RecordStatusID    int NOT NULL, 
  Area              varchar(50) NULL, 
  JobType           varchar(50) NULL, 
  JobCode           varchar(50) NULL, 
  EffectiveFromDate date NULL, 
  EffectiveToDate   date NULL, 
  Comment           varchar(max) NULL, 
  AppNameID         int NULL, 
  CONSTRAINT PK_Appt_Rule 
    PRIMARY KEY (RuleID));
CREATE TABLE dbo.Appt_RuleParameter (
  RuleParameterID  int NOT NULL, 
  RuleID           int NOT NULL, 
  RuleTypeID       int NOT NULL, 
  CreatedTimestamp datetime2(7) NOT NULL, 
  CreatedByID      int NOT NULL, 
  RecordStatusID   int NOT NULL, 
  FromDate         date NULL, 
  ToDate           date NULL, 
  MsgBefore        varchar(max) NULL, 
  MsgAfter         varchar(max) NULL, 
  MsgDuring        varchar(max) NULL);
CREATE TABLE dbo.ApptAttribute (
  WOAppointmentID int NOT NULL, 
  AttributeName   varchar(50) NOT NULL, 
  AttributeValue  varchar(255) NOT NULL);
CREATE TABLE dbo.CAT_JobCode (
  JobCodeID         int IDENTITY(0, 0) NOT NULL, 
  CatalogID         int NULL, 
  JobTypeID         int NULL, 
  SubtypeID         int NULL, 
  JobPlanID         int NULL, 
  ExpectedDuration  real NULL, 
  DisplayJobCode    varchar(255) NULL, 
  Description       varchar(255) NULL, 
  IsActive          bit NULL, 
  IsPrimary         bit NULL, 
  IsRC              bit NULL, 
  IsRR              bit NULL, 
  IsRO              bit NULL, 
  InSabre           bit NULL, 
  AllowSuspend      bit NULL, 
  AllowEarlyArrival bit NULL, 
  LateWindow        int NULL, 
  PrimaryTemplateID int NOT NULL, 
  FollowupDelay     int NULL, 
  Note              varchar(1024) NULL, 
  CreatedByID       int NULL, 
  CreatedTimestamp  datetime DEFAULT (getdate()) NULL, 
  CONSTRAINT PK_CJobCode 
    PRIMARY KEY (JobCodeID), 
  CONSTRAINT UnCJobCode 
    UNIQUE (JobTypeID, SubtypeID, JobPlanID));
CREATE TABLE dbo.CAT_JobCodeList (
  JobCodeListID    int IDENTITY(1, 1) NOT NULL, 
  JobCodeID        int NULL, 
  CodeID           int NULL, 
  SortOrder        int NULL, 
  TransmitID       int NULL, 
  CodeListTypeID   int NULL, 
  IsActive         int DEFAULT 1 NOT NULL, 
  CreatedByID      int NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CONSTRAINT PK_CJobCodeList 
    PRIMARY KEY (JobCodeListID), 
  CONSTRAINT UnCJobCodeList 
    UNIQUE (JobCodeID, CodeID, CodeListTypeID));
CREATE TABLE dbo.CAT_Master (
  CatalogID        int IDENTITY(0, 0) NOT NULL, 
  CatalogName      varchar(255) NULL, 
  IsActive         bit NOT NULL, 
  CreatedByID      int NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CONSTRAINT PK__CAT_Mast__C2513B482913C0E8 
    PRIMARY KEY (CatalogID), 
  CONSTRAINT UnCatalog 
    UNIQUE (CatalogName));
CREATE TABLE dbo.CAT_TemplateAttribute (
  TemplateAttributeID int IDENTITY(0, 0) NOT NULL, 
  TemplateID          int NOT NULL, 
  DataAttributeID     int NOT NULL, 
  IsRequired          int NULL, 
  IsReadonly          bit DEFAULT '0' NOT NULL, 
  SortOrder           int NULL, 
  HasDependants       bit NULL, 
  OverrideValue       bit NULL, 
  OverrideDOMAINID    varchar(50) NULL, 
  OverrideDATATYPE    varchar(8) NULL, 
  Validate            bit DEFAULT '1' NOT NULL, 
  JCABits             int DEFAULT 0 NOT NULL, 
  IsActive            int DEFAULT 1 NULL, 
  SpecTypeID          int DEFAULT 5800 NOT NULL, 
  CONSTRAINT PK__CAT_Temp__E2F7775C4DEF9919 
    PRIMARY KEY (TemplateAttributeID), 
  CONSTRAINT UnCatAttrTmp 
    UNIQUE (TemplateID, DataAttributeID, SpecTypeID));
CREATE TABLE dbo.HH_Action (
  HH_ActionID    int IDENTITY(1, 1) NOT NULL, 
  OrderID        int NULL, 
  LocalTimestamp datetime NULL, 
  WR_ID          varchar(12) NOT NULL, 
  ApptID         bigint NULL, 
  Action         varchar(255) NULL, 
  Fitter_ID      varchar(12) NULL, 
  Timestamp      datetime NULL, 
  CONSTRAINT PK_HH_Action 
    PRIMARY KEY (HH_ActionID));
CREATE TABLE dbo.HH_CancelRaise (
  HH_CancelRaiseID int IDENTITY(1, 1) NOT NULL, 
  OrderID          int DEFAULT 0 NOT NULL, 
  LocalTimestamp   datetime NULL, 
  PARENT_WR_ID     varchar(12) NULL, 
  TEMP_WR_ID       bigint NULL, 
  JobCodeID        int NULL, 
  RaiseType        varchar(2) NULL, 
  Fitter_ID        varchar(12) NULL, 
  COMMENTS         varchar(255) NULL, 
  CONSTRAINT PK_HH_CancelRaise 
    PRIMARY KEY (HH_CancelRaiseID));
CREATE TABLE dbo.HH_Completion (
  HH_CompletionID       int IDENTITY(1, 1) NOT NULL, 
  OrderID               int DEFAULT 0 NOT NULL, 
  LocalTimestamp        datetime NULL, 
  WR_ID                 varchar(12) NOT NULL, 
  COMPLETION_DATE       datetime NULL, 
  DateStamp             datetime NULL, 
  METER_NUMBER          varchar(254) NULL, 
  METER_STATUS          varchar(254) NULL, 
  RESOLUTION_CODE       varchar(20) NULL, 
  WOAppointmentID       bigint NULL, 
  ArrivalTimeHHMM       varchar(4) NULL, 
  CompletionTimeHHMM    varchar(4) NULL, 
  UpdateDate            datetime NULL, 
  CompletionDate        datetime NULL, 
  AppointmentType       varchar(30) NULL, 
  EarlyNow              bit NULL, 
  LateWindow            int NULL, 
  CompletionFitterCode  varchar(30) NULL, 
  GPSCurrentCoordinates bit NULL, 
  GPSOverride           bit NULL, 
  OnSiteGPSTimestamp    datetime NULL, 
  OnSiteLatitude        float(53) NULL, 
  OnSiteLongitude       float(53) NULL, 
  FailureCodeID         int NULL, 
  FailureClass          varchar(8) NULL, 
  FailureProblem        varchar(8) NULL, 
  FailureCause          varchar(8) NULL, 
  FailureRemedy         varchar(8) NULL, 
  PPE                   varchar(1) NULL, 
  ESI                   varchar(1) NULL, 
  STF                   varchar(1) NULL, 
  OEH                   varchar(1) NULL, 
  AOH                   varchar(1) NULL, 
  HazardNotes           varchar(max) NULL, 
  CONSTRAINT PK_HH_Completion 
    PRIMARY KEY (HH_CompletionID));
CREATE TABLE dbo.HH_FieldAttribute (
  HH_FieldAttributeID int IDENTITY(1, 1) NOT NULL, 
  OrderID             int DEFAULT 0 NOT NULL, 
  LocalTimestamp      datetime NULL, 
  HH_RecordType       varchar(1) NULL, 
  HH_RaiseCompleteID  int DEFAULT (NULL) NULL, 
  HH_CompletionID     int DEFAULT (NULL) NULL, 
  WR_ID               varchar(12) NOT NULL, 
  PARENT_WR_ID        varchar(12) NULL, 
  ATTRIBUTE_CODE      varchar(24) NULL, 
  FAName              varchar(255) NULL, 
  FAValue             varchar(254) NULL, 
  VALIDATION_CODE     varchar(20) NULL, 
  DEFAULT_VALUE       varchar(254) NULL, 
  FA_ID               bigint NULL, 
  ReadOnly            bit NULL, 
  DataType            varchar(8) NULL, 
  LENGTH              varchar(10) NULL, 
  Sequence            int NULL, 
  FieldValidation     varchar(20) NULL, 
  CONSTRAINT PK_HH_FieldAttribute 
    PRIMARY KEY (HH_FieldAttributeID));
CREATE TABLE dbo.HH_ImageData (
  HH_ImageDataID int IDENTITY(1, 1) NOT NULL, 
  OrderID        int DEFAULT 0 NOT NULL, 
  LocalTimestamp datetime NULL, 
  WR_ID          varchar(12) NOT NULL, 
  DocumentID     bigint NULL, 
  DocumentData   varbinary(max) NULL, 
  DateStamp      datetime NULL, 
  UploadedBy     varchar(255) NULL, 
  ImgDescription varchar(254) NULL, 
  UTPDocumentID  int DEFAULT (NULL) NULL, 
  CONSTRAINT PK_HH_ImageData 
    PRIMARY KEY (HH_ImageDataID));
CREATE TABLE dbo.HH_Note (
  HH_NoteID      int IDENTITY(1, 1) NOT NULL, 
  OrderID        int DEFAULT 0 NOT NULL, 
  LocalTimestamp datetime NULL, 
  WR_ID          varchar(12) NOT NULL, 
  NoteID         int NULL, 
  NoteText       varchar(255) NULL, 
  DateStamp      datetime NULL, 
  UpdateBy       varchar(255) NULL, 
  CONSTRAINT PK_HH_Note 
    PRIMARY KEY (HH_NoteID));
CREATE TABLE dbo.HH_RaiseComplete (
  HH_RaiseCompleteID   int IDENTITY(1, 1) NOT NULL, 
  OrderID              int DEFAULT 0 NOT NULL, 
  LocalTimestamp       datetime NULL, 
  WR_ID                varchar(12) NOT NULL, 
  PARENT_WR_ID         varchar(12) NULL, 
  COMMENTS             varchar(255) NULL, 
  COMPLETION_DATE      datetime NULL, 
  COMPLETION_FITTER_ID varchar(12) NULL, 
  DateStamp            datetime NULL, 
  JOB_CODE             varchar(64) NULL, 
  JOB_TYPE             varchar(64) NULL, 
  METER_NUMBER         varchar(254) NULL, 
  RESOLUTION_CODE      varchar(20) NULL, 
  WR_DESC              varchar(255) NULL, 
  JobCodeID            int NULL, 
  SubType              varchar(64) NULL, 
  RaiseType            varchar(2) NULL, 
  APEQTYPE             varchar(2) NULL, 
  FailureClass         varchar(8) NULL, 
  FailureProblem       varchar(8) NULL, 
  FailureCause         varchar(8) NULL, 
  FailureRemedy        varchar(8) NULL, 
  CONSTRAINT PK_HH_RaiseComplete 
    PRIMARY KEY (HH_RaiseCompleteID));
CREATE TABLE dbo.HH_Remark (
  HH_RemarkID        int IDENTITY(1, 1) NOT NULL, 
  OrderID            int DEFAULT 0 NOT NULL, 
  LocalTimestamp     datetime NULL, 
  HH_RecordType      varchar(1) NULL, 
  HH_RaiseCompleteID int DEFAULT (NULL) NULL, 
  HH_CompletionID    int DEFAULT (NULL) NULL, 
  WR_ID              varchar(12) NOT NULL, 
  PARENT_WR_ID       varchar(12) NULL, 
  TEMP_REMARK_ID     bigint NULL, 
  REMARK_CONTENT     varchar(max) NULL, 
  REMARK_DATE        datetime NULL, 
  CONSTRAINT PK_HH_Remark 
    PRIMARY KEY (HH_RemarkID));
CREATE TABLE dbo.RPT_rdsCompletions (
  [Date]          date NULL, 
  WOID            int NOT NULL, 
  OrderID         int NOT NULL, 
  DateCompleted   datetime NULL, 
  SourceCompleted varchar(255) NULL, 
  IsSabre         bit NULL, 
  IsUtopis        bit NULL, 
  IsRRC           bit NULL, 
  WorkDate        date NULL, 
  IsPrevious      bit NULL);
CREATE TABLE dbo.RPT_rdsErrors (
  [Date]    date NULL, 
  WOID      int NOT NULL, 
  OrderID   int NOT NULL, 
  ErrorMemo varchar(max) NULL, 
  ErrorType varchar(max) NULL, 
  ErrorTime datetime NULL);
CREATE TABLE dbo.RPT_rdsNewReceipts (
  [Date]  date NULL, 
  WOID    int NOT NULL, 
  OrderID int NOT NULL, 
  IsRRC   bit NULL);
CREATE TABLE dbo.RPT_rdsScannedDocs (
  [Date] date NULL, 
  Count  int NULL);
CREATE TABLE dbo.sysdiagrams (
  name         sysname NOT NULL, 
  principal_id int NOT NULL, 
  diagram_id   int IDENTITY(1, 1) NOT NULL, 
  version      int NULL, 
  definition   varbinary(max) NULL, 
  CONSTRAINT PK__sysdiagr__C2B05B61C3FE64FC 
    PRIMARY KEY (diagram_id), 
  CONSTRAINT UK_principal_name 
    UNIQUE (principal_id, name));
CREATE TABLE dbo.UTP_Address (
  AddressID       int IDENTITY(1, 1) NOT NULL, 
  StreetNo        varchar(10) DEFAULT '0' NULL, 
  Sfx             varchar(50) NOT NULL, 
  Street          varchar(50) NOT NULL, 
  Misc            varchar(150) NULL, 
  Town            varchar(50) NULL, 
  County          varchar(50) NULL, 
  Unit            varchar(10) NULL, 
  LotNumber       varchar(10) NULL, 
  ProvinceCode    varchar(20) NULL, 
  CountryCode     varchar(20) NULL, 
  PostalCode      varchar(20) NULL, 
  StreetType      varchar(20) NULL, 
  MailingAddress1 varchar(200) NULL, 
  MailingAddress2 varchar(200) NULL, 
  MailingAddress3 varchar(200) NULL, 
  CONSTRAINT PK__UTP_Addr__091C2A1BCB76BD26 
    PRIMARY KEY (AddressID));
CREATE TABLE dbo.UTP_Appointment (
  AppointmentID               int IDENTITY(1, 1) NOT NULL, 
  TechnicianID                int NULL, 
  AppointmentTypeID           int NOT NULL, 
  OrderID                     int NULL, 
  AppointmentStatusID         int NULL, 
  TimeslotID                  int NULL, 
  BookedViaID                 int NULL, 
  CreatedTimestamp            datetime NULL, 
  ExpectedDuration            real NULL, 
  PreferredContactModeID      int NULL, 
  ModifiedTimestamp           datetime NULL, 
  ContactID                   int NULL, 
  ApptStartDate               datetime NULL, 
  CompletionCode              varchar(6) NULL, 
  ActualStart                 datetime NULL, 
  ActualFinish                datetime NULL, 
  ApptEndDate                 datetime NULL, 
  ApptStartTime               varchar(5) NULL, 
  ApptEndTime                 varchar(5) NULL, 
  SpecialInstructions         varchar(1000) NULL, 
  CreatedByID                 int NULL, 
  ModifiedByID                int NULL, 
  AccessRestricted            bit NULL, 
  MedicalNecessity            bit NULL, 
  IsFirmAppt                  bit NULL, 
  MeterLeftStatus             varchar(10) NULL, 
  IsEAOK                      bit NULL, 
  AppointmentModifiedReasonID int NULL, 
  CONSTRAINT PK__UTP_Appo__8ECDFCA2FBB2E356 
    PRIMARY KEY (AppointmentID));
CREATE TABLE dbo.UTP_Catalog (
  CatalogID    int IDENTITY(1, 1) NOT NULL, 
  CatalogName  varchar(255) NULL, 
  RowVersionID int NULL, 
  IsActive     int DEFAULT 1 NOT NULL, 
  CONSTRAINT PK__UTP_Cata__C2513B48FCC59392 
    PRIMARY KEY (CatalogID));
CREATE TABLE dbo.UTP_CODetail (
  CODetailID int IDENTITY(1, 1) NOT NULL, 
  OrderID    int NOT NULL, 
  CONSTRAINT PK__UTP_CODe__9C5974F847FF3FF7 
    PRIMARY KEY (CODetailID));
CREATE TABLE dbo.UTP_Collection (
  CollectionID      bigint identity NOT NULL, 
  CollectionTypeID  int NOT NULL, 
  CollectionName    varchar(255) NOT NULL, 
  CollectionOwnerID int NULL, 
  CollectionQuery   varchar(max) NULL, 
  StatementTypeID   int NULL);
CREATE TABLE dbo.UTP_CollectionItem (
  CollectionItemID bigint identity NOT NULL, 
  CollectionID     bigint NOT NULL, 
  CollectionItem   varchar(255) NOT NULL);
CREATE TABLE dbo.UTP_Contact (
  ContactID             int IDENTITY(1, 1) NOT NULL, 
  OrderID               int NOT NULL, 
  PersonID              int NULL, 
  ContactTypeID         int NULL, 
  ContactName           varchar(255) NULL, 
  ContactEmail          varchar(50) NULL, 
  ContactPhone          varchar(20) NULL, 
  ContactAlternatePhone varchar(20) NULL, 
  LanguageID            int NULL, 
  CONSTRAINT PK__UTP_Cont__5C6625BB7CEC257C 
    PRIMARY KEY (ContactID));
CREATE TABLE dbo.UTP_Contract (
  ContractID          bigint identity NOT NULL, 
  ContractTypeID      int NOT NULL, 
  ContractNum         varchar(25) NULL, 
  ContractName        varchar(255) NULL, 
  ContractDescription varchar(max) NULL, 
  CustomerContractNum varchar(25) NULL, 
  ContractStartDate   datetime NULL, 
  ContractEndDate     datetime NULL, 
  OrgID               int NULL, 
  IsActive            bit NULL);
CREATE TABLE dbo.UTP_Customer (
  CustomerID int IDENTITY(1, 1) NOT NULL, 
  OrgID      int NOT NULL, 
  CONSTRAINT PK__UTP_Cust__A4AE64B8E6D6B401 
    PRIMARY KEY (CustomerID));
CREATE TABLE dbo.UTP_DataAttribute (
  DataAttributeID int IDENTITY(1, 1) NOT NULL, 
  Category        varchar(255) NOT NULL, 
  AttributeName   varchar(255) NOT NULL, 
  DisplayName     varchar(255) NOT NULL, 
  Description     varchar(max) NULL, 
  DataTypeID      int NOT NULL, 
  Length          int NOT NULL, 
  DefaultValue    varchar(255) NULL, 
  DocText         varchar(max) NULL, 
  HelpText        varchar(max) NULL, 
  LoVKey          varchar(255) NULL, 
  IsActive        bit DEFAULT '1' NOT NULL, 
  IsDerived       bit DEFAULT '0' NOT NULL, 
  ValidationRule  varchar(max) NULL, 
  VAddedID        int NULL, 
  VRemoved        int NULL, 
  CONSTRAINT PK_ATTTMP 
    PRIMARY KEY (DataAttributeID), 
  CONSTRAINT UnTemp 
    UNIQUE (Category, AttributeName));
CREATE TABLE dbo.UTP_DependantAttribute (
  UTP_DependantAttributeID bigint identity NOT NULL, 
  JobCodeAttributeID       bigint NOT NULL, 
  DependantAttributeID     bigint NOT NULL, 
  AttributeValue           varchar(255) NULL, 
  OverrideValue            bit DEFAULT '0' NULL, 
  DefaultValue             varchar(255) NULL);
CREATE TABLE dbo.UTP_DerivedAttribute (
  DerivedAttributeID int IDENTITY(1, 1) NOT NULL, 
  [Case]             varchar(255) NULL, 
  Formula            varchar(max) NULL, 
  CONSTRAINT PK_DRATT 
    PRIMARY KEY (DerivedAttributeID));
CREATE TABLE dbo.UTP_Document (
  DocumentID           int IDENTITY(1, 1) NOT NULL, 
  DocumentRepositoryID int NOT NULL, 
  DocumentTypeID       int NOT NULL, 
  CreatedTimestamp     datetime NOT NULL, 
  OrigFilename         varchar(255) NOT NULL, 
  CreatedById          int NULL, 
  AccessedTimestamp    datetime NULL, 
  SourceID             int NULL, 
  Filename             varchar(255) NULL, 
  Filetype             varchar(32) NULL, 
  [Size]               int NULL, 
  CONSTRAINT PK__UTP_Docu__1ABEEF6F7D4F0207 
    PRIMARY KEY (DocumentID));
CREATE TABLE dbo.UTP_DocumentStorage (
  DocumentStorageID int IDENTITY(1, 1) NOT NULL, 
  DocumentTypeID    int NOT NULL, 
  OrgID             int NULL, 
  RootFolder        varchar(255) NOT NULL, 
  DestinationFolder varchar(255) NULL, 
  CONSTRAINT PK__UTP_Docu__7381F3418DA44E9E 
    PRIMARY KEY (DocumentStorageID));
CREATE TABLE dbo.UTP_EmailHistory (
  EmailHistoryID            bigint IDENTITY(1, 1) NOT NULL, 
  EmailRecipient            varchar(200) NOT NULL, 
  Subject                   varchar(max) NULL, 
  Body                      varchar(max) NULL, 
  FromAddress               varchar(200) NOT NULL, 
  FromFriendlyName          varchar(200) NULL, 
  OrderID                   int NULL, 
  EmailTypeID               int NULL, 
  CreatedInQueueTimestamp   datetime NULL, 
  CreatedInHistoryTimestamp datetime NULL, 
  SendAttempts              int NULL, 
  CONSTRAINT PK_UTP_EmailHistory 
    PRIMARY KEY (EmailHistoryID));
CREATE TABLE dbo.UTP_EmailRecipients (
  EmailRecipient varchar(200) NOT NULL, 
  ListName       varchar(255) NULL, 
  Comment        varchar(255) NULL, 
  CONSTRAINT UN_RECLIST 
    UNIQUE (EmailRecipient, ListName));
CREATE TABLE dbo.UTP_Entity (
  EntityID      int IDENTITY(1, 1) NOT NULL, 
  EntityeTypeID int NULL, 
  EntityName    varchar(255) NOT NULL, 
  VAddedID      int NULL, 
  VRemovedID    int NULL, 
  CONSTRAINT PK_ENT 
    PRIMARY KEY (EntityID));
CREATE TABLE dbo.UTP_EntityAttribute (
  EntityAttributeID int IDENTITY(1, 1) NOT NULL, 
  EntityID          int NOT NULL, 
  DataAttributeID   int NOT NULL, 
  VAddedID          int NULL, 
  VRemovedID        int NULL, 
  CONSTRAINT PK__UTP_Enti__45B7C83BBA030A97 
    PRIMARY KEY (EntityAttributeID));
CREATE TABLE dbo.UTP_Grid (
  GridID   int IDENTITY(1, 1) NOT NULL, 
  GridCode varchar(10) NOT NULL, 
  CONSTRAINT PK_UTP_Grid 
    PRIMARY KEY (GridID));
CREATE TABLE dbo.UTP_Group (
  GroupID          int IDENTITY(1, 1) NOT NULL, 
  GroupCode        varchar(255) NULL, 
  GroupName        varchar(255) NULL, 
  GroupTypeID      int NOT NULL, 
  IsActive         int DEFAULT 1 NULL, 
  GroupManagerID   int NULL, 
  ParentGroupID    int NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CreateByID       int NULL, 
  CONSTRAINT PK__UTP_Grou__149AF30A49E21F57 
    PRIMARY KEY (GroupID));
CREATE TABLE dbo.UTP_GroupMember (
  GroupMemberID int IDENTITY(1, 1) NOT NULL, 
  MemberID      int NOT NULL, 
  GroupID       int NULL, 
  JobTitleID    int NOT NULL, 
  IsActive      int DEFAULT 1 NULL, 
  CONSTRAINT PK__UTP_Grou__344812B2F1BD0652 
    PRIMARY KEY (GroupMemberID));
CREATE TABLE dbo.UTP_HTML (
  HTMLID   int IDENTITY(1, 1) NOT NULL, 
  [key]    varchar(255) NOT NULL, 
  value    varchar(max) NOT NULL, 
  comments varchar(255) NULL, 
  CONSTRAINT PK_HTML 
    PRIMARY KEY (HTMLID));
CREATE TABLE dbo.UTP_ImportBatch (
  ImportBatchID      int IDENTITY(1, 1) NOT NULL, 
  ImportTemplateID   int NOT NULL, 
  BatchStatusID      int NOT NULL, 
  ExcludeFromCleanup bit NOT NULL, 
  CreatedByID        int NOT NULL, 
  AtUserID           int NULL, 
  CreatedTimestamp   datetime NOT NULL, 
  CompletedTimestamp datetime NULL, 
  Filename           varchar(255) NULL, 
  FileURL            varchar(1000) NULL, 
  ObjectSpec         varchar(1000) NULL, 
  ContractID         bigint NULL, 
  OrgID              int NULL, 
  CONSTRAINT PK_UTP_ImportBatch 
    PRIMARY KEY (ImportBatchID));
CREATE TABLE dbo.UTP_ImportData (
  ImportDataID   int IDENTITY(1, 1) NOT NULL, 
  ImportBatchID  int NOT NULL, 
  ImportStatusID int NOT NULL, 
  ErrorMessage   varchar(max) NULL, 
  Col1           varchar(max) NULL, 
  Col2           varchar(max) NULL, 
  Col3           varchar(max) NULL, 
  Col4           varchar(max) NULL, 
  Col5           varchar(max) NULL, 
  Col6           varchar(max) NULL, 
  Col7           varchar(max) NULL, 
  Col8           varchar(max) NULL, 
  Col9           varchar(max) NULL, 
  Col10          varchar(max) NULL, 
  Col11          varchar(max) NULL, 
  Col12          varchar(max) NULL, 
  Col13          varchar(max) NULL, 
  Col14          varchar(max) NULL, 
  Col15          varchar(max) NULL, 
  Col16          varchar(max) NULL, 
  Col17          varchar(max) NULL, 
  Col18          varchar(max) NULL, 
  Col19          varchar(max) NULL, 
  Col20          varchar(max) NULL, 
  Col21          varchar(max) NULL, 
  Col22          varchar(max) NULL, 
  Col23          varchar(max) NULL, 
  Col24          varchar(max) NULL, 
  Col25          varchar(max) NULL, 
  Col26          varchar(max) NULL, 
  Col27          varchar(max) NULL, 
  Col28          varchar(max) NULL, 
  Col29          varchar(max) NULL, 
  Col30          varchar(max) NULL, 
  Col31          varchar(max) NULL, 
  Col32          varchar(max) NULL, 
  Col33          varchar(max) NULL, 
  Col34          varchar(max) NULL, 
  Col35          varchar(max) NULL, 
  Col36          varchar(max) NULL, 
  Col37          varchar(max) NULL, 
  Col38          varchar(max) NULL, 
  Col39          varchar(max) NULL, 
  Col40          varchar(max) NULL, 
  Col41          varchar(max) NULL, 
  Col42          varchar(max) NULL, 
  Col43          varchar(max) NULL, 
  Col44          varchar(max) NULL, 
  Col45          varchar(max) NULL, 
  Col46          varchar(max) NULL, 
  Col47          varchar(max) NULL, 
  Col48          varchar(max) NULL, 
  Col49          varchar(max) NULL, 
  Col50          varchar(max) NULL, 
  Col51          varchar(max) NULL, 
  Col52          varchar(max) NULL, 
  Col53          varchar(max) NULL, 
  Col54          varchar(max) NULL, 
  Col55          varchar(max) NULL, 
  Col56          varchar(max) NULL, 
  Col57          varchar(max) NULL, 
  Col58          varchar(max) NULL, 
  Col59          varchar(max) NULL, 
  Col60          varchar(max) NULL, 
  CONSTRAINT PK_UTP_ImportData 
    PRIMARY KEY (ImportDataID));
CREATE TABLE dbo.UTP_ImportHeader (
  ImportHeaderID int IDENTITY(1, 1) NOT NULL, 
  ImportBatchID  int NOT NULL, 
  Col1           varchar(max) NULL, 
  Col2           varchar(max) NULL, 
  Col3           varchar(max) NULL, 
  Col4           varchar(max) NULL, 
  Col5           varchar(max) NULL, 
  Col6           varchar(max) NULL, 
  Col7           varchar(max) NULL, 
  Col8           varchar(max) NULL, 
  Col9           varchar(max) NULL, 
  Col10          varchar(max) NULL, 
  Col11          varchar(max) NULL, 
  Col12          varchar(max) NULL, 
  Col13          varchar(max) NULL, 
  Col14          varchar(max) NULL, 
  Col15          varchar(max) NULL, 
  Col16          varchar(max) NULL, 
  Col17          varchar(max) NULL, 
  Col18          varchar(max) NULL, 
  Col19          varchar(max) NULL, 
  Col20          varchar(max) NULL, 
  Col21          varchar(max) NULL, 
  Col22          varchar(max) NULL, 
  Col23          varchar(max) NULL, 
  Col24          varchar(max) NULL, 
  Col25          varchar(max) NULL, 
  Col26          varchar(max) NULL, 
  Col27          varchar(max) NULL, 
  Col28          varchar(max) NULL, 
  Col29          varchar(max) NULL, 
  Col30          varchar(max) NULL, 
  Col31          varchar(max) NULL, 
  Col32          varchar(max) NULL, 
  Col33          varchar(max) NULL, 
  Col34          varchar(max) NULL, 
  Col35          varchar(max) NULL, 
  Col36          varchar(max) NULL, 
  Col37          varchar(max) NULL, 
  Col38          varchar(max) NULL, 
  Col39          varchar(max) NULL, 
  Col40          varchar(max) NULL, 
  Col41          varchar(max) NULL, 
  Col42          varchar(max) NULL, 
  Col43          varchar(max) NULL, 
  Col44          varchar(max) NULL, 
  Col45          varchar(max) NULL, 
  Col46          varchar(max) NULL, 
  Col47          varchar(max) NULL, 
  Col48          varchar(max) NULL, 
  Col49          varchar(max) NULL, 
  Col50          varchar(max) NULL, 
  Col51          varchar(max) NULL, 
  Col52          varchar(max) NULL, 
  Col53          varchar(max) NULL, 
  Col54          varchar(max) NULL, 
  Col55          varchar(max) NULL, 
  Col56          varchar(max) NULL, 
  Col57          varchar(max) NULL, 
  Col58          varchar(max) NULL, 
  Col59          varchar(max) NULL, 
  Col60          varchar(max) NULL, 
  CONSTRAINT PK_UTP_ImportHeader 
    PRIMARY KEY (ImportHeaderID));
CREATE TABLE dbo.UTP_ImportMap (
  ImportMapID      int IDENTITY(1, 1) NOT NULL, 
  ImportTemplateID int NOT NULL, 
  MappingIndex     int NOT NULL, 
  ParameterName    varchar(255) NULL, 
  ParameterValue   varchar(255) NULL, 
  CONSTRAINT PK_UTP_ImportMap 
    PRIMARY KEY (ImportMapID));
CREATE TABLE dbo.UTP_ImportTemplate (
  ImportTemplateID   int IDENTITY(1, 1) NOT NULL, 
  ImportObjectID     int NOT NULL, 
  ImportTypeID       int NOT NULL, 
  ScopeID            int NOT NULL, 
  CreatedByID        int NOT NULL, 
  CreatedTimestamp   datetime NOT NULL, 
  ImportTemplateName varchar(255) NOT NULL, 
  HasHeaders         bit NOT NULL, 
  CONSTRAINT PK_UTP_ImportTemplate 
    PRIMARY KEY (ImportTemplateID));
CREATE TABLE dbo.UTP_JobHistory (
  JobHistoryID      int identity NOT NULL, 
  PersonID          int NULL, 
  JobTitleID        int NULL, 
  EffectiveFromDate datetime NULL, 
  EffectiveToDate   datetime NULL);
CREATE TABLE dbo.UTP_JobTestReq (
  JobTestReqID      int identity NOT NULL, 
  JobTitleID        int NULL, 
  TestID            int NULL, 
  EffectiveFromDate datetime NULL, 
  EffectiveToDate   datetime NULL);
CREATE TABLE dbo.UTP_JobTitle (
  JobTitleID     int IDENTITY(1, 1) NOT NULL, 
  JobTitle       varchar(255) NULL, 
  JobDescription varchar(255) NULL, 
  IsActive       int NULL, 
  CONSTRAINT PK__UTP_JobT__35382FC92BA244FB 
    PRIMARY KEY (JobTitleID));
CREATE TABLE dbo.UTP_ListMaster (
  ListID     int IDENTITY(0, 0) NOT NULL, 
  ListKey    varchar(255) NOT NULL, 
  ListValue  varchar(255) NOT NULL, 
  ListText   varchar(255) NULL, 
  HelpText   varchar(2000) NULL, 
  IsActive   bit DEFAULT '1' NOT NULL, 
  IsDefault  bit DEFAULT '0' NOT NULL, 
  SortOrder  int NULL, 
  LoVKey     int NULL, 
  LanguageID int NULL, 
  VAddedID   int NULL, 
  VRemoved   int NULL, 
  VNotes     varchar(max) NULL, 
  CONSTRAINT PK__UTP_List__E38328650C48BAE0 
    PRIMARY KEY (ListID), 
  CONSTRAINT UnLMLV 
    UNIQUE (ListKey, ListValue), 
  CONSTRAINT UnLMLT 
    UNIQUE (ListKey, ListText));
CREATE TABLE dbo.UTP_Location (
  LocationID     int identity NOT NULL, 
  GroupID        int NULL, 
  LocationTypeID int NULL, 
  Location       varchar(255) NULL, 
  StartDate      datetime NULL, 
  EndDate        datetime NULL);
CREATE TABLE dbo.UTP_MessageSwitch (
  MessageSwitchID int IDENTITY(1, 1) NOT NULL, 
  Message         varchar(64) NOT NULL, 
  Location        varchar(64) NOT NULL, 
  Blocked         bit DEFAULT '0' NOT NULL, 
  CONSTRAINT PK__UTP_Mess__911D86CBAC6584BA 
    PRIMARY KEY (MessageSwitchID));
CREATE TABLE dbo.UTP_Order (
  OrderID          int IDENTITY(1, 1) NOT NULL, 
  OrgID            int NOT NULL, 
  OrderTypeID      int DEFAULT 0 NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CreateByID       int NULL, 
  ContractID       bigint NULL, 
  CONSTRAINT PK__UTP_Orde__C3905BAFBB8A465E 
    PRIMARY KEY (OrderID));
CREATE TABLE dbo.UTP_OrderAddress (
  OrderAddressID int IDENTITY(1, 1) NOT NULL, 
  OrderID        int NOT NULL, 
  AddressID      int NOT NULL, 
  AddressTypeID  int NOT NULL, 
  CONSTRAINT PK__UTP_Orde__34B754C5247976EE 
    PRIMARY KEY (OrderAddressID));
CREATE TABLE dbo.UTP_OrderAttachment (
  OrderID    int NOT NULL, 
  DocumentID int NOT NULL);
CREATE TABLE dbo.UTP_OrderAttribute (
  OrderAttributeID int IDENTITY(1, 1) NOT NULL, 
  OrderID          int NOT NULL, 
  DataAttributeID  int NULL, 
  AppointmentID    int NULL, 
  AttributeValue   varchar(255) NULL, 
  ProductNumber    varchar(25) NULL, 
  CONSTRAINT PK_OrderAttribute 
    PRIMARY KEY (OrderAttributeID));
CREATE TABLE dbo.UTP_OrderHistory (
  OrderHistoryID   int IDENTITY(1, 1) NOT NULL, 
  OrderID          int NOT NULL, 
  MemoTypeID       int NOT NULL, 
  Memo             varchar(max) NULL, 
  CreatedByID      int NOT NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NOT NULL, 
  TechnicianID     int NULL, 
  OrderStatusCode  varchar(50) NULL, 
  StatusTimestamp  datetime NULL, 
  CONSTRAINT PK_OrderHistory 
    PRIMARY KEY (OrderHistoryID));
CREATE TABLE dbo.UTP_OrderJobCard (
  OrderJobCardID       int IDENTITY(1, 1) NOT NULL, 
  DocumentID           int NOT NULL, 
  JobcardLine          int NOT NULL, 
  Technician           varchar(50) NULL, 
  TechnicianID         int NULL, 
  WONUM                varchar(15) NULL, 
  OrderID              int NULL, 
  CreatedByID          int NULL, 
  CreatedTimestamp     datetime DEFAULT (getdate()) NOT NULL, 
  ReviewedByID         int NULL, 
  ReviewedTimestamp    datetime NULL, 
  DataEntryStatusID    int NULL, 
  CompletionDateOnCard datetime NULL, 
  JobCardMemo          varchar(max) NULL, 
  JobCardTypeID        int NULL, 
  CONSTRAINT PK__UTP_Orde__C50E6279E4C7968A 
    PRIMARY KEY (OrderJobCardID));
CREATE TABLE dbo.UTP_Org (
  OrgID            int IDENTITY(1, 1) NOT NULL, 
  Name             varchar(255) NOT NULL, 
  ShortName        varchar(50) NOT NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CreateByID       int NULL, 
  WONUM_Prefix     varchar(5) NULL, 
  CatalogID        int NULL, 
  CONSTRAINT PK__UTP_Org__420C9E0C14A3942A 
    PRIMARY KEY (OrgID), 
  CONSTRAINT UN_UTPORG_SN 
    UNIQUE (ShortName), 
  CONSTRAINT UN_UTPORG_NM 
    UNIQUE (Name));
CREATE TABLE dbo.UTP_OrgAddress (
  OrgAddressID  int IDENTITY(1, 1) NOT NULL, 
  OrgID         int NOT NULL, 
  AddressID     int NOT NULL, 
  AddressTypeID int NOT NULL, 
  CONSTRAINT PK__UTP_OrgA__BA2555B720987C27 
    PRIMARY KEY (OrgAddressID));
CREATE TABLE dbo.UTP_OrgAttribute (
  OrgAttributeID  int IDENTITY(1, 1) NOT NULL, 
  OrgID           int NOT NULL, 
  DataAttributeID int NOT NULL, 
  IsOptional      bit DEFAULT '0' NOT NULL, 
  IsReadOnly      bit DEFAULT '0' NOT NULL, 
  CONSTRAINT PK__UTP_OrgA__76A144E62C92B38D 
    PRIMARY KEY (OrgAttributeID));
CREATE TABLE dbo.UTP_OrgPermission (
  OrgPermissionID int IDENTITY(1, 1) NOT NULL, 
  OrgID           int NOT NULL, 
  UserID          int NULL, 
  [View]          bit NOT NULL, 
  [Add]           bit NOT NULL, 
  Edit            bit NOT NULL, 
  [Delete]        bit NOT NULL, 
  Duplicate       bit NOT NULL, 
  Submit          bit NOT NULL, 
  CONSTRAINT PK__UTP_OrgP__53C559EE4987B9EE 
    PRIMARY KEY (OrgPermissionID));
CREATE TABLE dbo.UTP_Personnel (
  PersonnelID int IDENTITY(1, 1) NOT NULL, 
  PersonID    int NOT NULL, 
  OrgID       int NOT NULL, 
  CONSTRAINT PK__UTP_Pers__CAFBCB6F5142A0FD 
    PRIMARY KEY (PersonnelID));
CREATE TABLE dbo.UTP_PhoneEmail (
  PhoneEmailID int IDENTITY(1, 1) NOT NULL, 
  CellPhone    varchar(20) NULL, 
  Pager        varchar(20) NULL, 
  HomePhone    varchar(20) NULL, 
  OfficePhone  varchar(20) NULL, 
  Email        varchar(50) DEFAULT '*' NOT NULL, 
  CONSTRAINT PK__UTP_Phon__1A96C8E0D8D67784 
    PRIMARY KEY (PhoneEmailID));
CREATE TABLE dbo.UTP_PODetail (
  PODetailID int IDENTITY(1, 1) NOT NULL, 
  OrderID    int NOT NULL, 
  CONSTRAINT PK__UTP_PODe__4EB47B5EFD88F16E 
    PRIMARY KEY (PODetailID));
CREATE TABLE dbo.UTP_ProductMaster (
  ProductID          int IDENTITY(1, 1) NOT NULL, 
  ProductNumber      varchar(20) NOT NULL, 
  ProductDescription varchar(255) NULL, 
  CONSTRAINT PK__UTP_Prod__B40CC6ED1BDB0759 
    PRIMARY KEY (ProductID));
CREATE TABLE dbo.UTP_Provider (
  ProviderID int IDENTITY(1, 1) NOT NULL, 
  OrgID      int NOT NULL, 
  CONSTRAINT PK__UTP_Prov__B54C689DC04D8311 
    PRIMARY KEY (ProviderID));
CREATE TABLE dbo.UTP_Report (
  ReportID         int IDENTITY(1, 1) NOT NULL, 
  UserID           int NULL, 
  ReportName       varchar(255) NULL, 
  ReportTypeID     int NULL, 
  ConnectionString varchar(255) NULL, 
  SqlStatement     varchar(max) NULL, 
  StatementTypeID  int NULL, 
  ReportDefinition varchar(max) NULL, 
  CONSTRAINT PK_UTP_Report 
    PRIMARY KEY (ReportID));
CREATE TABLE dbo.UTP_ReportParameter (
  ReportParameterID    int IDENTITY(1, 1) NOT NULL, 
  ReportID             int NOT NULL, 
  ReportParameter      varchar(255) NOT NULL, 
  ReportParameterValue varchar(255) NULL, 
  CONSTRAINT PK_UTP_ReportParameter 
    PRIMARY KEY (ReportParameterID));
CREATE TABLE dbo.UTP_RunAtQ (
  RunAtQID      int IDENTITY(1, 1) NOT NULL, 
  ImportBatchID int NOT NULL, 
  Attributes    varchar(5000) NULL, 
  CONSTRAINT PK_RunAtQ 
    PRIMARY KEY (RunAtQID));
CREATE TABLE dbo.UTP_SmsHistory (
  SmsHistoryID              bigint IDENTITY(1, 1) NOT NULL, 
  DestinationPhoneNumber    varchar(20) NOT NULL, 
  Body                      varchar(max) NULL, 
  OrderID                   int NULL, 
  SmsTypeID                 int NULL, 
  CreatedInQueueTimestamp   datetime NULL, 
  CreatedInHistoryTimestamp datetime NULL, 
  SendAttempts              int NULL, 
  CONSTRAINT PK_UTP_SmsHistory 
    PRIMARY KEY (SmsHistoryID));
CREATE TABLE dbo.UTP_Spec (
  SpecID          int IDENTITY(1, 1) NOT NULL, 
  OrderID         int NOT NULL, 
  DataAttributeID int NOT NULL, 
  ProductID       int NULL, 
  AttributeValue  varchar(255) NULL, 
  SpecTypeID      int NULL, 
  IsRequired      bit NULL, 
  IsReadony       bit NULL, 
  AttributeName   varchar(max) NULL, 
  AppointmentID   bigint NULL, 
  CONSTRAINT PK__UTP_Spec__883D519B8D75BAF2 
    PRIMARY KEY (SpecID));
CREATE TABLE dbo.UTP_Task (
  TaskID            int identity NOT NULL, 
  TaskTypeID        int NULL, 
  TaskNumber        varchar(50) NULL, 
  TaskDescription   varchar(500) NULL, 
  TaskStatusID      int NULL, 
  TaskPriorityID    int NULL, 
  DueDate           datetime NULL, 
  CreatedTimestamp  datetime DEFAULT (getdate()) NULL, 
  CreatedByID       int NULL, 
  TaskManagerID     int NULL, 
  Category          varchar(50) NULL, 
  Scope             varchar(50) NULL, 
  ProjectNumber     varchar(50) NULL, 
  RaisedDate        datetime NULL, 
  RaisedBy          varchar(50) NULL, 
  TargetStart       datetime NULL, 
  TargetFinish      datetime NULL, 
  AssignedToID      int NULL, 
  AssignedDate      datetime NULL, 
  ActualStart       datetime NULL, 
  ActualFinish      datetime NULL, 
  CompletedByID     int NULL, 
  CompletionCode    varchar(20) NULL, 
  EstimatedDuration real NULL, 
  ActualDuration    real NULL, 
  Instructions      varchar(max) NULL, 
  Notes             varchar(max) NULL, 
  FollowupDate      datetime NULL, 
  FollowupAction    varchar(255) NULL, 
  FollowupFreqID    int NULL, 
  CostCenter        varchar(20) NULL);
CREATE TABLE dbo.UTP_TaskAttachment (
  TaskID           int NULL, 
  DocumentID       int NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CreatedByID      int NULL);
CREATE TABLE dbo.UTP_TaskAttribute (
  TaskID           int NULL, 
  DataAttributeID  int NULL, 
  AttributeName    varchar(255) NULL, 
  AttributeValue   varchar(255) NULL, 
  IsRequired       bit NULL, 
  IsReadonly       bit NULL, 
  LoVKey           varchar(255) NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CreatedByID      int NULL);
CREATE TABLE dbo.UTP_TaskHistory (
  TaskHistoryID    int identity NOT NULL, 
  TaskID           int NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CreatedByID      int NULL, 
  Memo             varchar(max) NULL, 
  MemoTypeID       int NULL, 
  AssignedToID     int NULL, 
  ActualDuration   real NULL);
CREATE TABLE dbo.UTP_TaskType (
  TaskTypeID          int NULL, 
  TaskType            varchar(255) NULL, 
  TaskTypeDescription varchar(255) NULL);
CREATE TABLE dbo.UTP_Test (
  TestID             int identity NOT NULL, 
  TestCode           varchar(50) NULL, 
  TestTitle          varchar(255) NULL, 
  TestDescription    varchar(255) NULL, 
  TestRevision       varchar(10) NULL, 
  TotalMarks         float(53) NULL, 
  PassingMark        float(53) NULL, 
  ExpectedDuration   float(53) NULL, 
  RenewalFrequencyID int NULL, 
  IsActive           bit NULL, 
  TestStatusID       int NULL);
CREATE TABLE dbo.UTP_User (
  UserID           int IDENTITY(1, 1) NOT NULL, 
  PersonID         int NOT NULL, 
  UserTypeID       int NOT NULL, 
  UserName         varchar(50) NOT NULL, 
  Password         varchar(50) NOT NULL, 
  IsActive         bit DEFAULT '1' NULL, 
  CreatedTimestamp datetime DEFAULT (getdate()) NULL, 
  CreateByID       int NULL, 
  DomainUserID     varchar(50) NULL, 
  CONSTRAINT PK__UTP_User__1788CCACA86A6DBE 
    PRIMARY KEY (UserID), 
  CONSTRAINT UnUserName 
    UNIQUE (UserName));
CREATE TABLE dbo.UTP_UserColumn (
  UserColumnID  int IDENTITY(1, 1) NOT NULL, 
  UserID        int NOT NULL, 
  PanelColumnID int NOT NULL, 
  SortOrder     int NULL, 
  IsHidden      bit NULL, 
  IsFrozen      bit NULL, 
  ColumnWidth   int NULL, 
  CONSTRAINT PK__UTP_User__7D9569CA8CC5AA3D 
    PRIMARY KEY (UserColumnID));
CREATE TABLE dbo.UTP_UserPermission (
  UserPermissionID int IDENTITY(1, 1) NOT NULL, 
  UserID           int NOT NULL, 
  PermissionID     int NOT NULL, 
  IsEnabled        bit NOT NULL, 
  CONSTRAINT PK_UserPermission 
    PRIMARY KEY (UserPermissionID));
CREATE TABLE dbo.UTP_UserPreference (
  UserPreferenceID int IDENTITY(1, 1) NOT NULL, 
  UserID           int NOT NULL, 
  DataAttributeID  int NULL, 
  AttributeName    varchar(255) NULL, 
  AttributeValue   varchar(255) NULL, 
  CONSTRAINT PK_UserPreference 
    PRIMARY KEY (UserPreferenceID));
CREATE TABLE dbo.UTP_UserSession (
  UserSessionID         int IDENTITY(1, 1) NOT NULL, 
  UserID                int NOT NULL, 
  SessionStartTimestamp datetime DEFAULT (getdate()) NOT NULL, 
  SessionEndTimestamp   datetime NULL, 
  Action                varchar(255) NULL, 
  CONSTRAINT PK_UTP_UserSession 
    PRIMARY KEY (UserSessionID));
CREATE TABLE dbo.UTP_Version (
  VersionID     int IDENTITY(1, 1) NOT NULL, 
  DateInstalled datetime NULL, 
  VName         varchar(255) NOT NULL, 
  VNumbers      varchar(255) NOT NULL, 
  VNotes        varchar(max) NULL, 
  CONSTRAINT PK_VERS 
    PRIMARY KEY (VersionID));
CREATE TABLE dbo.UTP_WOInvoiceNote (
  InvoiceID      int NULL, 
  InvoiceLineID  int NULL, 
  OrderHistoryID int NULL);
CREATE TABLE dbo.UTP_WorkSchedule (
  WorkScheduleID  int IDENTITY(1, 1) NOT NULL, 
  UserID          int NULL, 
  WorkDate        date NOT NULL, 
  TimeSlotID      int NOT NULL, 
  GroupID         int NULL, 
  Capacity        int NULL, 
  ScheduleTypeID  int NULL, 
  TimeOffReasonID int NULL, 
  CONSTRAINT PK_WKSC 
    PRIMARY KEY (WorkScheduleID));
CREATE TABLE dbo.UTP_WOSearch (
  WOSearchID          int IDENTITY(1, 1) NOT NULL, 
  CreatedByID         int NULL, 
  CreatedTimestamp    datetime DEFAULT (getdate()) NULL, 
  OrderID             varchar(255) NULL, 
  WOID                varchar(255) NULL, 
  WONUM               varchar(max) NULL, 
  JobCodeID           varchar(255) NULL, 
  WorkType            varchar(255) NULL, 
  Subtype             varchar(255) NULL, 
  JobPlan             varchar(10) NULL, 
  GroupID             varchar(255) NULL, 
  GridID              varchar(255) NULL, 
  DisplayAddress      varchar(400) NULL, 
  Street              varchar(50) NULL, 
  Town                varchar(50) NULL, 
  PostCode            varchar(8) NULL, 
  StartDate           varchar(10) NULL, 
  DueDate             varchar(10) NULL, 
  WMStatusID          varchar(255) NULL, 
  DispatcherID        varchar(255) NULL, 
  TechnicianID        varchar(255) NULL, 
  CompletionDate      varchar(10) NULL, 
  CompletionCode      varchar(30) NULL, 
  AppointmentID       varchar(255) NULL, 
  AppointmentStatusID varchar(255) NULL, 
  AppointmentTypeID   varchar(255) NULL, 
  TimeslotID          varchar(255) NULL, 
  AppointmentDate     varchar(10) NULL, 
  CONSTRAINT PK_UTP_WOSearch 
    PRIMARY KEY (WOSearchID));
CREATE TABLE dbo.UTP_WOStructure (
  PrimaryOrderID int NOT NULL, 
  RelatedOrderID int NOT NULL, 
  RelationTypeID int NOT NULL);
CREATE TABLE dbo.UTP_Person (
  PersonID              int IDENTITY(1, 1) NOT NULL, 
  PersonTypeID          int NOT NULL, 
  FirstName             varchar(255) NOT NULL, 
  LastName              varchar(255) NOT NULL, 
  Description           varchar(50) DEFAULT '' NOT NULL, 
  PhoneEmailID          int NULL, 
  BusinessName          varchar(40) NULL, 
  IsActive              bit DEFAULT '1' NULL, 
  CreatedByID           int NULL, 
  CreatedTimestamp      datetime DEFAULT (getdate()) NULL, 
  LastModifiedByID      int NULL, 
  LastModifiedTimestamp datetime NULL, 
  CreateByID            int NULL, 
  CONSTRAINT PK__UTP_Pers__AA2FFB85D2F490E5 
    PRIMARY KEY (PersonID));
CREATE TABLE dbo.UTP_Technician (
  TechnicianID      int IDENTITY(1, 1) NOT NULL, 
  UserID            int NOT NULL, 
  TechnicianTypeID  int NOT NULL, 
  GSTNo             varchar(20) NULL, 
  PerformanceFactor int DEFAULT 0 NOT NULL, 
  Comments          varchar(50) NULL, 
  InsuranceNum      varchar(50) NULL, 
  InsuranceExpDate  datetime NULL, 
  LicenceNum        varchar(50) NULL, 
  LicenceExpDate    datetime NULL, 
  HasHandHeld       bit DEFAULT '0' NULL, 
  CONSTRAINT PK_UTP_Technician 
    PRIMARY KEY (TechnicianID));
CREATE TABLE dbo.UTP_WO (
  uWOID            int IDENTITY(1, 1) NOT NULL, 
  OrderID          int NOT NULL, 
  WONUM            varchar(15) NOT NULL, 
  JobCodeID        int NOT NULL, 
  AreaID           int NULL, 
  DueDate          datetime NULL, 
  WMStatusID       int NULL, 
  DispatcherID     int NULL, 
  TechnicianID     int NULL, 
  CompletionCode   varchar(10) NULL, 
  ActualStart      datetime NULL, 
  ActualFinish     datetime NULL, 
  Grid             varchar(20) NULL, 
  WONotes          varchar(max) NULL, 
  WODescription    varchar(255) NULL, 
  PersonID         int NULL, 
  SubmitStatusID   int NULL, 
  TransmitStatusID int NULL, 
  ServiceAddress   varchar(400) NULL, 
  CONSTRAINT PK__UTP_WO__91A21BC9A911BD81 
    PRIMARY KEY (uWOID), 
  CONSTRAINT UN_UWO_OrderID 
    UNIQUE (OrderID));
CREATE TABLE resources (
  id            int IDENTITY NOT NULL, 
  resource_type int NOT NULL, 
  work_area_id  int NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE job (
  id                     int IDENTITY NOT NULL, 
  job_type_id            int NOT NULL, 
  status_id              int NOT NULL, 
  estimated_time_minutes int NOT NULL, 
  work_order_id          int NOT NULL, 
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
  PRIMARY KEY (id));
CREATE TABLE work_order (
  id                     int IDENTITY NOT NULL, 
  minimum_start_time     timestamp NOT NULL, 
  maximum_start_time     timestamp NOT NULL, 
  priority               int NOT NULL, 
  work_area_id           int NOT NULL, 
  status_id              int NOT NULL, 
  address                varchar(255) NULL, 
  postal_code            varchar(8) NULL, 
  estimated_time_minutes int NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE skill (
  id          int IDENTITY NOT NULL, 
  name        varchar(50) NOT NULL, 
  description varchar(255) NULL, 
  PRIMARY KEY (id));
CREATE TABLE WorkOrderJobs (
  workOrderId int NOT NULL, 
  jobId       int NOT NULL, 
  created_at  int NULL, 
  modified_at int NULL);
CREATE TABLE job_types (
  id          int IDENTITY NOT NULL, 
  name        varchar(100) NOT NULL, 
  description varchar(255) NULL, 
  PRIMARY KEY (id));
CREATE TABLE work_area (
  id          int IDENTITY NOT NULL, 
  province    varchar(75) NOT NULL, 
  country     varchar(50) NOT NULL, 
  region      varchar(75) NOT NULL, 
  description varchar(255) NULL, 
  CONSTRAINT pk_work_area_id 
    PRIMARY KEY (id));
CREATE TABLE resource_type (
  id          int IDENTITY NOT NULL, 
  name        varchar(50) NOT NULL, 
  description varchar(255) NULL, 
  PRIMARY KEY (id));
CREATE TABLE technician_type (
  id          int IDENTITY NOT NULL, 
  name        varchar(100) NOT NULL, 
  description varchar(255) NULL, 
  PRIMARY KEY (id));
CREATE TABLE status (
  id             int IDENTITY NOT NULL, 
  name           varchar(25) NOT NULL, 
  description    varchar(255) NULL, 
  job_crewjobid  int NOT NULL, 
  job_crewcrewid int NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE technician_skills (
  technician_id int NOT NULL, 
  skills_id     int NOT NULL, 
  skill_rating  int NULL, 
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
  jobid      int NOT NULL, 
  crewid     int NOT NULL, 
  start_time timestamp NOT NULL, 
  end_time   timestamp NULL, 
  status_id  int NOT NULL, 
  PRIMARY KEY (jobid, 
  crewid));
GO






-- CREATED on 3-April-2018 - JLM
CREATE VIEW [dbo].[vw_Atlantis_WO] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = Org.ShortName,
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID] = uw.uWOID,
		[WONUM] = uw.WONUM,
		[JobCodeID] = uw.JobCodeID,
		--JobCode = isnull(ewt.ListValue,xda.JobType) + ' / ' + isnull(est.ListValue,xda.JobCode) + case when isnull(ew.JPNUM,'') = '' then '' else ' / ' + isnull(ew.JPNUM,'') end,
		WorkType = xda.JobType,
		--Subtype = isnull(est.ListValue,xda.JobCode),
		JobPlan = '',
		[GroupID] = ug.GroupID,
		[GroupName] = ug.GroupCode,  -- temp, update procs and datasets to include GroupCorde then change back 
		[GroupCode] = ug.GroupCode,
		[GridID] = 0,
		[Grid] = uw.Grid,
		[FullAddress] = isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
								+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
								+ case when isnull(addr.Misc,'') <> '' then ', Unit ' + isnull(REPLACE(addr.Misc,'Unit',''),'') else '' end 
								+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,''),
		[DisplayAddress] = isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
								+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
								+ case when isnull(addr.Misc,'') <> '' then ', Unit ' + isnull(REPLACE(addr.Misc,'Unit',''),'') else '' end 
								+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,''),
		[StreetNo] = addr.StreetNo,
		[Unit] = [Misc],
		[Street] = [Street],
		[Town] = [Town],
		[PostalCode] = addr.PostalCode,
		Misc = addr.Misc,
		Sfx = addr.Sfx,
		ProvinceCode = addr.ProvinceCode,
		ReportedAt = NULL,
		ReportedBy = NULL,
		DueDate, 
		UtilityComment = uw.WONotes,
		IsFirmAppt = cast(0 as bit),
		ApptStartDate = a.ApptStartDate,
		ApptEndDate = a.ApptEndDate,
		ApptStartTime = isnull(a.ApptStartTime,'00:00'),
		ApptEndTime = isnull(a.ApptEndTime,'23:59'),
		[WMStatusID] = uw.WMStatusID,
		--[WMStatus] = isnull(us.ListValue,es.ListValue),
		[DispatcherID] = 0,
		[Dispatcher] = NULL,
		[TechnicianID] = u.UserID,
		Technician = u.Username,
		ActualStart = NULL,
		ActualFinish = NULL,
		CompletionCode = NULL,
		--OldMeterSize = cast(isnull(xda.MeterSizeCode,ms.ALNVALUE) as varchar(50)),
		--OldMeterNumber = cast(isnull(xda.MeterNo,cast(mn.NUMVALUE as bigint)) as varchar(50)),
		--MeterLocation = cast(isnull(ea.WAMS_METERLOCATION,MeterLocationCode) as varchar(10)),
		ServicePressure = cast('' as varchar(25)),
		NewMeterSize = cast('' as varchar(50)),
		NewMeterNumber = cast('' as varchar(50)),
		MeterLeftStatus = cast('OFF' as varchar(10)),
		APEQType = cast('' as varchar(50)),
		a.AppointmentID, 
		a.AppointmentStatusID,
		--AppointmentStatus = s.ListText,
		a.AppointmentTypeID,
		--AppointmentType = t.ListText,
		a.TimeslotID,
		a.SpecialInstructions,
		a.PreferredContactModeID,
		PremiseNo = xda.PremiseNo,
		CustomerName = cast(cus.ContactName as varchar(255)),
		CustomerPhone = cast(coalesce(cus.ContactPhone,cus.ContactAlternatePhone) as varchar(50)),
		EnableSubmit = cast(0 as bit),
		EnableRaise = cast(0 as bit),
		EnableRelatedWork = cast(0 as bit),
		EnableRelight = cast(1 as bit),
		EnableAssignTech = cast(1 as bit),
		EnableSchedule = cast(1 as bit),
		EnableDispatch = cast(1 as bit),
		EnableRetract = cast(1 as bit),
		EnableBookAppt = cast(1 as bit),
		EnableNewInvoice = cast(1 as bit)

	--select top 200 * 
	FROM [UTP_Order] o
		LEFT JOIN [UTP_Org] org on o.OrgID = org.OrgID
		LEFT JOIN UTP_Contact cus on o.OrderID = cus.OrderID and cus.ContactTypeID = 1801 --CUSTOMER
		LEFT JOIN UTP_OrderAddress oa on o.OrderID = oa.OrderID  and AddressTypeID=1401
		LEFT JOIN [UTP_Address] addr on oa.AddressID = addr.AddressID
		--LEFT JOIN [EGD_WO;
GO
CREATE VIEW [dbo].[vw_UTP_WOXDA] as 
	select	s.OrderID,
			PremiseNo = max(case when da.AttributeName = 'PremiseNo' then AttributeValue else null end),
			SealGroup = max(case when da.AttributeName = 'SealGroup' then AttributeValue else null end),
			MeterLocationCode = max(case when da.AttributeName = 'MeterLocationCode' then AttributeValue else null end),
			MeterSizeCode = max(case when da.AttributeName = 'MeterSizeCode' then AttributeValue else null end),
			MeterNo = max(case when da.AttributeName = 'MeterNo' then AttributeValue else null end),
			JobType = max(case when jpt.WorkType IS NOT NULL THEN jpt.WorkType ELSE case when da.AttributeName = 'JobType' then AttributeValue else null end end),
			JobCode = max(case when jpt.JobPlan IS NOT NULL THEN jpt.JobPlan ELSE case when da.AttributeName = 'JobCode' then AttributeValue else null end end),
			MeterStatus = max(case when da.AttributeName = 'MeterStatus' then AttributeValue else null end)
			
		from UTP_Spec s
			inner join UTP_DataAttribute da on s.DataAttributeID = da.DataAttributeID
			inner join UTP_WO wo on s.OrderID = wo.OrderID
			left join vw_CAT_JobPlanT jpt ON wo.JobCodeID = jpt.JobCodeID
		group by s.OrderID

;
GO






CREATE VIEW [dbo].[vw_Atlantis_WO_UTP] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = Org.ShortName,
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID] = uw.uWOID,
		[WONUM] = uw.WONUM,
		[JobCodeID] = uw.JobCodeID,
		WorkType = xda.JobType,
		JobPlan = '',
		[GroupID] = ug.GroupID,
		[GroupName] = ug.GroupCode,  -- temp, update procs and datasets to include GroupCorde then change back 
		[GroupCode] = ug.GroupCode,
		[GridID] = 0,
		[Grid] = uw.Grid,
		[FullAddress] = isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
									+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
									+ case when isnull(addr.Misc,'') <> '' then ', Unit ' + isnull(REPLACE(addr.Misc,'Unit',''),'') else '' end 
									+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,''),
		[DisplayAddress] = isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
									+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
									+ case when isnull(addr.Misc,'') <> '' then ', Unit ' + isnull(REPLACE(addr.Misc,'Unit',''),'') else '' end 
									+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,''),
		[StreetNo] = addr.StreetNo,
		[Unit] = addr.[Unit],
		[Street] = addr.[Street],
		[Town] = addr.[Town],
		[PostalCode] = addr.PostalCode,
		Misc = addr.Misc,
		Sfx = addr.Sfx,
		ProvinceCode = addr.ProvinceCode,
		ReportedAt = NULL,
		ReportedBy = NULL,
		DueDate=uw.DueDate, 
		UtilityComment = uw.WONotes,
		IsFirmAppt = cast(0 as bit),
		ApptStartDate = a.ApptStartDate,
		ApptEndDate = a.ApptEndDate,
		ApptStartTime = a.ApptStartTime,
		ApptEndTime = a.ApptEndTime,
		[WMStatusID] = uw.WMStatusID,
		[DispatcherID] = 0,
		[Dispatcher] = NULL,
		[TechnicianID] = u.UserID,
		Technician = u.Username,
		ActualStart = NULL,
		ActualFinish = NULL,
		CompletionCode = NULL,
		ServicePressure = cast('' as varchar(25)),
		NewMeterSize = cast('' as varchar(50)),
		NewMeterNumber = cast('' as varchar(50)),
		MeterLeftStatus = cast('OFF' as varchar(10)),
		APEQType = cast('' as varchar(50)),
		a.AppointmentID, 
		a.AppointmentStatusID,
		a.AppointmentTypeID,
		a.TimeslotID,
		a.SpecialInstructions,
		a.PreferredContactModeID,
		PremiseNo = xda.PremiseNo,
		CustomerName = cast(cus.ContactName as varchar(255)),
		CustomerPhone = cast(coalesce(cus.ContactPhone,cus.ContactAlternatePhone) as varchar(50)),
		EnableSubmit = cast(0 as bit),
		EnableRaise = cast(0 as bit),
		EnableRelatedWork = cast(0 as bit),
		EnableRelight = cast(1 as bit),
		EnableAssignTech = cast(1 as bit),
		EnableSchedule = cast(1 as bit),
		EnableDispatch = cast(1 as bit),
		EnableRetract = cast(1 as bit),
		EnableBookAppt = cast(1 as bit),
		EnableNewInvoice = cast(1 as bit)

	FROM [UTP_WO] uw
		JOIN [UTP_Order] o on o.OrderID=uw.OrderID
		LEFT JOIN [UTP_Org] org on o.OrgID = org.OrgID
		LEFT JOIN UTP_Contact cus on o.OrderID = cus.OrderID and cus.ContactTypeID = 1801 --CUSTOMER
		LEFT JOIN UTP_OrderAddress oa on o.OrderID = oa.OrderID  and AddressTypeID=1401
		LEFT JOIN [UTP_Address] addr on oa.AddressID = addr.AddressID
		LEFT JOIN vw_UTP_WOXDA xda on o.OrderID = xda.OrderID
		INNER JOIN ([UTP_Appointment] a 
				INNER JOIN (Select OrderID, AppointmentID = max(AppointmentID) from [UTP_Appointment] WHERE AppointmentTypeID <> 90312 /*Relight*/ AND (AppointmentStatusID = 90321 /*Booked*/ OR AppointmentStatusID = 90320 /*Ready*/) group by OrderID) am 
					on a.AppointmentID = am.AppointmentID)
			on o.OrderID = a.OrderID 
		LEFT JOIN UTP_User u on a.TechnicianID = u.UserID and u.Isactive = 1
		LEFT JOIN UTP_Group ug on ug.GroupID = uw.AreaID
		LEFT JOIN UTP_Spec jt on jt.OrderID=uw.OrderID and jt.AttributeName='JobType'
		LEFT JOIN UTP_Spec jc on;
GO
CREATE view [dbo].[vw_CAT_CodeList] as
	select	distinct
			cl.JobCodeListID,
			JobCodeID = cl.JobCodeID,
			ID = cc.ListID, 
			WorkType = wt.ListValue,
			WT_Description = wt.ListText, 
			SubType = st.ListValue,
			ST_Description = st.ListText,
			JobPlan = jp.ListValue,
			JP_Description = jp.ListText,
			CompletionCode = cc.ListValue,
			CC_Description = cc.ListText,
			e.InSabre,
			e.Note
		from CAT_JobCodeList cl
			left join CAT_JobCode e on cl.JobCodeID = e.JobCodeID
			left join UTP_ListMaster wt on e.JobTypeID = wt.ListID
			left join UTP_ListMaster st on e.SubTypeID = st.ListID
			left join UTP_ListMaster jp on e.JobPlanID = jp.ListID
			left join UTP_ListMaster cc on cl.CodeID = cc.ListID
		where cl.IsActive = 1

;
GO
CREATE VIEW [dbo].[vw_CAT_JobCodeAttribute] AS
	select cta.TemplateAttributeID,
		jc.JobCodeiD,
		cta.DataAttributeID,
		jc.DisplayJobCode,
		jc.IsRC,
		jc.IsRR,
		jc.IsRO,
		jc.InSabre,
		jc.Note,
		SpecName=da.DisplayName,
		SpecDescription=da.Description,
		cta.IsRequired,
		cta.IsReadonly,
		da.LovKey,
		DataType=dt.ListValue,
		Length=da.Length,
		ValidationRule=da.ValidationRule,
		DefaultValue=da.DefaultValue,
		SortOrder=cta.SortOrder,
		SpecTypeID
	From CAT_JobCode jc
		left join CAT_TemplateAttribute cta on cta.TemplateID=jc.PrimaryTemplateID
		left join UTP_DataAttribute da on da.DataAttributeID=cta.DataAttributeID
		left join UTP_ListMaster dt on dt.ListID=da.DataTypeID
	where jc.IsActive=1 and cta.IsActive=1 and da.IsActive=1 

;
GO
-- select * from vw_CAT_JobPlan order by WAMS_WorkType, WAMS_SubType, WAMS_JPNUM
CREATE view [dbo].[vw_CAT_JobPlanT] as
	select JobCodeID, 
			JobCode = e.DisplayJobCode,
			e.JobTypeID,
			WorkType = wt.ListValue,
			WT_Description = wt.ListText, 
			e.SubtypeID,
			SubType = st.ListValue,
			ST_Description = st.ListText,
			e.JobPlanID,
			JobPlan = jp.ListValue,
			JP_Description = jp.ListText,
			IsRC = e.IsRC,
			IsRO = e.IsRO,
			IsRR = e.IsRR,
			InSabre = e.InSabre,
			Note = e.Note,
			PrimaryTemplateId=e.PrimaryTemplateID,
			CatalogID=e.CatalogID,
			IsActive=e.IsActive
		from CAT_JobCode e
			left join UTP_ListMaster wt on e.JobTypeID = wt.ListID
			left join UTP_ListMaster st on e.SubtypeID = st.ListID
			left join UTP_ListMaster jp on e.JobPlanID = jp.ListID
		--where e.IsActive = 1

;
GO
CREATE VIEW [dbo].[vw_CAT_TemplateAttribute] AS
       select cta.TemplateAttributeID,
              cta.TemplateID,
              TemplateName=tm.ListValue,
              cta.DataAttributeID,
              SpecName=da.DisplayName,
              SpecDescription=da.Description,
              cta.IsRequired,
              da.LovKey,
              DataType=dt.ListValue,
              Length=da.Length,
              ValidationRule=da.ValidationRule,
              DefaultValue=da.DefaultValue,
              SpecTypeID,
              cta.SortOrder,
              cta.IsReadOnly
       From CAT_TemplateAttribute cta
              left join UTP_DataAttribute da on da.DataAttributeID=cta.DataAttributeID
              left join UTP_ListMaster dt on dt.ListID=da.DataTypeID
              left join UTP_ListMaster tm on tm.ListID=cta.TemplateID
       where   cta.IsActive=1 and da.IsActive=1  and tm.IsActive=1

;
GO

CREATE view [dbo].[VW_CAT_WOCommon] AS
select 
	wo.WONUM,
	OrigWONUM=COALESCE(own.AttributeValue,''),
	wo.JobCodeID,
	JobCode=jp.JobCode ,
	Grid=COALESCE(wo.Grid,''),
	AreaCode=COALESCE(ug.GroupCode,''),
	StreetNo=COALESCE(ad.StreetNo,''),
	Sfx=COALESCE(ad.Sfx,''),
	Street=COALESCE(ad.Street,''),
	City=COALESCE(ad.Town,''),
	DrawingNum=COALESCE(dw.AttributeValue,''),
	LPCPON=COALESCE(po.AttributeValue,''),
	LPGSPON=COALESCE(lpgspo.AttributeValue,''),
	STNNUM=COALESCE(st.AttributeValue,''),
	wo.OrderID,
	wo.CompletionCode,
	wo.ActualStart,
	wo.ActualFinish
from UTP_WO wo (nolock)
	left join UTP_Spec po (nolock) on po.OrderID=wo.OrderID and po.DataAttributeID = (select DataAttributeID from UTP_DataAttribute where DisplayName='LPCPO')
	left join UTP_Spec lpgspo (nolock) on po.OrderID=wo.OrderID and po.DataAttributeID = (select DataAttributeID from UTP_DataAttribute where DisplayName='LPGSPO')
	left join UTP_Spec st (nolock) on st.OrderID=wo.OrderID and st.DataAttributeID = (select DataAttributeID from UTP_DataAttribute where DisplayName='STNNUM')
	left join UTP_Spec dw (nolock) on dw.OrderID=wo.OrderID and st.DataAttributeID = (select DataAttributeID from UTP_DataAttribute where DisplayName='DWGNUM')
	left join UTP_Spec own (nolock) on own.OrderID=wo.OrderID and own.DataAttributeID = (select DataAttributeID from UTP_DataAttribute where DisplayName='LPCWONUM')
	left join UTP_OrderAddress oad (nolock) on oad.OrderID=wo.OrderID
	left join UTP_Address ad (nolock) on ad.AddressID=oad.AddressID
	left join UTP_Group ug (nolock) on ug.GroupID = wo.AreaID
	join vw_CAT_JobPlanT jp (nolock) on jp.JobCodeID=wo.JobCodeID

;
GO

CREATE VIEW [dbo].[vw_IDM_TPS_WO_UTP] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = org.ShortName,
		[WOID] = uw.uWOID,
		[WONUM] = uw.WONUM,
		[JobCodeID] = uw.JobCodeID,
		JobCode = jt.AttributeValue + ' / ' + jc.AttributeValue,
		WorkType = jt.AttributeValue,
		Subtype = jc.AttributeValue,
		JobPlan = '',
		[WMStatusID] = uw.WMStatusID,
		[WMStatus] = us.ListValue,
		[Technician] = ft.Username, 
		[ToSabre] = 0,
		--[ToSabre] = CASE WHEN org.ShortName IN ('EGD','UGD','KU') THEN 1 ELSE 0 END,
		[QueuePriority] = 9 
	FROM [UTP_Order] o with(nolock)
		JOIN [UTP_Org] org with(nolock) on o.OrgID = org.OrgID
		JOIN [UTP_WO] uw with(nolock) on o.OrderID = uw.OrderID
		JOIN UTP_ListMaster us with(nolock) on uw.WMStatusID = us.ListID
		-- LEFT JOIN vw_UTP_WOXDA xda on o.OrderID = xda.OrderID
		JOIN UTP_Spec jc with(nolock) ON jc.OrderID=o.OrderID
		JOIN UTP_DataAttribute jca with(nolock) ON jca.DataAttributeID=jc.DataAttributeID
		JOIN UTP_Spec jt with(nolock) ON jt.OrderID=o.OrderID
		JOIN UTP_DataAttribute jta with(nolock) ON jta.DataAttributeID=jt.DataAttributeID
		LEFT JOIN UTP_User ft with(nolock) on ft.UserID = uw.TechnicianID
	WHERE jca.AttributeName='JobCode' AND jta.AttributeName='JobType'

;
GO

CREATE VIEW [dbo].[vw_IDM_TPS_WO] as
	select 
		[OrderID],[OrgID],[OrgShortName],[WOID],[WONUM],[JobCodeID],[JobCode],[WorkType],[Subtype],[JobPlan],[WMStatusID],[WMStatus],[Technician],[ToSabre],[QueuePriority] 
	FROM vw_IDM_TPS_WO_UTP
;
GO

CREATE VIEW [dbo].[vw_IDM_UTP_WO_UTP] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = Org.ShortName,
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID] = uw.uWOID,
		[WONUM] = cast(uw.WONUM as varchar(15)),
		[JobCodeID] = uw.JobCodeID,
		JobCode = coalesce(jt.AttributeValue,'(Not set)') + ' / ' + coalesce(jc.AttributeValue,'(Not set)'),
		WorkType = coalesce(jt.AttributeValue,'(Not set)'),
		Subtype = coalesce(jc.AttributeValue,'(Not set)'),
		JobPlan = cast('' as varchar(255)),
		WOTypeID = cast(0 as int),
		WOType = cast('PRIMARY' as varchar(50)),
		[GroupID] = ug.GroupID,
		[GroupName] = ug.GroupCode,  -- temp, update procs and datasets to include GroupCorde then change back 
		[GroupCode] = ug.GroupCode,
		[WorkGroupID] = cast(0 as int),
		[WorkGroup] = cast('' as varchar(255)),
		[GridID] = 0,
		[Grid] = uw.Grid,
		[DisplayAddress] = cast(isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
									+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
									+ case when isnull(addr.Misc,'') <> '' then ', ' + isnull(addr.Misc,'') else '' end 
									+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,'')
								as varchar(400)),
		[StreetNo] = addr.StreetNo,
		[Unit] = cast(addr.[Unit] as varchar(30)),
		[Street] = addr.[Street],
		[Town] = addr.[Town],
		[PostalCode] = addr.PostalCode,
		ReportedAt = CAST(NULL as DATETIME),
		ReportedBy = CAST(NULL as varchar(255)),
		DueDate = uw.DueDate, 
		UtilityComment = uw.WONotes,
		IsFirmAppt = a.IsFirmAppt,
		ApptStartDate = case when s.ListText = 'Cancelled' then null else cast(cast(a.ApptStartDate as varchar(12)) + ' ' + left(a.ApptStartTime,2) + ':' + right(a.ApptStartTime,2) as datetime) end,
		ApptEndDate = case when s.ListText = 'Cancelled' then null else cast(cast(a.ApptEndDate as varchar(12)) + ' ' + left(ApptEndTime,2) + ':' + right(ApptEndTime,2) as datetime) end,
		ApptStartTime = isnull(left(a.ApptStartTime,2) + ':' + right(a.ApptStartTime,2),'00:00'),
		ApptEndTime = isnull(left(ApptEndTime,2) + ':' + right(ApptEndTime,2),'23:59'),
		[WMStatusID] = uw.WMStatusID, 
		[WMStatus] = us.ListValue,
		[DispatcherID] = cast(0 as int),
		[Dispatcher] = cast(NULL as varchar(50)),
		[TechnicianID] = coalesce(u.UserID,ut.UserID),
		Technician = coalesce(u.Username,ut.Username),
		ActualStart = coalesce(uw.ActualStart,a.ActualStart),
		ActualFinish = coalesce(uw.ActualFinish,a.ActualFinish),
		CompletionCode = uw.CompletionCode,
		IsBillable = cast(NULL as int),
		NoCharge = cast(NULL as int),
		OldMeterSize = cast(umsc.AttributeValue as varchar(50)),
		OldMeterNumber = cast(umn.AttributeValue as varchar(50)),
		MeterLocation = cast(umlc.AttributeValue as varchar(10)),
		ServicePressure = cast('''' as varchar(25)),
		NewMeterSize = cast('''' as varchar(50)),
		NewMeterNumber = cast('''' as varchar(50)),
		MeterLeftStatus = cast(a.MeterLeftStatus as varchar(10)),
		APEQType = cast(NULL as varchar(50)),
		a.AppointmentID, 
		a.AppointmentStatusID,
		AppointmentStatus = s.ListText,
		a.AppointmentTypeID,
		AppointmentType = t.ListText,
		a.TimeslotID,
		a.SpecialInstructions,
		PremiseNo = cast (upn.AttributeValue as varchar(25)),
		CustomerName = cast(cus.ContactName as varchar(255)),
		CustomerPhone = cast(coalesce(cus.ContactPhone,cus.ContactAlternatePhone) as varchar(50)),
		WODescription = cast(uw.WODescription as varchar(255)),
		ParentWONUM = cast('' as varchar(15)), -- need to get uw.Parent from somewhere
		PrimaryOrderID = o.OrderID,
		IsEAOK = a.IsEAOK,
		ErrorStatus = cast('' as varchar(20)), -- need to get
		CreatedTimestamp = o.CreatedTimestamp,
		SubmitStatusID = uw.SubmitStatusID,
		SubmitStatus = uss.ListText,
		TransmitStatusID = uw.TransmitStatusID,
		TransmitStatus = uts.ListText,
		EnableSubmit = 0,
		EnableRaise = cast(0 as bit), ;
GO

CREATE VIEW [dbo].[vw_IDM_UTP_WO] as
	SELECT OrderID,OrgID,OrgShortName,ProjectNumber,WOID,WONUM,JobCodeID,JobCode,WorkType,Subtype,JobPlan,WOTypeID,WOType,GroupID,GroupName,GroupCode,WorkGroupID,WorkGroup,GridID,Grid,
		DisplayAddress,StreetNo,Unit,Street,Town,PostalCode,ReportedAt,ReportedBy,DueDate,UtilityComment,IsFirmAppt,ApptStartDate,ApptEndDate,ApptStartTime,ApptEndTime,WMStatusID,WMStatus,
		DispatcherID,Dispatcher,TechnicianID,Technician,ActualStart,ActualFinish,CompletionCode,IsBillable,NoCharge,OldMeterSize,OldMeterNumber,MeterLocation,ServicePressure,NewMeterSize,
		NewMeterNumber,MeterLeftStatus,APEQType,AppointmentID,AppointmentStatusID,AppointmentStatus,AppointmentTypeID,AppointmentType,TimeslotID,SpecialInstructions,PremiseNo,
		CustomerName,CustomerPhone,WODescription,ParentWONUM,PrimaryOrderID,IsEAOK,ErrorStatus,CreatedTimestamp,SubmitStatusID,SubmitStatus,TransmitStatusID,TransmitStatus,
		EnableSubmit,EnableRaise,EnableRelatedWork,EnableRelight,EnableAssignTech,EnableSchedule,EnableDispatch,EnableRetract,EnableBookAppt,EnableNewInvoice,EnableSuspend,
		EnableCodeOut,EnableCancel,EnableSummary
		FROM vw_IDM_UTP_WO_UTP
;
GO

CREATE VIEW [dbo].[vw_Portal_WO] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = Org.ShortName,
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID] = uw.uWOID,
		[WONUM] = uw.WONUM,
		[JobCodeID] = uw.JobCodeID,
		JobCode = xda.JobType + ' / ' + xda.JobCode,
		WorkType = xda.JobType,
		Subtype = xda.JobCode,
		JobPlan = '',
		[GroupID] = ug.GroupID,
		[GroupName] = ug.GroupCode,  -- temp, update procs and datasets to include GroupCorde then change back 
		[GroupCode] = ug.GroupCode,
		[GridID] = 0,
		[Grid] = uw.Grid,
		[DisplayAddress] = isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
								+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
								+ case when isnull(addr.Unit,'') <> '' then ', Unit ' + isnull(addr.Unit,'') else '' end 
								+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,''),
		[StreetNo] = addr.StreetNo,
		[Unit] = [Unit],
		[Street] = [Street],
		[Town] = [Town],
		[PostalCode] = addr.PostalCode,
		Misc = addr.Misc,
		Sfx = addr.Sfx,
		ProvinceCode = addr.ProvinceCode,
		ReportedAt = NULL,
		ReportedBy = NULL,
		DueDate, 
		UtilityComment = uw.WONotes,
		IsFirmAppt = cast(0 as bit),
		ApptStartDate = a.ApptStartDate,
		ApptEndDate = a.ApptEndDate,
		ApptStartTime = isnull(a.ApptStartTime,'00:00'),
		ApptEndTime = isnull(a.ApptEndTime,'23:59'),
		[WMStatusID] = uw.WMStatusID,
		[WMStatus] = us.ListValue,
		[DispatcherID] = 0,
		[Dispatcher] = NULL,
		[TechnicianID] = u.UserID,
		Technician = u.Username,
		ActualStart = NULL,
		ActualFinish = NULL,
		CompletionCode = NULL,
		OldMeterSize = cast(xda.MeterSizeCode as varchar(50)),
		OldMeterNumber = cast(xda.MeterNo as varchar(50)),
		MeterLocation = cast(MeterLocationCode as varchar(10)),
		ServicePressure = cast('' as varchar(25)),
		NewMeterSize = cast('' as varchar(50)),
		NewMeterNumber = cast('' as varchar(50)),
		MeterLeftStatus = cast('OFF' as varchar(10)),
		APEQType = cast('' as varchar(50)),
		a.AppointmentID, 
		a.AppointmentStatusID,
		AppointmentStatus = s.ListText,
		a.AppointmentTypeID,
		AppointmentType = t.ListText,
		a.TimeslotID,
		a.SpecialInstructions,
		a.PreferredContactModeID,
		PremiseNo = cast (xda.PremiseNo as varchar(25)),
		CustomerName = cast(cus.ContactName as varchar(255)),
		CustomerPhone = cast(coalesce(cus.ContactPhone,cus.ContactAlternatePhone,'') as varchar(50)),
		EnableSubmit = cast(0 as bit),
		EnableRaise = cast(0 as bit),
		EnableRelatedWork = cast(0 as bit),
		EnableRelight = cast(1 as bit),
		EnableAssignTech = cast(1 as bit),
		EnableSchedule = cast(1 as bit),
		EnableDispatch = cast(1 as bit),
		EnableRetract = cast(1 as bit),
		EnableBookAppt = cast(1 as bit),
		EnableNewInvoice = cast(1 as bit)

	--select top 200 * 
	FROM [UTP_Order] o
		LEFT JOIN [UTP_Org] org on o.OrgID = org.OrgID
		LEFT JOIN UTP_Contact cus on o.OrderID = cus.OrderID and cus.ContactTypeID = 1801 --CUSTOMER
		LEFT JOIN UTP_OrderAddress oa on o.OrderID = oa.OrderID  and AddressTypeID=1401
		LEFT JOIN [UTP_Address] addr on oa.AddressID = addr.AddressID
		--LEFT JOIN [EGD_WO] ew on o.OrderID = ew.OrderID
		--LEFT JOIN EGD_PlusPCustomer ec on ew.WOID = ec.WOID
		--LEFT JOIN UTP_ListMaster es on ew.StatusID = es.ListID
		--LEFT JOIN vw_EGD_JobPlan ej on ew.JobCodeID = ej.JobCodeID
		--LEFT JOIN UTP_ListMaster ewt on ej.WorkTypeID = ewt.ListID
		--LEFT JOIN UTP_ListMaster est on ej.WAMS_SubtypeID = est.ListID
		--LEFT JOIN [EGD_WOServiceAddress] ea on ew.WOID = ea.WOID
		--LEFT JOIN EGD_Spec mn on ew.WOID = mn.WOID and mn.SpecTypeID = 5803 and mn.ASSETATTRID = 'MTRNUM'
		--LEFT JOIN EGD_Spec ms on ew.WOID = ms.WOID and ms.SpecTypeID = 5803 and ms.ASSETATTRID = 'MTRSIZE'
		LEFT JOIN [UTP_WO] uw on o.OrderID = uw.OrderID
		LEFT JOIN UTP_ListMaster us on uw.WMStatusID = us.ListID
		LEFT JOIN vw_UT;
GO

-- CREATED on 11-Nov-2016 - JLM - Created as an alternative to vw_Portal_WO for performance reasons
--								  (and to prevent timeouts in Customer Portal)
CREATE VIEW [dbo].[vw_Portal_WO_Small] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = Org.ShortName,
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID] = uw.uWOID,
		[WONUM] = uw.WONUM,
		[JobCodeID] = uw.JobCodeID,
		--JobCode = isnull(ewt.ListValue,xda.JobType) + ' / ' + isnull(est.ListValue,xda.JobCode) + case when isnull(ew.JPNUM,'') = '' then '' else ' / ' + isnull(ew.JPNUM,'') end,
		WorkType = xda.JobType,
		--Subtype = isnull(est.ListValue,xda.JobCode),
		JobPlan = '',
		[GroupID] = ug.GroupID,
		[GroupName] = ug.GroupCode,  -- temp, update procs and datasets to include GroupCorde then change back 
		[GroupCode] = ug.GroupCode,
		[GridID] = 0,
		[Grid] = uw.Grid,
		[DisplayAddress] = isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
								+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
								+ case when isnull(addr.Unit,'') <> '' then ', Unit ' + isnull(addr.Unit,'') else '' end 
								+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,''),
		[StreetNo] = addr.StreetNo,
		[Unit] = [Unit],
		[Street] = [Street],
		[Town] = [Town],
		[PostalCode] = addr.PostalCode,
		Misc = addr.Misc,
		Sfx = addr.Sfx,
		ProvinceCode = addr.ProvinceCode,
		ReportedAt = NULL,
		ReportedBy = NULL,
		DueDate, 
		UtilityComment = uw.WONotes,
		IsFirmAppt = cast(0 as bit),
		ApptStartDate = a.ApptStartDate,
		ApptEndDate = a.ApptEndDate,
		ApptStartTime = isnull(a.ApptStartTime, '00:00'),
		ApptEndTime = isnull(a.ApptEndTime, '23:59'),
		[WMStatusID] = uw.WMStatusID,
		--[WMStatus] = isnull(us.ListValue,es.ListValue),
		[DispatcherID] = 0,
		[Dispatcher] = NULL,
		[TechnicianID] = u.UserID,
		Technician = u.Username,
		ActualStart = NULL,
		ActualFinish = NULL,
		CompletionCode = NULL,
		--OldMeterSize = cast(isnull(xda.MeterSizeCode,ms.ALNVALUE) as varchar(50)),
		--OldMeterNumber = cast(isnull(xda.MeterNo,cast(mn.NUMVALUE as bigint)) as varchar(50)),
		--MeterLocation = cast(isnull(ea.WAMS_METERLOCATION,MeterLocationCode) as varchar(10)),
		ServicePressure = cast('' as varchar(25)),
		NewMeterSize = cast('' as varchar(50)),
		NewMeterNumber = cast('' as varchar(50)),
		MeterLeftStatus = cast('OFF' as varchar(10)),
		APEQType = cast('' as varchar(50)),
		a.AppointmentID, 
		a.AppointmentStatusID,
		--AppointmentStatus = s.ListText,
		a.AppointmentTypeID,
		--AppointmentType = t.ListText,
		a.TimeslotID,
		a.SpecialInstructions,
		a.PreferredContactModeID,
		PremiseNo = xda.PremiseNo,
		CustomerName = cast(cus.ContactName as varchar(255)),
		CustomerPhone = cast(coalesce(cus.ContactPhone,cus.ContactAlternatePhone) as varchar(50)),
		EnableSubmit = cast(0 as bit),
		EnableRaise = cast(0 as bit),
		EnableRelatedWork = cast(0 as bit),
		EnableRelight = cast(1 as bit),
		EnableAssignTech = cast(1 as bit),
		EnableSchedule = cast(1 as bit),
		EnableDispatch = cast(1 as bit),
		EnableRetract = cast(1 as bit),
		EnableBookAppt = cast(1 as bit),
		EnableNewInvoice = cast(1 as bit)

	--select top 200 * 
	FROM [UTP_Order] o
		LEFT JOIN [UTP_Org] org on o.OrgID = org.OrgID
		LEFT JOIN UTP_Contact cus on o.OrderID = cus.OrderID and cus.ContactTypeID = 1801 --CUSTOMER
		LEFT JOIN UTP_OrderAddress oa on o.OrderID = oa.OrderID  and AddressTypeID=1401
		LEFT JOIN [UTP_Address] addr on oa.AddressID = addr.AddressID
		--LEFT JOIN [EGD_WO] ew on o.OrderID = ew.OrderID
		--LEFT JOIN EGD_PlusPCustomer ec on ew.WOID = ec.WOID
		--LEFT JOIN UTP_ListMaster es on ew.StatusID = es.ListID
		--LEFT JOIN vw_EGD_JobPlan ej on ew.JobCodeID = ej.JobCodeID
		--LEFT JOIN UTP_ListMaster ewt on ej.WorkTypeID = ewt.ListID
		--LEFT JOIN UTP_ListMaster est on ej.WAMS_SubtypeI;
GO
CREATE VIEW [dbo].[vw_TPS_WO_UTP] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = org.ShortName,
		[WOID] = uw.uWOID,
		[WONUM] = uw.WONUM,
		[JobCodeID] = uw.JobCodeID,
		[JobCode] = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.JobCode ELSE jt.AttributeValue + ' / ' + jc.AttributeValue END,
		[WorkType] = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.WorkType ELSE jt.AttributeValue END,
		[Subtype] = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.Subtype ELSE jc.AttributeValue END,
		[JobPlan] = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.JobPlan ELSE '' END,
		[WMStatusID] = uw.WMStatusID,
		[WMStatus] = us.ListValue,
		[Technician] = ft.Username, 
		-- [ToSabre] = 0,
		[ToSabre] = CASE WHEN org.ShortName IN ('LPC') THEN 1 ELSE 0 END,
		[QueuePriority] = 9 
	FROM [UTP_Order] o with(nolock)
		JOIN [UTP_Org] org with(nolock) on o.OrgID = org.OrgID
		JOIN [UTP_WO] uw with(nolock) on o.OrderID = uw.OrderID
		JOIN [UTP_ListMaster] us with(nolock) on uw.WMStatusID = us.ListID
		LEFT JOIN [UTP_Spec] jc with(nolock) ON jc.OrderID=o.OrderID AND jc.AttributeName='JobCode'
		--LEFT JOIN [UTP_DataAttribute] jca with(nolock) ON jca.DataAttributeID=jc.DataAttributeID AND jca.AttributeName='JobCode'
		LEFT JOIN [UTP_Spec] jt with(nolock) ON jt.OrderID=o.OrderID AND jt.AttributeName='JobType'
		--LEFT JOIN [UTP_DataAttribute] jta with(nolock) ON jta.DataAttributeID=jt.DataAttributeID AND jta.AttributeName='JobType'
		LEFT JOIN [UTP_User] ft with(nolock) on ft.UserID = uw.TechnicianID
		LEFT JOIN [vw_CAT_JobPlanT] jpt with(nolock) on jpt.JobCodeID=uw.JobCodeID


;
GO

CREATE VIEW [dbo].[vw_TPS_WO] as
	select 
		[OrderID],[OrgID],[OrgShortName],[WOID],[WONUM],[JobCodeID],[JobCode],[WorkType],[Subtype],[JobPlan],[WMStatusID],[WMStatus],[Technician],[ToSabre],[QueuePriority] 
	FROM vw_TPS_WO_UTP
;
GO
CREATE VIEW [dbo].[vw_UTP_AllBookedAppointments] AS
	-- All appointments currently in Booked or Reserve Status
	select ap.TechnicianID, GroupID=uwo.AreaID, CONVERT(date, ap.ApptEndDate) AS ApptEndDate, ap.TimeslotID, Booked = count(*) 
	from UTP_Appointment ap
		LEFT JOIN UTP_WO uwo ON uwo.OrderID=ap.OrderID
		--LEFT JOIN EGD_WO ewo ON ewo.OrderID=ap.OrderID
		--LEFT JOIN UTP_Group eg ON eg.GroupCode=ewo.WAMS_REGION
	where ap.AppointmentStatusID in (90321,90329)
	group by ap.TechnicianID,uwo.AreaID,CONVERT(date, ap.ApptEndDate), ap.TimeslotID

;
GO

-- select * from vw_UTP_Catalog
create view [dbo].[vw_UTP_Catalog] as
	select	CatalogID,
			CatalogName,
			RowVersionID,
			IsActive
		from UTP_Catalog




;
GO

-- ===========================================================
-- vw_UTP_Collection
-- Revisions:
-- ===========================================================
CREATE VIEW [dbo].[vw_UTP_Collection] as
	SELECT CollectionID
		  ,CollectionTypeID
		  ,CollectionType = ct.ListText
		  ,CollectionName
		  ,CollectionOwnerID
		  ,CollectionOwner = u.Username
		  ,CollectionQuery
		  ,StatementTypeID
		  ,StatementType = st.ListText
	  FROM UTP_Collection c
		inner join UTP_ListMaster ct on c.CollectionTypeID = ct.ListID
		left join UTP_User u on c.CollectionOwnerID = u.UserID
		left join UTP_ListMaster st on c.StatementTypeID = st.ListID

;
GO

-- ===========================================================
-- vw_UTP_CollectionItem
-- Revisions:
-- ===========================================================
CREATE VIEW [dbo].[vw_UTP_CollectionItem] as
	SELECT CollectionItemID
		  ,c.CollectionID
		  ,c.CollectionTypeID
		  ,CollectionType = ct.ListText
		  ,c.CollectionName
		  ,CollectionItem
	  FROM UTP_Collection c
		inner join UTP_CollectionItem ci on c.CollectionID = ci.CollectionID
		inner join UTP_ListMaster ct on c.CollectionTypeID = ct.ListID


;
GO

-- select * from vw_UTP_Customer
create view [dbo].[vw_UTP_Customer] as
	select	o.OrgID,
			o.Name,
			o.ShortName
		from UTP_Org o
			inner join UTP_Customer c on o.OrgID = c.OrgID




;
GO
CREATE view [dbo].[vw_UTP_CustomerAppts] as
select 
      Utility=org.ShortName,
      Via=via.ListText,
      Area=ug.GroupName,
      Date=CAST(a2.CreatedTimestamp as date),
      ApptStatus=ast.ListText,
      Job_Type=COALESCE(xda.JobType+' / '+xda.JobCode,'(Not set)'),
      --Job_Type=COALESCE(jp.WAMS_SubType,xda.JobType,'(Not set)'),
      RequestedReminder= sum (case when rr.ListText<>'None' then 1 else 0 end),
      NoReminder = sum (case when rr.ListText is null or rr.ListText = 'None' then 1 else 0 end),
      Total=count(*)
from UTP_Appointment a (nolock)
      --left join EGD_WO ew (nolock) on ew.OrderID=a.OrderID
      left join UTP_WO wo (nolock) on wo.OrderID = a.OrderID
      left join UTP_Order o (nolock) on o.OrderID=a.OrderID
      left join UTP_Org org (nolock) on org.OrgID=o.OrgID
      left join UTP_Group ug (nolock) on ug.GroupID = wo.AreaID
      --left join UTP_Group eg (nolock) on eg.GroupCode = ew.WAMS_REGION
      left join UTP_ListMaster (nolock) ast on ast.ListID = a.AppointmentStatusID
      --left join vw_EGD_JobPlan (nolock) jp on jp.JobCodeID = ew.JobCodeID
      left join UTP_ListMaster (nolock) rr on rr.ListID=a.PreferredContactModeID
      left join vw_UTP_WOXDA xda (nolock) on xda.OrderID=wo.OrderID
	  left join UTP_Appointment a2 (nolock) on a2.AppointmentID = (select min(a2.AppointmentID) from UTP_Appointment a2 where a2.OrderID=a.OrderID and a2.ApptStartDate=a.ApptStartDate)
      left join UTP_ListMaster via (nolock) on via.ListID=a2.BookedViaID
where a.TimeslotID between 90301 and 90305
      and  a.ApptStartDate is not null
	  and a2.BookedViaID is not null
	  and a.AppointmentId=a2.AppointmentID
group by org.ShortName,via.ListText,ug.GroupName,CAST(a2.CreatedTimestamp as date),ast.ListText,COALESCE(xda.JobType+' / '+xda.JobCode,'(Not set)')

;
GO
-- ===========================================================
-- select * from [vw_UTP_WO]
-- Revisions:
--	8-Dec-2016	JRP Added EnableCodeOut, EnableCancel, WOTypeID, WOType, PrimaryOrderID, IsBillable, NoCharge
--	24-May-2017	JRP	LPGS-704 For PRIMARY-RR, PrimaryOrderID should be OrderID
--					LPGS-1065 Add WOTypes PRIMARY-RR and PRIMARY-RO
--					LPGS-1016 Cannot Code Out UGD WO
--	June-2018	JRP	LPGS_1455 Added PSN
--	16-Aug-2018	IDM	Added support for CAT_JobCode JobCodeID
-- ===========================================================
CREATE VIEW [dbo].[vw_UTP_WO] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = Org.ShortName,
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID] = uw.uWOID,
		[WONUM] = cast(uw.WONUM as varchar(15)),
		[JobCodeID] = uw.JobCodeID,
		-- JobCode = coalesce(ewt.ListValue,xda.JobType,'(Not set)') + ' / ' + coalesce(est.ListValue,xda.JobCode,'(Not set)') + case when isnull(ew.JPNUM,'') = '' then '' else ' / ' + isnull(ew.JPNUM,'') end,
		JobCode = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.JobCode
					ELSE isnull(xda.JobType,'(Not set)') + ' / ' + isnull(xda.JobCode,'(Not set)') end,
		WorkType = coalesce(jpt.WorkType,xda.JobType,'(Not set)'),
		Subtype = coalesce(jpt.SubType,xda.JobCode,'(Not set)'),
		JobPlan = cast(coalesce(jpt.JobPlan,'') as varchar(255)),
		WOTypeID = cast(0 as int),
		WOType = cast((case when ws.RelationTypeID = 1601 then 'PRIMARY-RR' else 'PRIMARY' end) as varchar(50)),
		[GroupID] = ug.GroupID,
		[GroupName] = ug.GroupCode,  -- temp, update procs and datasets to include GroupCorde then change back 
		[GroupCode] = ug.GroupCode,
		[WorkGroupID] = cast(0 as int),
		[WorkGroup] = cast('' as varchar(255)),
		[GridID] = 0,
		[Grid] = uw.Grid,
		[DisplayAddress] = cast(isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
									+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
									+ case when isnull(addr.Misc,'') <> '' then ', ' + isnull(addr.Misc,'') else '' end 
									+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,'')
								as varchar(400)),
		[StreetNo] = addr.StreetNo,
		[Unit] = cast([Unit] as varchar(30)),
		[Street] = [Street],
		[Town] = [Town],
		[PostalCode] = addr.PostalCode,
		ReportedAt = cast(NULL as datetime),
		ReportedBy = cast(NULL as varchar(255)),
		DueDate, 
		UtilityComment = uw.WONotes,
		IsFirmAppt = a.IsFirmAppt,
		ApptStartDate = case when s.ListText = 'Cancelled' then null else cast(cast(a.ApptStartDate as varchar(12)) + ' ' + left(a.ApptStartTime,2) + ':' + right(a.ApptStartTime,2) as datetime) end,
		ApptEndDate = case when s.ListText = 'Cancelled' then null else cast(cast(a.ApptEndDate as varchar(12)) + ' ' + left(ApptEndTime,2) + ':' + right(ApptEndTime,2) as datetime) end,
		ApptStartTime = isnull(left(a.ApptStartTime,2) + ':' + right(a.ApptStartTime,2),'00:00'),
		ApptEndTime = isnull(left(ApptEndTime,2) + ':' + right(ApptEndTime,2),'23:59'),
		[WMStatusID] = uw.WMStatusID, 
		[WMStatus] = us.ListValue,
		[DispatcherID] = cast(0 as int),
		[Dispatcher] = cast(NULL as varchar(50)),
		[TechnicianID] = coalesce(u.UserID,ut.UserID),
		Technician = coalesce(u.Username,ut.Username),
		ActualStart = coalesce(uw.ActualStart,a.ActualStart),
		ActualFinish = coalesce(uw.ActualFinish,a.ActualFinish),
		CompletionCode = uw.CompletionCode,
		IsBillable = cast(NULL as int),
		NoCharge = cast(NULL as int),
		OldMeterSize = cast(xda.MeterSizeCode as varchar(50)),
		OldMeterNumber = cast(xda.MeterNo as varchar(50)),
		MeterLocation = cast(NULL as varchar(10)),
		ServicePressure = cast('''' as varchar(25)),
		NewMeterSize = cast('''' as varchar(50)),
		NewMeterNumber = cast('''' as varchar(50)),
		MeterLeftStatus = cast(a.MeterLeftStatus as varchar(10)),
		APEQType = cast(NULL as varchar(50)),
		a.AppointmentID, 
		a.Appointmen;
GO
create view [dbo].[vw_UTP_Dashboard] as
	select 	[NEW Today] = sum(case when isnull(ReportedAt,CreatedTimestamp) >= cast(getdate() as date) then 1 else 0 end),
			WSCH = sum(case WMStatus when 'WSCH' then 1 else 0 end),
			SCHED = sum(case when WMStatus = 'SCHED' then 1 else 0 end),
			DISP = sum(case when WMStatus = 'DISP' then 1 else 0 end),
			ACK = sum(case when WMStatus = 'ACK' then 1 else 0 end),
			ENROUTE = sum(case when WMStatus = 'ENROUTE' then 1 else 0 end),
			ONSITE = sum(case WMStatus when 'ONSITE' then 1 else 0 end),
			WCOMP = sum(case when WMStatus = 'WCOMP' then 1 else 0 end),
			[HANDED OVER] = sum(case when WMStatus = 'HANDED OVER' then 1 else 0 end),
			CANCELLED = sum(case WMStatus when 'CAN' then 1 else 0 end),
			COMP = sum(case WMStatus when 'COMP' then 1 else 0 end),
			[Total WO] = count(*)
		-- select top 1 *
		from vw_UTP_WO wo
	--		inner join UTP_ListMaster l1 on wo.WMStatusID = l1.ListID


;
GO

CREATE view [dbo].[vw_UTP_DateList] as select Date = cast('2/2/2017' as date)

;
GO
create view [dbo].[vw_UTP_DispatchAppointment] as
	select 	[OrderID],
			[TechnicianID] = max([TechnicianID]),
			[AppointmentTypeID] = max([AppointmentTypeID]),
			ApptWindowStartDate = max(ApptStartDate),
			ApptWindowEndDate = max(ApptEndDate),
			TimeslotID = max(TimeslotID),
			[SpecialInstructions] = max(SpecialInstructions)
	from UTP_Appointment
	where AppointmentStatusID in (90321,90329)
	group by OrderID


;
GO

-- select * from vw_UTP_Document
create view [dbo].[vw_UTP_Document] as
	select 	d.DocumentID,
			d.DocumentTypeID,
			DocumentType = dt.ListValue,
			d.[CreatedTimestamp],
			d.CreatedByID,
			CreatedBy = u.Username,
			d.[SourceID],
			Source = sc.ListValue,
			d.Filename,
			d.[Filetype],
			d.[Size],
			d.[DocumentRepositoryID],
			d.[OrigFilename],
			d.[AccessedTimestamp]
			--,
			--DocumentDescription = cast('' as varchar(255))
			--DocumentComments = cast('' as varchar(max))

		from UTP_Document d 
			left join UTP_Listmaster dt on d.DocumentTypeID = dt.ListID
			left join UTP_Listmaster sc on d.SourceID = dt.ListID
			left join UTP_User u on d.CreatedByID = u.UserID

;
GO
CREATE VIEW [dbo].[vw_UTP_DocumentStorage] as
	SELECT	ds.[DocumentStorageID],
			ds.[DocumentTypeID],
			ds.[OrgID],
			org.[Name],
			org.[ShortName],
			ds.[RootFolder],
			ds.[DestinationFolder]

		FROM UTP_DocumentStorage ds
			left join UTP_Listmaster dt on ds.DocumentTypeID = dt.ListID
			left join UTP_Org org on ds.OrgID = org.OrgID




;
GO

-- select * from vw_UTP_Group
create view [dbo].[vw_UTP_Group] as
	SELECT g.[GroupID]
		  ,g.[GroupCode]
		  ,g.[GroupName]
		  ,g.[GroupTypeID]
		  ,[GroupType] = gt.ListValue
		  ,[GroupManagerID] = isnull(g.[GroupManagerID],0)
		  ,[GroupManager] = gm.Username
		  ,[ParentGroupID] = isnull(g.[ParentGroupID],0)
		  ,[ParentGroupName] = pg.GroupName
		  ,g.[IsActive]
		  ,Active = active.ListText

	  FROM [dbo].[UTP_Group] g
		LEFT JOIN UTP_ListMaster gt on g.GroupTypeID = gt.ListID
		LEFT JOIN UTP_User gm on g.GroupManagerID = gm.UserID
		LEFT JOIN UTP_Group pg on g.ParentGroupID = pg.GroupID
		LEFT JOIN UTP_ListMaster active on g.IsActive = active.ListValue and active.ListKey = 'YesNoValue'




;
GO

-- select * from vw_UTP_GroupMember
create view [dbo].[vw_UTP_GroupMember] as
	SELECT gm.GroupMemberID
		  ,gm.MemberID
		  ,Member = m.Username
		  ,p.FirstName
		  ,p.LastName
		  ,MemberName = p.FirstNAme + ' ' + p.LastName
		  ,gm.JobTitleID
		  ,jt.JobTitle
		  ,g.[GroupID]
		  ,g.[GroupCode]
		  ,g.[GroupName]
		  ,g.[GroupTypeID]
		  ,[GroupType] = gt.ListValue
		  ,g.[GroupManagerID]
		  ,[GroupManager] = gm2.Username
		  ,[IsActive] = case when g.IsActive = 0 then 0 else gm.[IsActive] end
		  ,Active = case when g.IsActive = 0 then 'No' else active.ListText end

	  FROM [dbo].[UTP_Group] g
		INNER JOIN UTP_GroupMember gm on g.GroupID = gm.GroupID
		LEFT JOIN UTP_JobTitle jt on gm.JobTitleID = jt.JobTitleID
		LEFT JOIN UTP_ListMaster gt on g.GroupTypeID = gt.ListID
		LEFT JOIN UTP_User gm2 on g.GroupManagerID = gm2.UserID
		LEFT JOIN UTP_User m on gm.MemberID = m.UserID
		LEFT JOIN UTP_Person p on m.PersonID = p.PersonID
		LEFT JOIN UTP_ListMaster active on gm.IsActive = active.ListValue and active.ListKey = 'YesNoValue'




;
GO
create view [dbo].[vw_UTP_IDList] as select ID = cast(1 as int)




;
GO
CREATE VIEW [dbo].[vw_UTP_ImportBatch]
AS
SELECT        dbo.UTP_ImportBatch.*
FROM            dbo.UTP_ImportBatch




;
GO
CREATE VIEW [dbo].[vw_UTP_ImportData]
AS
SELECT        dbo.UTP_ImportData.*
FROM            dbo.UTP_ImportData




;
GO
CREATE VIEW [dbo].[vw_UTP_ImportHeader]
AS
SELECT        dbo.UTP_ImportHeader.*
FROM            dbo.UTP_ImportHeader




;
GO

CREATE VIEW [dbo].[vw_UTP_JobHistory] as
	select
			JobHistoryID, 
			jh.PersonID,
			PersonName = p.FirstName + ' ' + p.LastName,
			jh.JobTitleID,
			JobTitle,
			EffectiveFromDate,
			EffectiveToDate
		from UTP_JobHistory jh 
			inner join UTP_Person p on jh.PersonID = p.PersonID
			inner join UTP_JobTitle jt on jh.JobTitleID = jt.JobTitleID

;
GO

CREATE VIEW [dbo].[vw_UTP_JobRequirement] as
	SELECT [JobRequirementID] = tr.JobTestReqID
		  ,tr.[JobTitleID]
		  ,[JobTitle]
		  ,tr.[TestID]
		  ,[TestCode]
		  ,[TestTitle]
		  ,[EffectiveFromDate]
		  ,[EffectiveToDate]
	FROM UTP_JobTestReq tr
		INNER JOIN UTP_JobTitle jt on tr.JobTitleID = jt.JobTitleID
		INNER JOIN UTP_Test t on tr.TestID = t.TestID

;
GO
-- select * from vw_UTP_JobTitle order by JobTitle
create view [dbo].[vw_UTP_JobTitle] as
	select	distinct
			JobTitleID, 
			JobTitle, 
			JobDescription
		from UTP_JobTitle
		where IsActive = 1




;
GO

CREATE VIEW [dbo].[vw_UTP_Location] as
	SELECT	LocationID,
			l.GroupID,
			GroupCode,
			GroupName,
			LocationTypeID,
			LocationType = lt.ListText,
			Location,
			StartDate,
			EndDate
		FROM UTP_Location l
			INNER JOIN UTP_Group g on l.GroupID = g.GroupID
			INNER JOIN UTP_ListMaster lt on l.LocationTypeID = lt.ListID

;
GO

CREATE VIEW [dbo].[vw_UTP_OrderHistory] as
	SELECT	OrderHistoryID,
			OrderID = oh.OrderID, 
			WOID = uwo.uWOID,
			WONUM = uwo.WONUM,
			MemoTypeID,
			MemoType = mt.ListText,
			Memo,
			CreatedByID,
			CreatedBy = u.Username,
			CreatedTimestamp = oh.CreatedTimestamp,
			TechnicianID = oh.TechnicianID,
			Technician = t.Username,
			OrderStatusCode,
			StatusTimestamp

		FROM UTP_OrderHistory oh
			INNER JOIN UTP_ListMaster mt on oh.MemoTypeID = mt.ListID
			INNER JOIN UTP_User u on oh.CreatedByID = u.UserID
			LEFT JOIN UTP_WO uwo on oh.OrderID = uwo.OrderID
			--LEFT JOIN EGD_WO ewo on oh.OrderID = ewo.OrderID
			Left JOIN UTP_User t on oh.TechnicianID = t.UserID


;
GO

-- select * from vw_UTP_OrderJobcard
create view [dbo].[vw_UTP_OrderJobcard] as
	select	d.DocumentID,
			DocumentTypeID = isnull(ojc.JobCardTypeID,d.DocumentTypeID),
			DocumentType = isnull(jct.ListText,dt.ListText),
			d.SourceID,
			Source = sc.ListValue,
			d.Filename,
			d.Filetype,
			d.OrigFilename,
			ojc.OrderJobCardID,
			ojc.JobcardLine,
			ojc.CreatedTimestamp,
			ojc.CreatedByID,
			CreatedBy = u.Username,
			TechnicianOnCard = ojc.Technician,
			ojc.TechnicianID,
			Technician = t.Username,
			ojc.ReviewedTimestamp,
			ojc.ReviewedByID,
			ReviewedBy = r.Username,
			ojc.DataEntryStatusID,
			DataEntryStatus = jcs.ListText,
			WONUMOnCard = ojc.WONUM,
			o.OrderID,
			WONUM = uwo.WONUM,
			ojc.CompletionDateOnCard,
			ojc.JobCardMemo,
			DisplayJobCardLink = cast(ojc.JobcardLine as varchar(6)) + ': ' + coalesce(uwo.WONUM,ojc.WONUM,'(Not Set)') + ' / ' + coalesce(jct.ListText,dt.ListText,'(Not Set)')

			-- select *
		from UTP_Document d
			left join UTP_OrderJobCard ojc on ojc.DocumentID = d.DocumentID 
			left join UTP_Listmaster jct on ojc.JobCardTypeID = jct.ListID
			left join UTP_Order o on o.OrderID = ojc.OrderID
			left join UTP_WO uwo on o.OrderID = uwo.OrderID
			--left join EGD_WO ewo on o.OrderID = ewo.OrderID
			left join UTP_Listmaster dt on d.DocumentTypeID = dt.ListID
			left join UTP_Listmaster sc on d.SourceID = dt.ListID
			left join UTP_Listmaster jcs on ojc.DataEntryStatusID = jcs.ListID
			left join UTP_User u on ojc.CreatedByID = u.UserID
			left join UTP_User t on ojc.TechnicianID = t.UserID
			left join UTP_User r on ojc.ReviewedByID = r.UserID


;
GO

-- select * from vw_UTP_Panel
create view [dbo].[vw_UTP_Panel] as
	select	p.PanelID,
			p.PanelName,
			p.PanelTypeID,
			PanelType = pt.ListValue,
			P.ParentPanelID,
			ParentPanel = pp.PanelName,
			p.PanelViewName

		from UTP_Panel p
			inner join UTP_Listmaster pt on p.PanelTypeID = pt.ListID
			left join UTP_Panel pp on p.ParentPanelID = pp.PanelID


;
GO


-- select * from vw_UTP_PanelColumn
create view [dbo].[vw_UTP_PanelColumn] as
	select	pc.PanelColumnID,
			p.PanelID,
			p.PanelName,
			pc.ColumnName,
			da.DataAttributeID,
			da.AttributeName,
			pc.DisplayName,
			pc.HelpText,
			pc.IsActive,
			pc.IsReadOnly,
			pc.IsOptional,
			pc.IsHidden,
			pc.SortOrder,
			pc.DataTypeID,
			DataType = dt.ListValue,
			pc.Length,
			pc.ControlTypeID,
			ControlType = ct.ListValue,
			pc.LoVKey,
			LoVQueryName,
			LoVQueryValueColumn
			LoVQueryDisplayColumn,
			pc.DefaultValue,
			pc.Description,
			pc.LanguageID,
			Language = lang.ListValue,
			pc.FormatString,
			pc.ColumnWidth

		-- select *
		from UTP_PanelColumn pc
			inner join UTP_Panel p on pc.PanelID = p.PanelID
			inner join UTP_DataAttribute da on pc.DataAttributeID = da.DataAttributeID
			inner join UTP_ListMaster dt on pc.DataTypeID = dt.ListID
			inner join UTP_ListMaster ct on pc.ControlTypeID = ct.ListID
			inner join UTP_ListMaster lang on pc.LanguageID = lang.ListID

;
GO
-- select * from vw_UTP_PanelCommand
create view [dbo].[vw_UTP_PanelCommand] as
	select	pc.PanelCommandID,
			p.PanelID,
			p.PanelName,
			pc.ProcedureCalled,
			pc.ModuleID,
			Module = m.ListValue,
			pc.Comments
		from UTP_PanelCommand pc
			inner join UTP_Panel p on pc.PanelID = p.PanelID
			inner join UTP_Listmaster m on pc.ModuleID = m.ListID




;
GO

-- select * from [vw_UTP_Person]
create view [dbo].[vw_UTP_Person] as
	SELECT [PersonID]
		  ,[PersonTypeID]
		  ,[PersonType] = pt.ListText
		  ,[FirstName]
		  ,[LastName]
		  ,[Description]
		  ,p.[PhoneEmailID],
			CellPhone,
			Pager,
			HomePhone,
			OfficePhone,
			Email
		  ,[BusinessName]
	  FROM [dbo].[UTP_Person] p
		left join UTP_PhoneEmail pe on p.PhoneEmailID = pe.PhoneEmailID
		left join UTP_ListMaster pt on p.PersonTypeID = pt.ListID





;
GO

CREATE VIEW [dbo].[vw_UTP_RelatedWO] as
	SELECT	PrimaryOrderID = wo.PrimaryOrderID,
			PrimaryWOID = up.uWOID,
			PrimaryWONUM = up.WONUM,
			RelatedOrderID = wo.RelatedOrderID,
			RelatedWOID = ur.uWOID,
			RelatedWONUM = ur.WONUM,
			RelationTypeID = wo.RelationTypeID,
			RelationType = rt.ListValue,
			ChildJobCodeID = ur.JobCodeID,
			ChildJobCode = NULL,
			ChildAPEQTYPE = NULL,
			ChildActualStart = ur.ActualStart,
			ChildActualFinish = ur.ActualFinish,
			ChildCompletionCode = ur.CompletionCode,
			ChildTechnicianID = ur.TechnicianID,
			ChildTechnician = ut.UserName

		FROM UTP_WOStructure wo
			INNER JOIN UTP_ListMaster rt on wo.RelationTypeID = rt.ListID
			LEFT JOIN UTP_WO up on wo.PrimaryOrderID = up.OrderID
			LEFT JOIN UTP_WO ur on wo.RelatedOrderID = up.OrderID
			--LEFT JOIN EGD_WO ep on wo.PrimaryOrderID = ep.OrderID
			--LEFT JOIN EGD_WO er on wo.RelatedOrderID = er.OrderID
			--LEFT JOIN vw_EGD_JobPlan jp on er.JobCodeID = jp.JobCodeID
			LEFT JOIN UTP_User ut on ur.TechnicianID = ut.UserID
			--LEFT JOIN UTP_User et on er.WAMS_CREWID = et.Username

;
GO
/*
	Update-20180306.sql
	Fix to Techician Booked Appointment calculation W.R.T. Work Schedule
*/
CREATE VIEW [dbo].[vw_UTP_ScheduledAppointments] AS
	-- Limit appointments to (AppointmentType)Scheduled in Booked or Reserved Status
	-- These will only be scheduled in TimeSlots 90301 to 90305
	select ap.TechnicianID, GroupID=uwo.AreaID, CONVERT(date, ap.ApptEndDate) AS ApptEndDate, ap.TimeslotID, Booked = count(*) 
	from UTP_Appointment ap
		LEFT JOIN UTP_WO uwo ON uwo.OrderID=ap.OrderID
		-- LEFT JOIN EGD_WO ewo ON ewo.OrderID=ap.OrderID
		-- LEFT JOIN UTP_Group eg ON eg.GroupCode=ewo.WAMS_REGION
	where ap.AppointmentStatusID in (90321,90329) AND ap.AppointmentTypeID=90311 AND ap.TimeslotID BETWEEN 90301 AND 90305
	group by ap.TechnicianID,uwo.AreaID,CONVERT(date, ap.ApptEndDate), ap.TimeslotID

;
GO
-- select * from [vw_UTP_Search]
CREATE VIEW [dbo].[vw_UTP_Search] AS
	select 
		[OrderID], --=convert(varchar(255),[OrderID]),
		[OrgID],
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID], --=convert(varchar(255),[WOID]),
		[WONUM] = convert(varchar(max), [WONUM]),
		[JobCodeID], --=convert(varchar(255),[JobCodeID]),
		[JobCode],
		WorkType,
		Subtype,
		JobPlan,
		[GroupID], --=convert(varchar(255),[GroupID]),
		[Grid] = convert(varchar(255),[GridID]),
		[DisplayAddress] = convert(varchar(400),[DisplayAddress]),
		[StreetNo],
		[Unit],
		[Street],
		[Town],
		[PostalCode],
		OldMeterSize,
		OldMeterNumber,
		NewMeterSize,
		NewMeterNumber,
		APEQType,
		FromDueDate = [DueDate], --=convert(varchar(10),[DueDate],120),
		ToDueDate = [DueDate],
		FromApptStartDate = ApptStartDate, --=convert(varchar(10),[StartDate],120),
		ToApptStartDate = ApptStartDate, --=convert(varchar(10),[StartDate],120),
		IsFirmAppt,
		[WMStatusID], --=convert(varchar(255),[WMStatusID]),
		[DispatcherID], --=convert(varchar(255),[DispatcherID]),
		[TechnicianID], --=convert(varchar(255),[TechnicianID]),
		FromActualFinish = ActualFinish, --=convert(varchar(10),[CompletionDate]),
		ToActualFinish = ActualFinish,
		[CompletionCode],
		AppointmentID, --=convert(varchar(255),AppointmentID), 
		AppointmentStatusID, --=convert(varchar(255),AppointmentStatusID),
		AppointmentTypeID, --=convert(varchar(255),AppointmentTypeID),
		TimeslotID, --=convert(varchar(255),TimeslotID),
		PremiseNo = cast('' as varchar(25)),
		UtilityComment,
		[CustomerName],
		[CustomerPhone],
		ParentWONUM,
		WODescription,
		ErrorStatus,
		CreatedTimestamp,
		SubmitStatusID,
		SubmitStatus,
		TransmitStatusID,
		TransmitStatus,
		MeterLeftStatus,
		FromReportedDate = ReportedAt,
		ToReportedDate = ReportedAt

		-- select * 
	from vw_UTP_WO

;
GO


-- select * from vw_UTP_WOServiceAddress
CREATE view [dbo].[vw_UTP_WOServiceAddress] as
	SELECT	o.[OrderID],
			[WOID] = uwo.uWOID,
			[WONUM] = uwo.WONUM,
			[OrderAddressID],
			AddressID = oa.[AddressID],
			[AddressTypeID],
			[AddressType] = at.ListText,
			[DisplayAddress] = a.StreetNo + ' ' + a.Street + ' ' + a.StreetType 
							+ case when isnull(a.Sfx,'') <> '' then ' ' + a.Sfx else '' end
							+ case when isnull(a.Unit,'') <> '' then ', Unit ' + a.Unit else '' end 
							+ ', ' + a.Town + ', ' + a.ProvinceCode + ' ' + a.PostalCode,
			[StreetNo] = a.StreetNo,
			[LotNumber] = a.LotNumber,
			[Unit] = a.Unit,
			[Street] = a.Street,
			[StreetType] = a.StreetType,
			[Sfx] = a.Sfx,
			[Misc] = a.Misc,
			[Town] = a.Town,
			[County],
			[ProvinceCode] = a.ProvinceCode,
			[PostalCode] = a.PostalCode,
			[CountryCode] = a.CountryCode,
			MeterSize = cast(isnull(xda.MeterSizeCode,'') as varchar(50)),
			MeterNumber = cast(isnull(xda.MeterNo,'')as varchar(50)),
			MeterLocation = cast(isnull(xda.MeterLocationCode,'') as varchar(50)),
			ServicePressure =cast('' as varchar(25)),
			PremiseNo = cast(isnull(xda.PremiseNo,'') as varchar(25)),
			OrgID = o.OrgID,
			OrgShortName = org.ShortName

	  FROM UTP_Order o
		left JOIN UTP_Org org on o.OrgID = org.OrgID
		LEFT JOIN UTP_WO uwo on o.OrderID = uwo.OrderID
		LEFT JOIN UTP_OrderAddress oa on o.OrderID = oa.OrderID
		LEFT JOIN [UTP_Address] a on oa.AddressID = a.AddressID
		LEFT JOIN vw_UTP_WOXDA xda on o.OrderID = xda.OrderID
		LEFT JOIN UTP_ListMaster at on oa.AddressTypeID = at.ListID
		--LEFT JOIN EGD_WO ewo on o.OrderID = ewo.OrderID
		--LEFT JOIN EGD_WOServiceAddress ea on ewo.WOID = ea.WOID


;
GO

-- select * from vw_UTP_SearchJobCard
create view [dbo].[vw_UTP_SearchJobCard] as
	select	DocumentID,
			DocumentTypeID,
			DocumentType,
			SourceID,
			Source,
			Filename,
			Filetype,
			OrigFilename,
			OrderJobCardID,
			JobcardLine,
			CreatedFromTimestamp = ojc.CreatedTimestamp,
			CreatedToTimestamp = ojc.CreatedTimestamp,
			CreatedByID,
			CreatedBy,
			TechnicianOnCard,
			TechnicianID,
			Technician,
			ReviewedTimestamp,
			ReviewedByID,
			ReviewedBy,
			DataEntryStatusID,
			DataEntryStatus,
			WONUMOnCard,
			OrderID = ojc.OrderID,
			WONUM = ojc.WONUM,
			DisplayAddress,
			CompletedFromDatetime = ojc.CompletionDateOnCard,
			CompletedToDatetime = ojc.CompletionDateOnCard,
			JobCardMemo

			-- select *
		from vw_UTP_OrderJobcard ojc
			left join vw_UTP_WOServiceAddress sa on ojc.OrderID = sa.OrderID


;
GO

CREATE VIEW [dbo].[vw_UTP_Task] as
SELECT [TaskID]
      ,[TaskTypeID] = t.TaskTypeID
	  ,[TaskType] = tt.ListText
      ,[TaskNumber]
      ,[TaskDescription]
      ,[TaskStatusID]
	  ,[TaskStatus] = ts.ListText
      ,[TaskPriorityID]
	  ,[TaskPriority] = tp.ListText
      ,[DueDate]
      ,[CreatedTimestamp] = t.CreatedTimestamp
      ,[CreatedByID]
	  ,[CreatedBy] = cu.Username
      ,[TaskManagerID]
	  ,[TaskManager] = tm.Username
      ,[Category]
      ,[Scope]
      ,[ProjectNumber]
      ,[RaisedDate]
      ,[RaisedBy]
      ,[TargetStart]
      ,[TargetFinish]
	  ,[AssignedToID]
	  ,[AssignedTo] = au.ListText
	  ,[AssignedDate]
      ,[ActualStart]
      ,[ActualFinish]
      ,[CompletedByID]
	  ,[CompletedBy] = cb.Username
      ,[CompletionCode]
      ,[EstimatedDuration]
      ,[ActualDuration]
      ,[Instructions]
      ,[Notes]
      ,[FollowupDate]
      ,[FollowupAction]
      ,[FollowupFreqID]
	  ,[FollowupFreq] = ff.ListText
      ,[CostCenter]

  FROM [UTP_Task] t
	LEFT JOIN UTP_ListMaster tt on t.TaskTypeID = tt.ListID
	LEFT JOIN UTP_ListMaster ts on t.TaskStatusID = ts.ListID
	LEFT JOIN UTP_ListMaster tp on t.TaskPriorityID = tp.ListID
	LEFT JOIN UTP_ListMaster ff on t.FollowupFreqID = ff.ListID
	LEFT JOIN UTP_User cu on t.CreatedByID = cu.UserID
	LEFT JOIN UTP_User tm on t.TaskManagerID = tm.UserID
	LEFT JOIN UTP_ListMaster au on t.AssignedToID = au.ListID
	LEFT JOIN UTP_User cb on t.CompletedByID = cb.UserID

;
GO

 CREATE VIEW [dbo].[vw_UTP_TaskHistory] as
 SELECT	   [TaskHistoryID]
		  ,[TaskID]
		  ,th.[CreatedTimestamp]
		  ,[CreatedByID]
		  ,[CreatedBy] = cu.UserName
		  ,[Memo]
		  ,[MemoTypeID]
		  ,[MemoType] = mt.ListText
		  ,[AssignedToID]
		  ,[AssignedTo] = au.ListText
		  ,[ActualDuration]
  FROM [UTP_TaskHistory] th
	LEFT JOIN UTP_ListMaster mt on th.MemoTypeID = mt.ListID
	LEFT JOIN UTP_ListMaster au on th.AssignedToID = au.ListID
	LEFT JOIN UTP_User cu on th.CreatedByID = cu.UserID

;
GO

-- select * from [vw_UTP_Technician]
CREATE VIEW [dbo].[vw_UTP_Technician] as
	select t.[TechnicianID],
			g.GroupID,
			g.GroupCode,
			g.GroupName,
			gm.GroupMemberID,
			t.UserID,
			u.UserTypeID,
			u.Username,
			[Password] = NULL,
			t.[TechnicianTypeID],
			t.[GSTNo],
			t.[PerformanceFactor],
			t.[Comments],
			t.[InsuranceNum],
			t.[InsuranceExpDate],
			t.[LicenceNum],
			t.[LicenceExpDate],
			t.[HasHandHeld],
			p.[PersonID],
			p.[PersonTypeID],
			p.[FirstName],
			p.[LastName],
			p.[Description],
			p.[BusinessName],
			p.[PhoneEmailID],
			pe.[CellPhone],
			pe.[Pager],
			pe.[HomePhone],
			pe.[OfficePhone],
			pe.[Email],
			[FirstNameLastName] = p.FirstName+' '+ p.LastName,
			[LastNameFirstName] = p.LastName + ', ' + p.FirstName,
			DisplayName =  u.Username + ' Area ' + GroupCode + ' (' + p.FirstName+' '+ p.LastName + ')'

		from [dbo].[UTP_Technician] t
			left join UTP_User u on t.UserID = u.UserID
			left join UTP_Person p on u.PersonID = p.PersonID
			left join UTP_PhoneEmail pe on p.PhoneEmailID = pe.PhoneEmailID
			left join UTP_GroupMember gm on u.UserID = gm.MemberID
			left join UTP_Group g on gm.GroupID = g.GroupID
		where UserTypeID = 70403 -- Technician

;
GO

-- select * from vw_UTP_User order by Username
create view [dbo].[vw_UTP_User] as
	select 
		u.[UserID],
		u.[PersonID],
		u.[UserTypeID],
		[UserType] = ut.ListText,
		u.[UserName],
		u.[Password],
		u.[IsActive],
		p.[PersonTypeID],
		[PersonType] = pt.ListText,
		p.FirstName,
		p.[LastName],
		p.[Description],
		p.[PhoneEmailID],
		pe.CellPhone,
		pe.Pager,
		pe.HomePhone,
		pe.OfficePhone,
		pe.Email,
		p.[BusinessName]

  FROM [dbo].[UTP_User] u
	left join UTP_Person p on p.PersonID = u.PersonID
	left join UTP_PhoneEmail pe on p.PhoneEmailID = pe.PhoneEmailID
	left join UTP_ListMaster ut on u.UserTypeID = ut.ListID
	left join UTP_ListMaster pt on p.PersonTypeID = pt.ListID





;
GO
CREATE VIEW [dbo].[vw_UTP_UserWorkSchedule] as
	select	ws.UserID,
			Username = max(u.Username),
			ws.WorkDate,
			ws.ScheduleTypeID,
			ScheduleType = max(st.ListText),
			ws.GroupID,
			GroupCode = max(g.GroupCode),
			GroupName = max(g.GroupName),
			[WeekDay] = datename(weekday,ws.WorkDate),
			DisplayDate = cast('ddd, mmm dd, yyyy' as varchar(25)),
			Capacity1 = max(case ws.TimeslotID when 90301 then Capacity else 0 end),
			Capacity2 = max(case ws.TimeslotID when 90302 then Capacity else 0 end),
			Capacity3 = max(case ws.TimeslotID when 90303 then Capacity else 0 end),
			Capacity4 = max(case ws.TimeslotID when 90304 then Capacity else 0 end),
			Capacity5 = max(case ws.TimeslotID when 90305 then Capacity else 0 end),
			Timeslot1 = convert(varchar(6),max(case ws.TimeslotID when 90301 then Capacity else 0 end)) + ' / ' + convert(varchar(6),max(case ws.TimeslotID when 90301 then isnull(Booked,0) else 0 end)),
			TimeSlot2 = convert(varchar(6),max(case ws.TimeslotID when 90302 then Capacity else 0 end)) + ' / ' + convert(varchar(6),max(case ws.TimeslotID when 90302 then  isnull(Booked,0) else 0 end)),
			TimeSlot3 = convert(varchar(6),max(case ws.TimeslotID when 90303 then Capacity else 0 end)) + ' / ' + convert(varchar(6),max(case ws.TimeslotID when 90303 then  isnull(Booked,0) else 0 end)),
			TimeSlot4 = convert(varchar(6),max(case ws.TimeslotID when 90304 then Capacity else 0 end)) + ' / ' + convert(varchar(6),max(case ws.TimeslotID when 90304 then  isnull(Booked,0) else 0 end)),
			TimeSlot5 = convert(varchar(6),max(case ws.TimeslotID when 90305 then Capacity else 0 end)) + ' / ' + convert(varchar(6),max(case ws.TimeslotID when 90305 then  isnull(Booked,0) else 0 end))
			-- select  ws.UserID, ws.WorkDate, ws.GroupID, ws.ScheduleTypeID, count(*)
		from UTP_WorkSchedule ws
			inner join UTP_ListMaster ts on ws.TimeSlotID = ts.ListID
			inner join UTP_User u on ws.UserID = u.UserID
			left join UTP_Group g on ws.GroupID = g.GroupID
			left join UTP_ListMaster st on ws.ScheduleTypeID = st.ListID
			left join vw_UTP_AllBookedAppointments a on ws.UserID = a.TechnicianID and ws.WorkDate = a.ApptEndDate and ws.TimeSlotID = a.TimeslotID and ws.GroupID = a.GroupID
			WHERE ws.TimeSlotID BETWEEN 90301 AND 90305
		--where ws.WorkDate > '2/20/2017'
		group by ws.UserID, ws.WorkDate, ws.GroupID, ws.ScheduleTypeID




;
GO
--	June-2018	JRP	LPGS_1455 Added PSN
--	16-Aug-2018	IDM	Added support for CAT_JobCode JobCodeID
CREATE VIEW [dbo].[vw_UTP_WO_UTP] as
	select 
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = Org.ShortName,
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID] = uw.uWOID,
		[WONUM] = cast(uw.WONUM as varchar(15)),
		[JobCodeID] = uw.JobCodeID,
		JobCode = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.JobCode ELSE coalesce(jt.AttributeValue,'(Not set)') + ' / ' + coalesce(jc.AttributeValue,'(Not set)') END,
		WorkType = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.WorkType ELSE coalesce(jt.AttributeValue,'(Not set)') END,
		Subtype = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.SubType ELSE coalesce(jc.AttributeValue,'(Not set)') END,
		JobPlan = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.JobPlan ELSE cast('' as varchar(255)) END,
		WOTypeID = cast(0 as int),
		WOType = cast('PRIMARY' as varchar(50)),
		[GroupID] = ug.GroupID,
		[GroupName] = ug.GroupCode,  -- temp, update procs and datasets to include GroupCorde then change back 
		[GroupCode] = ug.GroupCode,
		[WorkGroupID] = cast(0 as int),
		[WorkGroup] = cast('' as varchar(255)),
		[GridID] = 0,
		[Grid] = uw.Grid,
		[DisplayAddress] = cast(isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
									+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
									+ case when isnull(addr.Misc,'') <> '' then ', ' + isnull(addr.Misc,'') else '' end 
									+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,'')
								as varchar(400)),
		[StreetNo] = addr.StreetNo,
		[Unit] = cast(addr.[Unit] as varchar(30)),
		[Street] = addr.[Street],
		[Town] = addr.[Town],
		[PostalCode] = addr.PostalCode,
		ReportedAt = CAST(NULL as DATETIME),
		ReportedBy = CAST(NULL as varchar(255)),
		DueDate = uw.DueDate, 
		UtilityComment = uw.WONotes,
		IsFirmAppt = a.IsFirmAppt,
		ApptStartDate = case when s.ListText = 'Cancelled' then null else cast(cast(a.ApptStartDate as varchar(12)) + ' ' + left(a.ApptStartTime,2) + ':' + right(a.ApptStartTime,2) as datetime) end,
		ApptEndDate = case when s.ListText = 'Cancelled' then null else cast(cast(a.ApptEndDate as varchar(12)) + ' ' + left(ApptEndTime,2) + ':' + right(ApptEndTime,2) as datetime) end,
		ApptStartTime = isnull(left(a.ApptStartTime,2) + ':' + right(a.ApptStartTime,2),'00:00'),
		ApptEndTime = isnull(left(ApptEndTime,2) + ':' + right(ApptEndTime,2),'23:59'),
		[WMStatusID] = uw.WMStatusID, 
		[WMStatus] = us.ListValue,
		[DispatcherID] = cast(0 as int),
		[Dispatcher] = cast(NULL as varchar(50)),
		[TechnicianID] = coalesce(u.UserID,ut.UserID),
		Technician = coalesce(u.Username,ut.Username),
		ActualStart = coalesce(uw.ActualStart,a.ActualStart),
		ActualFinish = coalesce(uw.ActualFinish,a.ActualFinish),
		CompletionCode = uw.CompletionCode,
		IsBillable = cast(NULL as int),
		NoCharge = cast(NULL as int),
		OldMeterSize = cast(umsc.AttributeValue as varchar(50)),
		OldMeterNumber = cast(umn.AttributeValue as varchar(50)),
		MeterLocation = cast(umlc.AttributeValue as varchar(10)),
		ServicePressure = cast('''' as varchar(25)),
		NewMeterSize = cast('''' as varchar(50)),
		NewMeterNumber = cast('''' as varchar(50)),
		MeterLeftStatus = cast(a.MeterLeftStatus as varchar(10)),
		APEQType = cast(NULL as varchar(50)),
		a.AppointmentID, 
		a.AppointmentStatusID,
		AppointmentStatus = s.ListText,
		a.AppointmentTypeID,
		AppointmentType = t.ListText,
		a.TimeslotID,
		a.SpecialInstructions,
		PremiseNo = cast (upn.AttributeValue as varchar(25)),
		CustomerName = cast(cus.ContactName as varchar(255)),
		CustomerPhone = cast(coalesce(cus.ContactPhone,cus.ContactAlternatePhone) as varchar(50)),
		WODescription = cast(uw.WODescription as varchar(255)),
		ParentWONUM = cast('' as varchar(15)), -- need to get uw.Parent from somewhere
		PrimaryOrd;
GO

CREATE VIEW [dbo].[vw_UTP_WOAppointment] as
	SELECT	AppointmentID,
			a.OrderID, 
			WOID = uwo.uWOID,
			WONUM = cast(uwo.WONUM as varchar(15)),
			AppointmentStatusID,
			AppointmentStatus = s.ListText,
			a.TechnicianID,
			Technician = cast(u.Username as varchar(50)),
			AppointmentTypeID,
			AppointmentType = t.ListText,
			TimeslotID,
			ApptStartDate,
			ApptEndDate,
			ApptStartTime,
			ApptEndTime,
			IsFirmAppt,
			BookedViaID,
			CreateByID,
			a.CreatedTimestamp,
			ExpectedDuration,
			PreferredContactModeID,
			ModifiedByID,
			ModifiedTimestamp,
			SpecialInstructions,
			AccessRestricted,
			MedicalNecessity,
			ContactID,
			ActualStart = isnull(uwo.ActualStart,a.ActualStart),
			ActualFinish = isnull(uwo.ActualFinish,a.ActualFinish),
			CompletionCode = a.CompletionCode

		FROM UTP_Appointment a
			INNER JOIN UTP_ListMaster s on a.AppointmentStatusID = s.ListID
			INNER JOIN UTP_ListMaster t on a.AppointmentTypeID = t.ListID
			INNER JOIN UTP_User u on a.TechnicianID = u.UserID
			LEFT JOIN UTP_WO uwo on a.OrderID = uwo.OrderID
			-- LEFT JOIN EGD_WO ewo on a.OrderID = ewo.OrderID


;
GO

CREATE VIEW [dbo].[vw_UTP_WOCustomer] as
	SELECT	o.OrderID,
			CustomerName = occ.ContactName,
			CustomerPhone = coalesce(occ.ContactPhone,occ.ContactAlternatePhone),
			CustomerEmail = occ.ContactEmail,
			ContactName = con.ContactName,
			ContactPhone = con.ContactPhone,
			ContactAlternatePhone = con.ContactAlternatePhone,
			ContactEmail = con.ContactEmail,
			LatestLetterDate = cast(null as date),
			CustomerType = NULL,
			CustomerOnsiteContact = NULL,
			CustomerContact1_Name = NULL,
			CustomerContact1_Phone = NULL,
			CustomerContact1_Mobile = NULL,
			CustomerContact2_Name = NULL,
			CustomerContact2_Phone = NULL,
			CustomerContact2_Mobile = NULL,
			CustomerLanguageCode = NULL

		FROM UTP_Order o
			LEFT JOIN UTP_Contact occ on o.OrderID = occ.OrderID and occ.ContactTypeID = 1801 --occupant
			--LEFT JOIN UTP_Appointment a on o.OrderID = a.OrderID and a.AppointmentStatusID <> 90322
			LEFT JOIN UTP_Contact con on o.OrderID = con.OrderID  and con.ContactTypeID = 1803 --contact
			-- LEFT JOIN EGD_WO ew	on o.OrderID = ew.OrderID
			-- LEFT JOIN EGD_PlusPCustomer ec on ew.WOID = ec.WOID



;
GO
-- select * from [vw_UTP_WOHeader] 

CREATE view [dbo].[vw_UTP_WOHeader] as
	select
		OrgID = o.OrgID,
		OrderID = o.OrderID,
		WONUM = uw.WONUM,
		JobCode = CASE WHEN jpt.JobCodeID IS NOT NULL THEN jpt.JobCode ELSE coalesce(jt.AttributeValue,'(Not set)') + ' / ' + coalesce(jc.AttributeValue,'(Not set)') END,
		JobCodeID = uw.JobCodeID,
		[WMStatusID] = uw.WMStatusID,
		WMStatus = us.ListValue

	FROM [UTP_Order] o (nolock)
		--LEFT JOIN [EGD_WO] ew (nolock) on o.OrderID = ew.OrderID
		--LEFT JOIN vw_EGD_JobPlan jp on ew.JobCodeID = jp.JobCodeID
		--LEFT JOIN UTP_ListMaster es (nolock) on ew.StatusID = es.ListID
		LEFT JOIN [UTP_WO] uw (nolock) on o.OrderID = uw.OrderID
		LEFT JOIN [UTP_ListMaster] us (nolock) on uw.WMStatusID = us.ListID
--		LEFT JOIN vw_UTP_WOXDA xda (nolock) on o.OrderID = xda.OrderID
		LEFT JOIN [vw_CAT_JobPlanT] jpt with(nolock) ON uw.JobCodeID=jpt.JobCodeID
		LEFT JOIN [UTP_DataAttribute] jca with(nolock) ON jca.AttributeName='JobCode'
		LEFT JOIN [UTP_Spec] jc with(nolock) on jca.DataAttributeID=jc.DataAttributeID AND jc.OrderID=o.OrderID
		LEFT JOIN [UTP_DataAttribute] jta with(nolock) ON jta.AttributeName='JobType'
		LEFT JOIN [UTP_Spec] jt with(nolock) ON jta.DataAttributeID=jt.DataAttributeID AND jt.OrderID=o.OrderID

	WHERE o.OrderID is not null

;
GO

CREATE VIEW [dbo].[vw_UTP_WOPremiseHistory] as
	select	OrderID = wo2.OrderID,
			WONUM = wo2.WONUM, 
			WorkType = wo2.WorkType,
			Technician = wo2.Technician,
			CompletionCode = wo2.CompletionCode,
			DueDate = wo2.DueDate,
			JobCode = wo2.JobCode,
			Comments = null

		from vw_UTP_WO wo1
			left join vw_UTP_WO wo2 on wo1.DisplayAddress = wo2.DisplayAddress

;
GO
create view [dbo].[vw_UTP_WORelight] as
	SELECT	OrderID,
			DayTimeTechnicianID = wo.TechnicianID,
			DayTimeTechnician = wo.Technician,
			AfterHoursTechnicianID = 1,
			AfterHoursTechnician = cast('' as varchar(50)),
			CurrentMeterStatus = wo.MeterLeftStatus,
			CompletionDate = wo.ActualFinish

		FROM vw_UTP_WO wo


;
GO

CREATE VIEW [dbo].[vw_UTP_WORemark] as
	SELECT	OrderHistoryID,
			OrderID = oh.OrderID,
			WOID = uwo.uWOID,
			WONUM = uwo.WONUM,
			CreatedTimestamp = oh.CreatedTimestamp,
			CreatedByID = oh.CreatedByID,
			CreatedBy = u.Username,
			MemoTypeID = oh.MemoTypeID,
			MemoType = mt.ListText,
			Memo = oh.Memo,
			TechnicianID = oh.TechnicianID,
			Technician = t.Username

		FROM UTP_OrderHistory oh
			INNER JOIN UTP_ListMaster mt on oh.MemoTypeID = mt.ListID
			LEFT JOIN UTP_User u on oh.CreatedBYID = u.UserID
			LEFT JOIN UTP_User t on oh.TechnicianID = t.UserID
			LEFT JOIN UTP_WO uwo on oh.OrderID = uwo.OrderId
			--LEFT JOIN EGD_WO ewo on oh.OrderID = ewo.OrderId

;
GO

-- LPGS-265 Time-off (vacation, sick, personal appts)
CREATE view [dbo].[vw_UTP_WorkSchedule] as
	select 
		[WorkScheduleID],
		[ScheduleTypeID],
		[ScheduleType] = st.ListText,
		w.[UserID],
		[Username],
		DisplayName = g.GroupCode + ' / ' + Username + case w.ScheduleTypeID when 90350 then ' (' + convert(varchar(6),Capacity) + ' / ' + convert(varchar(6),isnull(a.Booked,0)) + ')' else '' end,
		w.[WorkDate],
		w.[TimeSlotID],
		[Timeslot] = t.ListText,
		[Capacity],
		[Booked],
		w.[GroupID],
		Groupname,
		TimeOffReasonID,
		TimeOffReason = tor.ListText

	FROM UTP_WorkSchedule w
		left join UTP_User u on w.UserID = u.UserID
		left join vw_UTP_AllBookedAppointments a on w.UserID = a.TechnicianID and w.WorkDate = a.ApptEndDate and w.TimeSlotID = a.TimeslotID and w.GroupID = a.GroupID
		left join UTP_Group g on w.GroupID = g.GroupID
		left join UTP_ListMaster t on w.TimeslotID = t.ListID
		left join UTP_ListMaster st on w.ScheduleTypeID = st.ListID
		left join UTP_ListMaster tor on w.TimeOffReasonID = tor.ListID



;
GO
CREATE UNIQUE INDEX resource_resource_id 
  ON resource (resource_id);
CREATE UNIQUE INDEX cost_code_cost_code_id 
  ON cost_code (cost_code_id);
CREATE UNIQUE INDEX resource_skills_resource_skill_id 
  ON resource_skills (resource_skill_id);
CREATE UNIQUE INDEX skills_skill_id 
  ON skills (skill_id);
CREATE UNIQUE INDEX skill_rating_skill_rating_id 
  ON skill_rating (skill_rating_id);
CREATE UNIQUE INDEX job_code_skills_job_code_skills_id 
  ON job_code_skills (job_code_skills_id);
CREATE UNIQUE INDEX job_code_job_code_id 
  ON job_code (job_code_id);
CREATE NONCLUSTERED INDEX idx_Appt_Rule_AppNameID 
  ON dbo.Appt_Rule (AppNameID);
CREATE NONCLUSTERED INDEX idx_Appt_Rule_EffectiveFromDate 
  ON dbo.Appt_Rule (EffectiveFromDate);
CREATE NONCLUSTERED INDEX idx_Appt_Rule_EffectiveToDate 
  ON dbo.Appt_Rule (EffectiveToDate);
CREATE NONCLUSTERED INDEX idx_Appt_Rule_Area 
  ON dbo.Appt_Rule (Area);
CREATE NONCLUSTERED INDEX idx_Appt_Rule_JobCode 
  ON dbo.Appt_Rule (JobCode);
CREATE NONCLUSTERED INDEX idx_Appt_Rule_JobType 
  ON dbo.Appt_Rule (JobType);
CREATE CLUSTERED INDEX idx_Appt_RuleParameter_RuleID 
  ON dbo.Appt_RuleParameter (RuleID);
CREATE NONCLUSTERED INDEX IDX_HHActORNU 
  ON dbo.HH_Action (OrderID);
CREATE NONCLUSTERED INDEX IDX_HHCanRORNU 
  ON dbo.HH_CancelRaise (OrderID);
CREATE NONCLUSTERED INDEX IDX_HHCompORNU 
  ON dbo.HH_Completion (OrderID);
CREATE NONCLUSTERED INDEX IDX_HHFAORNU 
  ON dbo.HH_FieldAttribute (OrderID);
CREATE NONCLUSTERED INDEX IDX_HHImageDORNU 
  ON dbo.HH_ImageData (OrderID);
CREATE NONCLUSTERED INDEX IDX_HHNoteORNU 
  ON dbo.HH_Note (OrderID);
CREATE NONCLUSTERED INDEX IDX_HHRCompORNU 
  ON dbo.HH_RaiseComplete (OrderID);
CREATE NONCLUSTERED INDEX IDX_HHRemORNU 
  ON dbo.HH_Remark (OrderID);
CREATE NONCLUSTERED INDEX idx_UTP_Appointment_3 
  ON dbo.UTP_Appointment (TechnicianID, TimeslotID, ApptEndDate, AppointmentStatusID);
CREATE NONCLUSTERED INDEX idx_UTP_Appointment_2 
  ON dbo.UTP_Appointment (AppointmentTypeID, AppointmentStatusID, TimeslotID, ApptEndDate);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Appointment_5_2004202190__K4_K1_2_15_16 
  ON dbo.UTP_Appointment (OrderID, AppointmentID);
CREATE NONCLUSTERED INDEX idx_UTP_Appointment_1 
  ON dbo.UTP_Appointment (OrderID);
CREATE NONCLUSTERED INDEX idx_UTP_Appointment_6 
  ON dbo.UTP_Appointment (AppointmentTypeID);
CREATE NONCLUSTERED INDEX idx_Appointment_4 
  ON dbo.UTP_Appointment (AppointmentStatusID, TimeslotID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Appointment_5_2004202190__K4_K1_K5_K3_K2_6_13_15_16_17_18_19_20_25_26 
  ON dbo.UTP_Appointment (OrderID, AppointmentID, AppointmentStatusID, AppointmentTypeID, TechnicianID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Appointment_5_2004202190__K4_K1 
  ON dbo.UTP_Appointment (OrderID, AppointmentID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Appointment_5_2004202190__K4_K1_K2 
  ON dbo.UTP_Appointment (OrderID, AppointmentID, TechnicianID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Appointment_5_2004202190__K1_K2_K4_K3_K5_6_13_15_16_17_18_19_20_25_26 
  ON dbo.UTP_Appointment (AppointmentID, TechnicianID, OrderID, AppointmentTypeID, AppointmentStatusID);
CREATE NONCLUSTERED INDEX idx_UTP_Contact_1 
  ON dbo.UTP_Contact (OrderID, ContactTypeID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Contact_5_2100202532__K4_K2 
  ON dbo.UTP_Contact (ContactTypeID, OrderID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Contact_5_2100202532__K4_K2_K1_5_7_8 
  ON dbo.UTP_Contact (ContactTypeID, OrderID, ContactID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Contact_5_2100202532__K4_2_5_7_8 
  ON dbo.UTP_Contact (ContactTypeID);
CREATE NONCLUSTERED INDEX idx_UTP_DataAttribute_1 
  ON dbo.UTP_DataAttribute (DataAttributeID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Document_5_160719625__K10_K8_K1_K3_5_9 
  ON dbo.UTP_Document (Filetype, SourceID, DocumentID, DocumentTypeID);
CREATE NONCLUSTERED INDEX idx_UTP_ListMaster_1 
  ON dbo.UTP_ListMaster (ListID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Order_5_752721734__K2_K1_4 
  ON dbo.UTP_Order (OrgID, OrderID);
CREATE NONCLUSTERED INDEX idx_UTP_Order_1 
  ON dbo.UTP_Order (OrgID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Order_5_752721734__K1_2_4 
  ON dbo.UTP_Order (OrderID);
CREATE NONCLUSTERED INDEX idx_UTP_OrderAddress_1 
  ON dbo.UTP_OrderAddress (OrderID);
CREATE NONCLUSTERED INDEX IDX_OHWONUM 
  ON dbo.UTP_OrderHistory (OrderID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Spec_5_1760725325__K2_K1_K3_5 
  ON dbo.UTP_Spec (OrderID, SpecID, DataAttributeID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_Spec_5_1760725325__K3_K2_5 
  ON dbo.UTP_Spec (DataAttributeID, OrderID);
CREATE NONCLUSTERED INDEX idx_UTP_Spec_2 
  ON dbo.UTP_Spec (DataAttributeID, AttributeValue);
CREATE NONCLUSTERED INDEX idx_UTP_Spec_1 
  ON dbo.UTP_Spec (OrderID);
CREATE NONCLUSTERED INDEX idx_WorkSchedule_2 
  ON dbo.UTP_WorkSchedule (WorkDate);
CREATE NONCLUSTERED INDEX idx_UTP_WorkSchedule_1 
  ON dbo.UTP_WorkSchedule (UserID);
CREATE NONCLUSTERED INDEX idx_WOStructure_1 
  ON dbo.UTP_WOStructure (RelatedOrderID);
CREATE CLUSTERED INDEX _dta_index_UTP_WOStructure_c_5_157243615__K1_K2_K3 
  ON dbo.UTP_WOStructure (PrimaryOrderID, RelatedOrderID, RelationTypeID);
CREATE NONCLUSTERED INDEX idx_UTP_WO_2 
  ON dbo.UTP_WO (ServiceAddress);
CREATE NONCLUSTERED INDEX idx_UTP_WO_1 
  ON dbo.UTP_WO (OrderID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_WO_5_45243216__K2 
  ON dbo.UTP_WO (OrderID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_WO_5_45243216__K1_2_3 
  ON dbo.UTP_WO (uWOID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_WO_5_45243216__K1_3_4_9_10_11_12 
  ON dbo.UTP_WO (uWOID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_WO_5_45243216__K2_K1_K5_K9_K18_K17_K7_3_4_6_10_11_12_13_14_15 
  ON dbo.UTP_WO (OrderID, uWOID, AreaID, TechnicianID, TransmitStatusID, SubmitStatusID, WMStatusID);
CREATE NONCLUSTERED INDEX _dta_index_UTP_WO_5_45243216__K2_K9_1_3_4_10_11_12 
  ON dbo.UTP_WO (OrderID, TechnicianID);
ALTER TABLE job_code_skills ADD CONSTRAINT FKjob_code_s980686 FOREIGN KEY (job_code_id) REFERENCES job_code (job_code_id);
ALTER TABLE job_code_skills ADD CONSTRAINT FKjob_code_s539092 FOREIGN KEY (skill_id) REFERENCES skills (skill_id);
ALTER TABLE [resource_skills	] ADD CONSTRAINT FKresource_s325301 FOREIGN KEY (skill_id) REFERENCES skills (skill_id);
ALTER TABLE [resource_skills	] ADD CONSTRAINT FKresource_s4018 FOREIGN KEY (skill_rating_id) REFERENCES skill_rating (skill_rating_id);
ALTER TABLE [resource_skills	] ADD CONSTRAINT FKresource_s992286 FOREIGN KEY (resource_id) REFERENCES resource (resource_id);
ALTER TABLE resource ADD CONSTRAINT FKresource931082 FOREIGN KEY (cost_code_id) REFERENCES cost_code (cost_code_id);
ALTER TABLE dbo.CAT_JobCode ADD CONSTRAINT FK__CAT_JobCo__Prima__4979DDF4 FOREIGN KEY (PrimaryTemplateID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.CAT_TemplateAttribute ADD CONSTRAINT FK__CAT_Templ__Templ__4A6E022D FOREIGN KEY (TemplateID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_Action ADD CONSTRAINT FK_HH_Action_PT FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_CancelRaise ADD CONSTRAINT FK_HH_CancelRaise_PT FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_Completion ADD CONSTRAINT FK_HH_Completion_PT FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_FieldAttribute ADD CONSTRAINT FK_HH_FieldAttribute_PT FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_FieldAttribute ADD CONSTRAINT FK_HH_FieldAttributeRC_PT FOREIGN KEY (HH_RaiseCompleteID) REFERENCES dbo.HH_RaiseComplete (HH_RaiseCompleteID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_FieldAttribute ADD CONSTRAINT FK_HH_FieldAttributeC_PT FOREIGN KEY (HH_CompletionID) REFERENCES dbo.HH_Completion (HH_CompletionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_ImageData ADD CONSTRAINT FK_HH_ImageData_PT FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_ImageData ADD CONSTRAINT FK_HH_ImageData_Doc FOREIGN KEY (UTPDocumentID) REFERENCES dbo.UTP_Document (DocumentID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_Note ADD CONSTRAINT FK_HH_Note_PT FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_RaiseComplete ADD CONSTRAINT FK_HH_RaiseComplete_PT FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_Remark ADD CONSTRAINT FK_HH_Remark_PT FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_Remark ADD CONSTRAINT FK_HH_RemarkRC_PT FOREIGN KEY (HH_RaiseCompleteID) REFERENCES dbo.HH_RaiseComplete (HH_RaiseCompleteID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.HH_Remark ADD CONSTRAINT FK_HH_RemarkC_PT FOREIGN KEY (HH_CompletionID) REFERENCES dbo.HH_Completion (HH_CompletionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Appointment ADD CONSTRAINT FK_UTP_Appt_TechID FOREIGN KEY (TechnicianID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Appointment ADD CONSTRAINT FK__UTP_Appoi__Appoi__57C7FD4B FOREIGN KEY (AppointmentTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Appointment ADD CONSTRAINT FK__UTP_Appoi__Appoi__58BC2184 FOREIGN KEY (AppointmentTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Appointment ADD CONSTRAINT FK__UTP_Appoi__Appoi__59B045BD FOREIGN KEY (AppointmentTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Appointment ADD CONSTRAINT FK__UTP_Appoi__Appoi__5AA469F6 FOREIGN KEY (AppointmentTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_CODetail ADD CONSTRAINT FK__UTP_CODet__Order__5C8CB268 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_CODetail ADD CONSTRAINT FK__UTP_CODet__Order__5D80D6A1 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_CODetail ADD CONSTRAINT FK__UTP_CODet__Order__5E74FADA FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_CODetail ADD CONSTRAINT FK__UTP_CODet__Order__5F691F13 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Contact ADD CONSTRAINT FK__UTP_Conta__Order__605D434C FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Contact ADD CONSTRAINT FK__UTP_Conta__Order__61516785 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Contact ADD CONSTRAINT FK__UTP_Conta__Order__62458BBE FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Contact ADD CONSTRAINT FK__UTP_Conta__Order__6339AFF7 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Customer ADD CONSTRAINT FK__UTP_Custo__OrgID__642DD430 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Customer ADD CONSTRAINT FK__UTP_Custo__OrgID__6521F869 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Customer ADD CONSTRAINT FK__UTP_Custo__OrgID__66161CA2 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Customer ADD CONSTRAINT FK__UTP_Custo__OrgID__670A40DB FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__DataT__67FE6514 FOREIGN KEY (DataTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__DataT__68F2894D FOREIGN KEY (DataTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__DataT__69E6AD86 FOREIGN KEY (DataTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__DataT__6ADAD1BF FOREIGN KEY (DataTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__VAdde__6BCEF5F8 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__VAdde__6CC31A31 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__VAdde__6DB73E6A FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__VAdde__6EAB62A3 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__VRemo__6F9F86DC FOREIGN KEY (VRemoved) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__VRemo__7093AB15 FOREIGN KEY (VRemoved) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__VRemo__7187CF4E FOREIGN KEY (VRemoved) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DataAttribute ADD CONSTRAINT FK__UTP_DataA__VRemo__727BF387 FOREIGN KEY (VRemoved) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Document ADD CONSTRAINT FK_UTP_Document_RepositoryID FOREIGN KEY (DocumentRepositoryID) REFERENCES dbo.UTP_DocumentStorage (DocumentStorageID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Document ADD CONSTRAINT FK_UTP_Document_CreatedByID FOREIGN KEY (CreatedById) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Document ADD CONSTRAINT FK_UTP_Document_SourceID FOREIGN KEY (SourceID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DocumentStorage ADD CONSTRAINT FK_UTP_DocumentStorage_DocumentTypeID FOREIGN KEY (DocumentTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_DocumentStorage ADD CONSTRAINT FK_UTP_DocumentStorage_OrgID FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Entity ADD CONSTRAINT FK__UTP_Entit__VAdde__7834CCDD FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Entity ADD CONSTRAINT FK__UTP_Entit__VAdde__7928F116 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Entity ADD CONSTRAINT FK__UTP_Entit__VAdde__7A1D154F FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Entity ADD CONSTRAINT FK__UTP_Entit__VAdde__7B113988 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Entity ADD CONSTRAINT FK__UTP_Entit__VRemo__7C055DC1 FOREIGN KEY (VRemovedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Entity ADD CONSTRAINT FK__UTP_Entit__VRemo__7CF981FA FOREIGN KEY (VRemovedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Entity ADD CONSTRAINT FK__UTP_Entit__VRemo__7DEDA633 FOREIGN KEY (VRemovedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Entity ADD CONSTRAINT FK__UTP_Entit__VRemo__7EE1CA6C FOREIGN KEY (VRemovedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__Entit__03A67F89 FOREIGN KEY (EntityID) REFERENCES dbo.UTP_Entity (EntityID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__Entit__049AA3C2 FOREIGN KEY (EntityID) REFERENCES dbo.UTP_Entity (EntityID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__Entit__058EC7FB FOREIGN KEY (EntityID) REFERENCES dbo.UTP_Entity (EntityID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__Entit__0682EC34 FOREIGN KEY (EntityID) REFERENCES dbo.UTP_Entity (EntityID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__DataA__00CA12DE FOREIGN KEY (DataAttributeID) REFERENCES dbo.UTP_DataAttribute (DataAttributeID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__DataA__01BE3717 FOREIGN KEY (DataAttributeID) REFERENCES dbo.UTP_DataAttribute (DataAttributeID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__DataA__02B25B50 FOREIGN KEY (DataAttributeID) REFERENCES dbo.UTP_DataAttribute (DataAttributeID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__DataA__7FD5EEA5 FOREIGN KEY (DataAttributeID) REFERENCES dbo.UTP_DataAttribute (DataAttributeID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__VAdde__0777106D FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__VAdde__086B34A6 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__VAdde__095F58DF FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__VAdde__0A537D18 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__VRemo__0B47A151 FOREIGN KEY (VRemovedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__VRemo__0C3BC58A FOREIGN KEY (VRemovedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__VRemo__0D2FE9C3 FOREIGN KEY (VRemovedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_EntityAttribute ADD CONSTRAINT FK__UTP_Entit__VRemo__0E240DFC FOREIGN KEY (VRemovedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK__UTP_Group__Group__0F183235 FOREIGN KEY (GroupTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK__UTP_Group__Group__11007AA7 FOREIGN KEY (GroupTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK__UTP_Group__Group__12E8C319 FOREIGN KEY (GroupTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK__UTP_Group__Group__14D10B8B FOREIGN KEY (GroupTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK__UTP_Group__Group__100C566E FOREIGN KEY (GroupManagerID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK__UTP_Group__Group__11F49EE0 FOREIGN KEY (GroupManagerID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK__UTP_Group__Group__13DCE752 FOREIGN KEY (GroupManagerID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK__UTP_Group__Group__15C52FC4 FOREIGN KEY (GroupManagerID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Group ADD CONSTRAINT FK_UTP_Group_ParentGroupID FOREIGN KEY (ParentGroupID) REFERENCES dbo.UTP_Group (GroupID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_GroupMember ADD CONSTRAINT FK__UTP_Group__Membe__1B7E091A FOREIGN KEY (MemberID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_GroupMember ADD CONSTRAINT FK__UTP_Group__Membe__1C722D53 FOREIGN KEY (MemberID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_GroupMember ADD CONSTRAINT FK__UTP_Group__Membe__1D66518C FOREIGN KEY (MemberID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_GroupMember ADD CONSTRAINT FK__UTP_Group__Membe__1E5A75C5 FOREIGN KEY (MemberID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_GroupMember ADD CONSTRAINT FK__UTP_Group__JobTi__17AD7836 FOREIGN KEY (JobTitleID) REFERENCES dbo.UTP_JobTitle (JobTitleID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_GroupMember ADD CONSTRAINT FK__UTP_Group__JobTi__18A19C6F FOREIGN KEY (JobTitleID) REFERENCES dbo.UTP_JobTitle (JobTitleID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_GroupMember ADD CONSTRAINT FK__UTP_Group__JobTi__1995C0A8 FOREIGN KEY (JobTitleID) REFERENCES dbo.UTP_JobTitle (JobTitleID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_GroupMember ADD CONSTRAINT FK__UTP_Group__JobTi__1A89E4E1 FOREIGN KEY (JobTitleID) REFERENCES dbo.UTP_JobTitle (JobTitleID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ImportBatch ADD CONSTRAINT FK_UTP_ImportBatch_UTP_ImportTemplate FOREIGN KEY (BatchStatusID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ImportBatch ADD CONSTRAINT FK_UTP_ImportBatch_UTP_ListMaster FOREIGN KEY (BatchStatusID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ImportBatch ADD CONSTRAINT FK_UTP_ImportBatch_UTP_User FOREIGN KEY (CreatedByID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ImportData ADD CONSTRAINT FK_UTP_ImportData_UTP_ImportBatch FOREIGN KEY (ImportBatchID) REFERENCES dbo.UTP_ImportBatch (ImportBatchID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ImportData ADD CONSTRAINT FK_UTP_ImportData_UTP_ListMaster FOREIGN KEY (ImportStatusID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ImportMap ADD CONSTRAINT FK_UTP_ImportMap_UTP_ImportTemplate FOREIGN KEY (ImportTemplateID) REFERENCES dbo.UTP_ImportTemplate (ImportTemplateID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ImportTemplate ADD CONSTRAINT FK_UTP_ImportTemplate_UTP_ListMaster FOREIGN KEY (ImportTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ListMaster ADD CONSTRAINT FK__UTP_ListM__VAdde__25FB978D FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ListMaster ADD CONSTRAINT FK__UTP_ListM__VAdde__26EFBBC6 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ListMaster ADD CONSTRAINT FK__UTP_ListM__VAdde__27E3DFFF FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ListMaster ADD CONSTRAINT FK__UTP_ListM__VAdde__28D80438 FOREIGN KEY (VAddedID) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ListMaster ADD CONSTRAINT FK__UTP_ListM__VRemo__29CC2871 FOREIGN KEY (VRemoved) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ListMaster ADD CONSTRAINT FK__UTP_ListM__VRemo__2AC04CAA FOREIGN KEY (VRemoved) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ListMaster ADD CONSTRAINT FK__UTP_ListM__VRemo__2BB470E3 FOREIGN KEY (VRemoved) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_ListMaster ADD CONSTRAINT FK__UTP_ListM__VRemo__2CA8951C FOREIGN KEY (VRemoved) REFERENCES dbo.UTP_Version (VersionID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Order ADD CONSTRAINT FK__UTP_Order__OrgID__316D4A39 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Order ADD CONSTRAINT FK__UTP_Order__OrgID__32616E72 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Order ADD CONSTRAINT FK__UTP_Order__OrgID__335592AB FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Order ADD CONSTRAINT FK__UTP_Order__OrgID__3449B6E4 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Order ADD CONSTRAINT FK__UTP_Order__Order__2D9CB955 FOREIGN KEY (OrderTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Order ADD CONSTRAINT FK__UTP_Order__Order__2E90DD8E FOREIGN KEY (OrderTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Order ADD CONSTRAINT FK__UTP_Order__Order__2F8501C7 FOREIGN KEY (OrderTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Order ADD CONSTRAINT FK__UTP_Order__Order__30792600 FOREIGN KEY (OrderTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Order__3CDEFCE5 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Order__3DD3211E FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Order__3EC74557 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Order__3FBB6990 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Addre__73FA27A5 FOREIGN KEY (AddressID) REFERENCES dbo.UTP_Address (AddressID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Addre__75E27017 FOREIGN KEY (AddressID) REFERENCES dbo.UTP_Address (AddressID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Addre__77CAB889 FOREIGN KEY (AddressID) REFERENCES dbo.UTP_Address (AddressID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Addre__79B300FB FOREIGN KEY (AddressID) REFERENCES dbo.UTP_Address (AddressID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Addre__3631FF56 FOREIGN KEY (AddressTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Addre__381A47C8 FOREIGN KEY (AddressTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Addre__3A02903A FOREIGN KEY (AddressTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrderAddress ADD CONSTRAINT FK__UTP_Order__Addre__3BEAD8AC FOREIGN KEY (AddressTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__OrgID__4850AF91 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__OrgID__4944D3CA FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__OrgID__4A38F803 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__OrgID__4B2D1C3C FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__Addre__005FFE8A FOREIGN KEY (AddressID) REFERENCES dbo.UTP_Address (AddressID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__Addre__024846FC FOREIGN KEY (AddressID) REFERENCES dbo.UTP_Address (AddressID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__Addre__04308F6E FOREIGN KEY (AddressID) REFERENCES dbo.UTP_Address (AddressID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__Addre__0618D7E0 FOREIGN KEY (AddressID) REFERENCES dbo.UTP_Address (AddressID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__Addre__41A3B202 FOREIGN KEY (AddressTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__Addre__438BFA74 FOREIGN KEY (AddressTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__Addre__457442E6 FOREIGN KEY (AddressTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAddress ADD CONSTRAINT FK__UTP_OrgAd__Addre__475C8B58 FOREIGN KEY (AddressTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAttribute ADD CONSTRAINT FK__UTP_OrgAt__OrgID__4FF1D159 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAttribute ADD CONSTRAINT FK__UTP_OrgAt__OrgID__50E5F592 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAttribute ADD CONSTRAINT FK__UTP_OrgAt__OrgID__51DA19CB FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAttribute ADD CONSTRAINT FK__UTP_OrgAt__OrgID__52CE3E04 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAttribute ADD CONSTRAINT FK__UTP_OrgAt__DataA__4C214075 FOREIGN KEY (DataAttributeID) REFERENCES dbo.UTP_DataAttribute (DataAttributeID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAttribute ADD CONSTRAINT FK__UTP_OrgAt__DataA__4D1564AE FOREIGN KEY (DataAttributeID) REFERENCES dbo.UTP_DataAttribute (DataAttributeID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAttribute ADD CONSTRAINT FK__UTP_OrgAt__DataA__4E0988E7 FOREIGN KEY (DataAttributeID) REFERENCES dbo.UTP_DataAttribute (DataAttributeID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgAttribute ADD CONSTRAINT FK__UTP_OrgAt__DataA__4EFDAD20 FOREIGN KEY (DataAttributeID) REFERENCES dbo.UTP_DataAttribute (DataAttributeID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgPermission ADD CONSTRAINT FK__UTP_OrgPe__OrgID__53C2623D FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgPermission ADD CONSTRAINT FK__UTP_OrgPe__OrgID__54B68676 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgPermission ADD CONSTRAINT FK__UTP_OrgPe__OrgID__55AAAAAF FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgPermission ADD CONSTRAINT FK__UTP_OrgPe__OrgID__569ECEE8 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgPermission ADD CONSTRAINT FK__UTP_OrgPe__UserI__5792F321 FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgPermission ADD CONSTRAINT FK__UTP_OrgPe__UserI__5887175A FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgPermission ADD CONSTRAINT FK__UTP_OrgPe__UserI__597B3B93 FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_OrgPermission ADD CONSTRAINT FK__UTP_OrgPe__UserI__5A6F5FCC FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Personnel ADD CONSTRAINT FK__UTP_Perso__OrgID__1A54DAB7 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Personnel ADD CONSTRAINT FK__UTP_Perso__OrgID__1B48FEF0 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Personnel ADD CONSTRAINT FK__UTP_Perso__OrgID__1C3D2329 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Personnel ADD CONSTRAINT FK__UTP_Perso__OrgID__1D314762 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_PODetail ADD CONSTRAINT FK__UTP_PODet__Order__21F5FC7F FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_PODetail ADD CONSTRAINT FK__UTP_PODet__Order__22EA20B8 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_PODetail ADD CONSTRAINT FK__UTP_PODet__Order__23DE44F1 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_PODetail ADD CONSTRAINT FK__UTP_PODet__Order__24D2692A FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Provider ADD CONSTRAINT FK__UTP_Provi__OrgID__25C68D63 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Provider ADD CONSTRAINT FK__UTP_Provi__OrgID__26BAB19C FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Provider ADD CONSTRAINT FK__UTP_Provi__OrgID__27AED5D5 FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Provider ADD CONSTRAINT FK__UTP_Provi__OrgID__28A2FA0E FOREIGN KEY (OrgID) REFERENCES dbo.UTP_Org (OrgID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_RunAtQ ADD CONSTRAINT FK_UTP_RunAtQ_UTP_ImportBatch FOREIGN KEY (ImportBatchID) REFERENCES dbo.UTP_ImportBatch (ImportBatchID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_User ADD CONSTRAINT FK__UTP_User__UserTy__30441BD6 FOREIGN KEY (UserTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_User ADD CONSTRAINT FK__UTP_User__UserTy__3138400F FOREIGN KEY (UserTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_User ADD CONSTRAINT FK__UTP_User__UserTy__322C6448 FOREIGN KEY (UserTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_User ADD CONSTRAINT FK__UTP_User__UserTy__33208881 FOREIGN KEY (UserTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_UserColumn ADD CONSTRAINT FK_UTP_UserColumn_UserID FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WorkSchedule ADD CONSTRAINT FK__UTP_WorkS__UserI__3D9E16F4 FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WorkSchedule ADD CONSTRAINT FK__UTP_WorkS__UserI__3E923B2D FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WorkSchedule ADD CONSTRAINT FK__UTP_WorkS__UserI__3F865F66 FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WorkSchedule ADD CONSTRAINT FK__UTP_WorkS__UserI__407A839F FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WorkSchedule ADD CONSTRAINT FK__UTP_WorkS__Group__39CD8610 FOREIGN KEY (GroupID) REFERENCES dbo.UTP_Group (GroupID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WorkSchedule ADD CONSTRAINT FK__UTP_WorkS__Group__3AC1AA49 FOREIGN KEY (GroupID) REFERENCES dbo.UTP_Group (GroupID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WorkSchedule ADD CONSTRAINT FK__UTP_WorkS__Group__3BB5CE82 FOREIGN KEY (GroupID) REFERENCES dbo.UTP_Group (GroupID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WorkSchedule ADD CONSTRAINT FK__UTP_WorkS__Group__3CA9F2BB FOREIGN KEY (GroupID) REFERENCES dbo.UTP_Group (GroupID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WOStructure ADD CONSTRAINT FK_EGDWOS_POR FOREIGN KEY (PrimaryOrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WOStructure ADD CONSTRAINT FK_EGDWOS_SOR FOREIGN KEY (RelatedOrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WOStructure ADD CONSTRAINT FK__UTP_WOStr__Relat__416EA7D8 FOREIGN KEY (RelationTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WOStructure ADD CONSTRAINT FK__UTP_WOStr__Relat__4262CC11 FOREIGN KEY (RelationTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WOStructure ADD CONSTRAINT FK__UTP_WOStr__Relat__4356F04A FOREIGN KEY (RelationTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WOStructure ADD CONSTRAINT FK__UTP_WOStr__Relat__444B1483 FOREIGN KEY (RelationTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Person ADD CONSTRAINT FK__UTP_Perso__Perso__07420643 FOREIGN KEY (PersonTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Person ADD CONSTRAINT FK__UTP_Perso__Perso__08362A7C FOREIGN KEY (PersonTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Person ADD CONSTRAINT FK__UTP_Perso__Perso__092A4EB5 FOREIGN KEY (PersonTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Person ADD CONSTRAINT FK__UTP_Perso__Perso__0A1E72EE FOREIGN KEY (PersonTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Person ADD CONSTRAINT FK__UTP_Perso__Phone__0B129727 FOREIGN KEY (PhoneEmailID) REFERENCES dbo.UTP_PhoneEmail (PhoneEmailID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Person ADD CONSTRAINT FK__UTP_Perso__Phone__0C06BB60 FOREIGN KEY (PhoneEmailID) REFERENCES dbo.UTP_PhoneEmail (PhoneEmailID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Person ADD CONSTRAINT FK__UTP_Perso__Phone__0CFADF99 FOREIGN KEY (PhoneEmailID) REFERENCES dbo.UTP_PhoneEmail (PhoneEmailID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Person ADD CONSTRAINT FK__UTP_Perso__Phone__0DEF03D2 FOREIGN KEY (PhoneEmailID) REFERENCES dbo.UTP_PhoneEmail (PhoneEmailID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Technician ADD CONSTRAINT FK_UTP_Tech_TechID FOREIGN KEY (UserID) REFERENCES dbo.UTP_User (UserID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_Technician ADD CONSTRAINT FK_UTP_Tech_TechTypeID FOREIGN KEY (TechnicianTypeID) REFERENCES dbo.UTP_ListMaster (ListID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_User ADD CONSTRAINT FK__UTP_User__Person__2C738AF2 FOREIGN KEY (PersonID) REFERENCES dbo.UTP_Person (PersonID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_User ADD CONSTRAINT FK__UTP_User__Person__2D67AF2B FOREIGN KEY (PersonID) REFERENCES dbo.UTP_Person (PersonID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_User ADD CONSTRAINT FK__UTP_User__Person__2E5BD364 FOREIGN KEY (PersonID) REFERENCES dbo.UTP_Person (PersonID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_User ADD CONSTRAINT FK__UTP_User__Person__2F4FF79D FOREIGN KEY (PersonID) REFERENCES dbo.UTP_Person (PersonID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WO ADD CONSTRAINT FK__UTP_WO__OrderID__35FCF52C FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WO ADD CONSTRAINT FK__UTP_WO__OrderID__36F11965 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WO ADD CONSTRAINT FK__UTP_WO__OrderID__37E53D9E FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
ALTER TABLE dbo.UTP_WO ADD CONSTRAINT FK__UTP_WO__OrderID__38D961D7 FOREIGN KEY (OrderID) REFERENCES dbo.UTP_Order (OrderID) ON UPDATE No action ON DELETE No action;
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Appt_DispatchXGI') AND type in (N'P', N'PC')) DROP PROCEDURE Appt_DispatchXGI;
GO
/*
	Appt_DispatchXGI.sql
	This script implements the Portal stored procedure Appt_DispatchXGI
	Note: All Portal Dispatch work is done elsewhere
*/
-- ====================================================================================
-- Description:	Appt_DispatchXGI
-- Revisions: 
-- ====================================================================================
CREATE PROCEDURE [dbo].[Appt_DispatchXGI]
	@WRNo varchar(15),
	@MsgText varchar(255) OUTPUT
AS
	SET @MsgText=''
	RETURN 1


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Appt_fnGetActiveRuleID') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION Appt_fnGetActiveRuleID;
GO


-- ====================================================================================
-- Description:	Appt_fnGetActiveRuleID
-- Revisions: 
--		20-May-2014		Add AppName parameter
-- ====================================================================================
CREATE FUNCTION [dbo].[Appt_fnGetActiveRuleID] (
	@WRNo varchar(15),
	@Date datetime = null,
	@AppName varchar(20) = null)
	returns int
AS 
	BEGIN
	-- Precedence - if multiples, JobType then Effective date, then Area then Effective date 
	IF @Date is null SET @Date = cast(getdate() as date)
	
	DECLARE	@JobType varchar(20),
			@JobCode varchar(20),
			@Area varchar(10),
			@RuleID int,
			@AppNameID int

	SET @AppNameID = null
	SELECT	@AppNameID = ListID
		FROM dbo.UTP_ListMaster 
		WHERE ListKey = 'AppName' 
			and ListValue = coalesce(@AppName, 'UTOPIS')
	
	SELECT	@Area = ltrim(rtrim(GroupName)),
			@JobType = ltrim(rtrim(WorkType)),
			@JobCode = ltrim(rtrim(JobPlan))
		FROM dbo.vw_Portal_WO_Small uw
		WHERE WONUM = @WRNo

	SET @RuleID = null
	-- exact match?
	SELECT TOP 1 @RuleID = RuleID
		FROM dbo.Appt_Rule 
		WHERE @JobType like JobType 
			and @JobCode like coalesce(JobCode,'%')
			and @Area like Area
			and @AppNameID like coalesce(AppNameID,@AppNameID)
			and @Date between coalesce(EffectiveFromDate,@Date) and coalesce(EffectiveToDate,@Date)
		ORDER BY Area desc, JobType desc, JobCode desc
		
	IF @RuleID is null
		-- match any area, JobType/JobCode match? 
		SELECT TOP 1 @RuleID = RuleID
			FROM dbo.Appt_Rule
			WHERE @JobType like JobType 
				and @JobCode like coalesce(JobCode,'%')
				and Area is null
				and @AppNameID like coalesce(AppNameID,@AppNameID)
				and @Date between coalesce(EffectiveFromDate,@Date) and coalesce(EffectiveToDate,@Date)
				and not exists (SELECT * FROM dbo.Appt_Rule 
									WHERE @JobType like JobType 
										and @JobCode like coalesce(JobCode,'%')
										and @Area like Area
										and @AppNameID like coalesce(AppNameID,@AppNameID)
										and @Date between coalesce(EffectiveFromDate,@Date) and coalesce(EffectiveToDate,@Date))
			ORDER BY Area desc, JobType desc, JobCode desc
						
	IF @RuleID is null
		-- match any JobType, Area match?
		SELECT TOP 1 @RuleID = RuleID
			FROM dbo.Appt_Rule 
			WHERE JobType is null 
				and @Area like Area
			--	and @AppNameID like coalesce(AppNameID,@AppNameID)
				and @Date between coalesce(EffectiveFromDate,@Date) and coalesce(EffectiveToDate,@Date)
				and not exists (SELECT * FROM dbo.Appt_Rule 
									WHERE @JobType like JobType 
										and @JobCode like coalesce(JobCode,'%')
										and (Area is null or @Area like Area)
			--							and @AppNameID like coalesce(AppNameID,@AppNameID)
										and @Date between coalesce(EffectiveFromDate,@Date) and coalesce(EffectiveToDate,@Date))

	IF @RuleID is null
		-- get default
		SELECT TOP 1 @RuleID = RuleID
			FROM dbo.Appt_Rule 
			WHERE JobType is null 
				and Area is null
				and @AppNameID like coalesce(AppNameID,@AppNameID)
				and @Date between coalesce(EffectiveFromDate,@Date) and coalesce(EffectiveToDate,@Date)

	RETURN coalesce(@RuleID, 0)
	END





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_CheckAddressForExistingWO') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_CheckAddressForExistingWO;
GO








-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 7, 2018
-- Description:	Tries to retrieve a WO based
--				on the address entered.
--				Hopefully, if a WO exists at
--				the address inputted, then the
--				SP will return that WO
-- Revisions:
--     Jun 13, 2018 dm Filter by WMStatus, job code
--	   Jun 15, 2018 jm Added CutoffMessage (for
--					   rebooking cutoff times)
--	   Nov 2, 2018 jm added AP01 WAMS_Subtype
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_CheckAddressForExistingWO]
	@StreetNo varchar(10),
	@Street varchar(50),
	@StreetSuffix varchar(150) = null,
	@Unit varchar(20) = null,
	@City varchar(50),
	@ProvinceCode varchar(20),
	@PostalCode varchar(20),
	@CutoffTime varchar(10) = '15:30:00'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @results table (id int NOT NULL IDENTITY(1,1), ServiceAddress varchar(400),
		SiteAddress varchar(255), FullAddress varchar(255), PostalCode varchar(7), MailingAddress varchar(255), AreaCode varchar(255), ContactName varchar(255), ContactPhone varchar(20),
		ContactAlternatePhone varchar(20), ContactEmailAddress varchar(50), AppointmentID int, AppointmentStatusID int, AppointmentTypeID int,
		AssignedFitterID varchar(50), AssignedFitterCode int, FitterWorkScheduleID int, AppointmentDate date, AppointmentTime int,
		AppointmentTimeSlotID int, CustomerRequest varchar(1000), Utility varchar(50), UtilityContactInfo varchar(255),
		OrderID int, WONUM varchar(20), MatchPriority int)

	DECLARE @search varchar(512), @search0a varchar(512), @search0b varchar(512), @search1 varchar(512), @search2a varchar(512), @search2b varchar(512), @search2c varchar(512)

	SELECT @StreetNo=LTRIM(RTRIM(@StreetNo)),@Street=UPPER(LTRIM(RTRIM(@Street))),
		@StreetSuffix=CASE WHEN @StreetSuffix IS NULL THEN NULL WHEN LTRIM(RTRIM(@StreetSuffix))='' THEN NULL ELSE UPPER(LTRIM(RTRIM(@StreetSuffix))) END,
		@Unit=CASE WHEN @Unit IS NULL THEN NULL WHEN LTRIM(RTRIM(@Unit))='' THEN NULL ELSE LTRIM(RTRIM(@Unit)) END,
		@City=CASE WHEN @City IS NULL THEN NULL WHEN LTRIM(RTRIM(@City))='' THEN NULL ELSE UPPER(LTRIM(RTRIM(@City))) END,
		@PostalCode=CASE WHEN @PostalCode IS NULL THEN NULL WHEN REPLACE(@PostalCode,' ' ,'')='' THEN NULL ELSE UPPER(REPLACE(@PostalCode,' ' ,'')) END

	SELECT @Street = CASE 
			WHEN @Street like '%1ST%' THEN REPLACE(@Street,'1ST','1%')
			WHEN @Street like '%2ND%' THEN REPLACE(@Street,'2ND','2%')
			WHEN @Street like '%3RD%' THEN REPLACE(@Street,'3RD','3%')
			WHEN @Street like '%[0-9]TH%' THEN SUBSTRING(@Street,1,PATINDEX('%[0-9]TH%',@Street)) + '%' + SUBSTRING(@Street,PATINDEX('%[0-9]TH%',@Street)+3,999)
			ELSE @Street END

	SELECT @search=REPLACE(@StreetNo,' ','%') + '%' + REPLACE(REPLACE(@Street,',','%'),' ','%') + '%' +
		CASE WHEN @Unit IS NULL THEN '' ELSE REPLACE(REPLACE(@Unit,',','%'),' ','%') + '%' END,
		@search0a=REPLACE(@StreetNo,' ','%') + '%' + REPLACE(REPLACE(@Street,',','%'),' ','%') + '%',
		@search0b=CASE WHEN @Unit IS NULL THEN '%' ELSE '%' + REPLACE(REPLACE(@Unit,',','%'),' ','%') + '%' END
	
	SELECT @search1=CASE WHEN @StreetSuffix IS NOT NULL AND @City IS NOT NULL AND @PostalCode IS NOT NULL THEN 
			@search0a + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@StreetSuffix + @search0b + @City + '%' + @PostalCode,' ','%'),',','%'),'.','%'),'-','%'),'#','%'),'&','%') + '%' ELSE NULL END,
		@search2a=CASE WHEN @StreetSuffix IS NOT NULL AND @City IS NOT NULL THEN 
			@search0a + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@StreetSuffix + @search0b + @City,' ','%'),',','%'),'.','%'),'-','%'),'#','%'),'&','%') + '%' ELSE NULL END,
		@search2b=CASE WHEN @StreetSuffix IS NOT NULL AND @PostalCode IS NOT NULL THEN 
			@search0a + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@StreetSuffix + @search0b + @PostalCode,' ','%'),',';
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_CheckBookingRules') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_CheckBookingRules;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: June 4, 2018
-- Description:	Checks booking rules
--				(ie Summer/Winter) for the input
--				WONUM
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_CheckBookingRules]
	@WONUM varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @AppName varchar(20)='CustomerPortal'
	DECLARE @Area varchar(10), @JobCode varchar(20), @JobType varchar(20), @RuleID int, @AppNameID int, @OrgID int, @Now datetime=CAST(GETDATE() as date)
	DECLARE @ApptFromDate datetime, @ApptToDate datetime, @MsgBefore varchar(max), @MsgAfter varchar(max), @MsgDuring varchar(max), @Window varchar(50)

	select @AppNameID=ListID FROM UTP_ListMaster where ListKey='AppName' AND ListValue=ISNULL(@AppName,'UTOPIS')

	SELECT @Area=LTRIM(RTRIM(GroupName)),@JobType=LTRIM(RTRIM(WorkType)),@JobCode=LTRIM(RTRIM(JobPlan)),@OrgID=OrgID FROM vw_UTP_WO_UTP WHERE WONUM=@WONUM

	SELECT TOP 1 @RuleID=RuleID FROM dbo.Appt_Rule
		WHERE (JobType IS NULL OR @JobType LIKE JobType)
			AND (JobCode IS NULL OR @JobCode LIKE JobCode)
			AND (Area IS NULL OR @Area LIKE Area)
			AND (AppNameID IS NULL or AppNameID=@AppNameID)
			AND (EffectiveFromDate IS NULL OR @Now >= EffectiveFromDate)
			AND (EffectiveToDate IS NULL OR @Now <= EffectiveToDate)
		ORDER BY
			(CASE
				WHEN @JobType LIKE JobType AND @Area LIKE Area THEN 1
				WHEN @JobType LIKE JobType AND Area IS NULL THEN 2
				WHEN JobType IS NULL AND @Area LIKE Area THEN 3
				WHEN JobType IS NULL AND Area IS NULL THEN 4
			END) ASC, Area DESC, JobType DESC, JobCode DESC

	SELECT @ApptFromDate=COALESCE(rp.FromDate, @Now), 
			@ApptToDate=COALESCE(rp.ToDate,DATEADD(d,60,@Now))
		FROM dbo.Appt_RuleParameter rp INNER JOIN dbo.UTP_ListMaster rt ON rp.RuleTypeID=rt.ListID
		WHERE rp.RuleID=@RuleID AND rt.ListValue='ApptWindow'

	SELECT @MsgBefore=COALESCE(rp.MsgBefore, 'Early - please come back'),
			@MsgAfter=COALESCE(rp.MsgAfter, 'Closed - please call'),
			@MsgDuring=COALESCE(rp.MsgDuring, 'Open'),
			@Window=CASE WHEN @Now BETWEEN COALESCE(FromDate,@Now) AND COALESCE(ToDate,@Now) THEN 'Open'
						WHEN @Now < COALESCE(FromDate,@Now) THEN 'Early'
						ELSE 'Closed' END
		FROM dbo.Appt_RuleParameter rp INNER JOIN dbo.UTP_ListMaster rt ON rp.RuleTypeID=rt.ListID
		WHERE rp.RuleID=@RuleID AND rt.ListValue='BookingWindow'

	SELECT	ApptFromDate = @ApptFromDate,
			ApptToDate = @ApptToDate,
			MsgBefore = @MsgBefore,
			MsgAfter = @MsgAfter,
			MsgDuring = @MsgDuring,
			Window = @Window
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_ConfirmAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_ConfirmAppointment;
GO
-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 3, 2015
-- Description:	Used when confirming a user's
--				appointment (initially created
--				for use with CPV2)
--	2018-05-11 JLM - added login attempt
--					 reset to zero
--  2018-05-14 JLM - added LanguageID input
--	2018-12-04 IDM - Create Worklog of Special Instructions
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_ConfirmAppointment]
	@WONUM varchar(15),
	@WOApptID int, 
	@ApptContactMode varchar(20) = null, -- ie Email
	@EmailAddress varchar(255) = null,
	@CustomerName varchar(255) = null,
	@CustomerAlternatePhone varchar(255) = null, 
	@CustomerPhone varchar(255) = null,
	@SpecialInstructions varchar(100) = null,
	@LanguageID int = null,
	@SessionID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @BookedAppt int = 0, @DeltaMS int, @EventStatusDate DATETIME

    DECLARE @WOID int,@OrderID int,@Org varchar(20),@Now datetime,@NewKey int,
			@JobCode varchar(255),@Status varchar(20),@NextStatus varchar(20),
			@OrderHistoryIn [dbo].UTP_OrderHistoryType, @RowCount int,@TechnicianID int,
			@ToSabre int = 0, @HasHandheld int = 0, @ToHandheld int = 0, @SubmitBy varchar(50)
			
	SET @Now = getdate()

	SELECT @WOID=[WOID],@OrderID=[OrderID],@Status=[WMStatus],@Org=[OrgShortName],@JobCode=[JobCode],@ToSabre=[ToSabre]
		FROM dbo.vw_TPS_WO
	WHERE WONUM = @WONUM
	
	IF @WOID IS NULL
	BEGIN
		PRINT 'Unable to locate WR ' + ISNULL(@WONUM, '') + '.  Confirmation Abandoned'
		RETURN 0
	END
	IF @Status IS NULL OR @Status NOT IN ('WSCH','SCHED','DISP','ACK')
	BEGIN
		PRINT 'STATUS ' + ISNULL(@Status,'') + ' for WR ' + @WONUM + ' prevents completing Confirmation.  Confirmation Abandoned'
		RETURN 0
	END
	
	select @WOApptID = max(AppointmentID) from UTP_Appointment where OrderID=@OrderID and AppointmentStatusID in (90329)
	IF @WOApptID IS NULL
	BEGIN
		-- Customer could leave booked appointment and just update contact information in which case there is no Reserve Appointment
		select @WOApptID = max(AppointmentID) from UTP_Appointment where OrderID=@OrderID and AppointmentStatusID in (90321)
		IF @WOApptID iS NULL
		BEGIN
			PRINT 'No Reserve Appointment for WR ' + @WONUM + '.  Confirmation Abandoned'
			RETURN 0
		END
		ELSE SET @BookedAppt = 1
	END

	SELECT @TechnicianID=[TechnicianID] FROM [dbo].[UTP_Appointment] with(nolock) WHERE [AppointmentID]=@WOApptID
	IF @TechnicianID IS NULL
	BEGIN
		PRINT 'No Technician assigned to WR ' + @WONUM + '.  Confirmation Abandoned'
		RETURN 0
	END

	SELECT @SubmitBy=CAST(('portal:' + CASE WHEN @EmailAddress IS NOT NULL AND @EmailAddress <> '' THEN @EmailAddress ELSE LTRIM(RTRIM(isnull(@CustomerName,''))) END) as varchar(50))

	-- cancel existing booked or extra reserved appts
		UPDATE dbo.UTP_Appointment
			SET AppointmentStatusID = 90322,
				ModifiedByID=dbo.fnUTP_CurrentDomainUserID(), ModifiedTimestamp=GETDATE()
			WHERE OrderID = @OrderID
				and AppointmentStatusID in (90321,90329)
				and AppointmentID <> @WOApptID
		
		declare @ContactID int
		select @ContactID = ContactID 
			from UTP_Contact 
			WHERE OrderID = @OrderID
				and ContactTypeID = dbo.fnUTP_GetListMaster('ContactType','CONTACT')
				 
		UPDATE dbo.UTP_Contact
			SET ContactEmail = coalesce(@EmailAddress,ContactEmail),
				ContactName = coalesce(left(ltrim(rtrim(@CustomerName)),40),ContactName),
				ContactPhone = coalesce(left(ltrim(rtrim(@CustomerPhone)), 25),ContactPhone),
				ContactAlternatePhone = coalesce(left(ltrim(rtrim(@CustomerAlternatePhone)), 25),ContactAlternatePhone),
				LanguageID = @LanguageID
			WHERE ContactID = @ContactID

		-- confirm reserved appt as booked
		UPDATE dbo.UTP_Appointment
			SET AppointmentStatusID = 90321,
				ContactID = @ContactID,
				PreferredContactModeID = c;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_GetApptInfo') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_GetApptInfo;
GO




-- =============================================
-- Author:		Jeff Moretti
-- Create date: March 29, 2018
-- Description:	Retrieves WO info based on the
--				input WONUM
-- 2018-06-14 JLM > added cutoff message
--					to support when an appt
--					is past the allowable
--					rebooking time
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_GetApptInfo]
	@WONUM varchar(15),
	@CutoffTime varchar(10) = '15:30:00'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	   SELECT TOP 1
					 SiteAddress = awo.StreetNo + ' ' + rtrim(ltrim(awo.Street)) 
												+ case when rtrim(ltrim(isnull(awo.Misc,''))) <> '' then ' ' + rtrim(ltrim(awo.Misc)) else '' end + ', '+ awo.Town + ', ' + isnull(awo.ProvinceCode,'')
												+ ' ' + UPPER(REPLACE(awo.PostalCode, ' ', '')),
					 FullAddress,
					 PostalCode = awo.PostalCode,
					 MailingAddress = '',
					 AreaCode = awo.GroupCode,
					 ContactName = coalesce(c.ContactName,''),
					 ContactPhone = coalesce(c.ContactPhone,''),
					 ContactAlternatePhone = coalesce(c.ContactAlternatePhone,''),
					 ContactEmailAddress = coalesce(c.ContactEmail,''),
					 AppointmentID = coalesce(AppointmentID, 0),
					 AppointmentStatusID,
					 AppointmentTypeID = coalesce(AppointmentTypeID, 0),
					 AssignedFitterID = awo.Technician,
					 AssignedFitterCode = awo.TechnicianID,
					 FitterWorkScheduleID = 0, 
					 AppointmentDate = awo.ApptStartDate,
					 AppointmentTime = 0,
					 AppointmentTimeSlotID = awo.TimeSlotID,
					 CustomerRequest = coalesce(awo.SpecialInstructions,''),
					 Utility = OrgShortName,
					 UtilityContactInfo = case when OrgShortName = 'UGD' then '(877) 313-6046'
																	 when OrgShortName = 'KU' then '(866) 496-6583'
																	 else '(866) 215-6670 Option 1'
																	 end,
					 OrderID = awo.OrderID,
					 WONUM = awo.WONUM,
					 CutoffMessage = 
							case when CONVERT(date, getdate()) >= CONVERT(date, awo.ApptStartDate) AND awo.AppointmentStatusID = 90321 AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305 then 'Past CutoffTime - Cannot rebook'
								 when dateadd(d,1,cast(getdate() as date)) >= CONVERT(date, awo.ApptStartDate) AND CONVERT(TIME, getdate()) > @CutoffTime AND awo.AppointmentStatusID = 90321 AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305 then 'Past CutoffTime - Cannot rebook'
								 when dateadd(d,2,cast(getdate() as date)) >= CONVERT(date, awo.ApptStartDate) AND (datepart(weekday, getdate()) = 6 OR datepart(weekday, getdate()) = 7) AND awo.AppointmentStatusID = 90321 AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305 then 'Past CutoffTime - Cannot rebook'
								 when dateadd(d,3,cast(getdate() as date)) >= CONVERT(date, awo.ApptStartDate) AND datepart(weekday, getdate()) = 6 AND CONVERT(TIME, getdate()) > @CutoffTime AND awo.AppointmentStatusID = 90321 AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305 then 'Past CutoffTime - Cannot rebook'
								 else 'Before CutoffTime - Allowed to rebook' end	
			  FROM dbo.vw_Atlantis_WO_UTP awo
					 LEFT JOIN dbo.UTP_Contact c on c.OrderID = awo.OrderID and c.ContactTypeID = 1803
			  WHERE awo.WONUM = @WONUM
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_GetAvailableDatesAndTimeslots') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_GetAvailableDatesAndTimeslots;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 6, 2018
-- Description:	Retrieves available Dates and
--				Timeslots for booking appts
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_GetAvailableDatesAndTimeslots]
	@WONUM varchar(15), 
	@FromDate varchar(30) = null,
	@ToDate varchar(30) = null,
	@CutoffTime varchar(10) = '15:30:00'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @Window int  = 60 --days

    DECLARE @GroupID int,
			@TechnicianID int

	SELECT @GroupID=wo.GroupID, @TechnicianID=wo.TechnicianID
		FROM ( select GroupID,TechnicianID FROM vw_UTP_WO_UTP where WONUM=@WONUM) wo
			
	select 
			AreaCode = g.GroupCode,
			w.WorkDate,
			AppointmentTime = max(l.ListValue),
			TimeSlot = max(l.ListText),
			TimeSlotID = w.TimeSlotID,
			AvailableAppts = sum(w.Capacity - isnull(a.Booked,0)),
			AvailableSlot = convert(varchar(11), w.WorkDate, 100) 
								+ ' ' + max(l.ListText)
	from UTP_Technician t
			left join UTP_WorkSchedule w on t.UserID = w.UserID
			left join vw_UTP_ScheduledAppointments a on w.UserID = a.TechnicianID and w.WorkDate = a.ApptEndDate and w.TimeSlotID = a.TimeslotID and w.GroupID = a.GroupID
			left join UTP_ListMaster l on w.TimeSlotID = l.ListID
			left join UTP_Group g on g.GroupID = w.GroupID
		where w.WorkDate between isnull(@FromDate,getdate()) and isnull(@ToDate,dateadd(d,@Window,getdate()))
			and w.ScheduleTypeID in (90350)
			and w.TimeSlotID not in (90307)
			and g.GroupID = @GroupID
			and t.UserID = @TechnicianID
			-- JeffM - this will handle the prior notice for booking an appointment
			AND
			((CONVERT(TIME, getdate()) <= @CutoffTime AND -- before (3:30 pm or CutoffTime), can book the next business day
				w.WorkDate >= case datepart(weekday, getdate()) 
--								when 6 then dateadd(d,3,cast(getdate() as date)) -- fri
								when 7 then dateadd(d,3,cast(getdate() as date)) -- sat
								when 1 then dateadd(d,2,cast(getdate() as date)) -- sun
								else dateadd(d,1,cast(getdate() as date)) end)
			OR
			 (CONVERT(TIME, getdate()) > @CutoffTime AND -- after (3:30 pm or CutoffTime), must book two days from now
				w.WorkDate >= case datepart(weekday, getdate()) 
								when 6 then dateadd(d,4,cast(getdate() as date)) -- fri
								when 7 then dateadd(d,3,cast(getdate() as date)) -- sat
								when 1 then dateadd(d,2,cast(getdate() as date)) -- sun
								else dateadd(d,2,cast(getdate() as date)) end)
			)
		group by g.GroupCode, w.WorkDate, w.TimeSlotID
		having sum(w.Capacity - isnull(a.Booked,0)) > 0
		ORDER BY AreaCode, WorkDate, AppointmentTime
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_GetBookingCount') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_GetBookingCount;
GO
-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 29, 2018
-- Description:	Gets the booking count for the
--				given WONUM
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_GetBookingCount]
	@WONUM varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT BookingCount
	FROM Portal_BookingCount
	WHERE WONUM = @WONUM
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_QueueEmail') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_QueueEmail;
GO







-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 4, 2018
-- Description:	Queues an email in the
--				UTP_EmailQueue
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_QueueEmail]
	@EmailRecipient varchar(200),
	@Subject varchar(max) =  null,
	@Body varchar(max) =  null,
	@FromAddress varchar(200),
	@FromFriendlyName varchar(200) = null,
	@OrderID int = null,
	@EmailTypeID int = null
AS
BEGIN
	INSERT INTO [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
           ([EmailRecipient]
           ,[Subject]
           ,[Body]
		   ,[FromAddress]
		   ,[FromFriendlyName]
		   ,[OrderID]
		   ,[EmailTypeID]
		   ,[CreatedTimestamp])
     VALUES
           (@EmailRecipient
           ,@Subject
           ,@Body
		   ,@FromAddress
		   ,@FromFriendlyName
		   ,@OrderID
		   ,@EmailTypeID
		   ,GETDATE())
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_QueueSms') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_QueueSms;
GO










-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 18, 2018
-- Description:	Queues an sms in the
--				UTP_SmsQueue
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_QueueSms]
	@DestinationPhoneNumber varchar(200),
	@Body varchar(max) =  null,
	@OrderID int = null,
	@SmsTypeID int = null
AS
BEGIN
	INSERT INTO [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
           ([DestinationPhoneNumber]
           ,[Body]
		   ,[OrderID]
		   ,[SmsTypeID]
		   ,[CreatedTimestamp])
     VALUES
           (@DestinationPhoneNumber
           ,@Body
		   ,@OrderID
		   ,@SmsTypeID
		   ,GETDATE())
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_RecordBookingCount') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_RecordBookingCount;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 29, 2018
-- Description:	Records a booking (confirmed
--				appointment) made by the user.
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_RecordBookingCount]
	@WONUM varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @BookingCountID int
	DECLARE @BookingCount int

	SELECT @BookingCountID = BookingCountID
	FROM Portal_BookingCount
	WHERE WONUM = @WONUM

	IF @BookingCountID IS NULL
	BEGIN
		-- no login attempt rows.  Create a new one.
		INSERT INTO Portal_BookingCount(WONUM, BookingCount, CreatedTimestamp)
		VALUES (@WONUM, 1, GETDATE())

		SELECT @BookingCount = 1
	END
	ELSE
	BEGIN
		-- increment count of login attempts by 1
		UPDATE TOP(1) Portal_BookingCount
		SET BookingCount = BookingCount + 1, ModifiedTimestamp = GETDATE()
		WHERE BookingCountID = @BookingCountID

		SELECT @BookingCount = BookingCount
		FROM Portal_BookingCount
		WHERE BookingCountID = @BookingCountID
	END

	SELECT @BookingCount

END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_RecordLoginAttempt') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_RecordLoginAttempt;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 10, 2018
-- Description:	Records a (failed) login attempt
--				by the user.
-- 20180616 JLM > changed logic so that if
--				  loginAttemptCount is already 3
--				  reset value to 1
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_RecordLoginAttempt]
	@SessionID varchar(50),
	@UserHostAddress varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @LoginAttemptID int
	DECLARE @LoginAttemptCount int

	SELECT @LoginAttemptID = LoginAttemptID
	FROM Portal_LoginAttempt
	WHERE SessionID = @SessionID

	IF @LoginAttemptID IS NULL
	BEGIN
		-- no login attempt rows.  Create a new one.
		INSERT INTO Portal_LoginAttempt(SessionID, UserHostAddress, LoginAttemptCount, CreatedTimestamp)
		VALUES (@SessionID, @UserHostAddress, 1, GETDATE())

		SELECT @LoginAttemptCount = 1
	END
	ELSE
	BEGIN

		SELECT @LoginAttemptCount = LoginAttemptCount
		FROM Portal_LoginAttempt
		WHERE LoginAttemptID = @LoginAttemptID

		IF @LoginAttemptCount = 3
		BEGIN
			SET @LoginAttemptCount = 1
		END
		ELSE
		BEGIN
			SET @LoginAttemptCount = @LoginAttemptCount + 1
		END

		UPDATE TOP(1) Portal_LoginAttempt
		SET UserHostAddress = @UserHostAddress, LoginAttemptCount = @LoginAttemptCount, ModifiedTimestamp = GETDATE()
		WHERE LoginAttemptID = @LoginAttemptID
	END

	SELECT @LoginAttemptCount

END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AtlantisWS_ReserveAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE AtlantisWS_ReserveAppointment;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 30, 2018
-- Description:	Reserves the apt indicated in
--				the input parameters
-- =============================================
CREATE PROCEDURE [dbo].[AtlantisWS_ReserveAppointment]
	@WONUM varchar(15),
	@Date varchar(30),
	@TimeslotID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @OrderID int,
			@TechnicianID int, @Technician varchar(50), @GroupID int,
			@AppointmentID int,
			@ContactID int

	SET @AppointmentID = 0

	SELECT TOP 1 @OrderID = OrderID, @TechnicianID = TechnicianID, @Technician = Technician, @GroupID = GroupID FROM vw_UTP_WO_UTP WHERE WONUM=@WONUM
	
	select @ContactID = ContactID 
		from UTP_Contact 
		WHERE OrderID = @OrderID
			and ContactTypeID = dbo.fnUTP_GetListMaster('ContactType','CONTACT')

	DECLARE @UserID int

	SET @UserID = 1

	if exists (select AppointmentID from UTP_Appointment where OrderID = @OrderID and AppointmentStatusID = 90329) -- reserved
		begin	
		-- cancel previous reserved appts
		UPDATE [dbo].[UTP_Appointment]
			SET AppointmentStatusID = 90322, -- cancelled
				ModifiedById = @UserID,
				ModifiedTimestamp = getdate()
			WHERE OrderID = @OrderID and AppointmentStatusID = 90329 -- reserved
		end

	DECLARE @ApptStartDate DATETIME, @ApptEndDate DATETIME, @ApptStartTime varchar(5), @ApptEndTime varchar(5)
	SELECT @ApptStartTime = case @TimeslotID when 90301 then '08:00' 
									when 90302 then '12:00'
									when 90303 then '10:00'
									when 90304 then '08:00'
									when 90305 then '16:00'
									else '00:00' end,
		@ApptEndTime = case @TimeslotID when 90301 then '12:00'
									when 90302 then '16:00'
									when 90303 then '14:00'
									when 90304 then '20:00'
									when 90305 then '20:00'
									else '23:59' end
	SELECT @ApptStartDate = CAST(CAST(@Date as varchar(10)) + ' ' + @ApptStartTime as DATETIME),
		@ApptEndDate = CAST(CAST(@Date as varchar(10)) + ' ' + @ApptEndTime as DATETIME)

	DECLARE @MedicalNecessity bit, @IsFirmAppt bit=0, @AccessRestricted bit
	SELECT TOP 1 @MedicalNecessity=[MedicalNecessity], @IsFirmAppt=[IsFirmAppt], @AccessRestricted=[AccessRestricted], @ContactID=[ContactID]
		FROM UTP_Appointment WHERE OrderID=@OrderID AND AppointmentStatusID=90321 /*Booked*/
		ORDER BY AppointmentID DESC

	-- create new reserved appt, copy data from existing booked appt
	INSERT UTP_Appointment
				([TechnicianID],[AppointmentTypeID],[AppointmentStatusID],[TimeslotID],[ApptStartDate],[ApptEndDate],[ApptStartTime],[ApptEndTime],
				[BookedViaID],[ExpectedDuration],[PreferredContactModeID],[OrderID],[IsFirmAppt],[ContactID],[CreatedTimestamp],[CreatedByID],
				[AccessRestricted],[MedicalNecessity])
		SELECT TOP 1 
				w.UserID,90311 /*Scheduled*/,90329 /*Reserved*/,w.TimeSlotID,@ApptStartDate,@ApptEndDate,@ApptStartTime,@ApptEndTime,
				373 /*CustomerPortal*/,2.0,null,@OrderID,@IsFirmAppt,@ContactID,getdate(),@UserID,
				@AccessRestricted,@MedicalNecessity
		FROM UTP_WorkSchedule w
		left join vw_UTP_ScheduledAppointments a on w.UserID = a.TechnicianID and w.WorkDate = CAST(a.ApptEndDate as DATE) and w.TimeSlotID = a.TimeslotID and w.GroupID = a.GroupID
		WHERE w.UserID=@TechnicianID AND w.WorkDate=CAST(@ApptEndDate as DATE) AND w.TimeslotID=@TimeslotID AND w.GroupID=@GroupID AND (w.Capacity - isnull(a.Booked,0)) > 0

	-- Assume @A				
	SET @AppointmentID = SCOPE_IDENTITY()

	IF @AppointmentID IS NOT NULL AND @AppointmentID <> 0
	BEGIN
		DECLARE @OrderHistoryIn [dbo].UTP_OrderHistoryType,
			@RowCount int

		-- TODO: Add possibly OrderStatusCode? ('OPEN' or 'CLOSED')
		INSERT INTO @OrderHistoryIn (OrderID, MemoTypeID, Memo, StatusTimestamp,  Operation, TechnicianID)
		VALUES(@OrderID, 1001, 'Portal : Customer reserved appointment for ' + isnull(@Technician,'(null)') + ' ;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'CAT_NewJobCode') AND type in (N'P', N'PC')) DROP PROCEDURE CAT_NewJobCode;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date: Jul 10, 2018
--    Cloned from JRP_NewJobCode
-- Description:
--     Create New CAT Job Code entry 
-- ===========================================================
CREATE PROC [dbo].[CAT_NewJobCode]
	@JobCodeID int=1,
	@CatalogID int,
	@WT varchar(20),
	@ST varchar(20),
	@JP varchar(20),
	@IsRC int = null,
	@IsRO int = null,
	@IsRR int = null,
	@InSabre bit = null,
	@Note varchar(255) = null,
	@PrimaryTemplate varchar(64) = null,
	@CreatedByID int = 1
AS
set nocount on
	if (select JobCodeID from CAT_JobCode where JobCodeID = @JobCodeID) is not NULL
	BEGIN
		print 'Duplicate job code id: '+CONVERT(varchar(20),@JobCodeID)
		return
	END

	declare @WT_ID int = -1,
			@ST_ID int = -1,
			@JP_ID int = -1,
			@eJC_ID int = null,
			@PrimaryTemplateID int = null

	SELECT @WT_ID = ListID from UTP_ListMaster where ListKey = 'EGD_WORKTYPE' and ListValue = @WT
	SELECT @ST_ID = ListID from UTP_ListMaster where ListKey = 'EGD_WAMS_SUBTYPE' and ListValue = @ST
	SELECT @JP_ID = ListID from UTP_ListMaster where ListKey = 'EGD_JPNUM' and ListValue = @JP
	IF @PrimaryTemplate IS NOT NULL SELECT @PrimaryTemplateID=ListID from UTP_ListMaster where ListKey='CAT_Template' and ListValue=@PrimaryTemplate and IsActive=1

	IF @WT_ID <> -1 and @ST_ID <> -1 and @JP_ID <> -1
		BEGIN
		SELECT @eJC_ID = JobCodeID FROM CAT_JobCode WHERE isnull(JobCodeID,0) = @WT_ID and isnull(SubtypeID,0) = @ST_ID and isnull(JobPlanID,0) = @JP_ID
		UPDATE UTP_ListMaster set IsActive=1 where ListID in (@WT_ID, @ST_ID, @JP_ID)
		IF @eJC_ID is null
			BEGIN
			INSERT CAT_JobCode (JobCodeID, CatalogID, JobTypeID, SubtypeID, JobPlanID, DisplayJobCode, IsActive, IsRC, IsRO, IsRR, InSabre, Note, PrimaryTemplateID, CreatedByID)
				SELECT @JobCodeID, @CatalogID, @WT_ID, @ST_ID, @JP_ID,
				@WT+' / '+@ST+' / '+@JP,
				 1, @IsRC, @IsRO, @IsRR, isnull(@InSabre,1), @Note, @PrimaryTemplateID,@CreatedByID
			END
		ELSE
			BEGIN
			UPDATE CAT_JobCode
				SET IsActive = 1,
					IsRC = isnull(@IsRC, IsRC),
					IsRO = isnull(@IsRO, IsRO),
					IsRR = isnull(@IsRR, IsRR),
					InSabre = isnull(@InSabre, InSabre),
					Note =isnull(@Note, Note),
					PrimaryTemplateID = @PrimaryTemplateID,
					CreatedByID=@CreatedByID
				WHERE JobCodeID = @eJC_ID
			END
		END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'CAT_NewJobCodeAttribute') AND type in (N'P', N'PC')) DROP PROCEDURE CAT_NewJobCodeAttribute;
GO
-- ===========================================================
-- Author: D Macmartin
-- Create date: Jul 10, 2018
--    Cloned from JRP_NewJobCode
-- Description:
--   Create TemplateAttribute 
-- ===========================================================
CREATE PROC [dbo].[CAT_NewJobCodeAttribute]
	@WT varchar(20),
	@ST varchar(20),
	@JP varchar(20),
	@FA varchar (20),
	@IsRequired int = 1,
	@TemplateAttributeID int,
	@SortOrder int = 0,
	@CreatedByID int = 1
AS
set nocount on

	declare @JobCodeID int, @TemplateID int, @AttributeID int,@TemplateName varchar(255), @DataAttributeID int

	select @JobCodeID=JobCodeID from vw_CAT_JobPlanT where WorkType=@WT and SubType=@ST and JobPlan=@JP
	select @TemplateID = PrimaryTemplateID from CAT_JobCode where JobCodeID=@JobCodeID
	select @TemplateName = (select ListValue from UTP_ListMaster where ListID=@TemplateID)
	select @DataAttributeID = DataAttributeID from UTP_DataAttribute where Category = 'EGD_FA' and DisplayName = @FA

	if @JobCodeID is null OR @TemplateID is null or @TemplateName is null or @DataAttributeID is null
	BEGIN
		print ' ... cannot create spec ... Job code, template, or data attribute does not exist. Job code: '+@WT +' / '+@ST + ' / '+@JP +' ... Attribute: '+ @FA
		RETURN
	END

	declare @OldID int=(select TemplateAttributeID from CAT_TemplateAttribute where TemplateID=@TemplateID and DataAttributeID=@DataAttributeID and SpecTypeID=5800)
	if @OldID is null
	BEGIN
		insert CAT_TemplateAttribute (TemplateAttributeID,TemplateID,DataAttributeID,IsRequired,IsReadonly,SortOrder,JCABits,IsActive)
			VALUES(@TemplateAttributeID,@TemplateID,@DataAttributeID,@IsRequired,0,@SortOrder,0,1)
	END ELSE BEGIN
		print 'TemplateAttribute not created; requested TemplateAttributeID: '+CONVERT(varchar(10),@TemplateAttributeID)+'; updated ID: '++CONVERT(varchar(10),@OldID)
		update CAT_TemplateAttribute set IsRequired=@IsRequired,IsReadonly=0,SortOrder=@SortOrder,JCABits=0,IsActive=1 where TemplateID=@TemplateID and DataAttributeID=@DataAttributeID and SpecTypeID=5800
	END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'CAT_NewJobCodeList') AND type in (N'P', N'PC')) DROP PROCEDURE CAT_NewJobCodeList;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date: July 10, 2018
--    Cloned from EGD_NewCodeList
-- Description:
--     Add completion codes to the catalog
-- Revisions:
--     Aug 15 - change to LPC_CompCode list key
-- ===========================================================
-- exec CAT_NewJobCodeList 'CSE','AP01','CS', '10,17,19,20,DS,50,51,53,54,55,58,59'
CREATE PROC [dbo].[CAT_NewJobCodeList]
	@WT varchar(20),
	@ST varchar(20),
	@JP varchar(20),
	@RC_List varchar(100),
	@CodeListTypeID int = null
as
set nocount on

	declare @JobCodeID int = null
	select @JobCodeID = JobCodeID
		from vw_CAT_JobPlanT
		where WorkType = @WT
			and Subtype = @ST 
			and JobPlan = @JP
	if left(@RC_List,1)='"' and right(@RC_List,1)='"' select @RC_List=substring(@RC_List,2,len(@RC_List)-2)

	declare @i int = 1,
			@j int,
			@k int,
			@cc varchar(10) = null,
			@cc_id int = null

	set @k = len(@RC_list)
	while @i < @k
	begin
		set @j = CHARINDEX(',',@RC_List,@i)-@i
		if @j <= 0 
			set @j = @k

		select @cc = SUBSTRING(@RC_List,@i,@j)
		set @cc_id = null

		select @cc_id = ListID from UTP_ListMaster where ListKey = 'LPC_COMPCODE' and ListValue = @cc and IsActive=1
--select @i, @j, @k, @cc, @cc_id

		if @cc_id is null 
		BEGIN
			print 'Comp Code:'+@CC+' does not exist - JobCode: '+@WT+' / '+@ST+' / '+ @JP
			return
		END
		if exists (select JobCodeID from CAT_JobCodeList where JobCodeID = @JobCodeID and CodeID = @CC_ID)
			update CAT_JobCodeList set IsActive = 1, CodeListTypeID=@CodeListTypeID 
				where JobCodeID = @JobCodeID and CodeID = @CC_ID
		else
			insert CAT_JobCodeList (JobCodeID,  CodeID, CodeListTypeId, IsActive)
				select @JobCodeID,  @cc_id, @CodeListTypeID, 1
		if (select ListID from UTP_ListMaster where ListKey=convert(varchar(12),@JobCodeID) and ListValue=@CC) is null print 'Create ListMaster entry - JobCode: '+convert(varchar(12),@JobCodeID)+', CompCode:'+@CC
			else print 'JobCode: '+convert(varchar(12),@JobCodeID)+', CompCode:'+@CC 
		set @i = @i + @j + 1
	end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_CollectionType') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_CollectionType;
GO

-- exec DDL_WMStatus_null 1
create procedure [dbo].[DDL_CollectionType]
	@CurrentUserID int = null
as
	select 	ListID,
			ListValue,
			ListText = ListText,
			SortOrder
		--	select *
		from UTP_ListMaster
		where ListKey = 'CollectionType'
			and IsActive = 1
	order by SortOrder asc

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_Customers_Null') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_Customers_Null;
GO

--select * from vw_UTP_customer
-- exec DDL_Customers_Null 1
create procedure [dbo].[DDL_Customers_Null]
	@CurrentUserID int = null
as
	select 	OrgID,
			ListValue = ShortName,
			ListText = Name
		--	select *
		from vw_UTP_customer
	union
	Select	OrgID = 0,
			ListValue = '(null)',
			ListText = '(Not set)'
	order by ListText asc

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_DataEntryStatus_null') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_DataEntryStatus_null;
GO

-- exec DDL_DataEntryStatus_null null, 1
create procedure [dbo].[DDL_DataEntryStatus_null]
	@GroupID int = null,
	@CurrentUserID int = null
as
	select 	ListID,
			ListValue,
			ListText,
			SortOrder = isnull(SortOrder,ListID)
		--	select *
		from UTP_ListMaster
		where ListKey = 'DataEntryStatus'
			and IsActive = 1
	union
	Select	ListID = 0,
			ListValue = '(Not set)',
			ListText = '(Not set)',
			SortOrder = -1
	order by SortOrder asc

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_DocumentType') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_DocumentType;
GO

-- exec DDL_DocumentType
create proc [dbo].[DDL_DocumentType]
	@CurrentUserID int = null
as
	select	ListID,
			ListValue,
			ListText
		from UTP_ListMaster
		where ListKey = 'DocumentType'

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_Instructor') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_Instructor;
GO

--exec DDL_Instructor 2
create proc [dbo].[DDL_Instructor]
	@CurrentUserID int = NULL
as
	select	InstructorID = cast(ListValue as int),	
			Instructor = ListText
		from UTP_ListMaster
		where ListKey = 'Instructor'
		order by SortOrder

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_JCProblem') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_JCProblem;
GO

create proc [dbo].[DDL_JCProblem]
	@CurrentUserID int = null
as
	select	ListID,
			ListValue,
			ListText
		from UTP_ListMaster
		where ListKey = 'JobCardProblem'

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_JobTitle') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_JobTitle;
GO

create proc [dbo].[DDL_JobTitle]
	@CurrentUserID int = NULL
as
	select	ListID = JobTitleID,	
			ListValue = JobTitle,
			ListText = JobTitle
		from vw_UTP_JobTitle
		order by JobTitle

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_MemoType') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_MemoType;
GO

-- exec DDL_MemoType 'Memo', 142 -- 142
CREATE proc [dbo].[DDL_MemoType]
	@Context varchar(50) = null, -- limit the list based upon Panel?
	@CurrentUserID int = null
as

	declare @Username varchar(50)
	select @Username = Username from UTP_User where UserID = @CurrentUserID

	select	ListID,
			ListValue,
			ListText
		from UTP_ListMaster
		where ListKey = 'MemoType'
			and IsActive=1
			and (@CurrentUserID = 1
				or ((@Context is null or @Context = 'Memo') and ListValue in ('1','2','6','9','10','11','13'))
				or @Username in ('arhack','sxrobe','jxpeac','txbyer','sxpeac','cts1','cts2','cts3','cts4','cts5') and ListValue in ('8'))

		order by SortOrder


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_MeterLeftStatus') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_MeterLeftStatus;
GO

create proc [dbo].[DDL_MeterLeftStatus]
	@CurrentUserID int = null
as
	select	ListID,
			ListValue,
			ListText
		from UTP_ListMaster
		where ListKey = 'MeterLeftStatus'

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_MeterLeftStatus_null') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_MeterLeftStatus_null;
GO

create proc [dbo].[DDL_MeterLeftStatus_null]
	@CurrentUserID int = null
as
	select	ListID,
			ListValue,
			ListText,
			SortOrder = isnull(SortOrder,ListID)
		from UTP_ListMaster
		where ListKey = 'MeterLeftStatus'
	union
	select	ListID = 0,
			ListValue = '(null)',
			ListText = '(Not set)',
			SortOrder = 0
		from UTP_ListMaster
		where ListKey = 'MeterLeftStatus'
	order by SortOrder

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_PanelViews') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_PanelViews;
GO

create proc [dbo].[DDL_PanelViews]
	@CurrentUserID int = null
as
	select ObjectName = TABLE_NAME, 
		ObjectType = TABLE_TYPE 
		from [INFORMATION_SCHEMA].[TABLES] 
		where TABLE_TYPE = 'VIEW' 
		order by TABLE_NAME

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_QuestionType') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_QuestionType;
GO

create proc [dbo].[DDL_QuestionType]
	@CurrentUserID int = NULL
as
	select	ListID,
			ListValue,
			ListText
		from UTP_ListMaster
		where ListKey = 'QuestionType'
			and IsActive = 1
		order by SortOrder

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_RelightTechnicians') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_RelightTechnicians;
GO


/****** Object:  StoredProcedure [dbo].[DDL_RelightTechnicians]    Script Date: 2017-04-10 10:05:27 PM ******/

-- exec DDL_RelightTechnicians 5, '4/10/2017'
CREATE procedure [dbo].[DDL_RelightTechnicians]
	@OrderID int,
	@Workdate datetime,
	@CurrentUserID int = null
as
	declare	@GroupID int

	select @GroupID = ug.GroupID
		from UTP_Order o 
			LEFT JOIN UTP_WO uw on o.OrderID = uw.OrderID 
			--LEFT JOIN EGD_WO ew on o.OrderID = ew.OrderID
			LEFT JOIN UTP_Group ug on ug.GroupID = uw.AreaID
			--LEFT JOIN UTP_Group eg on eg.GroupCode = ew.WAMS_REGION
		where o.OrderID = @OrderID

	select distinct 
			TechnicianID = t.[UserID],
			Technician = t.Username,
			ListText = t.Username + ' (' + Firstname + ' ' + LastName + ')'
		--	select *
		from vw_UTP_Technician t inner join UTP_User u on t.UserID = u.UserID
		where t.UserTypeID = [dbo].[fnUTP_GetListMaster]('UserType','Technician')
		--	and (GroupID is null or GroupID = isnull(@GroupID,GroupID))
			and u.IsActive = 1

	--select	TechnicianID = t.[UserID],
	--		Technician = t.Username,
	--		ListText = t.Username + ' (' + Firstname + ' ' + LastName + ')'

	--	from UTP_WorkSchedule w
	--		inner join vw_UTP_Technician t on w.UserID = t.UserID
	--	where w.WorkDate = @Workdate
	--		and w.GroupID = @GroupID
	--		and w.TimeSlotID = 90307
	--union
	--select	TechnicianID = wo.TechnicianID,
	--		Technician,
	--		ListText = Technician + ' (' + Firstname + ' ' + LastName + ')'
	
	--	from vw_UTP_WO wo 
	--		inner join vw_UTP_Technician t on wo.TechnicianID = t.UserID
	--	where wo.OrderID = @OrderID

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_RemarkType') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_RemarkType;
GO

-- exec DDL_RemarkType
create proc [dbo].[DDL_RemarkType]
	@CurrentUserID int = null
as
	select	ListID,
			ListValue,
			ListText
		from UTP_ListMaster
		where ListKey = 'EGD_REMARKCODE'

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_RenewalFrequency') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_RenewalFrequency;
GO

create proc [dbo].[DDL_RenewalFrequency]
	@CurrentUserID int = NULL
as
	select	ListID,
			ListValue,
			ListText
		from UTP_ListMaster
		where ListKey = 'RenewalFrequency'
			and IsActive = 1
		order by SortOrder

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_ScheduleType') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_ScheduleType;
GO
-- exec DDL_ScheduleType 'WorkSchedule'
CREATE PROCEDURE [dbo].[DDL_ScheduleType]
	@Context varchar(50) = '%',
	@CurrentUserID int = NULL
as
	SELECT	ListID,
			ListValue,
			ListText
		FROM UTP_ListMaster 
		WHERE ListKey = 'ScheduleType' and IsActive = 1
			and (@Context = '%'
				or (@Context = 'WorkSchedule' and ListValue in ('0','5','6')))
	UNION
	SELECT  ListID = 0,
			ListValue = '(null)',
			ListText = '(All)'

		ORDER by ListValue

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_Technicians') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_Technicians;
GO
-- exec DDL_Technicians null, 1
CREATE procedure [dbo].[DDL_Technicians]
	@GroupID int = null,
	@CurrentUserID int = null
as
	select distinct 
			t.UserID,
			t.Username,
			ListText = t.Username + ' (' + Firstname + ' ' + LastName + ')'
		--	select *
		from vw_UTP_Technician t inner join UTP_User u on t.UserID = u.UserID
		where t.UserTypeID = [dbo].[fnUTP_GetListMaster]('UserType','Technician')
			and (GroupID is null or GroupID = isnull(@GroupID,GroupID))
			and u.IsActive = 1
	union
	Select	UserID = 0,
			Username = '(Not set)',
			ListText = '(Not set)'
	order by Username

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_Technicians_Null') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_Technicians_Null;
GO

-- exec DDL_Technicians_null null, 1
create procedure [dbo].[DDL_Technicians_Null]
	@GroupID int = null,
	@CurrentUserID int = null
as
	select distinct 
			t.UserID,
			t.Username,
			ListText = t.Username + ' (' + Firstname + ' ' + LastName + ')'
		--	select *
		from vw_UTP_Technician t inner join UTP_User u on t.UserID = u.UserID
		where t.UserTypeID = [dbo].[fnUTP_GetListMaster]('UserType','Technician')
			and (GroupID is null or GroupID = isnull(@GroupID,GroupID))
			and u.IsActive = 1
	union
	Select	UserID = 0,
			Username = '(Not set)',
			ListText = '(Not set)'
	order by Username

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_TimeOffReason') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_TimeOffReason;
GO
-- exec DDL_TimeOffReason 
CREATE PROCEDURE [dbo].[DDL_TimeOffReason]
	@CurrentUserID int = NULL
as
	SELECT	ListID,
			ListValue,
			ListText
		FROM UTP_ListMaster 
		WHERE ListKey = 'TimeOffReason' and IsActive = 1
		ORDER by ListValue

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_Timeslots') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_Timeslots;
GO

-- exec DDL_Timeslots 'Training'
CREATE PROCEDURE [dbo].[DDL_Timeslots]
	@Context varchar(50) = '%', -- Usually set to the ListText from DDL_ScheduleType 
	@CurrentUserID int = NULL
as
	SELECT	ListID,
			ListValue,
			ListText
		FROM UTP_ListMaster 
		WHERE ListKey = 'Timeslot' and IsActive = 1
			and (@Context = '%'
				or (@Context = 'Project' and ListValue in ('1','2','3','4','5'))
				or (@Context = 'AfterHoursRelight' and ListValue in ('13'))
				or (@Context = 'TimeOff' and ListValue in ('1','2','3','4','5','14'))
				or (@Context = 'Training' and ListValue in ('1','2','3','4','5')))
		ORDER by SortOrder, ListText

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_WMStatus') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_WMStatus;
GO

-- exec DDL_WMStatus 1
create procedure [dbo].[DDL_WMStatus]
	@CurrentUserID int = null
as
	select 	ListID,
			ListValue,
			ListText = ListValue + ' - ' + ListText,
			SortOrder
		--	select *
		from UTP_ListMaster
		where ListKey = 'WMStatus'
			and IsActive = 1
	order by SortOrder, ListValue asc

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DDL_WMStatus_null') AND type in (N'P', N'PC')) DROP PROCEDURE DDL_WMStatus_null;
GO

-- exec DDL_WMStatus_null 1
create procedure [dbo].[DDL_WMStatus_null]
	@CurrentUserID int = null
as
	select 	ListID,
			ListValue,
			ListText = ListValue + ' - ' + ListText,
			SortOrder
		--	select *
		from UTP_ListMaster
		where ListKey = 'WMStatus'
			and IsActive = 1
	union
	Select	ListID = 0,
			ListValue = '(null)',
			ListText = '(Not set)',
			SortOrder = 0
	order by SortOrder asc

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EGD_SelectErrorType') AND type in (N'P', N'PC')) DROP PROCEDURE EGD_SelectErrorType;
GO
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: February 17, 2016
-- Description: Table type of returned errors
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[EGD_SelectErrorType]
AS
	SELECT
	[Code]=CAST('' AS [varchar](20)),
	[Level]=CAST('' as int),
	[Message]=CAST('' AS [varchar](128)),
	[Location]=CAST('' AS [varchar](128)),
	[Param]=CAST('' AS [varchar](64)),
	[ParamValue]=CAST('' AS [varchar](128))




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fn_diagramobjects') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fn_diagramobjects;
GO

	CREATE FUNCTION dbo.fn_diagramobjects() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fn_GetUserEmailAddress') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fn_GetUserEmailAddress;
GO
CREATE FUNCTION [dbo].[fn_GetUserEmailAddress] (@userName varchar (255)) returns varchar (max)
AS
BEGIN
	declare @email varchar(max)
	select @email =COALESCE(pe.Email,'') from 
		UTP_User u
		left join UTP_Person p on p.PersonID=u.PersonID
		left join UTP_PhoneEmail pe on pe.PhoneEmailID = p.PhoneEmailID
		where u.username=@UserName
	RETURN @email
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FN_gnMVal') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION FN_gnMVal;
GO
--======================================================================
-- Function for the special case of formatting the output value for 
-- inclusion in the VALUES list
--======================================================================
CREATE FUNCTION [dbo].[FN_gnMVal](@val money) RETURNS nvarchar(4000) AS
BEGIN
DECLARE @res nvarchar(4000)
IF @val IS NULL
  SET @res = 'NULL'
ELSE
  SET @res = CONVERT(varchar(20), @val, 2)
RETURN(@res)
END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FN_gnVal') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION FN_gnVal;
GO
--======================================================================
-- Function to format the output value for inclusion in the VALUES list
--======================================================================
CREATE FUNCTION [dbo].[FN_gnVal](@str nvarchar(4000)) RETURNS nvarchar(4000) AS
BEGIN
DECLARE @res nvarchar(4000)
IF @str IS NULL
  SET @res = 'NULL'
ELSE
  SET @res = 'N''' + REPLACE(@str, '''', '''''') + ''''
RETURN(@res)
END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fn_ReplaceWONUMinCTPQueue') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fn_ReplaceWONUMinCTPQueue;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date: 2017-03-30
-- Description: Replace WONUM in CTPTransactionData with prefix plus the WONUM
-- Revisions:
-- ===========================================================
CREATE function [dbo].[fn_ReplaceWONUMinCTPQueue](@text varchar(max),@prefix varchar(3)  ='B' ) returns varchar(max)
AS
BEGIN
	declare @n int = CHARINDEX('<WONUM>',@text) +6
	if @n < 8 return @text
	return SUBSTRING(@text,1,@n)+@prefix+SUBSTRING(@text,@n+1,len(@text))
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAverage') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnAverage;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date: 2017-03-17
-- Description: Avearge, returning 0 if numerator is 0
-- Revisions:
-- ===========================================================
create function [dbo].[fnAverage] (@sum float, @count int) returns float
AS
BEGIN
	if @count=0 return 0
	return 1.0* @sum/@count
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnCAT_LPCWOType') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnCAT_LPCWOType;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 15, 2018
-- Description: Return CAT job type for LPC
--              TYPE = 1=PreInsp, 2=Build, 3=Install
-- Revisions: 
-- ====================================================================================
CREATE FUNCTION [dbo].[fnCAT_LPCWOType] (@JobCodeID int)
	RETURNS int
as
BEGIN
	if (select JobPlan from vw_CAT_JobPlanT  where JobCodeID=@JobCodeID) = 'STNPI' return 1
	RETURN CASE (select WorkType from vw_CAT_JobPlanT where JobCodeID=@JobCodeID) WHEN 'BLD' then 2 WHEN 'INST' then 3 ELSE NULL end
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnCAT_LPCWOTypeName') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnCAT_LPCWOTypeName;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 15, 2018
-- Description: Return CAT job type name for LPC
--              TYPE = 1=PreInsp, 2=Build, 3=Install
-- Revisions: 
-- ====================================================================================
CREATE FUNCTION [dbo].[fnCAT_LPCWOTypeName] (@type int)
	RETURNS varchar(25)
as
BEGIN
	RETURN CASE @Type 
		when 1 then 'Pre-Inspection'
		when 2 then 'Build'
		when 3 then 'Install'
		else ''
	END
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnIDM_tmpIfNull') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnIDM_tmpIfNull;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date: January 09, 2016
-- Description:
--     Used to compose the street address
--     If the text is null or 0-length, return ''
--     else return text appended by space
-- Revisions:
-- ===========================================================
CREATE FUNCTION [dbo].[fnIDM_tmpIfNull] (@text varchar(255))
RETURNS varchar(257)
AS
BEGIN
	if @text is NULL or len(@text)<1 return ''
	return @text+' '
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_ComputeBookedAppt') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_ComputeBookedAppt;
GO
-- select dbo.fnUTP_ComputeBookedAppt(null,'2016-08-10',null)
CREATE FUNCTION [dbo].[fnUTP_ComputeBookedAppt] (
      @TechnicianID int = null,
      @ApptStartDate datetime = null,
      @TimeslotID int = null
      ) 
      
      returns int
as
      begin
      declare @Booked int
      select @Booked = count(*) 
            from UTP_Appointment 
            Where AppointmentStatusID in (90321,90329) 
                  --and IsFirmAppt = 0
                  and TechnicianID = isnull(@TechnicianID,TechnicianID)
                  and CONVERT(date,ApptStartDate) = isnull(@ApptStartDate,CONVERT(date,ApptStartDate))
                  and TimeslotID = isnull(@TimeslotID,TimeslotID)
                  and TimeslotID between 90301 and 90305
      return @Booked
      end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_CurrentDomainUserID') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_CurrentDomainUserID;
GO
-- DROP FUNCTION fnUTP_CurrentDomainUserID
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: August 10, 2016
-- Description:
--     Return the UTP_User UserID of the current Domain User or Service entry
--     Note: this function will not work until a DomainUsername field on UTP_User
--			table is created
-- Revisions:
-- ===========================================================
CREATE FUNCTION [dbo].[fnUTP_CurrentDomainUserID]()
RETURNS int
AS
BEGIN
	DECLARE @Userid int
	SELECT @Userid=[dbo].[fnUTP_GetDomainUserID](SYSTEM_USER)
	IF @Userid IS NULL
	BEGIN
		SELECT TOP 1 @Userid=[UserID] FROM [dbo].[UTP_User] WHERE [UserName]='Service'
	END
	RETURN @Userid
END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_EmailAssembleList') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_EmailAssembleList;
GO
-- recursion occurs if a recipient name starts with $
CREATE FUNCTION [dbo].[fnUTP_EmailAssembleList](
	@ListName varchar(255)
	)
	returns varchar(max) 
as
	begin
		
	DECLARE @List varchar(max)
	set @List = ''

	declare list cursor for
		select [EmailRecipient] 
			from [UTP_EmailRecipients]
			where ListName like @ListName
			
	declare @Recipient varchar(max), @r varchar(max)
			
	open list
	fetch next from list into @Recipient

	while @@Fetch_Status = 0 begin
		if Left(@Recipient,1) = '$' 
			set @List = @List + dbo.[fnUTP_EmailAssembleList](substring(@Recipient,2,len(@Recipient)-1))
		else
			select @r= 
				case when @Recipient like '%@%' then @Recipient
				else dbo.fn_GetUserEmailAddress(@recipient)
				end
			if len(@R)>3 set @List = @List + @r + '; ' 
		fetch next from list into @Recipient
		end
		
	close list
	deallocate list
	if @List = ''
		set @List =  @ListName
	return @List
	end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_FormatAddress') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_FormatAddress;
GO
--
-- Formats address as 
-- StreetNo Street StreetType Sfx, [Misc,], Town, PostalCode
--
CREATE FUNCTION [dbo].[fnUTP_FormatAddress](@AddressID int) RETURNS varchar(max)
AS
BEGIN
	declare @address varchar(max)
	select @address = 
		 COALESCE(StreetNo+' ','')+ COALESCE(Street+' ','')+ COALESCE(StreetType+' ', '')+ COALESCE(Sfx,'')+', '
		 + case when len(COALESCE(ad.Misc,''))>0 then ad.Misc+', ' else '' end
		 + COALESCE(ad.Town+', ','')+ COALESCE(ProvinceCode,'')
		 + ' '+COALESCE(ad.PostalCode,'')
		 from UTP_Address ad where AddressID=@AddressID 
    RETURN COALESCE(@address,'***')
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_FormatAddress2') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_FormatAddress2;
GO
CREATE FUNCTION [dbo].[fnUTP_FormatAddress2](@AddressID int) RETURNS varchar(max)
AS
BEGIN
	declare @address varchar(max)
	select @address =  isnull(ad.StreetNo,'') + ' ' + isnull(ad.Street,'') + ' ' + isnull(ad.StreetType,'')
                                                + case when isnull(ad.Sfx,'') <> '' then ' ' + isnull(ad.Sfx,'') else '' end
                                                + case when isnull(ad.Unit,'') <> '' then ', Unit ' + isnull(ad.Unit,'') else '' end 
                                                + ', ' + isnull(ad.Town,'') + ', ' + isnull(ad.ProvinceCode,'') + ' ' + isnull(ad.PostalCode,'')
	from UTP_Address ad where AddressID=@AddressID 
	return @address
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_FormatAddressNoPostalCode') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_FormatAddressNoPostalCode;
GO
--
-- Formats address as 
-- StreetNo Street StreetType Sfx, [Misc,], Town
-- (no postal code)
--
CREATE FUNCTION [dbo].[fnUTP_FormatAddressNoPostalCode](@AddressID int) RETURNS varchar(max)
AS
BEGIN
	declare @address varchar(max)
	select @address = 
		 COALESCE(StreetNo+' ','')+ COALESCE(Street+' ','')+ COALESCE(StreetType+' ', '')+ COALESCE(Sfx,'')+', '
		 + case when len(COALESCE(ad.Misc,''))>0 then ad.Misc+', ' else '' end
		 + COALESCE(ad.Town+', ','')+ COALESCE(ProvinceCode,'')
		 from UTP_Address ad where AddressID=@AddressID 
    RETURN COALESCE(@address,'***')
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_GetAttributeName') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_GetAttributeName;
GO


-- =============================================
-- Author:		Jeff Moretti
-- Create date: 2016-10-14
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnUTP_GetAttributeName]
(
	@DataAttributeID INT
)
RETURNS varchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @AttributeName varchar(255)

	-- Add the T-SQL statements to compute the return value here
	SELECT @AttributeName = AttributeName
	FROM UTP_DataAttribute
	WHERE DataAttributeID = @DataAttributeID

	-- Return the result of the function
	RETURN @AttributeName

END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_GetDomainUserID') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_GetDomainUserID;
GO
/*
	Update-20160805.sql
	Add support for EGDSENDERROR requests and L2E failures
*/
-- DROP FUNCTION fnUTP_GetDomainUserID
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: August 10, 2016
-- Description:
--     Return the UTP_User UserID field for the supplied Domain Username
--     Note: this function will not work until a DomainUsername field on UTP_User
--			table is created
-- Revisions:
-- ===========================================================
CREATE FUNCTION [dbo].[fnUTP_GetDomainUserID](@DomainUsername [varchar](255))
RETURNS int
AS
BEGIN
	DECLARE @Userid int
	SELECT @Userid=[UserID] FROM [dbo].[UTP_User] WHERE [UserName]=@DomainUsername AND [IsActive]=1
	RETURN @Userid
END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_GetGroupID') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_GetGroupID;
GO

CREATE function [dbo].[fnUTP_GetGroupID](@OrderID int) returns int as
	begin
	declare @GroupID int
	select @GroupID = uw.AreaID
		from UTP_Order o 
			--left join EGD_WO ew on o.OrderID = ew.OrderID
			left join UTP_WO uw on o.OrderID = uw.OrderID
			--left join UTP_Group eg (nolock) on eg.GroupCode = ew.WAMS_REGION	
		where o.OrderID = @OrderID
	return @GroupID
	end
;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_GetJobCodeID') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_GetJobCodeID;
GO


-- =============================================
-- Author:		Jeff Moretti
-- Create date: Aug 17, 2018
-- Description:	Returns the JobCodeID associated
--				with the JobCode and CatalogID
--				as well
-- =============================================
CREATE function [dbo].[fnUTP_GetJobCodeID] (@JobCode varchar(100), @CatalogID int) returns int
AS
BEGIN 
		-- TODO:  May want to consider special handling of extra spaces, special characters, maybe even more than
		-- 3-part job codes in the future
       return (select JobCodeID from CAT_JobCode where REPLACE(DisplayJobCode,' ' ,'')=REPLACE(@JobCode,' ','') and CatalogID=@CatalogID )
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_GetListMaster') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_GetListMaster;
GO
/*
drop function [dbo].[fnUTP_SelectListMaster]
drop function [dbo].[fnUTP_GetListMaster]
*/
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 13, 2015
-- Description: Get one or more rows from the List Master table
-- Revisions: 
-- ====================================================================================
CREATE FUNCTION [dbo].[fnUTP_GetListMaster](@ListKey varchar(255),@ListValue varchar(255) = NULL)
	RETURNS int
as
	BEGIN
		DECLARE @key int
		SELECT @key = ListID from UTP_ListMaster where ListKey=@ListKey and ListValue=COALESCE(@ListValue,ListValue)
		RETURN @key
	END




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_GetUserPermission') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_GetUserPermission;
GO

CREATE FUNCTION [dbo].[fnUTP_GetUserPermission](@UserID int, @Permission varchar(255)) returns bit as
	begin
	declare @IsEnabled bit = null
	select @IsEnabled = IsEnabled from UTP_UserPermission 
		where UserID = @UserID and PermissionID = dbo.fnUTP_GetListMaster('Permission',@Permission)
	return @IsEnabled
	end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_GetWOSchedPriority') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_GetWOSchedPriority;
GO
CREATE FUNCTION [dbo].[fnUTP_GetWOSchedPriority](@OrderID int)
	RETURNS int
AS
BEGIN
	DECLARE @Priority int=5
	SELECT @Priority=[QueuePriority] FROM vw_TPS_WO WHERE OrderID=@OrderID
	RETURN @Priority
END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_GetWOSchedPriorityByWONUM') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_GetWOSchedPriorityByWONUM;
GO
CREATE FUNCTION [dbo].[fnUTP_GetWOSchedPriorityByWONUM](@WONUM varchar(20))
	RETURNS int
AS
BEGIN
	DECLARE @Priority int
	/*
	SELECT @Priority=CASE isnull(ewt.ListValue,'') WHEN 'HIPRTY' THEN 1 WHEN 'EMER' THEN 1 WHEN 'EXCH' THEN 9 ELSE 5 END
	FROM EGD_WO wo with(nolock) JOIN UTP_ListMaster ewt with(nolock) ON ewt.ListID=wo.WorkTypeID
	where WONUM=@WONUM
	*/

	IF @Priority IS NULL SET @Priority=9
	RETURN @Priority
END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_HTMLFormatRow') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_HTMLFormatRow;
GO

------------------
--
-- Revision: Feb 6, 2017 DM - increase # columns to 15
--           Oct 28, 2017 - DM - increate # columns to 27
--
-- Note function calls must specify all parameters
-- For optional parameters, you have to EXEC the function
--
-- declare @test varchar(255)
-- exec @test = dbo.[fnUTP_HTMLFormatRow] 'a','b','c'
-- select @test
------------------
CREATE FUNCTION [dbo].[fnUTP_HTMLFormatRow](@cell1 varchar(max)=null,@cell2 varchar(max)=null,@cell3 varchar(max)=null,@cell4 varchar(max)=null,
		@cell5 varchar(max)=null,@cell6 varchar(max)=null,@cell7 varchar(max)=null,@cell8 varchar(max)=null,@cell9 varchar(max)=null,
		@cell10 varchar(max)=null,@cell11 varchar(max)=null,@cell12 varchar(max)=null,
		@cell13 varchar(max)=null,@cell14 varchar(max)=null,@cell15 varchar(max)=null,
		@cell16 varchar(max)=null,@cell17 varchar(max)=null,@cell18 varchar(max)=null,
		@cell19 varchar(max)=null,@cell20 varchar(max)=null,@cell21 varchar(max)=null,
		@cell22 varchar(max)=null,@cell23 varchar(max)=null,@cell24 varchar(max)=null,
		@cell25 varchar(max)=null,@cell26 varchar(max)=null,@cell27 varchar(max)=null
		)
	RETURNS varchar(max)
as
BEGIN
		DECLARE @row varchar(max)
		select @row = '<tr>'
			+case when @cell1 is not null then '<td>'+@cell1+'</td>' else '' end
			+case when @cell2 is not null then '<td>'+@cell2+'</td>' else '' end
			+case when @cell3 is not null then '<td>'+@cell3+'</td>' else '' end
			+case when @cell4 is not null then '<td>'+@cell4+'</td>' else '' end
			+case when @cell5 is not null then '<td>'+@cell5+'</td>' else '' end
			+case when @cell6 is not null then '<td>'+@cell6+'</td>' else '' end
			+case when @cell7 is not null then '<td>'+@cell7+'</td>' else '' end
			+case when @cell8 is not null then '<td>'+@cell8+'</td>' else '' end
			+case when @cell9 is not null then '<td>'+@cell9+'</td>' else '' end
			+case when @cell10 is not null then '<td>'+@cell10+'</td>' else '' end
			+case when @cell11 is not null then '<td>'+@cell11+'</td>' else '' end
			+case when @cell12 is not null then '<td>'+@cell12+'</td>' else '' end
			+case when @cell13 is not null then '<td>'+@cell13+'</td>' else '' end
			+case when @cell14 is not null then '<td>'+@cell14+'</td>' else '' end
			+case when @cell15 is not null then '<td>'+@cell15+'</td>' else '' end
			+case when @cell16 is not null then '<td>'+@cell16+'</td>' else '' end
			+case when @cell17 is not null then '<td>'+@cell17+'</td>' else '' end
			+case when @cell18 is not null then '<td>'+@cell18+'</td>' else '' end
			+case when @cell19 is not null then '<td>'+@cell19+'</td>' else '' end
			+case when @cell20 is not null then '<td>'+@cell20+'</td>' else '' end
			+case when @cell21 is not null then '<td>'+@cell21+'</td>' else '' end
			+case when @cell22 is not null then '<td>'+@cell22+'</td>' else '' end
			+case when @cell23 is not null then '<td>'+@cell23+'</td>' else '' end
			+case when @cell24 is not null then '<td>'+@cell24+'</td>' else '' end
			+case when @cell25 is not null then '<td>'+@cell25+'</td>' else '' end
			+case when @cell26 is not null then '<td>'+@cell26+'</td>' else '' end
			+case when @cell27 is not null then '<td>'+@cell27+'</td>' else '' end
			+'</tr>'
		RETURN COALESCE(@row,'')
	END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_HTMLFormatTableHead') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_HTMLFormatTableHead;
GO
------------------    
--
-- Revision: Feb 6, 2017 DM - increase # columns to 15
--           Oct 28, 2018 - DM - increate # columns to 27
--
-- Note function calls must specify all parameters    
-- For optional parameters, you have to EXEC the function    
--    
-- declare @test varchar(255)    
-- exec @test = dbo.[fnUTP_HTMLFormatRow] 'a','b','c'    
-- select @test    
------------------    
CREATE FUNCTION [dbo].[fnUTP_HTMLFormatTableHead](@id varchar(max)=null,@cell1 varchar(max)=null,@cell2 varchar(max)=null,@cell3 varchar(max)=null,@cell4 varchar(max)=null,@cell5 varchar(max)=null,
		@cell6 varchar(max)=null,@cell7 varchar(max)=null,@cell8 varchar(max)=null,@cell9 varchar(max)=null,
		@cell10 varchar(max)=null,@cell11 varchar(max)=null,@cell12 varchar(max)=null, 
		@cell13 varchar(max)=null,@cell14 varchar(max)=null,@cell15 varchar(max)=null,
		@cell16 varchar(max)=null,@cell17 varchar(max)=null,@cell18 varchar(max)=null,
		@cell19 varchar(max)=null,@cell20 varchar(max)=null,@cell21 varchar(max)=null,
		@cell22 varchar(max)=null,@cell23 varchar(max)=null,@cell24 varchar(max)=null,
		@cell25 varchar(max)=null,@cell26 varchar(max)=null,@cell27 varchar(max)=null
	)
 RETURNS varchar(max)    
as    
 BEGIN    
  DECLARE @thead varchar(max)    
  select @thead = '<table id="'+COALESCE (@id,'')+'">'     
   +'<thead><tr>'    
   +case when @cell1 is not null then '<th>'+@cell1+'</th>' else '' end    
   +case when @cell2 is not null then '<th>'+@cell2+'</th>' else '' end    
   +case when @cell3 is not null then '<th>'+@cell3+'</th>' else '' end    
   +case when @cell4 is not null then '<th>'+@cell4+'</th>' else '' end    
   +case when @cell5 is not null then '<th>'+@cell5+'</th>' else '' end    
   +case when @cell6 is not null then '<th>'+@cell6+'</th>' else '' end    
   +case when @cell7 is not null then '<th>'+@cell7+'</th>' else '' end    
   +case when @cell8 is not null then '<th>'+@cell8+'</th>' else '' end    
   +case when @cell9 is not null then '<th>'+@cell9+'</th>' else '' end    
   +case when @cell10 is not null then '<th>'+@cell10+'</th>' else '' end    
   +case when @cell11 is not null then '<th>'+@cell11+'</th>' else '' end  
   +case when @cell12 is not null then '<th>'+@cell12+'</th>' else '' end  
   +case when @cell13 is not null then '<th>'+@cell13+'</th>' else '' end    
   +case when @cell14 is not null then '<th>'+@cell14+'</th>' else '' end  
   +case when @cell15 is not null then '<th>'+@cell15+'</th>' else '' end  
   +case when @cell16 is not null then '<th>'+@cell16+'</th>' else '' end  
   +case when @cell17 is not null then '<th>'+@cell17+'</th>' else '' end  
   +case when @cell18 is not null then '<th>'+@cell18+'</th>' else '' end  
   +case when @cell19 is not null then '<th>'+@cell19+'</th>' else '' end  
   +case when @cell20 is not null then '<th>'+@cell20+'</th>' else '' end  
   +case when @cell21 is not null then '<th>'+@cell21+'</th>' else '' end  
   +case when @cell22 is not null then '<th>'+@cell22+'</th>' else '' end  
   +case when @cell23 is not null then '<th>'+@cell23+'</th>' else '' end  
   +case when @cell24 is not null then '<th>'+@cell24+'</th>' else '' end  
   +case when @cell25 is not null then '<th>'+@cell25+'</th>' else '' end  
   +case when @cell26 is not null then '<th>'+@cell26+'</th>' else '' end  
   +case when @cell27 is not null then '<th>'+@cell27+'</th>' else '' end  
   +'</tr></thead><tbody>'    
  RETURN COALESCE(@thead,'')    
 END    

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_HTMLFormatTableHeadClass') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_HTMLFormatTableHeadClass;
GO
CREATE function [dbo].[fnUTP_HTMLFormatTableHeadClass](@id varchar(max)=null,@class varchar(max)=null,@cell1 varchar(max)=null,@cell2 varchar(max)=null,@cell3 varchar(max)=null,@cell4 varchar(max)=null,@cell5 varchar(max)=null,
		@cell6 varchar(max)=null,@cell7 varchar(max)=null,@cell8 varchar(max)=null,@cell9 varchar(max)=null,
		@cell10 varchar(max)=null,@cell11 varchar(max)=null,@cell12 varchar(max)=null, 
		@cell13 varchar(max)=null,@cell14 varchar(max)=null,@cell15 varchar(max)=null,
		@cell16 varchar(max)=null,@cell17 varchar(max)=null,@cell18 varchar(max)=null,
		@cell19 varchar(max)=null,@cell20 varchar(max)=null,@cell21 varchar(max)=null,
		@cell22 varchar(max)=null,@cell23 varchar(max)=null,@cell24 varchar(max)=null,
		@cell25 varchar(max)=null,@cell26 varchar(max)=null,@cell27 varchar(max)=null)
 RETURNS varchar(max)    
as    
 BEGIN    
  DECLARE @thead varchar(max)    
  select @thead = '<table id="'+COALESCE (@id,'')+'" class = "'+@class+'">'     
   +'<thead><tr>'    
   +case when @cell1 is not null then '<th>'+@cell1+'</th>' else '' end    
   +case when @cell2 is not null then '<th>'+@cell2+'</th>' else '' end    
   +case when @cell3 is not null then '<th>'+@cell3+'</th>' else '' end    
   +case when @cell4 is not null then '<th>'+@cell4+'</th>' else '' end    
   +case when @cell5 is not null then '<th>'+@cell5+'</th>' else '' end    
   +case when @cell6 is not null then '<th>'+@cell6+'</th>' else '' end    
   +case when @cell7 is not null then '<th>'+@cell7+'</th>' else '' end    
   +case when @cell8 is not null then '<th>'+@cell8+'</th>' else '' end    
   +case when @cell9 is not null then '<th>'+@cell9+'</th>' else '' end    
   +case when @cell10 is not null then '<th>'+@cell10+'</th>' else '' end    
   +case when @cell11 is not null then '<th>'+@cell11+'</th>' else '' end  
   +case when @cell12 is not null then '<th>'+@cell12+'</th>' else '' end  
   +case when @cell13 is not null then '<th>'+@cell13+'</th>' else '' end    
   +case when @cell14 is not null then '<th>'+@cell14+'</th>' else '' end  
   +case when @cell15 is not null then '<th>'+@cell15+'</th>' else '' end  
   +case when @cell16 is not null then '<th>'+@cell16+'</th>' else '' end  
   +case when @cell17 is not null then '<th>'+@cell17+'</th>' else '' end  
   +case when @cell18 is not null then '<th>'+@cell18+'</th>' else '' end  
   +case when @cell19 is not null then '<th>'+@cell19+'</th>' else '' end  
   +case when @cell20 is not null then '<th>'+@cell20+'</th>' else '' end  
   +case when @cell21 is not null then '<th>'+@cell21+'</th>' else '' end  
   +case when @cell22 is not null then '<th>'+@cell22+'</th>' else '' end  
   +case when @cell23 is not null then '<th>'+@cell23+'</th>' else '' end  
   +case when @cell24 is not null then '<th>'+@cell24+'</th>' else '' end  
   +case when @cell25 is not null then '<th>'+@cell25+'</th>' else '' end  
   +case when @cell26 is not null then '<th>'+@cell26+'</th>' else '' end  
   +case when @cell27 is not null then '<th>'+@cell27+'</th>' else '' end  
   +'</tr></thead><tbody>'    
  RETURN COALESCE(@thead,'')    
 END    

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_HTMLText') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_HTMLText;
GO
CREATE FUNCTION [dbo].[fnUTP_HTMLText](@Key varchar(max))
	RETURNS varchar(max)
as
	BEGIN
		DECLARE @value varchar(max)
		select @value = value from UTP_HTML where [key]=@Key
		RETURN COALESCE(@value,'***')
	END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_MessageEnabled') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_MessageEnabled;
GO
-- DROP FUNCTION [dbo].[fnUTP_MessageEnabled]
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: May 18, 2016
-- Description: Function to determine if a message or action should be processed
-- Revisions: 
-- ====================================================================================
CREATE FUNCTION [dbo].[fnUTP_MessageEnabled](@Message varchar(64),@Location varchar(64))
	RETURNS bit
AS
BEGIN
	DECLARE @Enabled bit=1, @BlockedCount int

	SELECT @BlockedCount=COUNT(*) FROM [dbo].[UTP_MessageSwitch] WHERE 
		(@Message LIKE [Message]) AND (@Location LIKE [Location]) AND [Blocked]=1
	IF @BlockedCount>0 SET @Enabled=0
	RETURN @Enabled
END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_RelightAppt') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_RelightAppt;
GO
/*
	Update-20161007.sql
	Implement Relight functionality
*/
-- DROP FUNCTION [dbo].[fnUTP_RelightAppt]
CREATE FUNCTION [dbo].[fnUTP_RelightAppt](@OrderID int)
	RETURNS int
AS
BEGIN
	DECLARE @Relight int
	SELECT @Relight=COUNT(*) FROM [dbo].[UTP_Appointment] WHERE [OrderID]=@OrderID AND [AppointmentTypeID]=90312 -- Relight
		AND [AppointmentStatusID] IN (90321,90325) -- Booked or Completed
	RETURN @Relight
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_SelectListMaster') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_SelectListMaster;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 14, 2015
-- Description: Return List value by key
-- Revisions: 
-- ====================================================================================
CREATE FUNCTION [dbo].[fnUTP_SelectListMaster](@ListID int)
	RETURNS varchar(255)
as
	BEGIN
		DECLARE @value varchar(255)
		SELECT @value = ListValue from UTP_ListMaster where ListID=@ListID
		RETURN @value
	END




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnUTP_SelectListText') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION fnUTP_SelectListText;
GO

-- ====================================================================================
-- Author: John Peacock 
-- Create date: Jul 8, 2016
-- Description: Return List text by key
-- Revisions: 
-- ====================================================================================
CREATE FUNCTION [dbo].[fnUTP_SelectListText](@ListKey varchar(255), @ListValue varchar(255))
	RETURNS varchar(255)
as
	BEGIN
		DECLARE @value varchar(255)
		SELECT @value = ListText from UTP_ListMaster where ListKey=@ListKey and ListValue=@ListValue
		RETURN @value
	END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FW_DocumentUploaded') AND type in (N'P', N'PC')) DROP PROCEDURE FW_DocumentUploaded;
GO
-- DROP PROC [dbo].[FW_DocumentUploaded]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: September 15, 2016
-- Description: Set DocumentTypeID on uploaded document
-- Revisions:
--
-- ===========================================================
CREATE PROC [dbo].[FW_DocumentUploaded]
	@DocumentTypeID [int],
	@DocumentID [int]
AS
	DECLARE @Success int=0

	UPDATE [dbo].[UTP_Document] SET [DocumentTypeID]=@DocumentTypeID WHERE [DocumentID]=@DocumentID
	
	IF @@ROWCOUNT = 1 SET @Success=1
	
	RETURN @Success


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FW_IncomingDocument') AND type in (N'P', N'PC')) DROP PROCEDURE FW_IncomingDocument;
GO
/*
	Update-20160915
	Add support for UTOPIS4 FileWatcher Service
*/
-- DROP PROC [dbo].[FW_IncomingDocument]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: September 15, 2016
-- Description: Determine Repository and other information for FileWatcher
-- Revisions:
--
-- ===========================================================
CREATE PROC [dbo].[FW_IncomingDocument]
	@Path [varchar](1024),
	@Filename [varchar](1024),
	@DocumentTypeID [int] OUTPUT,
	@DocumentStorageID [int] OUTPUT
AS
	DECLARE @Success int=0

	SELECT @DocumentTypeID=CASE
		WHEN PATINDEX('%EMERGENCY%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','EMERGENCY')
		WHEN PATINDEX('%SERVICE%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','SERVICE') -- No SERVICE Document type
		WHEN PATINDEX('%MXGI%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','MXGI')
		WHEN PATINDEX('%STANDPIPE%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','STANDPIPE')
		WHEN PATINDEX('%RED_TAGS%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','RED TAGS')
		WHEN PATINDEX('%CR00_CR10%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','CR00/CR10')
		WHEN PATINDEX('%OTHER_WLM%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','OTHER WLM')
		WHEN PATINDEX('%REJECTS%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','REJECTS')
		WHEN PATINDEX('%OTHER%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','N/A')
		WHEN PATINDEX('%SURVEY%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','SURVEY')
		WHEN PATINDEX('%ROUTE_SHEET%', @Filename) > 0 THEN [dbo].[fnUTP_GetListMaster]('DocumentType','ROUTE SHEET')
		ELSE [dbo].[fnUTP_GetListMaster]('DocumentType','N/A')
		END
		
	DECLARE @DSRoot int = 1 -- just use first DocumentStorage record - can be changed
	-- SELECT @DocumentStorageID=MIN([DocumentStorageID]) FROM [dbo].[UTP_DocumentStorage] WHERE [RootFolder] <> ''
	-- SELECT @DocumentStorageID=[DocumentStorageID] FROM [dbo].[UTP_DocumentStorage] WHERE [DocumentStorageID]=@DSRoot
	DECLARE @LocalPath varchar(128), @RightNow DATETIME, @FullPath VARCHAR(1024)
	SELECT @RightNow=GETDATE()
	SELECT @LocalPath=CAST(DATEPART(YYYY,@RightNow) AS VARCHAR(4)) + '\' + RIGHT('00' + CAST(DATEPART(wk, @RightNow) AS VARCHAR(2)),2)
	SELECT @FullPath=[RootFolder] + '\' + @LocalPath FROM [dbo].[UTP_DocumentStorage] WHERE [DocumentStorageID]=@DSRoot
	SELECT @DocumentStorageID=[DocumentStorageID] FROM [dbo].[UTP_DocumentStorage] WHERE [RootFolder]=@FullPath
	IF @DocumentStorageID IS NULL
	BEGIN
		EXEC [dbo].[UTP_NewDocumentStorage] @FullPath, 0, @DocumentStorageID OUTPUT
	END
	
	IF (@DocumentStorageID IS NOT NULL) AND (@DocumentTypeID IS NOT NULL) SET @Success=1
	RETURN @Success



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_IncomingImage') AND type in (N'P', N'PC')) DROP PROCEDURE HH_IncomingImage;
GO

-- DROP PROC [dbo].[HH_IncomingImage]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: June 9, 2016
-- Description: Identify OrderID and DocumentRepositoryID for Image
-- Revisions:
--
-- ===========================================================
CREATE PROC [dbo].[HH_IncomingImage]
	@WR_ID [varchar](20),
	@OrderID int OUTPUT,
	@DocumentStorageID int OUTPUT,
	@Success [bit] OUTPUT
AS
	SET @Success=0
	DECLARE @DSRoot int = 1 -- just use first DocumentStorage record - can be changed
	SELECT @OrderID=[OrderID] FROM [dbo].[vw_TPS_WO] WHERE [WONUM]=@WR_ID
	-- SELECT @DocumentStorageID=MIN([DocumentStorageID]) FROM [dbo].[UTP_DocumentStorage] WHERE [RootFolder] <> ''
	-- SELECT @DocumentStorageID=[DocumentStorageID] FROM [dbo].[UTP_DocumentStorage] WHERE [DocumentStorageID]=@DSRoot
	DECLARE @LocalPath varchar(128), @RightNow DATETIME, @FullPath VARCHAR(1024)
	SELECT @RightNow=GETDATE()
	SELECT @LocalPath=CAST(DATEPART(YYYY,@RightNow) AS VARCHAR(4)) + '\' + RIGHT('00' + CAST(DATEPART(wk, @RightNow) AS VARCHAR(2)),2)
	SELECT @FullPath=[RootFolder] + '\' + @LocalPath FROM [dbo].[UTP_DocumentStorage] WHERE [DocumentStorageID]=@DSRoot
	SELECT @DocumentStorageID=[DocumentStorageID] FROM [dbo].[UTP_DocumentStorage] WHERE [RootFolder]=@FullPath
	IF @DocumentStorageID IS NULL
	BEGIN
		EXEC [dbo].[UTP_NewDocumentStorage] @FullPath, 0, @DocumentStorageID OUTPUT
	END
	
	IF (@OrderID IS NOT NULL) AND (@DocumentStorageID IS NOT NULL) SET @Success=1
	RETURN @Success


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_MapRecAction') AND type in (N'P', N'PC')) DROP PROCEDURE HH_MapRecAction;
GO

-- DROP PROC [dbo].[HH_MapRecAction]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: March 23, 2016
-- Description: Map HH_Action data received from Allegro
-- Revisions:
--	2016-05-19 Indication of Status Change returned
--	2016-05-27 Add support for missed HH events
--	2016-07-06 Send EGD Missed Status updates
--	2016-07-26 On ONSITE, truncate ACTSTART to minutes
--	2016-09-17 Added RRAcknowledgement as Sabre Action
--	2016-09-23 Added UTP_OrderHistory entry for WOSTATUS Update
--	2016-10-07 Added support for Relight Appointments
--	2016-10-13 Added Auto-Completion transmission to Enbridge
--	2016-11-18 Change COMPETE Received to Status Update Memo
-- ===========================================================
CREATE PROC [dbo].[HH_MapRecAction]
	@WONUM [varchar](12),
	@OrderID int,
	@ID int,
	@Success [bit] OUTPUT
AS
	DECLARE @Errors EGD_ErrorType
	DECLARE @NextStatus int
	DECLARE @loc varchar(128) = 'HH_MapRecAction'
	DECLARE @fail bit=0
	DECLARE @curv int, @NewKey int
	SET @Success=0

	DECLARE @MemoStatusID int, @CurrentUserID int, @Relight int = 0, @Fitter varchar(12), @FitterID int
	DECLARE @InternalMemoID int = [dbo].[fnUTP_GetListMaster]('MemoType','1')
	SELECT @MemoStatusID=[dbo].[fnUTP_GetListMaster]('MemoType','7'), @CurrentUserID=[dbo].[fnUTP_CurrentDomainUserID]()
	
	DECLARE @Action varchar(255), @TS DATETIME
	SELECT @Action=[ACTION],@TS=[Timestamp],@Fitter=[Fitter_ID] FROM [dbo].[HH_Action] WHERE [HH_ActionID] = @ID
	IF @@ROWCOUNT = 0
		BEGIN
			SET @fail=1
			INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
				VALUES ('10',0,'No HH_Action record found',@loc,'@ID',@ID)
		END
	ELSE IF @Fitter IS NOT NULL
	BEGIN
		SELECT @FitterID=[UserID] FROM [dbo].[UTP_User] WHERE [Username]=@Fitter
	END

	DECLARE @StatusID int, @STATUS varchar(255)
	IF @Action NOT IN ('Logon','Logoff')
	BEGIN
		SELECT @STATUS=dbo.fnUTP_SelectListMaster([WMStatusID]),@Relight=[dbo].[fnUTP_RelightAppt]([OrderID]) FROM UTP_WO WHERE [OrderID]=@OrderID
		IF @@ROWCOUNT = 0
			BEGIN
				SET @fail=1
				INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
					VALUES ('11',0,'No UTP_WO record found',@loc,'@OrderID',@OrderID)
			END
		ELSE IF @STATUS IS NULL 
			BEGIN
				SET @fail=1
				INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
					VALUES ('12',0,'Unknown STATUS on WorkOrder',@loc,'@OrderID',@OrderID)
			END
	END
	
	IF @Relight = 0
	BEGIN
		IF @Action IN ('Standard Acknowledgement','Sabre Acknowledgement','Hot Call Acknowledgement','RRAcknowledgement')
			BEGIN
				IF @STATUS IN ('SCHED','DISP')
				BEGIN
					SELECT @NextStatus=[dbo].[fnUTP_GetListMaster]('WMStatus','ACK')
					UPDATE UTP_WO SET WMStatusID=@NextStatus WHERE [OrderID]=@OrderID
					
					INSERT INTO [dbo].[UTP_OrderHistory] ([OrderID], [MemoTypeID],[CreatedByID],[CreatedTimestamp],[Memo],[TechnicianID])
					VALUES (@OrderID, @MemoStatusID,@CurrentUserID, GETDATE(),'HHAction: WOSTATUS=ACK',@FitterID)
						
					IF @STATUS <> 'DISP'
					BEGIN
						INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
							VALUES ('5006',4,'MISSING EVENTS.  WO STATUS PROGRESSED TO ACK FROM ' + @STATUS,@loc,'@OrderID',@OrderID)
					END
				END
				ELSE IF @STATUS = 'ACK'
				BEGIN
						INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
							VALUES ('5005',3,'REDUNDENT EVENT IGNORED. ' + @Action + ' Received with STATUS=' + @STATUS,@loc,'@OrderID',@OrderID)
				END
				ELSE IF @STATUS <> 'SUSPENDED'
				BEGIN
						INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
							VALUES ('5003',3,'WO STATUS ' + @STATUS + ' prevents ACK state change',@loc,'@OrderID',@OrderID)
				END
			END
		ELSE IF @Action = 'Enroute'
			BEGIN
				IF @STATUS IN ('SCHED','DISP','ACK')
					BEGIN
						SELECT @NextStatus=[dbo].[fnUTP_GetListMaster]('WMStatus','ENROUTE;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_MapRecCancelRaise') AND type in (N'P', N'PC')) DROP PROCEDURE HH_MapRecCancelRaise;
GO
-- DROP PROC [dbo].[HH_MapRecCancelRaise]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: April 15, 2016
-- Description: Map Cancel Raise data received from Allegro
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_MapRecCancelRaise]
	@WONUM [varchar](12),
	@OrderID int,
	@ID int,
	@Success [bit] OUTPUT
AS
	DECLARE @Errors EGD_ErrorType
	DECLARE @loc varchar(128) = 'HH_MapRecCancelRaise'
	DECLARE @fail bit=0
	SET @Success=0

	DECLARE @JobCodeID int, @RaiseType varchar(2), @tempwr_id varchar(12)
	SELECT @tempwr_id=[TEMP_WR_ID],@JobCodeID=[JobCodeID],@RaiseType=[RaiseType] 
		FROM [dbo].[HH_CancelRaise] WHERE [HH_CancelRaiseID]=@ID
	IF @@ROWCOUNT <> 1
		BEGIN
			SET @fail=1
			INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
				VALUES ('16',0,'HH_CancelRaise record not found',@loc,'@ID',@ID)
		END
	
	DECLARE @STATUS varchar(12)
	SELECT @STATUS=dbo.fnUTP_SelectListMaster([WMStatusID]) FROM UTP_WO WHERE [OrderID]=@OrderID
	IF @@ROWCOUNT = 0
		BEGIN
			SET @fail=1
			INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
				VALUES ('11',0,'No UTP_WO record found',@loc,'@OrderID',@OrderID)
		END
	ELSE
		BEGIN
			IF @STATUS IS NULL
				BEGIN
					SET @fail=1
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						VALUES ('12',0,'Unknown STATUS on WorkOrder',@loc,'@OrderID',@OrderID)
				END

			ELSE IF @STATUS <> 'WCOMP'
				BEGIN
					SET @fail=1
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						VALUES ('14',0,'WO STATUS ' + @STATUS + ' prevents Cancel Raise',@loc,'@OrderID',@OrderID)
				END

		END

	SELECT Code,Level,Message,Location,Param,ParamValue FROM @Errors
	IF @fail = 0
		BEGIN
			SET @Success=1
			RETURN 1
		END
	ELSE
		BEGIN
			RETURN -1
		END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_MapRecCompletion') AND type in (N'P', N'PC')) DROP PROCEDURE HH_MapRecCompletion;
GO
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: March 23, 2016
-- Description: Map Completion data received from Allegro
-- Revisions:
--	2016-05-27 Add support for missed HH events
--	2016-06-27 Migrate APEQTYPE to EGD_WO and Process CompCode
--		20 and DS
--	2016-07-06 Send EGD Status Changes for missed events
--	2016-07-26 Support ASSETSPEC and MULTIASSETSPEC FAs
--		Ensure ACTFINISH >= ACTSTART
--	2016-09-23 Added UTP_OrderHistory entry for WOSTATUS Update
--	2016-09-26 Added UTP_Appointment completion
--	2016-10-07 Added support for Relight Appointments
--	2016-10-13 Added suport for N/A values in Dropdowns
--	2016-10-24 Store Fitter Remarks in UTP_OrderHistory
--	2016-11-07 Truncate EGD_WO REMARKDESC to 255 characters
--  2017-01-20 DM - Increase RemarkDesc to 400
--	2017-02-09 Create Worklog and OrderHistory on EarlyArrival
--	2018-08-17 IDM - Support LPC Work Orders
-- ===========================================================
CREATE PROC [dbo].[HH_MapRecCompletion]
	@WONUM [varchar](12),
	@OrderID int,
	@ID int,
	@Success [bit] OUTPUT
AS
	DECLARE @Errors EGD_ErrorType
	DECLARE @loc varchar(128) = 'HH_MapRecCompletion'
	DECLARE @fail bit=0
	DECLARE @StatusDate DATETIME
	SET @Success=0
	DECLARE @ActStart DATETIME, @ActFinish DATETIME, @MeterStatus varchar(10)
	DECLARE @MagicNAValue varchar(20)='#^'

	DECLARE @MemoStatusID int, @CurrentUserID int,@Remarks varchar(max)='', @MemoInternalID int
	SELECT @MemoStatusID=[dbo].[fnUTP_GetListMaster]('MemoType','7'), @CurrentUserID=[dbo].[fnUTP_CurrentDomainUserID](),@MemoInternalID=[dbo].[fnUTP_GetListMaster]('MemoType','1')

	DECLARE @STATUSID int, @STATUS varchar(255), @CompCode varchar(20), @Relight int = 0
	DECLARE @Fitter varchar(30), @FitterID int, @EarlyNow bit
	DECLARE @RelightTypeID int=[dbo].[fnUTP_GetListMaster]('AppointmentType','Relight')
	DECLARE @ProjectFitterID int, @ProjectFitter varchar(30),@ProjectStartDate datetime, @ProjectEndDate datetime, @CurrentApptID int, @CurrentApptTypeID int, @ProjectApptID int, @OldProjectApptID int
	DECLARE @CurrentTimeslotID int
	DECLARE @PPE varchar(1)='', @ESI varchar(1)='', @STF varchar(1)='', @OEH varchar(1)='', @AOH varchar(1)='', @HazardNotes varchar(max)='<none>'

	SELECT @CompCode=[RESOLUTION_CODE],@Fitter=[CompletionFitterCode],@EarlyNow=[EarlyNow],@MeterStatus=[METER_STATUS],
		@PPE=ISNULL([PPE],''),@ESI=ISNULL([ESI],''),@STF=ISNULL([STF],''),@OEH=ISNULL([OEH],''),@AOH=ISNULL([AOH],''),@HazardNotes=ISNULL([HazardNotes],'<none>')
	FROM [dbo].[HH_Completion] WHERE [HH_CompletionID]=@ID

	SELECT @Remarks+=CASE WHEN [REMARK_CONTENT] IS NULL OR LEN([REMARK_CONTENT]) = 0 THEN '' ELSE RTRIM([REMARK_CONTENT]) + ' ' END FROM HH_Remark WHERE HH_CompletionID=@ID ORDER BY [HH_RemarkID] ASC
	IF (LEN(@Remarks) > 0) SELECT @Remarks=RTRIM(@Remarks)
	ELSE SET @Remarks=NULL

	SELECT @FitterID=[UserID] FROM [dbo].[UTP_User] with(nolock) WHERE [UserName]=@Fitter
	SELECT @STATUS=dbo.fnUTP_SelectListMaster([WMStatusID]),@Relight=[dbo].[fnUTP_RelightAppt]([OrderID]) FROM UTP_WO WHERE [OrderID]=@OrderID
	IF @@ROWCOUNT = 0
		BEGIN
			SET @fail=1
			INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
				VALUES ('11',0,'No UTP_WO record found',@loc,'@OrderID',@OrderID)
		END
	ELSE IF @Relight = 0
		BEGIN
			IF @STATUS IS NULL
				BEGIN
					SET @fail=1
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						VALUES ('12',0,'Unknown STATUS on WorkOrder',@loc,'@OrderID',@OrderID)
				END

			ELSE IF @STATUS IN ('SCHED','DISP','ACK','ENROUTE','ONSITE','SUSPENDED') AND @CompCode IN ('99','80')
			BEGIN
				-- check if Project work and re-dispatch if so
				SELECT TOP 1 @CurrentApptID=[AppointmentID],@CurrentApptTypeID=[AppointmentTypeID],@CurrentTimeslotID=[TimeslotID]
					FROM [dbo].[UTP_Appointment] WHERE [OrderID]=@OrderID AND [AppointmentStatusID]=90321 /* Booked */ ORDER BY [Appoin;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_MapRecData') AND type in (N'P', N'PC')) DROP PROCEDURE HH_MapRecData;
GO

CREATE PROC [dbo].[HH_MapRecData]
	@TransactionData [varchar](512),
	@Success [bit] OUTPUT
AS
	DECLARE @Type varchar(20), @WONUM varchar(12), @WOID int, @ID int, @OrderID int
	DECLARE @Errors EGD_ErrorType
	DECLARE @subxml XML
	DECLARE @loc varchar(128) = 'HH_MapRecData'
	DECLARE @fail bit=0
	DECLARE @OrgShortName varchar(20)
	SELECT @subxml=CAST(@TransactionData AS XML)
	SET @Success=0

	SELECT @Type=@subxml.value('(/HHRECMAP/@TYPE)[1]','varchar(20)'),
		@WOID=@subxml.value('(/HHRECMAP/@WOID)[1]','int'),
		@OrderID=@subxml.value('(/HHRECMAP/@OrderID)[1]','int'),
		@WONUM=@subxml.value('(/HHRECMAP/@WR_ID)[1]','varchar(12)'),
		@ID=@subxml.value('(/HHRECMAP//@ID)[1]','int')

	-- VALIDATE that Work Order exists
	IF (@OrderID IS NULL) OR ((SELECT COUNT(*) FROM vw_TPS_WO WHERE OrderID=@OrderID) <> 1)
		BEGIN
			IF @Type <> 'ACTION'
			BEGIN
				SET @fail=1
				INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
					VALUES ('1',0,'OrderID is invalid',@loc,'@TransactionData',@TransactionData)
			END
		END
	IF @Type IS NULL
		BEGIN
			SET @fail=1
			INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
				VALUES ('3',0,'TYPE is NULL',@loc,'@TransactionData',@TransactionData)
		END

	IF @fail = 0
		BEGIN
			SELECT @OrgShortName=OrgShortName FROM vw_TPS_WO WHERE OrderID=@OrderID
			IF (@Type = 'ACTION')
				BEGIN
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						EXEC [dbo].[HH_MapRecAction] @WONUM,@OrderID,@ID, @Success OUTPUT
				END
			ELSE IF (@Type = 'IMAGE')
				BEGIN
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						EXEC [dbo].[HH_MapRecImage] @WONUM,@OrderID,@ID, @Success OUTPUT
				END
			ELSE IF (@Type = 'RAISE')
				BEGIN
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						EXEC [dbo].[HH_MapRecRaise] @WONUM,@OrderID,@ID, @Success OUTPUT
				END
			ELSE IF (@Type = 'COMPLETE')
				BEGIN
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						EXEC [dbo].[HH_MapRecCompletion] @WONUM,@OrderID,@ID, @Success OUTPUT
				END
			ELSE IF (@Type = 'NOTES')
				BEGIN
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						EXEC [dbo].[HH_MapRecNotes] @WONUM,@OrderID,@ID, @Success OUTPUT
				END
			ELSE IF (@Type = 'CANCELRAISE')
				BEGIN
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						EXEC [dbo].[HH_MapRecCancelRaise] @WONUM,@OrderID,@ID, @Success OUTPUT
				END
			ELSE
				BEGIN
					INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
						VALUES('2',0,'Unknown Type',@Loc,'@TransactionData',@TransactionData)
					SET @fail=1
				END
			
		END
	
	SELECT Code,Level,Message,Location,Param,ParamValue FROM @Errors
	IF @Success = 1
		BEGIN
			RETURN 1
		END
	ELSE
		BEGIN
			RETURN -1
		END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_MapRecImage') AND type in (N'P', N'PC')) DROP PROCEDURE HH_MapRecImage;
GO
CREATE PROC [dbo].[HH_MapRecImage]
	@WONUM [varchar](12),
	@OrderID int,
	@ID int,
	@Success [bit] OUTPUT
AS
	DECLARE @Errors EGD_ErrorType
	DECLARE @loc varchar(128) = 'HH_MapRecImage'
	DECLARE @fail bit=0
	SET @Success=0
	DECLARE @DocumentType int, @DocumentID int, @Description varchar(254), @UploadedByID int
	
	SELECT @DocumentID=[UTPDocumentID], 
		@DocumentType=CASE LOWER(RTRIM(ImgDescription))
			WHEN 'before' THEN dbo.fnUTP_GetListMaster('DocumentType','PHOTO_BEFORE')
			WHEN 'after' THEN dbo.fnUTP_GetListMaster('DocumentType','PHOTO_AFTER')
			WHEN 'unable to complete' THEN dbo.fnUTP_GetListMaster('DocumentType','PHOTO_UNABLE_TO_COMPLETE')
			WHEN 'please advise' THEN dbo.fnUTP_GetListMaster('DocumentType','PHOTO_PLEASE_ADVISE')
			WHEN 'cgi' THEN dbo.fnUTP_GetListMaster('DocumentType','PHOTO_CGI')
			WHEN 'coa' THEN dbo.fnUTP_GetListMaster('DocumentType','PHOTO_COA')
			WHEN 'other' THEN dbo.fnUTP_GetListMaster('DocumentType','PHOTO_OTHER')
			ELSE dbo.fnUTP_GetListMaster('DocumentType','PHOTO_OTHER')
			END,
		@Description=[ImgDescription], @UploadedByID=u.[UserID]
		FROM [dbo].[HH_ImageData] id LEFT JOIN UTP_User u ON u.Username=id.UploadedBy WHERE [HH_ImageDataID]=@ID
		
	IF @DocumentID IS NOT NULL
	BEGIN
		UPDATE [dbo].[UTP_Document] SET [DocumentTypeID]=@DocumentType WHERE [DocumentID]=@DocumentID
	END

	INSERT INTO [dbo].[UTP_OrderHistory] ([OrderID],[MemoTypeID],[CreatedByID],[CreatedTimestamp],[Memo],[TechnicianID])
	VALUES (@OrderID, dbo.fnUTP_GetListMaster('MemoType','1'), dbo.fnUTP_CurrentDomainUserID(), GETDATE(), 
		'HHImage: Image ' + isnull(@Description,'') + ' Received from Sabre',@UploadedByID)

	SELECT Code,Level,Message,Location,Param,ParamValue FROM @Errors
	IF @fail = 0
		BEGIN
			SET @Success=1
			RETURN 1
		END
	ELSE
		BEGIN
			RETURN -1
		END




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_MapRecNotes') AND type in (N'P', N'PC')) DROP PROCEDURE HH_MapRecNotes;
GO
-- DROP PROC [dbo].[HH_MapRecNotes]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: March 23, 2016
-- Description: Map Notes data received from Allegro
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_MapRecNotes]
	@WONUM [varchar](12),
	@OrderID int,
	@ID int,
	@Success [bit] OUTPUT
AS
	DECLARE @Errors EGD_ErrorType
	DECLARE @loc varchar(128) = 'HH_MapRecNotes'
	DECLARE @fail bit=0
	SET @Success=0
	
	IF @ID IS NULL SET @ID=0

	INSERT INTO [dbo].[UTP_OrderHistory] ([OrderID],[MemoTypeID],[CreatedByID],[CreatedTimestamp],[Memo],[TechnicianID])
	SELECT @OrderID, dbo.fnUTP_GetListMaster('MemoType','1'), dbo.fnUTP_CurrentDomainUserID(),note.[DateStamp],note.[NoteText],usr.[UserID]
		FROM [dbo].[HH_Note] note
		LEFT JOIN [dbo].[UTP_User] usr with(nolock) ON usr.[UserName]=note.[UpdateBy]
		WHERE note.[OrderID]=@OrderID AND note.[HH_NoteID] >= @ID

	SELECT Code,Level,Message,Location,Param,ParamValue FROM @Errors
	IF @fail = 0
		BEGIN
			SET @Success=1
			RETURN 1
		END
	ELSE
		BEGIN
			RETURN -1
		END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_MapRecRaise') AND type in (N'P', N'PC')) DROP PROCEDURE HH_MapRecRaise;
GO
-- DROP PROC [dbo].[HH_MapRecRaise]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: March 23, 2016
-- Description: Map Raise data received from Allegro
-- Revisions:
--     Jan 20, 2017 -  DM Increase RemarkDesc to 400
-- ===========================================================
CREATE PROC [dbo].[HH_MapRecRaise]
	@WONUM [varchar](12),
	@Order int,
	@ID int,
	@Success [bit] OUTPUT
AS
	DECLARE @Errors EGD_ErrorType
	DECLARE @loc varchar(128) = 'HH_MapRecRaise'
	DECLARE @fail bit=0
	SET @Success=0
	DECLARE @MagicNAValue varchar(20)='#^'

	DECLARE @CompletionDate DATETIME, @JobCode varchar(64), @JobType varchar(64), @ResolutionCode varchar(20)
	DECLARE @JobCodeID int, @Remarks varchar(MAX)='',@DateStamp DATETIME,@ActualStart DATETIME, @ActualFinish DATETIME
	DECLARE @RaiseType varchar(2), @TempWRID varchar(20),@APEQType varchar(2), @JCRaiseType varchar(10)
	DECLARE @Fitter varchar(30), @FitterID int, @RaiseOrderID int, @ParentOrderID int
	
	/*
	SELECT @CompletionDate=[COMPLETION_DATE],@JobCode=[JOB_CODE],@JobType=[JOB_TYPE],@ResolutionCode=[RESOLUTION_CODE],
		@DateStamp=[DateStamp],@RaiseType=[RaiseType],@JobCodeID=[JobCodeID],@TempWRID=[WR_ID],@APEQType=[APEQTYPE],
		@Fitter=[COMPLETION_FITTER_ID]
		FROM [dbo].[HH_RaiseComplete] 
		WHERE [HH_RaiseCompleteID]=@ID
	*/

	SET @fail=1
	INSERT INTO @Errors (Code,Level,Message,Location,Param,ParamValue)
		VALUES ('20',0,'Raise not supported for this Work Order',@loc,'@ID',@ID)

	SELECT Code,Level,Message,Location,Param,ParamValue FROM @Errors
	IF @fail = 0
		BEGIN
			SET @Success=1
			RETURN 1
		END
	ELSE
		BEGIN
			RETURN -1
		END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_ReceiveAction') AND type in (N'P', N'PC')) DROP PROCEDURE HH_ReceiveAction;
GO
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: January 8, 2016
-- Description: Receive Action information from Allegro
-- 		Return 1 on success, negative value on failure
--		@Success set true on success
--		Any errors encountered are returned as HH_ErrorDataType
-- Revisions:
--	2016-12-16 IDM Modified to directly call HH_MapRecData activity without queuing
-- ====================================================================================
CREATE PROC [dbo].[HH_ReceiveAction]
	@Action [dbo].[HH_ActionType] READONLY,
	@Success bit output
AS
	DECLARE @ErrorData HH_ErrorDataType, @Loc varchar(128)
	SET @Loc='HH_ReceiveAction'
	DECLARE @RV int
	SET @RV=0
	IF (SELECT COUNT(*) FROM @Action) <> 1
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('21',0,'Only one HH_Action row may be supplied', @Loc)
			SET @Success=0
			SET @RV=-1
		END
	DECLARE @WONUM varchar(12), @SabreAction varchar(20)
	SELECT @WONUM=[WR_ID],@SabreAction=[Action] FROM @Action

	IF (@WONUM IS NULL) AND (@SabreAction NOT IN ('Logon','Logoff'))
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param) VALUES('22',0,'WR_ID is NULL', @Loc, 'WR_ID')
			SET @Success=0
			SET @RV=-2
		END
	DECLARE @OrderID int, @OrgShortName varchar(20), @WOID int
	SELECT @OrderID=OrderID,@OrgShortName=OrgShortName,@WOID=WOID FROM [dbo].[vw_TPS_WO] WHERE WONUM=@WONUM
	IF (@OrderID IS NULL) AND (@SabreAction NOT IN ('Logon','Logoff'))
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param,ParamValue) VALUES('23',0,'WONUM not found', @Loc, 'WR_ID', @WONUM)
			SET @Success=0
			SET @RV=-3
		END

	IF @RV = 0
	BEGIN
		INSERT INTO HH_Action (
			[OrderID],
			[LocalTimestamp],
			[WR_ID],
			[ApptID],
			[Action],
			[Fitter_ID],
			[Timestamp]
		)
		SELECT 
			@OrderID,
			GetDate(),
			[WR_ID],
			[ApptID],
			[Action],
			[Fitter_ID],
			[Timestamp]
		FROM @Action
		DECLARE @rows int
		SET @rows=@@ROWCOUNT
		IF @rows = 1
			BEGIN
				SET @Success=1
				SET @RV=1
			END
		ELSE
			BEGIN
				INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location) VALUES('24',0,'Rows inserted not 1 : ' + CAST(@rows AS varchar(20)),@Loc)
				SET @Success=0
				SET @RV=-4
			END
	END

	IF (@RV = 1)
		BEGIN
			DECLARE @ID int, @TransactionData varchar(max), @subxml XML, @insresult int,@Priority int, @NewKey int
			DECLARE @MapSuccess bit
			SET @ID=@@IDENTITY
			IF (SELECT [dbo].[fnUTP_MessageEnabled]('HHRECMAPDIRECT','HH_ReceiveAction')) = 1
			BEGIN
				INSERT INTO @ErrorData ([Code],[ErrorLevel],[Message],[Location],[Param],[ParamValue])
					EXEC [dbo].[HH_MapRecAction] @WONUM,@OrderID,@ID, @MapSuccess OUTPUT
				IF @MapSuccess <> 1
				BEGIN
					SET @RV=-5
					SET @Success=0
				END
			END
			ELSE
			BEGIN
				SET @subxml=(SELECT [TYPE]='ACTION',[WOID]=[WOID],[OrderID]=[OrderID],[WR_ID]=[WONUM],[ID]=@ID FROM [dbo].[vw_UTP_WO] HHRECMAP WHERE [OrderID]=@OrderID FOR XML AUTO) 
				SELECT @TransactionData=CAST(@subxml AS varchar(max))
					EXEC @insresult=[dbo].[QUE_InsertCTPTransaction] @Priority, @WONUM, 'HHRECMAP', @TransactionData, @NewKey OUTPUT
					IF @insresult <> 1
						BEGIN
							INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location) VALUES('25',0,'Unable to Insert CTP Transaction:' + CAST(@insresult AS varchar(20)),@Loc)
							SET @Success=0
							SET @RV=-5
						END
			END
		END

	SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData

	RETURN @RV



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_ReceiveCancelRaise') AND type in (N'P', N'PC')) DROP PROCEDURE HH_ReceiveCancelRaise;
GO
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: April 15, 2016
-- Description: Receive Cancel Child Work Order information from Allegro
-- 		Return 1 on success, negative value on failure
--		@Success set true on success
--		Any errors encountered are returned as HH_ErrorDataType
-- Revisions:
--	2016-12-16 IDM Modified to directly call HH_MapRecData activity without queuing
-- ====================================================================================
CREATE PROC [dbo].[HH_ReceiveCancelRaise]
	@Cancel [dbo].[HH_CancelRaiseType] READONLY,
	@Success bit output
AS
	DECLARE @ErrorData HH_ErrorDataType, @Loc varchar(128)
	SET @Loc='HH_ReceiveCancelRaise'
	DECLARE @RV int
	SET @RV=0
	IF (SELECT COUNT(*) FROM @Cancel) <> 1
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('21',0,'Only one HH_CancelRaise row may be supplied', @Loc)
			SET @Success=0
			SET @RV=-1
		END
	DECLARE @WONUM varchar(12)
	SET @WONUM=(SELECT PARENT_WR_ID FROM @Cancel)
	IF @WONUM IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param) VALUES('22',0,'WR_ID is NULL', @Loc, 'WR_ID')
			SET @Success=0
			SET @RV=-2
		END
	DECLARE @WOID int, @OrderID int, @OrgShortName varchar(20)
	SELECT @WOID=WOID,@OrderID=OrderID,@OrgShortName=OrgShortName FROM [dbo].[vw_TPS_WO] WHERE WONUM=@WONUM
	IF @OrderID IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param,ParamValue) VALUES('23',0,'WONUM not found', @Loc, 'WR_ID', @WONUM)
			SET @Success=0
			SET @RV=-3
		END

	IF @RV = 0
	BEGIN
		INSERT INTO HH_CancelRaise (
			[OrderID],
			[LocalTimestamp],
			[PARENT_WR_ID],
			[TEMP_WR_ID],
			[JobCodeID],
			[RaiseType],
			[Fitter_ID],
			[COMMENTS]
		)
		SELECT 
			@OrderID,
			GetDate(),
			[PARENT_WR_ID],
			[TEMP_WR_ID],
			[JobCodeID],
			[RaiseType],
			[Fitter_ID],
			[COMMENTS]
		FROM @Cancel
		DECLARE @rows int
		SET @rows=@@ROWCOUNT
		IF @rows = 1
			BEGIN
				SET @Success=1
				SET @RV=1
			END
		ELSE
			BEGIN
				INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location) VALUES('24',0,'Rows inserted not 1 : ' + CAST(@rows AS varchar(20)),@Loc)
				SET @Success=0
				SET @RV=-4
			END
	END

	IF (@RV = 1)
		BEGIN
			DECLARE @ID int, @TransactionData varchar(max), @subxml XML, @insresult int,@Priority int, @NewKey int
			DECLARE @MapSuccess bit
			SET @ID=@@IDENTITY
			IF (SELECT [dbo].[fnUTP_MessageEnabled]('HHRECMAPDIRECT','HH_ReceiveCancelRaise')) = 1
			BEGIN
				INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param,ParamValue)
					EXEC [dbo].[HH_MapRecCancelRaise] @WONUM,@OrderID,@ID, @MapSuccess OUTPUT
				IF @MapSuccess <> 1
				BEGIN
					SET @RV=-6
					SET @Success=0
				END
			END
			ELSE
			BEGIN
				SET @subxml=(SELECT [TYPE]='CANCELRAISE',[WOID]=[WOID],[OrderID]=[OrderID],[WR_ID]=[WONUM],[ID]=@ID FROM [dbo].[vw_TPS_WO] HHRECMAP WHERE [OrderID]=@OrderID FOR XML AUTO) 
				SELECT @TransactionData=CAST(@subxml AS varchar(max))
				EXEC @insresult=[dbo].[QUE_InsertCTPTransaction] @Priority, @WONUM, 'HHRECMAP', @TransactionData, @NewKey OUTPUT
				IF @insresult <> 1
					BEGIN
						INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location) VALUES('25',0,'Unable to Insert CTP Transaction:' + CAST(@insresult AS varchar(20)),@Loc)
						SET @Success=0
						SET @RV=-5
					END
			END
		END

	SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData

	RETURN @RV


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_ReceiveCompletion') AND type in (N'P', N'PC')) DROP PROCEDURE HH_ReceiveCompletion;
GO
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: January 8, 2016
-- Description: Receive Completion information from Allegro
-- 		Return 1 on success, negative value on failure
--		@Success set to true on success
--		Any errors encountered are returned as HH_ErrorDataType
-- Revisions:
--	2016-12-16 IDM Modified to directly call HH_MapRecData activity without queuing
-- ====================================================================================
CREATE PROC [dbo].[HH_ReceiveCompletion]
	@CoreData [HH_WRCoreDataCompletionType] READONLY,
	@FA [HH_FieldAttributeType] READONLY,
	@Remarks [HH_RemarkType] READONLY,
	@Appointment [HH_AppointmentCompletionType] READONLY,
	@Success [bit] OUTPUT
AS
	DECLARE @ErrorData HH_ErrorDataType, @Loc varchar(128)
	SET @Loc='HH_ReceiveCompletion'
	DECLARE @RV int
	SET @RV=0
	IF (SELECT COUNT(*) FROM @CoreData) <> 1
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('21',0,'Only one WRCoreDataCompletion row may be supplied', @Loc)
			SET @Success=0
			SET @RV=-1
		END
	DECLARE @WONUM varchar(12)
	SET @WONUM=(SELECT WR_ID FROM @CoreData)
	IF @WONUM IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('22',0,'WR_ID is NULL', @Loc)
			SET @Success=0
			SET @RV=-2
		END
	DECLARE @WOID int, @OrderID int, @OrgShortName varchar(20)
	SELECT @WOID=WOID,@OrderID=OrderID,@OrgShortName=OrgShortName FROM [dbo].[vw_TPS_WO] WHERE WONUM=@WONUM
	IF @OrderID IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param, ParamValue) VALUES('23',0,'WONUM not found', @Loc, 'WR_ID', @WONUM)
			SET @Success=0
			SET @RV=-3
		END
	IF (SELECT COUNT(*) FROM @FA WHERE WR_ID <> @WONUM) <> 0
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param) VALUES('28',0,'FA Found with WR_ID not ' + @WONUM, @Loc, '@FA')
			SET @Success=0
			SET @RV=-4
		END
	IF (SELECT COUNT(*) FROM @Remarks WHERE WR_ID <> @WONUM) <> 0
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param) VALUES('29',0,'Remark Found with WR_ID not ' + @WONUM, @Loc, '@Remarks')
			SET @Success=0
			SET @RV=-5
		END
	IF (SELECT COUNT(*) FROM @Appointment) > 1
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param) VALUES('31',0,'Multipe HH_AppointmentCompletion Records not allowed', @Loc, '@Appointment')
			SET @Success=0
			SET @RV=-6
		END
	IF (SELECT COUNT(*) FROM @Appointment WHERE WR_ID <> @WONUM) > 0
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param) VALUES('32',0,'WRCoreData and Appointment WR_ID values must match', @Loc, '@Appointment')
			SET @Success=0
			SET @RV=-7
		END
		
	IF @RV = 0
		BEGIN
			INSERT INTO HH_Completion (
				[OrderID],
				[LocalTimestamp],
				[WR_ID],
				[COMPLETION_DATE],
				[DateStamp],
				[METER_NUMBER],
				[METER_STATUS],
				[RESOLUTION_CODE],
				[WOAppointmentID],
				[ArrivalTimeHHMM],
				[CompletionTimeHHMM],
				[UpdateDate],
				[CompletionDate],
				[AppointmentType],
				[EarlyNow],
				[LateWindow],
				[CompletionFitterCode],
				[GPSCurrentCoordinates],
				[GPSOverride],
				[OnSiteGPSTimestamp],
				[OnSiteLatitude],
				[OnSiteLongitude],
				[FailureCodeID],
				[FailureClass],
				[FailureProblem],
				[FailureCause],
				[FailureRemedy],
				[PPE],
				[ESI],
				[STF],
				[OEH],
				[AOH],
				[HazardNotes]
			)
			SELECT 
				@OrderID,
				GetDate(),
				cd.[WR_ID],
				cd.[COMPLETION_DATE],
				cd.[DateStamp],
				cd.[METER_NUMBER],
				cd.[METER_STATUS],
				cd.[RESOLUTION_CODE],
				ap.[WOAppointmentID],
				ap.[ArrivalTimeHHMM],
				ap.[CompletionTimeHHMM],
				ap.[UpdateDate],
				ap.[CompletionDate],
				ap.[AppointmentType],
				ap.[EarlyNow],
				ap.[LateWindow],
				ap.[CompletionFitterCode],
				ap.[GPSCurrentCoordinates],
				ap.;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_ReceiveFieldAttributes') AND type in (N'P', N'PC')) DROP PROCEDURE HH_ReceiveFieldAttributes;
GO
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: January 8, 2016
-- Description: Receive FieldAttributes information from Allegro
-- 		Can be part of ReceiveRaiseComplete or ReceiveCompletion activity
-- 		Return 1 on success, negative value on failure
--		No records or NULL @FA is success
--		@Success set true on success
--		Any errors encountered are returned as HH_ErrorDataType
-- Revisions:
-- ====================================================================================
CREATE PROC [dbo].[HH_ReceiveFieldAttributes]
	@FA [HH_FieldAttributeType] READONLY,
	@HHRecordType [varchar](1),
	@OrderID [int],
	@ParentRecordID [int] = NULL,
	@Success [bit] OUTPUT
AS
	DECLARE @ErrorData HH_ErrorDataType, @Loc varchar(128)
	SET @Loc='HH_ReceiveFieldAttributes'
	-- If no records or @FA is NULL return success
	IF (SELECT COUNT(*) FROM @FA) = 0 
		BEGIN
			SET @Success=1
			SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
			RETURN 1
		END
	
	DECLARE @HHRaiseCompleteID int
	DECLARE @HHCompletionID int
	IF @HHRecordType = 'R'
		BEGIN
			SET @HHRaiseCompleteID=@ParentRecordID
			SET @HHCompletionID=NULL
		END
	ELSE IF @HHRecordType = 'C'
		BEGIN
			SET @HHRaiseCompleteID=NULL
			SET @HHCompletionID=@ParentRecordID
		END
	ElSE
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param,ParamValue) VALUES('25',0,'Invalid @HHRecordType',@Loc,'@HHRecordType',@HHRecordType)
			SET @Success=0
			SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
			RETURN -3
		END
	
	INSERT INTO [dbo].[HH_FieldAttribute] (
		[OrderID],
		[LocalTimestamp],
		[HH_RecordType],
		[HH_RaiseCompleteID],
		[HH_CompletionID],
		[WR_ID],
		[PARENT_WR_ID],
		[ATTRIBUTE_CODE],
		[FAName],
		[FAValue],
		[VALIDATION_CODE],
		[DEFAULT_VALUE],
		[FA_ID],
		[ReadOnly],
		[DataType],
		[LENGTH],
		[Sequence],
		[FieldValidation]
	)
	SELECT 
		@OrderID,
		GetDate(),
		@HHRecordType,
		@HHRaiseCompleteID,
		@HHCompletionID,
		[WR_ID],
		[PARENT_WR_ID],
		[ATTRIBUTE_CODE],
		[FAName],
		[FAValue],
		[VALIDATION_CODE],
		[DEFAULT_VALUE],
		[FA_ID],
		[ReadOnly],
		[DataType],
		[LENGTH],
		[Sequence],
		[FieldValidation]
	FROM @FA
	SET @Success=1
	SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
	RETURN 1


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_ReceiveImage') AND type in (N'P', N'PC')) DROP PROCEDURE HH_ReceiveImage;
GO
CREATE PROC [dbo].[HH_ReceiveImage]
	@ImageData [HH_ImageDataType] READONLY,
	@Success [bit] output
AS
	DECLARE @ErrorData HH_ErrorDataType, @Loc varchar(128)
	SET @Loc='HH_ReceiveImage'
	DECLARE @RV int
	SET @RV=0

	IF (SELECT COUNT(*) FROM @ImageData) <> 1
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('21',0,'Only one HH_ImageData row may be supplied', @Loc)
			SET @Success=0
			SET @RV=-1
		END
	DECLARE @WONUM varchar(12)
	SET @WONUM=(SELECT WR_ID FROM @ImageData)
	IF @WONUM IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('22',0,'WR_ID is NULL', @Loc)
			SET @Success=0
			SET @RV=-2
		END
	DECLARE @WOID int,@OrderID int,@OrgShortName varchar(20)
	SELECT @WOID=WOID,@OrderID=OrderID,@OrgShortName=OrgShortName FROM [dbo].[vw_TPS_WO] WHERE WONUM=@WONUM
	IF @OrderID IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param, ParamValue) VALUES('23',0,'WONUM not found', @Loc, 'WR_ID', @WONUM)
			SET @Success=0
			SET @RV=-3
		END

	IF @RV = 0
		BEGIN
			INSERT INTO HH_ImageData (
				[OrderID],
				[LocalTimestamp],
				[WR_ID],
				[DocumentID],
				[DocumentData],
				[DateStamp],
				[UploadedBy],
				[ImgDescription],
				[UTPDocumentID]
			)
			SELECT 
				@OrderID,
				GetDate(),
				[WR_ID],
				[DocumentID],
				[DocumentData],
				[DateStamp],
				[UploadedBy],
				[ImgDescription],
				[UTPDocumentID]
			FROM @ImageData
			DECLARE @rows int
			SET @rows=@@ROWCOUNT
			IF @rows = 1
				BEGIN
					SET @Success=1
					SET @RV=1
				END
			ELSE
				BEGIN
					INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location) VALUES('24',0,'Rows inserted not 1 : ' + CAST(@rows AS varchar(20)),@Loc)
					SET @Success=0
					SET @RV=-4
				END
		END

	IF (@RV = 1)
		BEGIN
			DECLARE @ID int, @TransactionData varchar(max), @subxml XML, @insresult int,@Priority int, @NewKey int
			DECLARE @MapSuccess bit
			SET @ID=@@IDENTITY
			IF (SELECT [dbo].[fnUTP_MessageEnabled]('HHRECMAPDIRECT','HH_ReceiveImage')) = 1
			BEGIN
				INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param,ParamValue)
					EXEC [dbo].[HH_MapRecImage] @WONUM,@OrderID,@ID, @MapSuccess OUTPUT
				IF @MapSuccess <> 1
				BEGIN
					SET @RV=-6
					SET @Success=0
				END
			END
			ELSE
			BEGIN
				SET @subxml=(SELECT [TYPE]='IMAGE',[WOID]=[WOID],[OrderID]=[OrderID],[WR_ID]=[WONUM],[ID]=@ID FROM [dbo].[vw_TPS_WO] HHRECMAP WHERE [OrderID]=@OrderID FOR XML AUTO)
				SELECT @TransactionData=CAST(@subxml AS varchar(max))
				EXEC @insresult=[dbo].[QUE_InsertCTPTransaction] @Priority, @WONUM, 'HHRECMAP', @TransactionData, @NewKey OUTPUT
				IF @insresult <> 1
					BEGIN
						INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location) VALUES('25',0,'Unable to Insert CTP Transaction:' + CAST(@insresult AS varchar(20)),@Loc)
						SET @Success=0
						SET @RV=-5
					END
			END
		END

	SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
	RETURN @RV



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_ReceiveNotes') AND type in (N'P', N'PC')) DROP PROCEDURE HH_ReceiveNotes;
GO
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: January 11, 2016
-- Description: Receive Work Order Notes from Allegro
-- 		Return 1 on success, negative value on failure
--		Succes is returned even if no notes are provided
--		@Success is set to 1 on success, 0 on failure
--		Any errors encountered are returned as  HH_ErrorDataType
-- Revisions:
--	2016-10-24	Added ID to transaction information
--	2016-12-16 IDM Modified to directly call HH_MapRecData activity without queuing
-- ====================================================================================
CREATE PROC [dbo].[HH_ReceiveNotes]
	@Notes [HH_NoteType] READONLY,
	@Success [bit] OUTPUT
AS
	DECLARE @ErrorData HH_ErrorDataType, @Loc varchar(128)
	SET @Loc='HH_ReceiveNotes'
	DECLARE @RV int
	SET @RV=0

	IF (SELECT COUNT(*) FROM @Notes) < 1
		BEGIN
			SET @Success=1
			SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
			RETURN 1
		END
	DECLARE @WONUM varchar(12), @ID int
	SET @WONUM=(SELECT MAX(WR_ID) FROM @Notes)
	IF @WONUM IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('22',0,'WR_ID is NULL', @Loc)
			SET @Success=0
			SET @RV=-2
		END
	DECLARE @WOID int,@OrderID int,@OrgShortName varchar(20)
	SELECT @WOID=WOID,@OrderID=OrderID,@OrgShortName=OrgShortName FROM [dbo].[vw_TPS_WO] WHERE WONUM=@WONUM
	IF @OrderID IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param, ParamValue) VALUES('23',0,'WONUM not found', @Loc, 'WR_ID', @WONUM)
			SET @Success=0
			SET @RV=-3
		END
	IF (SELECT COUNT(*) FROM @Notes WHERE WR_ID <> @WONUM) > 0
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param) VALUES('29',0,'All Notes must have same WR_ID', @Loc, '@Notes')
			SET @Success=0
			SET @RV=-4
		END

	IF @RV = 0
		BEGIN
			INSERT INTO HH_Note (
				[OrderID],
				[LocalTimestamp],
				[WR_ID],
				[NoteID],
				[NoteText],
				[DateStamp],
				[UpdateBy]
			)
			SELECT 
				@OrderID,
				GetDate(),
				[WR_ID],
				[NoteID],
				[NoteText],
				[DateStamp],
				[UpdateBy]
			FROM @Notes
			IF @@ROWCOUNT > 0
				BEGIN
					SET @Success=1
					SET @RV=1
				END
			ELSE
				BEGIN
					INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location) VALUES('35',0,'Error inserting records',@Loc)
					SET @Success=0
					SET @RV=-5
				END
		END
	IF (@RV = 1)
		BEGIN
			SELECT @ID=MIN(nout.[HH_NoteID]) FROM @Notes nin 
				JOIN [dbo].[HH_Note] nout ON nout.[WR_ID]=nin.[WR_ID] AND nout.[NoteID]=nin.[NoteID] AND
					nout.[NoteText]=nin.[NoteText] AND nout.[DateStamp]=nin.[DateStamp]
			DECLARE @TransactionData varchar(max), @subxml XML, @insresult int,@Priority int, @NewKey int
			DECLARE @MapSuccess bit
			IF (SELECT [dbo].[fnUTP_MessageEnabled]('HHRECMAPDIRECT','HH_ReceiveNotes')) = 1
			BEGIN
				INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param,ParamValue)
					EXEC [dbo].[HH_MapRecNotes] @WONUM,@OrderID,@ID, @MapSuccess OUTPUT
				IF @MapSuccess <> 1
				BEGIN
					SET @RV=-6
					SET @Success=0
				END
			END
			ELSE
			BEGIN
				SET @subxml=(SELECT [TYPE]='NOTES',[WOID]=[WOID],[OrderID]=[OrderID],[WR_ID]=[WONUM],[ID]=@ID FROM [dbo].[vw_TPS_WO] HHRECMAP WHERE [OrderID]=@OrderID FOR XML AUTO)
				SELECT @TransactionData=CAST(@subxml AS varchar(max))
				EXEC @insresult=[dbo].[QUE_InsertCTPTransaction] @Priority, @WONUM, 'HHRECMAP', @TransactionData, @NewKey OUTPUT
				IF @insresult <> 1
					BEGIN
						INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location) VALUES('25',0,'Unable to Insert CTP Transaction:' + CAST(@insresult AS varchar(20)),@Loc)
						SET @Success=0
						SET @RV=-7
					END
			END
		END

	SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
	RETURN @RV




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_ReceiveRaiseComplete') AND type in (N'P', N'PC')) DROP PROCEDURE HH_ReceiveRaiseComplete;
GO
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: January 8, 2016
-- Description: Receive Raise and Complete information from Allegro
-- 		Return 1 on success, negative value on failure
--		@Success set to true on success
--		Any errors encountered are returned as HH_ErrorDataType
-- Revisions:
--	2016-12-16 IDM Modified to directly call HH_MapRecData activity without queuing
--	2017-11-15 IDM Modified to support Failure Reports on (RC) Raises
-- ====================================================================================
CREATE PROC [dbo].[HH_ReceiveRaiseComplete]
	@CoreData [HH_WRCoreDataChildType] READONLY,
	@FA [HH_FieldAttributeType] READONLY,
	@Remarks [HH_RemarkType] READONLY,
	@Success [bit] output
AS
	DECLARE @ErrorData HH_ErrorDataType, @Loc varchar(128)
	SET @Loc='HH_ReceiveRaiseComplete'
	DECLARE @RV int
	SET @RV=0
	IF (SELECT COUNT(*) FROM @CoreData) <> 1
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('21',0,'Only one WRCoreDataChild row may be supplied', @Loc)
			SET @Success=0
			SET @RV=-1
		END
	DECLARE @WONUM varchar(12)
	SET @WONUM=(SELECT PARENT_WR_ID FROM @CoreData)
	IF @WONUM IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('22',0,'PARENT_WR_ID is NULL', @Loc)
			SET @Success=0
			SET @RV=-2
		END
	DECLARE @WOID int,@OrderID int,@OrgShortName varchar(20)
	SELECT @WOID=WOID,@OrderID=OrderID,@OrgShortName=OrgShortName FROM [dbo].[vw_TPS_WO] WHERE WONUM=@WONUM
	IF @OrderID IS NULL
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param, ParamValue) VALUES('23',0,'WONUM not found', @Loc, 'PARENT_WR_ID', @WONUM)
			SET @Success=0
			SET @RV=-3
		END
	IF (SELECT COUNT(*) FROM @FA WHERE PARENT_WR_ID <> @WONUM) <> 0
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param) VALUES('28',0,'FA Found with PARENT_WR_ID not ' + @WONUM, @Loc, '@FA')
			SET @Success=0
			SET @RV=-4
		END

	IF (SELECT COUNT(*) FROM @Remarks WHERE PARENT_WR_ID <> @WONUM) <> 0
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location,Param) VALUES('29',0,'Remark Found with PARENT_WR_ID not ' + @WONUM, @Loc, '@Remarks')
			SET @Success=0
			SET @RV=-5
		END

	IF @RV = 0
		BEGIN
			INSERT INTO HH_RaiseComplete (
				[OrderID],
				[LocalTimestamp],
				[WR_ID],
				[PARENT_WR_ID],
				[COMMENTS],
				[COMPLETION_DATE],
				[COMPLETION_FITTER_ID],
				[DateStamp],
				[JOB_CODE],
				[JOB_TYPE],
				[METER_NUMBER],
				[RESOLUTION_CODE],
				[WR_DESC],
				[JobCodeID],
				[SubType],
				[RaiseType],
				[APEQTYPE],
				[FailureClass],
				[FailureProblem],
				[FailureCause],
				[FailureRemedy]
			)
			SELECT 
				@OrderID,
				GetDate(),
				[WR_ID],
				[PARENT_WR_ID],
				[COMMENTS],
				[COMPLETION_DATE],
				[COMPLETION_FITTER_ID],
				[DateStamp],
				[JOB_CODE],
				[JOB_TYPE],
				[METER_NUMBER],
				[RESOLUTION_CODE],
				[WR_DESC],
				[JobCodeID],
				[SubType],
				[RaiseType],
				[APEQTYPE],
				[FailureClass],
				[FailureProblem],
				[FailureCause],
				[FailureRemedy]
			FROM @CoreData
			IF @@ROWCOUNT <> 1
				BEGIN
					INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('30',0,'Error Inserting HH_RaiseComplete Record', @Loc)
					SET @Success=0
					SET @RV=-6
				END
			DECLARE @RECID int
			SELECT @RECID = COALESCE(SCOPE_IDENTITY(), 0)
			IF @RECID = 0
				BEGIN
					INSERT INTO @ErrorData (Code,ErrorLevel,Message, Location) VALUES('30',0,'Unable to obtain inserted record ID', @Loc)
					SET @Success=0
					SET @RV=-6
				END

	END

	IF @RV = 0
		BEGIN
			DECLARE @FASuccess bit
			INSERT @ErrorData(Code,ErrorLevel,Message,Location,Param,ParamValue) EXEC [dbo].[HH_ReceiveFieldAttributes] @FA, 'R', @OrderID, @RECID, @FASuccess
			IF @FASuccess <> 1
				BEGIN
					SET @Success=0
					;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_ReceiveRemarks') AND type in (N'P', N'PC')) DROP PROCEDURE HH_ReceiveRemarks;
GO
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: January 8, 2016
-- Description: Receive Remarks from Allegro
-- 		Can be part of ReceiveRaiseComplete or ReceiveCompletion activity
-- 		Return 1 on success, negative value on failure
--		No records or NULL @Remarks is success
--		@Success set to true on success
--		Any errors encountered are returned as HH_ErrorDataType
-- Revisions:
-- ====================================================================================
CREATE PROC [dbo].[HH_ReceiveRemarks]
	@Remarks [HH_RemarkType] READONLY,
	@HHRecordType [varchar](1),
	@OrderID [int],
	@ParentRecordID [int] = NULL,
	@Success [bit] OUTPUT
AS
	DECLARE @ErrorData HH_ErrorDataType, @Loc varchar(128)
	SET @Loc='HH_ReceiveRemarks'
	-- If no records or @Remarks is NULL return success
	IF (SELECT COUNT(*) FROM @Remarks) = 0
		BEGIN
			SET @Success=1
			SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
			RETURN 1
		END

	DECLARE @HHRaiseCompleteID int
	DECLARE @HHCompletionID int
	IF @HHRecordType = 'R'
		BEGIN
			SET @HHRaiseCompleteID=@ParentRecordID
			SET @HHCompletionID=NULL
		END
	ELSE IF @HHRecordType = 'C'
		BEGIN
			SET @HHRaiseCompleteID=NULL
			SET @HHCompletionID=@ParentRecordID
		END
	ELSE				
		BEGIN
			INSERT INTO @ErrorData (Code,ErrorLevel,Message,Location,Param,ParamValue) VALUES('25',0,'Invalid @HHRecordType',@Loc,'@HHRecordType',@HHRecordType)
			SET @Success=0
			SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
			RETURN -3
		END

	INSERT INTO [dbo].[HH_Remark] (
		[OrderId],
		[LocalTimestamp],
		[HH_RecordType],
		[HH_RaiseCompleteID],
		[HH_CompletionID],
		[WR_ID],
		[PARENT_WR_ID],
		[TEMP_REMARK_ID],
		[REMARK_CONTENT],
		[REMARK_DATE]
	)
	SELECT 
		@OrderID,
		GetDate(),
		@HHRecordType,
		@HHRaiseCompleteID,
		@HHCompletionID,
		[WR_ID],
		[PARENT_WR_ID],
		[TEMP_REMARK_ID],
		[REMARK_CONTENT],
		[REMARK_DATE]
	FROM @Remarks
	SET @Success=1
	SELECT Code,ErrorLevel,Message,Location,Param,ParamValue FROM @ErrorData
	RETURN 1

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectActionType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectActionType;
GO
-- drop proc [dbo].[HH_SelectActionType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_ActionType for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectActionType]
AS
	SELECT
	[WOID]=CAST(0 AS int),
	[WR_ID]=CAST('' AS varchar(12)),
       	[ApptID]=CAST(0 AS bigint),
	[Action]=CAST('' AS varchar(255)),
	[Fitter_ID]=CAST('' AS varchar(12)),
	[Timestamp]=CAST('2015-01-01' AS DATETIME)





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectAppointmentCompletionType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectAppointmentCompletionType;
GO
-- drop proc [dbo].[HH_SelectAppointmentCompletionType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_AppointmentCompletionType for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectAppointmentCompletionType]
AS
	SELECT
	[WOID]=CAST('' AS [int]),
	[WR_ID]=CAST('' AS [varchar](12)),
	[WOAppointmentID]=CAST('' AS [bigint]),
	[AppointmentTimeFromHHMM]=CAST('' AS [varchar](4)),
	[AppointmentTimeToHHMM]=CAST('' AS [varchar](4)),
	[ArrivalTimeHHMM]=CAST('' AS [varchar](4)),
	[CompletionTimeHHMM]=CAST('' AS [varchar](4)),
	[UpdateDate]=CAST('' AS [DATETIME]),
	[CompletionDate]=CAST('' AS [DATETIME]),
	[AppointmentType]=CAST('' AS [varchar](30)),
	[EarlyNow]=CAST('' AS [bit]),
	[LateWindow]=CAST('' AS [int]),
	[CompletionFitterCode]=CAST('' AS [varchar](30)),
	[GPSCurrentCoordinates]=CAST('' AS [bit]),
	[GPSOverride]=CAST('' AS [bit]),
	[OnSiteGPSTimestamp]=CAST('' AS [DATETIME]),
	[OnSiteLatitude]=CAST('' AS [float]),
	[OnSiteLongitude]=CAST('' AS [float]),
	[PPE]=CAST('' AS [varchar](1)),
	[ESI]=CAST('' AS [varchar](1)),
	[STF]=CAST('' AS [varchar](1)),
	[OEH]=CAST('' AS [varchar](1)),
	[AOH]=CAST('' AS [varchar](1)),
	[HazardNotes]=CAST('' AS [varchar](max))

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectCancelRaiseType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectCancelRaiseType;
GO
-- drop proc [dbo].[HH_SelectCancelRaiseType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_CancelRaiseTyp for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectCancelRaiseType]
AS
	SELECT
	[WOID]=CAST(0 AS [int]),
	[PARENT_WR_ID]=CAST('' AS [varchar](12)),
	[TEMP_WR_ID]=CAST('' AS [varchar](12)),
	[JobCodeID]=CAST('' AS [int]),
	[RaiseType]=CAST('' AS [varchar](2)),
	[Fitter_ID]=CAST('' AS [varchar](12)),
	[COMMENTS]=CAST('' AS [varchar](255))




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectErrorDataType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectErrorDataType;
GO
-- drop proc [dbo].[HH_SelectErrorDataType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Table type of returned errors
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectErrorDataType]
AS
	SELECT
	[Code]=CAST('' AS [varchar](20)),
	[ErrorLevel]=CAST('' as int),
	[Message]=CAST('' AS [varchar](128)),
	[Location]=CAST('' AS [varchar](128)),
	[Param]=CAST('' AS [varchar](64)),
	[ParamValue]=CAST('' AS [varchar](128))





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectFieldAttributeType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectFieldAttributeType;
GO
-- drop proc [dbo].[HH_SelectFieldAttributeType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_FieldAttributeType for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectFieldAttributeType]
AS
	SELECT
	[WOID]=CAST('' AS [int]),
	[WR_ID]=CAST('' AS [varchar](12)),
	[PARENT_WR_ID]=CAST('' AS [varchar](12)),
	[ATTRIBUTE_CODE]=CAST('' AS [varchar](24)),
	[FAName]=CAST('' AS [varchar](255)),
	[FAValue]=CAST('' AS [varchar](254)),
	[VALIDATION_TYPE]=CAST('' AS [varchar](20)),
	[VALIDATION_CODE]=CAST('' AS [varchar](20)),
	[DEFAULT_VALUE]=CAST('' AS [varchar](254)),
	[FA_ID]=CAST('' AS [bigint]),
	[ReadOnly]=CAST('' AS [bit]),
	[DataType]=CAST('' AS [varchar](8)),
	[LENGTH]=CAST('' AS [varchar](10)),
	[Sequence]=CAST('' AS [int]),
	[FieldValidation]=CAST('' AS [varchar](20))





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectHistory') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectHistory;
GO

-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: Dec 14, 2015
-- Description: Return Allegro SubmitNewWork History data by WOID
-- Revisions:
-- ====================================================================================
CREATE PROC [dbo].[HH_SelectHistory]
	@OrderID [int] = NULL
AS
	DECLARE @History UTP_IDListType
	SELECT
	[CompletionCode]='',
	[CrewID]='',
	[CompletionDate]=NULL,
	[JobSegNum]=null,
	[RedTagIndicator]='No',
	[Remark1]='',
	[Remark2]='',
	[Remark3]=null,
	[Remark4]=null,
	[WorkOrderType]='',
	[WONum]=''
	FROM @History


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectImageDataType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectImageDataType;
GO
-- drop proc [dbo].[HH_SelectImageDataType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_ImageDataType for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectImageDataType]
AS
	SELECT
	[WOID]=CAST(0 as [int]),
	[WR_ID]=CAST('' AS [varchar](12)),
	[DocumentID]=CAST(0 AS [bigint]),
	[DocumentData]=CAST('' AS [varbinary](max)),
	[DateStamp]=CAST('2015-01-01' AS [DATETIME]),
	[UploadedBy]=CAST('' AS [varchar](255)),
	[ImgDescription]=CAST('' AS [varchar](254)),
	[UTPDocumentID]=CAST(0 as int)






;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectNoteType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectNoteType;
GO
-- drop proc [dbo].[HH_SelectNoteType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_NoteType for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectNoteType]
AS
	SELECT
	[WOID]=CAST('' AS [int]),
	[WR_ID]=CAST('' AS [varchar](12)),
	[NoteID]=CAST('' AS [int]),
	[NoteText]=CAST('' AS [varchar](255)),
	[DateStamp]=CAST('' AS [DATETIME]),
	[UpdateBy]=CAST('' AS [varchar](255))





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectRemarkType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectRemarkType;
GO
-- drop proc [dbo].[HH_SelectRemarkType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_RemarkType for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectRemarkType]
AS
	SELECT
	[WOID]=CAST('' AS [int]),
	[WR_ID]=CAST('' AS [varchar](12)),
	[PARENT_WR_ID]=CAST('' AS [varchar](12)),
	[TEMP_REMARK_ID]=CAST('' AS [bigint]),
	[REMARK_CONTENT]=CAST('' AS [varchar](max)),
	[REMARK_DATE]=CAST('' AS [DATETIME])


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectWRCoreDataChildType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectWRCoreDataChildType;
GO
-- drop proc [dbo].[HH_SelectWRCoreDataChildType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_WRCoreDataChildType for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectWRCoreDataChildType]
AS
	SELECT
	[WOID]=CAST(0 AS [int]),
	[WR_ID]=CAST('' AS [varchar](12)),
	[COMMENTS]=CAST('' AS [varchar](255)),
	[COMPLETION_DATE]=CAST('2015-01-01' AS [DATETIME]),
	[COMPLETION_FITTER_ID]=CAST('' AS [varchar](12)),
	[DateStamp]=CAST('2015-01-01' AS [DATETIME]),
	[JOB_CODE]=CAST('' AS [varchar](64)),
	[JOB_TYPE]=CAST('' AS [varchar](64)),
	[METER_NUMBER]=CAST('' AS [varchar](254)),
	[PARENT_WR_ID]=CAST('' AS [varchar](12)),
	[RESOLUTION_CODE]=CAST('' AS [varchar](20)),
	[WR_DESC]=CAST('' AS [varchar](255)),
	[JobCodeID]=CAST('' AS [int]),
	[SubType]=CAST('' AS [varchar](64)),
	[RaiseType]=CAST('' AS [varchar](2)),
	[APEQTYPE]=CAST('' AS [varchar](2)),
	[FailureClass]=CAST('' AS [varchar](8)),
	[FailureProblem]=CAST('' AS [varchar](8)),
	[FailureCause]=CAST('' AS [varchar](8)),
	[FailureRemedy]=CAST('' AS [varchar](8))

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_SelectWRCoreDataCompletionType') AND type in (N'P', N'PC')) DROP PROCEDURE HH_SelectWRCoreDataCompletionType;
GO
-- drop proc [dbo].[HH_SelectWRCoreDataCompletionType]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: January 26, 2016
-- Description: Return sample HH_WRCoreDataCompletionType for identifying fields
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[HH_SelectWRCoreDataCompletionType]
AS
	SELECT
	[WOID]=CAST('' AS [int]),
	[WR_ID]=CAST('' AS [varchar](12)),
	[COMPLETION_DATE]=CAST('' AS [DATETIME]),
	[DateStamp]=CAST('' AS [DATETIME]),
	[METER_NUMBER]=CAST('' AS [varchar](254)),
	[METER_STATUS]=CAST('' AS [varchar](254)),
	[RESOLUTION_CODE]=CAST('' AS [varchar](20)),
	[FailureCodeID]=CAST('' AS [int]),
	[FailureClass]=CAST('' AS [varchar](8)),
	[FailureProblem]=CAST('' AS [varchar](8)),
	[FailureCause]=CAST('' AS [varchar](8)),
	[FailureRemedy]=CAST('' AS [varchar](8))





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_Submit31ByOrderID') AND type in (N'P', N'PC')) DROP PROCEDURE HH_Submit31ByOrderID;
GO
CREATE PROC [dbo].[HH_Submit31ByOrderID]
	@Action varchar(20),
	@OrderID int,
	@Priority int = NULL,
	@NewKey int output
AS
	DECLARE @SubmitData varchar(MAX), @WONUM varchar(20), @rv int
	DECLARE @QueueAction varchar(20)
	SET @QueueAction='HHSUBMIT31'

	SELECT @WONUM=[WONUM] FROM vw_TPS_WO where OrderID=@OrderID
	IF @WONUM IS NULL RETURN 0

	EXEC @rv=[dbo].[HH_Submit31ByWONUM] @Action, @WONUM, @Priority, @NewKey OUTPUT

	RETURN @rv


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HH_Submit31ByWONUM') AND type in (N'P', N'PC')) DROP PROCEDURE HH_Submit31ByWONUM;
GO

CREATE PROC [dbo].[HH_Submit31ByWONUM]
	@Action varchar(20),
	@Wonum varchar(20),
	@Priority int = NULL,
	@NewKey int output
AS
	DECLARE @SubmitData varchar(MAX)
	DECLARE @QueueAction varchar(20)
	SET @QueueAction='HHSUBMIT31'

	SET @SubmitData = (SELECT [Action]=@Action, WOID=[WOID], ORDERID=[OrderID], WONUM=[WONUM] FROM vw_TPS_WO HHSUBMIT WHERE WONUM=@Wonum FOR XML AUTO)
	IF @SubmitData IS NULL RETURN 0
	
	EXEC dbo.QUE_InsertCTPTransaction @Priority, @Wonum, @QueueAction, @SubmitData, @NewKey output

	RETURN @NewKey


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'IDM_ReassignTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE IDM_ReassignTechnician;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date: Feb 23, 2017
-- Description:
--     Manually call the reassign technican proc (one at a time)
-- Revisions:
-- ===========================================================
CREATE proc [dbo].[IDM_ReassignTechnician] @WONUM varchar(255), @PremiseNo varchar(255),@Tech varchar(255), @Errors varchar(max)=null output,
	@CurrentUserID int
AS
	SET ANSI_WARNINGS OFF  
	--SET NOCOUNT ON  
	DECLARE @SubmitBy varchar(50)
	IF @CurrentUserID IS NULL OR @CurrentUserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @CurrentUserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@CurrentUserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @CurrentUserID provided',2
	END

	declare @OrderID int = (select top 1 OrderID from vw_UTP_WO (nolock) where WONUM=@WONUM OR PremiseNo=@PremiseNo)
	declare @TechID int = (select UserID from UTP_User where UserName = @Tech)
	declare @Appt [UTP_WOAppointmentType]
	select @Errors = ''
	INSERT INTO @Appt 
        ([TechnicianID]
        ,[AppointmentTypeID]
        ,[OrderID]
        ,[AppointmentStatusID]
        ,[TimeslotID]
        ,[BookedViaID]
        ,[CreatedTimestamp]
        ,[ExpectedDuration]
        ,[PreferredContactModeID]
        ,[ModifiedTimestamp]
        ,[ContactID]
        ,[ApptStartDate]
        ,[CompletionCode]
        ,[ActualStart]
        ,[ActualFinish]
        ,[ApptEndDate]
        ,[ApptStartTime]
        ,[ApptEndTime]
        ,[SpecialInstructions]
        ,[CreatedByID]
        ,[ModifiedByID]
        ,[AccessRestricted]
        ,[MedicalNecessity]
        ,[IsFirmAppt]
		)
    select 
        TechnicianID,
        AppointmentTypeID,
        OrderID,
        AppointmentStatusID,
        TimeslotID,
        BookedViaID,
        CreatedTimestamp,
        ExpectedDuration,
        PreferredContactModeID,
        ModifiedTimestamp,
        ContactID,
        ApptStartDate,
        CompletionCode,
        ActualStart,
        ActualFinish,
        ApptEndDate,
        ApptStartTime,
        ApptEndTime,
        SpecialInstructions,
        CreatedByID,
        ModifiedByID,
        AccessRestricted,
        MedicalNecessity,
        IsFirmAppt
	from UTP_Appointment
		where AppointmentID in (select max(AppointmentID) from UTP_Appointment where OrderID=@OrderID)

	if @OrderID is null select @Errors = @Errors + '  '+ COALESCE(@WONUM,@PremiseNo,'') +' WONUM or PremiseNo not found'+char(10)
	if (select count(*) from @Appt)=0 select @Errors = @Errors + '  '+ + COALESCE(@WONUM,@PremiseNo,'') +' Appointment not found'+char(10)
	if @TechID is null select @Errors = @Errors + '  '+ + COALESCE(@WONUM,@PremiseNo,'') +' TechID not found: '+COALESCE (@Tech,'')+char(10)

	if len(@Errors)>0 
	BEGIN
		print @Errors
		return
	END
	update @Appt set TechnicianID=@TechID
	exec [UTP_ReassignTechnician] @appt,@CurrentUserID
	SET ANSI_WARNINGS OFF

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'IDM_UGDWOfromONHOLDtoWSCH') AND type in (N'P', N'PC')) DROP PROCEDURE IDM_UGDWOfromONHOLDtoWSCH;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date:  2017-05-09
-- Description:
--     For UGD/KU - Only if status is ON HOLD
--     Change WO to WSCH and set SendLetter date
--     Create 2 entries in UTP_OrderHistory
--     Return:
--            0 for success
--           -1 for can't find @WONUM
--           -2 for status not 'ON HOLD'
-- Revisions:
--     May 17/2016 - add new READY appointment
-- ===========================================================
CREATE PROC [dbo].[IDM_UGDWOfromONHOLDtoWSCH]
    @WONUM varchar(20),
    @UserID int = null,
    @SendLetterDate DATE = null,
	@Verbose int = 0
AS
	--SET NOCOUNT ON
	IF @UserID IS NULL SELECT @UserID=[dbo].[fnUTP_CurrentDomainUserID]()
	if @SendLetterDate is null set @SendLetterDate = convert(date,getdate())

	Declare @OrderID int, @WMStatusID int, @AppointmentID int, @SpecID int, @DataAttributeID int
	select @OrderID=OrderID,@WMStatusID = wo.WMStatusID from UTP_WO wo (nolock) where WONUM=@WONUM
	select @AppointmentID= max( AppointmentID) from UTP_Appointment a2 (nolock) where a2.OrderID=@OrderID

	if COALESCE(@OrderID,0) < 1 
	BEGIN
		if @Verbose = 1 print '>>'+ @WONUM + ' not found'
		return -1
	END
	if COALESCE(@WMStatusID,0) <> 102
	BEGIN
		if @Verbose = 1 print '>>'+@WONUM + ' not ONHOLD (Status is '+dbo.fnUTP_SelectListMaster(@WMStatusID)+')'
		return -2
	END
	if COALESCE(@AppointmentID,0) < 1
	BEGIN
		if @Verbose = 1 print '>>'+@WONUM + ' missing Appointment Record'
		return -2
	END
		if @Verbose=1 print 'Setting WSCH: '+@WONUM+ ' Send Letter date '+CONVERT(varchar(10),@SendLetterDate) +' -- ' +CONVERT(varchar(16),getdate(),121)

	-- Update Status

	UPDATE UTP_WO set WMStatusID = dbo.fnUTP_GetListMaster('WMStatus','WSCH') where OrderID=@OrderID
	
	-- Update Send Letter Date

	select @DataAttributeID = DataAttributeID From  UTP_DataAttribute WHERE AttributeName = 'LatestLetterDate' AND Category = 'UTP_WO'
	select @SpecID = SpecID from UTP_Spec where OrderID=@OrderID and DataAttributeID = @DataAttributeID

	if @SpecID is not NULL
	BEGIN
		UPDATE UTP_Spec SET AttributeValue = @SendLetterDate WHERE OrderID = @OrderID AND DataAttributeID = @DataAttributeID
	END ELSE BEGIN
		INSERT UTP_Spec (OrderID, DataAttributeID, AttributeValue, SpecTypeID, IsReadony, AttributeName)
			VALUES (@OrderID, @DataAttributeID, @SendLetterDate, 5807, 1, dbo.fnUTP_GetAttributeName(@DataAttributeID))
	END

	-- Replace Appointment Record

	if (select AppointmentStatusID from UTP_Appointment where AppointmentID=@AppointmentID) = (select ListID from UTP_ListMaster where ListKey='AppointmentStatus' and ListText='Completed')
	BEGIN
		INSERT UTP_Appointment
				([TechnicianID]
				,[AppointmentTypeID]
				,[AppointmentStatusID]
				,[TimeslotID]
				,[ApptStartDate]
				,[ApptEndDate]
				,[ApptStartTime]
				,[ApptEndTime]
				,[BookedViaID]
				,[ExpectedDuration]
				,[PreferredContactModeID]
				,[OrderID]
				,[CreatedTimestamp]
				,[CreatedByID]
				,[ModifiedByID]
				,[ModifiedTimestamp]
				,[MeterLeftStatus]
				,[ActualStart]
				,[ActualFinish]
				,[ContactID])
				
		select 
				[TechnicianID]
				,[AppointmentTypeID]=90314
				,[AppointmentStatusID]=90320 -- READY
				,[TimeslotID]=90306
				,[ApptStartDate]
				,[ApptEndDate]
				,[ApptStartTime]
				,[ApptEndTime]
				,[BookedViaID]
				,[ExpectedDuration]
				,[PreferredContactModeID]
				,[OrderID]
				,[CreatedTimestamp]=getdate()
				,[CreatedByID]=@UserID
				,[ModifiedByID]=null
				,[ModifiedTimestamp]=null
				,[MeterLeftStatus]
				,[ActualStart]
				,[ActualFinish]
				,[ContactID]
				from UTP_Appointment where AppointmentID=@AppointmentID

	END

	-- create Order History entries
	INSERT UTP_OrderHistory (OrderID,MemoTypeID,Memo,CreatedByID) select @OrderID,1001,'Customer letter sent on ' + convert(varchar(10),@SendLetterDate,121),@UserID
	INSERT UTP_Or;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JRP_GeneratePanelColumnScript') AND type in (N'P', N'PC')) DROP PROCEDURE JRP_GeneratePanelColumnScript;
GO

-- exec JRP_GeneratePanelColumnScript '%pnWOList'
create procedure [dbo].[JRP_GeneratePanelColumnScript] 
	@PanelName varchar(50) = '%',
	@ColumnName varchar(50) = '%'
as
	print '-- ' + @PanelName
	declare data cursor for
		select 'select @attr = DataAttributeID from UTP_DataAttribute where AttributeName=''' + ColumnName + ''';'
				+ 'update pc set '
				+ 'DisplayName=' + case when pc.Displayname is null then 'null' else '''' + pc.Displayname + '''' end
				+ ', DataAttributeID=@attr'
				+ ', HelpText=' + case when pc.HelpText is null then 'null' else '''' + pc.HelpText + '''' end
				+ ', IsActive=' + isnull(convert(varchar(6),pc.IsActive),'null')
				+ ', IsReadOnly=' + isnull(convert(varchar(6),pc.IsReadOnly),'null')
				+ ', IsOptional=' + isnull(convert(varchar(6),pc.IsOptional),'null')
				+ ', IsHidden=' + isnull(convert(varchar(6),pc.IsHidden),'null')
				+ ', SortOrder=' + isnull(convert(varchar(6),pc.SortOrder),'null')
				+ ', DataTypeID=' + convert(varchar(6),pc.DataTypeID )
				+ ', Length=' +  isnull(convert(varchar(6),pc.Length),'null')
				+ ', ControlTypeID=' + convert(varchar(6),pc.ControlTypeID)
				+ ', LoVKey=' + case when pc.LoVKey is null then 'null' else '''' + pc.LoVKey + '''' end
				+ ', LoVQueryName=' + case when pc.LoVQueryName is null then 'null' else '''' + pc.LoVQueryName + '''' end
				+ ', LoVQueryValueColumn=' + case when pc.LoVQueryValueColumn is null then 'null' else '''' + pc.LoVQueryValueColumn + '''' end
				+ ', LoVQueryDisplayColumn=' + case when pc.LoVQueryDisplayColumn is null then 'null' else '''' + pc.LoVQueryDisplayColumn + '''' end
				+ ', DefaultValue=' + case when pc.DefaultValue is null then 'null' else '''' + pc.DefaultValue + '''' end
				+ ', Description=' + case when pc.Description is null then 'null' else '''' + pc.Description + '''' end
				+ ', LanguageID=' + convert(varchar(6),pc.LanguageID)
				+ '	from UTP_Panel p left join UTP_PanelColumn pc on p.PanelID = pc.PanelID where PanelName = ''' + PanelName + ''' and ColumnName = ''' + ColumnName + ''''
				+ char(13)+char(10)

			--select * 
			from UTP_Panel p left join UTP_PanelColumn pc on p.PanelID = pc.PanelID 
			where PanelName like @PanelName and ColumnName like @ColumnName
			order by PanelName, SortOrder

		open data

		declare @Line varchar(4000),
				@Script varchar(max) = ''

		fetch next from data into @Line

		while @@FETCH_STATUS = 0
			begin
			set @Script = @Script + isnull(@Line,'')
			print @Line
			fetch next from data into @Line
			end

		close data
		deallocate data

		select @Script

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JRP_GenerateWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE JRP_GenerateWorkSchedule;
GO
-- exec JRP_GenerateWorkSchedule 5, '4/14/2012', 30
CREATE PROC [dbo].[JRP_GenerateWorkSchedule]
	@TechnicianID int,
	@StartDate datetime,
	@Days int
as
	declare @i int  = 0

	set nocount on

	while @i < @Days
		begin
		insert UTP_WorkSchedule (UserID, WorkDate, TimeslotID, Available, Booked) values (@TechnicianID,dateadd(d,@i,@startDate),90301,4,0)
		insert UTP_WorkSchedule (UserID, WorkDate, TimeslotID, Available, Booked) values (@TechnicianID,dateadd(d,@i,@startDate),90302,4,0)
		set @i = @i + 1
		end

	select s.*
		from UTP_WorkSchedule s
			inner join UTP_Technician t on s.UserID = t.TechnicianID
		where s.UserID = @TechnicianID
		order by WorkScheduleID desc




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JRP_HidePanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE JRP_HidePanelColumn;
GO
create proc [dbo].[JRP_HidePanelColumn]
	@PanelName varchar(50),
	@ColumnName varchar(50) = '%'
as 
	
	exec UTP_UpdatePanelColumnFromParms @PanelName=@PanelName, @ColumnName=@ColumnName, @IsHidden=1, @IsOptional=1
	update pc 
		set SortOrder = case when IsHidden = 0 and SortOrder > 1000 then SortOrder - 1000 
							when IsHidden = 1 and SortOrder < 1000 then SortOrder + 1000 
							else SortOrder end 
		from UTP_Panel p inner join UTP_PanelColumn pc on p.PanelID = pc.PanelID 
		where PanelName like @PanelName

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JRP_NewDataAttribute') AND type in (N'P', N'PC')) DROP PROCEDURE JRP_NewDataAttribute;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_DataAttribute from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[JRP_NewDataAttribute]
	@Category [varchar](255),
	@AttributeName [varchar](255),
	@DisplayName [varchar](255),
	@Description [varchar](max) = NULL,
	@DataTypeID [int],
	@Length [int],
	@ValidationRule varchar(max) = NULL,
	@LoVKey [varchar](255) = NULL,

	@DataAttributeIDout [int] = null output
AS
-- if @DisplayName exists for @Category & AttributeName, update 
-- otherwise create new

	set nocount on

	Declare @DataAttributeID int = null

	Select @DataAttributeID = DataAttributeID 
		from UTP_DataAttribute 
		where Category = @Category and AttributeName = @AttributeName and DisplayName = @DisplayName

	if @DataAttributeID is not null
		begin
		print @AttributeName + ' exists'
		update UTP_DataAttribute
			set	Description = @Description,
				DataTypeID = @DataTypeID,
				Length = @Length,
				ValidationRule = @ValidationRule,
				LoVKey = @LoVKey,
				IsActive = 1,
				IsDerived = 0
			where DataAttributeID = @DataAttributeID
		SELECT @DataAttributeIDout = @DataAttributeID
		end
	else
		begin
		print @AttributeName + ' new'
		insert into UTP_DataAttribute
		 (
			[Category],
			[AttributeName],
			[DisplayName],
			[Description],
			[DataTypeID],
			[Length],
			[LoVKey],
			[IsActive],
			IsDerived,
			[ValidationRule]
		)
		VALUES (
			@Category,
			@AttributeName,
			@DisplayName,
			@Description,
			@DataTypeID,
			@Length,
			@LoVKey,
			1,
			0,
			@ValidationRule
		)
		SELECT @DataAttributeIDout= COALESCE(SCOPE_IDENTITY(),0)
		end
	RETURN @DataAttributeIDout

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JRP_NewListMaster') AND type in (N'P', N'PC')) DROP PROCEDURE JRP_NewListMaster;
GO
CREATE proc [dbo].[JRP_NewListMaster]
	@ListID int,
	@ListKey varchar(255),
	@ListValue varchar(255),
	@ListText varchar(255),
	@HelpText varchar(2000) = null

as
begin
	declare @eListID int = null,
			@eListKey varchar(255) = null,
			@eListValue varchar(255) = null,
			@eListText varchar(255) = null,
			@tListText varchar(255) = null,
			@NextListID int

	set nocount on

	select @NextListID = max(ListID) + 1 from UTP_ListMaster
	select	@eListID = ListID, 
			@eListKey = ListKey, 
			@eListValue = ListValue,
			@eListText = ListText
		from UTP_ListMaster 
		where ListKey = @ListKey and ListValue = @ListValue

	set @tListText = case when coalesce(@ListText,@eListText,'') = '' then @ListValue else isnull(@ListText,@eListText) end

	if @ListKey = @eListKey and @ListValue = @eListValue 
		begin 
		update UTP_ListMaster 
			set ListValue = @ListValue,
				ListText = @tListText,
				HelpText = @HelpText,
				IsActive = 1
			where ListID = @eListID
		end
	else if @eListID is null and not exists (Select ListID from UTP_ListMaster where ListID = isnull(@ListID,-1))
		begin
		set @eListID = isnull(@ListID,@NextListID)
		exec UTP_CreateListMaster @eListID, @ListKey, @ListValue, @tListText, @HelpText
		end
	else 
		begin
		exec UTP_CreateListMaster @NextListID, @ListKey, @ListValue, @tListText, @HelpText
		end
end


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JRP_ResetLoVConfig') AND type in (N'P', N'PC')) DROP PROCEDURE JRP_ResetLoVConfig;
GO
create proc [dbo].[JRP_ResetLoVConfig]
	@PanelName varchar(50),
	@ColumnName varchar(50),
	@ControlTypeID int ,
	@LovKey varchar(50),
	@LoVQueryName varchar(50),
	@LoVQueryValueColumn varchar(50), 
	@LoVQueryDisplayColumn varchar(50)
as
	exec UTP_UpdatePanelColumnFromParms @PanelName=@PanelName, @ColumnName=@ColumnName,@ControlTypeID=@ControlTypeID, @LoVKey=@LoVKey, @LoVQueryName=@LoVQueryName, @LoVQueryValueColumn=@LoVQueryValueColumn, @LoVQueryDisplayColumn=@LoVQueryDisplayColumn

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JRP_ShowPanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE JRP_ShowPanelColumn;
GO
create proc [dbo].[JRP_ShowPanelColumn]
	@PanelName varchar(50),
	@ColumnName varchar(50) = '%',
	@SortOrder int = null,
	@DisplayName varchar(50) = null
as 

	update pc 
		set IsHidden = 0,
			SortOrder = isnull(@SortOrder,SortOrder),
			DisplayName = isnull(@DisplayName,DisplayName)
		from UTP_Panel p inner join UTP_PanelColumn pc on p.PanelID = pc.PanelID 
		where PanelName like @PanelName
			and ColumnName like @ColumnName

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUE_InsertCTPTransaction') AND type in (N'P', N'PC')) DROP PROCEDURE QUE_InsertCTPTransaction;
GO
CREATE PROC [dbo].[QUE_InsertCTPTransaction]
	@Priority int = NULL, 
	@Wonum varchar(20), 
	@Action varchar(255), 
	@Transactiondata varchar(MAX), 
	@Newkey int output
AS
	IF @Priority IS NULL
		SELECT @Priority=[dbo].[fnUTP_GetWOSchedPriorityByWONUM](@Wonum)
	
	DECLARE @RV INT
	EXEC @RV=[DEV_GAMIFIELD_QueueDB].[dbo].[CTP_InsertTransaction] @Priority, @Wonum, @Action, @TransactionData, @Newkey OUTPUT
	RETURN(@RV)
;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'QUE_ReexecuteCTPTransaction') AND type in (N'P', N'PC')) DROP PROCEDURE QUE_ReexecuteCTPTransaction;
GO
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: April 4, 2016
-- Description: Re-execute a previously executed CTP Transaction
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[QUE_ReexecuteCTPTransaction]
	@TransactionID int, 
	@Newkey int output
AS
	DECLARE @RV INT
	EXEC @RV=[DEV_GAMIFIELD_QueueDB].[dbo].[CTP_ReexecuteTransaction] @TransactionID, @Newkey OUTPUT
	RETURN(@RV)
;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Schedule_GetGroupList') AND type in (N'P', N'PC')) DROP PROCEDURE Schedule_GetGroupList;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: !3-Apr-2016
-- Description: Select Areas from table UTP_Group
-- exec Schedule_GetGroupList 1502
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[Schedule_GetGroupList]
	@UserID [int] = NULL
AS
	Declare @GroupTypeID int
	select @GroupTypeID = ListID from UTP_ListMaster where ListKey = 'GroupType' and ListValue = 'Area'
	exec UTP_SelectGroup @GroupTypeID = @GroupTypeID




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Schedule_GetOpenAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE Schedule_GetOpenAppointment;
GO
-- 30-May-2017	JP	Rewrite to show Relight appts... can't use vw_UTP_WO
CREATE PROCEDURE [dbo].[Schedule_GetOpenAppointment]
	@GroupID [int] = NULL,
	@TechnicianID [int] = NULL,
	@AppointmentDate [date] = NULL,
	@TimeslotID [int] = NULL,
	@CurrentUserID [int] = NULL
as
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'Schedule_GetOpenAppointment: '
					+ ', @GroupID=' + isnull(cast(@GroupID as varchar(6)),'null')
					+ ', @TechnicianID=' + isnull(cast(@TechnicianID as varchar(6)),'null')
  
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	declare @UserID varchar(50), @Today datetime 

	set @Today = cast(cast(getdate() as date) as datetime)

	select @UserID = t.UserID 
		from  UTP_Technician t 
		where t.TechnicianID = @TechnicianID

	SELECT
		[OrderID] = o.OrderID,
		[OrgID] = org.OrgID,
		[OrgShortName] = Org.ShortName,
		[ProjectNumber] = cast('' as varchar(50)),
		[WOID] = uw.uWOID,
		[WONUM] = cast(uw.WONUM as varchar(15)),
		[JobCodeID] = uw.JobCodeID,
		JobCode = coalesce(xda.JobType,'(Not set)') + ' / ' + coalesce(xda.JobCode,'(Not set)'),
		WorkType = coalesce(xda.JobType,'(Not set)'),
		Subtype = coalesce(xda.JobCode,'(Not set)'),
		JobPlan = cast(NULL as varchar(255)),
		[GroupID] = ug.GroupID,
		[GroupName] = ug.GroupCode,  -- temp, update procs and datasets to include GroupCorde then change back 
		[GroupCode] = ug.GroupCode,
		[GridID] = 0,
		[Grid] = uw.Grid,
		[DisplayAddress] = cast(isnull(addr.StreetNo,'') + ' ' + isnull(addr.Street,'') + ' ' + isnull(addr.StreetType,'')
								+ case when isnull(addr.Sfx,'') <> '' then ' ' + isnull(addr.Sfx,'') else '' end
								+ case when isnull(addr.Misc,'') <> '' then ', ' + isnull(addr.Misc,'') else '' end 
								+ ', ' + isnull(addr.Town,'') + ', ' + isnull(addr.ProvinceCode,'') + ' ' + isnull(addr.PostalCode,'')
							as varchar(400)),
		[StreetNo] = addr.StreetNo,
		[Unit] = cast([Unit] as varchar(30)),
		[Street] = [Street],
		[Town] = [Town],
		[PostalCode] = addr.PostalCode,
		ReportedAt = NULL,
		ReportedBy = NULL,
		DueDate, 
		UtilityComment = uw.WONotes,
		IsFirmAppt = a.IsFirmAppt,
		ApptStartDate = case when s.ListText = 'Cancelled' then null else cast(cast(a.ApptStartDate as varchar(12)) + ' ' + left(a.ApptStartTime,2) + ':' + right(a.ApptStartTime,2) as datetime) end,
		ApptEndDate = case when s.ListText = 'Cancelled' then null else cast(cast(a.ApptEndDate as varchar(12)) + ' ' + left(ApptEndTime,2) + ':' + right(ApptEndTime,2) as datetime) end,
		ApptStartTime = left(a.ApptStartTime,2) + ':' + right(a.ApptStartTime,2),
		ApptEndTime = left(ApptEndTime,2) + ':' + right(ApptEndTime,2),
		[WMStatusID] = uw.WMStatusID, 
		[WMStatus] = us.ListValue,
		[DispatcherID] = cast(0 as int),
		[Dispatcher] = cast(NULL as varchar(50)),
		[TechnicianID] = coalesce(u.UserID,ut.UserID),
		Technician = coalesce(u.Username,ut.Username),
		ActualStart = coalesce(uw.ActualStart,a.ActualStart),
		ActualFinish = coalesce(uw.ActualFinish,a.ActualFinish),
		CompletionCode = uw.CompletionCode,
		OldMeterSize = cast(xda.MeterSizeCode as varchar(50)),
		OldMeterNumber = cast(xda.MeterNo as varchar(50)),
		MeterLocation = cast(MeterLocationCode as varchar(10)),
		ServicePressure = cast('''' as varchar(25)),
		NewMeterSize = cast('''' as varchar(50)),
		NewMeterNumber = cast('''' as varchar(50)),
		MeterLeftStatus = cast(a.MeterLeftStatus as varchar(10)),
		APEQType = cast(NULL as varchar(50)),
		a.AppointmentID, 
		a.AppointmentStatusID,
		AppointmentStatus = s.ListText,
		a.Appoin;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_alterdiagram') AND type in (N'P', N'PC')) DROP PROCEDURE sp_alterdiagram;
GO

	CREATE PROCEDURE dbo.sp_alterdiagram
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_creatediagram') AND type in (N'P', N'PC')) DROP PROCEDURE sp_creatediagram;
GO

	CREATE PROCEDURE dbo.sp_creatediagram
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_dropdiagram') AND type in (N'P', N'PC')) DROP PROCEDURE sp_dropdiagram;
GO

	CREATE PROCEDURE dbo.sp_dropdiagram
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SP_gnScriptInsert') AND type in (N'P', N'PC')) DROP PROCEDURE SP_gnScriptInsert;
GO

--======================================================================
-- Create a script for inserting data into the specified table, based 
-- on the optional condition
--======================================================================
CREATE PROC [dbo].[SP_gnScriptInsert](@table varchar(80), 
							   @condition varchar(80) = '1=1',
							   @IncludeAuto int = 1,
							   @ColumnToExclude varchar(4000)  = NULL) AS
	DECLARE @fields nvarchar(4000), @values nvarchar(4000), 
			@SQL1 nvarchar(4000),@SQL2 nvarchar(4000)

	DECLARE @colorder int, @fieldname nvarchar(128), 
			@type varchar(40)

	SELECT top 100 colorder, syscolumns.name, systypes.name as type
	INTO #fields
	FROM syscolumns
		JOIN sysobjects  ON sysobjects.id      = syscolumns.id
		JOIN systypes    ON systypes.xusertype = syscolumns.xusertype
	WHERE sysobjects.name = @table and systypes.name <> 'text'
		and (@IncludeAuto = 1 OR autoval is null)
		and (@ColumnToExclude is NULL or syscolumns.name<>@ColumnToExclude)
	ORDER BY colorder

	DECLARE fieldscursor CURSOR FOR
	SELECT colorder, name, type
	FROM #fields
	ORDER BY colorder

	OPEN fieldscursor

	FETCH NEXT FROM fieldscursor INTO @colorder, @fieldname, @type

	SET @fields = ''
	SET @values = ''

	WHILE @@FETCH_STATUS = 0
	BEGIN
	  SET @fields = @fields + ',[' + @fieldname + ']'
	  IF @type = 'money'
		-- Special case for "money" type
		SET @values = @values + '+'',''+dbo.FN_gnMVal([' + @fieldname + '])'   
	  ELSE
		SET @values = @values + '+'',''+dbo.FN_gnVal(['  + @fieldname + '])'
	  FETCH NEXT FROM fieldscursor INTO @colorder, @fieldname, @type
	END
	DEALLOCATE fieldscursor
	SET @SQL1 = 'SELECT ''INSERT INTO ' + @table + '(' + 
				SUBSTRING(@fields, 2, 4000) + 
			   ')'
	SET @SQL2 = ' VALUES (''+ ' +
			   SUBSTRING(@values, 6, 4000) + '+'')'' FROM ' + 
			   @table + '(nolock) WHERE ' + @condition
	print '--'+@SQL1+@SQL2
	EXEC  (@SQL1+@SQL2)
	SELECT 'GO'


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SP_gnScriptInsertM') AND type in (N'P', N'PC')) DROP PROCEDURE SP_gnScriptInsertM;
GO

--======================================================================
-- Create a script for inserting data into the specified table, based 
-- on the optional condition
--======================================================================
CREATE PROC [dbo].[SP_gnScriptInsertM](@table varchar(80), 
							   @condition varchar(80) = '1=1',
							   @IncludeAuto int = 1,
							   @IncludeCreatedTimestamp int = 1) AS
	DECLARE @fields nvarchar(4000), @values nvarchar(4000), 
			@SQL1 nvarchar(4000),@SQL2 nvarchar(4000)

	DECLARE @colorder int, @fieldname nvarchar(128), 
			@type varchar(40)

	SELECT top 100 colorder, syscolumns.name, systypes.name as type
	INTO #fields
	FROM syscolumns
		JOIN sysobjects  ON sysobjects.id      = syscolumns.id
		JOIN systypes    ON systypes.xusertype = syscolumns.xusertype
	WHERE sysobjects.name = @table and systypes.name <> 'text'
		and (@IncludeAuto = 1 OR autoval is null)
		and (@IncludeCreatedTimestamp = 1 or syscolumns.name<>'CreatedTimestamp')
	ORDER BY colorder

	DECLARE fieldscursor CURSOR FOR
	SELECT colorder, name, type
	FROM #fields
	ORDER BY colorder

	OPEN fieldscursor

	FETCH NEXT FROM fieldscursor INTO @colorder, @fieldname, @type

	SET @fields = ''
	SET @values = ''

	WHILE @@FETCH_STATUS = 0
	BEGIN
	  SET @fields = @fields + ',[' + @fieldname + ']'
	  IF @type = 'money'
		-- Special case for "money" type
		SET @values = @values + '+'',''+dbo.FN_gnMVal([' + @fieldname + '])'   
	  ELSE
		SET @values = @values + '+'',''+dbo.FN_gnVal(['  + @fieldname + '])'
	  FETCH NEXT FROM fieldscursor INTO @colorder, @fieldname, @type
	END
	DEALLOCATE fieldscursor
	SET @SQL1 = 'SELECT ''INSERT INTO ' + @table + '(' + 
				SUBSTRING(@fields, 2, 4000) + 
			   ')'
	SET @SQL2 = ' VALUES (''+ ' +
			   SUBSTRING(@values, 6, 4000) + '+'')'' FROM ' + 
			   @table + '(nolock) WHERE ' + @condition
	print '--'+@SQL1+@SQL2
	EXEC  (@SQL1+@SQL2)
	SELECT 'GO'


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_helpdiagramdefinition') AND type in (N'P', N'PC')) DROP PROCEDURE sp_helpdiagramdefinition;
GO

	CREATE PROCEDURE dbo.sp_helpdiagramdefinition
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_helpdiagrams') AND type in (N'P', N'PC')) DROP PROCEDURE sp_helpdiagrams;
GO

	CREATE PROCEDURE dbo.sp_helpdiagrams
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_renamediagram') AND type in (N'P', N'PC')) DROP PROCEDURE sp_renamediagram;
GO

	CREATE PROCEDURE dbo.sp_renamediagram
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_upgraddiagrams') AND type in (N'P', N'PC')) DROP PROCEDURE sp_upgraddiagrams;
GO

	CREATE PROCEDURE dbo.sp_upgraddiagrams
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'TraceLog_EnterProcedure') AND type in (N'P', N'PC')) DROP PROCEDURE TraceLog_EnterProcedure;
GO
/***************************************************************  
Description: TraceLog_EnterProcedure  
Revisions:   
***************************************************************/  
CREATE PROCEDURE [dbo].[TraceLog_EnterProcedure]   
 @Source varchar(255),   
 @Version int = 1,  
 @LogLevel int = 1,  
 @Identifier varchar(255) = null,
 @Username varchar(255) = null
AS  
 declare @DB varchar(255),  
   @MSG varchar(max),  
   @TraceLogID int  
 set @DB = DB_NAME()  
 set @MSG = 'Entering procedure: ' + @Source  
 exec @TraceLogID = DEV_GAMIFIELD_LogDB.dbo.TraceLog_Insert   
       @LogLevel = 'CallTrace',   
       @Module = @DB,   
       @Source = 'TraceLog_EnterProcedure',   
       @Message = @Msg,  
       @Version = @Version,  
       @LogLevelN = @LogLevel,  
       @Identifier = @Identifier,
	   @Username = @Username  
  
 RETURN coalesce(@TraceLogID,0)  

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'TraceLog_ExitProcedure') AND type in (N'P', N'PC')) DROP PROCEDURE TraceLog_ExitProcedure;
GO

 /***************************************************************  
Description: TraceLog_ExitProcedure  
Revisions:   
 2016-04-07 DM update identifier upon exit, if provided  
***************************************************************/  
CREATE PROCEDURE [dbo].[TraceLog_ExitProcedure]   
 @Source varchar(255),   
 @TraceLogID int = 0,  
 @LogLevel int = 1,  
 @Identifier varchar(255) = null,
 @Username varchar(255) = null
AS  
 declare @DB varchar(255),  
   @MSG varchar(max)  
 set @DB = DB_NAME()  
 set @MSG = 'Exiting procedure: ' + @Source  
 if @TraceLogID <> 0  
  update DEV_GAMIFIELD_LogDB.dbo.TraceLog  
   set TimestampEnd = getdate(),  
    [Source] = 'Tracelog_ExitProcedure',  
    [Message] = @MSG,  
    [Identifier]=COALESCE(@Identifier,Identifier)  
   where TraceLogID = @TraceLogID  
 else   
  exec DEV_GAMIFIELD_LogDB.dbo.TraceLog_Insert   
    @LogLevel = 'CallTrace',   
    @Module = @DB,   
    @Source = 'TraceLog_ExitProcedure',   
    @Message = @Msg,  
    @LogLevelN = @LogLevel,  
    @Identifier = @Identifier,
	@Username = @Username

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisEmailAlertsService_GetEmailQueue') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisEmailAlertsService_GetEmailQueue;
GO





-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 4, 2018
-- Description:	Retrieves all emails queued
--				in the UTP_EmailQueue table
-- 2018-07-04 JLM > added SendAttempts and
--					NextSendAttemptTimestamp
-- 2018-07-18 JLM > added CreatedTimestamp
-- =============================================
CREATE PROCEDURE [dbo].[UtopisEmailAlertsService_GetEmailQueue]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT EmailQueueID, EmailRecipient, [Subject], Body, FromAddress, FromFriendlyName, OrderID, EmailTypeID, SendAttempts, NextSendAttemptTimestamp, CreatedTimestamp
	FROM [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
	ORDER BY EmailQueueID
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisEmailAlertsService_GetEnrouteEmailsList') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisEmailAlertsService_GetEnrouteEmailsList;
GO















-- =============================================
-- Author:		Jeff Moretti
-- Create date: June 6, 2018
-- Description:	Retrieves a list of WO info
--				for WOs that a fitter is
--				'Enroute' to servicing the
--				appt.  Will then send out
--				email to customer
--	2018-06-19 JM > Added utility to select stmt
-- =============================================
CREATE PROCEDURE [dbo].[UtopisEmailAlertsService_GetEnrouteEmailsList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT awo.OrderID, c.ContactEmail, c.LanguageID, c.ContactName, awo.WONUM, awo.FullAddress, Utility = awo.OrgShortName
	FROM vw_Atlantis_WO awo
	INNER JOIN UTP_Contact c ON c.OrderID = awo.OrderID AND c.ContactTypeID = 1803
	INNER JOIN HH_Action hha ON hha.OrderID = awo.OrderID
	WHERE hha.[Action] = 'Enroute'
	AND DATEADD(minute,2,hha.LocalTimestamp) < GETDATE()
	AND NOT EXISTS (
		SELECT HH_ActionID
		FROM HH_Action hhaSub
		WHERE hhaSub.OrderID = hha.OrderID
		AND hha.[Action] = 'Onsite')
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM UTP_EmailHistory
		 WHERE EmailTypeID = 250004)
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
		 WHERE EmailTypeID = 250004)
	AND awo.AppointmentStatusID = 90321 -- booked apt status
	AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305
	AND (awo.PreferredContactModeID = 90362 OR awo.PreferredContactModeID = 90367) -- either Email or EmailAndText
	ORDER BY hha.[Timestamp]

END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisEmailAlertsService_GetReminderEmailsList') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisEmailAlertsService_GetReminderEmailsList;
GO









-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 5, 2018
-- Description:	Retrieves info from all WOs
--				that have booked apts, that
--				require a reminder email
--				to be sent out (retrieves
--				a list of reminder emails)
-- =============================================
CREATE PROCEDURE [dbo].[UtopisEmailAlertsService_GetReminderEmailsList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT awo.OrderID, c.ContactEmail, c.LanguageID, c.ContactName, awo.WONUM, awo.FullAddress,
		awo.ApptStartDate, awo.TimeslotID, awo.SpecialInstructions, Utility = awo.OrgShortName
	FROM vw_Atlantis_WO awo
	INNER JOIN UTP_Contact c ON c.OrderID = awo.OrderID AND c.ContactTypeID = 1803
	INNER JOIN UTP_Appointment a ON awo.AppointmentID = a.AppointmentID
	WHERE awo.ApptStartDate < DATEADD(hour,48,GETDATE())
	AND GETDATE() < awo.ApptStartDate
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM UTP_EmailHistory
		 WHERE EmailTypeID = 250001)
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
		 WHERE EmailTypeID = 250001)
	AND awo.AppointmentStatusID = 90321 -- booked apt status
	AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305
	AND (awo.PreferredContactModeID = 90362 OR awo.PreferredContactModeID = 90367) -- either Email or EmailAndText
	AND DATEADD(hour,24,a.CreatedTimestamp) < awo.ApptStartDate
	
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisEmailAlertsService_GetSafetyEmailsList') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisEmailAlertsService_GetSafetyEmailsList;
GO










-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 7, 2018
-- Description:	Retrieves info from all WOs
--				that have booked apts, that
--				require a safety email
--				to be sent out (retrieves
--				a list of safety emails)
-- =============================================
CREATE PROCEDURE [dbo].[UtopisEmailAlertsService_GetSafetyEmailsList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT awo.OrderID, c.ContactEmail, c.LanguageID, c.ContactName, awo.WONUM, awo.FullAddress,
		awo.ApptStartDate, awo.TimeslotID, awo.SpecialInstructions, Utility = awo.OrgShortName
	FROM vw_Atlantis_WO awo
	INNER JOIN UTP_Contact c ON c.OrderID = awo.OrderID AND c.ContactTypeID = 1803
	WHERE awo.ApptStartDate < DATEADD(hour,24,GETDATE())
	AND GETDATE() < awo.ApptStartDate
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM UTP_EmailHistory
		 WHERE EmailTypeID = 250002)
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
		 WHERE EmailTypeID = 250002)
	AND awo.AppointmentStatusID = 90321 -- booked apt status
	AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305
	AND (awo.PreferredContactModeID = 90362 OR awo.PreferredContactModeID = 90367) -- either Email or EmailAndText
	
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisEmailAlertsService_QueueEmail') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisEmailAlertsService_QueueEmail;
GO








-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 5, 2018
-- Description:	Queues an email in the
--				UTP_EmailQueue
-- =============================================
CREATE PROCEDURE [dbo].[UtopisEmailAlertsService_QueueEmail]
	@EmailRecipient varchar(200),
	@Subject varchar(max) =  null,
	@Body varchar(max) =  null,
	@FromAddress varchar(200),
	@FromFriendlyName varchar(200) = null,
	@OrderID int = null,
	@EmailTypeID int = null
AS
BEGIN
	INSERT INTO [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
           ([EmailRecipient]
           ,[Subject]
           ,[Body]
		   ,[FromAddress]
		   ,[FromFriendlyName]
		   ,[OrderID]
		   ,[EmailTypeID]
		   ,[CreatedTimestamp])
     VALUES
           (@EmailRecipient
           ,@Subject
           ,@Body
		   ,@FromAddress
		   ,@FromFriendlyName
		   ,@OrderID
		   ,@EmailTypeID
		   ,GETDATE())
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisEmailAlertsService_RemoveFromEmailQueue') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisEmailAlertsService_RemoveFromEmailQueue;
GO


-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 4, 2018
-- Description:	Removes an item from the
--				UTP_EmailQueue corresponding to
--				the EmailQueueID input parameter
-- 2018-07-04 JLM > Inserts SendAttempts now
-- =============================================
CREATE PROCEDURE [dbo].[UtopisEmailAlertsService_RemoveFromEmailQueue]
	@EmailQueueID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- first record history in UTP_EmailHistory table
	INSERT INTO [dbo].[UTP_EmailHistory]
           ([EmailRecipient]
           ,[Subject]
           ,[Body]
           ,[FromAddress]
           ,[FromFriendlyName]
           ,[OrderID]
           ,[EmailTypeID]
           ,[CreatedInQueueTimestamp]
           ,[CreatedInHistoryTimestamp]
		   ,[SendAttempts])
	 SELECT [EmailRecipient],
			[Subject],
			[Body],
            [FromAddress],
            [FromFriendlyName],
            [OrderID],
            [EmailTypeID],
			[CreatedTimestamp],
			GETDATE(),
			[SendAttempts]
	 FROM [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
     WHERE EmailQueueID = @EmailQueueID

	 -- now remove from the UTP_EmailQueue
     DELETE FROM [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
	 WHERE EmailQueueID = @EmailQueueID
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisEmailAlertsService_UpdateEmailQueue') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisEmailAlertsService_UpdateEmailQueue;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: July 4, 2018
-- Description:	Updates an item in the
--				UTP_EmailQueue.  Initially
--				created to update SendAttempts
--				and NextSendAttemptTimestamp
-- =============================================
CREATE PROCEDURE [dbo].[UtopisEmailAlertsService_UpdateEmailQueue]
	@EmailQueueID bigint,
	@SendAttempts int,
	@NextSendAttemptTimestamp datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [DEV_GAMIFIELD_QueueDB].[dbo].[EmailQueue]
	SET SendAttempts = @SendAttempts, NextSendAttemptTimestamp = @NextSendAttemptTimestamp
	WHERE EmailQueueID = @EmailQueueID
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisSmsAlertsService_GetEnrouteSmsList') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisSmsAlertsService_GetEnrouteSmsList;
GO
















-- =============================================
-- Author:		Jeff Moretti
-- Create date: June 6, 2018
-- Description:	Retrieves a list of WO info
--				for WOs that a fitter is
--				'Enroute' to servicing the
--				appt.  Will then send out
--				SMS messages to customer
-- 2018-06-19 JM > Added utility to select stmt
-- =============================================
CREATE PROCEDURE [dbo].[UtopisSmsAlertsService_GetEnrouteSmsList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT awo.OrderID, c.ContactPhone, c.LanguageID, c.ContactName, awo.WONUM, awo.FullAddress, Utility = awo.OrgShortName
	FROM vw_Atlantis_WO awo
	INNER JOIN UTP_Contact c ON c.OrderID = awo.OrderID AND c.ContactTypeID = 1803
	INNER JOIN HH_Action hha ON hha.OrderID = awo.OrderID
	WHERE hha.[Action] = 'Enroute'
	AND DATEADD(minute,2,hha.LocalTimestamp) < GETDATE()
	AND NOT EXISTS (
		SELECT HH_ActionID
		FROM HH_Action hhaSub
		WHERE hhaSub.OrderID = hha.OrderID
		AND hha.[Action] = 'Onsite')
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM UTP_SmsHistory
		 WHERE SmsTypeID = 260003)
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
		 WHERE SmsTypeID = 260003)
	AND awo.AppointmentStatusID = 90321 -- booked apt status
	AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305
	AND (awo.PreferredContactModeID = 90366 OR awo.PreferredContactModeID = 90367) -- either Text or EmailAndText
	ORDER BY hha.[Timestamp]

END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisSmsAlertsService_GetReminderSmsList') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisSmsAlertsService_GetReminderSmsList;
GO












-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 18, 2018
-- Description:	Retrieves info from all WOs
--				that have booked apts, that
--				require a reminder sms
--				to be sent out (retrieves
--				a list of reminder sms msgs)
-- =============================================
CREATE PROCEDURE [dbo].[UtopisSmsAlertsService_GetReminderSmsList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT awo.OrderID, c.ContactPhone, c.LanguageID, c.ContactName, awo.WONUM, awo.FullAddress,
		awo.ApptStartDate, awo.TimeslotID, awo.SpecialInstructions, Utility = awo.OrgShortName
	FROM vw_Atlantis_WO awo
	INNER JOIN UTP_Contact c ON c.OrderID = awo.OrderID AND c.ContactTypeID = 1803
	INNER JOIN UTP_Appointment a ON awo.AppointmentID = a.AppointmentID
	WHERE awo.ApptStartDate < DATEADD(hour,48,GETDATE())
	AND GETDATE() < awo.ApptStartDate
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM UTP_SmsHistory
		 WHERE SmsTypeID = 260001)
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
		 WHERE SmsTypeID = 260001)
	AND awo.AppointmentStatusID = 90321 -- booked apt status
	AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305
	AND (awo.PreferredContactModeID = 90366 OR awo.PreferredContactModeID = 90367) -- either Text or EmailAndText
	AND DATEADD(hour,24,a.CreatedTimestamp) < awo.ApptStartDate
	
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisSmsAlertsService_GetSafetySmsList') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisSmsAlertsService_GetSafetySmsList;
GO












-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 18, 2018
-- Description:	Retrieves info from all WOs
--				that have booked apts, that
--				require a safety sms
--				to be sent out (retrieves
--				a list of safety sms msgs)
-- =============================================
CREATE PROCEDURE [dbo].[UtopisSmsAlertsService_GetSafetySmsList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT awo.OrderID, c.ContactPhone, c.LanguageID, c.ContactName, awo.WONUM, awo.FullAddress,
		awo.ApptStartDate, awo.TimeslotID, awo.SpecialInstructions, Utility = awo.OrgShortName
	FROM vw_Atlantis_WO awo
	INNER JOIN UTP_Contact c ON c.OrderID = awo.OrderID AND c.ContactTypeID = 1803
	WHERE awo.ApptStartDate < DATEADD(hour,24,GETDATE())
	AND GETDATE() < awo.ApptStartDate
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM UTP_SmsHistory
		 WHERE SmsTypeID = 260002)
	AND awo.OrderID NOT IN
		(SELECT OrderID
		 FROM [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
		 WHERE SmsTypeID = 260002)
	AND awo.AppointmentStatusID = 90321 -- booked apt status
	AND awo.TimeslotID >= 90301 AND awo.TimeslotID <= 90305
	AND (awo.PreferredContactModeID = 90366 OR awo.PreferredContactModeID = 90367) -- either Text or EmailAndText
	
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisSmsAlertsService_GetSmsQueue') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisSmsAlertsService_GetSmsQueue;
GO







-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 18, 2018
-- Description:	Retrieves all sms queued
--				in the UTP_SmsQueue table
-- 2018-07-04 JLM > added SendAttempts
-- 2018-07-25 JLM > added CreatedTimestamp
-- =============================================
CREATE PROCEDURE [dbo].[UtopisSmsAlertsService_GetSmsQueue]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT SmsQueueID, DestinationPhoneNumber, Body, OrderID, SmsTypeID, SendAttempts, CreatedTimestamp
	FROM [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
	ORDER BY SmsQueueID
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisSmsAlertsService_QueueSms') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisSmsAlertsService_QueueSms;
GO









-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 18, 2018
-- Description:	Queues an sms in the
--				UTP_SmsQueue
-- =============================================
CREATE PROCEDURE [dbo].[UtopisSmsAlertsService_QueueSms]
	@DestinationPhoneNumber varchar(200),
	@Body varchar(max) =  null,
	@OrderID int = null,
	@SmsTypeID int = null
AS
BEGIN
	INSERT INTO [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
           ([DestinationPhoneNumber]
           ,[Body]
		   ,[OrderID]
		   ,[SmsTypeID]
		   ,[CreatedTimestamp])
     VALUES
           (@DestinationPhoneNumber
           ,@Body
		   ,@OrderID
		   ,@SmsTypeID
		   ,GETDATE())
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisSmsAlertsService_RemoveFromSmsQueue') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisSmsAlertsService_RemoveFromSmsQueue;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: May 18, 2018
-- Description:	Removes an item from the
--				UTP_SmsQueue corresponding to
--				the SmsQueueID input parameter
-- 2018-07-04 JLM > Inserts SendAttempts now
-- =============================================
CREATE PROCEDURE [dbo].[UtopisSmsAlertsService_RemoveFromSmsQueue]
	@SmsQueueID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- first record history in UTP_SmsHistory table
	INSERT INTO [dbo].[UTP_SmsHistory]
           ([DestinationPhoneNumber]
           ,[Body]
           ,[OrderID]
           ,[SmsTypeID]
           ,[CreatedInQueueTimestamp]
           ,[CreatedInHistoryTimestamp]
		   ,[SendAttempts])
	 SELECT [DestinationPhoneNumber],
			[Body],
            [OrderID],
            [SmsTypeID],
			[CreatedTimestamp],
			GETDATE(),
			[SendAttempts]
	 FROM [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
     WHERE SmsQueueID = @SmsQueueID

	 -- now remove from the UTP_EmailQueue
     DELETE FROM [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
	 WHERE SmsQueueID = @SmsQueueID
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UtopisSmsAlertsService_UpdateSmsQueue') AND type in (N'P', N'PC')) DROP PROCEDURE UtopisSmsAlertsService_UpdateSmsQueue;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: July 4, 2018
-- Description:	Updates an item in the
--				UTP_SmsQueue.  Initially
--				created to update SendAttempts
-- =============================================
CREATE PROCEDURE [dbo].[UtopisSmsAlertsService_UpdateSmsQueue]
	@SmsQueueID bigint,
	@SendAttempts int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [DEV_GAMIFIELD_QueueDB].[dbo].[SmsQueue]
	SET SendAttempts = @SendAttempts
	WHERE SmsQueueID = @SmsQueueID
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_AssignTask') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_AssignTask;
GO

CREATE PROC [dbo].[UTP_AssignTask]
	@Task [dbo].[UTP_TaskType] READONLY,
	@CurrentUserID int = null

AS
	DECLARE @ROWS int,	
			@NEWID int ,
			@TmpTask UTP_TaskType

	INSERT @TmpTask SELECT * FROM @Task

	UPDATE @TmpTask set TaskStatusID = 8052 -- Assigned
	EXEC UTP_UpdateXTask @TmpTask, @CurrentUserID, @ROWS output, @NEWID output

	-- trigger an email to assigned

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_AssignTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_AssignTechnician;
GO
-- ===========================================================
-- Description: Appts must be scheduled, retract and re-dispatch to Sabre
-- Revisions:
-- ===========================================================
CREATE procedure [dbo].[UTP_AssignTechnician]
	@Appointment [UTP_WOAppointmentType] READONLY,
	@CurrentUserID int,
	
	@ROWS [int] output
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_AssignTechnician'

	select @i = count(*) from @Appointment
	if @i = 1
		select @Identifier = 'OrderID=' + cast(OrderID as varchar(6)) from @Appointment
	else 
		set @Identifier = 'Multiple' 

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	DECLARE @SubmitBy varchar(50)
	IF @CurrentUserID IS NULL OR @CurrentUserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @CurrentUserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@CurrentUserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @CurrentUserID provided',2
	END
	-- for dispatchable appts (except booked or completed)
	-- send to Sabre, if EGD
	-- set appts to dispatched 
	-- send dispatched to EGD, if EGD

	DECLARE @Action varchar(20), @WONUM varchar(20), @Priority int, @NewKey int, @rv int
	DECLARE @OrderID int, @AppointmentID int, @AppointmentStatusID int, @WOID int, @WOStatusID int, @now datetime
	DECLARE @TechnicianID int, @Technician varchar(50), @OrgShortname varchar(50)
	DECLARE @SysLog UTP_OrderHistoryType, @j int

	declare data cursor for
		SELECT	OrderID = tin.OrderID,
				WONUM = NULL, 
				WOID = NULL,
				AppointmentID = a.AppointmentID,
				AppointmentStatusID = coalesce(a.AppointmentStatusID,90321), -- booked
				TechnicianID = case when tin.TechnicianID = -1 then null else tin.TechnicianID end,
				Technician = case when tin.TechnicianID = -1 then null else t.Username end,
				OrgShortname = org.ShortName
			FROM @Appointment tin
				inner join UTP_Order ord on tin.OrderID = ord.OrderID
				inner join UTP_Org org on org.OrgID = ord.OrgID
				-- left join EGD_WO wo on tin.OrderID = wo.OrderID 
				left join UTP_Appointment a on tin.OrderID = a.OrderID
				left join UTP_User t on tin.TechnicianID = t.UserID
	
	open data
	fetch next from data into @OrderID, @WONUM, @WOID, @AppointmentID, @AppointmentStatusID, @TechnicianID, @Technician, @OrgShortname

	set @i = 0
	while @@fetch_Status = 0
		begin
		set @i = @i + 1

		UPDATE UTP_Appointment
			SET	TechnicianID = @TechnicianID,
				ModifiedByID = @CurrentUserID,
				ModifiedTimestamp = getdate()
			WHERE AppointmentID = @AppointmentID

		insert @SysLog (OrderID, MemoTypeID, Memo, TechnicianID, Operation) 
			select @OrderID, 1004, 'Technician changed to ' + isnull(@Technician,'(None)'), @TechnicianID, 'A'

		fetch next from data into @OrderID, @WONUM, @WOID, @AppointmentID, @AppointmentStatusID, @TechnicianID, @Technician, @OrgShortname
		end

	close data
	deallocate data

	exec UTP_UpdateXOrderHistory @Syslog, @CurrentUserID, @j
		
	SET @ROWS = @i

	EXEC UTP_DispatchWO @Appointment, @CurrentUserID, @ROWS

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_AttachDocumentToOrder') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_AttachDocumentToOrder;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: May 22, 2016
-- Description:  
-- Revisions:
-- ===========================================================
create proc [dbo].[UTP_AttachDocumentToOrder]
	@DocumentID int, 
	@WONUM varchar(15), 
	@OrgID int
as

	declare @OrderID int = null,
			@OrgShortName varchar(50),
			@success int = 0

	select @OrgShortName = ShortName from UTP_Org where OrgID = @OrgID

	select @OrderID=OrderID from UTP_WO where WONUM = @WONUM 

	if @OrderID is not null
		begin
		insert UTP_OrderAttachment (OrderID, DocumentID) values (@OrderID, @DocumentID)
		set @success = 1
		end
	else
		begin
		print 'return WONUM does not exist'
		end

	return @success


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_BookAvailability') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_BookAvailability;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: May 1, 2016
-- Description:
-- exec UTP_BookAvailability 6, '5/1/2016','5/6/2016', 90301, 4, 0, 2, 1
-- Revisions:
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_BookAvailability]
	@GroupID int,
	@FromDate datetime,
	@ToDate datetime,
	@TimeslotID int = null,
	@UserID int = null,
	@UseDefault bit, 
	@Capacity int,
	@CurrentUserID int
as

begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_BookAvailability'
	set @Identifier = 'UserID=' + convert(varchar(6),@UserID)
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	-- update if exists otherwise insert
	-- build [UTP_WorkScheduleType]
	declare @WorkSchedule UTP_WorkScheduleType
	insert @WorkSchedule (WorkScheduleID, UserID, WorkDate, TimeslotID, Available, GroupID, Operation)
		select WorkScheduleID, UserID, WorkDate, TimeslotID, @Capacity, GroupID, 'U'
			from UTP_WorkSchedule
			where GroupID = @GroupID
				and UserID = @UserID
				and WorkDate between @FromDate and @ToDate
				and TimeslotID = @TimeslotID

	declare @WorkDate date
	set @WorkDate = @FromDate

	while @WorkDate <= @ToDate
		begin
		insert @WorkSchedule (WorkScheduleID, UserID, WorkDate, TimeslotID, Available, Booked, GroupID, Operation)
			select null, @UserID, @WorkDate, @TimeslotID, @Capacity, 0, @GroupID, 'A'
				where not exists (
						select WorkScheduleID from @WorkSchedule 
							where GroupID = @GroupID
								and UserID = @UserID
								and WorkDate = @WorkDate
								and TimeslotID = @TimeslotID
							)

		set @WorkDate = dateadd(d,1,@WorkDate)
		end

	select * from @WorkSchedule
	declare @ROWS int, @NewID int
	exec [UTP_UpdateWorkSchedule] @WorkSchedule, @ROWS, @NewID
	select @Rows, @NewID

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_BookAvailabilityList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_BookAvailabilityList;
GO

/****** Object:  StoredProcedure [dbo].[UTP_BookAvailabilityList]    Script Date: 2017-03-02 12:25:39 PM ******/

-- ===========================================================
-- Author: John Peacock
-- Create date: May 1, 2016
-- Description:
-- exec UTP_BookAvailability 6, '5/1/2016','5/6/2016', 90301, 4, 0, 2, 1
-- Revisions:
--		19-Feb-2017	JRP	Replace FromDate/ToDat with Datelist Datelist
-- 4-Mar-2017	JP	LPGS-265 Time-off (vacation, sick, personal appts)
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_BookAvailabilityList]
	@ScheduleTypeID int,
	@GroupID int,
	@DateList [UTP_DateListType] READONLY,
	@TimeslotList [UTP_IDListType] READONLY, 
	@UserList [UTP_IDListType] READONLY,
	@UseDefault bit, 
	@Capacity int,
	@TimeoffReasonID int,
	@CurrentUserID int
as

begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select top 1 @ProcedureName = 'UTP_BookAvailabilityList ScheduleType=' + convert(varchar(6),@ScheduleTypeID)
			+ ', TimeslotID=' + convert(varchar(6),ID) from @TimeslotList
	select @Identifier = 'UserID=' + convert(varchar(6),ID) from @UserList
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	-- update if exists otherwise insert
	-- build [UTP_WorkScheduleType]
	declare @WorkSchedule vw_UTP_WorkScheduleType

	-- operates on existing rows
	insert @WorkSchedule (WorkScheduleID, ScheduleTypeID, UserID, WorkDate, TimeslotID, Capacity, GroupID, TimeoffReasonID, Operation)
		select	WorkScheduleID, @ScheduleTypeID,
				UserID, WorkDate, TimeslotID, @Capacity, GroupID, TimeoffReasonID, case when @Capacity = 0 then 'D' else 'U' end -- Ignore
			from UTP_WorkSchedule ws
				inner join @TimeslotList ts on ws.TimeSlotID = ts.ID
			where GroupID = @GroupID
				and UserID in (Select ID from @UserList)
				and WorkDate in (Select Date from @DateList)

	-- do not add if exists in another ScheduleType with same Date, Timeslot & User, nor if all day (90306)
	insert @WorkSchedule (WorkScheduleID, ScheduleTypeID, UserID, WorkDate, TimeslotID, Capacity, GroupID, TimeoffReasonID, Operation)
		select null, @ScheduleTypeID,
				UserID=u.ID, WorkDate=d.Date, TimeslotID=t.ID, @Capacity, @GroupID, @TimeoffReasonID, 'A'
			from @DateList d cross join @TimeslotList t cross join @UserList u
				left join UTP_WorkSchedule ws on d.Date = ws.WorkDate and (t.ID = ws.TimeSlotID or ws.TimeslotID = 90306 or t.ID = 90306) and u.ID = ws.UserID
					AND ws.GroupID = @GroupID
			where ws.WorkScheduleID is null

	select * from @WorkSchedule
	declare @ROWS int, @NewID int
	exec [UTP_UpdateXWorkSchedule] @WorkSchedule, @ROWS, @NewID
	select @Rows, @NewID

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CancelAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CancelAppointment;
GO
-- DROP PROC [dbo].[UTP_CancelAppointment]
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: March 10, 2017
-- Description: Called when cancelling UTP_Appointments for a UTP WorkOrder 
-- Returns: zero on failure, 1 on success
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_CancelAppointment]
	@OrderID [int],
	@SaveAppointmentID int = NULL
AS
	IF @SaveAppointmentID IS NULL
	BEGIN
		UPDATE [dbo].[UTP_Appointment] SET [AppointmentStatusID]=90322, -- Cancelled
			[ModifiedTimestamp]=GETDATE(),ModifiedByID=[dbo].[fnUTP_CurrentDomainUserID]()
		WHERE [OrderID]=@OrderID AND [AppointmentStatusID] IN (90320,90321,90329) -- READY, BOOKED, RESERVED
	END
	ELSE
	BEGIN
		UPDATE [dbo].[UTP_Appointment] SET [AppointmentStatusID]=90322, -- Cancelled
			[ModifiedTimestamp]=GETDATE(),ModifiedByID=[dbo].[fnUTP_CurrentDomainUserID]()
		WHERE [OrderID]=@OrderID AND [AppointmentStatusID] IN (90320,90321,90329) -- READY, BOOKED, RESERVED
			AND [AppointmentID] <> @SaveAppointmentID
	END
	
	RETURN 1


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CancelWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CancelWO;
GO

-- LPGS-373b - P2 - Need ability to cancel a WO - with no update sent to EGD - CANCEL PART IS DONE


/*
declare @A [UTP_WOAppointmentType], @ROWS int
insert @A (OrderID,WONUM,AppointmentID) values (2233,'2233',2054)
exec [UTP_RetractWO] @A, 1, @ROWS out
*/
-- ===========================================================
-- Description: Appts must be Booked, Scheduled or Dispatched
-- Revisions:
--		11-Oct-2016	JP	When cancelling appt, just set status and modified data
--		12-Oct-2016 IM	Also deal with SCHED status
-- ===========================================================
-- Needs to be modified to work for UTP Work Orders
CREATE procedure [dbo].[UTP_CancelWO]
	@WO vw_UTP_WOType READONLY,
	@CurrentUserID int,
	
	@ROWS [int] output
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int
	SET @ROWS=0
	
	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)

	select @i = count(*) from @WO
	if @i = 1
		select @Identifier = cast(OrderID as varchar(6)) from @WO
	else 
		set @Identifier = 'Multiple'

	select top 1 @ProcedureName = 'UTP_CancelWO'
				+ ' IN ROWS=' + cast(@i as varchar(6))
		from @WO

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	DECLARE @WONUM varchar(20), @rv int, @OrderID int

	declare data cursor for
		SELECT	OrderID = tin.OrderID,
				WONUM =  tin.WONUM
			FROM @WO tin

	open data
	fetch next from data into @OrderID, @WONUM

	set @i = 0
	while @@fetch_Status = 0
		begin
		--set @i = @i + 1

		-- exec @rv = EGD_TerminateWO @WONUM, @CurrentUserID

		fetch next from data into @OrderID, @WONUM
		end
		
	close data
	deallocate data

	SET @ROWS = @i
	SET @ProcedureName = @ProcedureName + ', UPDATED ROWS=' + cast(@i as varchar(6))

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CompleteAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CompleteAppointment;
GO
-- DROP PROC [dbo].[UTP_CompleteAppointment]
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: March 10, 2017
-- Description: Called when Completing a UTP WorkOrder
-- Returns: zero on failure, 1 on success
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_CompleteAppointment]
	@OrderID [int],
	@EarlyNow bit = NULL,
	@MeterStatus varchar(10) = NULL
AS
	DECLARE @AppointmentID int, @AppointmentTypeID int=dbo.fnUTP_GetListMaster('AppointmentType','Project')

	SELECT @AppointmentID=[AppointmentID] FROM [dbo].[UTP_Appointment] WHERE [OrderID]=@OrderID 
		AND [AppointmentStatusID] IN (90321)
		
	IF @AppointmentID IS NULL
	BEGIN
		EXEC @AppointmentID=[dbo].[UTP_NewAppointment] @OrderID, @AppointmentTypeID
		IF @AppointmentID = 0 RETURN 0
	END
	
	DECLARE @ActStart DATETIME, @ActFinish DATETIME, @CompCode varchar(6)
	SELECT @ActStart=[ActualStart],@ActFinish=[ActualFinish],@CompCode=[CompletionCode]
	FROM [dbo].[UTP_WO] WHERE [OrderID]=@OrderID
	
	UPDATE [dbo].[UTP_Appointment] SET [AppointmentStatusID]=90325,ModifiedByID=[dbo].[fnUTP_CurrentDomainUserID](),
		[ModifiedTimestamp]=GETDATE(),[ActualStart]=@ActStart,[ActualFinish]=@ActFinish,[CompletionCode]=@CompCode,
		[MeterLeftStatus]=@MeterStatus,[IsEAOK]=@EarlyNow
	WHERE [AppointmentID]=@AppointmentID
	
	IF @@ROWCOUNT = 1 RETURN 1
	ELSE RETURN 0


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CompleteSurvey') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CompleteSurvey;
GO


-- =============================================
-- Author:		Jeff Moretti
-- Create date: July 31, 2018
-- Description:	Updates OrderHistory about
--				completion of Customer Survey.
--				Called by SurveyWS_CompleteSurvey.
--				Note that this SP is called
--				when a customer completes a
--				survey.
-- =============================================
CREATE PROCEDURE [dbo].[UTP_CompleteSurvey]
	@OrderID int,
	@SurveyResultID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @OrderHistoryIn [dbo].UTP_OrderHistoryType,
			@RowCount int

	INSERT INTO @OrderHistoryIn (OrderID, MemoTypeID, Memo, StatusTimestamp,  Operation)
		VALUES(@OrderID, 1001, 'Survey : Customer has completed survey (SurveyResultID = ' + CONVERT(varchar(10),@SurveyResultID) + ')', GETDATE(), 'A')

		EXEC dbo.UTP_UpdateXOrderHistory
			@OrderHistory = @OrderHistoryIn,
			@CurrentUserID = 3,
			@Rows = @RowCount		
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CompleteWOManual') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CompleteWOManual;
GO

-- ===========================================================
-- Author: Diane MacMartin
-- Create date: Jan 16, 2017
-- Description: Procedure to force manual completion of UGD/KU 
--              work orders
-- Revisions:
--    Feb 14, 2017 dm - allow AppointmentStatus to be passed (COA only)
--                    - return error string rather than printing
--	  Jun 12, 2017 im - Allow lookup by PremiseNo only when 1 WO for Premise
-- ===========================================================
CREATE PROC [dbo].[UTP_CompleteWOManual]
	@WONUM varchar(20), @PremiseNo varchar(20), @CompletionFitter varchar (50), @CompletionDate datetime, @MeterStatus varchar(20), @CompletionCode varchar(20)=NULL,@AppointmentStatus varchar(20)='Completed',
	@Errors varchar(max) output
AS
	select @Errors = ''
	
	if @CompletionCode is NULL select @CompletionCode = '10'
	if @AppointmentStatus is NULL select @AppointmentStatus = 'Completed'

	declare @CompID int = (select ListID from UTP_ListMaster where ListKey='WMStatus' and ListValue='WCOMP')
			,@AppointmentStatusID int = (select ListID from UTP_ListMaster where ListKey='AppointmentStatus' and ListText=@AppointmentStatus)
			,@CurrentUserID int = [dbo].[fnUTP_CurrentDomainUserID]()
	declare @uWOID int, @OrderID int, @AppointmentID int, @WOCount int = 0

	if @AppointmentStatusID is null
	BEGIN
		select @Errors = @Errors + '   WONUM ' + COALESCE(@WONUM,@PremiseNo,'NULL')+ ': Appointment Status ' + @AppointmentStatus + ' not found <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'+char(10)
	END

	if @WONUM is not null select @uWOID = uWOID, @OrderID = OrderID from UTP_WO w (nolock) where w.WONUM=@WONUM
	if @uWOID is null and  @PremiseNo is not null 
	BEGIN
			select @WOCount=COUNT(*) from UTP_WO w (nolock)
				JOIN UTP_DataAttribute da with(nolock) ON da.AttributeName='PremiseNo'
				join UTP_Spec s with(nolock) on s.OrderID = w.OrderID AND s.DataAttributeID=da.DataAttributeID
				where s.AttributeValue = @PremiseNo

			IF (@WOCount = 1)
			BEGIN
				select @WONUM = w.WONUM, @uWOID = w.uWOID, @OrderID = w.OrderID from UTP_WO w (nolock) 
					left join UTP_Spec s (nolock) on s.OrderID = w.OrderID
					where s.AttributeName='PremiseNo' and s.AttributeValue = @PremiseNo
			END
	END
	if @uWOID is null
	BEGIN
		select @Errors = @Errors + '   WONUM or PremiseNo ' + COALESCE(@WONUM,@PremiseNo,'NULL')+ ' not found <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
		RETURN
	END

	select @AppointmentID = max(AppointmentID) from UTP_Appointment (nolock) where OrderID=@OrderID
	if @AppointmentID is null 
	BEGIN
		select @Errors = @Errors + '   AppointmentID not found for WONUM '+@WONUM+'<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
	END

	declare @TechID int = (select UserID from UTP_User where UserName = @CompletionFitter)
	if @TechID is null 
	BEGIN
		select @Errors = @Errors + '   Fitter ' + @CompletionFitter+ ' not found for WONUM '+@WONUM+'<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
	END
	if len(@Errors)>1 RETURN
	if @uWOID is NULL or @AppointmentID is NULL return

	declare @date datetime = getdate()
	
	update UTP_Appointment set
		AppointmentStatusID=@AppointmentStatusID,
		ActualStart=COALESCE(ActualStart,@CompletionDate),
		ActualFinish=COALESCE(ActualFinish,@CompletionDate),
		TechnicianID = @TechID,
		MeterLeftStatus = COALESCE(@MeterStatus,MeterLeftStatus),
		ModifiedTimestamp = @Date,
		ModifiedByID = [dbo].[fnUTP_CurrentDomainUserID](),
		CompletionCode = COALESCE(CompletionCode,@CompletionCode)
	where AppointmentID= @AppointmentID

	update UTP_WO set
		WMStatusID = @CompID,
		ActualStart = @CompletionDate,
		ActualFinish = @CompletionDate,
		CompletionCode = COALESCE(CompletionCode,@CompletionCode)
	where uWOID=@uWOID

	IF (SELECT ToSabre FROM vw_TPS_WO where WONUM=@WONUM) = 1 AND (SELECT [dbo].[fnUTP_MessageEnabled]('HHSUBCANWR31','UTP_CompleteWOManual')) = 1
	BEGIN
		DECLARE @NewKey int
		EXEC dbo.HH_Submit31ByWONUM 'HHSUBCAN;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ConfirmAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ConfirmAppointment;
GO
CREATE procedure [dbo].[UTP_ConfirmAppointment]
	@OrderID int,
	@AppointmentID int, 
	@ApptContactMode varchar(20), -- Email, None
	@EmailAddress varchar(255) = null,
	@ApptSalutation varchar(10) = null,
	@CustomerName varchar(255) = null, 
	@CustomerPhone varchar(255) = null,
	@CustomerAlternatePhone varchar(255) = null,
	@CustomerRequest varchar(255) = null,
	@MedicalNecessity bit = null,
	@AccessRestricted bit = null,
	@UserID int

as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_ConfirmAppointment ' + isnull(cast(@AppointmentID as varchar(6)),'null')
	set @Identifier = cast(@OrderID as varchar(20))
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	-- update contact info
	-- promote reserved appt to booked
	-- cancel existing booked appt and any extra reserved appts
	-- update EGD WO if Org = EGD 
	-- deschedule/schedule to egd/sabre
	-- record in WO history

	DECLARE @Memo UTP_OrderHistoryType, @ROWS int
	-- update contact info
	declare @ContactID int = null

	DECLARE @SubmitBy varchar(50)
	IF @UserID IS NULL OR @UserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @UserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@UserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @UserID provided',2
	END

	IF (SELECT [dbo].[fnUTP_RelightAppt](@OrderID)) <> 0
	BEGIN
		EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
		RETURN 0
	END

	declare @Org varchar(10) = null, @WONUM varchar(20), @ToSabre int = 0, @Status varchar(20), @Priority int, @FitterID int,
		@HasHandheld int = 0, @ToHandheld int = 0
	select @Org = OrgShortName,@ToSabre=ToSabre, @Status=WMStatus, @WONUM=WONUM from vw_TPS_WO where OrderID = @OrderID
	print @Org

	IF (@ToSabre = 1) AND (@Status NOT IN ('WSCH','SCHED','DISP','ACK'))
	BEGIN
		-- Work Orders destined for Sabre must be in WSCH, SCHED, DISP or ACK to proceed further
		EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
		RETURN 0
	END

	SELECT top 1 @ContactID = a.ContactID
		FROM UTP_Appointment a
		WHERE AppointmentID = @AppointmentID 

	IF @ContactID IS NULL
		SELECT TOP 1 @ContactID=ContactID FROM UTP_Contact 
		WHERE OrderID=@OrderID AND ContactTypeID=dbo.fnUTP_GetListMaster('ContactType','CONTACT')
		ORDER BY ContactID DESC

	if @ContactID is not null
		update UTP_Contact
			set ContactName = ISNULL(@CustomerName,[ContactName]),
				ContactEmail = ISNULL(@EmailAddress,[ContactEmail]),
				ContactPhone = ISNULL(@CustomerPhone,[ContactPhone]),
				ContactAlternatePhone = ISNULL(@CustomerAlternatePhone,[ContactAlternatePhone])
			where ContactID = @ContactID
	else
		begin
		insert UTP_Contact (OrderID, ContactTypeID, ContactName, ContactEmail, ContactPhone, ContactAlternatePhone)
			values (@OrderID, 1803, @CustomerName, @EmailAddress, @CustomerPhone, @CustomerAlternatePhone)
		set @ContactID = scope_identity()
		end

	-- promote to Booked
	UPDATE [dbo].[UTP_Appointment]
		SET AppointmentStatusID = 90321, -- booked
			SpecialInstructions = @CustomerRequest,
			AccessRestricted = @AccessRestricted,
			MedicalNecessity = @MedicalNecessity,
			PreferredContactModeID = dbo.fnUTP_GetListMaster('PreferredContactMode',@ApptContactMode),
			ContactID = @ContactID,
			ModifiedById = @UserID,
			ModifiedTimestamp = getdate()
		WHERE AppointmentStatusID in (90329, 90321, 90320) -- reserved, booked, ready
			and AppointmentID = @AppointmentID 

	-- cancel existing booked appt and any;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateAddress;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: May 20, 2016
-- Description: Insert into table UTP_Address from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateAddress]
	@Address [dbo].[UTP_AddressType] READONLY,
	@AddressIDout [int] = null output
AS
	insert into UTP_Address
	 (
		[StreetNo],
		[Sfx],
		[Street],
		[Misc],
		[ProvinceID],
		[PostCode],
		[BuildingTypeID],
		[Town],
		[County],
		[Unit],
		[LotNumber],
		[CountryID]

	)
	SELECT
		COALESCE(StreetNo,'0'),
		Sfx,
		Street,
		Misc,
		COALESCE(ProvinceID,'0'),
		PostCode,
		BuildingTypeID,
		Town,
		County,
		Unit,
		LotNumber,
		CountryID

	FROM @Address
	SELECT @AddressIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @AddressIDout



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateAppointment;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Appointment from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateAppointment]
	@TechnicianID [int],
	@AppointmentTypeID [int],

	@AppointmentIDout [int] = null output
AS
	insert into UTP_Appointment
	 (
		[TechnicianID],
		[AppointmentTypeID]

	)
	VALUES (
		@TechnicianID,
		@AppointmentTypeID

	)
	SELECT @AppointmentIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @AppointmentIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateAvailability') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateAvailability;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Availability from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateAvailability]
	@TechnicianID [int],

	@AvailabilityIDout [int] = null output
AS
	insert into UTP_Availability
	 (
		[TechnicianID]

	)
	VALUES (
		@TechnicianID

	)
	SELECT @AvailabilityIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @AvailabilityIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateCODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateCODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_CODetail from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateCODetail]
	@OrderID [int],

	@CODetailIDout [int] = null output
AS
	insert into UTP_CODetail
	 (
		[OrderID]

	)
	VALUES (
		@OrderID

	)
	SELECT @CODetailIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @CODetailIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateContact') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateContact;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Contact from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateContact]
	@OrderID [int],

	@ContactIDout [int] = null output
AS
	insert into UTP_Contact
	 (
		[OrderID]

	)
	VALUES (
		@OrderID

	)
	SELECT @ContactIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @ContactIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateContract') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateContract;
GO



-- ===========================================================
-- Author: Jeff Moretti
-- Create date: July 11, 2017
-- Description: Used to create new Contracts (in table
--				UTP_Contract
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateContract]
	@UTP_Contract [dbo].[UTP_ContractType] READONLY,
	@ContractIDout [bigint] = null output
AS
	insert into UTP_Contract
	 (
		ContractTypeID,
		ContractNum,
		ContractName,
		ContractDescription,
		CustomerContractNum,
		ContractStartDate,
		ContractEndDate,
		OrgID,
		IsActive
	)
	SELECT
		ContractTypeID,
		ContractNum,
		ContractName,
		ContractDescription,
		CustomerContractNum,
		ContractStartDate,
		ContractEndDate,
		OrgID,
		IsActive

	FROM @UTP_Contract

	SELECT @ContractIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @ContractIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateCustomer') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateCustomer;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Customer from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateCustomer]
	@OrgID [int],

	@CustomerIDout [int] = null output
AS
	insert into UTP_Customer
	 (
		[OrgID]

	)
	VALUES (
		@OrgID

	)
	SELECT @CustomerIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @CustomerIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateDataAttribute') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateDataAttribute;
GO

/*declare @int int
select @int = dbo.fnUTP_GetListMaster('DataType','int')
EXEC [UTP_CreateDataAttribute] 'UTP','AreaID', 'AreaID', 'AreaID',@int,'10'
*/
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_DataAttribute from params
-- Revisions:
--              Apr 20, 2016 DM Don't create attribute if it already exists
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateDataAttribute]
	@Category [varchar](255),
	@AttributeName [varchar](255),
	@DisplayName [varchar](255),
	@Description [varchar](max) = NULL,
	@DataTypeID [int],
	@Length [int],
	@DefaultValue [varchar](255) = NULL,
	@DocText [varchar](max) = NULL,
	@HelpText [varchar](max) = NULL,
	@LoVKey [varchar](255) = NULL,
	@IsActive [bit] = NULL,
	@IsDerived [bit] = NULL,
	@ValidationRule [varchar](max) = NULL,
	@VAddedID [int] = NULL,
	@VRemoved [int] = NULL,

	@DataAttributeIDout [int] = null output
AS

if (select DataAttributeID from UTP_DataAttribute where Category=@Category and AttributeName=@AttributeName) is not null
BEGIN
	--PRINT @Category+','+@AttributeName+' already exists -- not creating'
	RETURN
END

	insert into UTP_DataAttribute
	 (
		[Category],
		[AttributeName],
		[DisplayName],
		[Description],
		[DataTypeID],
		[Length],
		[DefaultValue],
		[DocText],
		[HelpText],
		[LoVKey],
		[IsActive],
		[IsDerived],
		[ValidationRule],
		[VAddedID],
		[VRemoved]

	)
	VALUES (
		@Category,
		@AttributeName,
		@DisplayName,
		@Description,
		@DataTypeID,
		@Length,
		@DefaultValue,
		@DocText,
		@HelpText,
		@LoVKey,
		COALESCE(@IsActive,'1'),
		COALESCE(@IsDerived,'0'),
		@ValidationRule,
		@VAddedID,
		@VRemoved

	)
	SELECT @DataAttributeIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @DataAttributeIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateFADetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateFADetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_FADetail from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateFADetail]
	@OrderID [int],

	@FADetailIDout [int] = null output
AS
	insert into UTP_FADetail
	 (
		[OrderID]

	)
	VALUES (
		@OrderID

	)
	SELECT @FADetailIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @FADetailIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateGroup') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateGroup;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Insert into table UTP_Group from params
-- Revisions:
--              Mar 08, 2016 DM add GroupManagerID
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateGroup]
	@GroupCode [varchar](255) = NULL,
	@GroupName [varchar](255) = NULL,
	@GroupTypeID [int],
	@GroupManagerID [int],
	@IsActive [int] = NULL,

	@GroupIDout [int] = null output
AS
	insert into UTP_Group
	 (
		[GroupCode],
		[GroupName],
		[GroupTypeID],
		[GroupManagerID],
		[IsActive]

	)
	VALUES (
		@GroupCode,
		@GroupName,
		@GroupTypeID,
		@GroupManagerID,
		@IsActive

	)
	SELECT @GroupIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @GroupIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateGroupMember') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateGroupMember;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Insert into table UTP_GroupMember from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateGroupMember]
	@MemberID [int],
	@GroupID [int] = NULL,
	@JobTitleID [int],
	@IsActive [int] = NULL,

	@GroupMemberIDout [int] = null output
AS
	insert into UTP_GroupMember
	 (
		[MemberID],
		[GroupID],
		[JobTitleID],
		[IsActive]

	)
	VALUES (
		@MemberID,
		@GroupID,
		@JobTitleID,
		@IsActive

	)
	SELECT @GroupMemberIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @GroupMemberIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateImportTemplate') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateImportTemplate;
GO








-- =============================================
-- Author:		Jeff Moretti
-- Create date: March 21, 2016
-- Description:	Adds a new template to the
--				UtopisImportTemplate table
-- =============================================
CREATE PROCEDURE [dbo].[UTP_CreateImportTemplate]
	-- Add the parameters for the stored procedure here
	@ImportTemplateName VARCHAR(50),
	@ImportTypeId INT,
	@HasHeaders BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].UTP_ImportTemplate(ImportTemplateName, ImportTypeId, HasHeaders, ImportObjectID, ScopeID, CreatedByID, CreatedTimestamp)
	VALUES (@ImportTemplateName, @ImportTypeId, @HasHeaders, 1, 1, 1, GETDATE())

	SELECT SCOPE_IDENTITY()
END













;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateJobTitle') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateJobTitle;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Insert into table UTP_JobTitle from params
-- Revisions:
--				Mar 10, 2016 DM Use table type instead of individual parameters
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateJobTitle]
	@JobTitle [dbo].[UTP_JobTitleType] READONLY,

	@JobTitleIDout [int] = null output
AS
	insert into UTP_JobTitle
	 (
		[JobTitle],
		[JobDescription],
		[IsActive]

	)
	Select 
		JobTitle,
		JobDescription,
		IsActive
		From @JobTitle

	SELECT @JobTitleIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @JobTitleIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateListMaster') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateListMaster;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_ListMaster from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateListMaster]
	@ListID [int],
	@ListKey [varchar](255),
	@ListValue [varchar](255),
	@ListText [varchar](255) = NULL,
	@HelpText [varchar](2000) = NULL,
	@IsActive [bit] = NULL,
	@IsDefault [bit] = NULL,
	@SortOrder [int] = NULL,
	@LoVKey [int] = NULL,
	@LanguageID [int] = NULL,
	@VAddedID [int] = NULL,
	@VRemoved [int] = NULL,
	@VNotes [varchar](max) = NULL,

	@ListIDout [int] = null output
AS
	insert into UTP_ListMaster
	 (
		[ListID],
		[ListKey],
		[ListValue],
		[ListText],
		[HelpText],
		[IsActive],
		[IsDefault],
		[SortOrder],
		[LoVKey],
		[LanguageID],
		[VAddedID],
		[VRemoved],
		[VNotes]

	)
	VALUES (
		@ListID,
		@ListKey,
		@ListValue,
		@ListText,
		@HelpText,
		COALESCE(@IsActive,'1'),
		COALESCE(@IsDefault,'0'),
		@SortOrder,
		@LoVKey,
		@LanguageID,
		@VAddedID,
		@VRemoved,
		@VNotes

	)
	SELECT @ListIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @ListIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateOrder') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateOrder;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Order from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateOrder]
	@OrgID [int],
	@OrderTypeID [int] = NULL,

	@OrderIDout [int] = null output
AS
	insert into UTP_Order
	 (
		[OrgID],
		[OrderTypeID]

	)
	VALUES (
		@OrgID,
		COALESCE(@OrderTypeID,'0')

	)
	SELECT @OrderIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @OrderIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateOrderAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateOrderAddress;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_OrderAddress from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateOrderAddress]
	@OrderID [int],
	@AddressID [int],
	@AddressTypeID [int],

	@OrderAddressIDout [int] = null output
AS
	insert into UTP_OrderAddress
	 (
		[OrderID],
		[AddressID],
		[AddressTypeID]

	)
	VALUES (
		@OrderID,
		@AddressID,
		@AddressTypeID

	)
	SELECT @OrderAddressIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @OrderAddressIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateOrg') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateOrg;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Org from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateOrg]
	@Name [varchar](255),
	@ShortName [varchar](50),

	@OrgIDout [int] = null output
AS
	insert into UTP_Org
	 (
		[Name],
		[ShortName]

	)
	VALUES (
		@Name,
		@ShortName

	)
	SELECT @OrgIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @OrgIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateOrgAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateOrgAddress;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_OrgAddress from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateOrgAddress]
	@OrgID [int],
	@AddressID [int],
	@AddressTypeID [int],

	@OrgAddressIDout [int] = null output
AS
	insert into UTP_OrgAddress
	 (
		[OrgID],
		[AddressID],
		[AddressTypeID]

	)
	VALUES (
		@OrgID,
		@AddressID,
		@AddressTypeID

	)
	SELECT @OrgAddressIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @OrgAddressIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateOrgPermission') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateOrgPermission;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_OrgPermission from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateOrgPermission]
	@OrgID [int],
	@UserID [int] = NULL,
	@View [bit],
	@Add [bit],
	@Edit [bit],
	@Delete [bit],
	@Duplicate [bit],
	@Submit [bit],

	@OrgPermissionIDout [int] = null output
AS
	insert into UTP_OrgPermission
	 (
		[OrgID],
		[UserID],
		[View],
		[Add],
		[Edit],
		[Delete],
		[Duplicate],
		[Submit]

	)
	VALUES (
		@OrgID,
		@UserID,
		@View,
		@Add,
		@Edit,
		@Delete,
		@Duplicate,
		@Submit

	)
	SELECT @OrgPermissionIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @OrgPermissionIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateOrUpdatePanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateOrUpdatePanelColumn;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Sep 22, 2015
-- Description:
--     Update table UTP_PanelColumn from params
--     Note that NULL params will not replace existing values
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateOrUpdatePanelColumn]
	@PanelName [varchar](255) = NULL,
	@ColumnName [varchar](255) = NULL,
	@DataAttributeID [int] = NULL,
	@DisplayName [varchar](255) = NULL,
	@HelpText [varchar](max) = NULL,
	@IsActive [bit] = NULL,
	@IsReadOnly [bit] = NULL,
	@IsOptional [bit] = NULL,
	@IsHidden [bit] = NULL,
	@SortOrder [int] = NULL,
	@DataTypeID [int] = NULL,
	@Length [int] = NULL,
	@ControlTypeID [int] = NULL,
	@LoVKey [varchar](255) = NULL,
	@LoVQueryName [varchar](255) = NULL,
	@LoVQueryValueColumn [varchar](255) = NULL,
	@LoVQueryDisplayColumn [varchar](255) = NULL,
	@DefaultValue [varchar](255) = NULL,
	@Description [varchar](max) = NULL,
	@LanguageID [int] = NULL,
	@FormatString [varchar](max) = NULL,
	@ColumnWidth [int] = NULL

AS
	DECLARE @PanelID int

	IF EXISTS (SELECT PanelColumnID FROM UTP_PanelColumn pc INNER JOIN UTP_Panel p on pc.PanelID = p.PanelID 
					WHERE pc.ColumnName like @ColumnName AND p.PanelName like @PanelName)
 
		UPDATE UTP_PanelColumn
		SET 
			[DataAttributeID] = COALESCE(@DataAttributeID,[DataAttributeID]),
			[DisplayName] = case when @DisplayName = 'NULL' then null else COALESCE(@DisplayName,[DisplayName]) end,
			[HelpText] = case when @HelpText = 'NULL' then null else COALESCE(@HelpText,[HelpText]) end,
			[IsActive] = COALESCE(@IsActive,pc.[IsActive],1),
			[IsReadOnly] = COALESCE(@IsReadOnly,[IsReadOnly],0),
			[IsOptional] = COALESCE(@IsOptional,[IsOptional],1),
			[IsHidden] = COALESCE(@IsHidden,[IsHidden],0),
			[SortOrder] = COALESCE(@SortOrder,[SortOrder]),
			[DataTypeID] = COALESCE(@DataTypeID,[DataTypeID]),
			[Length] = COALESCE(@Length,[Length]),
			[ControlTypeID] = COALESCE(@ControlTypeID,[ControlTypeID]),
			[LoVKey] = case when @LoVKey = 'NULL' then null else COALESCE(@LoVKey,[LoVKey]) end,
			[LoVQueryName] = case when @LoVQueryName = 'NULL' then null else COALESCE(@LoVQueryName,[LoVQueryName]) end,
			[LoVQueryValueColumn] = case when @LoVQueryValueColumn = 'NULL' then null else COALESCE(@LoVQueryValueColumn,[LoVQueryValueColumn]) end,
			[LoVQueryDisplayColumn] = case when @LoVQueryDisplayColumn = 'NULL' then null else COALESCE(@LoVQueryDisplayColumn,[LoVQueryDisplayColumn]) end,
			[DefaultValue] = case when @DefaultValue = 'NULL' then null else COALESCE(@DefaultValue,[DefaultValue]) end,
			[Description] = case when @Description = 'NULL' then null else COALESCE(@Description,[Description]) end,
			[LanguageID] = COALESCE(@LanguageID,[LanguageID]),
			[FormatString] = isnull(@FormatString,[FormatString]),
			[ColumnWidth] = isnull(@ColumnWidth,[ColumnWidth])

		FROM UTP_PanelColumn pc INNER JOIN UTP_Panel p on pc.PanelID = p.PanelID
		WHERE pc.ColumnName like COALESCE(@ColumnName,ColumnName)
			AND p.PanelName like COALESCE(@PanelName,PanelName)
	ELSE
		BEGIN
		SELECT @PanelID = PanelID from UTP_Panel where PanelName = @PanelName

		IF @PanelID IS NULL
			BEGIN
			INSERT UTP_Panel (PanelName, PanelTypeID, IsActive) SELECT @PanelName, 70600, 1
			SET @PanelID = SCOPE_IDENTITY()
			END

		INSERT INTO [dbo].[UTP_PanelColumn]
           ([PanelID]
           ,[ColumnName]
           ,[DataAttributeID]
           ,[DisplayName]
           ,[HelpText]
           ,[IsActive]
           ,[IsReadOnly]
           ,[IsOptional]
           ,[IsHidden]
           ,[SortOrder]
           ,[DataTypeID]
           ,[Length]
           ,[ControlTypeID]
           ,[LoVKey]
           ,[LoVQueryName]
           ,[LoVQueryValueColumn]
           ,[LoVQueryDisplayColumn]
           ,[DefaultValue]
           ,[Description]
           ,[Langu;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePanel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePanel;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Panel from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePanel]
	@PanelName [varchar](255),
	@PanelTypeID [int],
	@ParentPanelID [int] = NULL,

	@PanelIDout [int] = null output
AS
	insert into UTP_Panel
	 (
		[PanelName],
		[PanelTypeID],
		[ParentPanelID]

	)
	VALUES (
		@PanelName,
		@PanelTypeID,
		@ParentPanelID

	)
	SELECT @PanelIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PanelIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePanelColumn;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_PanelColumn from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePanelColumn]
	@PanelID [int],
	@ColumnName [varchar](255),
	@DataAttributeID [int],
	@DisplayName [varchar](255) = NULL,
	@HelpText [varchar](max) = NULL,
	@IsActive [bit] = NULL,
	@IsReadOnly [bit] = NULL,
	@IsOptional [bit] = NULL,
	@IsHidden [bit] = NULL,
	@SortOrder [int] = NULL,
	@DataTypeID [int],
	@Length [int] = NULL,
	@ControlTypeID [int],
	@LoVKey [varchar](255) = NULL,
	@LoVQueryName [varchar](255) = NULL,
	@LoVQueryValueColumn [varchar](255) = NULL,
	@LoVQueryDisplayColumn [varchar](255) = NULL,
	@DefaultValue [varchar](255) = NULL,
	@Description [varchar](max) = NULL,
	@LanguageID [int],

	@PanelColumnIDout [int] = null output
AS
	insert into UTP_PanelColumn
	 (
		[PanelID],
		[ColumnName],
		[DataAttributeID],
		[DisplayName],
		[HelpText],
		[IsActive],
		[IsReadOnly],
		[IsOptional],
		[IsHidden],
		[SortOrder],
		[DataTypeID],
		[Length],
		[ControlTypeID],
		[LoVKey],
		[LoVQueryName],
		[LoVQueryValueColumn],
		[LoVQueryDisplayColumn],
		[DefaultValue],
		[Description],
		[LanguageID]

	)
	VALUES (
		@PanelID,
		@ColumnName,
		@DataAttributeID,
		@DisplayName,
		@HelpText,
		@IsActive,
		@IsReadOnly,
		@IsOptional,
		COALESCE(@IsHidden,'0'),
		@SortOrder,
		@DataTypeID,
		@Length,
		@ControlTypeID,
		@LoVKey,
		@LoVQueryName,
		@LoVQueryValueColumn,
		@LoVQueryDisplayColumn,
		@DefaultValue,
		@Description,
		@LanguageID

	)
	SELECT @PanelColumnIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PanelColumnIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePanelCommand') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePanelCommand;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: May 20, 2016
-- Description: Insert into table UTP_PanelCommand from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePanelCommand]
	@PanelCommand [dbo].[UTP_PanelCommandType] READONLY,
	@PanelCommandIDout [int] = null output
AS
	insert into UTP_PanelCommand
	 (
		[PanelID],
		[ProcedureCalled],
		[ModuleID],
		[Comments],
		[Description]

	)
	SELECT
		PanelID,
		ProcedureCalled,
		ModuleID,
		Comments,
		Description

	FROM @PanelCommand
	SELECT @PanelCommandIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PanelCommandIDout



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePanelPermission') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePanelPermission;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_PanelPermission from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePanelPermission]
	@PanelID [int],
	@UserID [int] = NULL,
	@View [bit],
	@Add [bit],
	@Edit [bit],
	@Delete [bit],
	@Duplicate [bit],
	@Submit [bit],

	@PanelPermissionIDout [int] = null output
AS
	insert into UTP_PanelPermission
	 (
		[PanelID],
		[UserID],
		[View],
		[Add],
		[Edit],
		[Delete],
		[Duplicate],
		[Submit]

	)
	VALUES (
		@PanelID,
		@UserID,
		@View,
		@Add,
		@Edit,
		@Delete,
		@Duplicate,
		@Submit

	)
	SELECT @PanelPermissionIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PanelPermissionIDout

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePerson') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePerson;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Person from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePerson]
	@PersonTypeID [int],
	@FirstName [varchar](255),
	@LastName [varchar](255),
	@Description [varchar](50) = NULL,
	@PhoneEmailID [int] = NULL,
	@BusinessName [varchar](40) = NULL,

	@PersonIDout [int] = null output
AS
	insert into UTP_Person
	 (
		[PersonTypeID],
		[FirstName],
		[LastName],
		[Description],
		[PhoneEmailID],
		[BusinessName]

	)
	VALUES (
		@PersonTypeID,
		@FirstName,
		@LastName,
		COALESCE(@Description,''''),
		@PhoneEmailID,
		@BusinessName

	)
	SELECT @PersonIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PersonIDout


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePersonAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePersonAddress;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_PersonAddress from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePersonAddress]
	@PersonID [int],
	@AddressID [int],
	@AddressTypeID [int],

	@PersonAddressIDout [int] = null output
AS
	insert into UTP_PersonAddress
	 (
		[PersonID],
		[AddressID],
		[AddressTypeID]

	)
	VALUES (
		@PersonID,
		@AddressID,
		@AddressTypeID

	)
	SELECT @PersonAddressIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PersonAddressIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePersonnel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePersonnel;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Personnel from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePersonnel]
	@PersonID [int],
	@OrgID [int],

	@PersonnelIDout [int] = null output
AS
	insert into UTP_Personnel
	 (
		[PersonID],
		[OrgID]

	)
	VALUES (
		@PersonID,
		@OrgID

	)
	SELECT @PersonnelIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PersonnelIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePhoneEmail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePhoneEmail;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_PhoneEmail from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePhoneEmail]
	@CellPhone [varchar](20) = NULL,
	@Pager [varchar](20) = NULL,
	@HomePhone [varchar](20) = NULL,
	@OfficePhone [varchar](20) = NULL,
	@Email [varchar](50) = NULL,

	@PhoneEmailIDout [int] = null output
AS
	insert into UTP_PhoneEmail
	 (
		[CellPhone],
		[Pager],
		[HomePhone],
		[OfficePhone],
		[Email]

	)
	VALUES (
		@CellPhone,
		@Pager,
		@HomePhone,
		@OfficePhone,
		COALESCE(@Email,'*')

	)
	SELECT @PhoneEmailIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PhoneEmailIDout

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreatePODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreatePODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_PODetail from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreatePODetail]
	@OrderID [int],

	@PODetailIDout [int] = null output
AS
	insert into UTP_PODetail
	 (
		[OrderID]

	)
	VALUES (
		@OrderID

	)
	SELECT @PODetailIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @PODetailIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateProvider') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateProvider;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Provider from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateProvider]
	@OrgID [int],

	@ProviderIDout [int] = null output
AS
	insert into UTP_Provider
	 (
		[OrgID]

	)
	VALUES (
		@OrgID

	)
	SELECT @ProviderIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @ProviderIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateTask') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateTask;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Insert into table UTP_Task from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateTask]
	@TaskTypeID [int] = NULL,
	@TaskCode [varchar](255) = NULL,
	@TaskDescription [varchar](max) = NULL,
	@TaskStatusID [int] = NULL,
	@TaskPriorityID [int] = NULL,
	@TaskDueDate [datetime] = NULL,
	@TaskCreatedTimestap [datetime] = NULL,
	@TaskCreatedByUserID [int] = NULL,
	@TaskOwnerID [int] = NULL,
	@TaskCategory [varchar](50) = NULL,
	@TaskScope [varchar](50) = NULL,
	@IsActive [int] = NULL,

	@TaskIDout [int] = null output
AS
	insert into UTP_Task
	 (
		[TaskTypeID],
		[TaskCode],
		[TaskDescription],
		[TaskStatusID],
		[TaskPriorityID],
		[TaskDueDate],
		[TaskCreatedTimestap],
		[TaskCreatedByUserID],
		[TaskOwnerID],
		[TaskCategory],
		[TaskScope],
		[IsActive]

	)
	VALUES (
		@TaskTypeID,
		@TaskCode,
		@TaskDescription,
		@TaskStatusID,
		@TaskPriorityID,
		@TaskDueDate,
		@TaskCreatedTimestap,
		@TaskCreatedByUserID,
		@TaskOwnerID,
		@TaskCategory,
		@TaskScope,
		@IsActive

	)
	SELECT @TaskIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @TaskIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateTaskHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateTaskHistory;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Insert into table UTP_TaskHistory from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateTaskHistory]
	@TaskID [int] = NULL,
	@TaskUpdatedTimestamp [datetime] = NULL,
	@TaskUpdatedByID [int] = NULL,
	@TaskNote [varchar](max) = NULL,
	@TaskActionID [int] = NULL,
	@TaskCompletedByID [int] = NULL,
	@ActiveDatetimeFrom [datetime] = NULL,
	@ActiveDatetimeTo [datetime] = NULL,
	@TaskDuration [real] = NULL,

	@TaskHistoryIDout [int] = null output
AS
	insert into UTP_TaskHistory
	 (
		[TaskID],
		[TaskUpdatedTimestamp],
		[TaskUpdatedByID],
		[TaskNote],
		[TaskActionID],
		[TaskCompletedByID],
		[ActiveDatetimeFrom],
		[ActiveDatetimeTo],
		[TaskDuration]

	)
	VALUES (
		@TaskID,
		@TaskUpdatedTimestamp,
		@TaskUpdatedByID,
		@TaskNote,
		@TaskActionID,
		@TaskCompletedByID,
		@ActiveDatetimeFrom,
		@ActiveDatetimeTo,
		@TaskDuration

	)
	SELECT @TaskHistoryIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @TaskHistoryIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateTechnician;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_Technician from params
-- Revisions:
--		10-Apr-2016	JP	Implement TechnicianID DCR
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateTechnician]
	@UserID [int],
	@TechnicianTypeID [int],
	@GSTNo [varchar](20) = NULL,
	@PerformanceFactor [int] = NULL,
	@Comments [varchar](50) = NULL,
	@InsuranceNum [varchar](50) = NULL,
	@InsuranceExpDate [datetime] = NULL,
	@LicenceNum [varchar](50) = NULL,
	@LicenceExpDate [datetime] = NULL,
	@HasHandHeld [int] = NULL,

	@TechnicianIDout [int] = null output
AS
	insert into UTP_Technician
	 (
		[UserID],
		[TechnicianTypeID],
		[GSTNo],
		[PerformanceFactor],
		[Comments],
		[InsuranceNum],
		[InsuranceExpDate],
		[LicenceNum],
		[LicenceExpDate],
		[HasHandHeld]

	)
	VALUES (
		@UserID,
		@TechnicianTypeID,
		@GSTNo,
		COALESCE(@PerformanceFactor,'0'),
		@Comments,
		@InsuranceNum,
		@InsuranceExpDate,
		@LicenceNum,
		@LicenceExpDate,
		COALESCE(@HasHandHeld,'0')

	)
	SELECT @TechnicianIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @TechnicianIDout


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateUser') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateUser;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_User from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateUser]
	@PersonID [int],
	@UserTypeID [int],
	@UserName [varchar](50),
	@Password [varchar](50),

	@UserIDout [int] = null output
AS
	insert into UTP_User
	 (
		[PersonID],
		[UserTypeID],
		[UserName],
		[Password]

	)
	VALUES (
		@PersonID,
		@UserTypeID,
		@UserName,
		@Password

	)
	SELECT @UserIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @UserIDout


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Createvw_WorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Createvw_WorkSchedule;
GO


-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Insert into table vw_UTP_WorkSchedule from params
-- Revisions:
-- 4-Mar-2017	JP	LPGS-265 Time-off (vacation, sick, personal appts)
-- ===========================================================
CREATE PROC [dbo].[UTP_Createvw_WorkSchedule]
	@vw_UTP_WorkSchedule [dbo].[vw_UTP_WorkScheduleType] READONLY,
	@WorkScheduleIDout [int] = null output
AS
	insert into UTP_WorkSchedule
	 (
		[ScheduleTypeID],
		[GroupID],
		[UserID],
		[WorkDate],
		[TimeSlotID],
		[Capacity],
		[TimeOffReasonID]

	)
	SELECT
		ScheduleTypeID,
		GroupID,
		UserID,
		WorkDate,
		TimeSlotID,
		Capacity,
		TimeOffReasonID

	FROM @vw_UTP_WorkSchedule
	SELECT @WorkScheduleIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @WorkScheduleIDout



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateWODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateWODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Insert into table UTP_WODetail from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateWODetail]
	@OrderID [int],

	@WODetailIDout [int] = null output
AS
	insert into UTP_WODetail
	 (
		[OrderID]

	)
	VALUES (
		@OrderID

	)
	SELECT @WODetailIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @WODetailIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateWorkSchedule;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Insert into table UTP_WorkSchedule from params
-- Revisions:
--              Mar 08, 2016 DM add GroupID
--				Mar 10, 2016 DM Use table type instead of individual parameters
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateWorkSchedule]
	@WorkSchedule [dbo].[UTP_WorkScheduleType] READONLY,
	@WorkScheduleIDout [int] = null output
AS
	insert into UTP_WorkSchedule
	 (
		[UserID],
		[WorkDate],
		[TimeSlotID],
		[Available],
		[Booked],
		[GroupID]

	)
	SELECT 
		UserID,
		WorkDate,
		TimeSlotID,
		Available,
		Booked,
		GroupID

	FROM @WorkSchedule
	SELECT @WorkScheduleIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @WorkScheduleIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_CreateWOStructure') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_CreateWOStructure;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Insert into table UTP_WOStructure from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_CreateWOStructure]
	@PrimaryOrderID [int],
	@RelatedOrderID [int],
	@RelationTypeID [int],

	@WOStructureIDout [int] = null output
AS
	insert into UTP_WOStructure
	 (
		[PrimaryOrderID],
		[RelatedOrderID],
		[RelationTypeID]

	)
	VALUES (
		@PrimaryOrderID,
		@RelatedOrderID,
		@RelationTypeID

	)
	SELECT @WOStructureIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @WOStructureIDout




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_DeleteCustomerByOrgID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_DeleteCustomerByOrgID;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 25, 2015
-- Description: Delete row from Customer table
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_DeleteCustomerByOrgID]
	@OrgId int
AS
	DELETE FROM [dbo].[UTP_Customer] where OrgID = @OrgId




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_DeleteImportMap') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_DeleteImportMap;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: March 21, 2016
-- Description:	Clears all mappings for a given
--				template (essentially deletes
--				the template, but not from
--				the UtopisImportTemplate table)
-- =============================================
CREATE PROCEDURE [dbo].[UTP_DeleteImportMap]
	-- Add the parameters for the stored procedure here
	@ImportTemplateID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM UTP_ImportMap
	WHERE ImportTemplateID = @ImportTemplateID
END






;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_DeleteOrderAttachment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_DeleteOrderAttachment;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: May 22, 2016
-- Description: 
-- Revisions:
--	30-Jan-2017	JRP	Unlink JobCard from WO, set status to Unprocessed
-- ===========================================================
CREATE PROC [dbo].[UTP_DeleteOrderAttachment]
	@OrderID int,
	@DocumentID int,
	@CurrentUserID int
as
	delete UTP_OrderAttachment where OrderID = @OrderID and DocumentID = @DocumentID
	update UTP_OrderJobCard 
		set OrderID = null, WONUM = null, DataEntryStatusID = 2005 -- Unprocessed
		where DocumentID = @DocumentID and OrderID = @OrderID


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_DeletePanel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_DeletePanel;
GO

CREATE PROCEDURE [dbo].[UTP_DeletePanel]
	@PanelName varchar(50),
	@CurrentUserID int = null
as
	DELETE UTP_PanelCommand where PanelID in (select PanelID from UTP_Panel where PanelName = @PanelName)
	DELETE UTP_PanelPermission where PanelID in (select PanelID from UTP_Panel where PanelName = @PanelName)
	DELETE UTP_PanelColumn where PanelID in (select PanelID from UTP_Panel where PanelName = @PanelName)
	DELETE UTP_Panel where PanelName = @PanelName

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_DispatchRelightAppt') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_DispatchRelightAppt;
GO
-- ===========================================================
-- Description: Appts must be Booked, Scheduled or Dispatched
-- Revisions:
-- ===========================================================
CREATE procedure [dbo].[UTP_DispatchRelightAppt]
	@Appointment [UTP_WOAppointmentType] READONLY,
	@CurrentUserID int,
	
	@ROWS [int] output
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)

	select @i = count(*) from @Appointment
	if @i = 1
		select @Identifier = cast(OrderID as varchar(6)) from @Appointment
	else 
		set @Identifier = 'Multiple'

	select top 1 @ProcedureName = 'UTP_DispatchRelightAppt'
				+ ' IN ROWS=' + cast(@i as varchar(6))
				+ ' AppointmentID=' + isnull(cast(AppointmentID as varchar(6)),'null')
		from @Appointment

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on
	-- Ensure valid user
	DECLARE @SubmitBy varchar(50)
	IF @CurrentUserID IS NULL OR @CurrentUserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @CurrentUserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@CurrentUserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @CurrentUserID provided',2
	END

	-- pull back from Sabre

	-- for dispatchable appts (except booked or completed)
	-- create appt if it doesn't exists (ApptID = null) and cancel open appts
	-- send to Sabre, if EGD
	-- set appts to dispatched 
	-- send dispatched to EGD, if EGD

	DECLARE @Action varchar(20), @WONUM varchar(20), @Priority int, @NewKey int, @rv int, @Status varchar(20)
	DECLARE @OrderID int, @AppointmentID int, @AppointmentStatusID int, @WOID int, @WOStatusID int, @now datetime
	DECLARE @Memo UTP_OrderHistoryType, @SubmitSuccess bit, @FitterID int, @OrgShortName varchar(20)
	DECLARE @ToSabre int = 0, @HasHandheld int = 0, @ToHandheld int = 0

	-- cancel exisitng if different or any non-Relight active appointments
	UPDATE a
		SET	AppointmentStatusID = 90322
		FROM @Appointment tin
			inner join UTP_Appointment a on tin.OrderID = a.OrderID
		WHERE (a.AppointmentStatusID = 90321 -- booked
			and a.AppointmentTypeID = dbo.fnUTP_GetListMaster('AppointmentType','Relight')
			and (a.ApptStartDate <> tin.ApptStartDate
				or a.ApptEndDate <> tin.ApptEndDate
				or a.ApptStartTime <> tin.ApptStartTime
				or a.ApptEndTime <> tin.ApptEndTime))
			OR a.AppointmentStatusID IN (90320, 90329)
			OR (a.AppointmentStatusID IN (90320, 90321, 90329) AND a.AppointmentTypeID <> dbo.fnUTP_GetListMaster('AppointmentType','Relight'))

	-- add new if necessary
	INSERT UTP_Appointment
			([TechnicianID],[AppointmentTypeID],[AppointmentStatusID],[TimeslotID],[ApptStartDate],[ApptEndDate],
			[ApptStartTime],[ApptEndTime],[BookedViaID],[ExpectedDuration],[SpecialInstructions],[IsFirmAppt],
			[PreferredContactModeID],[OrderID],[CreatedTimestamp],[CreatedByID])
	SELECT  tin.TechnicianID
			,90312 -- Relight
			,90321 -- Booked
			,tin.TimeslotID
			,CAST(tin.ApptStartDate AS DATETIME) + CAST(CAST(ISNULL(tin.ApptStartTime,'00:00') AS TIME) AS DATETIME)
			,CASE WHEN CAST(tin.ApptEndDate AS DATETIME) + CAST(CAST(ISNULL(tin.ApptEndTime,'23:59') AS TIME) AS DATETIME) <
				CAST(tin.ApptStartDate AS DATETIME) + CAST(CAST(ISNULL(tin.ApptStartTime,'00:00') AS TIME) AS DATETIME) 
				THEN CAST(DATEADD(day,1,tin.ApptStartDate) AS DATETIME) + CAST(CAST(ISNULL(tin.ApptEndTime,'23:59') AS TIME) AS DATETIME)
				ELSE CAST(tin.ApptEndDate AS DATETIME) + CAST(CAST(ISNULL(tin.ApptEndTime,'23:59') AS TIME) AS DATETIME)
				END
			,tin.ApptStart;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_DispatchWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_DispatchWO;
GO
-- ===========================================================
-- Description: Appts must be scheduled 
-- Revisions:
-- ===========================================================
CREATE procedure [dbo].[UTP_DispatchWO]
	@Appointment [UTP_WOAppointmentType] READONLY,
	@UserID int,
	
	@ROWS [int] output
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_DispatchWO'

	select @i = count(*) from @Appointment
	if @i = 1
		select @Identifier = cast(OrderID as varchar(6)) from @Appointment
	else 
		set @Identifier = 'Multiple' 

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on
	
	DECLARE @SubmitBy varchar(50)
	IF @UserID IS NULL OR @UserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @UserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@UserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @UserID provided',2
	END
	-- Only fields in @Appointment that can be expected are OrderID and WONUM
	-- All Appointments to dispatch should be ready to dispatch
	-- All WO's should have STATUS or WMSTATUS = SCHED, No Booked or Complete Relight Appointments
	-- Appointment Start and End Dates and Times, and TechnicianID should be valid
	-- For UTP Appointments, update WMStatus to DISP, Cancel existing appointment and send new appt to Sabre if indicated
	-- For EGD Appointments, Update STATUS to DISP, send EGD Update, Cancel any existing work on
	-- Sabre and send this appointment
	DECLARE @OrderID int, @WONUM varchar(20), @WOID int, @AppointmentID int, @CrewID varchar(255), @StartDate DATETIME, @EndDate DATETIME, @IsFirmAppt bit
	DECLARE @NewKey int, @SubmitSuccess bit, @OrgShortName varchar(20), @ToSabre int = 0, @HasHandheld int = 0, @ToHandheld int = 0
	DECLARE @DispStatus int=dbo.fnUTP_GetListMaster('EGD_WOSTATUS','DISP')
	DECLARE @Memo UTP_OrderHistoryType, @TechID int
	DECLARE @MemoStatusID int=[dbo].[fnUTP_GetListMaster]('MemoType','7')
	
	DECLARE dc cursor for
		SELECT OrderID=a.OrderID,
			WONUM=wo.WONUM,
			WOID=wo.WOID,
			AppointmentID=a.AppointmentID,
			TechID=u.UserID,
			CrewID=u.Username,
			StartDate=a.ApptStartDate,
			EndDate=a.ApptEndDate,
			IsFirmAppt=a.IsFirmAppt,
			OrgShortName=wo.OrgShortName,
			ToSabre=wo.ToSabre
		FROM @Appointment tin
			INNER JOIN UTP_Appointment a ON tin.OrderID=a.OrderID AND a.AppointmentStatusID=90321 -- Booked
				AND a.AppointmentTypeID <> dbo.fnUTP_GetListMaster('AppointmentType','Relight')
			INNER JOIN UTP_User u ON a.TechnicianID=u.UserID
			INNER JOIN vw_TPS_WO wo ON tin.OrderID=wo.OrderID
			WHERE a.ApptStartDate IS NOT NULL AND a.ApptEndDate IS NOT NULL
				AND wo.WMStatus='SCHED'
	open dc
	fetch next from dc into @OrderID, @WONUM, @WOID, @AppointmentID, @TechID, @CrewID, @StartDate, @EndDate, @IsFirmAppt, @OrgShortName, @ToSabre

	set @i = 0
	while @@fetch_Status = 0
	begin
		set @i = @i + 1
		DECLARE @TS DATETIME = GETDATE()
		UPDATE UTP_WO SET WMStatusID=dbo.fnUTP_GetListMaster('WMStatus','DISP') WHERE OrderID=@OrderID
		SELECT @HasHandheld=[HasHandHeld] FROM UTP_Technician WHERE [UserID]=@TechID

		IF @ToSabre = 1
		BEGIN
			SELECT @ToHandheld=CASE WHEN (@HasHandheld = 1) AND ([dbo].[fnUTP_MessageEnabled]('HHSUBADDWR31','UTP_DispatchWO') = 1) THEN 1 ELSE 0 END
			IF (SELECT [dbo].[fnUTP_MessageEnabled]('HHSUBCANWR31','UTP_DispatchWO')) = 1
			BEGIN
				EXEC dbo.HH_Submit31ByWONUM 'HHSUBCANWR31', @WONUM, NULL, @NewKey OUTPUT
				IF @ToHandheld = 0
				BEGIN
					INSERT INTO [dbo].[UTP_O;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_DownloadDocument') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_DownloadDocument;
GO
-- DROP PROC [dbo].[UTP_DownloadDocument]
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: May 25, 2016
-- Description: Called when accessing a Document in Document Storage
-- Revisions: 
--	2016-08-03 Fixed bug causing the return of the wrong file
-- ====================================================================================
CREATE PROC [dbo].[UTP_DownloadDocument]
	@DocumentID [int],
	@CurrentUser [varchar](255),
	@Success [bit] OUTPUT,
	@FullPath [varchar](1024) OUTPUT
AS 
	DECLARE @Loc varchar(255) = 'UTP_DownloadDocument'
	DECLARE @CurrentUserID int, @Failure bit = 0, @RootPath varchar(255), @Filename varchar(255), @Filetype varchar(32)
	DECLARE @Errors UTP_ErrorType
	SET @Success=0

	SELECT @CurrentUserID=[UserID] FROM [dbo].[UTP_User] WHERE [Username] = @CurrentUser AND [IsActive] = 1
	IF @CurrentUserID IS NULL
		BEGIN
			INSERT INTO @Errors ([Code],[Level],[Message],[Location],[Param],[ParamValue])
			VALUES ('100',5,'Unknown User',@Loc,'@CurrentUser',@CurrentUser)
		END

	SELECT @Filename=doc.[Filename],@Filetype=doc.[Filetype],
		@RootPath=RTRIM(ds.[RootFolder]) + (CASE WHEN RIGHT(RTRIM(ds.[RootFolder]),1) = '\' THEN '' ELSE '\' END)
		FROM [dbo].[UTP_Document] doc
		JOIN [dbo].[UTP_DocumentStorage] ds ON doc.[DocumentRepositoryID]=ds.[DocumentStorageID]
		WHERE doc.[DocumentID]=@DocumentID
		
	IF @Filename IS NULL
		BEGIN
			INSERT INTO @Errors ([Code],[Level],[Message],[Location],[Param],[ParamValue])
			VALUES ('1',0,'Invalid DocumentID',@Loc,'@DocumentID',CAST(@DocumentID AS varchar(255)))
			SET @Failure=1
		END
	ELSE
		BEGIN
			DECLARE @FileSuffix varchar(33)
			IF (@Filetype IS NULL) OR (@Filetype='') SET @FileSuffix=''
			ELSE SELECT @FileSuffix=@Filetype
			SELECT @FullPath=@RootPath + @Filename + @FileSuffix
		END

	IF @Failure = 0
		BEGIN
			UPDATE [dbo].[UTP_Document] SET [AccessedTimestamp]=GetDate() WHERE [DocumentID]=@DocumentID
		END

	DECLARE @rv int
	SELECT [Code],[Level],[Message],[Location],[Param],[ParamValue] FROM @Errors
	IF @Failure = 0
		BEGIN
			SET @Success=1
			SET @rv=1
		END
	ELSE
		BEGIN
			SET @Success=0
			SET @rv=0
		END
	RETURN @rv





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_DuplicatePanel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_DuplicatePanel;
GO

CREATE procedure [dbo].[UTP_DuplicatePanel]
	@PanelName varchar(255),
	@NewPanelName varchar(255),
	@CurrentUserID int = null
as
	set nocount on

	declare @np int = null, 
			@p int = null

	select @p=PanelID from UTP_Panel where PanelName = @PanelName
	select @np=PanelID from UTP_Panel where PanelName = @NewPanelName

	if @np is null
		begin
		insert UTP_Panel (PanelName, PanelTypeID) select @NewPanelName, PanelTypeID from UTP_Panel where PanelName = @PanelName
		set @np = scope_identity()
		end
	else
		begin
		delete UTP_PanelColumn where PanelID = @np
		end
		
	insert UTP_PanelColumn 
		select	PanelID=@np
				,[ColumnName]
				,[DataAttributeID]
				,[DisplayName]
				,[HelpText]
				,[IsActive]
				,[IsReadOnly]
				,[IsOptional]
				,[IsHidden]
				,[SortOrder]
				,[DataTypeID]
				,[Length]
				,[ControlTypeID]
				,[LoVKey]
				,[LoVQueryName]
				,[LoVQueryValueColumn]
				,[LoVQueryDisplayColumn]
				,[DefaultValue]
				,[Description]
				,[LanguageID]
				,[FormatString]
				,[ColumnWidth]
			from UTP_PanelColumn where PanelID = @p

--	select * from UTP_Panel p left join UTP_PanelColumn pc on p.PanelID = pc.PanelID where p.PanelID = @np

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_EmailBookedAppointments') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_EmailBookedAppointments;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date: Sep 27, 2016
-- Description: List Booked appointments for specified date(s)
--              Default to yesterday, or last 3 days if Monday
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_EmailBookedAppointments]
	  @FitterFilter	varchar(10) = NULL
	, @Area			varchar(10) = NULL
	, @StartDate	date = NULL
	, @EndDate		date = NULL
	, @CommentsOnly varchar(3) = 'No'
	, @UtilityReq varchar(10) = '%'
	, @Test int = 0
AS
	declare @EmailRecipient varchar(max),@CCRecipient varchar(max),@BCCRecipient varchar(max)
	declare @Support_Email varchar(max), @Operations_Email varchar(max)
	declare @sendto varchar (max),@ccto varchar (max),@bccto varchar (max)
	
	set @Support_Email = dbo.fnUTP_EmailAssembleList('SoftwareSupport')
	set @EmailRecipient= dbo.fnUTP_EmailAssembleList('DailyBookedApptsEmail')
	
	set @BCCRecipient = @Support_Email

	if @FitterFilter is null select @FitterFilter = '%'
	if @Area is null select @Area = '%'

	if @StartDate is null and @EndDate is null
	BEGIN
		if datepart(weekday,getdate()) = 2 
		BEGIN
			select @StartDate = dateadd (day,-3,convert (date, getdate())) 
			select @EndDate = dateadd(day, 2,@StartDate)
		END ELSE BEGIN
			select @StartDate = dateadd (day,-1,convert (date, getdate())) 
			select @EndDate = @StartDate
		END
	END

	if @StartDate is null select @StartDate=@EndDate
	if @EndDate is null select @EndDate= @StartDate

	--select @StartDate,@EndDate
	IF OBJECT_ID('tempdb..#tmp1') IS NOT NULL drop table #tmp1
	select 
		Utility=org.ShortName,
		Area = COALESCE(g.GroupName,''),
		a.AppointmentID,
		wo.uWOID,
		wo.TechnicianID,
		Fitter=COALESCE(u.UserName,''),
		Email=COALESCE(pe.Email,''),
		[Time]=COALESCE(convert(varchar(5),a.ApptStartTime) + '-' + convert(varchar(5),a.ApptEndTime),''),
		[Date]=COALESCE(CONVERT(char(10),COALESCE(ApptEndDate,ApptStartDate,''),101),''),
		a.ApptStartDate,
		a.ApptEndDate,
		a.ApptStartTime,
		a.ApptEndTime,
		WRNo=COALESCE(wo.WONUM,''),
		[Address]=dbo.[fnUTP_FormatAddressNoPostalCode](ad.AddressID),
		Contact=COALESCE(ContactName,''),
		Phone=COALESCE(ContactPhone,''),
		Alternate=case when IsNumeric(substring(ContactAlternatePhone,2,1))=1 then ContactAlternatePhone else '' end,
		Request=COALESCE(SpecialInstructions,''),
		MeterNo=COALESCE(sp.AttributeValue,''),
		[Grid] = COALESCE(wo.Grid,''),
		Comment='CMT',
		[BookedDate]=COALESCE(CONVERT(char(10),a.CreatedTimestamp,101),''),
		BookedVia=COALESCE(bv.ListText,'')
		into #tmp1
	--select g.GroupName, *
		From UTP_WO wo 
		left join UTP_OrderAddress (nolock)oa on oa.OrderID=wo.OrderID
		left join UTP_Address (nolock)ad on ad.AddressID = oa.AddressID
		join UTP_Appointment (nolock)a on a.OrderID=wo.OrderID and a.AppointmentID in (select MAX(AppointmentID) from UTP_Appointment a2 where a2.OrderID=wo.OrderID)
		left join UTP_Order (nolock)o on o.OrderID = wo.OrderID
		left join UTP_Contact (nolock)c on c.ContactID = a.ContactID
		left join UTP_ListMaster (nolock)ct on ct.ListID=c.ContactTypeID
		left join UTP_Spec (nolock) sp on sp.OrderID=a.OrderID and AttributeName='MeterNo'
		left join UTP_User (nolock)u on u.UserID=wo.TechnicianID
		left join UTP_Person (nolock)p on p.PersonID = u.PersonID
		left join UTP_PhoneEmail (nolock)pe on pe.PhoneEmailID = p.PhoneEmailID
		left join UTP_ListMaster (nolock)bv on bv.ListID = BookedViaID
		left join UTP_Org (nolock)org on org.OrgID = o.OrgID
		left join UTP_Group (nolock)g on g.GroupID = wo.AreaID
	where 
	  COALESCE(u.UserName,'') like @FitterFilter
	and @StartDate <= COALESCE(ApptStartDate,ApptEndDate)
	and  COALESCE(ApptEndDate,ApptStartDate)<dateadd(day,1,@EndDate)
	and (@CommentsOnly='No' OR len (COALESCE(SpecialInstructions,'')) >0)
	and g.GroupName like @Area
	and org.ShortName like @UtilityReq
	and a.AppointmentStatusID = 903;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_EmailConfirmAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_EmailConfirmAppointment;
GO
-- =============================================
-- Author:		Jeff Moretti
-- Create date: 2016-09-29
-- Description: Sends out a confirmation
--				email to confirm a booking
--				of an appointment (to the
--				customer).  Created for use
--				with UTOPIS4 GUI (book
--				appointment).  Based of email
--				sent from Portal_ConfirmAppointment
--  Revised: 2016-09-30 dm TimeSlot: ListText instead of ListValue
--           2017-03-20 dm jrp instead of jpeacock
--           2017-08-17 dm 3 changes:
--              1)	Used OrderID to match WOID, resulting in possible incorrect branding on the emails 
--              2)	Did not filter by ContactID=1803, possibly resulting in selecting the occupant instead of the contact person
--              3)	Some fields being null resulted in a null body
-- =============================================
CREATE PROCEDURE [dbo].[UTP_EmailConfirmAppointment]
	@WRNo varchar(15),
	@WOApptID int,
	@EmailAddress varchar(255),
	@IsFrench bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @TracelogID int,
			@Version int,
			@ProcedureName varchar(50),
			@TextSubj varchar(255),
			@TextType varchar(255),
			@TextExplanation varchar(255),
			@TextWarning varchar(255)

	set @Version = 1
	set @ProcedureName = 'UTP_EmailConfirmAppointment'
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version

	DECLARE @JobCode varchar(255)

	-- TODO: Need to set JobCode, in order to properly handle standpipe removal appts
	
	if (@IsFrench = 0) -- English Email
	BEGIN
		if COALESCE(@JobCode,'') = 'SLRMSP'
		BEGIN
			set @TextSubj = 'Standpipe Removal appointment'
			set @TextType = 'remove the standpipe on '
			set @TextExplanation = 'Please be advised that the standpipe on your property must be removed.'
			set @TextWarning = ''
		END ELSE BEGIN
			set @TextSubj = 'Gas Meter Exchange appointment'
			set @TextType = 'replace your meter on '
			set @TextExplanation = 'Please be advised that the gas meter on your property must be exchanged.'
			set @TextWarning = char(10) +' In order to minimize the inconvenience to you, we ask that all obstructions be carefully cleared away from the meter set.  However, we do require access to your home or business to restore your gas service to your equipment.'
		END
	END
	ELSE -- French Email
	BEGIN
		if COALESCE(@JobCode,'') = 'SLRMSP'
		BEGIN
			set @TextSubj = 'Rendez-vous pour l''enlèvement d''une colonne montante'
			set @TextType = 'enlève la colonne montante le '
			set @TextExplanation = 'Veuillez prendre note que la colonne montante située sur votre propriété doit être enlevée.'
			set @TextWarning = ''
		END ELSE BEGIN
			set @TextSubj = 'remplacement de votre compteur à gaz'
			set @TextType = 'remplace votre compteur à gaz le '
			set @TextExplanation = 'Veuillez prendre note que le compteur à gaz installé sur votre propriété doit être remplacé.'
			set @TextWarning = char(10) +' Afin de minimiser tout inconvénient personnel, nous vous demandons d''enlever soigneusement tous les éléments qui peuvent nuire à l''accès au compteur.  Toutefois, nous devons pouvoir accéder à votre maison ou votre commerce afin de rétablir l''alimentation de vos appareils à gaz.'
		END
	END

	DECLARE @subject varchar(255),
				@body varchar(max),
				@boilerplate varchar(max),
				@BCC_Email varchar(255),
				@Support varchar(255)
				
		SET @Support = 'jrp@circumference.ca;' 
		
	DECLARE @Utility varchar(255),
			@ContactInfo varchar(255)

	IF @IsFrench = 0 -- English Email
	BEGIN
	
		SET @subject ='IMPORTANT INFORMATION about your ' + @TextSubj
							
		SELECT  TOP 1
                     @Utility = wo.OrgShortName,
                     @ContactInfo = case when wo.OrgShortName = 'UGD' 
										then 'go to www.ugd.lakesidegas.ca to reschedule, or call 1-877-313-6046'
   when wo.OrgShortName = 'KU'
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_EmailScheduledAppointments') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_EmailScheduledAppointments;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date:  2016-10-04
-- Description:
--     Send daily emails to UGD/KU techs
--     Ported from Utopis 3.5
-- Revisions:
--     Feb 06, 2017 - dm - include meter location, size on emails
--     Mar 13, 2017 - dm - select by AddressTypeID on UTP_OrderAddress
--     Mar 20, 2017 - dm - jrp instead of jpeacock
--     Apr 12, 2017 - dm - add tsm_ltd@rogers.com to recipient list for KT02
--     May 05, 2017 - dm - add job type
-- ===========================================================
-- @Test
--         0-No
--         1-Yes, send all emails to UTP_EmailRecipients list
--         2-Yes and don't send any emails
--         3-just select the data and return, don't format emails
--
-- To test sending emails to yourself and not me (Diane)
-- change the EmailRecipient in table UTP_EmailRecipients
-- for ListName='TestUGDEmailTechs'
--
-- To check the content, without sending emails, set @Test to
-- 2 and copy the html body that is selected by @test=2 run
-- into a file with .htm extension and load in a web browser
-- or Visual Studio. This will also show you the actual
-- recipients for the non-test run
--
-- Note: ZZZZZZZZZZZZZZZZZ is a dummy line so the cursor loop can process
-- all of the items without a final total required outside of the loop
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_EmailScheduledAppointments]
	@StartDate datetime = null,
	@EndDate datetime = null,
	@FitterFilter varchar(25) = '%',
	@Test int = 0 -- 0-No, 1-Yes, 2-Yes and don't send any emails, 3-just select the data and return, don't format emails
AS

-- 1) Get all appointment data into #tmp1
-- 2) using cursor, send mail to each fitter
-- 3) table 1: next day
-- 4) table 2: all future
-- 3) summary email

	declare @AppendAllFuture int

	declare @EmailRecipient varchar(max),@SummaryRecipient varchar(max),@CCRecipient varchar(max),@BCCRecipient varchar(max)
	declare @Support_Email varchar(max), @Operations_Email varchar(max),@SummaryOnly_Email varchar(max)
	declare @sendto varchar (max),@ccto varchar (max),@bccto varchar (max)
	
	set @Support_Email = dbo.fnUTP_EmailAssembleList('OperationsSupport')
	set @Operations_Email = dbo.fnUTP_EmailAssembleList('UGDScheduledAppointments_To')
						+ dbo.fnUTP_EmailAssembleList('UGDScheduledAppointments_Cc')
	set @SummaryOnly_Email = dbo.fnUTP_EmailAssembleList('UGDScheduledAppointments_Summary')

	set @BCCRecipient = 'jrp@circumference.ca;'+@Support_Email


	declare @TestRecipient varchar(max)
	select @TestRecipient = dbo.fnUTP_EmailAssembleList('TestUGDEmailTechs')
	--if @test = 0 select @test = 1

	select @AppendAllFuture = 1
	if @FitterFilter is null select @FitterFilter = '%'

	if @StartDate is null set @StartDate = cast(dateadd(d,1,getdate()) as date)
	if @EndDate is null 
	begin
		if datepart(weekday, getdate()) = 6
		BEGIN
			set @EndDate = cast(dateadd(d,3,@StartDate) as date)
		END else BEGIN
			set @EndDate = cast(dateadd(d,1,@StartDate) as date)
		END
	end

	--select @StartDate,@EndDate

	IF OBJECT_ID('tempdb..#tmp1') IS NOT NULL drop table #tmp1
	select 
		a.AppointmentID,
		wo.uWOID,
		wo.TechnicianID,
		Fitter=COALESCE(u.UserName,''),
		Email=COALESCE(pe.Email,''),
		[Time]=COALESCE(CONVERT(char(10),COALESCE(ApptEndDate,ApptStartDate,''),101)+ ' '+convert(varchar(5),a.ApptStartTime) + '-' + convert(varchar(5),a.ApptEndTime),''),
		[Date]=COALESCE(CONVERT(char(10),COALESCE(ApptEndDate,ApptStartDate,''),101),''),

		a.ApptStartDate,
		a.ApptEndDate,
		a.ApptStartTime,
		a.ApptEndTime,
		s=@StartDate,e=@EndDate,
		InTarget=case when (@StartDate <= COALESCE(ApptStartDate,ApptEndDate) and COALESCE(ApptStartDate,ApptEndDate) < @EndDate)  then 1 else 0 end,
		WRNo=wo.WONUM,
		[Address]=dbo.[fnUTP_FormatAddressNoPostalCode](ad.AddressID),
		Contact=COALESCE(ContactName,''),;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ExistsImportTemplate') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ExistsImportTemplate;
GO




-- =============================================
-- Author:		Jeff Moretti
-- Create date: March 21, 2016
-- Description:	Check to see if a template
--				exists for the given template
--				name (under the given template
--				type)
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ExistsImportTemplate]
	-- Add the parameters for the stored procedure here
	@ImportTemplateName VARCHAR(50),
	@ImportTypeId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ImportTemplateID
	FROM UTP_ImportTemplate
	WHERE ImportTemplateName = @ImportTemplateName
	AND ImportTypeId = @ImportTypeId
END









;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ExtractErrorFromMemo') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION UTP_ExtractErrorFromMemo;
GO
-- ===========================================================      
-- Create date: 2016-11-24      
-- Description: Extract the BMX error number from the memo
-- Revisions:      
-- ===========================================================      
create FUNCTION [dbo].[UTP_ExtractErrorFromMemo] (@text varchar(max))
	RETURNS varchar(max)
AS
	BEGIN
		if @text not like '%BMX%' return ''

		declare @n1 int, @n2 int
		select @n1=charindex('BMX',@text)
		select @n2=charindex(' ',@text,@n1)
		RETURN (SUBSTRING(@text,@n1,@n2-@n1))
	END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_fnGetGroupTreeIDList') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT')) DROP FUNCTION UTP_fnGetGroupTreeIDList;
GO

create function [dbo].[UTP_fnGetGroupTreeIDList] (@GroupID int) returns @IDList TABLE (ID int) as
	begin
	insert @IDList (ID) select @GroupID

	declare data cursor for 
		select GroupID from UTP_Group where ParentGroupID = @GroupID

	declare @ChildGroupID int 
	open data
	fetch next from data into  @ChildGroupID
	while @@FETCH_STATUS = 0
		begin
		insert @IDList (ID) select ID from dbo.UTP_fnGetGroupTreeIDList(@ChildGroupID)
		fetch next from data into  @ChildGroupID
		end
	close data
	deallocate data

	return 
	end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GeneratePanelColumnScript') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GeneratePanelColumnScript;
GO

/*
declare @Script varchar(max), @l int, @c int
exec UTP_GeneratePanelColumnScript 'pnEGD_WO', '%', null, @Script out, @l out, @c out
select @l,@c, @Script

select * from UTP_DataAttribute where Category='ListMaster'
*/
create procedure [dbo].[UTP_GeneratePanelColumnScript] 
	@PanelName varchar(50) = '%',
	@ColumnName varchar(50) = '%',
	@CurrentUserID int = null,

	@ScriptOut varchar(max) output,
	@Lines int output,
	@Chars int output
as

	declare data1 cursor for
		select  distinct
				'if (select DataAttributeID From UTP_DataAttribute where Category=''' + da.Category + ''' and AttributeName=''' + da.AttributeName + ''') IS NULL '
				+ ' exec UTP_CreateDataAttribute ' 
				+ '''' + da.Category 
				+ ''',''' + da.AttributeName
				+ ''',''' + da.DisplayName
				+ ''',' + case when da.Description is null then 'null' else '''' + da.Description + '''' end
				+ ',' + convert(varchar(6),da.DataTypeID)
				+ ',' + convert(varchar(6),da.Length)
				+ case when da.DefaultValue is null then ',null' else ',''' + da.DefaultValue + '''' end
				+ case when da.DocText is null then ',null' else ',''' + da.DocText + '''' end
				+ case when da.HelpText is null then ',null' else ',''' + da.HelpText + '''' end
				+ case when da.LoVKey is null then ',null' else ',''' + da.LoVKey + '''' end
				+ ',' + convert(varchar(6),da.IsActive)
				+ ',' + convert(varchar(6),da.IsDerived)
				+ case when da.ValidationRule is null then ',null' else ',''' + da.ValidationRule + '''' end
				+ case when da.VAddedID is null then ',null' else ',' + convert(varchar(6),da.VAddedID) end
				+ case when da.VRemoved is null then ',null' else ',' + convert(varchar(6),da.VRemoved) end

			--select distinct *
			from UTP_Panel p 
				inner join UTP_PanelColumn pc on p.PanelID = pc.PanelID
				inner join UTP_DataAttribute da on pc.DataAttributeID = da.DataAttributeID
			where PanelName like @PanelName

	open data1

	declare @Line varchar(1000),
			@pn varchar(50),
			@cn varchar(50),
			@p varchar(50),
			@a varchar(50),
			@c varchar(50)
			
	fetch next from data1 into @line

	set @ScriptOut = 'set nocount on'  + char(13) + char(10)
	set @Lines = 0

	while @@FETCH_STATUS = 0
		begin
		print @c + ',' +  @a + ','+ isnull(@line,'')
		set @Lines = @Lines + 1
		set @ScriptOut = @ScriptOut + @line + char(13) + char(10)
		fetch next from data1 into @line
		end

	close data1
	deallocate data1

	declare data cursor for
		select  PanelName,
				ColumnName,
				Line='select @attr = DataAttributeID from UTP_DataAttribute where AttributeName=''' + da.AttributeName + ''' and Category=''' + da.Category + ''' ;'
					+ 'exec UTP_CreateOrUpdatePanelColumn '
					+ '''' + PanelName 
					+ ''', ''' + ColumnName
					+ ''', @attr'
					+ ', ''' + pc.DisplayName
					+ ''', ' + case when pc.HelpText is null then 'null' else '''' + pc.HelpText + '''' end
					+ ', ' + isnull(convert(varchar(6),pc.IsActive),'null')
					+ ', ' + isnull(convert(varchar(6),pc.IsReadOnly),'null')
					+ ', ' + isnull(convert(varchar(6),pc.IsOptional),'null')
					+ ', ' + isnull(convert(varchar(6),pc.IsHidden),'null')
					+ ', ' + isnull(convert(varchar(6),pc.SortOrder),'null')
					+ ', ' + convert(varchar(6),pc.DataTypeID )
					+ ', ' +  isnull(convert(varchar(6),pc.Length),'null')
					+ ', ' + convert(varchar(6),pc.ControlTypeID)
					+ ', ' + case when pc.LoVKey is null then 'null' else '''' + pc.LoVKey + '''' end
					+ ', ' + case when pc.LoVQueryName is null then 'null' else '''' + pc.LoVQueryName + '''' end
					+ ', ' + case when pc.LoVQueryValueColumn is null then 'null' else '''' + pc.LoVQueryValueColumn + '''' end
					+ ', ' + case when pc.LoVQueryDisplayColumn is null then 'null' else '''' + pc.LoVQueryDisplayColumn + '''' end
					+ ', ' + case when pc.DefaultValue is null then 'null' else '''' + pc.DefaultValue + '''' end
					+ ', ' + case when pc.Description is null then 'null' else '''' + pc.D;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Get_WOServiceAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Get_WOServiceAddress;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_WOServiceAddress
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Get_WOServiceAddress]
	@OrderID [int] = null,
	@UserID [int] = null
AS
	select 
		[OrderID],
		[WOID],
		[WONUM],
		[OrderAddressID],
		[AddressID],
		[AddressTypeID],
		[AddressType],
		[DisplayAddress],
		[StreetNo],
		[LotNumber],
		[Unit],
		[Street],
		[Sfx],
		[Misc],
		[Town],
		[County],
		[ProvinceID],
		[ProviceCode],
		[Province],
		[PostCode],
		[CountryID],
		[CountryCode],
		[Country],
		[BuildingTypeID],
		[BuildingType]

  FROM [dbo].[vw_UTP_WOServiceAddress]
  where OrderID=COALESCE(@OrderID,OrderID)





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetAppointment;
GO

-- =============================================
-- Author:		John Peacock
-- Create date: July 2, 2016
-- exec [UTP_GetApptHistory] null, 'Booked'
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetAppointment]
	@OrderID int = null,
	@AppointmentStatus varchar(20) = null,
	@CurrentUserID int = null
AS
	BEGIN
	SET NOCOUNT ON

	SELECT [AppointmentID]
		  ,[OrderID]
		  ,[WOID]
		  ,[WONUM]
		  ,[AppointmentStatusID]
		  ,[AppointmentStatus]
		  ,[TechnicianID]
		  ,[Technician]
		  ,[AppointmentTypeID]
		  ,[AppointmentType]
		  ,[TimeslotID]
		  ,[ApptStartDate]
		  ,[ApptEndDate]
		  ,[ApptStartTime]
		  ,[ApptEndTime]
		  ,[IsFirmAppt]
		  ,[BookedViaID]
		  ,[CreateByID]
		  ,[CreatedTimestamp]
		  ,[ExpectedDuration]
		  ,[PreferredContactModeID]
		  ,[ModifiedByID]
		  ,[ModifiedTimestamp]
		  ,[SpecialInstructions]
		  ,[AccessRestricted]
		  ,[MedicalNecessity]
		  ,[ContactID]
		  ,[ActualStart]
		  ,[ActualFinish]
		  ,[CompletionCode]
	  FROM [dbo].[vw_UTP_WOAppointment]
		WHERE OrderID = isnull(@OrderID,OrderID)
			and AppointmentStatus = ISNULL(AppointmentStatus,@AppointmentStatus)
	END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetAvailableDates') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetAvailableDates;
GO

CREATE procedure [dbo].[UTP_GetAvailableDates]
	@FromDate datetime = null,
	@ToDate datetime = null,
	@OrderID int = null,
	@TechnicianID int = null

as
begin
	declare @Window int  = 60 --days

	DECLARE @GroupID int
			
	SELECT	@GroupID = GroupID
		FROM vw_UTP_WO uw
		WHERE uw.OrderID = @OrderID

	select 
			u.[UserID],
			u.[PersonID],
			[FirstNameLastName] = max(p.FirstName+' '+ p.LastName),
			[LastNameFirstName] = max(p.LastName + ', ' + p.FirstName),
			w.WorkDate,
			Appts = sum(w.Capacity - isnull(a.Booked,0))

		from UTP_User u 
			left join UTP_Person p on p.PersonID = u.PersonID
			left join UTP_WorkSchedule w on u.UserID = w.UserID AND w.ScheduleTypeID = 90350 -- Project
			left join vw_UTP_ScheduledAppointments a on w.UserID = a.TechnicianID and w.WorkDate = a.ApptEndDate and w.TimeSlotID = a.TimeslotID and w.GroupID = a.GroupID
			left join UTP_Group g on g.GroupID = w.GroupID
		where 
			u.UserID = @TechnicianID
			and g.GroupID = @GroupID
			and w.WorkDate between isnull(@FromDate,getdate()) and isnull(@ToDate,dateadd(d,@Window,getdate()))
			-- don't include Relights
			and w.TimeSlotID <> 90307
			-- Added by JeffM - this will handle the prior notice for booking an appointment
			AND
			((CONVERT(TIME, getdate()) <= '15:30:00' AND -- before 3:30 pm, can book the next business day
				w.WorkDate >= case datepart(weekday, getdate()) 
--								when 6 then dateadd(d,3,cast(getdate() as date)) -- fri
								when 7 then dateadd(d,3,cast(getdate() as date)) -- sat
								when 1 then dateadd(d,2,cast(getdate() as date)) -- sun
								else dateadd(d,1,cast(getdate() as date)) end)
			OR
			 (CONVERT(TIME, getdate()) > '15:30:00' AND -- after 3:30 pm, must book two days from now
				w.WorkDate >= case datepart(weekday, getdate()) 
								when 6 then dateadd(d,4,cast(getdate() as date)) -- fri
								when 7 then dateadd(d,3,cast(getdate() as date)) -- sat
								when 1 then dateadd(d,2,cast(getdate() as date)) -- sun
								else dateadd(d,2,cast(getdate() as date)) end)
			)
		group by u.UserID, u.PersonID, w.WorkDate
		HAVING sum(w.Capacity - isnull(a.Booked,0)) > 0

		-- Added by JeffM - this will handle the prior notice for booking an appointment
		-- OLD WorkDate comparison - taken from the way Utopis 3.5 was based on
		--HAVING WorkDate >= case datepart(weekday, getdate()) 
		--								when 6 then dateadd(d,5,cast(getdate() as date)) -- fri
		--								when 7 then dateadd(d,4,cast(getdate() as date)) -- sat
		--								when 1 then dateadd(d,3,cast(getdate() as date)) -- sun
		--								else dateadd(d,3,cast(getdate() as date)) end -- was 2 days, made it 3 to ensure 48 hrs
		--	and Workdate between coalesce(@FromDate,getdate()) and coalesce(@ToDate,dateadd(d,60,cast(getdate() as date)))

end


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetAvailableTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetAvailableTechnician;
GO
CREATE procedure [dbo].[UTP_GetAvailableTechnician]
	@FromDate datetime = null,
	@ToDate datetime = null,
	@OrderID int = null
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetAvailableTechnician'
							+ ', @FromDate=' + isnull(cast(@FromDate as varchar(15)),'null')
							+ ', @ToDate=' + isnull(cast(@ToDate as varchar(15)),'null')
	select @Identifier = isnull(convert(varchar(10),@OrderID),'null')

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on
	
	declare @Window int  = 60, --days
			@CheckWorkSchedule int = 1,
			@GroupID int
			
	select @GroupID = dbo.fnUTP_GetGroupID(@OrderID)

	--if @FromDate is null and @ToDate is null 
	--	set @CheckWorkSchedule = 0

	select --top 20
			t.[UserID],
			PersonID = max(u.[PersonID]),
			[FirstNameLastName] = max(u.Username + ' ('+ p.FirstName +' '+ p.LastName+ ')'),
			[LastNameFirstName] = max(u.Username + ' ('+ p.LastName + ', ' + p.FirstName + ')'),
			Slots = count(w.TimeSlotID), -- temp (not correct) calculation
			Appts = sum(w.Capacity - isnull(a.Booked,0))
--			sum(w.Capacity) -- - dbo.fnUTP_ComputeBookedAppt(t.UserID,w.WorkDate,w.TimeSlotID))
			-- select *
		from UTP_Technician t
			inner join UTP_User u on t.UserID = u.UserID
			inner join UTP_Person p on p.PersonID = u.PersonID
			inner join UTP_WorkSchedule w on t.UserID = w.UserID
			inner join UTP_Group g on w.GroupID = g.GroupID -- patch
			left join vw_UTP_ScheduledAppointments a on w.UserID = a.TechnicianID and w.WorkDate = a.ApptEndDate and w.TimeSlotID = a.TimeslotID and w.GroupID = a.GroupID
		where w.GroupID = isnull(@GroupID,w.GroupID)
		--	and g.GroupCode in ('100','200','300','400','500','600')
			and (@CheckWorkSchedule = 0 
			or (@CheckWorkSchedule = 1 
				and w.WorkDate between isnull(@FromDate,getdate()) and isnull(@ToDate,dateadd(d,@Window,getdate()))
				))
		group by t.UserID

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetAvailableTimeslots') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetAvailableTimeslots;
GO
CREATE procedure [dbo].[UTP_GetAvailableTimeslots]
	@FromDate datetime = null,
	@ToDate datetime = null,
	@OrderID int = null,
	@UserID int = null -- Should be TechnicianID

as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetAvailableTimeslots'
	select @Identifier = 'UserID=' + convert(varchar(6),@UserID) 

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	declare @Window int  = 42, --days
			@GroupID int
			
	select @GroupID = dbo.fnUTP_GetGroupID(@OrderID)

	select 
			t.UserID,
			Username = max(u.Username),
			[FirstNameLastName] = max(p.FirstName+' '+ p.LastName),
			[LastNameFirstName] = max(p.LastName + ', ' + p.FirstName),
			w.WorkDate,
			w.TimeslotID,
			TimeSlot = max(l.ListText),
			ApptsAvailabile = left(datename(weekday, w.WorkDate),3) + ', ' + convert(varchar(15),w.WorkDate,107) + ' ' + max(l.ListText) + ' (' + convert(varchar(6),sum(w.Capacity - isnull(a.Booked,0))) + ' available)',
			Capacity = sum(w.Capacity),
			Booked = isnull(sum(isnull(a.Booked,0)),0),
			Available = sum(w.Capacity - isnull(a.Booked,0))

		from UTP_Technician t
			left join UTP_User u on t.UserID = u.UserID
			left join UTP_Person p on p.PersonID = u.PersonID
			left join UTP_WorkSchedule w on t.UserID = w.UserID
			left join vw_UTP_ScheduledAppointments a on w.UserID = a.TechnicianID and w.WorkDate = a.ApptEndDate and w.TimeSlotID = a.TimeslotID and w.GroupID = a.GroupID
			left join UTP_ListMaster l on w.TimeSlotID = l.ListID
		where w.GroupID = isnull(@GroupID,w.GroupID)
			and  w.WorkDate between isnull(@FromDate,cast(getdate() as date)) and isnull(@ToDate,dateadd(d,@Window,getdate()))
			and t.UserID = isnull(@UserID, t.UserID)
			and w.Capacity > 0
			and w.ScheduleTypeID in (90350)
			and w.TimeSlotID not in (90307)
			AND
			((CONVERT(TIME, getdate()) <= '15:30:00' AND -- before 3:30 pm, can book the next business day
				w.WorkDate >= case datepart(weekday, getdate()) 
--								when 6 then dateadd(d,3,cast(getdate() as date)) -- fri
								when 7 then dateadd(d,3,cast(getdate() as date)) -- sat
								when 1 then dateadd(d,2,cast(getdate() as date)) -- sun
								else dateadd(d,1,cast(getdate() as date)) end)
			OR
			 (CONVERT(TIME, getdate()) > '15:30:00' AND -- after 3:30 pm, must book two days from now
				w.WorkDate >= case datepart(weekday, getdate()) 
								when 6 then dateadd(d,4,cast(getdate() as date)) -- fri
								when 7 then dateadd(d,3,cast(getdate() as date)) -- sat
								when 1 then dateadd(d,2,cast(getdate() as date)) -- sun
								else dateadd(d,2,cast(getdate() as date)) end)
			)
		group by t.UserID, w.WorkDate, w.TimeSlotID
		having sum(w.Capacity - isnull(a.Booked,0)) > 0

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetCodeOutSpec') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetCodeOutSpec;
GO

CREATE PROC [dbo].[UTP_GetCodeOutSpec]
	@OrderID int,
	@CurrentUserID int = null
AS
-- May need to support UTP work orders
		--exec UTP_GetSpec @OrderID

	declare @CC varchar(30) = null
	--select @CC = isnull(WAMS_COMPCODE,'') from EGD_WO where OrderID = @OrderID
	if isnull(@CC,'') not in ('20','99','DS')
		exec UTP_GetSpec @OrderID
	else 
		-- just return an empty resultset
		exec UTP_GetSpec -1


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetCollection') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetCollection;
GO

-- ===========================================================
-- UTP_GetCollection
-- Revisions:
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_GetCollection]
	@CollectionID int = null,
	@CollectionType varchar(255) = '%',
	@CollectionOwnerID int = null,
	@CurrentUserID int = null
as
	SELECT [CollectionID]
		  ,[CollectionTypeID]
		  ,[CollectionType]
		  ,[CollectionName]
		  ,[CollectionOwnerID]
		  ,[CollectionOwner]
		  ,[CollectionQuery]
		  ,[StatementTypeID]
		  ,[StatementType]
	  FROM [dbo].[vw_UTP_Collection]
	  WHERE CollectionID = isnull(@CollectionID,CollectionID)
		and CollectionType like @CollectionType
		and CollectionOwnerID = isnull(@CollectionOwnerID,CollectionOwnerID)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetCollectionItem') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetCollectionItem;
GO

-- ===========================================================
-- UTP_GetCollectionItem
-- Revisions:
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_GetCollectionItem]
	@CollectionItemID int = null,
	@CollectionID int = null,
	@CollectionType varchar(255) = '%',
	@CurrentUserID int = null
as
	SELECT [CollectionItemID]
		  ,[CollectionID]
		  ,[CollectionTypeID]
		  ,[CollectionType]
		  ,[CollectionName]
		  ,[CollectionItem]
	  FROM [dbo].[vw_UTP_CollectionItem]
	  WHERE CollectionItemID = isnull(@CollectionItemID,CollectionItemID)
		and CollectionID = isnull(@CollectionID,CollectionID)
		and CollectionType like @CollectionType

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetContract') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetContract;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: July 11, 2017
-- Description:	Fetches Contract(s) from the
--				UTP_Contract table
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetContract] 
	@ContractID BIGINT = NULL,
	@ContractTypeID INT = NULL,
	@OrgID INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		ContractID, 
		ContractTypeID, 
		ContractNum, 
		ContractName, 
		ContractDescription, 
		CustomerContractNum, 
		ContractStartDate,  
		ContractEndDate,
		OrgID
	FROM UTP_Contract
	WHERE ContractID = ISNULL(@ContractID,ContractID)
			AND	ContractTypeID = ISNULL(@ContractTypeID, ContractTypeID)
			AND OrgID = ISNULL(@OrgID, OrgID)
			AND IsActive = 1

END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetCurrentAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetCurrentAppointment;
GO

--	June-2018	JRP	LPGS_1455 Added PSN
--	July-2018	JRP Added PreferredContactMode
CREATE procedure [dbo].[UTP_GetCurrentAppointment]
	@OrderID int
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 2	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetCurrentAppointment'
	set @Identifier = 'OrderID=' + cast(@OrderID as varchar(20))
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	declare @AppointmentID int, @ContactID int

	select top 1 @AppointmentID=AppointmentID from UTP_Appointment where OrderID = @OrderID and AppointmentStatusID = 90321 -- Booked
	order by AppointmentID DESC
	IF @AppointmentID IS NULL
		select top 1 @AppointmentID=AppointmentID from UTP_Appointment where OrderID = @OrderID and AppointmentStatusID <> 90321 -- Not Booked
		order by AppointmentID DESC

	SELECT top 1 @ContactID=ContactID from UTP_Contact where OrderID=@OrderID AND ContactTypeID=1803 -- CONTACT
	ORDER BY ContactID DESC

	select
			OrderID = wo.OrderID,
			AppointmentID = a.AppointmentID,
			AppointmentTypeID = a.AppointmentTypeID,
			AppointmentType = at.ListText,
			AppointmentStatusID = a.AppointmentStatusID,
			AppointmentStatus = st.ListText,
			ApptStartDate = a.ApptStartDate,
			ApptEndDate = a.ApptEndDate,
			ApptStartTime = a.ApptStartTime,
			ApptEndTime = a.ApptEndTime,
			IsFirmAppt = a.IsFirmAppt,
			TimeSlotID = a.TimeslotID,
			Timeslot = ts.ListText,
			TechnicianID = isnull(a.TechnicianID,wo.TechnicianID),
			Technician = t.Username,
			ContactID = c.ContactID,
			SpecialInstructions = isnull(a.SpecialInstructions,''),
			AccessRestricted = isnull(a.AccessRestricted,0),
			MedicalNecessity = isnull(a.MedicalNecessity,0),
			EmailConfirmation = isnull(cast(case when PreferredContactModeID = 90362 then 1 else 0 end as bit),''),
			CustomerName = isnull(c.ContactName,wo.CustomerName),
			Phone = isnull(c.ContactPhone,wo.CustomerPhone),
			AlternatePhone = isnull(c.ContactAlternatePhone,''),
			Email = isnull(c.ContactEmail,''),
			PSN = cast(wo.PSN as varchar(max)),
			PreferredContactMode = pcm.ListValue
		from vw_UTP_WO_UTP wo
			left join UTP_Contact c on wo.OrderID = c.OrderID and c.ContactID = @ContactID
			left join UTP_Appointment a on wo.OrderID = a.OrderID and a.AppointmentID = @AppointmentID
			left join UTP_User t on a.TechnicianID = t.UserID
			left join UTP_ListMaster ts on a.TimeslotID = ts.ListID
			left join UTP_ListMaster at on a.AppointmentTypeID = at.ListID
			left join UTP_ListMaster st on a.AppointmentStatusID = st.ListID
			left join UTP_ListMaster pcm on a.PreferredContactModeID = pcm.ListID
		where wo.OrderID = @OrderID

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetCustomerByOrgID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetCustomerByOrgID;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 25, 2015
-- Description: Get Customer Information
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_GetCustomerByOrgID]
	@UserID int,
	@OrgID [int] = NULL
AS
	SELECT c.OrgID,Name,ShortName
	  FROM [dbo].[UTP_Customer] c
	  left join UTP_Org o on o.OrgID = c.OrgID
	  where c.[OrgID]=COALESCE(@OrgID,c.[OrgID])




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetCustomerList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetCustomerList;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 07, 2015
-- Description: Get all Customers
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_GetCustomerList]
	@UserID int = NULL
AS
	select OrgID=c.OrgID, Name=o.Name, [ShortName]=o.[ShortName]
		from [dbo].[UTP_Customer] c
		left join [dbo].[UTP_Org] o on o.OrgID = c.OrgID
		order by Name




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetDependantColumns') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetDependantColumns;
GO

-- exec UTP_GetDependentColumns 'pnWOList', 'WONUM', null
CREATE PROC [dbo].[UTP_GetDependantColumns] 
	@PanelName varchar(255), 
	@ColumnName varchar(255),
	@ColumnValue varchar(255) = null,
	@CurrentUserID int = null
as
	
	select 
			p.[PanelColumnID],
			p.[PanelID],
			p.[ColumnName],
			p.[DataAttributeID],
			[DisplayName]=COALESCE(p.[DisplayName],a.[DisplayName]),
			[HelpText]=COALESCE(p.[HelpText],a.[HelpText]),
			[IsActive]=COALESCE(p.[IsActive],a.[IsActive]),
			p.[IsReadOnly],
			p.[IsOptional],
			[IsHidden] = ISNULL(uc.IsHidden,p.[IsHidden]),
			[SortOrder] = ISNULL(uc.SortOrder,p.[SortOrder]),
			[DataTypeID]=COALESCE(p.[DataTypeID],a.[DataTypeID]),
			[Length]=COALESCE(p.[Length],a.[Length]),
			p.[ControlTypeID],
			[LoVKey]=COALESCE(p.[LoVKey],a.[LoVKey]),
			p.[LoVQueryName],
			p.[LoVQueryValueColumn],
			p.[LoVQueryDisplayColumn],
			[DefaultValue]=COALESCE(p.[DefaultValue],a.[DefaultValue]),
			[Description]=COALESCE(p.[Description],a.[Description]),
			p.[LanguageID],
			p.FormatString,
			ColumnWidth = isnull(p.ColumnWidth,uc.ColumnWidth),
			IsFrozen = ISNULL(uc.IsFrozen,0),
			pdc.OverrideValue

	  FROM [dbo].[UTP_PanelColumn] p
			inner join UTP_PanelDependantColumn pdc on p.PanelColumnID = pdc.PanelColumnID
			left join [dbo].[UTP_DataAttribute] a on a.DataAttributeID = p.DataAttributeID
			left join [dbo].[UTP_Panel] pn on pn.PanelID = p.PanelID
			left join [dbo].[UTP_UserColumn] uc on p.PanelColumnID = uc.PanelColumnID
		where p.ColumnName = @ColumnName
			-- pdc.ColumnValue is null means match any value
			-- to match @ColumnValue = null, set pdc.ColumnValue to '(null)'
			and isnull(pdc.ColumnValue,@ColumnValue) = isnull(@ColumnValue,'(null)')


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetDocument') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetDocument;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: Jun 16, 2016
-- Description: Select from table UTP_Document
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetDocument]
	@DocumentID [int] = null
AS
	SELECT [DocumentID]
		  ,[DocumentTypeID]
		  ,[DocumentType]
		  ,[CreatedTimestamp]
		  ,[CreatedByID]
		  ,[CreatedBy]
		  ,[SourceID]
		  ,[Source]
		  ,[Filename]
		  ,[Filetype]
		  ,[Size]
		  ,[DocumentRepositoryID]
		  ,[OrigFilename]
		  ,[AccessedTimestamp]
	  FROM [dbo].[vw_UTP_Document]
	  WHERE DocumentID=COALESCE(@DocumentID,DocumentID)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetGroup') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetGroup;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: Apr 30, 2016
-- Description: Select from table vw_UTP_Group
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetGroup]
	@GroupID [int] = null,
	@GroupTypeID [int] = null,
	@GroupManagerID [int] = null,
	@CurrentUserID [int] = null
AS
	select 
		[GroupID],
		[GroupCode],
		[GroupName],
		[GroupTypeID],
		[GroupType],
		[GroupManagerID],
		[GroupManager],
		[ParentGroupID],
		[ParentGroupName],
		[IsActive],
		[Active]

  FROM [dbo].[vw_UTP_Group]
  where GroupID=COALESCE(@GroupID,GroupID)
	AND GroupTypeID=COALESCE(@GroupTypeID,GroupTypeID)
	and GroupManagerID=COALESCE(@GroupManagerID,GroupManagerID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetGroupChildren') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetGroupChildren;
GO

/*
 exec UTP_GetGroupChildren
 exec UTP_GetGroupChildren 7
 exec UTP_GetGroupChildren 6
 exec UTP_GetGroupChildren 8
 exec UTP_GetGroupChildren 1
 exec UTP_GetGroupChildren 3

 */
CREATE PROC [dbo].[UTP_GetGroupChildren]
	@ParentGroupID int = null,
	@CurrentUserID int = null
as
	SELECT	GroupID,
			GroupCode,
			GroupName
		FROM UTP_GROUP 
		WHERE isnull(ParentGroupID,0) = isnull(@ParentGroupID,0)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetGroupMember') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetGroupMember;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: Apr 30, 2016
-- Description: Select from table vw_UTP_GroupMember
-- exec [UTP_GetGroupMember] 20
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetGroupMember]
	@GroupMemberID [int] = null,
	@GroupID [int] = null,
	@MemberID [int] = null,
	@CurrentUserID [int] = null
AS

	SELECT [GroupMemberID]
		  ,[MemberID]
		  ,[Member]
		  ,[FirstName]
		  ,[LastName]
		  ,[MemberName]
		  ,[JobTitleID]
		  ,[JobTitle]
		  ,[GroupID]
		  ,[GroupCode]
		  ,[GroupName]
		  ,[GroupTypeID]
		  ,[GroupType]
		  ,[GroupManagerID]
		  ,[GroupManager]
		  ,[IsActive]
		  ,[Active]

	  FROM [dbo].[vw_UTP_GroupMember]
	  WHERE GroupMemberID=COALESCE(@GroupMemberID,GroupMemberID)
		and GroupID=COALESCE(@GroupID,GroupID)
		and MemberID=COALESCE(@MemberID,MemberID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetImportTypeList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetImportTypeList;
GO






-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 18, 2016
-- Description:	Retrieves a list of all
--				Template Types in the
--				system
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetImportTypeList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ListID AS ImportTypeId, HelpText AS ImportTypeName
	FROM [UTP_ListMaster]
	WHERE ListKey = 'UTP_OrderType'
	ORDER BY ListID
END










;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetInstructor') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetInstructor;
GO

--exec UTP_GetInstructor 2
CREATE proc [dbo].[UTP_GetInstructor]
	@InstructorID int = null,
	@CurrentUserID int = NULL
as
	select	InstructorID = PersonID, 
			Instructor = PersonName 
		from vw_UTP_JobHistory 
		where JobTitle like '%Instructor%'
			and PersonID = isnull(cast(@InstructorID as varchar(10)),PersonID)
		order by PersonName

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetJobCard') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetJobCard;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 05, 2016
-- Description: Select from table UTP_JobCard
-- exec [UTP_GetJobCard] null, null,163
-- Revisions:
--		24-Oct-2016	JP Filter out Photos
-- ===========================================================
CREATE PROC [dbo].[UTP_GetJobCard]
	@OrderJobCardID [int] = null,
	@DocumentID [int] = null,
	@OrderID [int] = null,
	@CurrentUserID [int] = NULL
AS
IF @OrderJobCardID IS NOT NULL
	SELECT [DocumentID],[DocumentTypeID],[DocumentType],[SourceID],[Source],[Filename],[Filetype],[OrigFilename],[OrderJobCardID],[JobcardLine],[CreatedTimestamp],[CreatedByID],[CreatedBy],
	[TechnicianOnCard],[TechnicianID],[Technician],[ReviewedTimestamp],[ReviewedByID],[ReviewedBy],[DataEntryStatusID],[DataEntryStatus],[WONUMOnCard],[OrderID],[WONUM],[CompletionDateOnCard],[JobCardMemo],[DisplayJobCardLink]
	  FROM [dbo].[vw_UTP_OrderJobcard]
	  WHERE OrderJobCardID=@OrderJobCardID 
	  and FileType not in ('.jpg')
ELSE IF @DocumentID IS NOT NULL AND @OrderID IS NULL
	SELECT [DocumentID],[DocumentTypeID],[DocumentType],[SourceID],[Source],[Filename],[Filetype],[OrigFilename],[OrderJobCardID],[JobcardLine],[CreatedTimestamp],[CreatedByID],[CreatedBy],
	[TechnicianOnCard],[TechnicianID],[Technician],[ReviewedTimestamp],[ReviewedByID],[ReviewedBy],[DataEntryStatusID],[DataEntryStatus],[WONUMOnCard],[OrderID],[WONUM],[CompletionDateOnCard],[JobCardMemo],[DisplayJobCardLink]
	  FROM [dbo].[vw_UTP_OrderJobcard]
	  WHERE DocumentID=@DocumentID 
	  and FileType not in ('.jpg')
ELSE IF @DocumentID IS NOT NULL and @OrderID IS NOT NULL
	SELECT [DocumentID],[DocumentTypeID],[DocumentType],[SourceID],[Source],[Filename],[Filetype],[OrigFilename],[OrderJobCardID],[JobcardLine],[CreatedTimestamp],[CreatedByID],[CreatedBy],
	[TechnicianOnCard],[TechnicianID],[Technician],[ReviewedTimestamp],[ReviewedByID],[ReviewedBy],[DataEntryStatusID],[DataEntryStatus],[WONUMOnCard],[OrderID],[WONUM],[CompletionDateOnCard],[JobCardMemo],[DisplayJobCardLink]
	  FROM [dbo].[vw_UTP_OrderJobcard]
	  WHERE DocumentID=@DocumentID AND OrderID=@OrderID
	  and FileType not in ('.jpg')
ELSE
	SELECT [DocumentID],[DocumentTypeID],[DocumentType],[SourceID],[Source],[Filename],[Filetype],[OrigFilename],[OrderJobCardID],[JobcardLine],[CreatedTimestamp],[CreatedByID],[CreatedBy],
	[TechnicianOnCard],[TechnicianID],[Technician],[ReviewedTimestamp],[ReviewedByID],[ReviewedBy],[DataEntryStatusID],[DataEntryStatus],[WONUMOnCard],[OrderID],[WONUM],[CompletionDateOnCard],[JobCardMemo],[DisplayJobCardLink]
	  FROM [dbo].[vw_UTP_OrderJobcard]
	  WHERE OrderID=@OrderID
	  and FileType not in ('.jpg')

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetJobHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetJobHistory;
GO

-- ===========================================================
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetJobHistory]
	@JobHistoryID int = null,
	@JobTitleID int = null,
	@PersonID int = NULL,
	@CurrentUserID int = NULL
AS
	select 
			JobHistoryID, 
			PersonID,
			PersonName,
			JobTitleID,
			JobTitle,
			EffectiveFromDate,
			EffectiveToDate

  FROM vw_UTP_JobHistory
  where JobHistoryID=ISNULL(@JobHistoryID,JobHistoryID)
	and JobTitleID=ISNULL(@JobTitleID,JobTitleID)
	and PersonID=ISNULL(@PersonID,PersonID)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetJobRequirement') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetJobRequirement;
GO

CREATE PROC [dbo].[UTP_GetJobRequirement]
	@JobRequirementID int = NULL,
	@JobTitleID int = NULL,
	@TestID int = NULL,
	@CurrentUserID int = NULL
as
	SELECT [JobRequirementID]
		  ,[JobTitleID]
		  ,[JobTitle]
		  ,[TestID]
		  ,[TestCode]
		  ,[TestTitle]
		  ,[EffectiveFromDate]
		  ,[EffectiveToDate]
	  FROM vw_UTP_JobRequirement
	  WHERE JobRequirementID=ISNULL(@JobRequirementID,JobRequirementID)
		and JobTitleID=ISNULL(@JobTitleID,JobTitleID)
		and TestID=ISNULL(@TestID,TestID)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetLocation') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetLocation;
GO

CREATE PROCEDURE [dbo].[UTP_GetLocation]
	@LocationID int = NULL,
	@GroupID int = NULL,
	@CurrentUserID int = NULL
as
	SELECT [LocationID]
		  ,[GroupID]
		  ,[GroupCode]
		  ,[GroupName]
		  ,[LocationTypeID]
		  ,[LocationType]
		  ,[Location]
		  ,[StartDate]
		  ,[EndDate]

	  FROM [dbo].[vw_UTP_Location]
	  WHERE LocationID = ISNULL(@LocationID,LocationID)
		AND GroupID = ISNULL(@GroupID,GroupID)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetOpenAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetOpenAppointment;
GO
CREATE procedure [dbo].[UTP_GetOpenAppointment]
	@OrderID int

as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetOpenAppointment'
	set @Identifier = 'OrderID= ' + cast(@OrderID as varchar(20))
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	--get latest open appt
	select top 1
			AppointmentID = a.AppointmentID,
			AppointmentTypeID = a.AppointmentTypeID,
			AppointmentType = at.ListText,
			AppointmentStatusID = a.AppointmentStatusID,
			AppointmentStatus = st.ListText,
			ApptStartDate = a.ApptStartDate,
			ApptEndDate = a.ApptEndDate,
			ApptStartTime = a.ApptStartTime,
			ApptEndTime = a.ApptEndTime, 
			IsFirmAppt = a.IsFirmAppt,
			TimeSlotID = isnull(a.TimeslotID,90306),
			Timeslot = ts.ListText,
			TechnicianID = isnull(a.TechnicianID,-1),
			ContactID = c.ContactID,
			SpecialInstructions = isnull(a.SpecialInstructions,''),
			AccessRestricted = isnull(a.AccessRestricted,0),
			MedicalNecessity = isnull(a.MedicalNecessity,0),
			EmailConfirmation = isnull(cast(case when PreferredContactModeID = 90361 then 1 else 0 end as bit),''),
			CustomerName = isnull(c.ContactName,wo.CustomerName),
			Phone = isnull(c.ContactPhone,wo.CustomerPhone),
			AlternatePhone = isnull(c.ContactAlternatePhone,''),
			Email = isnull(c.ContactEmail,'')
			-- select *
		from vw_UTP_WO wo
			left join UTP_Appointment a on wo.OrderID = a.OrderID
			left join UTP_Contact c on a.ContactID = c.ContactID
			left join UTP_ListMaster ts on isnull(a.TimeslotID,90306) = ts.ListID
			left join UTP_ListMaster at on a.AppointmentTypeID = at.ListID
			left join UTP_ListMaster st on a.AppointmentStatusID = st.ListID
		where wo.OrderID = @OrderID
			and isnull(a.AppointmentStatusID,90320) in (90320, 90321, 90329)  -- ready, booked, reserved
		order by AppointmentID desc

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetOrderAttachment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetOrderAttachment;
GO
-- ===========================================================
-- Author: John Peacock
-- Create date: May 22, 2016
-- Description: 
-- exec [UTP_GetOrderAttachment_1] 153087, 1
-- Revisions:
--		7-Oct-2016	JRP		Patch to provide OrigFilename when blank
-- ===========================================================
CREATE PROC [dbo].[UTP_GetOrderAttachment]
	@OrderID int,
	@CurrentUserID int
as

	select	oa.OrderID,
			oa.DocumentID,
			DocumentTypeID,
			OrigFilename = case when isnull(OrigFilename,'') = '' then cast(oa.DocumentID as varchar(20)) + cast(isnull(Filetype,'') as varchar(10)) else OrigFilename end,
			d.CreatedTimestamp,
			d.CreatedByID,
			AccessedTimestamp,
			SourceID,
			Filename,
			Filetype,
			Size,
			ListValue = Filename + Filetype,
			ListText = 'ID: ' + cast(oa.DocumentID as varchar(10)) 
						+ ' / ' + dbo.fnUTP_SelectListMaster(isnull(jc.JobCardTypeID,d.DocumentTypeID)) 
						+ ' / ' + case when isnull(OrigFilename,'') = '' then cast(oa.DocumentID as varchar(20)) + cast(isnull(Filetype,'') as varchar(10)) else OrigFilename end
			
		from UTP_Document d
			inner join UTP_OrderAttachment oa on oa.DocumentID = d.DocumentID 
			left join UTP_OrderJobCard jc on d.DocumentID = jc.DocumentID and oa.OrderID = jc.OrderID
		where oa.OrderID = @OrderID

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetOrderHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetOrderHistory;
GO
-- =============================================
-- Author:		Jeff Moretti
-- Create date: June 30, 2016
-- exec UTP_GetOrderHistory null, 165
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetOrderHistory]
	@OrderHistoryID INT = NULL,
	@OrderID INT = NULL,
	@MemoType varchar(20) = NULL,
	@CurrentUserID INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [OrderHistoryID]
		  ,[OrderID]
		  ,[WOID]
		  ,[WONUM]
		  ,[MemoTypeID]
		  ,[MemoType]
		  ,[Memo]
		  ,[CreatedByID]
		  ,[CreatedBy]
		  ,[CreatedTimestamp]
		  ,[TechnicianID]
		  ,[Technician]
		  ,[OrderStatusCode]
		  ,[StatusTimestamp]

		FROM [dbo].[vw_UTP_OrderHistory]
		WHERE OrderHistoryID = isnull(@OrderHistoryID,OrderHistoryID)
			AND OrderID = isnull(@OrderID,OrderID)
			AND MemoType = isnull(@MemoType,MemoType)
		ORDER BY OrderHistoryID desc
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetOrgPermission') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetOrgPermission;
GO

-- exec [UTP_GetOrgPermission] 1,1
-- ===========================================================
-- Author: JRP
-- Create date: Mar 14, 2016
-- Description: Get from UTP_OrgPermission by OrgID and/or UserID
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetOrgPermission]
	@OrgID [int] = null,
	@UserID [int] = null
AS
	SELECT 
		[OrgPermissionID],
		op.[OrgID],
--		ShortName,
		op.[UserID],
--		UserName,
		[View],
		[Add],
		[Edit],
		[Delete],
		[Duplicate],
		[Submit]

  FROM [dbo].[UTP_OrgPermission] op
	inner join UTP_Org o on op.OrgID = o.OrgID
	inner join UTP_User u on op.UserID = u.UserID
  WHERE op.OrgID=COALESCE(@OrgID,op.OrgID)
	and op.UserID=COALESCE(@UserID,op.UserID)





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetPanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetPanelColumn;
GO

-- ===========================================================
-- Create date: Nov 03, 2015
-- Description: Select from table UTP_PanelColumn with defaults from DataAttribute
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetPanelColumn]
	@UserID int, @PanelColumnID [int] = NULL
AS
	select 
		p.[PanelColumnID],
		p.[PanelID],
		p.[ColumnName],
		p.[DataAttributeID],
		[DisplayName]=COALESCE(p.[DisplayName],a.[DisplayName]),
		[HelpText]=COALESCE(p.[HelpText],a.[HelpText]),
		[IsActive]=COALESCE(p.[IsActive],a.[IsActive]),
		p.[IsReadOnly],
		p.[IsOptional],
		p.[IsHidden],
		p.[SortOrder],
		[DataTypeID]=COALESCE(p.[DataTypeID],a.[DataTypeID]),
		[Length]=COALESCE(p.[Length],a.[Length]),
		p.[ControlTypeID],
		[LoVKey]=COALESCE(p.[LoVKey],a.[LoVKey]),
		p.[LoVQueryName],
		p.[LoVQueryValueColumn],
		p.[LoVQueryDisplayColumn],
		[DefaultValue]=COALESCE(p.[DefaultValue],a.[DefaultValue]),
		[Description]=COALESCE(p.[Description],a.[Description]),
		p.[LanguageID],
		p.FormatString,
		p.ColumnWidth

  FROM [dbo].[UTP_PanelColumn] p
	left join [dbo].[UTP_DataAttribute] a on a.DataAttributeID = p.DataAttributeID
   where PanelColumnID=COALESCE(@PanelColumnID,PanelColumnID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetPanelColumnByPanelID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetPanelColumnByPanelID;
GO


-- ===========================================================
-- Create date: Nov 16, 2015
-- Description: Select from table UTP_PanelColumn with defaults from DataAttribute
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetPanelColumnByPanelID]
	@UserID int,@PanelID int=NULL,@ColumnName varchar(255)=NULL,@IsActive bit=null,@IsHidden bit=null
AS
	select 
		p.[PanelColumnID],
		p.[PanelID],
		p.[ColumnName],
		p.[DataAttributeID],
		[DisplayName]=COALESCE(p.[DisplayName],a.[DisplayName]),
		[HelpText]=COALESCE(p.[HelpText],a.[HelpText]),
		[IsActive]=COALESCE(p.[IsActive],a.[IsActive]),
		p.[IsReadOnly],
		p.[IsOptional],
		p.[IsHidden],
		p.[SortOrder],
		[DataTypeID]=COALESCE(p.[DataTypeID],a.[DataTypeID]),
		[Length]=COALESCE(p.[Length],a.[Length]),
		p.[ControlTypeID],
		[LoVKey]=COALESCE(p.[LoVKey],a.[LoVKey]),
		p.LoVQueryName,
		p.LoVQueryValueColumn,
		p.LoVQueryDisplayColumn,
		[DefaultValue]=COALESCE(p.[DefaultValue],a.[DefaultValue]),
		[Description]=COALESCE(p.[Description],a.[Description]),
		p.[LanguageID],
		p.FormatString,
		p.ColumnWidth

  FROM [dbo].[UTP_PanelColumn] p
	left join [dbo].[UTP_DataAttribute] a on a.DataAttributeID = p.DataAttributeID
	left join [dbo].[UTP_Panel] pn on pn.PanelID = p.PanelID
	where  p.[PanelID]=COALESCE(@PanelID,p.[PanelID]) and [ColumnName]=COALESCE(@ColumnName,[ColumnName])
		and COALESCE(@IsActive,COALESCE(p.[IsActive],a.[IsActive]))=COALESCE(p.[IsActive],a.[IsActive]) and COALESCE(@IsHidden,IsHidden)=IsHidden


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetPanelColumnByPanelName') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetPanelColumnByPanelName;
GO

-- ===========================================================
-- Create date: Nov 03, 2015
-- Description: Select from table UTP_PanelColumn with defaults from DataAttribute
-- exec UTP_GetPanelColumnByPanelName null, 'pnEGD_WO', null, 1, 0
-- Revisions:
--      Feb 03, 2016 DM - as updated by JRP
--      May 23, 2016 JP - Change UserID to CurrentUserID
--		19-Feb-2017	 JP - Add User-defined column width
-- ===========================================================
CREATE PROC [dbo].[UTP_GetPanelColumnByPanelName]
	@UserID int=NULL,
	@PanelName varchar(255)=NULL,
	@ColumnName varchar(255)=NULL,
	@IsActive bit=1,
	@IsHidden bit=0
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetPanelColumnByPanelName'
	set @Identifier = @PanelName
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	select 
		p.[PanelColumnID],
		p.[PanelID],
		p.[ColumnName],
		p.[DataAttributeID],
		[DisplayName]=COALESCE(p.[DisplayName],a.[DisplayName]),
		[HelpText]=COALESCE(p.[HelpText],a.[HelpText]),
		[IsActive]=COALESCE(p.[IsActive],a.[IsActive]),
		p.[IsReadOnly],
		p.[IsOptional],
		[IsHidden] = ISNULL(uc.IsHidden,p.[IsHidden]),
		[SortOrder] = ISNULL(uc.SortOrder,p.[SortOrder]),
		[DataTypeID]=COALESCE(p.[DataTypeID],a.[DataTypeID]),
		[Length]=COALESCE(p.[Length],a.[Length]),
		p.[ControlTypeID],
		[LoVKey]=COALESCE(p.[LoVKey],a.[LoVKey]),
		p.[LoVQueryName],
		p.[LoVQueryValueColumn],
		p.[LoVQueryDisplayColumn],
		[DefaultValue]=COALESCE(p.[DefaultValue],a.[DefaultValue]),
		[Description]=COALESCE(p.[Description],a.[Description]),
		p.[LanguageID],
		p.[FormatString],
		[ColumnWidth] = ISNULL(uc.ColumnWidth,p.ColumnWidth),
		IsFrozen = ISNULL(uc.IsFrozen,0)

  FROM [dbo].[UTP_PanelColumn] p
	left join [dbo].[UTP_DataAttribute] a on a.DataAttributeID = p.DataAttributeID
	left join [dbo].[UTP_Panel] pn on pn.PanelID = p.PanelID
	left join [dbo].[UTP_UserColumn] uc on p.PanelColumnID = uc.PanelColumnID and uc.UserID=@UserID
	where [PanelName]=COALESCE(@PanelName,[PanelName]) 
		and [ColumnName]=COALESCE(@ColumnName,[ColumnName])
		and COALESCE(@IsActive,1,COALESCE(p.[IsActive],a.[IsActive]))=COALESCE(p.[IsActive],a.[IsActive]) 
		and COALESCE(@IsHidden,0,uc.IsHidden,p.IsHidden)=p.IsHidden
	order by p.SortOrder

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetPanelPermission') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetPanelPermission;
GO



-- exec [UTP_GetPanelPermission] null,1
-- ===========================================================
-- Author: JRP
-- Create date: Mar 14, 2016
-- Description: Get from UTP_PanelPermission by PanelID and/or UserID
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetPanelPermission]
	@PanelID [int] = null,
	@UserID [int] = null
AS

	INSERT [UTP_PanelPermission] ([PanelID],[UserID],[View],[Add],[Edit],[Delete],[Duplicate],[Submit])
	SELECT 
		p.[PanelID],
		u.[UserID],
		[View] = isnull([View],0),
		[Add] = isnull([Add],0),
		[Edit] = isnull([Edit],0),
		[Delete] = isnull([Delete],0),
		[Duplicate] = isnull([Duplicate],0),
		[Submit] = isnull([Submit],0)

  FROM UTP_Panel p
	cross join UTP_User u 
	left join [dbo].[UTP_PanelPermission] pp on pp.PanelID = p.PanelID and pp.UserID = u.UserID
  WHERE p.PanelID=COALESCE(@PanelID,p.PanelID)
	and u.UserID=COALESCE(@UserID,u.UserID)
	and pp.PanelID is null

	SELECT 
		[PanelPermissionID],
		p.[PanelID],
		PanelName,
		u.[UserID],
		UserName,
		[View] = isnull([View],0),
		[Add] = isnull([Add],0),
		[Edit] = isnull([Edit],0),
		[Delete] = isnull([Delete],0),
		[Duplicate] = isnull([Duplicate],0),
		[Submit] = isnull([Submit],0)

  FROM UTP_Panel p
	cross join UTP_User u 
	left join [dbo].[UTP_PanelPermission] pp on pp.PanelID = p.PanelID and pp.UserID = u.UserID
  WHERE p.PanelID=COALESCE(@PanelID,p.PanelID)
	and u.UserID=COALESCE(@UserID,u.UserID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetPerson') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetPerson;
GO

-- ===========================================================
-- Author: JRP
-- Create date: Apr 26, 2016
-- Description: Select from table UTP_Person
-- exec [UTP_GetPerson]
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetPerson]
	@PersonID [int] = null,
	@CurrentUserID int = null
AS
	select 
		[PersonID],
		[PersonTypeID],
		[PersonType],
		[FirstName],
		[LastName],
		[Description],
		[PhoneEmailID],
		[CellPhone],
		[Pager],
		[HomePhone],
		[OfficePhone],
		[Email],
		[BusinessName]

  FROM [dbo].[vw_UTP_Person]
  where PersonID=COALESCE(@PersonID,PersonID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetPersonByName') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetPersonByName;
GO
-- ===========================================================
-- Create date: Dec 29, 2015
-- Description: Select from table UTP_Person
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetPersonByName]
	@PersonID [int] = null,@FirstName [varchar] (255) = null,@LastName [varchar] (255) = null
AS
	select 
		[PersonID],
		[PersonTypeID],
		[FirstName],
		[LastName],
		[Description],
		[PhoneEmailID],
		[BusinessName],
		[FirstNameLastName] = FirstName+' '+LastName,
		[LastNameFirstName] = LastName + ', ' + FirstName

  FROM [dbo].[UTP_Person]
  where PersonID=COALESCE(@PersonID,PersonID)
	and FirstName=COALESCE(@FirstName,FirstName)
	and LastName=COALESCE(@LastName,LastName)
order by LastName + ', ' + FirstName, PersonID

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetProjectList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetProjectList;
GO




-- =============================================
-- Author:		Jeff Moretti
-- Create date: July 6 2017
-- Description:	Gets list of Projects stored
--				in DB
-- 08/22/17 JLM:Added OrgID field to the select
--				query
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetProjectList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT ContractID, ContractName, OrgID
	FROM UTP_Contract
	WHERE ContractTypeID = 240000 -- Project Type
	AND IsActive = 1
	ORDER BY ContractID
END





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetRelatedWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetRelatedWO;
GO
-- =============================================
-- Author:		John Peacock
-- Create date: July 2, 2016
-- Description:	
-- Revisions:
--		15-OCt-2016		Add logging
--		24-May-2017	JP	Include returned RR WO
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetRelatedWO]
	@PrimaryOrderID int = null,
	@RelatedOrderID int = null,
	@CurrentUserID int = null
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetRelatedWO:'
				+ ' @RelatedOrderID=' + isnull(cast(@RelatedOrderID as varchar(10)),'null')
	set @Identifier = cast(@PrimaryOrderID as varchar(20))
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on	DECLARE @OrderID int
	SELECT @OrderID = PrimaryOrderID from [vw_UTP_RelatedWO] where RelatedOrderID = @PrimaryOrderID

	DECLARE @rwo UTP_RelatedWOType

	INSERT INTO @rwo ([PrimaryOrderID],[RelatedOrderID],[RelationTypeID],[RelationType])
	SELECT wos.[PrimaryOrderID],wos.[RelatedOrderID],wos.[RelationTypeID],lm.[ListValue]
		FROM [dbo].[UTP_WOStructure] wos
		JOIN [dbo].[UTP_ListMaster] lm ON lm.[ListID]=wos.[RelationTypeID]
		WHERE wos.[PrimaryOrderID] = @PrimaryOrderID
			or wos.[PrimaryOrderID] in (select [RelatedOrderID] from UTP_WOStructure where [PrimaryOrderID] = @PrimaryOrderID)
			or wos.[PrimaryOrderID] in (select [PrimaryOrderID] from UTP_WOStructure where [RelatedOrderID] = @PrimaryOrderID)

	IF @OrderID IS NOT NULL
		INSERT INTO @rwo ([PrimaryOrderID],[PrimaryWOID],[PrimaryWONUM],[RelatedOrderID],[RelationTypeID],[RelationType])
		VALUES (0,0,'',@OrderID,0,'P')

	UPDATE @rwo SET PrimaryWOID=wo.[uWOID],PrimaryWONUM=wo.[WONUM]
		FROM @rwo rw 
		JOIN [dbo].[UTP_WO] wo ON wo.[OrderID]=rw.[PrimaryOrderID] 
		where rw.[PrimaryWOID] IS NULL

	UPDATE @rwo SET RelatedWOID=wo.[uWOID],RelatedWONUM=wo.[WONUM],ChildJobCodeID=wo.[JobCodeID],ChildJobCode=NULL,ChildAPEQType=NULL,
		ChildActualStart=wo.[ActualStart],ChildActualFinish=wo.[ActualFinish],ChildCompletionCode=wo.[CompletionCode],
		ChildTechnicianID=wo.[TechnicianID],ChildTechnician=u.[Username]
		FROM @rwo rw
		JOIN [dbo].[UTP_WO] wo ON wo.[OrderID]=rw.[RelatedOrderID]
		LEFT JOIN [dbo].[UTP_User] u ON u.[UserID]=wo.[TechnicianID]
		WHERE rw.[RelatedWOID] IS NULL

	IF @RelatedOrderID IS NOT NULL
		SELECT [PrimaryOrderID]
				,[PrimaryWOID]
				,[PrimaryWONUM]
				,[RelatedOrderID]
				,[RelatedWOID]
				,[RelatedWONUM]
				,[RelationTypeID]
				,[RelationType]
				,[ChildJobCodeID]
				,[ChildJobCode]
				,[ChildAPEQTYPE]
				,[ChildActualStart]
				,[ChildActualFinish]
				,[ChildCompletionCode]
				,[ChildTechnicianID]
				,[ChildTechnician]
			FROM @rwo WHERE [RelatedOrderID]=@RelatedOrderID
	ELSE
		SELECT [PrimaryOrderID]
				,[PrimaryWOID]
				,[PrimaryWONUM]
				,[RelatedOrderID]
				,[RelatedWOID]
				,[RelatedWONUM]
				,[RelationTypeID]
				,[RelationType]
				,[ChildJobCodeID]
				,[ChildJobCode]
				,[ChildAPEQTYPE]
				,[ChildActualStart]
				,[ChildActualFinish]
				,[ChildCompletionCode]
				,[ChildTechnicianID]
				,[ChildTechnician]
			FROM @rwo

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetRelightDates') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetRelightDates;
GO
--select * from egd_WO where WONUM='15861904'

/****** Object:  StoredProcedure [dbo].[UTP_GetRelightDates]    Script Date: 2017-04-10 9:56:53 PM ******/

-- ===========================================================
-- Create date: Jan 14, 2015 -- from JRP_20160104
-- Description: 
-- exec UTP_GetRelightDates 311500, '4/18/2017','4/18/2017'
-- exec UTP_GetRelightDates 37901, '4/18/2017','4/18/2017'
-- Revisions:
--		21-Apr-2016		JRP		TechnicianID DCR
--		09-Oct-2016		IDM		Correct Date/Datetime comparison
-- ===========================================================
CREATE procedure [dbo].[UTP_GetRelightDates]
	@OrderID int,
	@FromDate datetime = null,
	@ToDate datetime = null,
	@TechnicianID int = null,
	@CurrentUserID int = null

as
begin
	declare @Window int  = 14, --days
			@GroupID int,
			@Hour int,
			@Grid varchar(30)
	declare @Dates table (WorkDate date)
	
	declare @FirstDate Date, @EndDate Date, @Date date
	SELECT @FirstDate=CAST(ISNULL(@FromDate,GETDATE()) AS DATE),
		   @EndDate=CAST(ISNULL(@ToDate,DATEADD(d,@Window,GETDATE())) AS DATE)
	select @Date = @FirstDate
	while @Date <= @EndDate
		begin
		insert @Dates (Workdate) values (@Date)
		set @Date = dateadd(d,1,@Date)
		end	

	set @Hour = datepart(hh,getdate())

	select  @GroupID = GroupID,
			@Grid = Grid
		from vw_UTP_WO
		where OrderID = @OrderID

	print @Grid
	
	--if @Hour >= 16
	select 
			w.WorkDate,
			TechnicianID = t.[UserID],
			Technician = u.Username,
			whe=1

		from UTP_WorkSchedule w
			inner join UTP_Technician t on w.UserID = t.UserID
			inner join UTP_User u on w.UserID = u.UserID
			left join UTP_Location l on w.GroupID = l.GroupID
			left join UTP_Group g on l.GroupID = g.GroupID
		where w.WorkDate between @FirstDate AND @EndDate
			and t.TechnicianID = isnull(@TechnicianID, t.TechnicianID)
			and g.ParentGroupID = @GroupID
			and isnull(l.Location,@Grid) = @Grid
			and w.TimeSlotID = 90307
	union
	select WorkDate, -1, '(not set)',2 from @Dates
	--union
	--	select distinct 
	--		WorkDate,
	--		TechnicianID = t.[UserID],
	--		Technician = u.Username,
	--		3
	--	--	select *
	--		from @Dates cross join vw_UTP_Technician t inner join UTP_User u on t.UserID = u.UserID
	--		where t.UserTypeID = [dbo].[fnUTP_GetListMaster]('UserType','Technician')
	--		--	and (GroupID is null or GroupID = isnull(@GroupID,GroupID))
	--			and u.IsActive = 1
	order by whe
end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetRelightSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetRelightSchedule;
GO

-- exec UTP_GetRelightSchedule
Create proc [dbo].[UTP_GetRelightSchedule]
	@GroupID int = null,
	@CurrentUserID int = null
as
	select	g.GroupID,
			GroupCode = isnull(g.GroupCode,'(null)'),
			WorkDate,
			TechnicianID = ws.UserID,
			ws.Capacity

		from UTP_Group g
			left join UTP_WorkSchedule ws on g.GroupID = ws.GroupID and ws.ScheduleTypeID = dbo.fnUTP_GetListMaster('ScheduleType','AfterHoursRelight')
		where g.GroupTypeID = dbo.fnUTP_GetListMaster('GroupType','District')


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetSearchJobCard') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetSearchJobCard;
GO

CREATE PROC [dbo].[UTP_GetSearchJobCard]
	@CurrentUserID int = NULL
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetSearchJobCard'
	select @Identifier = 'Multiple'

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	SELECT TOP 1
		   [DocumentID]
		  ,[DocumentTypeID]
		  ,[DocumentType]
		  ,[SourceID]
		  ,[Source]
		  ,[Filename]
		  ,[Filetype]
		  ,[OrigFilename]
		  ,[OrderJobCardID]
		  ,[JobcardLine]
		  ,[CreatedFromTimestamp]
		  ,[CreatedToTimestamp]
		  ,[CreatedByID]
		  ,[CreatedBy]
		  ,[TechnicianOnCard]
		  ,[TechnicianID]
		  ,[Technician]
		  ,[ReviewedTimestamp]
		  ,[ReviewedByID]
		  ,[ReviewedBy]
		  ,[DataEntryStatusID]
		  ,[DataEntryStatus]
		  ,[WONUMOnCard]
		  ,[WONUM]
		  ,[OrderID]
		  ,[DisplayAddress]
		  ,[CompletedFromDatetime]
		  ,[CompletedToDatetime]
		  ,[JobCardMemo]
		  ,[CollectionName] = cast('' as varchar(255))
		  ,[CollectionID] = cast(0 as bigint)

	  FROM [dbo].[vw_UTP_SearchJobCard]

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel


/****** Object:  StoredProcedure [dbo].[UTP_SearchJobCard]    Script Date: 2017-01-08 9:28:55 AM ******/
SET ANSI_NULLS ON

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetSpec') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetSpec;
GO
-- =============================================
-- Author:		Jeff Moretti
-- Create date: June 30, 2016
-- exec [UTP_GetSpec] 86
-- Description:	<Description,,>
-- Revisions:
--   20180920  dm cast DefaultValue to varchar(255)
--   20181004  dm Get DefaultValue from UTP_Attribute
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetSpec]
	-- Add the parameters for the stored procedure here
	@OrderID INT
AS
BEGIN
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetSpec'
	set @Identifier = cast(@OrderID as varchar(20))
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	DECLARE @WOID int,
			@OrgShortName varchar(50)

	SELECT @OrgShortName = ShortName from UTP_Org c inner join UTP_Order o on c.OrgID = o.OrgID where o.OrderID = @OrderID
	SELECT
		SpecID,
		--OrderID,
		--s.DataAttributeID,
		--ProductID,
		--AppointmentID = 0,
		AttributeName = da.AttributeName,
		AttributeValue,
		DefaultValue = CONVERT(varchar(255),COALESCE(da.DefaultValue,'')),
		DataType = 'System.String' ,
		Caption = da.DisplayName,
		HelpText = isnull(da.HelpText,da.DisplayName),
		MaxLength = 255, -- da.Length,
		SortOrder = 0,
		LoVKey = cast(da.LoVKey as varchar(255)),
		LoVQueryName = cast(null as varchar(255)),
		QueryDisplayMember = cast(null as varchar(255)),
		QueryValueMember = cast(null as varchar(255)),
		ControlType = 70101,
		IsHidden = 0,
		IsOptional = case when IsRequired = 1 then 0 else 1 end,
		IsOptional2 = 1,
		IsReadOnly = isnull(IsReadony,0)

	FROM UTP_Spec s
		inner join UTP_DataAttribute da on s.DataAttributeID = da.DataAttributeID
	--	left join UTP_Appointment a on s.AppointmentID = a.AppointmentID
	WHERE OrderID = @OrderID

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetStagingData') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetStagingData;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 26, 2016
-- Description:	Retrieves data in staging
--				table (that will later be
--				inserted into actual table)
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetStagingData]
	@ImportBatchID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
	   [Col1]
      ,[Col2]
      ,[Col3]
      ,[Col4]
      ,[Col5]
      ,[Col6]
      ,[Col7]
      ,[Col8]
      ,[Col9]
      ,[Col10]
      ,[Col11]
      ,[Col12]
      ,[Col13]
      ,[Col14]
      ,[Col15]
      ,[Col16]
      ,[Col17]
      ,[Col18]
      ,[Col19]
      ,[Col20]
      ,[Col21]
      ,[Col22]
      ,[Col23]
      ,[Col24]
      ,[Col25]
      ,[Col26]
      ,[Col27]
      ,[Col28]
      ,[Col29]
      ,[Col30]
	FROM UTP_ImportData
	WHERE ImportBatchID = @ImportBatchID
	ORDER BY ImportDataID
END





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetStandardMemoList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetStandardMemoList;
GO

-- exec UTP_GetStandardMemoList 1008
CREATE PROC [dbo].[UTP_GetStandardMemoList]
	@MemoTypeID int = 1008,
	@CurrentUserID int = null
as
	declare @MemoType varchar(10)
	select @MemoType = ListValue from UTP_ListMaster where ListID = @MemoTypeID
	select	ListID,
			ListValue,
			ListText
		from UTP_ListMaster
		where ListKey = 'StandardMemoList' + @MemoType
			and IsActive=1
		order by SortOrder

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetTask') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetTask;
GO


CREATE PROCEDURE [dbo].[UTP_GetTask]
	@TaskID int = null,
	@TaskTypeID int = null,
	@CurrentUserID int = null
as
SELECT [TaskID]
      ,[TaskTypeID]
      ,[TaskType]
      ,[TaskNumber]
      ,[TaskDescription]
      ,[TaskStatusID]
      ,[TaskStatus]
      ,[TaskPriorityID]
      ,[TaskPriority]
      ,[DueDate]
      ,[CreatedTimestamp]
      ,[CreatedByID]
      ,[CreatedBy]
      ,[TaskManagerID]
      ,[TaskManager]
      ,[Category]
      ,[Scope]
      ,[ProjectNumber]
      ,[RaisedDate]
      ,[RaisedBy]
      ,[TargetStart]
      ,[TargetFinish]
	  ,[AssignedToID]
	  ,[AssignedTo]
	  ,[AssignedDate]
      ,[ActualStart]
      ,[ActualFinish]
      ,[CompletedByID]
      ,[CompletedBy]
      ,[CompletionCode]
      ,[EstimatedDuration]
      ,[ActualDuration]
      ,[Instructions]
      ,[Notes]
      ,[FollowupDate]
      ,[FollowupAction]
      ,[FollowupFreqID]
      ,[FollowupFreq]
      ,[CostCenter]
  FROM [vw_UTP_Task]
  WHERE TaskID = isnull(@TaskID,TaskID)
	and TaskTypeID = isnull(@TaskTypeID,TaskTypeID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetTaskHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetTaskHistory;
GO

CREATE PROCEDURE [dbo].[UTP_GetTaskHistory]
	@TaskHistoryID int = null,
	@TaskID int = null,
	@MemoTypeID int = null,
	@CurrentUserID int = null
AS
SELECT [TaskHistoryID]
      ,[TaskID]
      ,[CreatedTimestamp]
      ,[CreatedByID]
      ,[CreatedBy]
      ,[Memo]
      ,[MemoTypeID]
      ,[MemoType]
      ,[AssignedToID]
	  ,[AssignedTo]
      ,[ActualDuration]
  FROM [vw_UTP_TaskHistory]
  WHERE TaskHistoryID = isnull(@TaskHistoryID,TaskHistoryID)
	and TaskID = isnull(@TaskID,TaskID)
	and MemoTypeID = isnull(@MemoTypeID,MemoTypeID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetTechnician;
GO
--select * from UTP_User where UserID=7
-- select * from UTP_Group g inner join UTP_GroupMember gm on g.groupid = gm.groupid where g.groupid=19
-- exec [UTP_GetTechnician] @GroupID = 1, @Workdate='9/26/2016', @TimeslotID = 90302
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Dec 08, 2015
-- Description: Get all Technicians
-- Revisions: 
--		9-Apr-2016	JP	Add parameters @Workdate & @timeslotID to limit to Techs NOT in
--						workschedule for that timeslot
--						Still have to fix up the technican table, or drop it
-- ====================================================================================
CREATE PROC [dbo].[UTP_GetTechnician]
	@TechnicianID [int] = null,
	@UserID [int] = null,
	@GroupID [int] = null,
	@Workdate date = null,
	@TimeslotID int = null,
	@CurrentUserID [int] = null

AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetTechnician:'
							+ ' TechnicianID=' + isnull(cast(@TechnicianID as varchar(6)),'null')
							+ ', GroupID=' + isnull(cast(@GroupID as varchar(6)),'null')
	set @Identifier = 'UserID=' + isnull(cast(@UserID as varchar(20)),'null')
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier
	declare @GroupCode varchar(10) = null
	select @GroupCode = GroupCode from UTP_Group where GroupID = @GroupID

	select [TechnicianID],
			[GroupID],
			[GroupCode],
			[GroupName],
			[GroupMemberID],
			UserID,
			UserTypeID,
			Username,
			[Password],
			[TechnicianTypeID],
			[GSTNo],
			[PerformanceFactor],
			[Comments],
			[InsuranceNum],
			[InsuranceExpDate],
			[LicenceNum],
			[LicenceExpDate],
			[HasHandHeld],
			[PersonID],
			[PersonTypeID],
			[FirstName],
			[LastName],
			[Description],
			[BusinessName],	
			[PhoneEmailID],
			[CellPhone],
			[Pager],
			[HomePhone],
			[OfficePhone],
			[Email],
			[FirstNameLastName],
			[LastNameFirstName],
			DisplayName = isnull(DisplayName,'(Not set)')
		-- select * 
		from vw_UTP_Technician vt
		where TechnicianID = COALESCE(@TechnicianID,TechnicianID)
			and (@GroupCode is null 
				or @GroupCode in ('10','20','30','40','50','60','70','80') 
				or (GroupID = @GroupID and UserID in (Select MemberID from UTP_GroupMember gm inner join UTP_Group g on gm.GroupID = g.GroupID where g.GroupID = @GroupID)))
			and (@Workdate is null 
				or @Workdate is not null and UserID not in (Select UserID from UTP_WorkSchedule where GroupID = @GroupID and Workdate = @Workdate and TimeslotID = isnull(@TimeslotID,TimeslotID)))
		order by left(Username,4), substring(Username,5,5) 

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetTechnicianList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetTechnicianList;
GO

-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Dec 08, 2015
-- Description: Get all Technicians
-- exec [UTP_GetTechnicianList]
-- Revisions: Jan 14/16 - default values
--		21-Apr-2016		JRP		TechnicianID DCR
-- ====================================================================================
CREATE PROC [dbo].[UTP_GetTechnicianList]
	@TechnicianID [int] = null
AS
	select t.[TechnicianID],
		u.[PersonID],
		t.[TechnicianTypeID],
		t.[HasHandHeld],
		p.[FirstName],
		p.[LastName],
		p.[Description],
		[FirstNameLastName] = p.FirstName+' '+ p.LastName,
		[LastNameFirstName] = p.LastName + ', ' + p.FirstName

		from [dbo].[UTP_Technician] t
			left join UTP_User u on t.TechnicianID = u.UserID
			left join UTP_Person p on p.PersonID = u.PersonID
		where TechnicianID=COALESCE(@TechnicianID,TechnicianID)

	union

	select TechnicianID = 0,
		PersonID = 0,
		TechnicianTypeID = 0,
		HH = 0,
		FirstName = null,
		LastName = null,
		Description = null,
		FirstNameLastName = '(any)',
		LastNameFirstName = '(any)'

	order by p.LastName






;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetTechWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetTechWorkSchedule;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: May 2, 2016
-- Description:
-- exec UTP_GetTechWorkSchedule @GroupID=7, @Recursive=1, @ScheduleTypeID=90350
-- Revisions:
--		20-May-2016	JP	Add parameter CurrentUserID
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_GetTechWorkSchedule]
	@WorkScheduleID [int] = null, 
	@ScheduleTypeID [int] = null, -- Project
	@GroupID [int] = null, 
	@UserID [int] = null, 
	@Workdate date = null, 
	@TimeslotID int = null,
	@CurrentUserID [int] = null,
	@Recursive [bit] = 0

as
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetTechWorkSchedule: UserID=' + isnull(cast(@UserID as varchar(6)),'null')
	set @Identifier = 'GroupID=' + isnull(cast(@GroupID as varchar(20)),'null')
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	--SET @ScheduleTypeID = isnull(@ScheduleTypeID,90350)

	declare @FromDate date

	set @FromDate = isnull(@WorkDate,cast(Getdate() as date))

	SELECT [UserID]
		  ,[Username]
		  ,[WorkDate]
		  ,[ScheduleTypeID]
		  ,[ScheduleType]
		  ,[GroupID]
		  ,[GroupCode]
		  ,[GroupName]
		  ,[WeekDay]
		  ,[DisplayDate]
		  ,[Timeslot1]
		  ,[TimeSlot2]
		  ,[TimeSlot3]
		  ,[TimeSlot4]
		  ,[TimeSlot5]

		FROM vw_UTP_TechWorkSchedule
		WHERE ((@Recursive = 0 and isnull(GroupID,0) = coalesce(@GroupID,GroupID,0))
				or (@Recursive = 1 and isnull(GroupID,0) in (select ID from dbo.UTP_fnGetGroupTreeIDList(@GroupID))))
			and UserID = isnull(@UserID,UserID) 
			and Workdate = isnull(@Workdate,Workdate)
			and WorkDate >= @FromDate
			and ScheduleTypeID = isnull(@ScheduleTypeID,ScheduleTypeID)

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetTemplate') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetTemplate;
GO
-- =============================================
-- Author:		Jeff Moretti
-- Create date: March 21, 2016
-- Description:	Fetches the details for the
--				given template (headers and
--				columns)
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetTemplate] 
	-- Add the parameters for the stored procedure here
	@ImportTemplateId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT HasHeaders, MappingIndex, ParameterName, ParameterValue
	FROM UTP_ImportMap AS IM
	INNER JOIN UTP_ImportTemplate AS T ON T.ImportTemplateId = IM.ImportTemplateId
	WHERE T.ImportTemplateId = @ImportTemplateId
	ORDER BY MappingIndex
END




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetTemplateList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetTemplateList;
GO


-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 26, 2016
-- Description:	Retrieves a list of templates
--				in the DB based on orgID
--				(customer) and importTypeID/
--				ListID (import type)
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetTemplateList]
	-- Add the parameters for the stored procedure here
	@ImportTypeId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ImportTemplateID, ImportTemplateName
	FROM UTP_ImportTemplate
	WHERE ImportTypeID = @ImportTypeId
END






;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetUser') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetUser;
GO


-- exec [UTP_GetUser] 1, ''jxpeac''
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Dec 08, 2015
-- Description: Get User by ID, or all
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_GetUser]
	@UserID [int] = null,
	@Username varchar(50) = null,
	@CurrentUserID [int] = null
AS
	select 
		[UserID],
		[PersonID],
		[UserTypeID],
		[UserType],
		[UserName],
		[Password],
		[IsActive],
		[PersonTypeID],
		[PersonType],
		FirstName,
		[LastName],
		[Description],
		[PhoneEmailID],
		CellPhone,
		Pager,
		HomePhone,
		OfficePhone,
		Email,
		[BusinessName]

  FROM vw_UTP_User
	where UserID=COALESCE(@UserID,UserID)
		and Username=COALESCE(@Username,Username)
	order by LastName


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetUserPreference') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetUserPreference;
GO

-- exec UTP_GetUserPreference LogLevel, null, 1
-- 
CREATE PROCEDURE [dbo].[UTP_GetUserPreference] 
	@AttributeName varchar(255) = null,
	@UserID int = null,
	@CurrentUserID int = null
as
	SELECT UserPreferenceID
		  ,up.UserID
		  ,Username
		  ,up.DataAttributeID
		  ,up.AttributeName
		  ,AttributeValue
	  FROM UTP_UserPreference up
		INNER JOIN UTP_User u on up.UserID = u.UserID
		--INNER JOIN UTP_DataAttribute da on up.DataAttributeID = da.DataAttributeID
	  WHERE up.UserID = isnull(@UserID,up.UserID)
		and up.AttributeName = isnull(@AttributeName,up.AttributeName)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetUserWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetUserWorkSchedule;
GO


-- ===========================================================
-- Author: John Peacock
-- Create date: May 2, 2016
-- Description:
-- exec UTP_GetUserWorkSchedule @GroupID=7, @Recursive=1, @ScheduleTypeID=90350
-- Revisions:
--		20-May-2016	JP	Add parameter CurrentUserID
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_GetUserWorkSchedule]
	@ScheduleTypeID [int] = null, -- Project
	@GroupID [int] = null, 
	@UserID [int] = null, 
	@Workdate date = null, 
	@CurrentUserID [int] = null,
	@Recursive [bit] = 0

as
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@username varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetUserWorkSchedule: @UserID=' + isnull(cast(@UserID as varchar(6)),'null')
						+ ', @ScheduleTypeID=' + isnull(cast(@ScheduleTypeID as varchar(6)),'null')
						+ ', @Workdate=' + isnull(cast(@Workdate as varchar(25)),'null')
						+ ', @Recursive=' + isnull(cast(@Recursive as varchar(6)),'null')
	set @Identifier = 'GroupID=' + isnull(cast(@GroupID as varchar(20)),'null')
	select @Username = Username from UTP_User where UserID = @CurrentUserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	--SET @ScheduleTypeID = isnull(@ScheduleTypeID,90350)

	declare @FromDate date

	set @FromDate = isnull(@WorkDate,cast(Getdate() as date))

	SELECT [UserID]
		  ,[Username]
		  ,[WorkDate]
		  ,[ScheduleTypeID]
		  ,[ScheduleType]
		  ,[GroupID]
		  ,[GroupCode]
		  ,[GroupName]
		  ,[WeekDay]
		  ,[DisplayDate]
		  ,[Capacity1]
		  ,[Capacity2]
		  ,[Capacity3]
		  ,[Capacity4]
		  ,[Capacity5]
		  ,[Timeslot1]
		  ,[TimeSlot2]
		  ,[TimeSlot3]
		  ,[TimeSlot4]
		  ,[TimeSlot5]

		FROM vw_UTP_UserWorkSchedule
		WHERE ((@Recursive = 0 and isnull(GroupID,0) = coalesce(@GroupID,GroupID,0))
				or (@Recursive = 1 and isnull(GroupID,0) in (select ID from dbo.UTP_fnGetGroupTreeIDList(@GroupID))))
			and UserID = isnull(@UserID,UserID) 
			and Workdate = isnull(@Workdate,Workdate)
			and WorkDate >= @FromDate
			and ScheduleTypeID = isnull(@ScheduleTypeID,ScheduleTypeID)

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Getvw_Group') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Getvw_Group;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_Group
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Getvw_Group]
	@GroupID [int] = null,@UserID [int] = null
AS
	select 
		[GroupID],
		[GroupCode],
		[GroupName],
		[GroupTypeID],
		[GroupType],
		[IsActive],
		[Active],
		[GroupManagerID],
		[GroupManager],
		[ParentGroupID],
		[ParentGroupName]

  FROM [dbo].[vw_UTP_Group]
  where GroupID=COALESCE(@GroupID,GroupID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Getvw_Person') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Getvw_Person;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_Person
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Getvw_Person]
	@PersonID [int] = null,@UserID [int] = null
AS
	select 
		[PersonID],
		[PersonTypeID],
		[PersonType],
		[FirstName],
		[LastName],
		[Description],
		[PhoneEmailID],
		[CellPhone],
		[Pager],
		[HomePhone],
		[OfficePhone],
		[Email],
		[BusinessName]

  FROM [dbo].[vw_UTP_Person]
  where PersonID=COALESCE(@PersonID,PersonID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Getvw_Search') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Getvw_Search;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_Search
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Getvw_Search]
	@OrderID [int] = null,@UserID [int] = null
AS
	select 
		[OrderID],
		[WOID],
		[WONUM],
		[JobCodeID],
		[WorkType],
		[Subtype],
		[JobPlan],
		[GroupID],
		[GridID],
		[DisplayAddress],
		[Street],
		[Town],
		[PostCode],
		[StartDate],
		[DueDate],
		[WMStatusID],
		[DispatcherID],
		[TechnicianID],
		[CompletionDate],
		[CompletionCode],
		[AppointmentID],
		[AppointmentStatusID],
		[AppointmentTypeID],
		[TimeslotID],
		[AppointmentDate]

  FROM [dbo].[vw_UTP_Search]
  where OrderID=COALESCE(@OrderID,OrderID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Getvw_User') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Getvw_User;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_User
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Getvw_User]
	@UserID [int] = null,@UserIDRequesting [int] = null
AS
	select 
		[UserID],
		[PersonID],
		[UserTypeID],
		[UserType],
		[UserName],
		[Password],
		[IsActive],
		[PersonTypeID],
		[PersonType],
		[FirstName],
		[LastName],
		[Description],
		[PhoneEmailID],
		[CellPhone],
		[Pager],
		[HomePhone],
		[OfficePhone],
		[Email],
		[BusinessName]

  FROM [dbo].[vw_UTP_User]
  where UserID=COALESCE(@UserID,UserID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Getvw_WO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Getvw_WO;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_WO
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Getvw_WO]
	@OrderID [int] = null,@UserID [int] = null
AS
	select 
		[OrderID],
		[WOID],
		[WONUM],
		[JobCodeID],
		[JobCode],
		[WorkType],
		[Subtype],
		[JobPlan],
		[GroupID],
		[GroupName],
		[GridID],
		[Grid],
		[DisplayAddress],
		[Street],
		[Town],
		[PostCode],
		[StartDate],
		[DueDate],
		[WMStatusID],
		[WMStatus],
		[DispatcherID],
		[Dispatcher],
		[TechnicianID],
		[Technician],
		[CompletionDate],
		[CompletionCode],
		[AppointmentID],
		[AppointmentStatusID],
		[AppointmentStatus],
		[AppointmentTypeID],
		[AppointmentType],
		[TimeslotID],
		[AppointmentDate],
		[maxappt]

  FROM [dbo].[vw_UTP_WO]
  where OrderID=COALESCE(@OrderID,OrderID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWO;
GO


/****** Object:  StoredProcedure [dbo].[UTP_GetWO]    Script Date: 2017-02-04 7:44:40 PM ******/
-- ===========================================================
-- Author: JRP
-- Create date: Apr 26, 2016
-- Description: Select from table vw_UTP_WO
-- exec UTP_GetWO 165
-- Revisions:
--	8-Dec-2016	JRP Added EnableCodeOut, EnableCancel, WOTypeID, WOType, PrimaryOrderID, IsBillable, NoCharge
--	June-2018	JRP	LPGS_1455 Added PSN
-- ===========================================================
CREATE PROC [dbo].[UTP_GetWO]
	@OrderID [int] = null,
	@UserID int = null
AS
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@Username varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetWO'
	select @Identifier = cast(@OrderID as varchar(6))

	select @Username = Username from UTP_User where UserID = @UserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	set nocount on
	
	IF @OrderID is not NULL
	BEGIN
		SELECT [OrderID]
			  ,[OrgID]
			  ,[OrgShortName]
			  ,[ProjectNumber]
			  ,[WOID]
			  ,[WONUM]
			  ,[JobCodeID]
			  ,[JobCode]
			  ,[WorkType]
			  ,[Subtype]
			  ,[JobPlan]
			  ,[WOTypeID]
			  ,[WOType]
			  ,[GroupID]
			  ,[GroupName]
			  ,[GroupCode]
			  ,[WorkGroupID]
			  ,[WorkGroup]
			  ,[GridID]
			  ,[Grid]
			  ,[DisplayAddress]
			  ,[StreetNo]
			  ,[Unit]
			  ,[Street]
			  ,[Town]
			  ,[PostalCode]
			  ,[ReportedAt]
			  ,[ReportedBy]
			  ,[DueDate]
			  ,[UtilityComment]
			  ,[IsFirmAppt]
			  ,[ApptStartDate]
			  ,[ApptEndDate]
			  ,[ApptStartTime]
			  ,[ApptEndTime]
			  ,[WMStatusID]
			  ,[WMStatus]
			  ,[DispatcherID]
			  ,[Dispatcher]
			  ,[TechnicianID]
			  ,[Technician]
			  ,[ActualStart]
			  ,[ActualFinish]
			  ,[CompletionCode]
			  ,[IsBillable]
			  ,[NoCharge]
			  ,[OldMeterSize]
			  ,[OldMeterNumber]
			  ,[MeterLocation]
			  ,[ServicePressure]
			  ,[NewMeterSize]
			  ,[NewMeterNumber]
			  ,[MeterLeftStatus]
			  ,[APEQType]
			  ,[AppointmentID]
			  ,[AppointmentStatusID]
			  ,[AppointmentStatus]
			  ,[AppointmentTypeID]
			  ,[AppointmentType]
			  ,[TimeslotID]
			  ,[SpecialInstructions]
			  ,[PremiseNo]
			  ,[CustomerName]
			  ,[CustomerPhone]
			  ,[WODescription]
			  ,[ParentWONUM]
			  ,[PrimaryOrderID]
			  ,[IsEAOK]
			  ,[ErrorStatus]
			  ,[CreatedTimestamp]
			  ,[SubmitStatusID]
			  ,[SubmitStatus]
			  ,[TransmitStatusID]
			  ,[TransmitStatus]
			  ,[EnableSubmit]
			  ,[EnableRaise]
			  ,[EnableRelatedWork]
			  ,[EnableRelight]
			  ,[EnableAssignTech]
			  ,[EnableSchedule]
			  ,[EnableDispatch]
			  ,[EnableRetract]
			  ,[EnableBookAppt]
			  ,[EnableNewInvoice]
			  ,[EnableSuspend]
			  ,[EnableCodeOut]
			  ,[EnableCancel]
			  ,[EnableSummary]
			  ,[PSN]

		  FROM [dbo].[vw_UTP_WO_UTP]
		  WHERE OrderID = @OrderID
	END
	ELSE
	BEGIN
		SELECT TOP 500
			[OrderID]
			,[OrgID]
			,[OrgShortName]
			,[ProjectNumber]
			,[WOID]
			,[WONUM]
			,[JobCodeID]
			,[JobCode]
			,[WorkType]
			,[Subtype]
			,[JobPlan]
			,[WOTypeID]
			,[WOType]
			,[GroupID]
			,[GroupName]
			,[GroupCode]
			,[WorkGroupID]
			,[WorkGroup]
			,[GridID]
			,[Grid]
			,[DisplayAddress]
			,[StreetNo]
			,[Unit]
			,[Street]
			,[Town]
			,[PostalCode]
			,[ReportedAt]
			,[ReportedBy]
			,[DueDate]
			,[UtilityComment]
			,[IsFirmAppt]
			,[ApptStartDate]
			,[ApptEndDate]
			,[ApptStartTime]
			,[ApptEndTime]
			,[WMStatusID]
			,[WMStatus]
			,[DispatcherID]
			,[Dispatcher]
			,[TechnicianID]
			,[Techni;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWOCustomer') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWOCustomer;
GO

-- exec UTP_GetWOCustomer 165
-- 31-May-2017 JP fix to align order of ContactEmail and ContactAlterPhone with vw_UTP_WOCustomerType
CREATE PROC [dbo].[UTP_GetWOCustomer]
	@OrderID int = null,
	@CurrentUserID int = null
as

	SELECT	TOP 1
			o.OrderID,
			CustomerName = occ.ContactName,
			CustomerPhone = coalesce(occ.ContactPhone,occ.ContactAlternatePhone),
			CustomerEmail = occ.ContactEmail,
			ContactName = con.ContactName,
			ContactPhone = con.ContactPhone,
			ContactEmail = con.ContactEmail,
			ContactAlternatePhone = con.ContactAlternatePhone,
			LatestLetterDate = cast(null as date),
			CustomerType = NULL,
			CustomerOnsiteContact = NULL,
			CustomerContact1_Name = NULL,
			CustomerContact1_Phone = NULL,
			CustomerContact1_Mobile = NULL,
			CustomerContact2_Name = NULL,
			CustomerContact2_Phone = NULL,
			CustomerContact2_Mobile = NULL,
			CustomerLanguageCode = NULL

		FROM UTP_Order o
			LEFT JOIN UTP_Contact occ on o.OrderID = occ.OrderID and occ.ContactTypeID = 1801 --occupant
			--LEFT JOIN UTP_Appointment a on o.OrderID = a.OrderID and a.AppointmentStatusID <> 90322
			LEFT JOIN UTP_Contact con on o.OrderID = con.OrderID  and con.ContactTypeID = 1803 --contact
			--LEFT JOIN EGD_WO ew	on o.OrderID = ew.OrderID
			--LEFT JOIN EGD_PlusPCustomer ec on ew.WOID = ec.WOID
		WHERE o.OrderID = isnull(@OrderID,o.OrderID)
		ORDER BY con.ContactID desc



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWOHeader') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWOHeader;
GO
-- ===========================================================
-- exec UTP_GetWOHeader 165
-- Revisions:
--	8-Dec-2016	JRP Added EnableCodeOut, EnableCancel, WOTypeID, WOType, PrimaryOrderID, IsBillable, NoCharge
-- ===========================================================
CREATE PROC [dbo].[UTP_GetWOHeader]
	@OrderID [int],
	@CurrentUserID int = null
AS
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@Username varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetWOHeader'
	select @Identifier = cast(@OrderID as varchar(6))

	select @Username = Username from UTP_User where UserID = @CurrentUserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	set nocount on
	
	SELECT [OrderID]
		  ,[WONUM]
		  ,[JobCodeID]
		  ,[JobCode]
		  ,[DisplayAddress]
		  ,[WMStatusID]
		  ,[WMStatus]
		  ,[OldMeterSize]
		  ,[OldMeterNumber]
		  ,[APEQType] = isnull([APEQType],'')
		  ,[ParentWONUM]
		  ,[PrimaryOrderID]

	  FROM [dbo].[vw_UTP_WO_UTP]
	  WHERE OrderID = @OrderID

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWOInfo') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWOInfo;
GO
-- ===========================================================
-- Description: 
-- exec [UTP_GetWOInfo] '272225'
-- exec [UTP_GetWOInfo] '272226'
-- Revisions:
-- ===========================================================
CREATE procedure [dbo].[UTP_GetWOInfo]
	@WONUM varchar(15) = null,
	@CurrentUserID int = null
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetWOInfo'
	set @Identifier = @WONUM

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	declare @WOInfo varchar(1334) = null, @OrgID int

	SELECT @OrgID=OrgID from vw_TPS_WO where WONUM=@WONUM
	IF @OrgID IS NOT NULL
	BEGIN
		Select @WOInfo = 'WONUM: ' + WONUM
						+ '<BR/> JobCode:' + isnull(JobCode, 'null')
						+ '<BR/> Address: ' + isnull(DisplayAddress, 'null')
						+ '<BR/> Technician: ' + isnull(Technician, 'null')
						+ '<BR/> CompletionDate: ' + isnull(convert(varchar(10),ActualFinish,101), 'null')
						+ '<BR/> CompletionCode: ' + isnull(CompletionCode, 'null')
			--		select *
			from vw_UTP_WO_UTP
			where WONUM = @WONUM
	END
	
	if @WOInfo is null
			set @WOInfo = 'WONUM: ' + @WONUM + ' not found'

	select WOInfo = @WOInfo

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWOInvoiceLine') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWOInvoiceLine;
GO
-- ===========================================================
-- Author: Diane MacMartin
-- Create date: Jan 20, 2016
-- Description:
--     Select from tableEGD_InvoiceLine by InvoiceID
-- exec UTP_GetWOInvoiceLine @OrderID=77872
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_GetWOInvoiceLine]
	@InvoiceLineID int = null,
	@InvoiceID int = null,
	@OrderID int = null,
	@CurrentUserID int = null
AS

IF @InvoiceLineID IS NOT NULL
	SELECT
		   [OrderID]
		  ,[WOID]
		  ,[WONUM]
		  ,[InvoiceID]
		  ,[InvoiceLineID]
		  ,[InvoiceNum]
		  ,[InvoiceLineNum]
		  ,[InstallDate]
		  ,[InvoiceQty]
		  ,[ItemNum]
		  ,[ItemCost]
		  ,[LineCost]
		  ,[TaxCode]
		  ,[InvoiceLineNote]

		FROM [dbo].[vw_UTP_WOInvoiceLine]
		WHERE InvoiceLineID = @InvoiceLineID
			and IsActive=1
		order by InvoiceLineID 
ELSE IF @InvoiceID IS NOT NULL
	SELECT
		   [OrderID]
		  ,[WOID]
		  ,[WONUM]
		  ,[InvoiceID]
		  ,[InvoiceLineID]
		  ,[InvoiceNum]
		  ,[InvoiceLineNum]
		  ,[InstallDate]
		  ,[InvoiceQty]
		  ,[ItemNum]
		  ,[ItemCost]
		  ,[LineCost]
		  ,[TaxCode]
		  ,[InvoiceLineNote]

		FROM [dbo].[vw_UTP_WOInvoiceLine]
		WHERE InvoiceID = @InvoiceID
			and IsActive=1
		order by InvoiceLineID 
ELSE
	SELECT
		   [OrderID]
		  ,[WOID]
		  ,[WONUM]
		  ,[InvoiceID]
		  ,[InvoiceLineID]
		  ,[InvoiceNum]
		  ,[InvoiceLineNum]
		  ,[InstallDate]
		  ,[InvoiceQty]
		  ,[ItemNum]
		  ,[ItemCost]
		  ,[LineCost]
		  ,[TaxCode]
		  ,[InvoiceLineNote]

		FROM [dbo].[vw_UTP_WOInvoiceLine]
		WHERE OrderID = @OrderID
			and IsActive=1
		order by InvoiceLineID 

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWOPremiseHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWOPremiseHistory;
GO
CREATE proc [dbo].[UTP_GetWOPremiseHistory]
	@OrderID int,
	@WONUM varchar(15) = null,
	@CurrentUserID int = null
as 

	declare @PHList table (OrderID int null, WONUM varchar(15),WorkType varchar(20),Technician varchar(50) null,CompletionCode varchar(10) null,DueDate datetime null,JobCode varchar(255) null,Comments varchar(4000) null)

	insert @PHList (OrderID,WONUM,WorkType,Technician,CompletionCode,DueDate,JobCode,Comments)
		select	distinct 
				OrderID = wo.OrderID,
				WONUM = wo.WONUM, 
				WorkType = wo.WorkType,
				Technician = wo.Technician,
				CompletionCode = wo.CompletionCode,
				DueDate = wo.DueDate,
				JobCode = wo.JobCode,
				Comments = null
			from vw_UTP_WO_UTP wo
				where DisplayAddress = (select DisplayAddress from vw_UTP_WO_UTP where OrderID=@OrderID)

	select	OrderID = wo.OrderID,
			WONUM = wo.WONUM, 
			WorkType = wo.WorkType,
			Technician = wo.Technician,
			CompletionCode = wo.CompletionCode,
			DueDate = wo.DueDate,
			JobCode = wo.JobCode,
			Comments = wo.Comments

		from @PHList wo
		where wo.WONUM=isnull(@WONUM,wo.WONUM)
		order by WONUM

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWORelightHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWORelightHistory;
GO

-- exec [UTP_GetWORelightHistory] 165
CREATE PROC [dbo].[UTP_GetWORelightHistory]
	@OrderID int = null,
	@CurrentUserID int = null
as

	SELECT	MeterLeftStatus = MeterLeftStatus,
			CompletionDate = a.ActualFinish,
			TechnicianID = TechnicianID,
			Technician = t.Username,
			ModifiedByID = a.ModifiedByID,
			ModifiedBy = u.Username

		FROM UTP_Appointment a 
			left join UTP_User t on TechnicianID = t.UserID
			left join UTP_User u on ModifiedByID = u.UserID

		WHERE OrderID = isnull(@OrderID, OrderID)
			and AppointmentTypeID=90312

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWORelightInfo') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWORelightInfo;
GO

-- exec UTP_GetWORelightInfo 165
CREATE PROC [dbo].[UTP_GetWORelightInfo]
	@OrderID int = null,
	@CurrentUserID int = null
as

	SELECT	o.OrderID,
			DayTimeTechnicianID =  coalesce(u.UserID,ut.UserID),
			DayTimeTechnician =coalesce(u.Username,ut.Username),
			AfterHoursTechnicianID = 1,
			AfterHoursTechnician = cast('' as varchar(50)),
			CurrentMeterStatus = cast(a.MeterLeftStatus as varchar(10)),
			CompletionDate = coalesce(uw.ActualFinish,a.ActualFinish)

		FROM [UTP_Order] o (nolock)
			LEFT JOIN UTP_WOStructure ws (nolock) on o.OrderID = ws.RelatedOrderID
			-- LEFT JOIN [EGD_WO] ew (nolock) on o.OrderID = ew.OrderID
			LEFT JOIN [UTP_WO] uw (nolock) on o.OrderID = uw.OrderID
			LEFT JOIN ([UTP_Appointment] a 
					INNER JOIN (Select OrderID, AppointmentID = max(AppointmentID) from [UTP_Appointment] (nolock)  where AppointmentTypeID = 90312 group by OrderID) am 
						on a.AppointmentID = am.AppointmentID)
				on o.OrderID = a.OrderID 
			LEFT JOIN UTP_ListMaster s (nolock) on a.AppointmentStatusID = s.ListID
			LEFT JOIN UTP_ListMaster t (nolock) on a.AppointmentTypeID = t.ListID
			LEFT JOIN UTP_User u (nolock) on a.TechnicianID = u.UserID and u.Isactive = 1
			LEFT JOIN UTP_User ut (nolock) on uw.TechnicianID = ut.UserID and u.Isactive = 1
			-- LEFT JOIN UTP_User eu (nolock) on ew.WAMS_CREWID = eu.Username and eu.Isactive = 1

		WHERE o.OrderID =isnull(@OrderID,o.OrderID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWORemark') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWORemark;
GO
-- Add logging to GetWORemark and GetRelatedWO
-- =============================================
-- Author:		John Peacock
-- Create date: July 2, 2016
-- exec [UTP_GetWORemark] null, 1, 'COA'
-- Description:	
-- Revisions:
--		15-OCt-2016		Add logging
-- =============================================
CREATE PROCEDURE [dbo].[UTP_GetWORemark]
	@OrderHistoryID int = null,
	@OrderID int = null,
	@MemoTypeID int = null,
	@CurrentUserID int = null
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Username varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetWORemark:'
				+ ' @OrderHistoryID=' + isnull(cast(@OrderHistoryID as varchar(10)),'null')
				+ ' @MemoTypeID=' + isnull(cast(@MemoTypeID as varchar(10)),'null')
	set @Identifier = cast(@OrderID as varchar(20))
	select @Username = Username from UTP_User where UserID = @CurrentUserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	set nocount on

	IF @OrderHistoryID is not NULL
	BEGIN
		SELECT	[OrderHistoryID],
				[OrderID],
				[WOID],
				[WONUM],
				[CreatedTimestamp],
				[CreatedByID],
				[CreatedBy],
				[MemoTypeID],
				[MemoType],
				[Memo],
				[TechnicianID],
				[Technician]

			FROM [dbo].[vw_UTP_WORemark]
			WHERE OrderHistoryID = @OrderHistoryID
			ORDER BY OrderHistoryID desc
		END
		ELSE
		BEGIN
		SELECT	[OrderHistoryID],
				[OrderID],
				[WOID],
				[WONUM],
				[CreatedTimestamp],
				[CreatedByID],
				[CreatedBy],
				[MemoTypeID],
				[MemoType],
				[Memo],
				[TechnicianID],
				[Technician]

			FROM [dbo].[vw_UTP_WORemark]
			WHERE OrderID = @OrderID
				AND (@MemoTypeID IS NULL OR MemoTypeID = @MemoTypeID)
			ORDER BY OrderHistoryID desc
		END

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWorkSchedule;
GO


-- ===========================================================
-- Author: John Peacock
-- Create date: May 2, 2016
-- Description:
-- exec UTP_GetWorkSchedule @UserID=3, @Recursive=0, @ScheduleTypeID=90350
-- exec UTP_GetWorkSchedule @GroupID=7, @Recursive=1, @ScheduleTypeID=90353
-- exec UTP_GetWorkSchedule @GroupID=7, @Recursive=1, @ScheduleTypeID=90353
-- Revisions:
-- 20-May-2016	JP	Add parameter CurrentUserID
-- 4-Mar-2017	JP	LPGS-265 Time-off (vacation, sick, personal appts)
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_GetWorkSchedule]
	@WorkScheduleID [int] = null, 
	@ScheduleTypeID [int] = null, -- Project
	@GroupID [int] = null, 
	@UserID [int] = null, 
	@Workdate date = null, 
	@TimeslotID int = null,
	@CurrentUserID [int] = null,
	@Recursive [bit] = 0

as
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@Username varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_GetWorkSchedule: @UserID=' + isnull(cast(@UserID as varchar(6)),'null')
						+ ', @ScheduleTypeID=' + isnull(cast(@ScheduleTypeID as varchar(6)),'null')
						+ ', @Workdate=' + isnull(cast(@Workdate as varchar(25)),'null')
	set @Identifier = 'GroupID=' + isnull(cast(@GroupID as varchar(20)),'null')
	select @Username = Username from UTP_User where UserID = @CurrentUserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	--SET @ScheduleTypeID = isnull(@ScheduleTypeID,90350)

	SELECT [WorkScheduleID]
		  ,[ScheduleTypeID]
		  ,[ScheduleType]
		  ,[UserID]
		  ,[Username]
		  ,[DisplayName]
		  ,[WorkDate]
		  ,[TimeSlotID]
		  ,[Timeslot]
		  ,[Capacity]
		  ,[Booked]
		  ,[GroupID]
		  ,[Groupname]
		  ,[TimeoffReasonID]
		  ,[TimeoffReason]

		FROM [dbo].[vw_UTP_WorkSchedule]
		WHERE ((@Recursive = 0 and isnull(GroupID,0) = coalesce(@GroupID,GroupID,0))
				or (@Recursive = 1 and isnull(GroupID,0) in (select ID from dbo.UTP_fnGetGroupTreeIDList(@GroupID))))
			and UserID = isnull(@UserID,UserID) 
			and Workdate = isnull(@Workdate,Workdate)
			and TimeslotID = isnull(@TimeslotID,TimeslotID)
			and WorkScheduleID = isnull(@WorkScheduleID,WorkScheduleID)
			and ScheduleTypeID = isnull(@ScheduleTypeID,ScheduleTypeID)
			and ScheduleTypeID in (90350,90353,90355,90356)

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWorkSchedule2') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWorkSchedule2;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: May 2, 2016
-- Description:
-- exec UTP_GetWorkSchedule @GroupID=7, @Recursive=1, @ScheduleTypeID=90353
-- Revisions:
--		20-May-2016	JP	Add parameter CurrentUserID
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_GetWorkSchedule2]
	@WorkScheduleID [int] = null, 
	@ScheduleTypeID [int] = null, -- Project
	@GroupID [int] = null, 
	@UserID [int] = null, 
	@Workdate date = null, 
	@TimeslotID int = null,
	@CurrentUserID [int] = null,
	@Recursive [bit] = 0

as
	--SET @ScheduleTypeID = isnull(@ScheduleTypeID,90350)

	SELECT [WorkScheduleID]
		  ,[ScheduleTypeID]
		  ,[ScheduleType]
		  ,[UserID]
		  ,[Username]
		  ,[DisplayName]
		  ,[WorkDate]
		  ,[TimeSlotID]
		  ,[Timeslot]
		  ,[Capacity]
		  ,[Booked]
		  ,[GroupID]
		  ,[Groupname]

		FROM [dbo].[vw_UTP_WorkSchedule]
		WHERE ((@Recursive = 0 and isnull(GroupID,0) = coalesce(@GroupID,GroupID,0))
				or (@Recursive = 1 and isnull(GroupID,0) in (select ID from dbo.UTP_fnGetGroupTreeIDList(@GroupID))))
			and UserID = isnull(@UserID,UserID) 
			and Workdate = isnull(@Workdate,Workdate)
			and TimeslotID = isnull(@TimeslotID,TimeslotID)
			and WorkScheduleID = isnull(@WorkScheduleID,WorkScheduleID)
			and ScheduleTypeID = isnull(@ScheduleTypeID,ScheduleTypeID)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GetWOSearch') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GetWOSearch;
GO

-- exec  UTP_GetWOSearch 1
CREATE PROC [dbo].[UTP_GetWOSearch]
	@CurrentUserID int 
AS

	SELECT TOP 1
			[OrderID]
		  ,[OrgID]
		  ,[ProjectNumber]
		  ,[WOID]
		  ,[WONUM]
		  ,[JobCodeID]
		  ,[JobCode]
		  ,[WorkType]
		  ,[Subtype]
		  ,[JobPlan]
		  ,[GroupID]
		  ,[Grid]
		  ,[DisplayAddress]
		  ,[StreetNo]
		  ,[Unit]
		  ,[Street]
		  ,[Town]
		  ,[PostalCode]
		  ,[OldMeterNumber]
		  ,[OldMeterSize]
		  ,[NewMeterNumber]
		  ,[NewMeterSize]
		  ,[APEQType]
		  ,[FromDueDate]
		  ,[ToDueDate]
		  ,[FromApptStartDate]
		  ,[ToApptStartDate]
		  ,[IsFirmAppt]
		  ,[WMStatusID]
		  ,[DispatcherID]
		  ,[TechnicianID]
		  ,[FromActualFinish]
		  ,[ToActualFinish]
		  ,[CompletionCode]
		  ,[AppointmentID]
		  ,[AppointmentStatusID]
		  ,[AppointmentTypeID]
		  ,[TimeslotID]
		  ,[PremiseNo]
		  ,[UtilityComment]
		  ,[CustomerName]
		  ,[CustomerPhone]
		  ,[ParentWONUM]
		  ,[WODescription]
		  ,[ErrorStatus]
		  ,[CreatedTimestamp]
		  ,[SubmitStatusID]
		  ,[SubmitStatus]
		  ,[TransmitStatusID]
		  ,[TransmitStatus]
		  ,[MeterLeftStatus]
		  ,[FromReportedDate]
		  ,[ToReportedDate]

	  FROM [dbo].[vw_UTP_Search]
	--WHERE CreatedByID = @CurrentUserID
	--ORDER BY WOSearchID DESC


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GUIAddAttachment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GUIAddAttachment;
GO
-- DROP PROC [dbo].[UTP_GUIAddAttachment]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: August 3, 2016
-- Description: Identify OrderID and DocumentRepositoryID for Attachment
-- Revisions:
--	2016-09-22 IDM - Alter to remove OrderID lookup
--
-- ===========================================================
CREATE PROC [dbo].[UTP_GUIAddAttachment]
	@Filename [varchar](1024),
	@DocumentStorageID int OUTPUT
AS
	DECLARE @Success int=0
	DECLARE @DSRoot int = 1 -- just use first DocumentStorage record - can be changed
	-- SELECT @DocumentStorageID=MIN([DocumentStorageID]) FROM [dbo].[UTP_DocumentStorage] WHERE [RootFolder] <> ''
	-- SELECT @DocumentStorageID=[DocumentStorageID] FROM [dbo].[UTP_DocumentStorage] WHERE [DocumentStorageID]=@DSRoot
	DECLARE @LocalPath varchar(128), @RightNow DATETIME, @FullPath VARCHAR(1024)
	SELECT @RightNow=GETDATE()
	SELECT @LocalPath=CAST(DATEPART(YYYY,@RightNow) AS VARCHAR(4)) + '\' + RIGHT('00' + CAST(DATEPART(wk, @RightNow) AS VARCHAR(2)),2)
	SELECT @FullPath=[RootFolder] + '\' + @LocalPath FROM [dbo].[UTP_DocumentStorage] WHERE [DocumentStorageID]=@DSRoot
	SELECT @DocumentStorageID=[DocumentStorageID] FROM [dbo].[UTP_DocumentStorage] WHERE [RootFolder]=@FullPath
	IF @DocumentStorageID IS NULL
	BEGIN
		EXEC [dbo].[UTP_NewDocumentStorage] @FullPath, 0, @DocumentStorageID OUTPUT
	END
	
	IF @DocumentStorageID IS NOT NULL SET @Success=1

	RETURN @Success



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_GUIDocumentUploaded') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_GUIDocumentUploaded;
GO
-- DROP PROC [dbo].[UTP_GUIDocumentUploaded]
-- ===========================================================
-- Author: Ian MacIntyre
-- Create date: September 22, 2016
-- Description: Set DocumentTypeID on uploaded document
-- Revisions:
--
-- ===========================================================
CREATE PROC [dbo].[UTP_GUIDocumentUploaded]
	@DocumentType [varchar](255),
	@DocumentID [int]
AS
	DECLARE @Success int=0, @DocumentTypeID int
	
	SELECT @DocumentTypeID=isnull([dbo].[fnUTP_GetListMaster]('DocumentType',@DocumentType),[dbo].[fnUTP_GetListMaster]('DocumentType','N/A'))

	UPDATE [dbo].[UTP_Document] SET [DocumentTypeID]=@DocumentTypeID WHERE [DocumentID]=@DocumentID
	
	IF @@ROWCOUNT = 1 SET @Success=1
	
	RETURN @Success



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportStagingFirstStep') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportStagingFirstStep;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 22, 2016
-- Description:	Staging Import - imports data
--				into staging table.  Later
--				this data will be copied into
--				actual table (later in process)
--				NOTE: This is a first step
--				master SP.  Will need to call
--				import type specific SP after.
-- 07/06/16 JLM - added ContractID parameter
--				(support for Project) and 
--				OrgID parameter
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportStagingFirstStep]
	-- Add the parameters for the stored procedure here
	@ImportTemplateID INT,
	@UserID INT,
	@ExcludeFromCleanup BIT,
	@ContractID BIGINT = NULL,
	@OrgID INT = NULL,
	@ImportBatchID INT = NULL OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportBatch]
		   ([ImportTemplateID]
           ,[BatchStatusID]
           ,[ExcludeFromCleanup]
           ,[CreatedByID]
           ,[CreatedTimestamp]
		   ,[ContractID]
		   ,[OrgID])
     VALUES
			(@ImportTemplateID
           ,1100 -- TODO: Will need to determine initial batch status ID and hardcore here
           ,@ExcludeFromCleanup
           ,@UserID
           ,GETDATE()
		   ,@ContractID
		   ,@OrgID)

	SET @ImportBatchID = SCOPE_IDENTITY()
END







;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOAssignFitterFinal') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOAssignFitterFinal;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 22, 2016
-- Description:	Imports data from staging
--				tables (ImportHeader and
--				Import data) into actual
--				desired tables
-- 2018-11-26 jm > Commented out 
--				****SPECIAL PROJECT - SURVEY****
--				logging
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOAssignFitterFinal]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@OrgID INT
AS
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @UserID int, @SubmitBy varchar(50)

	SELECT @UserID=u.UserID, @SubmitBy=CAST(('utopis:' + u.Username) as varchar(50))
	FROM UTP_ImportBatch ib with(nolock) JOIN UTP_User u with(nolock) ON u.UserID=ISNULL(ib.AtUserID,ib.CreatedByID)
	WHERE ib.ImportBatchID=@ImportBatchID

	IF @UserID IS NULL OR @UserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @UserID must be provide',1
	END
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @UserID provided',2
	END

	-- Declare scalar variables to insert WO Assign Fitter Import data into
	DECLARE @WRNo varchar(30)
	DECLARE @Fitter varchar(50)
	DECLARE @ApptStartDate datetime
	DECLARE @ApptEndDate datetime

	DECLARE wo_cursor CURSOR FOR 
		SELECT
		    [Col1]
           ,[Col2]
           ,[Col3]
		   ,[Col4]
		FROM UTP_ImportData WHERE ImportBatchID = @ImportBatchID
		ORDER BY ImportDataID
	OPEN wo_cursor
	FETCH NEXT FROM wo_cursor INTO
			@WRNo,
			@Fitter,
			@ApptStartDate,
			@ApptEndDate
			
	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- Fetch TechnicianID based on @Fitter
		DECLARE @TechnicianID INT, @Status varchar(20), @StatusDate DATETIME, @NewKey int, @WOID int, @SubmitSuccess bit, @OrderID int
		DECLARE @ContactID INT, @Org varchar(20), @TimeslotID int, @AppointmentType varchar(20),@NextStatus varchar(20)
		DECLARE @OldApptID INT, @DeltaMS int, @EventStatusDate DATETIME, @ToSabre int, @HasHandheld int = 0, @ToHandheld int = 0
		
		SELECT @TechnicianID=NULL,@OrderID=NULL,@OldApptID=NULL,@Status=NULL,@TimeslotID=NULL,@AppointmentType=NULL,@ContactID=NULL
		
		SELECT @ApptEndDate=CAST(CAST(@ApptEndDate AS DATE) AS DATETIME) + CAST(CAST('23:59' AS TIME) AS DATETIME)

		SELECT @TechnicianID=[UserID] FROM [dbo].[UTP_User] WHERE [UserName] = @Fitter

		SELECT @OrderID=[OrderID],@Org=[OrgShortName],@WOID=[WOID],@Status=[WMStatus],@ToSabre=[ToSabre] FROM [dbo].[vw_TPS_WO] WHERE [WONUM]=@WRNo

		IF @OrderID IS NULL
		BEGIN
			PRINT 'Unknown WRNo'
		END
		ELSE IF @TechnicianID IS NULL
		BEGIN
			PRINT 'Unknown Technician: ' + ISNULL(@Fitter,'')
		END
		ELSE IF (SELECT COUNT(*) FROM [dbo].[UTP_Appointment] WHERE [OrderID]=@OrderID AND ([AppointmentStatusID] IN (90235,90237) OR ([AppointmentStatusID] IN (90321) and TimeslotID between 90301 and 90305 and cast(ApptStartDate as date) = cast(ApptEndDate as date)))) > 0 -- Completed, COA
			OR @Status NOT IN ('WSCH','SCHED','DISP','ACK')
		BEGIN
			PRINT 'Appointment is Completed or Active'
		END
		ELSE
		BEGIN
			-- Process UTP_Appointment records
			-- If expired Customer Booked appointment, can copy information from it
			-- Otherwise, create a new UTP_Appointment record.  In both cases, maintain Contact information		
			SELECT @OldApptID=[AppointmentID], @ContactID=[ContactID],@AppointmentType=dbo.fnUTP_SelectListMaster([AppointmentTypeID]),
				@TimeslotID=[TimeslotID]
			FROM [dbo].[UTP_Appointment] WHERE [OrderID]=@OrderID AND [AppointmentStatusID] IN (90321,90329) -- Booked, Reserved
			
			-- Cancel all active appointments for the order
			UPDATE [dbo].[UTP_Appointment] SET [AppointmentStatusID]=90322 WHERE [OrderID]=@OrderID AND [AppointmentStatusID] IN (90320,90321,90329) -- Ready, Booked, Reserved
			
			-- Create new Appointment - If previous was Customer Booked, copy information from it, otherwise create new
			I;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOAssignFitterStaging') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOAssignFitterStaging;
GO





















-- =============================================
-- Author:		Jeff Moretti
-- Create date: September 9, 2016
-- Description:	Imports a list of assign fitter
--				WOs to modify in the system
--				(aka 'batch upload')
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOAssignFitterStaging]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@WO [dbo].[UTP_WOAssignFitterImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportHeader]
           ([ImportBatchID]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   ,[Col4]
           )
     VALUES
           (@ImportBatchID,
			'WRNo',
			'Fitter',
			'ApptStartDate',
			'ApptEndDate'
			)

	INSERT INTO [dbo].[UTP_ImportData]
           ([ImportBatchID]
           ,[ImportStatusID]
           ,[ErrorMessage]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   ,[Col4]
           )
	SELECT 
		@ImportBatchID,
		1100, -- TODO Will need to determine initial import status ID and hardcore here
		NULL, -- Insert NULL for error message
		[WRNo],
		[Fitter],
		[ApptStartDate],
		[ApptEndDate]
		
	FROM @WO
END





















;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOCompletionFinal') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOCompletionFinal;
GO

-- ========================================
-- Author:		Jeff Moretti
-- Create date: Feb 22, 2017
-- Description:	Imports data from staging
--				tables (ImportHeader and
--				Import data) into actual
--				desired tables.  Note that
--				this is a WO - Completion
--				Import.
--
--				JLM - April 17 2017
--				added COA comment into
--				OrderHistory
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOCompletionFinal]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@OrgID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare scalar variables to insert WO Import data into
	DECLARE @PremiseNo varchar(30)
	DECLARE @WONUM varchar(15)
	DECLARE @WMStatus varchar(25)
	DECLARE @CompletionFitter varchar(50)
	DECLARE @CompletionDate datetime
	DECLARE @MeterStatus varchar(25)
	DECLARE @COA varchar(200)

	DECLARE wo_cursor CURSOR FOR 
		SELECT
		    [Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
		   ,[Col5]
		   ,[Col6]
		   ,[Col7]
		FROM UTP_ImportData WHERE ImportBatchID = @ImportBatchID
		ORDER BY ImportDataID
	OPEN wo_cursor
	FETCH NEXT FROM wo_cursor INTO
			@WONUM,
			@PremiseNo,
			@WMStatus,
			@CompletionFitter,
			@CompletionDate,
			@MeterStatus,
			@COA

	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- Fetch DataAttributeIDs
		DECLARE @PremiseNoDAID INT
		DECLARE @MeterStatusDAID INT

		SELECT @PremiseNoDAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'PremiseNo'
		AND Category = 'UTP_WO'

		SELECT @MeterStatusDAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'MeterStatus'
		AND Category = 'UTP_WO'

		DECLARE @WMStatusID INT
		DECLARE @oldWMStatusID INT
		DECLARE @CompletionTechnicianID INT
		DECLARE @CompletionCode varchar(20)

		DECLARE @oldOrderID INT
		DECLARE @oldWMStatus varchar(25)

		DECLARE @Memo varchar(300)
		DECLARE @MemoTechID int

		-- set meter status to NULL if blank string
		SET @MeterStatus = NULLIF(@MeterStatus,'')

		-- set completion date to NULL if its not valid (ie timestamp before Jan 1st 1901)
		SELECT @CompletionDate = NULL
		WHERE @CompletionDate < '1901-01-01'

		SET @oldOrderID = -5

		IF @WONUM IS NOT NULL
		BEGIN
			SELECT @oldOrderID = OrderID FROM UTP_WO WHERE WONUM=@WONUM
		END
		IF @oldOrderID = -5
		BEGIN
			IF (SELECT COUNT(*) FROM UTP_Spec us LEFT JOIN UTP_Order uo ON us.OrderID = uo.OrderID
				INNER JOIN UTP_WO uw ON uw.OrderID = uo.OrderID
				WHERE us.DataAttributeID = @PremiseNoDAID AND us.AttributeValue = @PremiseNo) = 1
			BEGIN
				SELECT @oldOrderID = uo.OrderID
				FROM UTP_Spec us
				LEFT JOIN UTP_Order uo ON us.OrderID = uo.OrderID
				INNER JOIN UTP_WO uw ON uw.OrderID = uo.OrderID
				WHERE us.DataAttributeID = @PremiseNoDAID
				AND us.AttributeValue = @PremiseNo
			END
		END

		-- Only want to update old WO record if WMStatus is either WCOMP or ONHOLD
		IF @oldOrderID <> -5 AND (@WMStatus = 'WCOMP' OR @WMStatus = 'ONHOLD')
		BEGIN
			-- Found already existing row for the WO import.  Will need to update old WO records
			-- Also will want to inspect current WMStatus in Utopis already
			SELECT @oldWMStatusID = NULL
			
			SELECT @oldWMStatusID = WMStatusID, @MemoTechID=TechnicianID
			FROM UTP_WO
			WHERE OrderID = @oldOrderID

			SELECT @oldWMStatus = ListValue
			FROM UTP_ListMaster
			WHERE ListKey = 'WMStatus' AND ListID = @oldWMStatusID

			IF (@oldWMStatus <> 'WCOMP' AND @oldWMStatus <> 'ONHOLD')
			BEGIN
				-- Fetch WMStatusID based on @WMStatus
				SELECT @WMStatusID = NULL

				SELECT @WMStatusID = ListID
				FROM UTP_ListMaster
				WHERE ListKey = 'WMStatus' AND ListValue = @WMStatus
				
				-- Fetch CompletionTechnicianID based on @CompletionFitter
				SELECT @CompletionTechnicianID = NULL

				SELECT @CompletionTechnic;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOCompletionStaging') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOCompletionStaging;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: Feb 22, 2016
-- Description:	Imports a WO Completion Import
--				Primarily done to update status
--				and Completion Fitter/Completion
--				Date for WOs
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOCompletionStaging]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@WO [dbo].[UTP_WOCompletionImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportHeader]
           ([ImportBatchID]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   ,[Col4]
		   ,[Col5]
		   ,[Col6]
		   ,[Col7]
           )
     VALUES
           (@ImportBatchID,
			'WONUM',
			'PremiseNo',
			'WMStatus',
			'CompletionFitter',
			'CompletionDate',
			'MeterStatus',
			'COA'
			)

	INSERT INTO [dbo].[UTP_ImportData]
           ([ImportBatchID]
           ,[ImportStatusID]
           ,[ErrorMessage]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   ,[Col4]
		   ,[Col5]
		   ,[Col6]
		   ,[Col7]
           )
	SELECT 
		@ImportBatchID,
		1100, -- TODO Will need to determine initial import status ID and hardcore here
		NULL, -- Insert NULL for error message
		[WONUM],
		[PremiseNo],
		[WMStatus],
		[Completion Fitter],
		[Completion Date],
		[MeterStatus],
		[COA]
	FROM @WO
END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOCustomerContactInfoFinal') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOCustomerContactInfoFinal;
GO

-- ========================================
-- Author:		Jeff Moretti
-- Create date: April 26, 2017
-- Description:	Imports data from staging
--				tables (ImportHeader and
--				Import data) into actual
--				desired tables.  Done based
--				on the Customer Contact Info
--				Import.
-- 05/24/2017 JLM -- Now updates service address
--					 in WO Header
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOCustomerContactInfoFinal]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@OrgID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare scalar variables to insert WO Import data into
	DECLARE @PremiseNo varchar(30)
	DECLARE @WONUM varchar(15)
	DECLARE @StreetNo varchar(10)
	DECLARE @Sfx varchar(10)
	DECLARE @Street varchar(50)
	DECLARE @Raw varchar(50)
	DECLARE @City varchar(50)
	DECLARE @ProvinceCode varchar(5)
	DECLARE @PostalCode varchar(20)
	DECLARE @Name varchar(200)
	DECLARE @HomePhone varchar(20)
	DECLARE @MailingName varchar(255)
	DECLARE @District varchar(50)
	DECLARE @MailAdd varchar(200)
	DECLARE @MailAdd2 varchar(200)
	DECLARE @MailAdd3 varchar(200)
	DECLARE @MailCity varchar(50)
	DECLARE @MailPc varchar(20)

	DECLARE wo_cursor CURSOR FOR 
		SELECT
		    [Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		FROM UTP_ImportData WHERE ImportBatchID = @ImportBatchID
		ORDER BY ImportDataID
	OPEN wo_cursor
	FETCH NEXT FROM wo_cursor INTO
			@WONUM,
			@PremiseNo,
			@StreetNo,
			@Sfx,
			@Street,
			@Raw,
			@City,
			@ProvinceCode,
			@PostalCode,
			@Name,
			@HomePhone,
			@MailingName,
			@District,
			@MailAdd,
			@MailAdd2,
			@MailAdd3,
			@MailCity,
			@MailPc

	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- Fetch DataAttributeIDs
		DECLARE @PremiseNoDAID INT

		SELECT @PremiseNoDAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'PremiseNo'
		AND Category = 'UTP_WO'

		DECLARE @ProvinceID INT
		DECLARE @AddressID INT
		DECLARE @MailingAddressID INT
		DECLARE @WMStatusID INT
		DECLARE @CompletionTechnicianID INT
		DECLARE @SafetyCommentsConcat VARCHAR(400)
		DECLARE @ServiceAddress varchar(400)
		DECLARE @DisplayAddress varchar(400)

		DECLARE @oldOrderID INT

		SET @oldOrderID = -5

		IF @WONUM IS NOT NULL
		BEGIN
			SELECT @oldOrderID=OrderID FROM UTP_WO WHERE WONUM=@WONUM
		END
		IF @oldOrderID = 5
		BEGIN
			IF (SELECT COUNT(*) FROM UTP_Spec us LEFT JOIN UTP_Order uo ON us.OrderID = uo.OrderID
				INNER JOIN UTP_WO uw ON uw.OrderID = uo.OrderID 
				WHERE us.DataAttributeID = @PremiseNoDAID AND us.AttributeValue = @PremiseNo) = 1
			BEGIN
				SELECT @oldOrderID = uo.OrderID
				FROM UTP_Spec us
				LEFT JOIN UTP_Order uo ON us.OrderID = uo.OrderID
				INNER JOIN UTP_WO uw ON uw.OrderID = uo.OrderID
				WHERE us.DataAttributeID = @PremiseNoDAID
				AND us.AttributeValue = @PremiseNo
			END
		END

		IF @oldOrderID <> -5
		BEGIN
			-- Found already existing WO.  Can now update customer contact info

			-- Also want to update UTP_Contact (for customer name, etc)
			UPDATE UTP_Contact
			SET ContactName = @Name, ContactPhone = @HomePhone
			WHERE OrderID = @oldOrderID
				And ContactTypeID in (1801) --dbo.fnUTP_GetListMaster('ContactType','OCCUPANT')

			IF @@ROWCOUNT = 0
			BEGIN
				INSERT INTO UTP_Contact (OrderID, ContactTypeID, ContactName, ContactPhone)
				VALUES (@oldOrderID, 1801, @Name, @HomePhone), (@oldOrderID, 1803, @Name, @HomePhone)
			END

			-- update UTP_Contact for Mailing info as well
			UPDATE UTP_Contact
			SET ContactName = @MailingName
			WHERE;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOCustomerContactInfoStaging') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOCustomerContactInfoStaging;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 26, 2017
-- Description:	Updates Customer Contact Info
--				for the given WOs.  Staging
--				import imports into
--				UTP_ImportData, and will
--				then be filled by 'Final' SP
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOCustomerContactInfoStaging]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@WO [dbo].[UTP_WOCustomerContactInfoImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportHeader]
           ([ImportBatchID]
           ,[Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		   )
     VALUES
           (@ImportBatchID,
			'WONUM',
			'PremiseNo',
			'StreetNo',
			'Sfx',
			'Street',
			'Raw',
			'City',
			'ProvinceCode',
			'PostalCode',
			'Name',
			'HomePhone',
			'MailingName',
			'District',
			'MailAdd',
			'MailAdd2',
			'MailAdd3',
			'MailCity',
			'MailPc'
			)

	INSERT INTO [dbo].[UTP_ImportData]
           ([ImportBatchID]
           ,[ImportStatusID]
           ,[ErrorMessage]
           ,[Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		   )
	SELECT 
		@ImportBatchID,
		1100, -- TODO Will need to determine initial import status ID and hardcore here
		NULL, -- Insert NULL for error message
		[WONUM],
		[PremiseNo],
		[StreetNo],
		[Sfx],
		[Street],
		[Raw],
		[City],
		[ProvinceCode],
		[PostCode],
		[Name],
		[HomePhone],
		[MailingName],
		[District],
		[MAIL ADD],
		[MAIL ADD2],
		[MAIL ADD3],
		[MAIL CITY],
		[MAIL PC]
	FROM @WO
END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOLPCDataValidation') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOLPCDataValidation;
GO









-- =============================================
-- Author:		Jeff Moretti
-- Create date: Aug 15, 2018
-- Description:	Validates the data in the @WO
--				TVP (which will afterwards be
--				uploaded into Utopis).  Checks
--				to verify that:
-- 1)	Confirm that if a new Build or Install WO 
-- is to be created, confirm that the (EGD) supplied 
-- WONUM is unique (ie doesn’t already exist in the DB)
-- 2)	Confirm that if a new Build or Install WO is to 
-- be created, confirm that there is not already another 
-- Build/Install WO with the given LPC PO #
--
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOLPCDataValidation]
	@WO [dbo].[UTP_WOLPCImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



	-- Declare scalar variables to insert WO Import data into	
	DECLARE @LPCPONumber varchar(15)
	DECLARE @BuildWONUM varchar(15)
	DECLARE @BuildJobCode varchar(100)
	DECLARE @InstallWONUM varchar(15)
	DECLARE @InstallJobCode varchar(100)

	DECLARE @ImportWOLPCDataValidationResults UTP_DataValidationType

	DECLARE wo_cursor CURSOR FOR 
		SELECT 
			[LPC P.O.#],
			[Build WONUM],
			[Build],
			[Install WONUM],
			[Install]
		FROM @WO
	OPEN wo_cursor
	FETCH NEXT FROM wo_cursor INTO
			@LPCPONumber,
			@BuildWONUM,
			@BuildJobCode,
			@InstallWONUM,
			@InstallJobCode

	WHILE @@FETCH_STATUS = 0
	BEGIN

		DECLARE @lLPCWONUM_DAID INT
		DECLARE @lLPCPO_DAID INT

		SELECT @lLPCWONUM_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lLPCWONUM'
		AND Category = 'LPC'

		SELECT @lLPCPO_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lLPCPO'
		AND Category = 'LPC'

		-- 1)	Confirm that if a new Build or Install WO 
		--		is to be created, confirm that the (EGD) supplied 
		--		WONUM is unique (ie doesn’t already exist in the DB)

		IF NOT (@BuildJobCode IS NULL OR @BuildJobCode = '')
		BEGIN
			INSERT INTO @ImportWOLPCDataValidationResults ([Val2])
			SELECT AttributeValue FROM UTP_Spec
			WHERE DataAttributeID = @lLPCWONUM_DAID AND AttributeValue = @BuildWONUM
		END

		IF NOT (@InstallJobCode IS NULL OR @InstallJobCode = '')
		BEGIN
			INSERT INTO @ImportWOLPCDataValidationResults ([Val3])
			SELECT AttributeValue FROM UTP_Spec
			WHERE DataAttributeID = @lLPCWONUM_DAID AND AttributeValue = @InstallWONUM
		END

		-- 2)	Confirm that if a new Build or Install WO is to 
		--		be created, confirm that there is not already another 
		--		Build/Install WO with the given LPC PO #

		IF NOT (@BuildJobCode IS NULL OR @BuildJobCode = '')
		BEGIN
			INSERT INTO @ImportWOLPCDataValidationResults ([Val1],[Val2])
			SELECT s.AttributeValue, 'Dup Build WO' 
			FROM UTP_Spec s
			INNER JOIN UTP_WO wo ON s.OrderID = wo.OrderID
			WHERE s.DataAttributeID = @lLPCPO_DAID AND s.AttributeValue = @LPCPONumber
			AND dbo.fnCAT_LPCWOType(wo.JobCodeID) = 2 -- this line indicates that the current WO is a build WO
		END

		IF NOT (@InstallJobCode IS NULL OR @InstallJobCode = '')
		BEGIN
			INSERT INTO @ImportWOLPCDataValidationResults ([Val1],[Val3])
			SELECT s.AttributeValue, 'Dup Install WO' 
			FROM UTP_Spec s
			INNER JOIN UTP_WO wo ON s.OrderID = wo.OrderID
			WHERE s.DataAttributeID = @lLPCPO_DAID AND s.AttributeValue = @LPCPONumber
			AND dbo.fnCAT_LPCWOType(wo.JobCodeID) = 3 -- this line indicates that the current WO is an install WO
		END

		FETCH NEXT FROM wo_cursor INTO
				@LPCPONumber,
				@BuildWONUM,
				@BuildJobCode,
				@InstallWONUM,
				@InstallJobCode
	END

	CLOSE wo_cursor  
	DEALLOCATE wo_cursor

	SELECT [Val1] AS [LPC P.O.#], [Val2] AS [Build WONUM], [Val3] AS [Install WONUM]
	FROM @ImportWOLPCDataValidationResults
	
END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOLPCFinal') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOLPCFinal;
GO






-- ========================================
-- Author:		Jeff Moretti
-- Create date: Aug 18, 2018
-- Description:	Imports data from staging
--				tables (ImportHeader and
--				Import data) into actual
--				desired tables
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOLPCFinal]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@OrgID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare scalar variables to insert WO Import data into	
	DECLARE @LPCPONumber varchar(15)
	DECLARE @StationNumber varchar(15)
	DECLARE @AreaCode varchar(20)
	DECLARE @StreetNo varchar(10)
	DECLARE @Sfx varchar(10)
	DECLARE @Street varchar(50)
	DECLARE @Raw varchar(50)
	DECLARE @City varchar(50)
	DECLARE @ProvinceCode varchar(5)
	DECLARE @PostalCode varchar(20)
	DECLARE @RequestedInstallDate datetime
	DECLARE @PreInspectJobCode varchar(100)
	DECLARE @BuildWONUM varchar(15)
	DECLARE @BuildJobCode varchar(100)
	DECLARE @InstallWONUM varchar(15)
	DECLARE @InstallJobCode varchar(100)
	DECLARE @DrawingNumber varchar(15)
	DECLARE @ContactName varchar(200)
	DECLARE @ContactNumber varchar(20)

	DECLARE wo_cursor CURSOR FOR 
		SELECT
		    [Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		   ,[Col19]
		FROM UTP_ImportData WHERE ImportBatchID = @ImportBatchID
		ORDER BY ImportDataID
	OPEN wo_cursor
	FETCH NEXT FROM wo_cursor INTO
			@LPCPONumber,
			@StationNumber,
			@AreaCode,
			@StreetNo,
			@Sfx,
			@Street,
			@Raw,
			@City,
			@ProvinceCode,
			@PostalCode,
			@RequestedInstallDate,
			@PreInspectJobCode,
			@BuildWONUM,
			@BuildJobCode,
			@InstallWONUM,
			@InstallJobCode,
			@DrawingNumber,
			@ContactName,
			@ContactNumber

	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- Fetch DataAttributeIDs
		DECLARE @lLPCPO_DAID INT
		DECLARE @lSTNNUM_DAID INT
		DECLARE @lDWGNUM_DAID INT
		DECLARE @lREQDAT_DAID INT
		DECLARE @lLPCWONUM_DAID INT
		DECLARE @eMBREQD_DAID INT
		DECLARE @eMTNBR_DAID INT
		DECLARE @lSHPTO_DAID INT
		DECLARE @lSTNSVINST_DAID INT
		DECLARE @lSTNSVTIE_DAID INT

		SELECT @lLPCPO_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lLPCPO'
		AND Category = 'LPC'

		SELECT @lSTNNUM_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lSTNNUM'
		AND Category = 'LPC'

		SELECT @lDWGNUM_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lDWGNUM'
		AND Category = 'LPC'

		SELECT @lREQDAT_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lREQDAT'
		AND Category = 'LPC'

		SELECT @lLPCWONUM_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lLPCWONUM'
		AND Category = 'LPC'

		SELECT @eMBREQD_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'eMBREQD'
		AND Category = 'EGD_FA'

		SELECT @eMTNBR_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'eMTNBR'
		AND Category = 'EGD_FA'

		SELECT @lSHPTO_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lSHPTO'
		AND Category = 'LPC'

		SELECT @lSTNSVINST_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lSTNSVINST'
		AND Category = 'LPC'

		SELECT @lSTNSVTIE_DAID = DataAttributeID 
		FROM UTP_DataAttribute
		WHERE AttributeName = 'lSTNSVTIE'
		AND Category = 'LPC'

		--DECLARE @TechnicianID INT
		DECLARE @AreaID INT
		DECLARE @ProvinceID INT
		DECLARE @AddressID INT
		--DECLARE @MailingAddressID INT
		DECLARE @WMStatusID INT
		--DECLARE @CompletionTechni;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOLPCStaging') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOLPCStaging;
GO





-- =============================================
-- Author:		Jeff Moretti
-- Create date: Aug 15, 2018
-- Description:	Imports a list of WOs via the LPC
--				Import process.  Imports into
--				staging table, to be later
--				inserted into the actual table
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOLPCStaging]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@WO [dbo].[UTP_WOLPCImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportHeader]
           ([ImportBatchID]
           ,[Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		   ,[Col19]
		   )
     VALUES
           (@ImportBatchID,
			'LPCPONumber',
			'StationNumber',
			'AreaCode',
			'StreetNo',
			'Sfx',
			'Street',
			'Raw',
			'City',
			'ProvinceCode',
			'PostalCode',
			'RequestedInstallDate',
			'PreInspectJobCode',
			'BuildWONUM',
			'BuildJobCode',
			'InstallWONUM',
			'InstallJobCode',
			'DrawingNumber',
			'ContactName',
			'ContactNumber'
			)

	INSERT INTO [dbo].[UTP_ImportData]
           ([ImportBatchID]
           ,[ImportStatusID]
           ,[ErrorMessage]
           ,[Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		   ,[Col19]
		   )
	SELECT 
		@ImportBatchID,
		1100, -- TODO Will need to determine initial import status ID and hardcore here
		NULL, -- Insert NULL for error message
		[LPC P.O.#],
		[Station#],
		[AreaCode],
		[StreetNo],
		[Sfx],
		[Street],
		[Raw],
		[City],
		[ProvinceCode],
		[PostCode],
		[Requested Install Date],
		[Pre-Inspect],
		[Build WONUM],
		[Build],
		[Install WONUM],
		[Install],
		[Drawing#],
		[ContactName],
		[ContactNumber]
	FROM @WO
END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOModifyStatusFinal') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOModifyStatusFinal;
GO
-- ========================================
-- Author:		Jeff Moretti
-- Create date: June 6, 2017
-- Description:	Imports data from staging
--				tables (ImportHeader and
--				Import data) into actual
--				desired tables.  Done based
--				on the Modify Status Import
-- 07/07/17 JLM - added support for projects;
--				  now sets ApptStartDate and
--				  ApptEndDate from project
--				  when importing
-- 2018-04-12 IDM - Support transitions to ONHOLD
--				and CAN
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOModifyStatusFinal]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@OrgID INT,
	@ContractID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare scalar variables to insert WO Import data into
	DECLARE @WONUM varchar(15)
	DECLARE @Fitter varchar(50)
	DECLARE @WMStatus varchar(25)
	DECLARE @Priority int
	DECLARE @NewKey int

	-- retrieve ApptStartDate and ApptEndDate from project (via ContractID).
	-- will need to use these when insert new appt for ONHOLD to WSCH WOs.
	DECLARE @ApptStartDate DATETIME
	DECLARE @ApptEndDate DATETIME

	SELECT @ApptStartDate = ContractStartDate, @ApptEndDate = ContractEndDate
	FROM UTP_Contract
	WHERE ContractID = @ContractID

	DECLARE wo_cursor CURSOR FOR 
		SELECT
		    [Col1]
           ,[Col2]
           ,[Col3]
		FROM UTP_ImportData WHERE ImportBatchID = @ImportBatchID
		ORDER BY ImportDataID
	OPEN wo_cursor
	FETCH NEXT FROM wo_cursor INTO
			@WONUM,
			@Fitter,
			@WMStatus

	WHILE @@FETCH_STATUS = 0
	BEGIN

		--DECLARE @WMStatusID INT

		DECLARE @oldOrderID INT

		SET @oldOrderID = -5

		-- fetch order id based on WONUM.
		SELECT @oldOrderID = OrderID
		FROM UTP_WO
		WHERE WONUM = @WONUM

		IF @oldOrderID <> -5
		BEGIN
			-- Found already existing WO.  Can now update Appt Status (based on given WMStatus)
			-- Make sure to only update if current WO has WMStatus = WSCH, SCHED, ONHOLD,
			-- DISP, ACK, ENROUTE, or ONSITE.
			DECLARE @oldWMStatusID INT, @WMStatusID INT
			DECLARE @oldWMStatus varchar(25)
			DECLARE @TechnicianID INT
			DECLARE @ToSabre INT
			DECLARE @SendToSabre INT
			DECLARE @HHNewWorkEnabled INT
			DECLARE @OldApptID INT
			DECLARE @NewApptID INT
			DECLARE @ApptStatusID INT
			DECLARE @Memo UTP_OrderHistoryType, @ROWS int
			
			SELECT @oldWMStatusID = NULL, @WMStatusID = NULL
			SELECT @oldWMStatus = NULL
			SELECT @TechnicianID = NULL
			SELECT @ToSabre = NULL
			SELECT @SendToSabre = 0
			SELECT @HHNewWorkEnabled = 0
			SELECT @OldApptID = NULL
			SELECT @ApptStatusID = NULL
			DELETE @MEMO

			SELECT @HHNewWorkEnabled=dbo.fnUTP_MessageEnabled('HHSUBADDWR31','UTP_ImportWOModifyStatusFinal')
			SELECT @oldWMStatusID=WMStatusID,@oldWMStatus=WMStatus,@ToSabre=ToSabre FROM vw_TPS_WO WHERE OrderID=@oldOrderID
			
			if @oldWMStatus IN ('ONHOLD','WSCH') AND @WMStatus IN ('WSCH','ONHOLD','CAN') AND @oldWMStatus <> @WMStatus
			BEGIN
				-- Fetch TechnicianID based on @Fitter
				SELECT @TechnicianID = UserID
				FROM UTP_User
				WHERE UserName = @Fitter

				IF @TechnicianID IS NOT NULL AND @ToSabre = 1 AND @HHNewWorkEnabled = 1 SELECT @SendToSabre = HasHandHeld FROM UTP_Technician WHERE UserID=@TechnicianID
				SELECT @WMStatusID=ListID FROM UTP_ListMaster WHERE ListKey='WMStatus' AND ListValue=@WMStatus

				IF (@oldWMStatus = 'ONHOLD') AND (@WMStatus = 'WSCH')
				BEGIN
					-- If new WMStatus = WSCH, will want to update WMStatus to WSCH
					-- in UTP_WO and Apt Status to 'Ready' in UTP_Appointment

					-- Update Technician and Status on WO
					UPDATE UTP_WO
					SET TechnicianID = @TechnicianID,
					WMStatusID=CASE @SendToSabre WHEN 1 THEN 104 /* DISP */ ELSE 101 /* WSCH */ END
					WHERE OrderID = @oldOrderID

					-- Also need to create a row in the UTP_Appointment table, and copy data in;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOModifyStatusStaging') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOModifyStatusStaging;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: June 6, 2017
-- Description:	Updates status (ApptStatus) for
--				the input WOs, based on input
--				WMStatus
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOModifyStatusStaging]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@WO [dbo].[UTP_WOModifyStatusImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportHeader]
           ([ImportBatchID]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   )
     VALUES
           (@ImportBatchID,
		    'WONUM',
			'Fitter',
			'WMStatus'
			)

	INSERT INTO [dbo].[UTP_ImportData]
           ([ImportBatchID]
           ,[ImportStatusID]
           ,[ErrorMessage]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   )
	SELECT 
		@ImportBatchID,
		1100, -- TODO Will need to determine initial import status ID and hardcore here
		NULL, -- Insert NULL for error message
		[WONUM],
		[Fitter],
		[WMStatus]
	FROM @WO
END






;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOReassignTechUGDKUFinal') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOReassignTechUGDKUFinal;
GO


-- ========================================
-- Author:		Jeff Moretti
-- Create date: March 10, 2017
-- Description:	Imports data from staging
--				tables (ImportHeader and
--				Import data) into actual
--				desired tables. Done based
--				on the ReassignTech import
--	jm Nov 8 2018 - Now allowing cancelled
--					appts to be handled
--					(ie 'rebooked')
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOReassignTechUGDKUFinal]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@OrgID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare scalar variables to insert WO Import data into
	DECLARE @WONUM varchar(15)
	DECLARE @Fitter varchar(50)
	DECLARE @AreaCode varchar(20)

	DECLARE wo_cursor CURSOR FOR 
		SELECT
		    [Col1]
           ,[Col2]
           ,[Col3]
		FROM UTP_ImportData WHERE ImportBatchID = @ImportBatchID
		ORDER BY ImportDataID
	OPEN wo_cursor
	FETCH NEXT FROM wo_cursor INTO
			@WONUM,
			@Fitter,
			@AreaCode

	WHILE @@FETCH_STATUS = 0
	BEGIN

		DECLARE @TechnicianID INT
		DECLARE @AreaID INT

		DECLARE @oldOrderID INT
		
		DECLARE @OrderHistoryOrderID int
		DECLARE @Memo UTP_OrderHistoryType, @ROWS int

		SET @oldOrderID = -5

		SELECT @oldOrderID = OrderID
		FROM UTP_WO
		WHERE WONUM = @WONUM

		IF @oldOrderID <> -5
		BEGIN

			-- Fetch TechnicianID based on @Fitter
			SELECT @TechnicianID = NULL

			SELECT @TechnicianID = UserID
			FROM UTP_User
			WHERE UserName = @Fitter

			-- Fetch AreaID based on @AreaCode
			SELECT @AreaID = NULL

			SELECT @AreaID = GroupID
			FROM UTP_Group
			WHERE GroupCode = @AreaCode

			UPDATE UTP_WO
			SET AreaID = @AreaID, TechnicianID = @TechnicianID
			WHERE OrderID = @oldOrderID

			-- Also need to create a row in the UTP_Appointment table, copy data into it from the old appointment, and set the previous appointment to 'cancelled'
			DECLARE @OldApptID INT
			DECLARE @NewApptID INT
			DECLARE @ApptStatusID INT
			
			-- fetch previous appt row
			SELECT @OldApptID = NULL
			SELECT @ApptStatusID = NULL

			SELECT TOP 1 @OldApptID = AppointmentID,
					@ApptStatusID = AppointmentStatusID
			FROM UTP_Appointment
			WHERE OrderID = @oldOrderID
			ORDER BY AppointmentID DESC

			IF @ApptStatusID in (90320,90321,90329,90322) -- only if open -- JEFFM EDIT 20181108 Now allowing cancelled appts, as sometimes ReassignTech is done when appt is in a cancelled state
			BEGIN
			-- create new appt row here
			INSERT INTO UTP_Appointment
			([TechnicianID]
			,[AppointmentTypeID]
			,[OrderID]
			,[AppointmentStatusID]
			,[TimeslotID]
			,[BookedViaID]
			,[CreatedTimestamp]
			,[ExpectedDuration]
			,[PreferredContactModeID]
			,[ModifiedTimestamp]
			,[ContactID]
			,[ApptStartDate]
			,[CompletionCode]
			,[ActualStart]
			,[ActualFinish]
			,[ApptEndDate]
			,[ApptStartTime]
			,[ApptEndTime]
			,[SpecialInstructions]
			,[CreatedByID]
			,[ModifiedByID]
			,[AccessRestricted]
			,[MedicalNecessity]
			,[IsFirmAppt]
			,[MeterLeftStatus]
			)
			SELECT
			[TechnicianID]
			,[AppointmentTypeID]
			,[OrderID]
			,[AppointmentStatusID]
			,[TimeslotID]
			,[BookedViaID]
			,[CreatedTimestamp]
			,[ExpectedDuration]
			,[PreferredContactModeID]
			,[ModifiedTimestamp]
			,[ContactID]
			,[ApptStartDate]
			,[CompletionCode]
			,[ActualStart]
			,[ActualFinish]
			,[ApptEndDate]
			,[ApptStartTime]
			,[ApptEndTime]
			,[SpecialInstructions]
			,[CreatedByID]
			,[ModifiedByID]
			,[AccessRestricted]
			,[MedicalNecessity]
			,[IsFirmAppt]
			,[MeterLeftStatus]
			FROM UTP_Appointment
			WHERE AppointmentID = @OldApptID

			SELECT @NewApptID = SCOPE_IDENTITY()

			-- set old appointment to cancelled
			UPDATE UTP_Appointment
			SET AppointmentStatusID = 90322 -- cancelled
			WHERE Ap;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOReassignTechUGDKUStaging') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOReassignTechUGDKUStaging;
GO























-- =============================================
-- Author:		Jeff Moretti
-- Create date: March 10, 2017
-- Description:	Used to reassign technician to
--				WOs, based on input WO list.
--				Used by UGD and KU.
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOReassignTechUGDKUStaging]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@WO [dbo].[UTP_WOReassignTechUGDKUImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportHeader]
           ([ImportBatchID]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   )
     VALUES
           (@ImportBatchID,
			'WONUM',
			'Fitter',
			'AreaCode'
			)

	INSERT INTO [dbo].[UTP_ImportData]
           ([ImportBatchID]
           ,[ImportStatusID]
           ,[ErrorMessage]
           ,[Col1]
           ,[Col2]
           ,[Col3]
           )
	SELECT 
		@ImportBatchID,
		1100, -- TODO Will need to determine initial import status ID and hardcore here
		NULL, -- Insert NULL for error message
		[WONUM],
		[Fitter],
		[AreaCode]
	FROM @WO


END























;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWorkOrderCheckFitterExists') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWorkOrderCheckFitterExists;
GO


-- =============================================
-- Author:		Jeff Moretti
-- Create date: Aug 19 2016
-- Description:	Checks to see if the input
--				fitter exists in the DB
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWorkOrderCheckFitterExists]
	@Fitter varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT UserID
	FROM UTP_User
	WHERE UserName = @Fitter
END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWorkOrderCheckFitterExistsBatch') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWorkOrderCheckFitterExistsBatch;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: Aug 31 2018
-- Description:	Checks to see if the input 'batch'
--				of fitters exist in the DB.
--				Returns a list of 'fitter'
--				usernames that could not be found
--				in the DB.
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWorkOrderCheckFitterExistsBatch]
	@FitterDataValidation [dbo].[UTP_DataValidationType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	-- Declare scalar variables
	DECLARE @Fitter varchar(50)
	DECLARE @CompletionFitter varchar(50)

	DECLARE @UserID INT
	DECLARE @ImportWorkOrderCheckFitterExistResults UTP_DataValidationType

	DECLARE data_validation_cursor CURSOR FOR 
		SELECT 
			[Val1],
			[Val2]
		FROM @FitterDataValidation
	OPEN data_validation_cursor
	FETCH NEXT FROM data_validation_cursor INTO
			@Fitter,
			@CompletionFitter

	WHILE @@FETCH_STATUS = 0
	BEGIN

	SELECT @UserID = NULL

	IF NOT (@Fitter IS NULL OR @Fitter = '')
	BEGIN

		SELECT @UserID = UserID
		FROM UTP_User
		WHERE UserName = @Fitter

		IF @UserID IS NULL
		BEGIN
			INSERT INTO @ImportWorkOrderCheckFitterExistResults ([Val1]) VALUES (@Fitter)
		END
	END

	SELECT @UserID = NULL

	IF NOT (@CompletionFitter IS NULL OR @CompletionFitter = '')
	BEGIN

		SELECT @UserID = UserID
		FROM UTP_User
		WHERE UserName = @CompletionFitter

		IF @UserID IS NULL
		BEGIN
			INSERT INTO @ImportWorkOrderCheckFitterExistResults ([Val2]) VALUES (@CompletionFitter)
		END
	END

	FETCH NEXT FROM data_validation_cursor INTO
				@Fitter,
				@CompletionFitter
	END

	CLOSE data_validation_cursor  
	DEALLOCATE data_validation_cursor

	SELECT [Val1] AS [Fitter], [Val2] AS [Completion Fitter]
	FROM @ImportWorkOrderCheckFitterExistResults
	
END



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWorkOrderFinal') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWorkOrderFinal;
GO

-- ========================================
-- Author:		Jeff Moretti
-- Create date: April 22, 2016
-- Description:	Imports data from staging
--				tables (ImportHeader and
--				Import data) into actual
--				desired tables
-- Revisions: 
--	JLM 10/6/2016 -- altered new WOs imported
--					 to have status = 90325 (complete)
--					 if completion date is defined.
--					 Otherwise, status is ready (90320)
				  -- NOTE: reverted status on
--					 new imports back to booked
--					 status since it causes
--					 issues with other SPs.
--					 (when checking status)		
--  JLM 10/14/2016-- set WMStatusID to previous
--					 WO value (rather than
--					 overwriting with WSCH)
--					 when re-importing a WO
--				     with no WM Status value
--				  -- set AttributeName for
--				     UTP_Spec values		   
--  JLM 10/18/2016-- again setting new appts
--				     to have status = 90320
--					 (ready) for new WOs
--	JLM 10/27/2016-- bugfix with checking
--					 'null' on completion
--					 date
--  JLM 03/07/2017-- added support for new
--					 columns > Mailing info,
--					 and safety codes
--  JLM 04/17/2017-- added COA comment
--					 to OrderHistory; added
--					 COA status to UTP_Appointment
--  JLM 05/24/2017-- insert ServiceAddress into
--					 WO Header (UTP_WO)
--	IDM 2017-06-12-- Lookup by PremiseNo, JobCode,
--					 JobType and Comments -
--					 Support multiple WOs per
--					 PremiseNo
--	IDM 2017-06-23	 Altered so ONHOLD Status sets
--					 AppointmentStatus=Ready
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWorkOrderFinal]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@OrgID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare scalar variables to insert WO Import data into
	DECLARE @PremiseNo varchar(30)
	DECLARE @SealGroup varchar(15)
	DECLARE @SendLetterDate date
	DECLARE @Comments varchar(50)
	DECLARE @Cycle varchar(15)
	DECLARE @Fitter varchar(50)
	DECLARE @ServiceCode varchar(15)
	DECLARE @AreaCode varchar(20)
	DECLARE @Grid varchar(15)
	DECLARE @StreetNo varchar(10)
	DECLARE @Sfx varchar(10)
	DECLARE @Street varchar(50)
	DECLARE @Raw varchar(50)
	DECLARE @City varchar(50)
	DECLARE @ProvinceCode varchar(5)
	DECLARE @PostalCode varchar(20)
	DECLARE @CustomerType varchar(20)
	DECLARE @BuildingType varchar(20)
	DECLARE @Name varchar(200)
	DECLARE @HomePhone varchar(20)
	DECLARE @MeterStatus varchar(25)
	DECLARE @MeterLocationCode varchar(10)
	DECLARE @MeterSizeCode varchar(25)
	DECLARE @MeterNo varchar(25)
	DECLARE @JobType varchar(25)
	DECLARE @JobCode varchar(25)
	DECLARE @WMStatus varchar(25)
	DECLARE @CompletionFitter varchar(50)
	DECLARE @CompletionDate datetime
	DECLARE @MailingName varchar(255)
	DECLARE @District varchar(50)
	DECLARE @MailAdd varchar(200)
	DECLARE @MailAdd2 varchar(200)
	DECLARE @MailAdd3 varchar(200)
	DECLARE @MailCity varchar(50)
	DECLARE @MailPc varchar(20)
	DECLARE @SafetyCode varchar(100)
	DECLARE @SafetyCInd varchar(100)
	DECLARE @SafetyCom varchar(200)
	DECLARE @COA varchar(200)

	DECLARE wo_cursor CURSOR FOR 
		SELECT
		    [Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		   ,[Col19]
		   ,[Col20]
		   ,[Col21]
		   ,[Col22]
		   ,[Col23]
		   ,[Col24]
		   ,[Col25]
		   ,[Col26]
		   ,[Col27]
		   ,[Col28]
		   ,[Col29]
		   ,[Col30]
		   ,[Col31]
		   ,[Col32]
		   ,[Col33]
		   ,[Col34]
		   ,[Col35]
		   ,[Col36]
		   ,[Col37]
		   ,[Col38]
		   ,[Col39]
		   ,[Col40]
		FROM UTP_ImportData WHERE ImportBatchID = @ImportBatchID
		ORDER BY Impo;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWorkOrderGetWONUMs') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWorkOrderGetWONUMs;
GO

-- ========================================
-- Author:		Jeff Moretti
-- Create date: March 2, 2017
-- Description:	Retrieves WONUMs from an import
--				that has just completed.  Used
--				to help populate the input 
--				spreadsheet with WONUMs
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWorkOrderGetWONUMs]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @PremiseNoDAID INT

	SELECT @PremiseNoDAID = DataAttributeID 
	FROM UTP_DataAttribute
	WHERE AttributeName = 'PremiseNo'
	AND Category = 'UTP_WO'

	-- Returns list of WONUMs matched up by PremiseNo
	-- NOTE: Col1 in UTP_ImportData is storing the PremiseNo
	SELECT uw.WONUM, impData.Col1 AS PremiseNo
	FROM UTP_ImportData impData
	INNER JOIN UTP_Spec us ON us.AttributeValue = impData.Col1
	JOIN UTP_DataAttribute dajc ON dajc.AttributeName='JobCode' AND dajc.Category='UTP_WO'
	JOIN UTP_Spec sjc ON sjc.DataAttributeID=dajc.DataAttributeID AND sjc.OrderID=us.OrderID
	JOIN UTP_DataAttribute dajt ON dajt.AttributeName='JobType' AND dajc.Category='UTP_WO'
	JOIN UTP_Spec sjt ON sjt.DataAttributeID=dajt.DataAttributeID AND sjt.OrderID=us.OrderID
	JOIN UTP_DataAttribute dac ON dac.AttributeName='Comments' AND dajc.Category='UTP_WO'
	JOIN UTP_Spec sc ON sc.DataAttributeID=dac.DataAttributeID AND sc.OrderID=us.OrderID
	INNER JOIN UTP_WO uw ON us.OrderID = uw.OrderID
	WHERE us.DataAttributeID = @PremiseNoDAID AND sjc.AttributeValue=impData.Col26 AND sjt.AttributeValue=impData.Col25 AND sc.AttributeValue=impData.Col4
		AND impData.ImportBatchID = @ImportBatchID
	ORDER BY ImportDataID

END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWorkOrderStaging') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWorkOrderStaging;
GO

-- =============================================
-- Author:		Jeff Moretti
-- Create date: April 21, 2016
-- Description:	Imports a list of WOs into the
--				system (generic).  Imports into
--				staging table, to be later
--				inserted into the actual table
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWorkOrderStaging]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@WO [dbo].[UTP_WOImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportHeader]
           ([ImportBatchID]
           ,[Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		   ,[Col19]
		   ,[Col20]
		   ,[Col21]
		   ,[Col22]
		   ,[Col23]
		   ,[Col24]
		   ,[Col25]
		   ,[Col26]
		   ,[Col27]
		   ,[Col28]
		   ,[Col29]
		   ,[Col30]
		   ,[Col31]
		   ,[Col32]
		   ,[Col33]
		   ,[Col34]
		   ,[Col35]
		   ,[Col36]
		   ,[Col37]
		   ,[Col38]
		   ,[Col39]
		   ,[Col40]
		   )
     VALUES
           (@ImportBatchID,
			'PremiseNo',
			'SealGroup',
			'SendLetterDate',
			'Comments',
			'Cycle',
			'Fitter',
			'ServiceCode',
			'AreaCode',
			'GridCode',
			'StreetNo',
			'Sfx',
			'Street',
			'Raw',
			'City',
			'ProvinceCode',
			'PostalCode',
			'CustomerType',
			'BuildingType',
			'Name',
			'HomePhone',
			'MeterStatus',
			'MeterLocationCode',
			'MeterSizeCode',
			'MeterNo',
			'JobType',
			'JobCode',
			'WMStatus',
			'CompletionFitter',
			'CompletionDate',
			'MailingName',
			'District',
			'MailAdd',
			'MailAdd2',
			'MailAdd3',
			'MailCity',
			'MailPc',
			'SafetyCode',
			'SafetyCInd',
			'SafetyCom',
			'COA'
			)

	INSERT INTO [dbo].[UTP_ImportData]
           ([ImportBatchID]
           ,[ImportStatusID]
           ,[ErrorMessage]
           ,[Col1]
           ,[Col2]
           ,[Col3]
           ,[Col4]
           ,[Col5]
           ,[Col6]
           ,[Col7]
           ,[Col8]
           ,[Col9]
           ,[Col10]
           ,[Col11]
		   ,[Col12]
		   ,[Col13]
		   ,[Col14]
		   ,[Col15]
		   ,[Col16]
		   ,[Col17]
		   ,[Col18]
		   ,[Col19]
		   ,[Col20]
		   ,[Col21]
		   ,[Col22]
		   ,[Col23]
		   ,[Col24]
		   ,[Col25]
		   ,[Col26]
		   ,[Col27]
		   ,[Col28]
		   ,[Col29]
		   ,[Col30]
		   ,[Col31]
		   ,[Col32]
		   ,[Col33]
		   ,[Col34]
		   ,[Col35]
		   ,[Col36]
		   ,[Col37]
		   ,[Col38]
		   ,[Col39]
		   ,[Col40]
		   )
	SELECT 
		@ImportBatchID,
		1100, -- TODO Will need to determine initial import status ID and hardcore here
		NULL, -- Insert NULL for error message
		[PremiseNo],
		[SealGroup],
		[SendLetterDate],
		[Comments],
		[Cycle],
		[Fitter],
		[ServiceCode],
		[AreaCode],
		[Grid],
		[StreetNo],
		[Sfx],
		[Street],
		[Raw],
		[City],
		[ProvinceCode],
		[PostCode],
		[CustomerType],
		[BuildingType],
		[Name],
		[HomePhone],
		[MeterStatus],
		[MeterLocationCode],
		[MeterSizeCode],
		[MeterNo],
		[Job Type],
		[Job Code],
		[WMStatus],
		[Completion Fitter],
		[Completion Date],
		[MailingName],
		[District],
		[MAIL ADD],
		[MAIL ADD2],
		[MAIL ADD3],
		[MAIL CITY],
		[MAIL PC],
		[SAFETY CODE],
		[SAFETY C IND],
		[SAFETY COM],
		[COA]
	FROM @WO
END
/****** Object:  StoredProcedure [dbo].[UTP_ImportWOCompletionFinal]    Script Date: 2017-04-12 9:24:35 AM ******/
SET ANSI_NULLS ON


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOSendLetterFinal') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOSendLetterFinal;
GO

-- ========================================
-- Author:		Jeff Moretti
-- Create date: March 22, 2017
-- Description:	Imports data from staging
--				tables (ImportHeader and
--				Import data) into actual
--				desired tables. Done based
--				on the Send Letter Date
--				import
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOSendLetterFinal]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@OrgID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare scalar variables to insert WO Import data into
	DECLARE @WONUM varchar(15)
	DECLARE @PremiseNo varchar(30)
	DECLARE @Fitter varchar(50)
	DECLARE @SendLetterDate date

	DECLARE wo_cursor CURSOR FOR 
		SELECT
		    [Col1]
           ,[Col2]
           ,[Col3]
		   ,[Col4]
		FROM UTP_ImportData WHERE ImportBatchID = @ImportBatchID
		ORDER BY ImportDataID
	OPEN wo_cursor
	FETCH NEXT FROM wo_cursor INTO
			@WONUM,
			@PremiseNo,
			@Fitter,
			@SendLetterDate

	WHILE @@FETCH_STATUS = 0
	BEGIN

		DECLARE @TechnicianID INT

		DECLARE @oldOrderID INT

		SET @oldOrderID = -5

		-- try to fetch order id based on WONUM.  If unsuccessful, try fetching order id based on PremiseNo
		SELECT @oldOrderID = OrderID
		FROM UTP_WO
		WHERE WONUM = @WONUM

		IF @oldOrderID = -5
		BEGIN

			DECLARE @PremiseNoDAID INT, @WOCount int=0

			SELECT @PremiseNoDAID = DataAttributeID 
			FROM UTP_DataAttribute
			WHERE AttributeName = 'PremiseNo'
			AND Category = 'UTP_WO'

			SELECT @WOCount=COUNT(*)
			FROM UTP_Spec us
			LEFT JOIN UTP_Order uo ON us.OrderID = uo.OrderID
			INNER JOIN UTP_WO uw ON uw.OrderID = uo.OrderID
			WHERE us.DataAttributeID = @PremiseNoDAID
			AND us.AttributeValue = @PremiseNo

			IF @WOCount = 1
			BEGIN
				SELECT @oldOrderID = uo.OrderID
				FROM UTP_Spec us
				LEFT JOIN UTP_Order uo ON us.OrderID = uo.OrderID
				INNER JOIN UTP_WO uw ON uw.OrderID = uo.OrderID
				WHERE us.DataAttributeID = @PremiseNoDAID
				AND us.AttributeValue = @PremiseNo
			END

		END

		IF @oldOrderID <> -5
		BEGIN

			-- Fetch TechnicianID based on @Fitter
			SELECT @TechnicianID = NULL

			SELECT @TechnicianID = UserID
			FROM UTP_User
			WHERE UserName = @Fitter

			-- Add record in OrderHistory
			DECLARE @OrderHistoryOrderID int

			SET @OrderHistoryOrderID = @oldOrderID

			If (select count(*) from UTP_OrderHistory where Memo like'Customer letter sent on ' + CONVERT(varchar(10), @SendLetterDate, 121)  + '%' and OrderID= @OrderHistoryOrderID) = 0
			BEGIN
				DECLARE @Memo UTP_OrderHistoryType, @ROWS int
				DELETE @Memo
				insert @Memo (OrderID, MemoTypeID, Memo, TechnicianID, Operation)
				select @OrderHistoryOrderID, 1001, 'Customer letter sent on ' + CONVERT(varchar(23), @SendLetterDate, 121), @TechnicianID, 'A'               
  
				EXEC UTP_UpdateXOrderHistory @Memo, 1, @ROWS out
			END

		END

		FETCH NEXT FROM wo_cursor INTO
			@WONUM,
			@PremiseNo,
			@Fitter,
			@SendLetterDate
	END

	CLOSE wo_cursor  
	DEALLOCATE wo_cursor
END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ImportWOSendLetterStaging') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ImportWOSendLetterStaging;
GO
























-- =============================================
-- Author:		Jeff Moretti
-- Create date: March 20, 2017
-- Description:	Used to update send letter date
--				based on input WO list.
-- =============================================
CREATE PROCEDURE [dbo].[UTP_ImportWOSendLetterStaging]
	-- Add the parameters for the stored procedure here
	@ImportBatchID INT,
	@WO [dbo].[UTP_WOSendLetterImportType] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[UTP_ImportHeader]
           ([ImportBatchID]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   ,[Col4]
		   )
     VALUES
           (@ImportBatchID,
			'WONUM',
			'PremiseNo',
			'Fitter',
			'SendLetterDate'
			)

	INSERT INTO [dbo].[UTP_ImportData]
           ([ImportBatchID]
           ,[ImportStatusID]
           ,[ErrorMessage]
           ,[Col1]
           ,[Col2]
           ,[Col3]
		   ,[Col4]
           )
	SELECT 
		@ImportBatchID,
		1100, -- TODO Will need to determine initial import status ID and hardcore here
		NULL, -- Insert NULL for error message
		[WONUM],
		[PremiseNo],
		[Fitter],
		[SendLetterDate]
	FROM @WO


END
























;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewAppointment;
GO
-- DROP PROC [dbo].[UTP_NewAppointment]
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: March 10, 2017
-- Description: Called when creating a new UTP_Appointment record for a UTP WorkOrder
-- Returns: zero on failure, the non-zero AppointmentID on success
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_NewAppointment]
	@OrderID [int],
	@AppointmentTypeID int
AS
	DECLARE @ContactID int, @NewAppointmentID int

	SELECT @ContactID=[ContactID] FROM [dbo].[UTP_Contact] WHERE [OrderID]=@OrderID AND [ContactTypeID]=[dbo].[fnUTP_GetListMaster]('ContactType','CONTACT')
	
	INSERT INTO [dbo].[UTP_Appointment] ([AppointmentTypeID],[OrderID],[AppointmentStatusID],[CreatedTimestamp],[ContactID],[CreatedByID])
	VALUES (@AppointmentTypeID, @OrderID, /* READY */ 90320, GETDATE(), @ContactID, [dbo].[fnUTP_CurrentDomainUserID]())
	
	IF @@ROWCOUNT = 1 
	BEGIN
		SELECT @NewAppointmentID=SCOPE_IDENTITY()
		EXEC [dbo].[UTP_CancelAppointment] @OrderID, @NewAppointmentID
		RETURN @NewAppointmentID
	END
	ELSE RETURN 0



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewCustomer') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewCustomer;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 25, 2015
-- Description: New customer, creating org if it doesn't exist
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_NewCustomer]	
	@Name [varchar] (255),
	@ShortName [varchar] (50) = '',
	@OrgId int = null output
AS
	Select @OrgId = OrgID from UTP_Org where ShortName = @ShortName
	if @OrgID is null BEGIN
		INSERT INTO [dbo].[UTP_Org]
			([Name]
			,[ShortName])
		VALUES
		(
			@Name
			,@ShortName
		)
		SELECT @OrgId = COALESCE(SCOPE_IDENTITY(),0) 
	END
	EXEC [dbo].[UTP_CreateCustomer] @OrgID
	RETURN @OrgId 




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewDocumentStorage') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewDocumentStorage;
GO

-- ===========================================================
-- Author: JohnPeacock
-- Create date: May 22, 2016
-- Description: Insert into table UTP_DocumentStorage from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_NewDocumentStorage]
	@RootFolder varchar(255),
	@CurrentUserID int,
	@DocumentStorageIDout [int] = null output
AS
	insert into UTP_DocumentStorage
	 (
		[DocumentTypeID],
		[RootFolder]
	)
	SELECT
		DocumentTypeID = 1700,
		@RootFolder

	SELECT @DocumentStorageIDout= COALESCE(SCOPE_IDENTITY(),0)
	RETURN @DocumentStorageIDout


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewJobcard') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewJobcard;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: May 27, 2016
-- Description: Conditionally insert into table UTP_OrderJobcard 
--				and UTP_OrderAttachment from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_NewJobcard]
	@DocumentID int,
	@OrderID int,
--	@OrderJobcard [dbo].[UTP_OrderJobcardType] READONLY,
	@CurrentUserID int = NULL,

	@OrderJobcardIDout [int] = null output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_NewJobcard'
	select @Identifier = 'OrderID= ' + convert(varchar(6),@OrderID)

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewOrderAttachment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewOrderAttachment;
GO
-- ===========================================================
-- Author: JohnPeacock
-- Create date: May 22, 2016
-- Description: Insert into table UTP_DocumentStorage from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_NewOrderAttachment]
	@DocumentStorageID int,
	@OrigFilename varchar(255),
	@Filetype varchar(32),
	@OrderID int = null,
	@CurrentUserID int,
	@Filesize int = null,
	@DocumentIDOut [int] = null output,
	@FilenameOut varchar(255) = null output
AS
	insert into UTP_Document
	 (
		[DocumentRepositoryID],
		[DocumentTypeID],
		[CreatedTimestamp],
		[CreatedById],
		[SourceID],
		[Filetype],
		[OrigFilename],
		[Size]
	)
	SELECT
		[DocumentRepositoryID] = isnull(@DocumentStorageID,1),
		[DocumentTypeID] = 1700,
		[CreatedTimestamp] = getdate(),
		[CreatedById] = @CurrentUserID,
		[SourceID] = null,
		[Filetype] = @Filetype,
		[OrigFilename] = @OrigFilename,
		[Size] = @Filesize

	SELECT @DocumentIDout = COALESCE(SCOPE_IDENTITY(),0)
	SELECT @FilenameOut = convert(varchar(255),@DocumentIDout)
	Update UTP_Document 
		set Filename = @FilenameOut
		where DocumentID = @DocumentIDout

	if @OrderID is not null
		insert UTP_OrderAttachment (OrderID, DocumentID) select @OrderID, @DocumentIDOut

	insert UTP_OrderJobCard (DocumentID, JobCardLine, CreatedByID, DataEntryStatusID) select @DocumentIDOut, 1, @CurrentUserID, dbo.fnUTP_GetListMaster('DataEntryStatus','Unprocessed')

	RETURN @DocumentIDout

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewPanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewPanelColumn;
GO

--select * from utp_Panel
--select * from utp_panelColumn where PanelID=2108
-- exec UTP_NewPanelColumn 'pnJRPWO','vw_UTP_WO'
create procedure [dbo].[UTP_NewPanelColumn]
	@PanelName varchar(50),
	@PanelViewName varchar(50),
	@ColumnName varchar(50) = '%',
	@CurrentUserID int = null
as

	DECLARE @RC int
	DECLARE @Category varchar(255)
	DECLARE @AttributeName varchar(255)
	DECLARE @DisplayName varchar(255)
	DECLARE @Description varchar(max)
	DECLARE @DataTypeID int
	DECLARE @Length int
	DECLARE @DefaultValue varchar(255)
	DECLARE @DocText varchar(max) = null
	DECLARE @HelpText varchar(max)
	DECLARE @LoVKey varchar(255)
	DECLARE @IsActive bit = 1
	DECLARE @IsDerived bit = 0
	DECLARE @ValidationRule varchar(max) = null
	DECLARE @VAddedID int = null
	DECLARE @VRemoved int = null
	DECLARE @DataAttributeID int
	DECLARE @IsReadOnly bit = 0 
	DECLARE @IsOptional bit = 1
	DECLARE @IsHidden bit = 1
	DECLARE @SortOrder int
	DECLARE @ControlTypeID int
	DECLARE @LoVQueryName varchar(255) = null
	DECLARE @LoVQueryValueColumn varchar(255) = null
	DECLARE @LoVQueryDisplayColumn varchar(255) = null
	DECLARE @LanguageID int
	DECLARE @FormatString varchar(255)
	DECLARE @ColumnWidth int

	set @LanguageID = dbo.fnUTP_GetListMaster('Language','English')

	declare data cursor for
		SELECT	Category = case when TABLE_NAME like '%EGD%' then 'EGD' else 'UTP' end,
				AttributeName = case when TABLE_NAME like '%EGD%' then 'e' else '' end + COLUMN_NAME,
				ColumnName = COLUMN_NAME,
				DisplayName = COLUMN_NAME,
				[Description] = COLUMN_NAME,
				DataTypeID = dbo.fnUTP_GetListMaster('DataType',case when DATA_TYPE in ('varchar') then 'string' when DATA_TYPE in ('date','datetime') then 'datetime' else DATA_TYPE end),
				InputLength= case when CHARACTER_MAXIMUM_LENGTH is null and DATA_TYPE in ('int','float','bigint','real') then 10
								when CHARACTER_MAXIMUM_LENGTH is null and DATA_TYPE in ('datetime','date') then 30
								when CHARACTER_MAXIMUM_LENGTH is null and DATA_TYPE in ('bit') then 3
								else CHARACTER_MAXIMUM_LENGTH end,
				DefaultValue = COLUMN_DEFAULT,
				HelpText = COLUMN_NAME,
				SortOrder = ORDINAL_POSITION,
				ControlTypeID = dbo.fnUTP_GetListMaster('ControlType', case when DATA_TYPE in ('int','bigint') then 'TextBoxNumeric'
																			when DATA_TYPE in ('float','real') then 'TextBoxFloat'
																			when DATA_TYPE in ('datetime') then 'DateTime'
																			when DATA_TYPE in ('date') then 'DatePicker'
																			when DATA_Type in ('bit') then 'DropDown'
																			else 'TextBox' end),
				LovKey = case when DATA_TYPE in ('bit') then 'YesNoValue' else null end

			FROM INFORMATION_SCHEMA.COLUMNS 
			WHERE TABLE_NAME = @PanelViewName
				AND COLUMN_NAME like @ColumnName
			ORDER BY TABLE_NAME, ORDINAL_POSITION

	open data
	
	fetch next from data into @Category,@AttributeName,@ColumnName,@DisplayName,@Description,@DataTypeID,@Length,@DefaultValue,
								@HelpText,@SortOrder,@ControlTypeID,@LoVKey

	while @@FETCH_STATUS = 0
		begin
		select @DataAttributeID = DataAttributeID From UTP_DataAttribute where Category = @Category and AttributeName = @AttributeName
		if @DataAttributeID IS NULL 
			begin
			exec UTP_CreateDataAttribute @Category,@AttributeName,@DisplayName,@Description,@DataTypeID,@Length,@DefaultValue,
										@DocText,@HelpText,@LoVKey,@IsActive,@IsDerived,@ValidationRule,@VAddedID,@VRemoved,
										@DataAttributeID out
			end

		exec UTP_CreateOrUpdatePanelColumn @PanelName,@ColumnName,@DataAttributeID,@DisplayName,@HelpText,@IsActive,
						@IsReadOnly,@IsOptional,@IsHidden,@SortOrder,@DataTypeID,@Length,@ControlTypeID,
						@LoVKey,@LoVQueryName,@LoVQueryValueColumn,@LoVQueryDisplayColumn,@DefaultValue,@Description,
						@LanguageID

		fetch next from data into @Category,@AttributeName,@ColumnName,@DisplayName,@Description,@DataTypeID,@Length,@DefaultValue,
								@HelpText,@So;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewPerson') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewPerson;
GO


-- ===========================================================
-- Author: Diane MacMartin
-- Create date: Dec 08, 2015
-- Description: Insert into table UTP_Person from params, creating person if required
-- NOTE: Person parameters are ignored if the PersonID is not null
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_NewPerson]
	@Person vw_UTP_PersonType readonly, 
	@PersonIDout [int] = null output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_NewPerson'
	select @Identifier = FirstName + ' ' + LastName from @Person
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	declare @rows int
	select @rows = count(*) from @Person
	if @rows<>1
	BEGIN
		print 'Cannot create new person. [UTP_NewPerson] must have exactly 1 row, found '+convert(varchar(4),@rows)
		RETURN
	END
	declare 
		@PersonTypeID [int] ,
		@FirstName [varchar](255) ,
		@LastName [varchar](255) ,
		@Description [varchar](50) ,
		@PhoneEmailID [int] ,
		@BusinessName [varchar](40),
		@CellPhone [varchar](20) = NULL,
		@Pager [varchar](20) = NULL,
		@HomePhone [varchar](20) = NULL,
		@OfficePhone [varchar](20) = NULL,
		@Email [varchar](50) = NULL,
		@PhoneEmailIDout [int]

	select top 1
		@PersonTypeID=[PersonTypeID],
		@FirstName=[FirstName],
		@LastName=[LastName],
		@Description=[Description],
		@BusinessName=[BusinessName],
		@CellPhone = CellPhone,
		@Pager = Pager,
		@HomePhone = HomePhone,
		@OfficePhone = OfficePhone,
		@Email = COALESCE(Email,'*')

	from @Person
	
	exec UTP_CreatePhoneEmail
			@CellPhone,
			@Pager,
			@HomePhone,
			@OfficePhone,
			@Email,
			@PhoneEmailID OUTPUT

	exec @PersonIDout = [dbo].[UTP_CreatePerson] 
			@PersonTypeID,
			@FirstName,
			@LastName,
			@Description,
			@PhoneEmailID,
			@BusinessName

	IF @PersonIDout is NULL
	BEGIN
		PRINT 'UNABLE TO CREATE PERSON'
		RETURN
	END

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @PersonIDout


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewTechnician;
GO

-- ===========================================================
-- Author: Diane MacMartin
-- Create date: Dec 08, 2015
-- Description: Insert into table UTP_Technician from params, creating person if required
-- NOTE: Person parameters are ignored if the PersonID is not null
-- Revisions:
--		10-Apr-2016	JP	Implement TechnicianID DCR
-- ===========================================================
CREATE PROC [dbo].[UTP_NewTechnician]
	@TechnicianP vw_UTP_TechnicianType readonly,
	@CurrentUserID int = null,

	@TechnicianIDout [int] = null output
AS
	declare @rows int
	select @rows = count(*) from @TechnicianP
	if @rows<>1
	BEGIN
		print 'Cannot create new Technician. [UTP_NewTechnician] must have exactly 1 row, found '+convert(varchar(4),@rows)
		RETURN
	END

	declare @PersonID [int] ,
		@PersonTypeID [int] ,
		@FirstName [varchar](255) ,
		@LastName [varchar](255) ,
		@Description [varchar](50) ,
		@PhoneEmailID [int] ,
		@BusinessName [varchar](40) ,
		@TechnicianTypeID [int],
		@GSTNo [varchar](20) ,
		@PerformanceFactor [int] ,
		@Comments [varchar](50) ,
		@InsuranceNum [varchar](50) ,
		@InsuranceExpDate [varchar](50) ,
		@LicenceNum [varchar](50) ,
		@LicenceExpDate [varchar](50) ,
		@HH [int]

	select top 1
		@PersonID=PersonID,
		@PersonTypeID=[PersonTypeID],
		@FirstName=[FirstName],
		@LastName=[LastName],
		@Description=[Description],
		@PhoneEmailID=[PhoneEmailID],
		@BusinessName=[BusinessName] 
	from @TechnicianP
	if COALESCE(@PersonID,0) = 0
	BEGIN
		exec @PersonID = [dbo].[UTP_CreatePerson] 
			@PersonTypeID=@PersonTypeID,
			@FirstName=@FirstName,
			@LastName=@LastName,
			@Description=@Description,
			@PhoneEmailID=@PhoneEmailID,
			@BusinessName=@BusinessName
		IF @PersonID is NULL
		BEGIN
			PRINT 'UNABLE TO CREATE PERSON'
			RETURN
		END
	END
	select 
		@TechnicianTypeId=[TechnicianTypeId],
		@GSTNo=[GSTNo],
		@PerformanceFactor=COALESCE(PerformanceFactor,'0'),
		@Comments=[Comments],
		@InsuranceNum=[InsuranceNum],
		@InsuranceExpDate=[InsuranceExpDate],
		@LicenceNum=[LicenceNum],
		@LicenceExpDate=[LicenceExpDate],
		@HH=COALESCE(HasHandHeld,'0')
	from @TechnicianP

	exec @TechnicianIDout=[dbo].[UTP_CreateTechnician]
		@TechnicianTypeId,
		@GSTNo,
		@PerformanceFactor,
		@Comments,
		@InsuranceNum,
		@InsuranceExpDate,
		@LicenceNum,
		@LicenceExpDate,
		@HH
	RETURN @TechnicianIDout


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_NewUser') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_NewUser;
GO

-- ===========================================================
-- Author: Diane MacMartin
-- Create date: Dec 08, 2015
-- Description: Insert into table UTP_User from params, creating person if required
-- NOTE: Person parameters are ignored if the PersonID is not null
-- Revisions:
--		27-Oct-2016	JP	Set password to username 
-- ===========================================================
CREATE PROC [dbo].[UTP_NewUser]
	@UserP [vw_UTP_UserType] readonly, 
	@UserIDout [int] = null output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_NewUser'
	select @Identifier = FirstName + ' ' + LastName from @UserP
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	declare @rows int
	select @rows = count(*) from @UserP
	if @rows<>1
	BEGIN
		print 'Cannot create new user. [UTP_NewUser] must have exactly 1 row, found '+convert(varchar(4),@rows)
		RETURN
	END
	declare @PersonID [int] ,
		@PersonTypeID [int] ,
		@FirstName [varchar](255) ,
		@LastName [varchar](255) ,
		@Description [varchar](50) ,
		@PhoneEmailID [int] ,
		@BusinessName [varchar](40) 
	select top 1
		@PersonID=PersonID,
		@PersonTypeID=[PersonTypeID],
		@FirstName=[FirstName],
		@LastName=[LastName],
		@Description=[Description],
		@PhoneEmailID=[PhoneEmailID],
		@BusinessName=[BusinessName] 
	from @UserP
	
	if COALESCE(@PersonID,0) = 0
	BEGIN	
		exec @PersonID = [dbo].[UTP_CreatePerson] 
			@PersonTypeID,
			@FirstName,
			@LastName,
			@Description,
			@PhoneEmailID,
			@BusinessName
		IF @PersonID is NULL
		BEGIN
			PRINT 'UNABLE TO CREATE PERSON'
			RETURN
		END
	END
	
	declare @UserTypeID [int],@UserName [varchar](50),@Password [varchar](50),@TechnicianTypeID int,@TechnicianIDOut int
	select top 1 @UserTypeId = UserTypeId, @UserName = UserName, @Password = [Password] from @UserP
	-- set password to username
	exec [dbo].[UTP_CreateUser] @PersonID,@UserTypeID,@UserName,@UserName,@UserIDout output
	select @TechnicianTypeID = [dbo].[fnUTP_GetListMaster]('TechnicianType','Technician1')

	if @UserTypeId = [dbo].[fnUTP_GetListMaster]('UserType','Technician')
		exec @TechnicianIDout=[dbo].[UTP_CreateTechnician] @UserIDout, @TechnicianTypeID

	INSERT [dbo].[UTP_OrgPermission] (OrgID,UserID,[View],[Add],[Edit],[Delete],[Duplicate],[Submit])
	SELECT o.[OrgID],u.[UserID],1,1,1,1,1,1 
	FROM [dbo].[UTP_Org] o CROSS JOIN [dbo].[UTP_User] u
	where u.[UserID]=@UserIDOut

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @UserIDout

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_RaiseWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_RaiseWO;
GO
CREATE proc [dbo].[UTP_RaiseWO]
	@PrimaryOrderID int,
	@RaiseJobCodeID int,
	@RaiseType varchar(10) = 'RC',
	@APEQType varchar(20) = null,
	@ChildOrderID int output,
	@CurrentUserID int,
	@CrewID INT = NULL,
	@ActStart DATETIME = NULL,
	@ActFinish DATETIME = NULL
as
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_RaiseWO:'
				+ ' @RaiseJobCodeID=' + isnull(cast(@RaiseJobCodeID as varchar(6)),'null')
				+ ' @RaiseType=' + isnull(@RaiseType,'null')
				+ ' @APEQType=' + isnull(@APEQType,'null')
	set @Identifier = cast(@PrimaryOrderID as varchar(20))
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	DECLARE @SubmitBy varchar(50)
	IF @CurrentUserID IS NULL OR @CurrentUserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @CurrentUserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@CurrentUserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @CurrentUserID provided',2
	END

	declare @PrimaryWOID int,
			@RaiseWOID int,
			@ChildWONUM varchar(20),
			@WT_ID int,
			@ST_ID int,
			@StatusID int,
			@RC varchar(10),
			@RC_ID int,
			@SpecType int,
			@WONUM varchar(20),
			@WT varchar(20),
			@ST varchar(20),
			@JP varchar(20),
			@OrgShortName varchar(50),
			@RelationTypeID int,
			@ParentLongDesc varchar(max),
			@TemplateID int,
			@PrimaryJobCodeID int,
			@RaiseJobCode varchar(255), @IsBillable int,
			@Crew varchar(255)

	if @APEQType = '(null)' set @APEQType = null
	IF @CurrentUserID IS NULL SELECT @CurrentUserID=dbo.fnUTP_CurrentDomainUserID()

	select @SpecType = ListID from UTP_ListMaster where ListKey = 'SpecType' and ListValue = 'CHILDWOSPEC'
	select @RelationTypeID = ListID from UTP_ListMaster where ListKey = 'UTP_WORelationType' and ListValue = 'Child'
	
	DECLARE @Fitter varchar(255), @FitterID int
	--IF @Fitter IS NOT NULL SELECT @FitterID=[UserID] FROM UTP_User with(nolock) WHERE [Username]=@Fitter
	INSERT INTO [dbo].[UTP_OrderHistory]([OrderID],[MemoTypeID],[CreatedByID],[CreatedTimestamp],[TechnicianID],[Memo])
	VALUES(@PrimaryOrderID,dbo.fnUTP_GetListMaster('MemoType','1'),@CurrentUserID,GETDATE(),@FitterID,
	    'RaiseWO: ' + ISNULL(@RaiseType,'<not set>') + ' ' + @ChildWONUM + ' Created. JobCodeID=' + CAST(@RaiseJobCodeID AS varchar(10)))

	set @ProcedureName = @ProcedureName
	 				+ ', @RaiseWOID=' + isnull(cast(@RaiseWOID as varchar(10)),'null')

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ReassignTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ReassignTechnician;
GO
-- ===========================================================
-- Description: Appts must be scheduled, retract and re-dispatch to Sabre
--     Copied from UTP_AssignTechnician
-- Revisions:
--     20170223 - DM - copy UTP_AssignTechnician to UTP_ReassignTechnician
--                     Handle UTP WOs as well
-- ===========================================================
CREATE procedure [dbo].[UTP_ReassignTechnician]
	@Appointment [UTP_WOAppointmentType] READONLY,
	@CurrentUserID int,
	
	@ROWS [int] = NULL output
as
begin
	SET ANSI_WARNINGS OFF  
	--SET NOCOUNT ON  

	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_ReassignTechnician'

	select @i = count(*) from @Appointment
	if @i = 1
		select @Identifier = 'OrderID=' + cast(OrderID as varchar(6)) from @Appointment
	else 
		set @Identifier = 'Multiple' 

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	DECLARE @SubmitBy varchar(50)
	IF @CurrentUserID IS NULL OR @CurrentUserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @CurrentUserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@CurrentUserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @CurrentUserID provided',2
	END
	-- for dispatchable appts (except booked or completed)
	-- send to Sabre, if EGD
	-- set appts to dispatched 
	-- send dispatched to EGD, if EGD

	DECLARE @Action varchar(20), @WONUM varchar(20), @Priority int, @NewKey int, @rv int
	DECLARE @OrderID int, @AppointmentID int, @AppointmentStatusID int, @WOID int, @WOStatusID int, @now datetime
	DECLARE @TechnicianID int, @Technician varchar(50), @OrgShortname varchar(50)
	DECLARE @SysLog UTP_OrderHistoryType, @j int

	declare data cursor for
		SELECT	OrderID = tin.OrderID,
				WONUM = wo.WONUM, 
				WOID = uWOID,
				AppointmentID = a.AppointmentID,
				AppointmentStatusID = coalesce(a.AppointmentStatusID,90321), -- booked
				TechnicianID = case when tin.TechnicianID = -1 then null else tin.TechnicianID end,
				Technician = case when tin.TechnicianID = -1 then null else t.Username end,
				OrgShortname = org.ShortName
			FROM @Appointment tin
				inner join UTP_Order ord on tin.OrderID = ord.OrderID
				inner join UTP_Org org on org.OrgID = ord.OrgID
				-- left join EGD_WO wo on tin.OrderID = wo.OrderID 
				left join UTP_WO uwo on tin.OrderID = uwo.OrderID
				left join UTP_Appointment a on tin.OrderID = a.OrderID and a.AppointmentID in (select max(AppointmentID) from UTP_Appointment a2 where a2.OrderID=tin.OrderID)
				left join UTP_User t on tin.TechnicianID = t.UserID
	
	open data
	fetch next from data into @OrderID, @WONUM, @WOID, @AppointmentID, @AppointmentStatusID, @TechnicianID, @Technician, @OrgShortname

	set @i = 0
	while @@fetch_Status = 0
		begin
		set @i = @i + 1

		UPDATE UTP_Appointment
			SET	TechnicianID = @TechnicianID,
				ModifiedByID = @CurrentUserID,
				ModifiedTimestamp = getdate(),
				AppointmentStatusID = case when AppointmentStatusID=90329 then 90321 else AppointmentStatusID end
			WHERE AppointmentID = @AppointmentID

			UPDATE UTP_WO
			SET TechnicianID = @TechnicianID
			WHERE uWOID = @WOID

		insert @SysLog (OrderID, MemoTypeID, Memo, TechnicianID, Operation) 
			select @OrderID, 1004, 'Technician changed to ' + isnull(@Technician,'(None)'), @TechnicianID, 'A'

		fetch next from data into @OrderID, @WONUM, @WOID, @AppointmentID, @AppointmentStatusID, @TechnicianID, @Technician, @OrgShortname
		end

	close data
	deallocate data

	exec UTP;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ReserveAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ReserveAppointment;
GO
-- ===========================================================
-- Description: 
-- Revisions:
--	9-Apr-2016	JP	Set ApptStartDate
--  21-Apr-2017 JLM Added ContactID to INSERT UTP_Appointment
-- ===========================================================
CREATE procedure [dbo].[UTP_ReserveAppointment]
	@OrderID int,
	@ApptEndDate date,
	@TimeslotID int,
	@TechnicianID int,
	@SpecialInstructions varchar(1000) = null,
	@UserID int,
	@AppointmentID int output
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_ReserveAppointment'
						+ ' TechnicianID=' + isnull(cast(@TechnicianID as varchar(20)),'null')
	set @Identifier = cast(@OrderID as varchar(10))
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	-- check whether timeslot still available
	-- cancel previous reserved appts
	-- create new reserved appt
	-- update technician workschedule
	-- update WO
	-- log in WO history
	-- return AppointmentID as resultset

	SET @AppointmentID=NULL

	IF (SELECT [dbo].[fnUTP_RelightAppt](@OrderID)) <> 0
	BEGIN
		EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
		RETURN 0
	END

	DECLARE @GroupID int
	SELECT TOP 1 @GroupID=GroupID FROM vw_UTP_WO_UTP WHERE OrderID=@OrderID

	IF @GroupID IS NULL
	BEGIN
		EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
		RETURN 0
	END
	
	if exists (select AppointmentID from UTP_Appointment where OrderID = @OrderID and AppointmentStatusID = 90329) -- reserved
		begin	
		-- cancel previous reserved appts
		UPDATE [dbo].[UTP_Appointment]
			SET AppointmentStatusID = 90322, -- cancelled
				ModifiedById = @UserID,
				ModifiedTimestamp = getdate()
			WHERE OrderID = @OrderID and AppointmentStatusID = 90329 -- reserved
		end

	DECLARE @StartTime VARCHAR(5),@EndTime VARCHAR(5), @StartDateTime DATETIME, @EndDateTime DATETIME
	SELECT @StartTime = case @TimeslotID when 90301 then '08:00' 
									when 90302 then '12:00'
									when 90303 then '10:00'
									when 90304 then '08:00'
									when 90305 then '16:00'
									else '00:00' end,
					@EndTime= case @TimeslotID when 90301 then '12:00'
									when 90302 then '16:00'
									when 90303 then '14:00'
									when 90304 then '20:00'
									when 90305 then '20:00'
									else '23:59' end,
					@StartDateTime = CASE @TimeslotID
									WHEN 90301 THEN DATEADD(hh,8,CAST(@ApptEndDate as DATETIME))
									WHEN 90302 THEN DATEADD(hh,12,CAST(@ApptEndDate as DATETIME))
									WHEN 90303 THEN DATEADD(hh,10,CAST(@ApptEndDate as DATETIME))
									WHEN 90304 THEN DATEADD(hh,8,CAST(@ApptEndDate as DATETIME))
									WHEN 90305 THEN DATEADD(hh,16,CAST(@ApptEndDate as DATETIME))
									ELSE CAST(@ApptEndDate as DATETIME) END,
					@EndDateTime = CASE @TimeslotID
									WHEN 90301 THEN DATEADD(hh,12,CAST(@ApptEndDate as DATETIME))
									WHEN 90302 THEN DATEADD(hh,16,CAST(@ApptEndDate as DATETIME))
									WHEN 90303 THEN DATEADD(hh,14,CAST(@ApptEndDate as DATETIME))
									WHEN 90304 THEN DATEADD(hh,20,CAST(@ApptEndDate as DATETIME))
									WHEN 90305 THEN DATEADD(hh,20,CAST(@ApptEndDate as DATETIME))
									ELSE (CAST(@ApptEndDate as DATETIME) + CAST(CAST('23:59' as TIME) as DATETIME)) END

	-- create new reserved appt, copy data from existing booked appt
	declare @AccessRestricted bit, @MedicalNecessity bit, @ContactID int
	SELECT TOP 1 @AccessRestricted=AccessRestricted, @MedicalNecessity=MedicalNecessity, @SpecialInstructions=SpecialInstructions, @ContactID=ContactID
	FROM UTP_Appointment WHER;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_RetractWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_RetractWO;
GO
/*
declare @A [UTP_WOAppointmentType], @ROWS int
insert @A (OrderID,WONUM,AppointmentID) values (2233,'2233',2054)
exec [UTP_RetractWO] @A, 1, @ROWS out
*/
-- ===========================================================
-- Description: Appts must be Booked, Scheduled or Dispatched
-- Revisions:
--		11-Oct-2016	JP	When cancelling appt, just set status and modified data
--		12-Oct-2016 IM	Also deal with SCHED status
--		24-Apr-2018 IM	Re-Dispatch Cancelled Project Work Appointments
-- ===========================================================
CREATE procedure [dbo].[UTP_RetractWO]
	@Appointment [UTP_WOAppointmentType] READONLY,
	@UserID int,
	
	@ROWS [int] output
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int
	SET @ROWS=0
	
	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)

	select @i = count(*) from @Appointment
	if @i = 1
		select @Identifier = cast(OrderID as varchar(6)) from @Appointment
	else 
		set @Identifier = 'Multiple'

	select top 1 @ProcedureName = 'UTP_RetractWO'
				+ ' IN ROWS=' + cast(@i as varchar(6))
				+ ' AppointmentID=' + isnull(cast(AppointmentID as varchar(6)),'null')
		from @Appointment

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	DECLARE @SubmitBy varchar(50)
	IF @UserID IS NULL OR @UserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @UserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@UserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @UserID provided',2
	END

	-- pull back from Sabre
	-- cancel appt

	DECLARE @MemoStatusID int=[dbo].[fnUTP_GetListMaster]('MemoType','7')
	DECLARE @Action varchar(20), @WONUM varchar(20), @Priority int, @NewKey int, @rv int
	DECLARE @OrderID int, @AppointmentID int, @AppointmentStatusID int, @Relight int,@Status varchar(20)
	DECLARE @AppointmentTypeID int, @FitterID int, @TimeslotID int
	DECLARE @Memo UTP_OrderHistoryType

	-- this next bit is to populate the list of appointments because more could be added through processing
	DECLARE @AppointmentData UTP_WOAppointmentType
	INSERT INTO @AppointmentData(OrderID,WONUM,AppointmentID)
		SELECT OrderID=tin.OrderID,WONUM=tin.WONUM,AppointmentID=a.AppointmentID
		FROM @Appointment tin inner join UTP_Appointment a on tin.OrderID=a.OrderID 
		WHERE a.AppointmentStatusID=90321

	declare data cursor for
		SELECT	OrderID = tin.OrderID,
				WONUM =  tin.WONUM, 
				AppointmentID = a.AppointmentID,
				AppointmentStatusID = a.AppointmentStatusID,
				Relight = [dbo].[fnUTP_RelightAppt](tin.OrderID),
				AppointmentTypeID = a.AppointmentTypeID,
				FitterID = a.TechnicianID,
				TimeslotID= a.TimeslotID
			FROM @AppointmentData tin
				inner join UTP_Appointment a on tin.OrderID = a.OrderID AND tin.AppointmentID = a.AppointmentID
			WHERE a.AppointmentStatusID = 90321 -- Booked
	
	open data
	fetch next from data into @OrderID, @WONUM, @AppointmentID, @AppointmentStatusID, @Relight, @AppointmentTypeID, @FitterID, @TimeslotID

	set @i = 0
	while @@fetch_Status = 0
		begin
		DECLARE @ProjectFitterID int=NULL, @ProjectFitter varchar(30)=NULL,@ProjectStartDate datetime=NULL, @ProjectEndDate datetime=NULL, @ProjectApptID int=NULL, @OldProjectApptID int=NULL
		DECLARE @StatusDate datetime=NULL, @ts datetime=NULL, @deltams int=NULL, @OldStatusDate datetime=NULL, @Now datetime=GETDATE(), @WOID int=NULL, @NewStatus varchar(20)=NULL

		set @i = @i + 1
		INSERT @Memo (OrderID, MemoTypeID, Memo, TechnicianID, Operation)
			SELECT OrderID, 1001, 'Appointment cancelled and retracted from ' + u.Username, Techni;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ScheduleWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ScheduleWO;
GO
-- ===========================================================
-- Description: Cannot (re)schedule Booked nor Completed appts
-- Revisions:
-- ===========================================================
CREATE procedure [dbo].[UTP_ScheduleWO]
	@Appointment [UTP_WOAppointmentType] READONLY,
	@UserID int,
	
	@ROWS [int] output
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select @ProcedureName = 'UTP_ScheduleWO'
				+ ', IsFirmAppt=' + isnull(cast(IsFirmAppt as varchar(6)),'null')
				+ ', TechnicianID=' + isnull(cast(TechnicianID as varchar(6)),'null')
		from @Appointment

	select @i = count(*) from @Appointment
	if @i = 1
		select @Identifier = cast(OrderID as int) from @Appointment
	else 
		set @Identifier = 'Multiple' 

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier
	
	DECLARE @SubmitBy varchar(50)
	IF @UserID IS NULL OR @UserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @UserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@UserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @UserID provided',2
	END
	-- It is assumed that OrderID, ApptStartDate, ApptStartTime, ApptEndDate and ApptEndTime will always be supplied
	-- TimeslotID, TechnicianID may be null, -1 or 0 all representing NULL
	-- It is assumed that even if TimeslotID is not NULL, Appt Start and End Dates and Times are accurate
	DECLARE @MemoStatusID int=[dbo].[fnUTP_GetListMaster]('MemoType','7')

	-- Create working @Appts by filtering out Appointments that cannot be processed and set fields
	DECLARE @Appts UTP_WOAppointmentType
	INSERT INTO @Appts ([TechnicianID],[AppointmentTypeID],[AppointmentStatusID],[TimeslotID],[ApptStartDate],[ApptEndDate],
		[ApptStartTime],[ApptEndTime],[BookedViaID],[ExpectedDuration],[SpecialInstructions],[IsFirmAppt],[PreferredContactModeID],
		[OrderID],[ModifiedTimestamp],[CreatedTimestamp],[CreatedByID],[ModifiedByID],[ContactID])
	SELECT 
		CASE WHEN tin.[TechnicianID] IS NULL THEN NULL WHEN tin.[TechnicianID] IN (-1,0) THEN NULL ELSE tin.[TechnicianID] END,
		dbo.fnUTP_GetListMaster('AppointmentType','Unscheduled'), 90321, -- Booked
		NULL,
		-- cast((cast(tin.ApptStartDate as varchar(12)) + ' ' + ISNULL(tin.ApptStartTime, '00:00')) as DATETIME), -- StartDateTime
		-- cast((cast(tin.ApptEndDate as varchar(12)) + ' ' + ISNULL(tin.ApptEndTime,'23:59')) as DATETIME),	-- EndDateTime
		tin.ApptStartDate, tin.ApptEndDate, tin.ApptStartTime,tin.ApptEndTime,
		dbo.fnUTP_GetListMaster('AppName','UTOPIS'),2.0,
		--CASE WHEN tin.SpecialInstructions IS NULL THEN NULL WHEN tin.SpecialInstructions='' THEN NULL ELSE tin.SpecialInstructions END,
		CASE WHEN ewo.WOID IS NOT NULL THEN NULL ELSE CASE WHEN isnull(tin.SpecialInstructions,'')='' THEN NULL ELSE tin.SpecialInstructions END END,
		tin.IsFirmAppt,null,tin.OrderID,GETDATE(),GETDATE(),@UserID,@UserID,ISNULL(tin.ContactID,ap.ContactID)
		FROM @Appointment tin
		LEFT JOIN [dbo].[UTP_Appointment] ap ON ap.OrderID=tin.OrderID AND ap.[AppointmentStatusID]=90321 -- Booked
		--LEFT JOIN [dbo].[EGD_WO] ewo ON ewo.[OrderID]=tin.[OrderID]
		LEFT JOIN [dbo].[UTP_WO] uwo ON uwo.[OrderID]=tin.[OrderID]
		WHERE dbo.fnUTP_SelectListMaster(uwo.WMStatusID) IN ('WSCH','SCHED','DISP','ACK','ENROUTE')
					-- Require manual retraction on Customer Booked appointments (TimeslotID NULL) in progress
			AND ((CASE WHEN ap.AppointmentID IS NOT NULL AND ap.TimeslotID IS NOT NULL AND dbo.fnUTP_SelectListMaster(uwo.WMStatusID) IN ('DISP','ACK','ENROUTE')
				THEN 0 ELSE 1 END) ;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SearchJobCard') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SearchJobCard;
GO
CREATE PROC [dbo].[UTP_SearchJobCard]
	@Search [dbo].UTP_SearchJobcardType READONLY,
	@CurrentUserID int = NULL,
	
	@ROWS [int] output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_SearchJobcard'
	select @Identifier = 'Multiple'

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	DECLARE @DocumentID int = null,
			@DocumentTypeID int = null,
			@JobCardLine int = null,
			@DataEntryStatusID int = null,
			@TechnicianID int = null,
			@ReviewedByID int = null,
			@WONUM varchar(255) = null,
			@WONUMonCard varchar(255) = null,
			@JobCardMemo varchar(255) = null,
			@CreatedFrom datetime = null,
			@CreatedTo datetime = null,
			@ReviewedFrom datetime = null,
			@ReviewedTo datetime = null,
			@CompletedFrom datetime = null,
			@CompletedTo datetime = null,
			@OrigFilename varchar(255) = null

	SELECT TOP 1
			@DocumentID = case when DocumentID = 0 then null else DocumentID end,
			@DocumentTypeID = case when DocumentTypeID = 0 then null else DocumentTypeID end,
			@JobCardLine = case when JobCardLine = 0 then null else JobCardLine end,
			@DataEntryStatusID =  case when DataEntryStatusID = 0 then null else DataEntryStatusID end,
			@TechnicianID = case when TechnicianID = 0 then null else TechnicianID end,
			@ReviewedByID = case when ReviewedByID = 0 then null else ReviewedByID end,
			@WONUM = case when WONUM = '' then null else '%' + ltrim(rtrim(WONUM)) + '%' end,
			@WONUMonCard = case when WONUMonCard = '' then null else '%' + ltrim(rtrim(WONUMonCard)) + '%' end,
			@JobCardMemo = case when JobCardMemo = '' then null else '%' + ltrim(rtrim(JobCardMemo)) + '%' end,
			@OrigFilename = case when OrigFilename = '' then null else '%' + ltrim(rtrim(OrigFilename)) + '%' end,
			@CreatedFrom = case when CreatedFromTimestamp is null AND CreatedToTimestamp IS NULL then null else cast(isnull(CreatedFromTimestamp,CreatedToTimestamp) as date) end,
			@CreatedTo = case when CreatedToTimestamp is null AND CreatedFromTimestamp IS NULL then null else cast(isnull(CreatedToTimestamp,CreatedFromTimestamp) as date) end,
			@ReviewedFrom = case when ReviewedTimestamp is null then null else cast(ReviewedTimestamp as date) end,
			@ReviewedTo = case when ReviewedTimestamp is null then null else cast(ReviewedTimestamp as date) end,
			@CompletedFrom = case when CompletedFromDatetime is null AND CompletedToDatetime IS NULL then null else cast(isnull(CompletedFromDatetime,CompletedToDatetime) as date) end,
			@CompletedTo = case when CompletedToDatetime is null AND CompletedFromDatetime is null then null else cast(isnull(CompletedToDatetime,CompletedFromDatetime) as date) end

		FROM @Search

	SET @ProcedureName = 'UTP_SearchJobcard WONUM=' + isnull(@WONUM,'null') 
			+ ', WONUMOnCard=' + isnull(@WONUMonCard,'null') 
			+ ', CreatedFrom=' + isnull(cast(@CreatedFrom as varchar(25)),'null')
			+ ', ReviewedFrom=' + isnull(cast(@ReviewedFrom as varchar(25)),'null')
			+ ', CompletedFrom=' + isnull(cast(@CompletedFrom as varchar(25)),'null')

	declare @jc table([DocumentID] int, [OrderJobCardID] int)

	IF @DocumentID IS NOT NULL
	BEGIN
		INSERT INTO @jc([DocumentID], [OrderJobCardID])
		SELECT TOP 500 d.[DocumentID], ojc.[OrderJobCardID] 
			FROM UTP_Document d LEFT JOIN UTP_OrderJobCard ojc ON ojc.[DocumentID]=d.[DocumentID]
			WHERE d.Filetype <> '.jpg' AND d.[DocumentID] = @DocumentID
			ORDER BY d.DocumentID DESC, ojc.JobCardLine asc
	END
	ELSE
	BEGIN
		declare @sqlcmd nvarchar(max), @sqlparms nvarchar(max)
		select @sqlcmd = 'SELECT TOP 500;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SearchTaskList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SearchTaskList;
GO

CREATE PROCEDURE [dbo].[UTP_SearchTaskList]
	@Search UTP_TaskType READONLY, 
	@CurrentUserID int = NULL
as

	declare @TaskTypeID int = null,
			@TasKStatusID int = null,
			@TaskPriorityID int = null,
			@TaskID int = null,
			@AssignedToID int = null,
			@CompletedByID int = null,
			@TaskNumber varchar(50) = null,
			@TaskDescription varchar(500) = null,
			@Category varchar(50) = null,
			@Scope varchar(50) = null,
			@CompletionCode varchar(20) = null,
			@RaisedBy varchar(50) = null,
			@RaisedDate datetime = null

	select  @TaskID = case when TaskID = 0 then null else TaskID end,
			@TaskTypeID = case when TaskTypeID = 0 then null else TaskTypeID end,
			@TaskStatusID = case when TaskStatusID = 0 then null else TaskStatusID end,
			@TaskPriorityID = case when TaskPriority = 0 then null else TaskPriority end,
			@AssignedToID = case when AssignedToID = 0 then null else AssignedToID end,
			@CompletedByID = case when CompletedByID = 0 then null else CompletedByID end,
			@TaskNumber = case when TaskNumber = '' then null else '%' + ltrim(rtrim(TaskNumber)) + '%' end,
			@TaskDescription = case when TaskDescription = '' then null else '%' + ltrim(rtrim(TaskDescription)) + '%' end,
			@Category = case when Category = '' then null else '%' + ltrim(rtrim(Category)) + '%' end,
			@Scope = case when Scope = '' then null else '%' + ltrim(rtrim(Scope)) + '%' end,
			@CompletionCode = case when CompletionCode = '' then null else '%' + ltrim(rtrim(CompletionCode)) + '%' end,
			@RaisedBy = case when RaisedBy = '' then null else '%' + ltrim(rtrim(RaisedBy)) + '%' end,
			@RaisedDate = cast(RaisedDate as date)

		from @Search

	SELECT [TaskID]
		  ,[TaskTypeID]
		  ,[TaskType]
		  ,[TaskNumber]
		  ,[TaskDescription]
		  ,[TaskStatusID]
		  ,[TaskStatus]
		  ,[TaskPriorityID]
		  ,[TaskPriority]
		  ,[DueDate]
		  ,[CreatedTimestamp]
		  ,[CreatedByID]
		  ,[CreatedBy]
		  ,[TaskManagerID]
		  ,[TaskManager]
		  ,[Category]
		  ,[Scope]
		  ,[ProjectNumber]
		  ,[RaisedDate]
		  ,[RaisedBy]
		  ,[TargetStart]
		  ,[TargetFinish]
		  ,[AssignedToID]
		  ,[AssignedTo]
		  ,[AssignedDate]
		  ,[ActualStart]
		  ,[ActualFinish]
		  ,[CompletedByID]
		  ,[CompletedBy]
		  ,[CompletionCode]
		  ,[EstimatedDuration]
		  ,[ActualDuration]
		  ,[Instructions]
		  ,[Notes]
		  ,[FollowupDate]
		  ,[FollowupAction]
		  ,[FollowupFreqID]
		  ,[FollowupFreq]
		  ,[CostCenter]
	  FROM [vw_UTP_Task] 
	  WHERE isnull(TaskID,0) = coalesce(@TaskID,TaskID,0)
		and isnull(TaskTypeID,0) = coalesce(@TaskTypeID,TaskTypeID,0)
	  	and isnull(TaskStatusID,0) = coalesce(@TaskStatusID,TaskStatusID,0)
	  	and isnull(TaskPriorityID,0) = coalesce(@TaskPriorityID,TaskPriorityID,0)
		and isnull(AssignedToID,0) = coalesce(@AssignedToID,AssignedToID,0)
		and isnull(CompletedByID,0) = coalesce(@CompletedByID,CompletedByID,0)
		and isnull(TaskNumber,'') like coalesce(@TaskNumber,TaskNumber,'')
		and isnull(TaskDescription,'') like coalesce(@TaskDescription,TaskDescription,'')
		and isnull(Category,'') like coalesce(@Category,Category,'')
		and isnull(Scope,'') like coalesce(@Scope,Scope,'')
		and isnull(CompletionCode,'') like coalesce(@CompletionCode,CompletionCode,'')
		and isnull(RaisedBy,'') like coalesce(@RaisedBy,RaisedBy,'')


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SearchWOList') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SearchWOList;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Feb 25, 2016
-- Description: Get EGD WO header fields by Search criteria
-- Revisions: 
--	27-Apr-2016	JRP use [vw_UTP_WO] instead of exec @Return=EGD_SearchWOList
--	6-Oct-2016	JRP Remove % from beginning of WONUM search because User can enter it but can't remove it
--	12-Oct-2016	JP	Increase to 100 rows returned
--	11-Dec-2016	JRP	Handle null search criteria to improve performance
--	8-Dec-2016	JRP Added EnableCodeOut, EnableCancel, WOTypeID, WOType, PrimaryOrderID, IsBillable, NoCharge
--  24-May-2017 JLM Now looks at WO Header tables when doing an address search (instead of JRP_OrderSearch)
--	20-Dec-2017	IDM Altered to improve preformance using Dynamic Query and UTP & EGD specific views
--  28-May-2017 DM Add MaxRows as parameter
--	06-Aug-2018 IDM Limit results to permitted OrgIDs
--	11-Oct-2018	IDM Add LPC PO Number and Station Number to searched fields
--	30-Nov-2018	IDM Restructured to fix timeout issue
-- ====================================================================================
CREATE PROC [dbo].[UTP_SearchWOList]
		@SearchCriteria [vw_UTP_SearchType] readonly,
		@CurrentUserID int = null,
		@MaxRows int = 500
AS
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@Username varchar(255),
			@AllNull int = 0

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)

	select @AllNull = 1
		from @SearchCriteria
		where --[OrderID] is null
			  [OrgID] is null
			  and [ProjectNumber] is null
			  --and [WOID] is null
			  and [WONUM] is null
			  and [JobCodeID] is null
			  and [JobCode] is null
			  and [WorkType] is null
			  and [Subtype] is null
			  and [JobPlan] is null
			  and [GroupID] is null
			  and [Grid] is null
			  and [DisplayAddress] is null
			  --and [StreetNo] is null
			  --and [Unit] is null
			  --and [Street] is null
			  --and [Town] is null
			  and [PostalCode] is null
			  and [OldMeterSize] is null
			  and [OldMeterNumber] is null
			  --and [NewMeterSize] is null
			  --and [NewMeterNumber] is null
			  --and [APEQType] is null
			  --and [FromDueDate] is null
			  --and [ToDueDate] is null
			  and [FromApptStartDate] is null
			  and [ToApptStartDate] is null
			  --and [IsFirmAppt] is null
			  and [WMStatusID] is null
			  --and [DispatcherID] is null
			  and [TechnicianID] is null
			  and [FromActualFinish] is null
			  and [ToActualFinish] is null
			  --and [CompletionCode] is null
			  and [AppointmentID] is null
			  and [AppointmentStatusID] is null
			  and [AppointmentTypeID] is null
			  and [TimeslotID] is null
			  and [PremiseNo] is null
			  --and [UtilityComment] is null
			  --and [CustomerName] is null
			  --and [CustomerPhone] is null
			  --and [ParentWONUM] is null
			  --and [IsEAOK] is null
			  --and [WODescription] is null
			  --and [ErrorStatus] is null
			  --and [CreatedTimestamp] is null
			  --and [SubmitStatusID] is null
			  --and [SubmitStatus] is null
			  --and [TransmitStatusID] is null
			  --and [TransmitStatus] is null
			  and [MeterLeftStatus] is null
			  and [FromReportedDate] is null
			  and [ToReportedDate] is null

	IF (SELECT COUNT(*) FROM @SearchCriteria) = 0 SELECT @AllNull=1

	select	@ProcedureName = 'UTP_SearchWOList'
							+ ', @AllNull=' + isnull(cast(@AllNull as varchar(8)),'null')
							+ ', OrgID=' + isnull(cast(OrgID as varchar(8)),'null')
							+ ', AppointmentID=' + isnull(cast(AppointmentID as varchar(8)),'null')
							+ ', TechnicianID=' + isnull(cast(TechnicianID as varchar(8)),'null')
							+ ', WMStat;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectAddress;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: May 20, 2016
-- Description: Select from table UTP_Address
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectAddress]
	@AddressID [int] = null,@UserID [int] = null
AS
	select 
		[AddressID],
		[StreetNo],
		[Sfx],
		[Street],
		[Misc],
		[ProvinceID],
		[PostCode],
		[BuildingTypeID],
		[Town],
		[County],
		[Unit],
		[LotNumber],
		[CountryID]

  FROM [dbo].[UTP_Address]
  where AddressID=COALESCE(@AddressID,AddressID)



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectAppointment;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Appointment
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectAppointment]
	@AppointmentID [int] = null
AS
	select 
		[AppointmentID],
		[TechnicianID],
		[AppointmentTypeID]

  FROM [dbo].[UTP_Appointment]
  where AppointmentID=COALESCE(@AppointmentID,AppointmentID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectAvailability') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectAvailability;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Availability
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectAvailability]
	@AvailabilityID [int] = null
AS
	select 
		[AvailabilityID],
		[TechnicianID]

  FROM [dbo].[UTP_Availability]
  where AvailabilityID=COALESCE(@AvailabilityID,AvailabilityID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectCODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectCODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_CODetail
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectCODetail]
	@CODetailID [int] = null
AS
	select 
		[CODetailID],
		[OrderID]

  FROM [dbo].[UTP_CODetail]
  where CODetailID=COALESCE(@CODetailID,CODetailID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectContact') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectContact;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Contact
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectContact]
	@ContactID [int] = null
AS
	select 
		[ContactID],
		[OrderID]

  FROM [dbo].[UTP_Contact]
  where ContactID=COALESCE(@ContactID,ContactID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectCustomer') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectCustomer;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: July 31, 2015
-- Description: Select row by PK ID from Customer table
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_SelectCustomer]
		@CustomerID [int] = NULL
AS
	
	SELECT [OrgID]
	  FROM [dbo].[UTP_Customer]
	  where [OrgID]=COALESCE(@CustomerID,OrgID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectCustomerByOrgID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectCustomerByOrgID;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 13, 2015
-- Description: Select row by PK ID from Customer table
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_SelectCustomerByOrgID]
		@OrgID [int] = NULL
AS
	
	SELECT [OrgID]
	  FROM [dbo].[UTP_Customer]
	  where [OrgID]=COALESCE(@OrgID,[OrgID])




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectDataAttribute') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectDataAttribute;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_DataAttribute
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectDataAttribute]
	@DataAttributeID [int] = null
AS
	select 
		[DataAttributeID],
		[Category],
		[AttributeName],
		[DisplayName],
		[Description],
		[DataTypeID],
		[Length],
		[DefaultValue],
		[DocText],
		[HelpText],
		[LoVKey],
		[IsActive],
		[IsDerived],
		[ValidationRule],
		[VAddedID],
		[VRemoved]

  FROM [dbo].[UTP_DataAttribute]
  where DataAttributeID=COALESCE(@DataAttributeID,DataAttributeID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectDataAttributeByName') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectDataAttributeByName;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 02, 2015
-- Description: Select from table UTP_DataAttribute
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectDataAttributeByName]
	@Key varchar(255) 
AS
	select 
		[DataAttributeID],
		[Category],
		[AttributeName],
		[Description],
		[DisplayName],
		[DataTypeID],
		[Length],
		[DefaultValue],
		[DocText],
		[HelpText],
		[LoVKey],
		[IsActive],
		[IsDerived],
		[ValidationRule],
		[VAddedID],
		[VRemoved]

  FROM [dbo].[UTP_DataAttribute]
  where AttributeName=COALESCE(@Key,AttributeName)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectDocument') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectDocument;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 05, 2016
-- Description: Select from table UTP_Document
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectDocument]
	@DocumentID [int] = null
AS
	select 
		[DocumentID],
		[DocumentRepositoryID],
		[DocumentTypeID],
		[CreatedTimestamp],
		[OrigFilename],
		[CreatedById],
		[AccessedTimestamp],
		[SourceID],
		[Filename],
		[Filetype],
		[Size]

  FROM [dbo].[UTP_Document]
  where DocumentID=COALESCE(@DocumentID,DocumentID)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectErrorType') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectErrorType;
GO
-- DROP PROC [dbo].[UTP_SelectErrorType]
-- ==============================2=============================
-- Author: Ian MacIntyre
-- Create date: May 25, 2016
-- Description: Table type of returned errors
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectErrorType]
AS
	SELECT
	[Code]=CAST('' AS [varchar](32)),
	[Level]=CAST('' as int),
	[Message]=CAST('' AS [varchar](255)),
	[Location]=CAST('' AS [varchar](255)),
	[Param]=CAST('' AS [varchar](255)),
	[ParamValue]=CAST('' AS [varchar](255))




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectFADetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectFADetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_FADetail
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectFADetail]
	@FADetailID [int] = null
AS
	select 
		[FADetailID],
		[OrderID]

  FROM [dbo].[UTP_FADetail]
  where FADetailID=COALESCE(@FADetailID,FADetailID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectGroup') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectGroup;
GO
-- select * from vw_UTP_WO where AppointmentID = maxappt and AppointmentStatusID in (90321, 90323) order by WONUM
--select * from UTP_Appointment where OrderID=7
--select * from UTP_ListMaster where ListKey = 'AppointmentStatus'

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Select from table UTP_Group
--	exec [UTP_SelectGroup]
-- Revisions:
--              Mar 08, 2016 DM add GroupManagerID
--	13-Apr-2016	JP	Add filter parameters GroupType, User, GroupManager
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectGroup]
	@GroupID [int] = null,
	@GroupTypeID [int] = NULL,
	@GroupManagerID [int] = NULL,
	@UserID [int] = NULL
AS
	select 
		[GroupID],
		[GroupCode],
		[GroupName],
		[GroupTypeID],
		[GroupManagerID],
		[IsActive]

  FROM [dbo].[UTP_Group]
  where GroupID=COALESCE(@GroupID,GroupID)
	and GroupTypeID=COALESCE(@GroupTypeID,GroupTypeID)
	and (GroupManagerID is null or GroupManagerID=COALESCE(@GroupManagerID,GroupManagerID))





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectGroupMember') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectGroupMember;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Select from table UTP_GroupMember
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectGroupMember]
	@GroupMemberID [int] = null
AS
	select 
		[GroupMemberID],
		[MemberID],
		[GroupID],
		[JobTitleID],
		[IsActive]

  FROM [dbo].[UTP_GroupMember]
  where GroupMemberID=COALESCE(@GroupMemberID,GroupMemberID)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectGroupMemberByGroupID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectGroupMemberByGroupID;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Mar 03, 2016
-- Description: Group Member by GroupID
-- Revisions: 
--	4-Mar-2016	JRP	Reorder columns to match UTP_GroupMemberType
-- ====================================================================================
CREATE PROC [dbo].[UTP_SelectGroupMemberByGroupID]
	@GroupID int
AS
	Select 
		g.GroupMemberID,
		g.MemberID,
		g.GroupID,
		g.JobTitleID,
		g.IsActive
	from UTP_GroupMember g
	where g.GroupID=@GroupID




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectJobTitle') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectJobTitle;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Select from table UTP_JobTitle
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectJobTitle]
	@JobTitleID [int] = null
AS
	select 
		[JobTitleID],
		[JobTitle],
		[JobDescription],
		[IsActive]

  FROM [dbo].[UTP_JobTitle]
  where JobTitleID=COALESCE(@JobTitleID,JobTitleID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectListMaster') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectListMaster;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_ListMaster
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectListMaster]
	@ListID [int] = null
AS
	select 
		[ListID],
		[ListKey],
		[ListValue],
		[ListText],
		[HelpText],
		[IsActive],
		[IsDefault],
		[SortOrder],
		[LoVKey],
		[LanguageID],
		[VAddedID],
		[VRemoved],
		[VNotes]

  FROM [dbo].[UTP_ListMaster]
  where ListID=COALESCE(@ListID,ListID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectListMasterByKey') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectListMasterByKey;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_ListMaster
-- exec UTP_SelectListMasterByKey 'EGD_PriceList'
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectListMasterByKey]
       @Key varchar(255),
       @IsActive int = 1
AS
       select 
              [ListID],
              [ListKey],
              [ListValue],
              [ListText],
              [HelpText],
              [IsActive],
              [IsDefault],
              [SortOrder],
              [LoVKey],
              [LanguageID],
              [VAddedID],
              [VRemoved],
              [VNotes]
  FROM [dbo].[UTP_ListMaster]
  where		[ListKey] like COALESCE (@Key,ListKey)
		and [IsActive] like COALESCE (@IsActive,IsActive)
  order by ListKey,SortOrder,ListText


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectListMasterKeys') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectListMasterKeys;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create Oct 06, 2015
-- Description: Select row by PK ID from ListMaster table
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_SelectListMasterKeys]
		@ListKey [varchar] (255) = NULL
AS
	
	SELECT distinct [ListKey]

	  FROM [dbo].[UTP_ListMaster]
	  where [ListKey] like COALESCE (@ListKey,ListKey)
	  order by ListKey




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectOrder') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectOrder;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Order
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectOrder]
	@OrderID [int] = null
AS
	select 
		[OrderID],
		[OrgID],
		[OrderTypeID]

  FROM [dbo].[UTP_Order]
  where OrderID=COALESCE(@OrderID,OrderID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectOrg') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectOrg;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Org
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectOrg]
	@OrgID [int] = null
AS
	select 
		[OrgID],
		[Name],
		[ShortName]

  FROM [dbo].[UTP_Org]
  where OrgID=COALESCE(@OrgID,OrgID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPanel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPanel;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Panel
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPanel]
	@PanelID [int] = null
AS
	select 
		[PanelID],
		[PanelName],
		[PanelTypeID],
		[ParentPanelID],
		[PanelViewName]

  FROM [dbo].[UTP_Panel]
  where PanelID=COALESCE(@PanelID,PanelID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPanelColumn;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_PanelColumn
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPanelColumn]
	@PanelColumnID [int] = null
AS
	select 
		[PanelColumnID],
		[PanelID],
		[ColumnName],
		[DataAttributeID],
		[DisplayName],
		[HelpText],
		[IsActive],
		[IsReadOnly],
		[IsOptional],
		[IsHidden],
		[SortOrder],
		[DataTypeID],
		[Length],
		[ControlTypeID],
		[LoVKey],
		[LoVQueryName],
		[LoVQueryValueColumn],
		[LoVQueryDisplayColumn],
		[DefaultValue],
		[Description],
		[LanguageID],
		[FormatString],
		[ColumnWidth]

  FROM [dbo].[UTP_PanelColumn]
  where PanelColumnID=COALESCE(@PanelColumnID,PanelColumnID)


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPanelCommand') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPanelCommand;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: May 20, 2016
-- Description: Select from table UTP_PanelCommand
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPanelCommand]
	@PanelCommandID [int] = null,@UserID [int] = null
AS
	select 
		[PanelCommandID],
		[PanelID],
		[ProcedureCalled],
		[ModuleID],
		[Comments],
		[Description]

  FROM [dbo].[UTP_PanelCommand]
  where PanelCommandID=COALESCE(@PanelCommandID,PanelCommandID)



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPanelCommandByPanelID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPanelCommandByPanelID;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: May 20, 2016
-- Description: Select from table UTP_PanelCommand
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPanelCommandByPanelID]
	@PanelID [int] = null,@UserID [int] = null
AS
	select 
		[PanelCommandID],
		[PanelID],
		[ProcedureCalled],
		[ModuleID],
		[Comments],
		[Description]

  FROM [dbo].[UTP_PanelCommand]
  where PanelID=COALESCE(@PanelID,PanelID)



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPanelPermission') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPanelPermission;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_PanelPermission
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPanelPermission]
	@PanelPermissionID [int] = null
AS
	select 
		[PanelPermissionID],
		[PanelID],
		[UserID],
		[View],
		[Add],
		[Edit],
		[Delete],
		[Duplicate],
		[Submit]

  FROM [dbo].[UTP_PanelPermission]
  where PanelPermissionID=COALESCE(@PanelPermissionID,PanelPermissionID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPerson') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPerson;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Person
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPerson]
	@PersonID [int] = null
AS
	select 
		[PersonID],
		[PersonTypeID],
		[FirstName],
		[LastName],
		[Description],
		[PhoneEmailID],
		[BusinessName]

  FROM [dbo].[UTP_Person]
  where PersonID=COALESCE(@PersonID,PersonID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPersonnel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPersonnel;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Personnel
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPersonnel]
	@PersonnelID [int] = null
AS
	select 
		[PersonnelID],
		[PersonID],
		[OrgID]

  FROM [dbo].[UTP_Personnel]
  where PersonnelID=COALESCE(@PersonnelID,PersonnelID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPhoneEmail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPhoneEmail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_PhoneEmail
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPhoneEmail]
	@PhoneEmailID [int] = null
AS
	select 
		[PhoneEmailID],
		[CellPhone],
		[Pager],
		[HomePhone],
		[OfficePhone],
		[Email]

  FROM [dbo].[UTP_PhoneEmail]
  where PhoneEmailID=COALESCE(@PhoneEmailID,PhoneEmailID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectPODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectPODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_PODetail
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectPODetail]
	@PODetailID [int] = null
AS
	select 
		[PODetailID],
		[OrderID]

  FROM [dbo].[UTP_PODetail]
  where PODetailID=COALESCE(@PODetailID,PODetailID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectReport') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectReport;
GO

CREATE PROC [dbo].[UTP_SelectReport]
	@ReportID [int] = null
AS
SELECT [ReportID]
      ,[UserID]
      ,[ReportName]
      ,[ReportTypeID]
      ,[ConnectionString]
      ,[SqlStatement]
	,[StatementTypeID]
      ,[ReportDefinition]
  FROM [dbo].[UTP_Report]
  where ReportID=COALESCE(@ReportID,ReportID)
  





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectReportByReportName') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectReportByReportName;
GO

CREATE PROC [dbo].[UTP_SelectReportByReportName]
	@ReportName varchar(255) = null
AS
SELECT [ReportID]
      ,[UserID]
      ,[ReportName]
      ,[ReportTypeID]
      ,[ConnectionString]
      ,[SqlStatement]
	,[StatementTypeID]
      ,[ReportDefinition]
  FROM [dbo].[UTP_Report]
  where ReportName=COALESCE(@ReportName,ReportName)





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectReportParameter') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectReportParameter;
GO


CREATE PROC [dbo].[UTP_SelectReportParameter]
	@ReportParameterID [int] = null
AS
SELECT [ReportParameterID]
      ,[ReportID]
      ,[ReportParameter]
      ,[ReportParameterValue]
  FROM [dbo].[UTP_ReportParameter]
  where ReportParameterID=COALESCE(@ReportParameterID,ReportParameterID)
  






;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectReportParameterByReportID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectReportParameterByReportID;
GO

CREATE PROC [dbo].[UTP_SelectReportParameterByReportID]
	@ReportID [int] = null
AS
SELECT [ReportParameterID]
      ,[ReportID]
      ,[ReportParameter]
      ,[ReportParameterValue]
  FROM [dbo].[UTP_ReportParameter]
  where ReportID=@ReportID
 




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectTask') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectTask;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Select from table UTP_Task
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectTask]
	@TaskID [int] = null
AS
	select 
		[TaskID],
		[TaskTypeID],
		[TaskCode],
		[TaskDescription],
		[TaskStatusID],
		[TaskPriorityID],
		[TaskDueDate],
		[TaskCreatedTimestap],
		[TaskCreatedByUserID],
		[TaskOwnerID],
		[TaskCategory],
		[TaskScope],
		[IsActive]

  FROM [dbo].[UTP_Task]
  where TaskID=COALESCE(@TaskID,TaskID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectTaskHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectTaskHistory;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Select from table UTP_TaskHistory
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectTaskHistory]
	@TaskHistoryID [int] = null
AS
	select 
		[TaskHistoryID],
		[TaskID],
		[TaskUpdatedTimestamp],
		[TaskUpdatedByID],
		[TaskNote],
		[TaskActionID],
		[TaskCompletedByID],
		[ActiveDatetimeFrom],
		[ActiveDatetimeTo],
		[TaskDuration]

  FROM [dbo].[UTP_TaskHistory]
  where TaskHistoryID=COALESCE(@TaskHistoryID,TaskHistoryID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectTaskHistoryByTaskID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectTaskHistoryByTaskID;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Mar 03, 2016
-- Description: Task History by TaskID
-- Revisions: 
--	4-Mar-2016	JRP	Add TaskHistoryID to match UTP_TaskHistoryType
-- ====================================================================================
CREATE PROC [dbo].[UTP_SelectTaskHistoryByTaskID]
	@TaskID int
AS
	Select 
		th.TaskHistoryID,
		th.TaskID,
		th.TaskUpdatedTimestamp,
		th.TaskUpdatedByID,
		th.TaskNote,
		th.TaskActionID,
		th.TaskCompletedByID,
		th.ActiveDatetimeFrom,
		th.ActiveDatetimeTo,
		th.TaskDuration
	from UTP_TaskHistory th
	where th.TaskID=@TaskID




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectTechnician;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_Technician
-- Revisions:
--		21-Apr-2016		JRP		TechnicianID DCR
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectTechnician]
	@TechnicianID [int] = null
AS
	select 
		[TechnicianID],
		[TechnicianTypeID],
		[GSTNo],
		[PerformanceFactor],
		[Comments],
		[InsuranceNum],
		[InsuranceExpDate],
		[LicenceNum],
		[LicenceExpDate],
		[HasHandHeld]

  FROM [dbo].[UTP_Technician]
  where TechnicianID=COALESCE(@TechnicianID,TechnicianID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectUser') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectUser;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_User
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectUser]
	@UserID [int] = null
AS
	select 
		[UserID],
		[PersonID],
		[UserTypeID],
		[UserName],
		[Password]

  FROM [dbo].[UTP_User]
  where UserID=COALESCE(@UserID,UserID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Selectvw_Catalog') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Selectvw_Catalog;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_Catalog
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Selectvw_Catalog]
	@CatalogID [int] = null
AS
	select 
		[CatalogID],
		[CatalogName],
		[RowVersionID],
		[IsActive]

  FROM [dbo].[vw_UTP_Catalog]
  where CatalogID=COALESCE(@CatalogID,CatalogID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Selectvw_Document') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Selectvw_Document;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_Document
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Selectvw_Document]
	@DocumentID [int] = null
AS
	select 
		[DocumentID],
		[DocumentTypeID],
		[DocumentType],
		[DateCreated],
		[CreatedByID],
		[CreatedBy],
		[ScannerID],
		[Scanner],
		[Filename],
		[URL]

  FROM [dbo].[vw_UTP_Document]
  where DocumentID=COALESCE(@DocumentID,DocumentID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Selectvw_DocumentStorage') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Selectvw_DocumentStorage;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_DocumentStorage
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Selectvw_DocumentStorage]
	@DocumentStorageID [int] = null
AS
	select 
		[DocumentStorageID],
		[DocumentTypeID],
		[OrgID],
		[Name],
		[ShortName],
		[RootFolder],
		[DestinationFolder]

  FROM [dbo].[vw_UTP_DocumentStorage]
  where DocumentStorageID=COALESCE(@DocumentStorageID,DocumentStorageID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Selectvw_Panel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Selectvw_Panel;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_Panel
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Selectvw_Panel]
	@PanelID [int] = null
AS
	select 
		[PanelID],
		[PanelName],
		[PanelTypeID],
		[PanelType],
		[ParentPanelID],
		[ParentPanel]

  FROM [dbo].[vw_UTP_Panel]
  where PanelID=COALESCE(@PanelID,PanelID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Selectvw_PanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Selectvw_PanelColumn;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_PanelColumn
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Selectvw_PanelColumn]
	@PanelColumnID [int] = null
AS
	select 
		[PanelColumnID],
		[PanelID],
		[PanelName],
		[ColumnName],
		[DataAttributeID],
		[AttributeName],
		[DisplayName],
		[HelpText],
		[IsActive],
		[IsReadOnly],
		[IsOptional],
		[IsHidden],
		[SortOrder],
		[DataTypeID],
		[DataType],
		[Length],
		[ControlTypeID],
		[ControlType],
		[LoVKey],
		[LoVQueryName],
		[LoVQueryDisplayColumn],
		[DefaultValue],
		[Description],
		[LanguageID],
		[Language]

  FROM [dbo].[vw_UTP_PanelColumn]
  where PanelColumnID=COALESCE(@PanelColumnID,PanelColumnID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Selectvw_Technician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Selectvw_Technician;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_Technician
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Selectvw_Technician]
	@TechnicianID [int] = null
AS
	select 
		[TechnicianID],
		[GroupID],
		[GroupCode],
		[GroupName],
		[UserTypeID],
		[Username],
		[Password],
		[TechnicianTypeID],
		[GSTNo],
		[PerformanceFactor],
		[Comments],
		[InsuranceNum],
		[InsuranceExpDate],
		[LicenceNum],
		[LicenceExpDate],
		[HasHandHeld],
		[PersonID],
		[PersonTypeID],
		[FirstName],
		[LastName],
		[Description],
		[BusinessName],
		[PhoneEmailID],
		[CellPhone],
		[Pager],
		[HomePhone],
		[OfficePhone],
		[Email],
		[FirstNameLastName],
		[LastNameFirstName],
		[DisplayName]

  FROM [dbo].[vw_UTP_Technician]
  where TechnicianID=COALESCE(@TechnicianID,TechnicianID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Selectvw_WO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Selectvw_WO;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_WO
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Selectvw_WO]
	@OrderID [int] = null
AS
	select 
		[OrderID],
		[WOID],
		[WONUM],
		[JobCodeID],
		[JobCode],
		[WorkType],
		[Subtype],
		[JobPlan],
		[GroupID],
		[GroupName],
		[GridID],
		[Grid],
		[StartDate],
		[DueDate],
		[WMStatusID],
		[DispatcherID],
		[Dispatcher],
		[TechnicianID],
		[Technician],
		[CompletionDate],
		[CompletionCode],
		[AppointmentID],
		[AppointmentStatusID],
		[AppointmentStatus],
		[AppointmentTypeID],
		[AppointmentType],
		[TimeslotID],
		[AppointmentDate],
		[maxappt]

  FROM [dbo].[vw_UTP_WO]
  where OrderID=COALESCE(@OrderID,OrderID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Selectvw_WOAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Selectvw_WOAppointment;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Select from table vw_UTP_WOAppointment
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Selectvw_WOAppointment]
	@OrderID [int] = null
AS
	select 
		[OrderID],
		[TechnicianID],
		[AppointmentTypeID],
		[ApptWindowStartDate],
		[ApptWindowEndDate],
		[TimeslotID],
		[SpecialInstructions]

  FROM [dbo].[vw_UTP_WOAppointment]
  where OrderID=COALESCE(@OrderID,OrderID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectWO;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 05, 2016
-- Description: Select from table UTP_WO
-- Revisions:
--		4/9/2016	JP	Select from EGD_WO
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectWO]
	@uWOID [int] = null
AS
	select 
		[uWOID] = uWOID,
		[OrderID],
		[WONUM],
		[JobCodeID],
		[AreaID] = 0,
		[GridID] = 0,
		--[DueDate] = SCHEDFINISH,
		[DueDate] = NULL,
		[WMStatusID] = 0,
		[DispatcherID] = 0,
		[TechnicianID] = 0,
		[CompletionDate] = ActualFinish,
		[CompletionCode] = [CompletionCode]

  --FROM [dbo].[EGD_WO]
  FROM [dbo].[UTP_WO]
 where WOID=COALESCE(@uWOID,WOID)
 --where uWOID=COALESCE(@uWOID,uWOID)
;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectWODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectWODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Oct 27, 2015
-- Description: Select from table UTP_WODetail
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectWODetail]
	@WODetailID [int] = null
AS
	select 
		[WODetailID],
		[OrderID]

  FROM [dbo].[UTP_WODetail]
  where WODetailID=COALESCE(@WODetailID,WODetailID)




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectWorkSchedule;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description: Select from table UTP_WorkSchedule
-- Revisions:
--              Mar 08, 2016 DM add GroupID
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectWorkSchedule]
	@WorkScheduleID [int] = null, @GroupID [int] = null, @UserID [int] = null
AS
	select 
		[WorkScheduleID],
		[UserID],
		[WorkDate],
		[TimeSlotID],
		[Available] = [Capacity],
		[Booked],
		[GroupID]

	FROM vw_UTP_WorkSchedule
	where WorkScheduleID=COALESCE(@WorkScheduleID,WorkScheduleID)
		and  (@GroupID is NULL OR ([GroupID]=@GroupID))
		and  (@UserID is NULL OR ([UserID]=@UserID))





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SelectWOServiceAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SelectWOServiceAddress;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- exec [UTP_SelectWOServiceAddress] 165
-- Description: Select from table vw_UTP_WOServiceAddress
-- Revisions:
--	Restricted AddressTypeID to NULL (EGD) or SERVICE to support Utopis4
-- ===========================================================
CREATE PROC [dbo].[UTP_SelectWOServiceAddress]
	@OrderID [int] = null
AS
	select 
		[OrderID],
		[WOID],
		[WONUM],
		[OrderAddressID],
		[AddressID],
		[AddressTypeID],
		[AddressType],
		[StreetNo],
		[LotNumber],
		[Unit],
		[Street],
		[Sfx],
		[Misc],
		[Town],
		[County],
		[ProvinceCode],
		[PostalCode],
		[CountryCode],
		[MeterNumber],
		[MeterLocation],
		[MeterSize],
		[ServicePressure],
		[PremiseNo],
		[OrgID],
		[OrgShortName]

  FROM [dbo].[vw_UTP_WOServiceAddress]
  WHERE OrderID=@OrderID AND (AddressTypeID IS NULL OR AddressTypeID=1401) -- SERVICE

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ShowAllUserColumns') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ShowAllUserColumns;
GO

CREATE PROCEDURE [dbo].[UTP_ShowAllUserColumns]
	@PanelName varchar(255),
	@CurrentUserID int
as
	UPDATE UTP_UserColumn
		SET	IsHidden = 0
		FROM UTP_UserColumn uc 
			inner join UTP_PanelColumn pc on uc.PanelColumnID = pc.PanelColumnID
			inner join UTP_Panel p on pc.PanelID = p.PanelID 
		WHERE PanelName = @PanelName

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ShowPanelIDColumns') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ShowPanelIDColumns;
GO

-- exec UTP_ShowPanelIDColumns 0
CREATE PROCEDURE [dbo].[UTP_ShowPanelIDColumns]
	@Show int = 1 -- =0 to hide
as
	declare @i int, @PanelID int

	set nocount on

	if @Show = 1
		exec UTP_UpdatePanelColumnFromParms @PanelName='%', @ColumnName='%', @IsHidden=0
	else
		begin
		set @i = 1
--		exec UTP_UpdatePanelColumnFromParms @PanelName='%List', @ColumnName='IsActive', @IsHidden=1, @IsOptional=1
		exec UTP_UpdatePanelColumnFromParms @PanelName='%Info', @ColumnName='Active', @IsHidden=1, @IsOptional=1
		exec UTP_UpdatePanelColumnFromParms @PanelName='%', @ColumnName='PhoneEmailID', @IsHidden=1, @IsOptional=1

	-- pnEGD_WO
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_WO' and ColumnName in ('OrderID','JobCodeID')
--		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_WO' and ColumnName in ('WOID','OrderID','JobCodeID')
	--	update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_WO' and ColumnName in ('WorkTypeID','WAMS_SubtypeID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_WOServiceAddress' and ColumnName in ('EGD_WOServiceAddressID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_Worklog' and ColumnName in ('EGD_WorklogID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_PremiseHistory' and ColumnName in ('EGD_PremiseHistoryID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_PlusPCustomer' and ColumnName in ('EGD_PlusPCustomerID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_WOAsset' and ColumnName in ('EGD_WOAssetID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_Spec' and ColumnName in ('EGD_SpecID','EGD_WOAssetID','WOID')
	--	update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_Spec' and ColumnName in ('SpecTypeID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_FailureReport' and ColumnName in ('EGD_FailureReportID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_Invoice' and ColumnName in ('EGD_InvoiceID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_InvoiceLine' and ColumnName in ('EGD_InvoiceLineID','EGD_InvoiceID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_WPMaterial' and ColumnName in ('EGD_WPMaterialID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_WPService' and ColumnName in ('EGD_WPServiceID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_RelatedWO' and ColumnName in ('EGD_RelatedWOID','WOID')
		update pc set IsHidden = @i from UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID where PanelName='pnEGD_DocInfo' and ColumnName in ('EGD_DocInfoID','WOID')

		-- Groups
		exec UTP_UpdatePanelColumnFromParms @PanelName='pnGroupList', @ColumnName='%ID', @IsHidden=1, @IsOptional=1
		exec UTP_UpdatePanelColumnFromParms @PanelName='pnGroupInfo', @ColumnName='GroupID', @IsHidden=1;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_StartSurvey') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_StartSurvey;
GO



-- =============================================
-- Author:		Jeff Moretti
-- Create date: July 31, 2018
-- Description:	Updates OrderHistory about
--				a customer either starting, or
--				continuing a Customer Survey.
--				Called by SurveyWS_StartSurvey.
--				Note that this SP is called
--				when a customer starts (or
--				continues a survey).
-- =============================================
CREATE PROCEDURE [dbo].[UTP_StartSurvey]
	@OrderID int,
	@SurveyResultID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @OrderHistoryIn [dbo].UTP_OrderHistoryType,
			@RowCount int

	INSERT INTO @OrderHistoryIn (OrderID, MemoTypeID, Memo, StatusTimestamp,  Operation)
		VALUES(@OrderID, 1001, 'Survey : Customer has started (or is continuing) a survey (SurveyResultID = ' + CONVERT(varchar(10),@SurveyResultID) + ')', GETDATE(), 'A')

		EXEC dbo.UTP_UpdateXOrderHistory
			@OrderHistory = @OrderHistoryIn,
			@CurrentUserID = 3,
			@Rows = @RowCount		
END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_SuspendWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_SuspendWO;
GO

-- ===========================================================
-- Description: Appts must be Booked, Scheduled or Dispatched
-- Revisions:
-- ===========================================================
CREATE procedure [dbo].[UTP_SuspendWO]
	@Appointment [UTP_WOAppointmentType] READONLY,
	@CurrentUserID int = null,
	
	@ROWS [int] output
as
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_SuspendWO'

	select @i = count(*) from @Appointment
	if @i = 1
		select @Identifier = cast(OrderID as varchar(6)) from @Appointment
	else 
		set @Identifier = 'Multiple'

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	DECLARE @Action varchar(20), @WONUM varchar(20), @Priority int, @NewKey int, @rv int
	DECLARE @OrderID int, @AppointmentID int, @AppointmentStatusID int
	DECLARE @Memo UTP_OrderHistoryType

	declare data cursor for
		SELECT	OrderID = wo.OrderID,
				WONUM = wo.WONUM, 
				AppointmentID = a.AppointmentID,
				AppointmentStatusID = a.AppointmentStatusID
			FROM @Appointment tin
				inner join UTP_WO wo on tin.OrderID = wo.OrderID 
				inner join UTP_Appointment a on tin.OrderID = a.OrderID AND a.AppointmentStatusID=90321 -- Booked
			WHERE ([dbo].[fnUTP_SelectListMaster](wo.[WMStatusID]) IN ('ENROUTE','ONSITE')) OR ([dbo].[fnUTP_RelightAppt](wo.OrderID) > 0)
	
	open data
	fetch next from data into @OrderID, @WONUM, @AppointmentID, @AppointmentStatusID

	set @i = 0
	while @@fetch_Status = 0
		begin
		set @i = @i + 1
		
		IF (SELECT [dbo].[fnUTP_MessageEnabled]('HHSUBSUSPWR31','UTP_SuspendWO')) = 1
		BEGIN
			EXEC @rv=dbo.HH_Submit31ByWONUM 'HHSUBSUSPWR31', @WONUM, @Priority, @NewKey OUTPUT
		END

		INSERT @Memo (OrderID, MemoTypeID, Memo, TechnicianID, Operation)
			SELECT OrderID, 1004, 'Appointment suspended for ' + u.Username, TechnicianID, 'A' 
				FROM UTP_Appointment a inner join UTP_User u on a.TechnicianID = u.UserID
				WHERE AppointmentID = @AppointmentID
					AND [AppointmentStatusID] <> 90322

		fetch next from data into @OrderID, @WONUM, @AppointmentID, @AppointmentStatusID
		end
		
	close data
	deallocate data

	EXEC UTP_UpdateXOrderHistory @Memo, @CurrentUserID, @ROWS out

	SET @ROWS = @i

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
end

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateAddress;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: May 20, 2016
-- Description:
--     Update proc from table UTP_Address
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateAddress]
	@Address [dbo].[UTP_AddressType] READONLY,@ROWS [int] = NULL output, @NewID int = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Address) < 1  RETURN 0
 
	declare @new [UTP_AddressType]
	insert into @new
	 (
		[StreetNo],
		[Sfx],
		[Street],
		[Misc],
		[ProvinceID],
		[PostCode],
		[BuildingTypeID],
		[Town],
		[County],
		[Unit],
		[LotNumber],
		[CountryID]

	)
	SELECT
		COALESCE(StreetNo,'0'),
		Sfx,
		Street,
		Misc,
		COALESCE(ProvinceID,'0'),
		PostCode,
		BuildingTypeID,
		Town,
		County,
		Unit,
		LotNumber,
		CountryID

	FROM @Address as ta where ta.Operation = 'A'
	EXEC [dbo].[UTP_CreateAddress] @new,@NewID output
 
--	DELETE does not check whether this record is referenced as a foreign key
	DELETE FROM UTP_Address WHERE AddressID IN (SELECT AddressID FROM @Address as td WHERE td.Operation = 'D')
	UPDATE two
	SET
		two.[StreetNo] = tin.[StreetNo],
		two.[Sfx] = tin.[Sfx],
		two.[Street] = tin.[Street],
		two.[Misc] = tin.[Misc],
		two.[ProvinceID] = tin.[ProvinceID],
		two.[PostCode] = tin.[PostCode],
		two.[BuildingTypeID] = tin.[BuildingTypeID],
		two.[Town] = tin.[Town],
		two.[County] = tin.[County],
		two.[Unit] = tin.[Unit],
		two.[LotNumber] = tin.[LotNumber],
		two.[CountryID] = tin.[CountryID]

		FROM @Address tin join UTP_Address two on two.AddressID = tin.AddressID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	RETURN @NewID



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateAvailability') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateAvailability;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_Availability
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateAvailability]
	@Availability [dbo].[UTP_AvailabilityType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Availability) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[TechnicianID] = tin.[TechnicianID]

		FROM @Availability tin join UTP_Availability two on two.AvailabilityID = tin.AvailabilityID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateCODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateCODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_CODetail
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateCODetail]
	@CODetail [dbo].[UTP_CODetailType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @CODetail) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[OrderID] = tin.[OrderID]

		FROM @CODetail tin join UTP_CODetail two on two.CODetailID = tin.CODetailID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateContact') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateContact;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_Contact
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateContact]
	@Contact [dbo].[UTP_ContactType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Contact) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[OrderID] = tin.[OrderID]

		FROM @Contact tin join UTP_Contact two on two.ContactID = tin.ContactID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateCustomerByOrgID') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateCustomerByOrgID;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Aug 25, 2015
-- Description: Update Org and Customer table
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_UpdateCustomerByOrgID]
	@OrgID int, @Name varchar(255) = null, @ShortName varchar(255) = null
AS
	UPDATE [dbo].[UTP_Org]
	SET [Name] = COALESCE(@Name,Name),
		[ShortName] = COALESCE(@ShortName, ShortName)
	WHERE OrgID = @OrgID




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateDataAttribute') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateDataAttribute;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_DataAttribute
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateDataAttribute]
	@DataAttribute [dbo].[UTP_DataAttributeType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @DataAttribute) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[Category] = tin.[Category],
		two.[AttributeName] = tin.[AttributeName],
		two.[DisplayName] = tin.[DisplayName],
		two.[Description] = tin.[Description],
		two.[DataTypeID] = tin.[DataTypeID],
		two.[Length] = tin.[Length],
		two.[DefaultValue] = tin.[DefaultValue],
		two.[DocText] = tin.[DocText],
		two.[HelpText] = tin.[HelpText],
		two.[LoVKey] = tin.[LoVKey],
		two.[IsActive] = tin.[IsActive],
		two.[IsDerived] = tin.[IsDerived],
		two.[ValidationRule] = tin.[ValidationRule],
		two.[VAddedID] = tin.[VAddedID],
		two.[VRemoved] = tin.[VRemoved]

		FROM @DataAttribute tin join UTP_DataAttribute two on two.DataAttributeID = tin.DataAttributeID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateFADetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateFADetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_FADetail
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateFADetail]
	@FADetail [dbo].[UTP_FADetailType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @FADetail) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[OrderID] = tin.[OrderID]

		FROM @FADetail tin join UTP_FADetail two on two.FADetailID = tin.FADetailID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateGroup') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateGroup;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description:
--     Update proc from table UTP_Group
--     Update replacing all values in the row including NULL
-- Revisions:
--              Mar 08, 2016 DM add GroupManagerID
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateGroup]
	@Group [dbo].[UTP_GroupType] READONLY,@ROWS [int] output, @NewID int output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Group) < 1  RETURN 0
	
	Declare @ID table (GroupID int)
	
	INSERT INTO UTP_Group (GroupCode, GroupName, GroupTypeID, GroupManagerID, IsActive) OUTPUT inserted.GroupID into @ID 
	   SELECT GroupCode, GroupName, GroupTypeID, GroupManagerID, IsActive FROM @Group as ta where ta.Operation = 'A'
	
	DELETE FROM UTP_GroupMember WHERE GroupID IN (SELECT GroupID FROM @Group as td WHERE td.Operation = 'D');
	DELETE FROM UTP_Group WHERE GroupID IN (SELECT GroupID FROM @Group as td WHERE td.Operation = 'D');
 
	UPDATE two
	SET
		two.[GroupCode] = tin.[GroupCode],
		two.[GroupName] = tin.[GroupName],
		two.[GroupTypeID] = tin.[GroupTypeID],
		two.[GroupManagerID] = tin.[GroupManagerID],
		two.[IsActive] = tin.[IsActive]

		FROM @Group tin join UTP_Group two on two.GroupID = tin.GroupID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	Select @NewID = MAX(GroupID) from @ID
	RETURN @ROWS





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateGroupMember') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateGroupMember;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description:
--     Update proc from table UTP_GroupMember
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateGroupMember]
	@GroupMember [dbo].[UTP_GroupMemberType] READONLY,
	@ROWS [int] output, @NewID int output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @GroupMember) < 1  RETURN 0
	
	Declare @ID table (GroupMemberID int)
	
	INSERT INTO UTP_GroupMember (MemberID, GroupID, JobTitleID, IsActive) 
		OUTPUT inserted.GroupMemberID into @ID 
		SELECT ta.MemberID, ta.GroupID, ta.JobTitleID, ta.IsActive 
			FROM @GroupMember as ta left join UTP_GroupMember gm on ta.MemberID = gm.MemberID and ta.GroupID = gm.GroupID
			WHERE ta.Operation = 'A' and gm.MemberID is null
	
	DELETE FROM UTP_GroupMember WHERE GroupMemberID IN (SELECT GroupMemberID FROM @GroupMember as td WHERE td.Operation = 'D');
 
	UPDATE two
	SET
		two.[MemberID] = tin.[MemberID],
		two.[GroupID] = tin.[GroupID],
		two.[JobTitleID] = tin.[JobTitleID],
		two.[IsActive] = tin.[IsActive]

		FROM @GroupMember tin join UTP_GroupMember two on two.GroupMemberID = tin.GroupMemberID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	Select @NewID = MAX(GroupMemberID) from @ID
	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateImportTemplate') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateImportTemplate;
GO


-- =============================================
-- Author:		Jeff Moretti
-- Create date: March 21, 2016
-- Description:	Updates the given template
-- =============================================
CREATE PROCEDURE [dbo].[UTP_UpdateImportTemplate]
	-- Add the parameters for the stored procedure here
	@ImportTemplateId INT,
	@HasHeaders BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE UTP_ImportTemplate
	SET HasHeaders = @HasHeaders
	WHERE ImportTemplateId = @ImportTemplateId
END







;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateJobTitle') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateJobTitle;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description:
--     Update proc from table UTP_JobTitle
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateJobTitle]
	@JobTitle [dbo].[UTP_JobTitleType] READONLY,@ROWS [int] = NULL output , @NewID [int] = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @JobTitle) < 1  RETURN 0
	
	Declare @ID table (JobTitleID int)
	
	declare @new [UTP_JobTitleType]
	INSERT INTO @new (JobTitle, JobDescription, IsActive ) 
	    SELECT JobTitle, JobDescription, IsActive FROM @JobTitle as ta where ta.Operation = 'A'
	EXEC UTP_CreateJobTitle @new,@NewID output

	DELETE FROM UTP_JobTitle WHERE JobTitleID IN (SELECT JobTitleID FROM @JobTitle as td WHERE td.Operation = 'D');
 
	UPDATE two
	SET
		two.[JobTitle] = tin.[JobTitle],
		two.[JobDescription] = tin.[JobDescription],
		two.[IsActive] = tin.[IsActive]

		FROM @JobTitle tin join UTP_JobTitle two on two.JobTitleID = tin.JobTitleID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateListMaster') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateListMaster;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_ListMaster
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateListMaster]
	@ListMaster [dbo].[UTP_ListMasterType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @ListMaster) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[ListKey] = tin.[ListKey],
		two.[ListValue] = tin.[ListValue],
		two.[ListText] = tin.[ListText],
		two.[HelpText] = tin.[HelpText],
		two.[IsActive] = tin.[IsActive],
		two.[IsDefault] = tin.[IsDefault],
		two.[SortOrder] = tin.[SortOrder],
		two.[LoVKey] = tin.[LoVKey],
		two.[LanguageID] = tin.[LanguageID],
		two.[VAddedID] = tin.[VAddedID],
		two.[VRemoved] = tin.[VRemoved],
		two.[VNotes] = tin.[VNotes]

		FROM @ListMaster tin join UTP_ListMaster two on two.ListID = tin.ListID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateOrder') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateOrder;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_Order
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateOrder]
	@Order [dbo].[UTP_OrderType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Order) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[OrgID] = tin.[OrgID],
		two.[OrderTypeID] = tin.[OrderTypeID]

		FROM @Order tin join UTP_Order two on two.OrderID = tin.OrderID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateOrg') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateOrg;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_Org
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateOrg]
	@Org [dbo].[UTP_OrgType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Org) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[Name] = tin.[Name],
		two.[ShortName] = tin.[ShortName]

		FROM @Org tin join UTP_Org two on two.OrgID = tin.OrgID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePanel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePanel;
GO


--Select * from UTP_Panel

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_Panel
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePanel]
	@Panel [dbo].[UTP_PanelType] READONLY,
	@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Panel) < 1  RETURN 0
 
	-- create new PanelColumns if ViewName changed?
	UPDATE two
	SET
		two.[PanelName] = tin.[PanelName],
		two.[PanelTypeID] = tin.[PanelTypeID],
		two.[ParentPanelID] = tin.[ParentPanelID],
		two.PanelViewName = tin.PanelViewName

		FROM @Panel tin join UTP_Panel two on two.PanelID = tin.PanelID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePanelColumn;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_PanelColumn
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePanelColumn]
	@PanelColumn [dbo].[UTP_PanelColumnType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @PanelColumn) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[PanelID] = tin.[PanelID],
		two.[ColumnName] = tin.[ColumnName],
		two.[DataAttributeID] = tin.[DataAttributeID],
		two.[DisplayName] = tin.[DisplayName],
		two.[HelpText] = tin.[HelpText],
		two.[IsActive] = tin.[IsActive],
		two.[IsReadOnly] = tin.[IsReadOnly],
		two.[IsOptional] = tin.[IsOptional],
		two.[IsHidden] = tin.[IsHidden],
		two.[SortOrder] = tin.[SortOrder],
		two.[DataTypeID] = tin.[DataTypeID],
		two.[Length] = tin.[Length],
		two.[ControlTypeID] = tin.[ControlTypeID],
		two.[LoVKey] = tin.[LoVKey],
		two.[LoVQueryName] = tin.[LoVQueryName],
		two.[LoVQueryValueColumn] = tin.[LoVQueryValueColumn],
		two.[LoVQueryDisplayColumn] = tin.[LoVQueryDisplayColumn],
		two.[DefaultValue] = tin.[DefaultValue],
		two.[Description] = tin.[Description],
		two.[LanguageID] = tin.[LanguageID],
		two.[FormatString] = tin.[FormatString],
		two.[ColumnWidth] = tin.[ColumnWidth]

		FROM @PanelColumn tin join UTP_PanelColumn two on two.PanelColumnID = tin.PanelColumnID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePanelColumnFromParms') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePanelColumnFromParms;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Sep 22, 2015
-- Description:
--     Update table UTP_PanelColumn from params
--     Note that NULL params will not replace existing values
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePanelColumnFromParms]
	@PanelColumnID int = NULL,
	@PanelID [int] = NULL,
	@PanelName [varchar](255) = NULL,
	@ColumnName [varchar](255) = NULL,
	@DataAttributeID [int] = NULL,
	@DisplayName [varchar](255) = NULL,
	@HelpText [varchar](max) = NULL,
	@IsActive [bit] = NULL,
	@IsReadOnly [bit] = NULL,
	@IsOptional [bit] = NULL,
	@IsHidden [bit] = NULL,
	@SortOrder [int] = NULL,
	@DataTypeID [int] = NULL,
	@Length [int] = NULL,
	@ControlTypeID [int] = NULL,
	@LoVKey [varchar](255) = NULL,
	@LoVQueryName [varchar](255) = NULL,
	@LoVQueryValueColumn [varchar](255) = NULL,
	@LoVQueryDisplayColumn [varchar](255) = NULL,
	@DefaultValue [varchar](255) = NULL,
	@Description [varchar](max) = NULL,
	@LanguageID [int] = NULL,
	@FormatString [varchar](max) = NULL,
	@ColumnWidth [int] = NULL,

	@ROWS [int] = NULL output
AS
 
	UPDATE UTP_PanelColumn
	SET 
		[PanelID] = COALESCE(@PanelID,pc.[PanelID]),
		[ColumnName] = case when @PanelColumnID is null then [ColumnName] else COALESCE(@ColumnName,[ColumnName]) end,
		[DataAttributeID] = COALESCE(@DataAttributeID,[DataAttributeID]),
		[DisplayName] = case when @DisplayName = 'NULL' then null else COALESCE(@DisplayName,[DisplayName]) end,
		[HelpText] = case when @HelpText = 'NULL' then null else COALESCE(@HelpText,[HelpText]) end,
		[IsActive] = COALESCE(@IsActive,pc.[IsActive],1),
		[IsReadOnly] = COALESCE(@IsReadOnly,[IsReadOnly],0),
		[IsOptional] = COALESCE(@IsOptional,[IsOptional],1),
		[IsHidden] = COALESCE(@IsHidden,[IsHidden],0),
		[SortOrder] = COALESCE(@SortOrder,[SortOrder]),
		[DataTypeID] = COALESCE(@DataTypeID,[DataTypeID]),
		[Length] = COALESCE(@Length,[Length]),
		[ControlTypeID] = COALESCE(@ControlTypeID,[ControlTypeID]),
		[LoVKey] = case when @LoVKey = 'NULL' then null else COALESCE(@LoVKey,[LoVKey]) end,
		[LoVQueryName] = case when @LoVQueryName = 'NULL' then null else COALESCE(@LoVQueryName,[LoVQueryName]) end,
		[LoVQueryValueColumn] = case when @LoVQueryValueColumn = 'NULL' then null else COALESCE(@LoVQueryValueColumn,[LoVQueryValueColumn]) end,
		[LoVQueryDisplayColumn] = case when @LoVQueryDisplayColumn = 'NULL' then null else COALESCE(@LoVQueryDisplayColumn,[LoVQueryDisplayColumn]) end,
		[DefaultValue] = case when @DefaultValue = 'NULL' then null else COALESCE(@DefaultValue,[DefaultValue]) end,
		[Description] = case when @Description = 'NULL' then null else COALESCE(@Description,[Description]) end,
		[LanguageID] = COALESCE(@LanguageID,[LanguageID]),
		[FormatString] = isnull(@FormatString,[FormatString]),
		[ColumnWidth] = isnull(@ColumnWidth,[ColumnWidth])

	FROM UTP_PanelColumn pc INNER JOIN UTP_Panel p on pc.PanelID = p.PanelID
	WHERE PanelColumnID = COALESCE(@PanelColumnID,PanelColumnID)
		AND pc.PanelID = COALESCE(@PanelID,pc.PanelID)
		AND pc.ColumnName like COALESCE(@ColumnName,ColumnName)
		AND p.PanelName like COALESCE(@PanelName,PanelName)
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePanelCommand') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePanelCommand;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: May 20, 2016
-- Description:
--     Update proc from table UTP_PanelCommand
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePanelCommand]
	@PanelCommand [dbo].[UTP_PanelCommandType] READONLY,@ROWS [int] = NULL output, @NewID int = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @PanelCommand) < 1  RETURN 0
 
	declare @new [UTP_PanelCommandType]
	insert into @new
	 (
		[PanelID],
		[ProcedureCalled],
		[ModuleID],
		[Comments],
		[Description]

	)
	SELECT
		PanelID,
		ProcedureCalled,
		ModuleID,
		Comments,
		Description

	FROM @PanelCommand as ta where ta.Operation = 'A'
	EXEC [dbo].[UTP_CreatePanelCommand] @new,@NewID output
 
--	DELETE does not check whether this record is referenced as a foreign key
	DELETE FROM UTP_PanelCommand WHERE PanelCommandID IN (SELECT PanelCommandID FROM @PanelCommand as td WHERE td.Operation = 'D')
	UPDATE two
	SET
		two.[PanelID] = tin.[PanelID],
		two.[ProcedureCalled] = tin.[ProcedureCalled],
		two.[ModuleID] = tin.[ModuleID],
		two.[Comments] = tin.[Comments],
		two.[Description] = tin.[Description]

		FROM @PanelCommand tin join UTP_PanelCommand two on two.PanelCommandID = tin.PanelCommandID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	RETURN @NewID



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePanelPermission') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePanelPermission;
GO


-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_PanelPermission
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePanelPermission]
	@PanelPermission [dbo].[UTP_PanelPermissionType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @PanelPermission) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[PanelID] = tin.[PanelID],
		two.[UserID] = tin.[UserID],
		two.[View] = tin.[View],
		two.[Add] = tin.[Add],
		two.[Edit] = tin.[Edit],
		two.[Delete] = tin.[Delete],
		two.[Duplicate] = tin.[Duplicate],
		two.[Submit] = tin.[Submit]

		FROM @PanelPermission tin inner join UTP_PanelPermission two on two.PanelPermissionID = tin.PanelPermissionID
		WHERE coalesce(tin.Operation,'U') in ('U','A')

	INSERT UTP_PanelPermission ([PanelID], [UserID], [View], [Add], [Edit], [Delete], [Duplicate], [Submit])
		SELECT [PanelID] = tin.[PanelID],
			[UserID] = tin.[UserID],
			[View] = tin.[View],
			[Add] = tin.[Add],
			[Edit] = tin.[Edit],
			[Delete] = tin.[Delete],
			[Duplicate] = tin.[Duplicate],
			[Submit] = tin.[Submit]

		FROM @PanelPermission tin left join UTP_PanelPermission two on two.PanelPermissionID = tin.PanelPermissionID
		WHERE two.PanelPermissionID is null

	DELETE two
		FROM @PanelPermission tin inner join UTP_PanelPermission two on two.PanelPermissionID = tin.PanelPermissionID
		WHERE tin.Operation = 'D'

	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS






;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePerson') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePerson;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_Person
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePerson]
	@Person [dbo].[UTP_PersonType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Person) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[PersonTypeID] = tin.[PersonTypeID],
		two.[FirstName] = tin.[FirstName],
		two.[LastName] = tin.[LastName],
		two.[Description] = tin.[Description],
		two.[PhoneEmailID] = tin.[PhoneEmailID],
		two.[BusinessName] = tin.[BusinessName]

		FROM @Person tin join UTP_Person two on two.PersonID = tin.PersonID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePersonnel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePersonnel;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_Personnel
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePersonnel]
	@Personnel [dbo].[UTP_PersonnelType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Personnel) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[PersonID] = tin.[PersonID],
		two.[OrgID] = tin.[OrgID]

		FROM @Personnel tin join UTP_Personnel two on two.PersonnelID = tin.PersonnelID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePhoneEmail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePhoneEmail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_PhoneEmail
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePhoneEmail]
	@PhoneEmail [dbo].[UTP_PhoneEmailType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @PhoneEmail) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[CellPhone] = tin.[CellPhone],
		two.[Pager] = tin.[Pager],
		two.[HomePhone] = tin.[HomePhone],
		two.[OfficePhone] = tin.[OfficePhone],
		two.[Email] = tin.[Email]

		FROM @PhoneEmail tin join UTP_PhoneEmail two on two.PhoneEmailID = tin.PhoneEmailID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdatePODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdatePODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_PODetail
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdatePODetail]
	@PODetail [dbo].[UTP_PODetailType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @PODetail) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[OrderID] = tin.[OrderID]

		FROM @PODetail tin join UTP_PODetail two on two.PODetailID = tin.PODetailID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateReport') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateReport;
GO

CREATE PROC [dbo].[UTP_UpdateReport]
	@Report [dbo].[UTP_ReportType] READONLY,@ROWS [int] output, @NewID int output
AS
	SELECT @ROWS = -1
	IF (SELECT COUNT(*) from @Report) < 1  RETURN -1
	
	Declare @ID table (ReportID int)
	
	INSERT INTO UTP_Report OUTPUT inserted.ReportID into @ID SELECT UserID, ReportName, ReportTypeID, ConnectionString, SqlStatement, StatementTypeID, ReportDefinition FROM @Report as ta where ta.Operation = 'A'
	
	DELETE FROM UTP_ReportParameter WHERE ReportID IN (SELECT ReportID FROM @Report as td WHERE td.Operation = 'D');
	DELETE FROM UTP_Report WHERE ReportID IN (SELECT ReportID FROM @Report as td WHERE td.Operation = 'D');
 
	UPDATE two
	SET
		two.[UserID] = tin.[UserID]
      ,two.[ReportName] = tin.[ReportName]
      ,two.[ReportTypeID] = tin.[ReportTypeID]
      ,two.[ConnectionString] = tin.[ConnectionString]
      ,two.[SqlStatement] = tin.[SqlStatement]
      ,two.[StatementTypeID] = tin.[StatementTypeID]
      ,two.[ReportDefinition] = tin.[ReportDefinition]

		FROM @Report tin join UTP_Report two on two.ReportID = tin.ReportID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	
	Select @NewID = MAX(ReportID) from @ID
	
	RETURN @ROWS





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateReportParameter') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateReportParameter;
GO

CREATE PROC [dbo].[UTP_UpdateReportParameter]
	@ReportParameter [dbo].[UTP_ReportParameterType] READONLY,@ROWS [int] output, @NewID int output
AS
	SELECT @ROWS = -1
	IF (SELECT COUNT(*) from @ReportParameter) < 1  RETURN -1
	
	Declare @ID table (ReportParameterID int)
	
	INSERT INTO UTP_ReportParameter OUTPUT inserted.ReportParameterID into @ID SELECT ReportID, ReportParameter, ReportParameterValue FROM @ReportParameter as ta where ta.Operation = 'A'
	
	DELETE FROM UTP_ReportParameter WHERE ReportParameterID IN (SELECT ReportParameterID FROM @ReportParameter as td WHERE td.Operation = 'D');
 
	UPDATE two
	SET
		two.[ReportID] = tin.[ReportID]
      ,two.[ReportParameter] = tin.[ReportParameter]
      ,two.[ReportParameterValue] = tin.[ReportParameterValue]

		FROM @ReportParameter tin join UTP_ReportParameter two on two.ReportParameterID = tin.ReportParameterID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	
	Select @NewID = MAX(ReportParameterID) from @ID
	
	RETURN @ROWS





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateSpec') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateSpec;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 05, 2016
-- Description:
--     Update proc from table UTP_Spec
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateSpec]
	@Spec [dbo].[UTP_SpecType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Spec) < 1  RETURN 0
 
	UPDATE two
	SET
		--two.[OrderID] = tin.[OrderID],
		--two.[DataAttributeID] = tin.[DataAttributeID],
		--two.[ProductID] = tin.[ProductID],
		two.[AttributeValue] = tin.[AttributeValue]

		FROM @Spec tin join UTP_Spec two on two.SpecID = tin.SpecID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateTechnician;
GO


-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_Technician
--     Update replacing all values in the row including NULL
-- Revisions:
--		10-Apr-2016	JP	Implement TechnicianID DCR
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateTechnician]
	@Technician [dbo].[UTP_TechnicianType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Technician) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[TechnicianTypeID] = tin.[TechnicianTypeID],
		two.[GSTNo] = tin.[GSTNo],
		two.[PerformanceFactor] = tin.[PerformanceFactor],
		two.[Comments] = tin.[Comments],
		two.[InsuranceNum] = tin.[InsuranceNum],
		two.[InsuranceExpDate] = tin.[InsuranceExpDate],
		two.[LicenceNum] = tin.[LicenceNum],
		two.[LicenceExpDate] = tin.[LicenceExpDate],
		two.[HasHandHeld] = tin.[HasHandHeld]

		FROM @Technician tin join UTP_Technician two on two.TechnicianID = tin.TechnicianID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS





;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateUser') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateUser;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_User
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateUser]
	@User [dbo].[UTP_UserType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @User) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[PersonID] = tin.[PersonID],
		two.[UserTypeID] = tin.[UserTypeID],
		two.[UserName] = tin.[UserName],
		two.[Password] = tin.[Password],
		two.[Isactive] = tin.[IsActive]

		FROM @User tin join UTP_User two on two.UserID = tin.UserID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateUserColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateUserColumn;
GO

create procedure [dbo].[UTP_UpdateUserColumn]
	@PanelName varchar(255),
	@ColumnName varchar(255),
	@CurrentUserID int,
	@IsHidden bit = NULL,
	@SortOrder int = NULL,
	@IsFrozen bit = NULL,
	@ColumnWidth int = NULL,
	
	@NewID int output
as

	DECLARE @UserColumnID int = null,
			@PanelColumnID int = null

	SELECT @PanelColumnID = PanelColumnID 
		FROM UTP_PanelColumn pc inner join UTP_Panel p on pc.PanelID = p.PanelID 
		WHERE PanelName = @PanelName and ColumnName = @ColumnName

	SELECT @UserColumnID = UserColumnID 
		FROM UTP_UserColumn 
		WHERE PanelColumnId = @PanelColumnID and UserID = @CurrentUserID

	IF @UserColumnID is not null
		UPDATE UTP_UserColumn 
			SET IsHidden = isnull(@IsHidden,IsHidden),
				IsFrozen = isnull(@IsFrozen,IsFrozen),
				SortOrder = isnull(@SortOrder,SortOrder),
				ColumnWidth = isnull(@ColumnWidth,ColumnWidth)
			WHERE UserColumnID = @UserColumnID
	ELSE
		BEGIN
		INSERT UTP_UserColumn (UserID, PanelColumnID, SortOrder, IsHidden, IsFrozen, ColumnWidth)
			SELECT @CurrentUserID, @PanelColumnID, @SortOrder, @IsHidden, @IsFrozen, @ColumnWidth

		SET @NewID = SCOPE_IDENTITY()
		END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateUserPreference') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateUserPreference;
GO
/*
select * from UTP_User
select * from UTP_UserPreference where AttributeName = 'AutomaticUpdates' --UserID=1
exec UTP_UpdateUserPreference 'AutomaticUpdates', 'true', 'Admin'
*/
CREATE PROCEDURE [dbo].[UTP_UpdateUserPreference]
	@AttributeName varchar(255),
	@AttributeValue varchar(255),
	@Username varchar(50) = null,
	@CurrentUserID int = null
as

	if @Username is null
		update up
			set AttributeValue = @AttributeValue
			from UTP_UserPreference up 
			where AttributeName = @AttributeName
	else
		update up
			set AttributeValue = @AttributeValue
			from UTP_UserPreference up inner join UTP_User u on up.UserID = u.UserID
			where AttributeName = @AttributeName
				and u.Username = @Username


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateUserSession') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateUserSession;
GO

CREATE PROCEDURE [dbo].[UTP_UpdateUserSession]
	@Action varchar(255),
	@CurrentUserID int
as

	DECLARE @UserSessionID int = null
	IF @Action = 'Logoff'
		BEGIN
		SELECT TOP 1
				@UserSessionID = UserSessionID
			FROM UTP_UserSession 
			WHERE UserID = @CurrentUserID
				and [Action] = 'Logon'
				and SessionEndTimestamp is null
			ORDER BY UserSessionID desc

		IF @UserSessionID is not null
			UPDATE UTP_UserSession
				SET SessionEndTimestamp = getdate()
				WHERE UserSessionID = @UserSessionID
		ELSE
			INSERT UTP_UserSession (UserID, SessionEndTimestamp, [Action])
				values (@CurrentUserID, getdate(), @Action)
		END
	ELSE
		INSERT UTP_UserSession (UserID, SessionStartTimestamp, [Action])
			values (@CurrentUserID, getdate(), @Action)

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateUserWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateUserWorkSchedule;
GO


CREATE PROCEDURE [dbo].[UTP_UpdateUserWorkSchedule]
	@ScheduleTypeID int = 90350, -- Project
	@GroupID int = null, 
	@UserID int = null, 
	@Workdate date = null, 
	@Capacity1 int = null,
	@Capacity2 int = null,
	@Capacity3 int = null,
	@Capacity4 int = null,
	@Capacity5 int = null,
	@CurrentUserID [int] = null
as
	set nocount on

	declare @WorkScheduleID int = null

	set @ScheduleTypeID = isnull(@ScheduleTypeID,90350)

	IF @Capacity1 is not null
		BEGIN 
		SELECT @WorkScheduleID = WorkScheduleID 
			FROM UTP_WorkSchedule 
			WHERE ScheduleTypeID = isnull(@ScheduleTypeID,90350) and UserID = @UserID and GroupID = @GroupID 
				and WorkDate = @Workdate and TimeSlotID = 90301

		IF @WorkScheduleID is not null
			UPDATE UTP_WorkSchedule	SET Capacity = @Capacity1 WHERE WorkScheduleID = @WorkScheduleID
		ELSE
			INSERT UTP_WorkSchedule (UserID, WorkDate, TimeslotID, GroupID, Capacity, ScheduleTypeID)
				VALUES (@UserID, @Workdate, 90301, @GroupID, @Capacity1, @ScheduleTypeID)
		END

	IF @Capacity2 is not null
		BEGIN 
		SELECT @WorkScheduleID = WorkScheduleID 
			FROM UTP_WorkSchedule 
			WHERE ScheduleTypeID = isnull(@ScheduleTypeID,90350) and UserID = @UserID and GroupID = @GroupID 
				and WorkDate = @Workdate and TimeSlotID = 90302

		IF @WorkScheduleID is not null
			UPDATE UTP_WorkSchedule	SET Capacity = @Capacity2 WHERE WorkScheduleID = @WorkScheduleID
		ELSE
			INSERT UTP_WorkSchedule (UserID, WorkDate, TimeslotID, GroupID, Capacity, ScheduleTypeID)
				VALUES (@UserID, @Workdate, 90302, @GroupID, @Capacity2, @ScheduleTypeID)
		END

	IF @Capacity3 is not null
		BEGIN 
		SELECT @WorkScheduleID = WorkScheduleID 
			FROM UTP_WorkSchedule 
			WHERE ScheduleTypeID = isnull(@ScheduleTypeID,90350) and UserID = @UserID and GroupID = @GroupID 
				and WorkDate = @Workdate and TimeSlotID = 90303

		IF @WorkScheduleID is not null
			UPDATE UTP_WorkSchedule	SET Capacity = @Capacity3 WHERE WorkScheduleID = @WorkScheduleID
		ELSE
			INSERT UTP_WorkSchedule (UserID, WorkDate, TimeslotID, GroupID, Capacity, ScheduleTypeID)
				VALUES (@UserID, @Workdate, 90303, @GroupID, @Capacity3, @ScheduleTypeID)
		END

	IF @Capacity4 is not null
		BEGIN 
		SELECT @WorkScheduleID = WorkScheduleID 
			FROM UTP_WorkSchedule 
			WHERE ScheduleTypeID = isnull(@ScheduleTypeID,90350) and UserID = @UserID and GroupID = @GroupID 
				and WorkDate = @Workdate and TimeSlotID = 90304

		IF @WorkScheduleID is not null
			UPDATE UTP_WorkSchedule	SET Capacity = @Capacity4 WHERE WorkScheduleID = @WorkScheduleID
		ELSE
			INSERT UTP_WorkSchedule (UserID, WorkDate, TimeslotID, GroupID, Capacity, ScheduleTypeID)
				VALUES (@UserID, @Workdate, 90304, @GroupID, @Capacity4, @ScheduleTypeID)
		END

	IF @Capacity5 is not null
		BEGIN 
		SELECT @WorkScheduleID = WorkScheduleID 
			FROM UTP_WorkSchedule 
			WHERE ScheduleTypeID = isnull(@ScheduleTypeID,90350) and UserID = @UserID and GroupID = @GroupID 
				and WorkDate = @Workdate and TimeSlotID = 90305

		IF @WorkScheduleID is not null
			UPDATE UTP_WorkSchedule	SET Capacity = @Capacity5 WHERE WorkScheduleID = @WorkScheduleID
		ELSE
			INSERT UTP_WorkSchedule (UserID, WorkDate, TimeslotID, GroupID, Capacity, ScheduleTypeID)
				VALUES (@UserID, @Workdate, 90305, @GroupID, @Capacity5, @ScheduleTypeID)
		END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Updatevw_Catalog') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Updatevw_Catalog;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description:
--     Update proc from table vw_UTP_Catalog
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Updatevw_Catalog]
	@vw_UTP_Catalog [dbo].[vw_UTP_CatalogType] READONLY,@ROWS [int] = NULL output, @NewID int = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @vw_UTP_Catalog) < 1  RETURN 0
 
	declare @new [vw_UTP_CatalogType]
	insert into @new
	 (
		[CatalogName],
		[RowVersionID],
		[IsActive]

	)
	SELECT
		CatalogName,
		RowVersionID,
		IsActive

	FROM @vw_UTP_Catalog as ta where ta.Operation = 'A'
	EXEC [dbo].[UTP_Createvw_Catalog] @new,@NewID output
 
--	DELETE does not check whether this record is referenced as a foreign key
	DELETE FROM vw_UTP_Catalog WHERE CatalogID IN (SELECT CatalogID FROM @vw_UTP_Catalog as td WHERE td.Operation = 'D')
/* --- need special coding
	UPDATE two
	SET
		two.[CatalogName] = tin.[CatalogName],
		two.[RowVersionID] = tin.[RowVersionID],
		two.[IsActive] = tin.[IsActive]

		FROM @vw_UTP_Catalog tin join vw_UTP_Catalog two on two.CatalogID = tin.CatalogID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	RETURN @NewID
*/




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Updatevw_Document') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Updatevw_Document;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description:
--     Update proc from table vw_UTP_Document
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Updatevw_Document]
	@vw_UTP_Document [dbo].[vw_UTP_DocumentType] READONLY,@ROWS [int] = NULL output, @NewID int = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @vw_UTP_Document) < 1  RETURN 0
 
	declare @new [vw_UTP_DocumentType]
	insert into @new
	 (
		[DocumentTypeID],
		[DocumentType],
		[DateCreated],
		[CreatedByID],
		[CreatedBy],
		[ScannerID],
		[Scanner],
		[Filename],
		[URL]

	)
	SELECT
		DocumentTypeID,
		DocumentType,
		DateCreated,
		CreatedByID,
		CreatedBy,
		ScannerID,
		Scanner,
		Filename,
		URL

	FROM @vw_UTP_Document as ta where ta.Operation = 'A'
	EXEC [dbo].[UTP_Createvw_Document] @new,@NewID output
 
--	DELETE does not check whether this record is referenced as a foreign key
	DELETE FROM vw_UTP_Document WHERE DocumentID IN (SELECT DocumentID FROM @vw_UTP_Document as td WHERE td.Operation = 'D')
/* --- need special coding
	UPDATE two
	SET
		two.[DocumentTypeID] = tin.[DocumentTypeID],
		two.[DocumentType] = tin.[DocumentType],
		two.[DateCreated] = tin.[DateCreated],
		two.[CreatedByID] = tin.[CreatedByID],
		two.[CreatedBy] = tin.[CreatedBy],
		two.[ScannerID] = tin.[ScannerID],
		two.[Scanner] = tin.[Scanner],
		two.[Filename] = tin.[Filename],
		two.[URL] = tin.[URL]

		FROM @vw_UTP_Document tin join vw_UTP_Document two on two.DocumentID = tin.DocumentID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	RETURN @NewID
*/




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Updatevw_DocumentStorage') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Updatevw_DocumentStorage;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description:
--     Update proc from table vw_UTP_DocumentStorage
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Updatevw_DocumentStorage]
	@vw_UTP_DocumentStorage [dbo].[vw_UTP_DocumentStorageType] READONLY,@ROWS [int] = NULL output, @NewID int = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @vw_UTP_DocumentStorage) < 1  RETURN 0
 
	declare @new [vw_UTP_DocumentStorageType]
	insert into @new
	 (
		[DocumentTypeID],
		[OrgID],
		[Name],
		[ShortName],
		[RootFolder],
		[DestinationFolder]

	)
	SELECT
		DocumentTypeID,
		OrgID,
		Name,
		ShortName,
		RootFolder,
		DestinationFolder

	FROM @vw_UTP_DocumentStorage as ta where ta.Operation = 'A'
	EXEC [dbo].[UTP_Createvw_DocumentStorage] @new,@NewID output
 
--	DELETE does not check whether this record is referenced as a foreign key
	DELETE FROM vw_UTP_DocumentStorage WHERE DocumentStorageID IN (SELECT DocumentStorageID FROM @vw_UTP_DocumentStorage as td WHERE td.Operation = 'D')
/* --- need special coding
	UPDATE two
	SET
		two.[DocumentTypeID] = tin.[DocumentTypeID],
		two.[OrgID] = tin.[OrgID],
		two.[Name] = tin.[Name],
		two.[ShortName] = tin.[ShortName],
		two.[RootFolder] = tin.[RootFolder],
		two.[DestinationFolder] = tin.[DestinationFolder]

		FROM @vw_UTP_DocumentStorage tin join vw_UTP_DocumentStorage two on two.DocumentStorageID = tin.DocumentStorageID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	RETURN @NewID
*/




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Updatevw_Panel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Updatevw_Panel;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description:
--     Update proc from table vw_UTP_Panel
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Updatevw_Panel]
	@vw_UTP_Panel [dbo].[vw_UTP_PanelType] READONLY,@ROWS [int] = NULL output, @NewID int = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @vw_UTP_Panel) < 1  RETURN 0
 
	declare @new [vw_UTP_PanelType]
	insert into @new
	 (
		[PanelName],
		[PanelTypeID],
		[PanelType],
		[ParentPanelID],
		[ParentPanel]

	)
	SELECT
		PanelName,
		PanelTypeID,
		PanelType,
		ParentPanelID,
		ParentPanel

	FROM @vw_UTP_Panel as ta where ta.Operation = 'A'
	EXEC [dbo].[UTP_Createvw_Panel] @new,@NewID output
 
--	DELETE does not check whether this record is referenced as a foreign key
	DELETE FROM vw_UTP_Panel WHERE PanelID IN (SELECT PanelID FROM @vw_UTP_Panel as td WHERE td.Operation = 'D')
/* --- need special coding
	UPDATE two
	SET
		two.[PanelName] = tin.[PanelName],
		two.[PanelTypeID] = tin.[PanelTypeID],
		two.[PanelType] = tin.[PanelType],
		two.[ParentPanelID] = tin.[ParentPanelID],
		two.[ParentPanel] = tin.[ParentPanel]

		FROM @vw_UTP_Panel tin join vw_UTP_Panel two on two.PanelID = tin.PanelID and tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	RETURN @NewID
*/




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_Updatevw_PanelColumn') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_Updatevw_PanelColumn;
GO


-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description:
--     Update proc from table vw_UTP_PanelColumn
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_Updatevw_PanelColumn]
	@vw_UTP_PanelColumn [dbo].[vw_UTP_PanelColumnType] READONLY,@ROWS [int] = NULL output, @NewID int = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @vw_UTP_PanelColumn) < 1  RETURN 0
 
	declare @new [vw_UTP_PanelColumnType]
	insert into @new
	 (
		[PanelID],
		[PanelName],
		[ColumnName],
		[DataAttributeID],
		[AttributeName],
		[DisplayName],
		[HelpText],
		[IsActive],
		[IsReadOnly],
		[IsOptional],
		[IsHidden],
		[SortOrder],
		[DataTypeID],
		[DataType],
		[Length],
		[ControlTypeID],
		[ControlType],
		[LoVKey],
		[LoVQueryName],
		[LoVQueryDisplayColumn],
		[DefaultValue],
		[Description],
		[LanguageID],
		[Language]

	)
	SELECT
		PanelID,
		PanelName,
		ColumnName,
		DataAttributeID,
		AttributeName,
		DisplayName,
		HelpText,
		IsActive,
		IsReadOnly,
		IsOptional,
		IsHidden,
		SortOrder,
		DataTypeID,
		DataType,
		Length,
		ControlTypeID,
		ControlType,
		LoVKey,
		LoVQueryName,
		LoVQueryDisplayColumn,
		DefaultValue,
		Description,
		LanguageID,
		Language

	FROM @vw_UTP_PanelColumn as ta where ta.Operation = 'A'
	EXEC [dbo].[UTP_Createvw_PanelColumn] @new,@NewID output
 
--	DELETE does not check whether this record is referenced as a foreign key
	DELETE FROM vw_UTP_PanelColumn WHERE PanelColumnID IN (SELECT PanelColumnID FROM @vw_UTP_PanelColumn as td WHERE td.Operation = 'D')
/* --- need special coding
	UPDATE two
	SET
		two.[PanelID] = tin.[PanelID],
		two.[PanelName] = tin.[PanelName],
		two.[ColumnName] = tin.[ColumnName],
		two.[DataAttributeID] = tin.[DataAttributeID],
		two.[AttributeName] = tin.[AttributeName],
		two.[DisplayName] = tin.[DisplayName],
		two.[HelpText] = tin.[HelpText],
		two.[IsActive] = tin.[IsActive],
		two.[IsReadOnly] = tin.[IsReadOnly],
		two.[IsOptional] = tin.[IsOptional],
		two.[IsHidden] = tin.[IsHidden],
		two.[SortOrder] = tin.[SortOrder],
		two.[DataTypeID] = tin.[DataTypeID],
		two.[DataType] = tin.[DataType],
		two.[Length] = tin.[Length],
		two.[ControlTypeID] = tin.[ControlTypeID],
		two.[ControlType] = tin.[ControlType],
		two.[LoVKey] = tin.[LoVKey],
		two.[LoVQueryName] = tin.[LoVQueryName],
		two.[LoVQueryDisplayColumn] = tin.[LoVQueryDisplayColumn],
		two.[DefaultValue] = tin.[DefaultValue],
		two.[Description] = tin.[Description],
		two.[LanguageID] = tin.[LanguageID],
		two.[Language] = tin.[Language]

		FROM @vw_UTP_PanelColumn tin join vw_UTP_PanelColumn two on two.PanelColumnID = tin.PanelColumnID and tin.Operation = ''U''
	SELECT @ROWS = @@ROWCOUNT
	RETURN @NewID
*/

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateWODetail') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateWODetail;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Nov 19, 2015
-- Description:
--     Update proc from table UTP_WODetail
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateWODetail]
	@WODetail [dbo].[UTP_WODetailType] READONLY,@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @WODetail) < 1  RETURN 0
 
	UPDATE two
	SET
		two.[OrderID] = tin.[OrderID]

		FROM @WODetail tin join UTP_WODetail two on two.WODetailID = tin.WODetailID
	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateWONotes') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateWONotes;
GO

CREATE proc [dbo].[UTP_UpdateWONotes]
	@OrderID int,
	@WONotes varchar(max),
	@CurrentUserID int = NULL
as

-- Updates to EGD_WO DESCRIPTION_LONGDESCRIPTION are no longer allowed in WAMS 2017
	if (select ShortName from UTP_Org org inner join UTP_Order o on org.OrgID = o.OrgID where o.OrderID = @OrderID) <> 'EGD'
		update UTP_WO
			set WONotes = @WONotes
			where OrderID = @OrderID


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateWorkSchedule;
GO

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description:
--     Update proc from table UTP_WorkSchedule
--     Update replacing all values in the row including NULL
-- Revisions:
--              Mar 08, 2016 DM add GroupID
--				Mar 10, 2016 DM handle A, D operations
--				May 1, 2016	JP Booked should not be changed if input is null
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateWorkSchedule]
	@WorkSchedule [dbo].[UTP_WorkScheduleType] READONLY,@ROWS [int] = NULL output, @NewID [int] = NULL output
AS
	SELECT @NewID = 0, @ROWS = 0
	IF (SELECT COUNT(*) from @WorkSchedule) < 1  RETURN 0
	
	DELETE FROM UTP_WorkSchedule where WorkScheduleID in (select WorkScheduleID from @WorkSchedule where Operation='D')

	DECLARE @new [dbo].[UTP_WorkScheduleType]
	INSERT @new select * from @WorkSchedule where Operation='A'
	EXEC @NewID = [UTP_CreateWorkSchedule] @new
 
	UPDATE two
	SET
		two.[UserID] = tin.[UserID],
		two.[WorkDate] = tin.[WorkDate],
		two.[TimeSlotID] = tin.[TimeSlotID],
		two.[Available] = tin.[Available],
		two.[Booked] = COALESCE(tin.[Booked],two.[Booked],0),
		two.[GroupID] = tin.[GroupID]

		FROM @WorkSchedule tin join UTP_WorkSchedule two on two.WorkScheduleID = tin.WorkScheduleID
			where Operation='U'
	select @ROWS = @@ROWCOUNT
	RETURN @ROWS




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateWOServiceAddress') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateWOServiceAddress;
GO



-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description:
--     Update proc from table vw_UTP_WOServiceAddress
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateWOServiceAddress]
	@WOServiceAddress [dbo].[UTP_WOServiceAddressType] READONLY,@ROWS [int] = NULL output, @NewID int = NULL output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @WOServiceAddress) < 1  RETURN 0
 
	declare @new [UTP_WOServiceAddressType]
	insert into @new
	 (
		[WOID],
		[WONUM],
		[OrderAddressID],
		[AddressID],
		[AddressTypeID],
		[AddressType],
		[StreetNo],
		[LotNumber],
		[Unit],
		[Street],
		[Sfx],
		[Misc],
		[Town],
		[County],
		[ProviceCode],
		[PostalCode],
		[CountryCode]

	)
	SELECT
		WOID,
		WONUM,
		OrderAddressID,
		AddressID,
		AddressTypeID,
		AddressType,
		StreetNo,
		LotNumber,
		Unit,
		Street,
		Sfx,
		Misc,
		Town,
		County,
		ProviceCode,
		PostalCode,
		CountryCode

	FROM @WOServiceAddress as ta where ta.Operation = 'A'
	EXEC [dbo].[UTP_CreateWOServiceAddress] @new,@NewID output
 
--	DELETE does not check whether this record is referenced as a foreign key
	DELETE FROM vw_UTP_WOServiceAddress WHERE OrderID IN (SELECT OrderID FROM @WOServiceAddress as td WHERE td.Operation = 'D')
/* --- need special coding
	UPDATE two
	SET
		two.[WOID] = tin.[WOID],
		two.[WONUM] = tin.[WONUM],
		two.[OrderAddressID] = tin.[OrderAddressID],
		two.[AddressID] = tin.[AddressID],
		two.[AddressTypeID] = tin.[AddressTypeID],
		two.[AddressType] = tin.[AddressType],
		two.[StreetNo] = tin.[StreetNo],
		two.[LotNumber] = tin.[LotNumber],
		two.[Unit] = tin.[Unit],
		two.[Street] = tin.[Street],
		two.[Sfx] = tin.[Sfx],
		two.[Misc] = tin.[Misc],
		two.[Town] = tin.[Town],
		two.[County] = tin.[County],
		two.[ProvinceID] = tin.[ProvinceID],
		two.[ProviceCode] = tin.[ProviceCode],
		two.[Province] = tin.[Province],
		two.[PostCode] = tin.[PostCode],
		two.[CountryID] = tin.[CountryID],
		two.[CountryCode] = tin.[CountryCode],
		two.[Country] = tin.[Country],
		two.[BuildingTypeID] = tin.[BuildingTypeID],
		two.[BuildingType] = tin.[BuildingType]

		FROM @WOServiceAddress tin join UTP_WOServiceAddress two on two.OrderID = tin.OrderID and tin.Operation = ''U''
	SELECT @ROWS = @@ROWCOUNT
	RETURN @NewID
*/

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXAppointment') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXAppointment;
GO

-- ===========================================================
-- Author: John Peacock
-- Create date: July 2, 2016
-- Description:
--     Update proc from table UTP_Appointment
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXAppointment]
	@Appointment [dbo].[UTP_WOAppointmentType] READONLY,
	@CurrentUserID int = null,
	
	@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Appointment) < 1  RETURN 0
 
	INSERT UTP_Appointment (OrderID, TechnicianID, AppointmentTypeID, AppointmentStatusID,
				ActualStart,ActualFinish,CompletionCode)
		SELECT tin.OrderID, tin.TechnicianID, tin.AppointmentTypeID, tin.AppointmentStatusID,
				tin.ActualStart,tin.ActualFinish,tin.CompletionCode
		FROM @Appointment tin left join UTP_Appointment two on two.AppointmentID = tin.AppointmentID
		WHERE two.AppointmentID is null

	DELETE two
		FROM @Appointment tin inner join UTP_Appointment two on two.AppointmentID = tin.AppointmentID
		WHERE Operation = 'D'

	UPDATE two
	SET
		two.[TechnicianID] = tin.[TechnicianID],
		two.[AppointmentTypeID] = tin.[AppointmentTypeID],
		two.[AppointmentStatusID] = tin.[AppointmentStatusID],
		two.[ActualStart] = tin.ActualStart,
		two.[ActualFinish] = tin.ActualFinish,
		two.CompletionCode = tin.CompletionCode

		FROM @Appointment tin inner join UTP_Appointment two on two.AppointmentID = tin.AppointmentID
		WHERE Operation = 'U'

	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXCollection') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXCollection;
GO

-- ===========================================================
-- UTP_UpdateXCollection
-- Revisions:
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_UpdateXCollection]
	@Collection UTP_CollectionType READONLY,
	@CurrentUserID int = null,
	@ROWS [int] output, 
	@NewID bigint output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Collection) < 1  RETURN 0	
	
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@Username varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	Select	@ProcedureName = 'UTP_UpdateXCollection',
			@Identifier = CollectionName
		from @Collection

	select @Username = Username from UTP_User where UserID = @CurrentUserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	set nocount on

	Declare @ID table (CollectionID int)
	
	INSERT INTO UTP_Collection (CollectionName, CollectionTypeID, CollectionOwnerID, CollectionQuery, StatementTypeID) 
		OUTPUT inserted.CollectionID into @ID 
		SELECT t.CollectionName, t.CollectionTypeID, t.CollectionOwnerID, t.CollectionQuery, t.StatementTypeID
			FROM @Collection t left join UTP_Collection c on t.CollectionName = c.CollectionName
			WHERE Operation = 'A' and c.CollectionID is null

	DELETE FROM UTP_CollectionItem WHERE CollectionID IN (SELECT CollectionID FROM @Collection WHERE Operation = 'D');
	DELETE FROM UTP_Collection WHERE CollectionID IN (SELECT CollectionID FROM @Collection WHERE Operation = 'D');

	UPDATE c
		SET	CollectionName = t.CollectionName,
			CollectionOwnerID = t.CollectionOwnerID,
			CollectionQuery = t.CollectionQuery,
			StatementTypeID = t.StatementTypeID

		FROM @Collection t 
			inner join UTP_Collection c on t.CollectionID = c.CollectionID
			left join UTP_Collection c2 on t.CollectionName = c2.CollectionName
		WHERE t.Operation = 'U' and c2.CollectionID is null

	SELECT @ROWS = @@ROWCOUNT
	Select @NewID = MAX(CollectionID) from @ID
	
	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel		

	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXCollectionItem') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXCollectionItem;
GO

-- ===========================================================
-- UTP_UpdateXCollectionItem
-- Revisions:
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_UpdateXCollectionItem]
	@CollectionItem UTP_CollectionItemType READONLY,
	@CurrentUserID int = null,
	@ROWS [int] output, 
	@NewID bigint output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @CollectionItem) < 1  RETURN 0
	
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@Username varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	Select	@ProcedureName = 'UTP_UpdateXCollectionItem',
			@Identifier = CollectionName
		from @CollectionItem

	select @Username = Username from UTP_User where UserID = @CurrentUserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	set nocount on

	Declare @ID table (CollectionItemID int)
	
	INSERT INTO UTP_CollectionItem (CollectionID, CollectionItem) 
		OUTPUT inserted.CollectionItemID into @ID 
		SELECT t.CollectionID, t.CollectionItem
			FROM @CollectionItem t 
				left join UTP_CollectionItem ci on t.CollectionID = ci.CollectionID and t.CollectionItem = ci.CollectionItem
			WHERE Operation = 'A' and ci.CollectionItemID is null

	DELETE FROM UTP_CollectionItem WHERE CollectionItemID IN (SELECT CollectionItemID FROM @CollectionItem WHERE Operation = 'D');

	UPDATE ci
		SET	CollectionItem = t.CollectionItem

		FROM @CollectionItem t 
			inner join UTP_CollectionItem ci on t.CollectionItemID = ci.CollectionItemID
			left join UTP_CollectionItem ci2 on t.CollectionID = ci2.CollectionID and t.CollectionItem = ci2.CollectionItem
		WHERE t.Operation = 'U' and ci2.CollectionItemID is null

	SELECT @ROWS = @@ROWCOUNT
	Select @NewID = MAX(CollectionItemID) from @ID

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXGroup') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXGroup;
GO

/*
declare @g vw_UTP_GroupType, @ROWS int, @NewID int
insert @g (GroupID, GroupCode, GroupName, GroupTypeID, IsActive, GroupManagerID, ParentGroupID)
	select GroupID, GroupCode, GroupName, GroupTypeID, IsActive, GroupManagerID, 0 from UTP_Group where GroupID=19
exec [UTP_UpdateXGroup] @g, null, @rows output, @newID output
select * from UTP_Group
*/
-- ===========================================================
-- Author: John Peacock
-- Create date: Apr 30, 2016
-- Description:
--     Update proc from table UTP_Group
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXGroup]
	@Group [dbo].[vw_UTP_GroupType] READONLY,
	@CurrentUserID [int] = null,
	@ROWS [int] output, 
	@NewID int output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Group) < 1  RETURN 0
	
	Declare @ID table (GroupID int)
	
	INSERT INTO UTP_Group (GroupCode, GroupName, GroupTypeID, GroupManagerID, ParentGroupID, IsActive) OUTPUT inserted.GroupID into @ID 
	   SELECT GroupCode, GroupName, GroupTypeID, 
				GroupManagerID = case GroupManagerID when 0 then null else GroupManagerID end, 
				ParentGroupID = case ParentGroupID when 0 then null else ParentGroupID end, 
				IsActive 
		FROM @Group as ta 
		WHERE	 ta.Operation = 'A'
	
	DELETE FROM UTP_GroupMember WHERE GroupID IN (SELECT GroupID FROM @Group as td WHERE td.Operation = 'D');
	DELETE FROM UTP_Group WHERE GroupID IN (SELECT GroupID FROM @Group as td WHERE td.Operation = 'D');
 
	UPDATE two
	SET
		two.[GroupCode] = tin.[GroupCode],
		two.[GroupName] = tin.[GroupName],
		two.[GroupTypeID] = tin.[GroupTypeID],
		two.[GroupManagerID] = case tin.[GroupManagerID] when 0 then null else tin.GroupManagerID end, 
		two.[ParentGroupID] = case tin.[ParentGroupID] when 0 then null else tin.ParentGroupID end, 
		two.[IsActive] = tin.[IsActive]

		FROM @Group tin join UTP_Group two on two.GroupID = tin.GroupID 
		WHERE tin.Operation = 'U'
	SELECT @ROWS = @@ROWCOUNT
	Select @NewID = MAX(GroupID) from @ID
	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXGroupMember') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXGroupMember;
GO
-- ===========================================================
-- Author: John Peacock
-- Create date: Apr 30, 2016
-- Description:
--     Update proc from table UTP_Group
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXGroupMember]
	@GroupMember [dbo].[vw_UTP_GroupMemberType] READONLY,
	@CurrentUserID [int] = null,
	@ROWS [int] output, 
	@NewID int output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @GroupMember) < 1  RETURN 0
	
	Declare @ID table (GroupMemberID int)
	
	INSERT INTO UTP_GroupMember (MemberID, GroupID, JobTitleID, IsActive) OUTPUT inserted.GroupMemberID into @ID 
	   SELECT ta.MemberID, ta.GroupID, ta.JobTitleID, ta.IsActive 
			FROM @GroupMember as ta left join UTP_GroupMember gm on ta.MemberID = gm.MemberID and ta.GroupID = gm.GroupID
			WHERE ta.Operation = 'A' and gm.MemberID is null
	
	DELETE FROM UTP_GroupMember WHERE GroupMemberID IN (SELECT GroupMemberID FROM @GroupMember as td WHERE td.Operation = 'D');
 
	UPDATE two
		SET
			two.MemberID = tin.MemberID,
			two.GroupID = tin.GroupID,
			two.JobTitleID = tin.JobTitleID,
			two.[IsActive] = tin.[IsActive]

		FROM @GroupMember tin join UTP_GroupMember two on two.GroupMemberID = tin.GroupMemberID and tin.Operation = 'U'

	SELECT @ROWS = @@ROWCOUNT
	Select @NewID = MAX(GroupMemberID) from @ID
	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXJobCard') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXJobCard;
GO
-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 05, 2016
-- Description:
--     Update proc from table UTP_OrderJobCard
--     Update replacing all values in the row including NULL
-- Revisions:
--	30-Jan-2017	JRP Disallow linking the OrderID is DataEntryStatus is NotInUtopis
--	01-Feb-2017	IDM	Send RED TAGS to Enbridge
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXJobCard]
	@OrderJobCard [dbo].[UTP_OrderJobCardType] READONLY,
	@CurrentUserID int,
	
	@ROWS [int] output,
	@NEWID [int] = null output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select	@ProcedureName = 'UTP_UpdateXJobCard IN: Operation=' + isnull(Operation,'null')
								+ ', DocumentID=' + isnull(cast(DocumentID as varchar(6)),'null')
								+ ', OrderJobCardID=' + isnull(cast(OrderJobCardID as varchar(6)),'null')
								+ ', DocumentTypeID=' + isnull(cast(DocumentTypeID as varchar(6)),'null')
								+ ', DataEntryStatusID=' + isnull(cast(DataEntryStatusID as varchar(6)),'null')
								+ ', TechnicianID=' + isnull(cast(TechnicianID as varchar(6)),'null')
								+ ', OrderID=' + isnull(cast(OrderID as varchar(6)),'null')
								+ ', WONUM=' + isnull(WONUM,'null')
								+ ', WONUMOnCard=' + isnull(WONUMOnCard,'null')
								+ ', JobCardMemo=' + isnull(JobCardMemo,'null')
								+ ', CompletionDateOnCard=' + isnull(cast(CompletionDateOnCard as varchar(25)),'null'),
			@Identifier = isnull(cast(OrderID as varchar(8)),'')
		from @OrderJobCard

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @OrderJobCard) <> 1  RETURN 0
 
	DECLARE @SubmitBy varchar(50)
	IF @CurrentUserID IS NULL OR @CurrentUserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @CurrentUserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@CurrentUserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @CurrentUserID provided',2
	END

	declare @OrderID int = null,
			@WONUM varchar(15) = null,
			@WONUMOnCard varchar(15) = null,
			@OrderJobCardID int = null,
			@DocumentID int = null,
			@JobcardLine int = null,
			@TechnicianID int = null,
			@DocumentTypeID int = null,
			@Operation varchar(3) = null,
			@TmpOrderID int = null,
			@TmpWONUM varchar(15) = null,
			@IsRedTag bit = 0, @NewOrderLinkage bit = 0, @DocumentTypeChanged bit = 0

	select top 1 
			@DocumentID = DocumentID,
			@OrderID = case when DataEntryStatusID in (2003) then null else OrderID end, 
			@WONUM = case when DataEntryStatusID in (2003) then null else WONUM end, 
			@WONUMOnCard = case when DataEntryStatusID in (2003) then null else WONUMOnCard end, 
			@OrderJobCardID = OrderJobCardID,
			@JobcardLine = JobCardLine,
			@DocumentTypeID = DocumentTypeID,
			@Operation = Operation,
			@IsRedTag = CASE WHEN DocumentTypeID IS NOT NULL AND DocumentTypeID=[dbo].fnUTP_GetListMaster('DocumentType','RED TAGS') THEN 1 ELSE 0 END
		from @OrderJobCard

	IF @OrderID IS NOT NULL SELECT @TmpWONUM=WONUM FROM vw_TPS_WO where OrderID=@OrderID
	IF @WONUM IS NOT NULL SELECT @TmpOrderID=OrderID FROM vw_TPS_WO where WONUM=@WONUM
	
	/*
	set @TmpOrderID = @OrderID
	select	@TmpOrderID = OrderID,
			@TmpWONUM = WONUM
		from vw_UTP_WO 
		where (@WONUM is not null and WONUM = @WONUM)
			or (@OrderID is not null and OrderID = @OrderID)
	*/

	if @TmpOrderID is null and @WONUM is not null
		begin
		set @;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXJobHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXJobHistory;
GO

CREATE PROC [dbo].[UTP_UpdateXJobHistory]
	@JobHistory UTP_JobHistoryType READONLY,
	@CurrentUserID int = NULL,
	@ROWS [int] output, 
	@NewID int output
as

	insert UTP_JobHistory (PersonID, JobTitleID, EffectiveFromDate, EffectiveToDate)
		select PersonID, JobTitleID, EffectiveFromDate, EffectiveToDate from @JobHistory where Operation='A'

	delete jh 
		from @JobHistory tin inner join UTP_JobHistory jh on tin.JobHistoryID = jh.JobHistoryID
		where Operation='D'

	update jh
		set	EffectiveFromDate = tin.EffectiveFromDate,
			EffectiveToDate = tin.EffectiveToDate
		from @JobHistory tin inner join UTP_JobHistory jh on tin.JobHistoryID = jh.JobHistoryID
		where Operation='U'

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXJobRequirement') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXJobRequirement;
GO

CREATE PROC [dbo].[UTP_UpdateXJobRequirement]
	@JobRequirement UTP_JobRequirementType READONLY,
	@CurrentUserID int = NULL,
	@ROWS [int] output, 
	@NewID int output
as

	insert UTP_JobTestReq (JobTitleID,TestID,EffectiveFromDate,EffectiveToDate)
		select JobTitleID,TestID,EffectiveFromDate,EffectiveToDate from @JobRequirement where Operation='A'

	delete tr
		from @JobRequirement tin inner join UTP_JobTestReq tr on tin.JobRequirementID = tr.JobTestReqID
		where Operation='D'

	update tr
			set EffectiveFromDate = tin.EffectiveFromDate,
				EffectiveToDate = tin.EffectiveToDate
		from @JobRequirement tin inner join UTP_JobTestReq tr on tin.JobRequirementID = tr.JobTestReqID
		where Operation='U'

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXLocation') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXLocation;
GO

/*
declare @location UTP_LocationType, @NewID int, @Error int
insert @location (GroupID, LocationTypeID, Location, StartDate, EndDate, Operation)
	values (1,580,'N2E1A3','2/1/2017','3/1/2017','A')
exec UTP_UpdateXLocation @location, 1, @NewID out, @Error out
print @NewID
print @Error
select * from UTP_Location
*/

CREATE PROCEDURE [dbo].[UTP_UpdateXLocation]
	@Location UTP_LocationType READONLY,
	@CurrentUserID int = NULL,

	@NewID int output,
	@Error int output
as
	declare @Message table (ErrorMessage varchar(255))

	IF (SELECT count(*) FROM @Location) > 0
		BEGIN 
		INSERT INTO [dbo].[UTP_Location] ([GroupID],[LocationTypeID],[Location],[StartDate],[EndDate])
			 SELECT tin.GroupID, tin.LocationTypeID, tin.Location, tin.StartDate, tin.EndDate 
				FROM @Location tin LEFT JOIN UTP_Location l 
					on tin.GroupID = l.GroupID and tin.LocationTypeID = l.LocationTypeID and tin.Location = l.Location and tin.StartDate = l.StartDate and tin.EndDate = l.EndDate
				WHERE l.LocationID is null and Operation = 'A'

		SET @NewID = SCOPE_IDENTITY()

		DELETE UTP_Location 
			FROM @Location tin LEFT JOIN UTP_Location l on tin.LocationID = l.LocationID 
			WHERE Operation = 'D'
		
		UPDATE l
			SET	LocationTypeID = tin.LocationTypeID,
				Location = tin.Location,
				StartDate = tin.StartDate,
				EndDate = tin.EndDate

			FROM @Location tin LEFT JOIN UTP_Location l on tin.LocationID = l.LocationID 
			WHERE Operation = 'U'
 
		SET @Error = 0
		END
	ELSE
		BEGIN
		SET @Error = 1
		SELECT ErrorMessage FROM @Message
		END


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXOrderHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXOrderHistory;
GO

/*
select * from UTP_ListMaster where ListKey='MemoType'
declare @m UTP_OrderHistoryType,
		@ROWS int
insert @m (OrderID, MemoTypeID, Memo, Operation)
		select 1, 1001, 'asdfg', 'A'
exec [UTP_UpdateXOrderHistory] @m, 1, @ROWS out
exec [UTP_GetOrderHistory] null, 1, null, 1
select * from UTP_OrderHistory where OrderID = 1
*/
-- ===========================================================
-- Author: John Peacock
-- Create date: July 2, 2016
-- Description:
--     Update proc from table UTP_Appointment
--     Update replacing all values in the row including NULL
-- Revisions:
--	27-Feb-2017	JRP Add SQL REPORTEXCL to EGD Worklog
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXOrderHistory]
	@OrderHistory [dbo].UTP_OrderHistoryType READONLY,
	@CurrentUserID int = null,
	
	@ROWS [int] output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select @ProcedureName = 'UTP_UpdateXOrderHistory:'
				+ ' @MemoTypeID=' + isnull(cast(MemoTypeID as varchar(10)),'null'),
				 @Identifier = cast(OrderID as varchar(20))
		from @OrderHistory
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @OrderHistory) < 1  RETURN 0
 
	INSERT UTP_OrderHistory (OrderID, MemoTypeID, Memo, CreatedByID, CreatedTimestamp,
				TechnicianID, OrderStatusCode, StatusTimestamp)
		SELECT tin.OrderID, tin.MemoTypeID, tin.Memo, isnull(tin.CreatedByID, @CurrentUserID), isnull(tin.CreatedTimestamp,getdate()),
				tin.TechnicianID, tin.OrderStatusCode, tin.StatusTimestamp
		FROM @OrderHistory tin left join UTP_OrderHistory two on two.OrderHistoryID = tin.OrderHistoryID
		WHERE two.OrderHistoryID is null
			AND Operation = 'A'

	DECLARE @InsertTable TABLE (ID int, WOID int, LOGTYPE varchar(255))

	DELETE two
		FROM @OrderHistory tin left join UTP_OrderHistory two on two.OrderHistoryID = tin.OrderHistoryID
		WHERE Operation = 'D'
			AND tin.MemoTypeID = 1002 -- Field Remarks, only

	UPDATE two
	SET
		two.MemoTypeID = tin.MemoTypeID,
		two.Memo = tin.Memo,
		two.CreatedByID = isnull(tin.CreatedByID,@CurrentUserID),
		two.CreatedTimestamp = isnull(tin.CreatedTimestamp,getdate()),
		two.TechnicianID = tin.TechnicianID,
		two.OrderStatusCode = tin.OrderStatusCode,
		two.StatusTimestamp = tin.StatusTimestamp

		FROM @OrderHistory tin left join UTP_OrderHistory two on two.OrderHistoryID = tin.OrderHistoryID
		WHERE Operation = 'U'

	SELECT @ROWS = @@ROWCOUNT

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXPanel') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXPanel;
GO


-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Apr 22, 2016
-- Description: Insert into table vw_UTP_Panel from params
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXPanel]
	@Panel [dbo].[UTP_PanelType] READONLY,
	@CurrentUserID int = null,

	@PanelIDout [int] = null output,
	@ROWS [int] output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Panel) < 1  RETURN 0

	insert into UTP_Panel
			 (
				[PanelName],
				[PanelTypeID],
				[ParentPanelID],
				[PanelViewName]

			)
		SELECT
			PanelName,
			PanelTypeID,
			ParentPanelID,
			PanelViewName

		FROM @Panel
		WHERE Operation = 'A'

	SELECT @PanelIDout= COALESCE(SCOPE_IDENTITY(),0)
 
	UPDATE two
	SET
		two.[PanelName] = tin.[PanelName],
		two.[PanelTypeID] = tin.[PanelTypeID],
		two.[ParentPanelID] = tin.[ParentPanelID],
		two.[PanelViewName] = tin.[PanelViewName]

		FROM @Panel tin inner join UTP_Panel two on two.PanelID = tin.PanelID
			AND Operation = 'U'

	RETURN @PanelIDout

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXPerson') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXPerson;
GO


-- ===========================================================
-- Author: John Peacock
-- Create date: Apr 30, 2015
-- Description:
--     Update proc from table UTP_Person
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXPerson]
	@Person [dbo].[vw_UTP_PersonType] READONLY,
	@CurrentUserID [int] = null,
	@ROWS [int] output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_UpdateXPerson'
	select @Identifier = FirstName + ' ' + LastName from @Person
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Person) < 1  RETURN 0
 
	Declare @ID table (PersonID int)
	Declare @PE UTP_PhoneEmailType,
			@PhoneEmailID int

	-- create PhoneEmail record
	INSERT @PE (PhoneEmailID, CellPhone, Pager, HomePhone, OfficePhone, Email, Operation)
		SELECT PhoneEmailID, CellPhone, Pager, HomePhone, OfficePhone, Email, Operation FROM @Person WHERE Operation = 'U'

	EXEC UTP_UpdatePhoneEmail @PE, @ROWS

	INSERT UTP_PhoneEmail (CellPhone, Pager, HomePhone, OfficePhone, Email)
		SELECT TOP 1 CellPhone, Pager, HomePhone, OfficePhone, Email FROM @Person WHERE Operation = 'A'
	SET @PhoneEmailID = scope_identity()

	INSERT INTO UTP_Person (PersonTypeID, FirstName, LastName, Description, PhoneEmailID, BusinessName) OUTPUT inserted.PersonID into @ID 
	   SELECT TOP 1 PersonTypeID, FirstName, LastName, Description, @PhoneEmailID, BusinessName FROM @Person as ta where ta.Operation = 'A'
	
	--UPDATE UTP_Person SET IsActive = 0 WHERE PersonID IN (SELECT PersonID FROM @Person as td WHERE td.Operation = 'D');
 
	UPDATE two
	SET
		two.[PersonTypeID] = tin.[PersonTypeID],
		two.[FirstName] = tin.[FirstName],
		two.[LastName] = tin.[LastName],
		two.[Description] = tin.[Description],
		two.[PhoneEmailID] = tin.[PhoneEmailID],
		two.[BusinessName] = tin.[BusinessName]

		FROM @Person tin join UTP_Person two on two.PersonID = tin.PersonID

	SELECT @ROWS = @@ROWCOUNT

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXRelatedWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXRelatedWO;
GO

-- =============================================
-- Author:		John Peacock
-- Create date: July 2, 2016
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[UTP_UpdateXRelatedWO]
	@RWO [dbo].UTP_RelatedWOType READONLY,
	@CurrentUserID int = null,

	@ROWS int output
AS
	BEGIN
	SET NOCOUNT ON

	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @RWO) < 1  RETURN 0

	INSERT UTP_WOStructure (PrimaryOrderID, RelatedOrderID, RelationTypeID)
		SELECT	tin.PrimaryOrderID,
				tin.RelatedOrderID,
				RelationTypeID = isnull(tin.RelationTypeID,dbo.fnUTP_GetListMaster('UTP_WORelationType','RC'))

		FROM @RWO tin
			LEFT JOIN UTP_WOStructure two on two.PrimaryOrderID = tin.PrimaryOrderID and two.RelatedOrderID = tin.RelatedOrderID
		WHERE tin.Operation = 'A'
			AND two.PrimaryOrderID is null

	DELETE two
		FROM UTP_WOStructure two 
			INNER JOIN @RWO tin on two.PrimaryOrderID = tin.PrimaryOrderID and two.RelatedOrderID = tin.RelatedOrderID
		WHERE Operation = 'D' 

	UPDATE two 
		SET	
			RelationTypeID = coalesce(tin.RelationTypeID,two.RelationTypeID,-1)

		FROM UTP_WOStructure two 
			INNER JOIN @RWO tin on two.PrimaryOrderID = tin.PrimaryOrderID and two.RelatedOrderID = tin.RelatedOrderID
		WHERE Operation = 'U' 
	END

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXSpec') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXSpec;
GO
-- ===========================================================
-- Author: John Peacock
-- Create date: Apr 05, 2016
-- Description:
--     Update proc from table UTP_Spec and EGD_Spec
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXSpec]
	@OrderID int,
	@Spec [dbo].[UTP_SpecType] READONLY,
	@ROWS [int] output
AS	
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select top 1 @ProcedureName = 'UTP_UpdateXSpec: INROWS=' + isnull(cast(count(*) as varchar(10)),'null')
					+ ',have values=' + isnull(cast(sum(case when isnull(AttributeValue,'') <> '' then 1 else 0 end) as varchar(10)),'null')
					--+ ', AttributeName=' + isnull(two.ASSETATTRID,'null')
					--+ ', AttributeValue=' + isnull(AttributeValue,'null')
					--+ ', DataType=' + isnull(DataType,'null')
					--+ ', WAMS_DATEVALUE=' + isnull(cast(case when (two.DATATYPE = 'DATETIME' and IsDate(tin.AttributeValue)=1) then cast(tin.AttributeValue as datetime) else null end as varchar(25)),'null')
  
		FROM @Spec tin left join UTP_Spec two on two.SpecID = tin.SpecID  
		--WHERE two.ASSETATTRID = 'EXRLFTYP'
  
	set @Identifier = cast(@OrderID as varchar(20))
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on
	DECLARE @MagicNAValue varchar(20)='#^' -- for dropdown ALN, means null

	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Spec) < 1  RETURN 0

	DECLARE @OrgShortName varchar(50),
			@EGD_Spec JRP_AttributeType

	SELECT @OrgShortName = ShortName from UTP_Org c inner join UTP_Order o on c.OrgID = o.OrgID where o.OrderID = @OrderID
	UPDATE two
	SET
		two.[AttributeValue] = tin.[AttributeValue]

		FROM @Spec tin join UTP_Spec two on two.SpecID = tin.SpecID
		WHERE tin.Operation = 'U'

	SELECT @ROWS = @@ROWCOUNT

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXTask') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXTask;
GO

/*
declare @t [UTP_TaskType]
declare @rows int, @newid int
insert @t (Operation,TaskID,TaskTypeID) values ('A',2,12)
exec [UTP_UpdateXTask] @t,1, @rows output, @newid output
select top 100 * from UTP_Task order by TaskID desc
*/

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description:
--     Update proc from table UTP_Task
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXTask]
	@Task [dbo].[UTP_TaskType] READONLY,
	@CurrentUserID int = null,
	@ROWS [int] output, 
	@NEWID int output

AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Task) < 1  RETURN 0

	DECLARE @Now datetime
	SET @Now = getdate()

	INSERT [UTP_Task]
           ([TaskTypeID]
           ,[TaskNumber]
           ,[TaskDescription]
           ,[TaskStatusID]
           ,[TaskPriorityID]
           ,[DueDate]
           ,[CreatedByID]
		   ,[CreatedTimestamp]
           ,[TaskManagerID]
           ,[Category]
           ,[Scope]
           ,[ProjectNumber]
           ,[RaisedDate]
           ,[RaisedBy]
           ,[TargetStart]
           ,[TargetFinish]
		   ,[AssignedToID]
		   ,[AssignedDate]
           ,[ActualStart]
           ,[ActualFinish]
           ,[CompletedByID]
           ,[CompletionCode]
           ,[EstimatedDuration]
           ,[ActualDuration]
           ,[Instructions]
           ,[Notes]
           ,[FollowupDate]
           ,[FollowupAction]
           ,[FollowupFreqID]
           ,[CostCenter])

	SELECT [TaskTypeID] = isnull(tin.TaskTypeID,8301)
		  ,tin.[TaskNumber]
		  ,tin.[TaskDescription]
		  ,[TaskStatusID] = case when isnull(tin.TaskStatusID,0) <> 0 then tin.TaskStatusID else 8051 end
		  ,[TaskPriorityID] = isnull(tin.TaskPriority,8002)
		  ,tin.[DueDate]
		  ,[CreatedByID] = @CurrentUserID
		  ,[CreatedTimestamp] = @Now
		  ,[TaskManagerID]= case when isnull(tin.TaskManagerID,0) <> 0 then tin.TaskManagerID else null end
		  ,tin.[Category]
		  ,tin.[Scope]
		  ,tin.[ProjectNumber]
		  ,[RaisedDate] = isnull(tin.RaisedDate,@Now)
		  ,[RaisedBy] = isnull(tin.RaisedBy,u.UserName)
		  ,tin.[TargetStart]
		  ,tin.[TargetFinish]
		  ,[AssignedToID] = case when isnull(tin.AssignedToID,0) <> 0 then tin.AssignedToID else null end
		  ,[AssignedDate] = case when isnull(tin.AssignedToID,0) <> 0 then @Now else null end
		  ,tin.[ActualStart]
		  ,tin.[ActualFinish]
		  ,[CompletedByID] = case when isnull(tin.CompletedByID,0) <> 0 then tin.CompletedByID else null end
		  ,tin.[CompletionCode]
		  ,tin.[EstimatedDuration]
		  ,tin.[ActualDuration]
		  ,tin.[Instructions]
		  ,tin.[Notes]
		  ,tin.[FollowupDate]
		  ,tin.[FollowupAction]
		  ,tin.[FollowupFreqID]
		  ,tin.[CostCenter]
		FROM @Task tin
			left join UTP_Task two on two.TaskNumber = tin.TaskNumber
			left join UTP_User u on tin.CreatedByID = u.UserID
		WHERE Operation in ('A','U')
			and two.TaskID is null

	SET @NEWID = SCOPE_IDENTITY()

	DELETE two 
		FROM @Task tin inner join UTP_Task two on two.TaskID = tin.TaskID
		WHERE Operation='D'

	UPDATE two
	   SET [TaskTypeID] = tin.TaskTypeID
		  ,[TaskNumber] = tin.TaskNumber
		  ,[TaskDescription] = tin.TaskDescription
		  ,[TaskStatusID] = tin.TaskStatusID
		  ,[TaskPriorityID] = tin.TaskPriorityID
		  ,[DueDate] = tin.DueDate
		  ,[TaskManagerID] = tin.TaskManagerID
		  ,[Category] = tin.Category
		  ,[Scope] = tin.Scope
		  ,[ProjectNumber] = tin.ProjectNumber
		  ,[RaisedDate] = tin.RaisedDate
		  ,[RaisedBy] = tin.RaisedBy
		  ,[TargetStart] = tin.TargetStart
		  ,[TargetFinish] = tin.TargetFinish
		  ,[AssignedToID] = tin.AssignedToID
		  ,[AssignedDate] = isnull(tin.AssignedDate, case when two.AssignedToID is not null then @Now else null end)
		  ,[ActualStart] = tin.ActualStart
		  ,[ActualF;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXTaskHistory') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXTaskHistory;
GO

/*
declare @t [UTP_TaskHistoryType]
declare @rows int, @newid int
insert @t (Operation,TaskID,Memo,MemoTypeID) values ('A',2,'Status',8202)
exec [UTP_UpdateXTaskHistory] @t,1, @rows output, @newid output
select * from UTP_TaskHistory

*/

-- ===========================================================
-- Author: auto-generated from table definitions
-- Create date: Feb 15, 2016
-- Description:
--     Update proc from table UTP_TaskHistory
--     Update replacing all values in the row including NULL
-- Revisions:
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXTaskHistory]
	@TaskHistory [dbo].[UTP_TaskHistoryType] READONLY,
	@CurrentUserID int = null,
	@ROWS [int] output, 
	@NEWID int output
AS
	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @TaskHistory) < 1  RETURN 0
 
 INSERT INTO [UTP_TaskHistory]
           ([TaskID]
           ,[CreatedByID]
           ,[Memo]
           ,[MemoTypeID]
           ,[AssignedToID]
           ,[ActualDuration])
	SELECT [TaskID]
		  ,[CreatedByID] = @CurrentUserID
		  ,[Memo]
		  ,[MemoTypeID]
		  ,[AssignedToID]
		  ,[ActualDuration]
	  FROM @TaskHistory
	  WHERE Operation='A'

	DELETE two
		FROM @TaskHistory tin inner join UTP_TaskHistory two on two.TaskHistoryID = tin.TaskHistoryID
		WHERE Operation='D'


	UPDATE two
	   SET [TaskID] = tin.TaskID
		  ,[Memo] = tin.Memo
		  ,[MemoTypeID] = tin.MemoTypeID
		  ,[AssignedToID] = tin.AssignedToID
		  ,[ActualDuration] = tin.ActualDuration
		FROM @TaskHistory tin inner join UTP_TaskHistory two on two.TaskHistoryID = tin.TaskHistoryID
		WHERE Operation='U'

	SELECT @ROWS = @@ROWCOUNT
	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXTechnician') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXTechnician;
GO
-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Dec 14, 2015
-- Description: Update Technician and Person
-- Revisions: 
--		10-Apr-2016	JP	Implement TechnicianID DCR
--      14-Jun-2017 DM  Preserve IsActive flag on UTP_User
-- ====================================================================================
CREATE PROC [dbo].[UTP_UpdateXTechnician]
	@TechnicianP [dbo].[vw_UTP_TechnicianType] READONLY, 
	@CurrentUserID [int],
	
	@ROWS [int] = NULL output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255) = ''

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select top 1 @ProcedureName = 'UTP_UpdateXTechnician: TechnicianID=' + isnull(cast(TechnicianID as varchar(10)),'null')
				+ ', UserID=' + isnull(cast(UserID as varchar(10)),'null')
				+ ', PersonID=' + isnull(cast(PersonID as varchar(10)),'null')
				+ ', PhoneEmailID=' + isnull(cast(PhoneEmailID as varchar(10)),'null')
				+ ', HasHH=' +  isnull(cast(HasHandHeld as varchar(10)),'null')
 				+ ', Cell=' +  isnull(CellPhone,'null')
		FROM @TechnicianP tin 
  
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	declare @ROWSAFFECTED int, @Technician UTP_TechnicianType, @Person UTP_PersonType, @User UTP_UserType, @Phone UTP_PhoneEmailType
	insert into @Technician (TechnicianID,TechnicianTypeID,GSTNo,PerformanceFactor,Comments,InsuranceNum,InsuranceExpDate,LicenceNum,LicenceExpDate,HasHandHeld)
		select TechnicianID,TechnicianTypeID,GSTNo,PerformanceFactor,Comments,InsuranceNum,InsuranceExpDate,LicenceNum,LicenceExpDate,HasHandHeld from @TechnicianP
	exec [dbo].[UTP_UpdateTechnician] @Technician, @ROWS output
	set @ProcedureName = @ProcedureName + ', T_Rows=' + isnull(cast(@ROWS as varchar(10)),'null')
	insert into @Person (PersonID,PersonTypeID,FirstName,LastName,Description,PhoneEmailID,BusinessName)
		select PersonID,PersonTypeID,FirstName,LastName,Description,PhoneEmailID,BusinessName from @TechnicianP
	exec [dbo].[UTP_UpdatePerson] @Person, @ROWSAFFECTED output
	set @ProcedureName = @ProcedureName + ', P_Rows=' + isnull(cast(@ROWSAFFECTED as varchar(10)),'null')
	select @ROWS = @ROWS + @ROWSAFFECTED
	insert @Phone (PhoneEmailID, CellPhone, Pager, HomePhone, OfficePhone, Email)
		select PhoneEmailID, CellPhone, Pager, HomePhone, OfficePhone, Email  from @TechnicianP
	exec UTP_UpdatePhoneEmail @Phone, @ROWSAFFECTED output
	set @ProcedureName = @ProcedureName + ', E_Rows=' + isnull(cast(@ROWSAFFECTED as varchar(10)),'null')

	declare @IsActive int = COALESCE((select IsActive from UTP_User where UserID = (select UserID from @TechnicianP)),1)
	insert into @User (UserID, PersonID, UserTypeID, Username, Password, IsActive)
		select UserID, PersonID, UserTypeID, Username, Username, @IsActive from @TechnicianP 
	exec [dbo].[UTP_UpdateUser] @User, @ROWSAFFECTED output
	set @ProcedureName = @ProcedureName + ', U_Rows=' + isnull(cast(@ROWSAFFECTED as varchar(10)),'null')
	select @ROWS = @ROWS + @ROWSAFFECTED

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @ROWS

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXUser') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXUser;
GO

-- ====================================================================================
-- Author: Diane MacMartin
-- Create date: Dec 14, 2015
-- Description: Update User and Person
-- Revisions: 
--		21-May-2016	JP  Udpate UTP_User.IsActive also
-- ====================================================================================
CREATE PROC [dbo].[UTP_UpdateXUser]
	@UserP [dbo].[vw_UTP_UserType] READONLY,
	@CurrentUserID [int] = null,
	@ROWS [int] = NULL output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select top 1 
			@ProcedureName = 'UTP_UpdateXUser, Op=' + Operation,
			@Identifier = UserID 
		from @UserP

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	declare @ROWSAFFECTED int, @User UTP_UserType, @Person UTP_PersonType

	Declare @PE UTP_PhoneEmailType,
			@PhoneEmailID int

	-- create PhoneEmail record
	INSERT @PE (PhoneEmailID, CellPhone, Pager, HomePhone, OfficePhone, Email, Operation)
		SELECT PhoneEmailID, CellPhone, Pager, HomePhone, OfficePhone, Email, Operation FROM @UserP WHERE Operation = 'U'

	EXEC UTP_UpdatePhoneEmail @PE, @ROWS

	--INSERT UTP_PhoneEmail (CellPhone, Pager, HomePhone, OfficePhone, Email)
	--	SELECT TOP 1 CellPhone, Pager, HomePhone, OfficePhone, Email FROM @UserP WHERE Operation = 'A'
	--SET @PhoneEmailID = scope_identity()

	insert into @User (UserID, PersonID,UserTypeID,UserName,[Password],IsActive)
		select UserID, PersonID,UserTypeID,UserName,[Password],isnull(IsActive,1) from @UserP where Operation = 'U'

	exec [dbo].[UTP_UpdateUser] @User, @ROWS output

	-- deactivate User upon delete
	update u
		SET Isactive = 0
		from @UserP tin inner join UTP_User u on tin.UserID = u.UserID
		where Operation = 'D'

	insert into @Person (PersonID,PersonTypeID,FirstName,LastName,Description,PhoneEmailID,BusinessName)
		select PersonID,PersonTypeID,FirstName,LastName,Description,PhoneEmailID,BusinessName from @UserP
	exec [dbo].[UTP_UpdatePerson] @Person, @ROWSAFFECTED output
	select @ROWS = @ROWS + @ROWSAFFECTED

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @ROWS


;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXWO;
GO

-- ===========================================================
-- Author: JRP 
-- Create date: Apr 26, 2016
-- Description:
--     Update proc from table vw_UTP_WO
--     Update replacing all values in the row including NULL
-- Revisions:
--		6-Oct-2016	JRP	Save UtilityComment to EGD_WO and UTP_WONotes
--		16-Oct-2016	JRP	WAMS_CREWID was improperly set
--		19-Feb-2016	IsEAOK should only trigger one Worklog entry
-- ===========================================================
CREATE PROC [dbo].[UTP_UpdateXWO]
	@vw_UTP_WO [dbo].[vw_UTP_WOType] READONLY,@UserID [int], @ROWS [int] = NULL output, @NewID int = NULL output
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@Username varchar(255),
			@IsEAOK bit,
			@WOID int,
			@OrderID int,
			@FitterID int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select	@ProcedureName = 'UTP_UpdateXWO IN: Operation=' + isnull(Operation,'null')
							+ ', APEQType=' + isnull(APEQType,'null')
							+ ', AppointmentID=' + isnull(cast(tin.AppointmentID as varchar(8)),'null')
							+ ', IsFirmAppt=' + isnull(cast(tin.IsFirmAppt as varchar(8)),'null')
							+ ', IsEAOK=' + isnull(cast(tin.IsEAOK as varchar(8)),'null')
							+ ', TechnicianID=' + isnull(cast(tin.TechnicianID as varchar(8)),'null')
							+ ', ApptStartDate=' + isnull(cast(tin.ApptStartDate as varchar(25)),'null'),
					
			@Identifier = cast(tin.OrderID as varchar(8)),
			@IsEAOK = case when tin.IsEAOK = 1 and isnull(two.IsEAOK,0) = 0 then 1 else 0 end,
			@WOID = WOID,
			@OrderID = tin.OrderID,
			@FitterID = tin.TechnicianID
		from  @vw_UTP_WO tin left join UTP_Appointment two on two.AppointmentID = tin.AppointmentID  
	
	select @Username = Username from UTP_User where UserID = @UserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	set nocount on

	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @vw_UTP_WO) < 1  RETURN 0
 
	DECLARE @SubmitBy varchar(50)
	IF @UserID IS NULL OR @UserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @UserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@UserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @UserID provided',2
	END

	declare @new [vw_UTP_WOType]
	insert into @new
	 (
		[WOID],
		[WONUM],
		[JobCodeID],
		[JobCode],
		[WorkType],
		[Subtype],
		[JobPlan],
		[GroupID],
		[GroupName],
		[GridID],
		[Grid],
		[ApptStartDate],
		[DueDate],
		[WMStatusID],
		[DispatcherID],
		[Dispatcher],
		[TechnicianID],
		[Technician],
		[ActualFinish],
		[CompletionCode],
		[AppointmentID],
		[AppointmentStatusID],
		[AppointmentStatus],
		[AppointmentTypeID],
		[AppointmentType],
		[TimeslotID],
		[ApptEndDate],
		[APEQTYPE],
		[UtilityComment]
	)
	SELECT
		WOID,
		WONUM,
		JobCodeID,
		JobCode,
		WorkType,
		Subtype,
		JobPlan,
		GroupID,
		GroupName,
		GridID,
		Grid,
		ApptStartDate,
		DueDate,
		WMStatusID,
		DispatcherID,
		Dispatcher,
		TechnicianID,
		Technician,
		ActualFinish,
		CompletionCode,
		AppointmentID,
		AppointmentStatusID,
		AppointmentStatus,
		AppointmentTypeID,
		AppointmentType,
		TimeslotID,
		ApptEndDate,
		APEQTYPE,
		UtilityComment

	FROM @vw_UTP_WO as ta where ta.Operation = 'A'
--	EXEC [dbo].[UTP_Createvw_WO] @new,@NewID output

--	DELETE does not check whether this record is referenced as a foreign key
--	DELETE FROM vw_UTP_WO WHERE OrderID IN (SELECT OrderID FROM @vw_UTP_WO as td WHERE td.Operation = 'D')
-- need special coding

	UPDATE two
	SET	[ActualStart] = tin.[ActualStart],
		[ActualFinish] = tin.[ActualFinish];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXWOCustomer') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXWOCustomer;
GO

CREATE PROC [dbo].[UTP_UpdateXWOCustomer]
	@Customer vw_UTP_WOCustomerType READONLY,
	@CurrentUserID int = NULL,

	@ROWS int = NULL OUTPUT
as

	DECLARE @ContactID int 
	SELECT TOP 1 @ContactID = ContactID 
		FROM @Customer tin inner join UTP_Contact two on tin.OrderID = two.OrderID
		WHERE ContactTypeID = 1803
		ORDER BY ContactID desc

	IF @ContactID is NOT NULL
		UPDATE two
			SET	ContactName = tin.ContactName,
				ContactEmail = tin.ContactEmail,
				ContactPhone = tin.ContactPhone,
				ContactAlternatePhone = tin.ContactAlternatePhone
			FROM @Customer tin inner join UTP_Contact two on tin.OrderID = two.OrderID
			WHERE ContactID = @ContactID
	ELSE
		INSERT UTP_Contact (OrderID,ContactName,ContactPhone,ContactAlternatePhone,ContactEmail)
			SELECT TOP 1 OrderID,ContactName,ContactPhone,ContactAlternatePhone,ContactEmail FROM @Customer




;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXWORelightInfo') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXWORelightInfo;
GO

CREATE PROC [dbo].[UTP_UpdateXWORelightInfo]
	@Relight vw_UTP_WORelightType READONLY,
	@CurrentUserID int = NULL,

	@ROWS int = NULL OUTPUT
as

	UPDATE two
		SET	TechnicianID = tin.DayTimeTechnicianID
		FROM @Relight tin inner join UTP_WO two on tin.OrderID = two.OrderID



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXWORemark') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXWORemark;
GO

-- =============================================
-- Author:		John Peacock
-- Description:	
--	27-Feb-2017	JRP Add SQL REPORTEXCL to EGD Worklog
-- =============================================
CREATE PROCEDURE [dbo].[UTP_UpdateXWORemark]
	@Remark [dbo].UTP_WORemarkType READONLY,
	@CurrentUserID int = null,

	@ROWS int output
AS
	BEGIN
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select @ProcedureName = 'UTP_UpdateXWORemark:'
				+ ' @MemoTypeID=' + isnull(cast(MemoTypeID as varchar(10)),'null'),
				 @Identifier = cast(OrderID as varchar(20))
		from @Remark
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @Remark) < 1  RETURN 0
	
	INSERT UTP_OrderHistory (OrderID, MemoTypeID, Memo, CreatedByID, CreatedTimestamp, TechnicianID)
		SELECT	r.OrderID,
				MemoTypeID = isnull(r.MemoTypeID, dbo.fnUTP_GetListMaster('MemoType','2')),
				Memo = r.Memo,
				CreatedById = isnull(r.CreatedById,@CurrentUserID),
				CreatedTimestamp = isnull(r.CreatedTimestamp,getdate()),
				TechnicianID = isnull(r.TechnicianID,wo.TechnicianID)

		FROM @Remark r inner join vw_UTP_WO wo on r.OrderID = wo.OrderID
		WHERE r.Operation = 'A'

	DECLARE @EGDCount int = 0, @woid int, @CompileCount int = 0
	DECLARE @InsertIDTable TABLE (ID int);

	DELETE oh 
		FROM UTP_OrderHistory oh 
			INNER JOIN @Remark r on oh.OrderHistoryID = r.OrderHistoryID
		WHERE Operation = 'D' 
			AND oh.MemoTypeID = 1002 -- Field Remarks, only

	UPDATE oh 
		SET	
			MemoTypeID = coalesce(r.MemoTypeID,oh.MemoTypeID,dbo.fnUTP_GetListMaster('MemoType','2')),
			Memo = isnull(r.Memo,oh.Memo),
			CreatedById = isnull(r.CreatedById,oh.CreatedById),
			CreatedTimestamp = isnull(r.CreatedTimestamp,oh.CreatedTimestamp),
			TechnicianID = isnull(r.TechnicianID,oh.TechnicianID)

		FROM UTP_OrderHistory oh 
			INNER JOIN @Remark r on oh.OrderHistoryID = r.OrderHistoryID
		WHERE Operation = 'U' 

	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel
	END
;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UpdateXWorkSchedule') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UpdateXWorkSchedule;
GO


/*
select * from UTP_User
select * from UTP_WorkSchedule where WorkDate = '6/2/2016'
declare 	@vw_UTP_WorkSchedule [vw_UTP_WorkScheduleType],
	@CurrentUserID [int] = null,
	@ROWS [int] = NULL, 
	@NewID int = NULL
insert @vw_UTP_WorkSchedule (ScheduleTypeID, GroupID, UserID, WorkDate, TimeslotID, Capacity, Booked, Operation)
	select 90350, 1, 4, '3/4/2017', 90301, 5, 0, 'A'
exec [UTP_UpdateXWorkSchedule] @vw_UTP_WorkSchedule, 1, @ROWS output, @NewID output
select top 100 * from vw_UTP_WorkSchedule order by WorkScheduleID desc
*/
-- ===========================================================
-- Author: John Peacock
-- Create date: May 2, 2016
-- Description:
--     Update proc from table vw_UTP_WorkSchedule
--     Update replacing all values in the row including NULL
--	   Project, TimeOff and Training calendars are deemed mutually exclusive for a UserID
-- Revisions:
--		20-May-2016	JP	Add parameter CurrentUserID
-- 4-Mar-2017	JP	LPGS-265 Time-off (vacation, sick, personal appts)
-- ===========================================================
CREATE PROCEDURE [dbo].[UTP_UpdateXWorkSchedule]
	@vw_UTP_WorkSchedule [dbo].[vw_UTP_WorkScheduleType] READONLY,
	@CurrentUserID [int] = null,
	@ROWS [int] = NULL output, 
	@NewID int = NULL output
AS
begin
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int,
			@Username varchar(255)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select top 1 @ProcedureName = 'UTP_UpdateXWorkSchedule TimeslotID=' + isnull(convert(varchar(6), TimeslotID),'null')
								+ ', ScheduleTypeID=' + isnull(convert(varchar(6), ScheduleTypeID),'null'),
				@Identifier =  Groupname
		from @vw_UTP_WorkSchedule

	select @Username = Username from UTP_User where UserID = @CurrentUserID
	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier, @Username

	set nocount on

	SELECT @ROWS = 0
	IF (SELECT COUNT(*) from @vw_UTP_WorkSchedule) < 1  RETURN 0
 
	declare @new [vw_UTP_WorkScheduleType]
	insert into @new
	 (
		[ScheduleTypeID],
		[ScheduleType],
		[UserID],
		[Username],
		[DisplayName],
		[WorkDate],
		[TimeSlotID],
		[Timeslot],
		[Capacity],
		[GroupID],
		[Groupname],
		[TimeOffReasonID],
		[TimeoffReason],
		[Operation]

	)
	SELECT DISTINCT
		ta.ScheduleTypeID, -- = case ta.TimeSlotID when 90307 then 90353 else 90350 end,
		ta.ScheduleType,
		ta.UserID,
		Username,
		DisplayName,
		ta.WorkDate,
		ta.TimeSlotID,
		Timeslot,
		ta.Capacity,
		ta.GroupID,
		Groupname,
		TimeOffReasonID = case when ta.ScheduleTypeID = 90356 then ta.TimeOffReasonID else null end,
		ta.TimeoffReason,
		Operation

	FROM @vw_UTP_WorkSchedule as ta 
		LEFT JOIN UTP_WorkSchedule ws 
			on ta.UserID = ws.UserID 
			and ta.GroupID = ws.GroupID 
			and ta.WorkDate = ws.WorkDate 
			and (ta.TimeslotID = ws.TimeslotID or ta.TimeSlotID = 90306 or ws.TimeslotID = 90306)
			--and ta.ScheduleTypeID = isnull(ws.ScheduleTypeID,ta.ScheduleTypeID) -- leave out for mutually exclusive
	WHERE ta.Operation = 'A'
		and ws.WorkScheduleID is null -- do not create duplicates

	EXEC [dbo].[UTP_Createvw_WorkSchedule] @new,@NewID output

--	DELETE does not check whether this record has booked appts
	DELETE FROM UTP_WorkSchedule WHERE WorkScheduleID IN (SELECT WorkScheduleID FROM @vw_UTP_WorkSchedule as td WHERE td.Operation = 'D')

	UPDATE two
		SET
			two.[Capacity] = tin.[Capacity],
			two.[TimeOffReasonID] = case when tin.ScheduleTypeID = 90356 then tin.TimeOffReasonID else null end

		FROM @vw_UTP_WorkSchedule as tin 
			INNER JOIN UTP_WorkSchedule two 
				on tin.UserID = two.UserID 
				and tin.GroupID = two.GroupID 
	;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_UploadDocument') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_UploadDocument;
GO
-- DROP PROC [dbo].[UTP_UploadDocument]
-- ====================================================================================
-- Author: Ian MacIntyre
-- Create date: May 25, 2016
-- Description: Called when creating a new Document in Document Storage
-- Revisions: 
-- ====================================================================================
CREATE PROC [dbo].[UTP_UploadDocument]
	@DocumentStorageID [int],
	@OriginalFilename [varchar](255) = NULL,
	@Filetype [varchar](32),
	@OrderID [int] = NULL,
	@CurrentUser [varchar](255),
	@Filesize int,
	@Success [bit] OUTPUT,
	@DocumentIDOut [int] OUTPUT,
	@FullPath [varchar](1024) OUTPUT
AS
	DECLARE @Loc varchar(255) = 'UTP_UploadDocument'
	DECLARE @CurrentUserID int, @Failure bit = 0, @RootPath varchar(255), @FilenameOut varchar(255)
	DECLARE @FileSuffix varchar(33)
	DECLARE @Errors UTP_ErrorType
	SET @Success=0

	SELECT @CurrentUserID=[UserID] FROM [dbo].[UTP_User] WHERE [Username] = @CurrentUser AND [IsActive] = 1
	IF @CurrentUserID IS NULL
		BEGIN
			INSERT INTO @Errors ([Code],[Level],[Message],[Location],[Param],[ParamValue])
			VALUES ('100',5,'Unknown User',@Loc,'@CurrentUser',@CurrentUser)
		END
	SELECT
		@RootPath=RTRIM([RootFolder]) + (CASE WHEN RIGHT(RTRIM([RootFolder]),1) = '\' THEN '' ELSE '\' END)
		FROM [dbo].[UTP_DocumentStorage] WHERE [DocumentStorageID]=@DocumentStorageID
	IF @RootPath IS NULL
		BEGIN
			INSERT INTO @Errors ([Code],[Level],[Message],[Location],[Param],[ParamValue])
			VALUES ('1',0,'Invalid DocumentStorageID',@Loc,'@DocumentStorageID',CAST(@DocumentStorageID AS varchar(255)))
			SET @Failure=1			
		END
	IF @OrderID IS NOT NULL
		BEGIN
			IF (SELECT COUNT(*) FROM [dbo].[UTP_Order] WHERE [OrderID]=@OrderID) <> 1
				BEGIN
					INSERT INTO @Errors ([Code],[Level],[Message],[Location],[Param],[ParamValue])
					VALUES ('2',0,'Invalid OrderID',@Loc,'@OrderID',CAST(@OrderID AS varchar(255)))
					SET @Failure=1			
				END
		END

	IF @Failure = 0
		BEGIN
			EXEC [dbo].[UTP_NewOrderAttachment] @DocumentStorageID, @OriginalFilename, @Filetype, @OrderID, @CurrentUserID,
				@Filesize, @DocumentIDOut OUTPUT, @FilenameOut OUTPUT
			IF @DocumentIDOut IS NULL
				BEGIN
					INSERT INTO @Errors ([Code],[Level],[Message],[Location],[Param],[ParamValue])
					VALUES ('3',0,'Unable to create New Order Attachment',@Loc,NULL,NULL)
					SET @Failure=1			
				END
			ELSE
				BEGIN
					IF @Filetype IS NULL SET @FileSuffix=''
					ELSE SELECT @FileSuffix=@Filetype
					SELECT @FullPath=@RootPath + @FilenameOut + @FileSuffix
				END
		END

	DECLARE @rv int
	SELECT [Code],[Level],[Message],[Location],[Param],[ParamValue] FROM @Errors
	IF @Failure = 0
		BEGIN
			SET @Success=1
			SET @rv=1
		END
	ELSE
		BEGIN
			SET @Success=0
			SET @rv=0
		END
	RETURN @rv



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ValidateUser') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ValidateUser;
GO

/*
select * from UTP_User
declare @UserID int
exec UTP_ValidateUser ''User1'','''', @UserID out
print @UserID
*/
CREATE PROC [dbo].[UTP_ValidateUser]
	@Username varchar(50),
	@Password varchar(50),

	@UserID int output
AS
	set @UserID = 0
	IF exists (select Username from UTP_User where Username = @Username and Password = @Password)
		begin
		select @UserID = UserID from UTP_User where Username = @Username 
	
		exec UTP_UpdateUserSession 'Logon', @UserID
		end

	return @UserID



;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UTP_ValidateWO') AND type in (N'P', N'PC')) DROP PROCEDURE UTP_ValidateWO;
GO
-- ===========================================================
-- Created:	17-Oct-2016	John Peacock
-- Description: validate WO data prior to submission
-- exec UTP_ValidateWO 1, null
-- Revisions:
--		28-Oct	JRP		Handle no specs case
--		02-Nov	IDM		Support type=RAISE and RC Raises on COMPLETE
-- ===========================================================
CREATE proc [dbo].[UTP_ValidateWO]
	@OrderID int,
	@Type varchar(20) = null, -- 'Submit'

	@Result int output
as
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	set @ProcedureName = 'UTP_ValidateWO'
						+ ' @Type=' + isnull(@Type,'null')
	set @Identifier = cast(@OrderID as varchar(20))

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on
	set @Result = 1 -- SUCCESS
	
	declare @OrgShortName varchar(50) = '',
			@ErrorMessage varchar(max) = ''
	
	select @OrgShortName = org.ShortName from UTP_Order o with(nolock)
		JOIN UTP_Org org with(nolock) ON o.OrgID=org.OrgID
		where o.OrderID = @OrderID

	select ErrorMessage = @ErrorMessage

	set @ProcedureName = @ProcedureName + ' @Result=' + cast(@Result as varchar(10))
	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @Result

;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'WorkOrder_SubmitAction') AND type in (N'P', N'PC')) DROP PROCEDURE WorkOrder_SubmitAction;
GO
-- Revisions:
--	28-Nov-2016	JRP	Add compiling EGD REMARKDESC to ensure all Field Remarks are sent
CREATE PROC [dbo].[WorkOrder_SubmitAction]
	@Action varchar(20),
	@OrderID int,
	@Priority int = NULL,
	@NewKey int output,
	@CurrentUserID int
AS
	declare @TracelogID int,
			@Version int,
			@LogLevel int,
			@ProcedureName varchar(255),
			@Identifier varchar(255),
			@i int,
			@OrgShortName varchar(50)

	set @Version = 1	-- increment with each major change
	set @LogLevel = 1	-- 1=CallTrace, 2=Trace, 3=Debug, 4=Config, 5=Info, 6=Warning, 7=Exception. 
						-- SIT & UAT logging threshold usually =1, PROD usually =5 (see TransactionLogDB.dbo.TracelLog_Insert)
	select	@ProcedureName = 'WorkOrder_SubmitAction'
				+ ': Action=' + isnull(@Action,'null'),
			@Identifier = cast(OrderID as varchar(8)),
			@OrgShortName = OrgShortName
		from vw_UTP_WO 
		where OrderID = @OrderID

	EXEC @TracelogID = TraceLog_EnterProcedure @ProcedureName, @Version, @LogLevel, @Identifier

	set nocount on

	DECLARE @MemoStatusID int=[dbo].[fnUTP_GetListMaster]('MemoType','7')
	IF @CurrentUserID IS NULL SELECT @CurrentUserID=[dbo].[fnUTP_CurrentDomainUserID]()
	DECLARE @CompCode varchar(30)

	DECLARE @SubmitBy varchar(50)
	IF @CurrentUserID IS NULL OR @CurrentUserID IN (1,2,3)
	BEGIN;
		THROW 60000,'A valid UTOPIS4 @CurrentUserID must be provide',1
	END
	SELECT @SubmitBy=CAST(('utopis:' + Username) as varchar(50)) FROM UTP_User where UserID=@CurrentUserID
	IF @SubmitBy IS NULL
	BEGIN;
		THROW 60001,'Unknown @CurrentUserID provided',2
	END

	declare @rv int=0
	IF @OrgShortName <> 'EGD'
	BEGIN
		UPDATE w 
			SET WMStatusID = [dbo].[fnUTP_GetListMaster]('WMStatus','WCOMP'),
				ActualFinish = v.ActualFinish,
				ActualStart = v.ActualStart,
				CompletionCode = v.CompletionCode
			FROM UTP_WO w inner join vw_UTP_WO v on w.OrderID = v.OrderID
			WHERE w.OrderId = @OrderID

		SELECT @CompCode=CompletionCode FROM vw_UTP_WO with(nolock) WHERE [OrderID]=@OrderID
		INSERT INTO [dbo].[UTP_OrderHistory] ([OrderID], [MemoTypeID],[CreatedByID],[CreatedTimestamp],[Memo])
			VALUES (@OrderID, @MemoStatusID,@CurrentUserID, GETDATE(),'SubmitWO : WOSTATUS=WCOMP COMPCODE=' + @CompCode)
	END
	EXEC TraceLog_ExitProcedure @ProcedureName, @TracelogID, @LogLevel

	RETURN @rv

;
GO
