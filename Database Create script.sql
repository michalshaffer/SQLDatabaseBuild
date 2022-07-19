/****** The following is the full database build script for the DREAMEFV database ******/

USE [master]
GO
/****** Object:  Database [dreamLocal]    Script Date: 5/16/2020 3:04:45 PM ******/
CREATE DATABASE [dreamLocal]
 CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'dreamLocal', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dreamLocal.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON
( NAME = N'dreamLocal_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dreamLocal_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dreamLocal] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dreamLocal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dreamLocal] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [dreamLocal] SET ANSI_NULLS OFF
GO
ALTER DATABASE [dreamLocal] SET ANSI_PADDING OFF
GO
ALTER DATABASE [dreamLocal] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [dreamLocal] SET ARITHABORT OFF
GO
ALTER DATABASE [dreamLocal] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [dreamLocal] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [dreamLocal] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [dreamLocal] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [dreamLocal] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [dreamLocal] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [dreamLocal] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [dreamLocal] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [dreamLocal] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [dreamLocal] SET  DISABLE_BROKER
GO
ALTER DATABASE [dreamLocal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [dreamLocal] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [dreamLocal] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [dreamLocal] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [dreamLocal] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [dreamLocal] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [dreamLocal] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [dreamLocal] SET RECOVERY SIMPLE
GO
ALTER DATABASE [dreamLocal] SET  MULTI_USER
GO
ALTER DATABASE [dreamLocal] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [dreamLocal] SET DB_CHAINING OFF
GO
ALTER DATABASE [dreamLocal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
GO
ALTER DATABASE [dreamLocal] SET TARGET_RECOVERY_TIME = 0 SECONDS
GO
ALTER DATABASE [dreamLocal] SET DELAYED_DURABILITY = DISABLED
GO
EXEC sys.sp_db_vardecimal_storage_format N'dreamLocal', N'ON'
GO
ALTER DATABASE [dreamLocal] SET QUERY_STORE = OFF
GO
USE [dreamLocal]
GO
/****** Object:  Schema [enroll]    Script Date: 5/16/2020 3:04:46 PM ******/
CREATE SCHEMA [enroll]
GO
/****** Object:  Schema [fund]    Script Date: 5/16/2020 3:04:46 PM ******/
CREATE SCHEMA [fund]
GO
/****** Object:  Schema [volunteer]    Script Date: 5/16/2020 3:04:46 PM ******/
CREATE SCHEMA [volunteer]
GO
USE [dreamLocal]
GO
/****** Object:  Sequence [dbo].[SeqAccountIds]    Script Date: 5/16/2020 3:04:46 PM ******/
CREATE SEQUENCE [dbo].[SeqAccountIds]
 AS [int]
 START WITH 1000001
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE
GO
USE [dreamLocal]
GO
/****** Object:  Sequence [dbo].[SeqCampaignIds]    Script Date: 5/16/2020 3:04:46 PM ******/
CREATE SEQUENCE [dbo].[SeqCampaignIds]
 AS [int]
 START WITH 1000001
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE
GO
USE [dreamLocal]
GO
/****** Object:  Sequence [dbo].[SeqContactIds]    Script Date: 5/16/2020 3:04:46 PM ******/
CREATE SEQUENCE [dbo].[SeqContactIds]
 AS [int]
 START WITH 1000001
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE
GO
/****** Object:  UserDefinedFunction [dbo].[fnCheckContactExists]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE FUNCTION [dbo].[fnCheckContactExists] (@contactid varchar(9))

 RETURNS BIT
 AS
 BEGIN
     IF EXISTS (SELECT * FROM dbo.Contact WHERE ID = @contactid)
         return 1
     return 0
 END

GO
/****** Object:  UserDefinedFunction [dbo].[fnCheckTypeStatus]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE FUNCTION [dbo].[fnCheckTypeStatus] (@field varchar(20), @table_id int, @isType bit)

 RETURNS VARCHAR(5)
 AS
 BEGIN
     IF EXISTS (SELECT * FROM dbo.TypeStatus WHERE ForTableId = @table_id AND isType = @isType and value = @field )
         return 'True'
     return 'False'
 END

GO
/****** Object:  Table [dbo].[Contact]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [varchar](9) NOT NULL,
	[Title] [varchar](10) NULL,
	[FirstName] [varchar](30) NULL,
	[LastName] [varchar](30) NULL,
	[MiddleName] [varchar](30) NULL,
	[Suffix] [varchar](10) NULL,
	[Email] [varchar](30) NULL,
	[Email2] [varchar](30) NULL,
	[WorkPhone] [varchar](20) NULL,
	[HomePhone] [varchar](20) NULL,
	[CellPhone] [varchar](20) NULL,
	[Fax] [varchar](20) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
	[FullName]  AS (Trim(concat(coalesce([title],''),' ',[firstName],' ',Trim(concat(coalesce([middlename],''),' ',[lastName],' ')),concat(' ',coalesce([suffix],''))))),
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_LastEmail] UNIQUE NONCLUSTERED
(
	[LastName] ASC,
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [varchar](9) NOT NULL,
	[AccountName] [varchar](100) NULL,
	[Type] [nvarchar](20) NOT NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [enroll].[Course]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [enroll].[Course](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AcademicInstitutionId] [varchar](9) NULL,
	[CourseName] [varchar](30) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [enroll].[Term]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [enroll].[Term](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TermName] [varchar](10) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [enroll].[Section]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [enroll].[Section](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NULL,
	[TermId] [int] NULL,
	[InstructorId] [varchar](9) NULL,
	[ScDays] [varchar](10) NULL,
	[ScTime] [time](7) NULL,
	[ScMins] [int] NULL,
	[MaxStudents] [int] NULL,
	[Status] [varchar](20) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [enroll].[vw_CourseSections]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [enroll].[vw_CourseSections]
AS

select ac.id as AcademicInstitutionId, ac.AccountName as AcademicInstitutionName, CourseName, TermName as Term, ScDays as Schedule, ScTime as StartTime, cast(scmins as varchar) + ' minutes' as Duration, MaxStudents, s.Status, co.fullname as InstructorName
from enroll.course c
left join enroll.section s on s.courseid = c.id
--left join enroll.SectionEnrollment se on se.SectionId = s.id
left join account ac on ac.id = c.AcademicInstitutionId
left join enroll.term t on t.id = termid
left join contact co on co.id = InstructorId
GO
/****** Object:  Table [enroll].[Grade]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [enroll].[Grade](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [varchar](9) NULL,
	[GradeName] [varchar](30) NULL,
	[TermId] [int] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [enroll].[SectionEnrollment]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [enroll].[SectionEnrollment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [varchar](9) NULL,
	[SectionId] [int] NULL,
	[Grade] [varchar](10) NULL,
	[Status] [nvarchar](20) NOT NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [enroll].[vw_StudentEnrollments]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [enroll].[vw_StudentEnrollments]
AS

select con.FullName as StudentName, g.GradeName, SectionId, se.Status, ac.id as AcademicInstitutionId, ac.AccountName as AcademicInstitutionName
from enroll.SectionEnrollment se
join enroll.Section s on s.id = se.SectionId
join enroll.Course c on c.id = s.CourseId
join contact con on con.id = StudentId
join Account ac on ac.id = AcademicInstitutionId
join enroll.Grade g on g.StudentId = con.Id
where g.isActive = 1
GO
/****** Object:  Table [fund].[Opportunity]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fund].[Opportunity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [varchar](9) NULL,
	[ContactId] [varchar](9) NULL,
	[RecDonation] [bit] NULL,
	[RecDonationId] [int] NULL,
	[RecDonationInstal] [int] NULL,
	[Status] [nvarchar](20) NOT NULL,
	[ReqAmount] [decimal](18, 2) NULL,
	[WonAmount] [decimal](18, 2) NULL,
	[DateExpected] [datetime] NULL,
	[DateClosed] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
	[Name] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Campaign]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaign](
	[Id] [varchar](9) NOT NULL,
	[Name] [varchar](100) NULL,
	[Type] [nvarchar](20) NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Status] [nvarchar](20) NOT NULL,
	[isActive] [bit] NULL,
	[AccountId] [varchar](9) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [fund].[Payment]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fund].[Payment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OpportunityId] [int] NULL,
	[Type] [nvarchar](20) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
	[Paid] [bit] NULL,
	[AmountReceived] [decimal](18, 2) NULL,
	[WrittenOff] [bit] NULL,
	[Notes] [varchar](max) NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [fund].[vw_Opportunities]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [fund].[vw_Opportunities]
AS

select CampaignId, camp.Name as CampaignName, c.Id as ContactId, c.FullName as ContactName, o.status as OpportunityStatus, ReqAmount, WonAmount, DateExpected, DateClosed,
(select count (*) from fund.Payment p where p.OpportunityId = o.id and p.Status <> 'Void') as NumPayments
from fund.Opportunity o
join Campaign camp on camp.id = o.CampaignId
join contact c on c.id = o.ContactId

GO
/****** Object:  Table [volunteer].[Hour]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [volunteer].[Hour](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [varchar](9) NULL,
	[ShiftId] [int] NULL,
	[CheckInDate] [datetime] NULL,
	[CheckOutDate] [datetime] NULL,
	[Status] [nvarchar](20) NOT NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [volunteer].[Job]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [volunteer].[Job](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [varchar](9) NULL,
	[Name] [varchar](100) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [volunteer].[Shift]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [volunteer].[Shift](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[VolunteersNeeded] [int] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_CampaignWithRollup]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create VIEW [dbo].[vw_CampaignWithRollup]
AS
SELECT ca.id as CampaignId, ca.Name as CampaignName, ca.AccountId as AccountId, ca.Status as Status,
(select count(id) from fund.Opportunity o where o.CampaignId = ca.Id and o.Status <> 'ClosedLost') as ActiveOpportunityCount
, (select sum(ReqAmount) from fund.Opportunity o where o.CampaignId = ca.Id and o.Status <> 'ClosedLost') as TotalRequestedAmount
, (select sum(WonAmount) from fund.Opportunity o where o.CampaignId = ca.Id and o.Status <> 'ClosedLost') as TotalWonAmount
, (select count(j.id) from volunteer.job j where j.CampaignId = ca.Id) as JobCount
, (select count(sh.id) from volunteer.shift sh where sh.jobid in (select id from volunteer.job j where j.CampaignId = ca.Id)) as ShiftCount
, (select count(h.id) from volunteer.hour h where h.ShiftId in (select id from volunteer.Shift sh where sh.JobId in ( select id from volunteer.job j where j.CampaignId = ca.Id)) and h.Status <> 'Cancelled') as TotalVolunteerSignUps

from Campaign ca
GO
/****** Object:  Table [dbo].[ContactType]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [varchar](9) NULL,
	[Type] [nvarchar](20) NOT NULL,
	[isActive] [bit] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Affiliation]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Affiliation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [varchar](9) NULL,
	[ContactId] [varchar](9) NULL,
	[Role] [varchar](30) NULL,
	[isActive] [bit] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
	[isPrimaryAffiliation] [bit] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Affiliation_Unq] UNIQUE NONCLUSTERED
(
	[AccountId] ASC,
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ContactWithAffiliations]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_ContactWithAffiliations]
AS
SELECT dbo.Contact.Id AS ContactId, dbo.Contact.FullName, dbo.Contact.Email, dbo.Contact.Email2, dbo.Contact.WorkPhone, dbo.Contact.HomePhone, dbo.Contact.CellPhone, dbo.Contact.Fax, dbo.Contact.DateCreated,
                    (STUFF((SELECT CAST(', ' + type AS VARCHAR(MAX))
         FROM ContactType ct
         WHERE (ct.ContactId = Contact.id and isActive = 1)
         FOR XML PATH ('')), 1, 2, '')) as ContactType  , dbo.Affiliation.Role, dbo.Account.AccountName, dbo.Account.Type AS AccountType
FROM     dbo.Contact INNER JOIN
                  dbo.Affiliation ON dbo.Contact.Id = dbo.Affiliation.ContactId INNER JOIN
                  dbo.Account ON dbo.Affiliation.AccountId = dbo.Account.Id
GO
/****** Object:  Table [dbo].[Address]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](20) NULL,
	[AddressCo] [varchar](100) NULL,
	[AddressLine_1] [varchar](100) NULL,
	[AddressLine_2] [varchar](100) NULL,
	[City] [varchar](20) NULL,
	[State] [varchar](20) NULL,
	[Zip] [int] NULL,
	[Country] [varchar](20) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AddressAffiliation]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressAffiliation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressId] [int] NULL,
	[AccountId] [varchar](9) NULL,
	[ContactId] [varchar](9) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ContactWithAddresses]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_ContactWithAddresses]
AS
SELECT dbo.Contact.Id AS ContactId, dbo.Contact.FullName, dbo.Contact.Email, dbo.Contact.Email2, dbo.Contact.WorkPhone, dbo.Contact.HomePhone, dbo.Contact.CellPhone, dbo.Contact.Fax, dbo.Contact.DateCreated,
                  (STUFF((SELECT CAST(', ' + type AS VARCHAR(MAX))
         FROM ContactType ct
         WHERE (ct.ContactId = Contact.id and isActive = 1)
         FOR XML PATH ('')), 1, 2, '')) as ContactType
                  , dbo.Address.Type AS [Address Type], dbo.Address.AddressCo, dbo.Address.AddressLine_1, dbo.Address.AddressLine_2, dbo.Address.City, dbo.Address.State, dbo.Address.Zip,
                  dbo.Address.Country
FROM     dbo.Contact INNER JOIN
                  dbo.AddressAffiliation ON dbo.Contact.Id = dbo.AddressAffiliation.ContactId INNER JOIN
                  dbo.Address ON dbo.AddressAffiliation.AddressId = dbo.Address.Id
GO
/****** Object:  Table [enroll].[Attendance]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [enroll].[Attendance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [varchar](9) NOT NULL,
	[SectionEnrollmentId] [int] NOT NULL,
	[AttendanceDate] [datetime] NULL,
	[ArrivedTime] [time](7) NULL,
	[LeftTime] [time](7) NULL,
	[isPresent] [bit] NULL,
	[isLate] [bit] NULL,
	[Note] [varchar](100) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ContactWithRollUps]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[vw_ContactWithRollUps]
AS
SELECT dbo.Contact.Id AS ContactId, dbo.Contact.FullName, dbo.Contact.Email,
                 (STUFF((SELECT CAST(', ' + type AS VARCHAR(MAX))
         FROM ContactType ct
         WHERE (ct.ContactId = Contact.id and isActive = 1)
         FOR XML PATH ('')), 1, 2, '')) as ContactType
                  , (select count(id) from dbo.AddressAffiliation adf where adf.ContactId = dbo.Contact.Id) as AddressCount
                  , (select count(id) from dbo.Affiliation af where af.ContactId = dbo.Contact.Id and af.isActive = 1) as AffiliationCount
                  , (select count(id) from fund.Opportunity where fund.Opportunity.contactId = dbo.contact.id and fund.opportunity.status not in ('Withdrawn','Closed Lost')) as OpportunityCount
                  , coalesce((select sum(wonamount) from fund.Opportunity where fund.Opportunity.contactId = dbo.contact.id),0) as OpportunityWonAmount
                  , coalesce((select sum(ReqAmount) from fund.Opportunity where fund.Opportunity.contactId = dbo.contact.id and fund.opportunity.status not in ('Withdrawn','Closed Lost')),0) as OpportunityRequestedAmount
                  , (select count(id) from [enroll].[SectionEnrollment] where [enroll].[SectionEnrollment].StudentId = dbo.contact.id) as CurrentEnrollmentCount
                  , (select count(id) from [volunteer].[Hour] where [volunteer].[Hour].contactId = dbo.contact.id and status = 'Interested') as VolunteerHoursInterested
                  , (select count(id) from [volunteer].[Hour] where [volunteer].[Hour].contactId = dbo.contact.id and status = 'Confirmed') as VolunteerHoursConfirmed
                  , (select count(id) from [volunteer].[Hour] where [volunteer].[Hour].contactId = dbo.contact.id and status = 'Completed') as VolunteerHoursCompleted
                  , (select count(id) from [volunteer].[Hour] where [volunteer].[Hour].contactId = dbo.contact.id) as VolunteerHoursTotal
                  , (select count(id) from enroll.[section] where enroll.section.instructorid = dbo.contact.id) as TotalSectionsTeaching
                  , (select count(id) from enroll.[section] where enroll.section.instructorid = dbo.contact.id) as TotalSectionsEnrolled
                  , (select count(id) from enroll.[SectionEnrollment] where enroll.[SectionEnrollment].StudentId = dbo.contact.id) as CurrentSectionsEnrolled
                  , (select count(id) from enroll.Attendance where enroll.Attendance.StudentId = dbo.contact.id and ispresent = 1) as TotalPresentAttendance
                  , (select count(id) from enroll.Attendance where enroll.Attendance.StudentId = dbo.contact.id and islate = 1) as TotalLateAttendance
                  , (select count(id) from enroll.Attendance where enroll.Attendance.StudentId = dbo.contact.id and ispresent = 0) as TotalAbsentAttendance
FROM     dbo.Contact
GO
/****** Object:  View [dbo].[vw_AccountWithContacts]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_AccountWithContacts]
AS
SELECT a.id as AccountId, AccountName, a.Type as AccountType,
c.id as ContactId, c.FullName, (STUFF((SELECT CAST(', ' + type AS VARCHAR(MAX))
         FROM ContactType ct
         WHERE (ct.ContactId = c.id and isActive = 1)
         FOR XML PATH ('')), 1, 2, '')) as ContactType
from account a left join Affiliation af on af.AccountId = a.id
join Contact c on c.id = af.ContactId

GO
/****** Object:  View [dbo].[vw_AccountWithAddresses]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[vw_AccountWithAddresses]
AS
SELECT a.id as AccountId, AccountName, a.Type as AccountType,
ad.Type as AddressType, ad.AddressCo, ad.AddressLine_1, ad.AddressLine_2, ad.City, ad.State, ad.Zip, ad.Country
from account a left join AddressAffiliation af on af.AccountId = a.Id
left join Address ad on ad.id = af.AddressId
GO
/****** Object:  View [dbo].[vw_AccountWithRollup]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[vw_AccountWithRollup]
AS
SELECT a.id as AccountId, AccountName, a.Type as AccountType,
(select count(id) from Affiliation af where af.AccountId = a.id and af.isActive = 1) as ContactCount
, (select count(id) from AddressAffiliation af  where af.AccountId = a.id) as AddressCount
, (select count(id) from Campaign ca  where ca.AccountId = a.id and ca.isActive = 1) as ActiveCampaignCount
, (select count(id) from Campaign ca  where ca.AccountId = a.id) as TotalCampaignCount

from account a
GO
/****** Object:  Table [volunteer].[Detail]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [volunteer].[Detail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [varchar](9) NULL,
	[SkillAvailId] [int] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [volunteer].[SkillAvail]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [volunteer].[SkillAvail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [volunteer].[vw_SkillsbyContact]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [volunteer].[vw_SkillsbyContact]
as

select c.id as ContactId, c.Email, coalesce(c.cellphone, c.WorkPhone, c.homephone) as Phone, c.FullName, sk.name as skill
from volunteer.detail d
join volunteer.SkillAvail sk on sk.id = d.SkillAvailId
join dbo.Contact c on c.id = d.ContactId
GO
/****** Object:  Table [dbo].[TypeStatus]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ForTableId] [int] NULL,
	[ForTableName] [varchar](30) NULL,
	[isType] [bit] NULL,
	[Value] [nvarchar](20) NOT NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [fund].[RecDonation]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fund].[RecDonation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [varchar](9) NULL,
	[ContactId] [varchar](9) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[InstalAmount] [decimal](18, 2) NULL,
	[InstalPeriod] [nvarchar](20) NOT NULL,
	[NumInstal] [int] NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [volunteer].[JobDetail]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [volunteer].[JobDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [int] NOT NULL,
	[SkillNeededId] [int] NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_MySeq]  DEFAULT (format(NEXT VALUE FOR [SeqAccountIds],'AC#')) FOR [Id]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Address] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[AddressAffiliation] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Affiliation] ADD  CONSTRAINT [DF_Affiliation_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Affiliation] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Affiliation] ADD  CONSTRAINT [DF_Affiliation_isPrimaryAffiliation]  DEFAULT ((0)) FOR [isPrimaryAffiliation]
GO
ALTER TABLE [dbo].[Campaign] ADD  CONSTRAINT [DF_Campaign_MySeq]  DEFAULT (format(NEXT VALUE FOR [SeqCampaignIds],'CA#')) FOR [Id]
GO
ALTER TABLE [dbo].[Campaign] ADD  DEFAULT ('Planning') FOR [Status]
GO
ALTER TABLE [dbo].[Campaign] ADD  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[Campaign] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Contact] ADD  CONSTRAINT [DF_Contacts_MySeq]  DEFAULT (format(NEXT VALUE FOR [SeqContactIds],'CO#')) FOR [Id]
GO
ALTER TABLE [dbo].[Contact] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ContactType] ADD  CONSTRAINT [DF_ContactType_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[ContactType] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[TypeStatus] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [enroll].[Attendance] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [enroll].[Course] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [enroll].[Grade] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [enroll].[Grade] ADD  CONSTRAINT [DF_Grade_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [enroll].[Section] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [enroll].[SectionEnrollment] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [enroll].[Term] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [fund].[Opportunity] ADD  DEFAULT ((0)) FOR [RecDonation]
GO
ALTER TABLE [fund].[Opportunity] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [fund].[Payment] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [fund].[Payment] ADD  CONSTRAINT [DF_Payment_WrittenOff]  DEFAULT ((0)) FOR [WrittenOff]
GO
ALTER TABLE [fund].[RecDonation] ADD  DEFAULT (getdate()) FOR [StartDate]
GO
ALTER TABLE [fund].[RecDonation] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [volunteer].[Detail] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [volunteer].[Hour] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [volunteer].[Job] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [volunteer].[JobDetail] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [volunteer].[Shift] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [volunteer].[SkillAvail] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[AddressAffiliation]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[AddressAffiliation]  WITH CHECK ADD FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[AddressAffiliation]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[Affiliation]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Affiliation]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[Campaign]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Campaign]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[ContactType]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [enroll].[Attendance]  WITH CHECK ADD FOREIGN KEY([SectionEnrollmentId])
REFERENCES [enroll].[SectionEnrollment] ([Id])
GO
ALTER TABLE [enroll].[Attendance]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [enroll].[Course]  WITH CHECK ADD FOREIGN KEY([AcademicInstitutionId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [enroll].[Grade]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [enroll].[Grade]  WITH CHECK ADD FOREIGN KEY([TermId])
REFERENCES [enroll].[Term] ([Id])
GO
ALTER TABLE [enroll].[Section]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [enroll].[Course] ([Id])
GO
ALTER TABLE [enroll].[Section]  WITH CHECK ADD FOREIGN KEY([InstructorId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [enroll].[Section]  WITH CHECK ADD FOREIGN KEY([TermId])
REFERENCES [enroll].[Term] ([Id])
GO
ALTER TABLE [enroll].[SectionEnrollment]  WITH CHECK ADD FOREIGN KEY([SectionId])
REFERENCES [enroll].[Section] ([Id])
GO
ALTER TABLE [enroll].[SectionEnrollment]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [fund].[Opportunity]  WITH CHECK ADD FOREIGN KEY([CampaignId])
REFERENCES [dbo].[Campaign] ([Id])
GO
ALTER TABLE [fund].[Opportunity]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [fund].[Opportunity]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [fund].[Opportunity]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [fund].[Opportunity]  WITH CHECK ADD FOREIGN KEY([RecDonationId])
REFERENCES [fund].[RecDonation] ([Id])
GO
ALTER TABLE [fund].[Payment]  WITH CHECK ADD FOREIGN KEY([OpportunityId])
REFERENCES [fund].[Opportunity] ([Id])
GO
ALTER TABLE [fund].[RecDonation]  WITH CHECK ADD FOREIGN KEY([CampaignId])
REFERENCES [dbo].[Campaign] ([Id])
GO
ALTER TABLE [fund].[RecDonation]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [volunteer].[Detail]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [volunteer].[Detail]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [volunteer].[Detail]  WITH CHECK ADD FOREIGN KEY([SkillAvailId])
REFERENCES [volunteer].[SkillAvail] ([Id])
GO
ALTER TABLE [volunteer].[Hour]  WITH CHECK ADD FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [volunteer].[Hour]  WITH CHECK ADD FOREIGN KEY([ShiftId])
REFERENCES [volunteer].[Shift] ([Id])
GO
ALTER TABLE [volunteer].[Job]  WITH CHECK ADD FOREIGN KEY([CampaignId])
REFERENCES [dbo].[Campaign] ([Id])
GO
ALTER TABLE [volunteer].[JobDetail]  WITH CHECK ADD FOREIGN KEY([JobId])
REFERENCES [volunteer].[Job] ([Id])
GO
ALTER TABLE [volunteer].[JobDetail]  WITH CHECK ADD FOREIGN KEY([SkillNeededId])
REFERENCES [volunteer].[SkillAvail] ([Id])
GO
ALTER TABLE [volunteer].[Shift]  WITH CHECK ADD  CONSTRAINT [FK__Shift__JobId__2F9A1060] FOREIGN KEY([JobId])
REFERENCES [volunteer].[Job] ([Id])
GO
ALTER TABLE [volunteer].[Shift] CHECK CONSTRAINT [FK__Shift__JobId__2F9A1060]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [CK_Account_Type] CHECK  (([dbo].[fnCheckTypeStatus]([Type],(1),(1))='True'))
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [CK_Account_Type]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [CK_Address_Type] CHECK  (([dbo].[fnCheckTypeStatus]([Type],(9),(1))='True'))
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [CK_Address_Type]
GO
ALTER TABLE [dbo].[Campaign]  WITH CHECK ADD  CONSTRAINT [CK_Campaign_Status] CHECK  (([dbo].[fnCheckTypeStatus]([Status],(3),(0))='True'))
GO
ALTER TABLE [dbo].[Campaign] CHECK CONSTRAINT [CK_Campaign_Status]
GO
ALTER TABLE [dbo].[Campaign]  WITH CHECK ADD  CONSTRAINT [CK_Campaign_Type] CHECK  (([dbo].[fnCheckTypeStatus]([Type],(3),(1))='True'))
GO
ALTER TABLE [dbo].[Campaign] CHECK CONSTRAINT [CK_Campaign_Type]
GO
ALTER TABLE [dbo].[ContactType]  WITH CHECK ADD  CONSTRAINT [CK_Contact_Type] CHECK  (([dbo].[fnCheckTypeStatus]([Type],(2),(1))='True'))
GO
ALTER TABLE [dbo].[ContactType] CHECK CONSTRAINT [CK_Contact_Type]
GO
ALTER TABLE [enroll].[Section]  WITH CHECK ADD  CONSTRAINT [CK_Section_Status] CHECK  (([dbo].[fnCheckTypeStatus]([Status],(12),(0))='True'))
GO
ALTER TABLE [enroll].[Section] CHECK CONSTRAINT [CK_Section_Status]
GO
ALTER TABLE [enroll].[SectionEnrollment]  WITH CHECK ADD  CONSTRAINT [CK_SectionEnrollment_Status] CHECK  (([dbo].[fnCheckTypeStatus]([Status],(8),(0))='True'))
GO
ALTER TABLE [enroll].[SectionEnrollment] CHECK CONSTRAINT [CK_SectionEnrollment_Status]
GO
ALTER TABLE [fund].[Opportunity]  WITH CHECK ADD  CONSTRAINT [CK_Opportunity_Status] CHECK  (([dbo].[fnCheckTypeStatus]([Status],(10),(0))='True'))
GO
ALTER TABLE [fund].[Opportunity] CHECK CONSTRAINT [CK_Opportunity_Status]
GO
ALTER TABLE [fund].[Payment]  WITH CHECK ADD  CONSTRAINT [CK_Payment_Status] CHECK  (([dbo].[fnCheckTypeStatus]([Status],(7),(0))='True'))
GO
ALTER TABLE [fund].[Payment] CHECK CONSTRAINT [CK_Payment_Status]
GO
ALTER TABLE [fund].[Payment]  WITH CHECK ADD  CONSTRAINT [CK_Payment_Type] CHECK  (([dbo].[fnCheckTypeStatus]([Type],(7),(1))='True'))
GO
ALTER TABLE [fund].[Payment] CHECK CONSTRAINT [CK_Payment_Type]
GO
ALTER TABLE [fund].[RecDonation]  WITH CHECK ADD  CONSTRAINT [CK_RecDonation_InstalPeriod] CHECK  (([dbo].[fnCheckTypeStatus]([InstalPeriod],(6),(1))='True'))
GO
ALTER TABLE [fund].[RecDonation] CHECK CONSTRAINT [CK_RecDonation_InstalPeriod]
GO
ALTER TABLE [volunteer].[Hour]  WITH CHECK ADD  CONSTRAINT [CK_Hour_Status] CHECK  (([dbo].[fnCheckTypeStatus]([Status],(4),(0))='True'))
GO
ALTER TABLE [volunteer].[Hour] CHECK CONSTRAINT [CK_Hour_Status]
GO
/****** Object:  StoredProcedure [dbo].[SP_Create_Account]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [dbo].[SP_Create_Account]
  ( @accountname as varchar(100) = null
  , @type as varchar(20))
  --allows types Household, Academic Institution, Foundation, Program, Corporation

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;

  begin tran;
  declare @accountid varchar(9)
  declare @ids table (accountid varchar(9));

  Begin Try
	  --add account
    if exists (select id from account where AccountName = @accountname)
      RAISERROR ('Cannot create duplicate account.', 11, 1);

      Insert into Account (AccountName, Type)
		  output inserted.id into @ids (accountid)
		  values (@accountname, @type);

	  --set new accountid
	    set @accountid = (select accountid from @ids  where accountid is not null);

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Create_Address]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----Procedure to return errors
--CREATE PROCEDURE usp_GetErrorInfo
--AS
--SELECT
--    ERROR_NUMBER() AS ErrorNumber
--    ,ERROR_SEVERITY() AS ErrorSeverity
--    ,ERROR_STATE() AS ErrorState
--    ,ERROR_PROCEDURE() AS ErrorProcedure
--    ,ERROR_LINE() AS ErrorLine
--    ,ERROR_MESSAGE() AS ErrorMessage;
--GO

  CREATE Procedure [dbo].[SP_Create_Address]
  ( @accountid as varchar(9) = null
  , @contactid as varchar(9) = null
  , @type as varchar(20)
  , @addressCo as varchar(100)
  , @address1 as varchar(100)
  , @address2 as varchar(100)
  , @city as varchar(20)
  , @state as varchar(20)
  , @zip as int
  , @country as varchar(20))

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;
  declare @addressid int
  declare @ids table (addressid int, addressaffiliationid int);

  Begin Try
	  --add address

    --insert only if doesn't already exist
    if not exists (select id from dbo.Address where AddressLine_1 = @address1 and AddressLine_2 = @address2 and Zip = @zip)
      begin
        insert into dbo.Address (Type, AddressCo, AddressLine_1, AddressLine_2, City, State, Zip, Country)
        output inserted.id into @ids (addressid)
        values (@type, @addressCo, @address1, @address2, @city, @state, @zip, @country);

        set @addressid = (select addressid from @ids where addressid is not null);
      end
    ELSE --if exists, save address ID
      begin
        set @addressid = (select id from dbo.Address where AddressLine_1 = @address1 and AddressLine_2 = @address2 and Zip = @zip);
      end;

    --add address affiliation

    if exists (select id from AddressAffiliation where addressid = @addressid and AccountId = @accountid and contactid = @contactid)
      RAISERROR ('Cannot insert duplicate address affiliation.', 11, 1);

    insert into dbo.AddressAffiliation (AddressId, Accountid, ContactId)
    output inserted.id into @ids (addressaffiliationid)
	  values (@addressid, @accountid, @contactid);


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Create_Affiliation]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----Procedure to return errors
--CREATE PROCEDURE usp_GetErrorInfo
--AS
--SELECT
--    ERROR_NUMBER() AS ErrorNumber
--    ,ERROR_SEVERITY() AS ErrorSeverity
--    ,ERROR_STATE() AS ErrorState
--    ,ERROR_PROCEDURE() AS ErrorProcedure
--    ,ERROR_LINE() AS ErrorLine
--    ,ERROR_MESSAGE() AS ErrorMessage;
--GO

  CREATE Procedure [dbo].[SP_Create_Affiliation]
  ( @accountid as varchar(9)
  , @contactid as varchar(9)
  , @role as varchar(30) = null
  , @isprimaryaffiliation as bit)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;
  declare @affiliationid int
  declare @ids table (affiliationid int);

  Begin Try
	  --add affiliation
    if dbo.fnCheckContactExists(@contactid) = 0
      RAISERROR ('Contact does not exist.', 11, 1);

    if exists (select id from Affiliation where AccountId = @accountid and ContactId = @contactid)
      RAISERROR ('Cannot insert duplicate affiliation.', 11, 1);

      Insert into Affiliation(AccountId, ContactId, role, isPrimaryAffiliation)
		  output inserted.id into @ids (affiliationid)
		  values (@accountid, @contactid, @role, @isprimaryaffiliation);

	  --set new affiliation id
	    set @affiliationid = (select affiliationid from @ids  where affiliationid is not null);

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Create_Campaign]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [dbo].[SP_Create_Campaign]
  ( @Name varchar(100)
  , @Type varchar(20)
  , @StartDate datetime = null
  , @EndDate datetime = null
  , @Status varchar(20)
  , @isActive bit
  , @AccountId varchar(9))

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
	  --add campaign
    if exists (select id from Campaign where AccountId = @AccountId and Name = @name)
      RAISERROR ('Cannot insert duplicate campaign', 11, 1);

	  Insert into dbo.Campaign(Name, Type, StartDate, EndDate, Status, isActive, AccountId)
    values (@Name, @Type, coalesce(@startdate, getdate()), @EndDate, @Status, @isActive, @AccountId)

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Create_Contact]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----Procedure to return errors
--CREATE PROCEDURE usp_GetErrorInfo
--AS
--SELECT
--    ERROR_NUMBER() AS ErrorNumber
--    ,ERROR_SEVERITY() AS ErrorSeverity
--    ,ERROR_STATE() AS ErrorState
--    ,ERROR_PROCEDURE() AS ErrorProcedure
--    ,ERROR_LINE() AS ErrorLine
--    ,ERROR_MESSAGE() AS ErrorMessage;
--GO

  CREATE Procedure [dbo].[SP_Create_Contact]
  ( @first as varchar(30)
  , @last as varchar(30)
  , @title as varchar(10) = null
  , @email as varchar(50)
  , @mobile as varchar(20) = null
  , @middle as varchar(20) = null
  , @suffix as varchar(10) = null
  , @email2 as varchar(50) = null
  , @workphone as varchar(20) = null
  , @homephone as varchar(20) = null
  , @fax as varchar(20) = null
  , @accountname as varchar(100) = null
  , @accounttype as varchar(50)
  , @addresstype as varchar(20)
  , @addressCo as varchar(100)
  , @address1 as varchar(100)
  , @address2 as varchar(100)
  , @city as varchar(20)
  , @state as varchar(20)
  , @zip as int
  , @country as varchar(20)
  , @contactType as varchar(20))

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;

  begin tran;
  declare @accountid varchar(9),
		  @contactid varchar(9),
		  @affiliationid int,
		  @addressid int,
		  @count int,
		  @fullname varchar(50);
  declare @ids table (contactid varchar(9), accountid varchar(9), affiliationid int, addressid int);

  Begin Try
	  --add contact
    if exists (select id from contact where Email = @email and FirstName = @first and LastName = @last)
      RAISERROR ('Cannot insert duplicate contact.', 11, 1);

	  Insert into dbo.Contact (Title, FirstName, LastName, MiddleName, Suffix, Email, Email2, WorkPhone, HomePhone, CellPhone, Fax)
	  output inserted.id into @ids (contactid)
	  values (@title, @first, @last, @middle, @suffix, @email, @email2, @workphone, @homephone, @mobile, @fax);

	  --set new contactid
	  set @contactid = (select contactid from @ids  where contactid is not null);
	   -- add contact type

    insert into dbo.ContactType (ContactId, Type)
    values (@contactid, @contacttype);




      --add account
    IF @accountname is null OR not exists (select id from account where accountname = @accountname) --needs new account
	  begin
		  --create accountname
		  set @accountname = concat((select fullname from contact where id = @contactid), ' ', @accounttype);
		  --new account
		  Insert into Account (AccountName, Type)
		  output inserted.id into @ids (accountid)
		  values (@accountname, @accounttype);
		  set @accountid = (select top 1 accountid from @ids where accountid is not null);

	  --create new affiliation
		  insert into Affiliation (AccountId, ContactId)
		  output inserted.id into @ids (affiliationid)
		  values (@accountid, @contactid);

		  set @affiliationid = (select top 1 affiliationid from @ids  where affiliationid is not null);

	  end
    ELSE --account exists
	  begin
		  set	@accountid = (select id from account where AccountName = @accountname);

		    --create new affiliation
		    insert into Affiliation (AccountId, ContactId)
		    output inserted.id into @ids (affiliationid)
		    values (@accountid, @contactid);
		    set @affiliationid = (select top 1 affiliationid from @ids  where affiliationid is not null);

		  	  --get list of contact names
		  DECLARE @contactNames TABLE(
		  id int identity,
		  fullname varchar(100) NOT NULL);

		  INSERT INTO @contactNames (fullname)
		  SELECT fullname FROM contact c
		  join affiliation af on c.id = af.contactid
      join ContactType ct on ct.ContactId = c.id
		  where af.accountid = @accountid
      and ct.Type <> 'Student';


	  declare @newaccountname varchar(100) =
		  concat((select fullname from @contactNames where id = 1), ' and ', (select fullname from @contactNames where id = 2), ' ', @accounttype);

	  --update account name
	  update account set accountname = @newaccountname where id = @accountid;

	  end
    --check if first affiliation

    set @count = (select count(*) from Affiliation where AccountId = @accountid);

    --!!don't set as primary for household accounts
   -- --set as primary if only one
   -- IF @count = 1
	  --begin
		 -- update Affiliation set isPrimaryAffiliation = 1 where id = @affiliationid;
	  --end

    --add address
    --insert only if doesn't already exist

  exec dbo.SP_Create_Address @accountid = @accountid, @contactid = @contactid, @type = @addresstype, @addressCo = @addressCo, @address1 = @address1,
  @address2 = @address2, @city = @city, @state = @state, @zip = @zip, @country = @country;

    --if not exists (select id from dbo.Address where AddressLine_1 = @address1 and AddressLine_2 = @address2 and Zip = @zip)
    --  begin
    --    insert into dbo.Address (Type, AddressCo, AddressLine_1, AddressLine_2, City, State, Zip, Country)
    --    output inserted.id into @ids (addressid)
    --    values (@addresstype, @addressCo, @address1, @address2, @city, @state, @zip, @country);

    --    set @addressid = (select addressid from @ids where addressid is not null);
    --  end
    --ELSE --if exists, save address ID
    --  begin
    --    set @addressid = (select id from dbo.Address where AddressLine_1 = @address1 and AddressLine_2 = @address2 and Zip = @zip);
    --  end;

    ----add address affiliation

	   -- insert into dbo.AddressAffiliation (AddressId, ContactId)
	   -- values (@addressid, @contactid);



  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Create_ContactType]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



  CREATE Procedure [dbo].[SP_Create_ContactType]
  ( @contactid varchar(9)
  , @contactType as varchar(20)
  , @isActive bit = 1)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;

  begin tran;
  Begin Try

    if dbo.fnCheckContactExists(@contactid) = 0
      RAISERROR ('Contact does not exist.', 11, 1);

    if exists (select id from contacttype where contactid = @contactid and type = @contacttype)
      RAISERROR ('Cannot insert a duplicate contact type record.', 11, 1);

   insert into ContactType (ContactId, Type, isActive)
   values (@contactid, @contactType, @isActive);

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Account]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [dbo].[SP_Delete_Account]
  ( @accountid as varchar(9))
  --allows types Household, Academic Institution, Foundation, Program, Corporation

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;

  begin tran;

  Begin Try
	  --delete account
    if (exists (select id from Affiliation where accountID = @accountid) or exists (select id from Campaign where accountid = @accountid))
      RAISERROR ('Acount has active affiliations or Campaigns', 11, 1);

      delete from account where id = @accountid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Address]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----Procedure to return errors
--CREATE PROCEDURE usp_GetErrorInfo
--AS
--SELECT
--    ERROR_NUMBER() AS ErrorNumber
--    ,ERROR_SEVERITY() AS ErrorSeverity
--    ,ERROR_STATE() AS ErrorState
--    ,ERROR_PROCEDURE() AS ErrorProcedure
--    ,ERROR_LINE() AS ErrorLine
--    ,ERROR_MESSAGE() AS ErrorMessage;
--GO

  CREATE Procedure [dbo].[SP_Delete_Address]
  ( @addressid int )

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

   if not exists (select id from Address where id = @addressid)
      RAISERROR ('Address does not exist', 11, 1);

   --delete address affiliations
    if exists (select id from AddressAffiliation where addressID = @addressid)
	    begin
        delete from AddressAffiliation where addressid = @addressid;
      end

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Affiliation]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----Procedure to return errors
--CREATE PROCEDURE usp_GetErrorInfo
--AS
--SELECT
--    ERROR_NUMBER() AS ErrorNumber
--    ,ERROR_SEVERITY() AS ErrorSeverity
--    ,ERROR_STATE() AS ErrorState
--    ,ERROR_PROCEDURE() AS ErrorProcedure
--    ,ERROR_LINE() AS ErrorLine
--    ,ERROR_MESSAGE() AS ErrorMessage;
--GO

  CREATE Procedure [dbo].[SP_Delete_Affiliation]
  ( @accountid as varchar(9)
  , @contactid as varchar(9))

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;
  Begin Try
	  --delete affiliation
    if not exists (select id from Affiliation where AccountId = @accountid and ContactId = @contactid)
      RAISERROR ('Affiliation does not exists', 11, 1);


      declare @isprimary bit = (select isPrimaryAffiliation from Affiliation where AccountId = @accountid and ContactId = @contactid);
      update affiliation set isactive = 0, isPrimaryAffiliation = 0 where id = (select id from Affiliation where AccountId = @accountid and ContactId = @contactid)
	  --set new primary affiliation
      if @isprimary = 1
        begin
	        update affiliation set isprimaryaffiliation = 1 where id = (select top 1 af.id from affiliation af join account a on af.AccountId = a.id where contactid = @contactid and isPrimaryAffiliation = 0 and isactive = 1
          and a.Type <> 'Household');
        end


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Contact]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [dbo].[SP_Delete_Contact]
  ( @contactid as varchar(9))
  --allows types Household, Academic Institution, Foundation, Program, Corporation

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;

  begin tran;

  Begin Try
	  --delete contact
    if (exists (select af.id from affiliation af join account a on a.id = af.accountid where af.contactid = @contactid and a.type <> 'Household')
    or exists(select id from fund.opportunity where contactid = @contactid)
    or exists(select id from volunteer.hour where contactid = @contactid)
    or exists (select id from enroll.Section where InstructorId = @contactid)
    or exists (select id from enroll.SectionEnrollment where StudentId = @contactid))
      RAISERROR ('Contact has active affiliations, opportunites, or volunteer hours', 11, 1);

      delete from contacttype where contactid = @contactid;
      delete from AddressAffiliation where contactid = @contactid;
      delete from affiliation where id in (select af.id from affiliation af join account a on a.id = af.accountid where af.contactid = @contactid and a.type = 'Household');
      delete from contact where id = @contactid;


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Account]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [dbo].[SP_Update_Account]
  ( @accountid as varchar(9)
  , @accountname as varchar(100) = null
  , @type as varchar(20) = null)
  --allows types Household, Academic Institution, Foundation, Program, Corporation

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;

  begin tran;

  Begin Try
	  --add account
    if not exists (select id from account where ID = @accountid)
      RAISERROR ('Account does not exist', 11, 1);

    if exists (select id from account where AccountName = @accountname and type = @type and id <> @accountid)
      RAISERROR ('This update will cause a duplicate account. Update cancelled.', 11, 1);


    Update Account
    set AccountName = coalesce(@accountname, accountname)
    , Type = coalesce(@type, type)
    where ID = @accountid;


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Address]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----Procedure to return errors
--CREATE PROCEDURE usp_GetErrorInfo
--AS
--SELECT
--    ERROR_NUMBER() AS ErrorNumber
--    ,ERROR_SEVERITY() AS ErrorSeverity
--    ,ERROR_STATE() AS ErrorState
--    ,ERROR_PROCEDURE() AS ErrorProcedure
--    ,ERROR_LINE() AS ErrorLine
--    ,ERROR_MESSAGE() AS ErrorMessage;
--GO

  CREATE Procedure [dbo].[SP_Update_Address]
  ( @addressid int
  , @type as varchar(20) = null
  , @addressCo as varchar(100) = null
  , @address1 as varchar(100) = null
  , @address2 as varchar(100) = null
  , @city as varchar(20) = null
  , @state as varchar(20) = null
  , @zip as int = null
  , @country as varchar(20) = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
	  --update address

    if not exists (select id from dbo.Address where id = @addressid)
      RAISERROR ('Address does not exist', 11, 1);

    update address
    set type = coalesce(@type, type)
    , addressco = coalesce(@addressco, addressco)
    , AddressLine_1 = coalesce(@address1, AddressLine_1)
    , AddressLine_2 = coalesce(@address2, AddressLine_2)
    , city = coalesce(@city, city)
    , state = coalesce(@state, state)
    , zip = coalesce(@zip, zip)
    , country = coalesce(@country, country)
    where id = @addressid

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Campaign]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [dbo].[SP_Update_Campaign]
  ( @CampaignID varchar(9)
  , @Name varchar(100) = null
  , @Type varchar(20) = null
  , @StartDate datetime = null
  , @EndDate datetime = null
  , @Status varchar(20) = null
  , @isActive bit = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
	  --add campaign
    if not exists (select id from Campaign where id = @CampaignID)
      RAISERROR ('Campaign does not exist', 11, 1);

	  update Campaign
    set Name = coalesce(@name, name)
    , type = coalesce(@type, type)
    , startdate = coalesce(@startdate, startdate)
    , enddate = coalesce(@enddate, enddate)
    , status = coalesce(@status, status)
    , isactive = coalesce(@isactive, isactive)
    where id = @CampaignID;


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Contact]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [dbo].[SP_Update_Contact]
  ( @contactid as varchar(9)
  , @first as varchar(30) = null
  , @last as varchar(30)= null
  , @title as varchar(10) = null
  , @email as varchar(50)= null
  , @mobile as varchar(20) = null
  , @middle as varchar(20) = null
  , @suffix as varchar(10) = null
  , @email2 as varchar(50) = null
  , @workphone as varchar(20) = null
  , @homephone as varchar(20) = null
  , @fax as varchar(20) = null
  , @contactType as varchar(20) = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if dbo.fnCheckContactExists(@contactid) = 0
      RAISERROR ('Contact does not exist.', 11, 1);

    --update contact
	  Update contact set
      title = coalesce(title, @title)
    , FirstName = coalesce(firstname, @first)
    , MiddleName = coalesce(MiddleName, @middle)
    , Suffix = coalesce(Suffix, @suffix)
    , LastName = coalesce(LastName, @last)
    , Email = coalesce(Email, @email)
    , Email2 = coalesce(Email2, @email2)
    , WorkPhone = coalesce(WorkPhone, @workphone)
    , HomePhone = coalesce(HomePhone, @homephone)
    , CellPhone = coalesce(CellPhone, @mobile)
    , Fax = coalesce(Fax, @fax)
    where id = @contactid;

 -- update contact type
    if @contacttype is not null
      begin
        update dbo.ContactType
        set type = @contactType
        where id = (select top 1 id from ContactType where ContactId = @contactid order by id);
      end


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_ContactType]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



  create Procedure [dbo].[SP_Update_ContactType]
  ( @typeid varchar(9)
  , @isActive bit)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;

  begin tran;
  Begin Try

    if not exists (select id from contacttype where id = @typeid)
      RAISERROR ('Contact Type Record does not exist.', 11, 1);

    update contacttype set isActive = @isActive where id = @typeid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [dbo].[usp_GetErrorInfo]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----Procedure to return errors
CREATE PROCEDURE [dbo].[usp_GetErrorInfo]
AS
SELECT
    ERROR_NUMBER() AS ErrorNumber
    ,ERROR_SEVERITY() AS ErrorSeverity
    ,ERROR_STATE() AS ErrorState
    ,ERROR_PROCEDURE() AS ErrorProcedure
    ,ERROR_LINE() AS ErrorLine
    ,ERROR_MESSAGE() AS ErrorMessage;
GO
/****** Object:  StoredProcedure [enroll].[SP_Create_Attendance]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [enroll].[SP_Create_Attendance]
  ( @studentid varchar(9)
  , @enrollmentid int
  , @attendancedate datetime = null
  , @ispresent bit = 1
  , @islate bit = 0
  , @arrivedtime time = null
  , @lefttime time = null
  , @note varchar(100) = null
  )

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if dbo.fnCheckContactExists(@studentid) = 0
      RAISERROR ('Student does not exist.', 11, 1);

    IF @attendancedate is null
      SET @attendancedate = getdate();

    declare @sctime time = (select sctime from enroll.Section where id = (select sectionid from enroll.SectionEnrollment where id = @enrollmentid));
    set @attendancedate = cast(cast(@attendancedate as date) as datetime) + cast(@sctime as datetime);

    if exists (select id from enroll.Attendance where studentid = @studentid and SectionEnrollmentId = @enrollmentid and AttendanceDate = @attendancedate)
      RAISERROR ('Cannot insert a duplicate attendance record.', 11, 1);

    if @ispresent = 1 and @islate = 0
      set @arrivedtime = @sctime;

    insert into enroll.Attendance (studentid, SectionEnrollmentId, isPresent, isLate, AttendanceDate, Arrivedtime, Lefttime, Note)
    values (@studentid, @enrollmentid, @ispresent, @islate, @attendancedate, @arrivedtime, @lefttime, @note);


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Create_Course]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [enroll].[SP_Create_Course]
  ( @schoolid varchar(9)
  , @CourseName varchar(30))

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if exists (select id from enroll.course where AcademicInstitutionId = @schoolid and CourseName = @CourseName)
      RAISERROR ('Cannot insert a duplicate course record.', 11, 1);

    insert into enroll.Course (AcademicInstitutionId, CourseName)
    values (@schoolid, @CourseName);

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Create_Grade]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [enroll].[SP_Create_Grade]
  ( @studentid varchar(9)
  , @gradename varchar(30)
  , @termid int
  , @isActive bit = 0)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
     if dbo.fnCheckContactExists(@studentid) = 0
      RAISERROR ('Student does not exist.', 11, 1);

    if exists (select id from enroll.Grade where StudentId = @studentid and termid = @termid and GradeName = @gradename)
      RAISERROR ('Cannot enter a duplicate grade record.', 11, 1);

    if @isActive = 1
      update enroll.grade set isActive = 0 where StudentId = @studentid and isActive = 1; --update old grade to inactive

    insert into enroll.Grade (StudentId, GradeName, TermId, isActive)
    values (@studentid, @gradename, @termid, @isActive);


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Create_Section]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  CREATE Procedure [enroll].[SP_Create_Section]
  ( @courseid int
  , @termid int
  , @instructorid varchar(9) = null
  , @maxstudents int = 50
  , @status varchar(20) = 'Planned'
  , @scdays varchar(20) = 'M,T,W,TH'
  , @sctime time
  , @scmins int = 50
  )
  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if exists (select id from enroll.Section where courseid = @courseid and termid = @termid and InstructorId = @instructorid and scdays = @scdays and sctime = @sctime)
      RAISERROR ('Cannot insert a duplicate section.', 11, 1);


    insert into enroll.Section (CourseId, termid, InstructorId, MaxStudents, Status, scdays, sctime, scmins)
    values (@courseid, @termid, @instructorid, @maxstudents, @status, @scdays, @sctime, @scmins);


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Create_SectionEnrollment]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [enroll].[SP_Create_SectionEnrollment]
  ( @sectionid int
  , @studentid varchar(9)
  , @grade varchar(10) = null
  , @status varchar(20) = 'Current'
  )
  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if dbo.fnCheckContactExists(@studentid) = 0
      RAISERROR ('Contact does not exist.', 11, 1);

    if ((not exists (select id from enroll.Section where id = @sectionid)) OR (exists (select id from enroll.Section where id = @sectionid and status = 'Cancelled')))
      RAISERROR ('Section does not exist or is cancelled', 11, 1);

    if exists (select id from enroll.SectionEnrollment where StudentId = @studentid and SectionId = @sectionid)
      RAISERROR ('Cannot enter duplicate enrollment', 11, 1);

    insert into enroll.SectionEnrollment (StudentId, SectionId, Grade, Status)
    values (@studentid, @sectionid, @grade, @status);

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Create_Term]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [enroll].[SP_Create_Term]
  ( @name varchar(10)
  , @StartDate datetime
  , @EndDate datetime)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if exists (select * from enroll.term where TermName = @name)
      RAISERROR ('Cannot insert duplicate term.', 11, 1);


    insert into enroll.term (TermName, StartDate, EndDate)
    values (@name, @StartDate, @EndDate);

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Delete_Course]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [enroll].[SP_Delete_Course]
  ( @courseid int)
  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if exists (select * from enroll.Section where courseid = @courseid and status <> 'Cancelled')
      RAISERROR ('Active sections exists with this course', 11, 1);

    if not exists (select * from enroll.course where id = @courseid)
      RAISERROR ('Course does not exist', 11, 1);

    delete from enroll.Section where courseid = @courseid;
    delete from enroll.Course where id = @courseid;


  End Try
  BEGIN CATCH

    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Delete_Grade]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [enroll].[SP_Delete_Grade]
  ( @gradeid int)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if not exists (select id from enroll.Grade where id = @gradeid)
      RAISERROR ('Grade record does not exist.', 11, 1);

    if (Select isactive from enroll.grade where id = @gradeid) = 1
      begin
        declare @studentid varchar(9) = (select studentid from enroll.grade where id = @gradeid);
        declare @lastgradeid int = (select top 1 id from enroll.grade where StudentId = @studentid and isActive = 0 order by id desc);

        update enroll.grade set isactive = 1 where id = @lastgradeid;
      end

    delete from enroll.grade where id = @gradeid;


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Delete_Section]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [enroll].[SP_Delete_Section]
  ( @sectionid int)
  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if not exists (select id from enroll.Section where id = @sectionid)
      RAISERROR ('Section does not exists', 11, 1);
    if exists (select id from enroll.SectionEnrollment where sectionid = @sectionid and status <> 'Withdrawn')
      RAISERROR ('Section has active enrollments', 11, 1);

    delete from enroll.SectionEnrollment where SectionId = @sectionid and status = 'Withdrawn';
    delete from enroll.Section where id = @sectionid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Update_Attendance]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [enroll].[SP_Update_Attendance]
  ( @attendanceid int
  , @ispresent bit = null
  , @islate bit = null
  , @arrivedtime time = null
  , @lefttime time = null
  , @note varchar(100) = null
  )

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if not exists (select id from enroll.Attendance where id = @attendanceid)
      RAISERROR ('Attendance record does not exist.', 11, 1);

    declare @sctime time = (select sctime from enroll.Section where id = (select sectionid from enroll.SectionEnrollment where id = (select SectionEnrollmentid from enroll.Attendance where id = @attendanceid)));

    if @ispresent = 1 and @islate = 0
      set @arrivedtime = @sctime;

    update enroll.Attendance
    set isPresent = coalesce(@ispresent, ispresent)
    , isLate = coalesce(@islate, islate)
    , arrivedtime = coalesce(@arrivedtime, arrivedtime)
    , lefttime = coalesce(@lefttime, lefttime)
    , note = coalesce(@note, note)
    where id = @attendanceid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Update_Course]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [enroll].[SP_Update_Course]
  ( @courseid int
  , @CourseName varchar(30))

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if not exists (select id from enroll.course where id = @courseid)
      RAISERROR ('Course does not exist.', 11, 1);

    if exists (select id from enroll.course where CourseName = @CourseName and id <> @courseid and AcademicInstitutionId = (select AcademicInstitutionId from enroll.course where id = @courseid))
      RAISERROR ('Cannot update course as a course with this name already exists for this institution.', 11, 1);

    update enroll.course set CourseName = @CourseName where id = @courseid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Update_Section]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [enroll].[SP_Update_Section]
  ( @sectionid int
  , @instructorid varchar(9) = null
  , @maxstudents int = null
  , @status varchar(20) = null
  , @scdays varchar(20) = null
  , @sctime varchar(20) = null
  )
  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if not exists (select id from enroll.Section where id = @sectionid)
      RAISERROR ('Section does not exists', 11, 1);

    if @status = 'Cancelled'
      begin
        if exists (select id from enroll.SectionEnrollment where sectionid = @sectionid)
          RAISERROR ('Section has active enrollments', 11, 1);
        end

    update enroll.Section
    set InstructorId = coalesce(@instructorid, instructorid)
    , MaxStudents = coalesce(@maxstudents, maxstudents)
    , Status = coalesce(@status, status)
    , scdays = coalesce(@scdays, scdays)
    , sctime = coalesce(@sctime, sctime)
    where id = @sectionid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Update_SectionEnrollment]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create Procedure [enroll].[SP_Update_SectionEnrollment]
  ( @enrollmentid int
  , @grade varchar(10) = null
  , @status varchar(20) = null
  )
  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if not exists (select id from enroll.SectionEnrollment where id = @enrollmentid)
      RAISERROR ('Enrollment does not exist.', 11, 1);

    update enroll.SectionEnrollment
      set grade = coalesce(@grade, grade), Status = coalesce(@status, status)
    where id = @enrollmentid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [enroll].[SP_Update_Term]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [enroll].[SP_Update_Term]
  ( @termid int
  , @StartDate datetime = null
  , @EndDate datetime = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if not exists (select id from enroll.Term where id = @termid)
      RAISERROR ('Term does not exist.', 11, 1);

    update enroll.Term set StartDate = coalesce(@startdate, StartDate), EndDate = coalesce(@enddate, EndDate)
    where id = @termid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [fund].[SP_Create_Opportunity]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [fund].[SP_Create_Opportunity]
  ( @campaignid varchar(9)
  , @contactid varchar(9)
  , @name varchar(100) = null
  , @Status nvarchar(20) = 'Pending'
  , @ReqAmount decimal(18,2)
  , @WonAmount decimal(18,2) = null
  , @dateexpected datetime = null
  , @dateclosed datetime = null
  , @RecDonation bit = 0
  , @RecDonationId int = null
  , @RecDonationInstal int = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if dbo.fnCheckContactExists(@contactid) = 0
      RAISERROR ('Contact does not exist.', 11, 1);

    if (@name is null or @name = '')
      begin
        set @name = concat((select fullname from dbo.contact where id = @contactid), ' - ', coalesce(@dateexpected, getdate()));
      end

      declare @ids table (opportunityid int);
      declare @opportunityid int

	    --add opportunity
	    Insert into fund.Opportunity (CampaignId, ContactId, Name, Status, ReqAmount, WonAmount, DateExpected, DateClosed, RecDonation, RecDonationId, RecDonationInstal)
      output inserted.id into @ids (opportunityid)
      values (@campaignid, @contactid, @name, @Status, @ReqAmount, @WonAmount, @dateexpected, @dateclosed, @RecDonation, @RecDonationId, @RecDonationInstal)

	    set @opportunityid = (select opportunityid from @ids  where opportunityid is not null);


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [fund].[SP_Create_Payment]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [fund].[SP_Create_Payment]
  ( @opportunityid int
  , @type varchar(20)
  , @status varchar(20) = 1
  , @paid bit
  , @AmountReceived decimal(18,2)
  , @WrittenOff bit = 0
  , @Notes varchar(max) = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

  if not exists (select id from fund.Opportunity where id = @opportunityid)
    RAISERROR ('Opportunity does not exist.', 11, 1);

  declare @ids table (paymentid int);
  declare @paymentid int;
  declare @paidamount decimal(18,2) = @AmountReceived;

	--add payment
	Insert into fund.Payment (OpportunityId, type, status, paid, AmountReceived, WrittenOff, notes)
  output inserted.id into @ids (paymentid)
  values (@opportunityid, @type, @status, @paid, @AmountReceived, @WrittenOff, @Notes);

	set @paymentid = (select paymentid from @ids  where paymentid is not null);

  --update opportunity
  set @paidamount += (select coalesce(WonAmount,0) from fund.Opportunity where id = @opportunityid);
  declare @reqamount decimal(18,2) = (select reqamount from fund.Opportunity where id = @opportunityid);

  update Opportunity set WonAmount = @paidamount where id = @opportunityid;
  if @paidamount >= @reqamount
    begin
      update Opportunity set status = 'Closed Won', DateClosed = getdate() where id = @opportunityid;
    end



  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [fund].[SP_Create_RecDonation]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [fund].[SP_Create_RecDonation]
  ( @CampaignId varchar(9)
  , @ContactId varchar(9)
  , @TotalAmount decimal (18,2) = null
  , @InstalAmount decimal(18,2) = null
  , @InstalPeriod varchar(20) = "Once a Month"
  , @StartDate datetime = null
  , @EndDate datetime = null
  , @NumInstal int = null
  , @OpenEnded bit = 0)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if dbo.fnCheckContactExists(@contactid) = 0
      RAISERROR ('Contact does not exist.', 11, 1);

    if (@TotalAmount is null and @InstalAmount is null and @EndDate is null)
      RAISERROR ('An amount must be entered.', 11, 1);

    declare @ids table (recDonationId int);
    declare @recDonationId int;

    set @StartDate = isnull(@startdate, getdate());

    if (@TotalAmount is not null)
      begin
        set @InstalAmount = @TotalAmount / @NumInstal;
      end
    else
      begin
        set @NumInstal = DATEDIFF(month, @StartDate, @EndDate);
      end

	  --add recDonation
	  Insert into [fund].[RecDonation] (CampaignId, ContactId, TotalAmount, InstalAmount, InstalPeriod, NumInstal, StartDate, EndDate)
    output inserted.id into @ids (recDonationId)
    values (@CampaignId, @ContactId, @TotalAmount, @InstalAmount, @InstalPeriod, @NumInstal, @StartDate, @EndDate);

	  set @recDonationId = (select recDonationId from @ids  where recDonationId is not null);

    --insert opportunities
    --loop for each installation
    declare @i int = 1;
    while @i <= @NumInstal
      begin
        --set date for installation based on startdate
        declare @date date = DATEADD(month, @i-1, @startdate);
        --create opportunity for installation
        exec fund.SP_Create_Opportunity @campaignid = @CampaignId, @contactid = @ContactId, @status = 'Pending', @reqamount = @InstalAmount, @recDonationId = @recDonationId, @recdonation = 1, @recdonationinstal = @i, @dateexpected = @date;
        --Insert into fund.Opportunity (Name, CampaignId, ContactId, RecDonation, RecDonationId, RecDonationInstal, Status, ReqAmount, DateExpected)
        --values (concat("Instal ", @i)), @CampaignId, @ContactId, 1, @recDonationId, @i, 'Pending', @InstalAmount, @date);

        set @i += 1;
      end


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [fund].[SP_Update_Opportunity]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [fund].[SP_Update_Opportunity]
  ( @opportunityid int
  , @Status nvarchar(20) = null
  , @ReqAmount decimal(18,2) = null
  , @dateexpected datetime = null
  , @dateclosed datetime = null
  )

  --won amount can only be adjusted via payments. never directly in opportunities.


  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if not exists (select id from fund.Opportunity where id = @opportunityid)
      RAISERROR ('Opportunity does not exist.', 11, 1);

    update fund.Opportunity
    set status = coalesce(@status, status)
  , ReqAmount = coalesce(@ReqAmount, ReqAmount)
  , DateExpected = coalesce(@dateexpected, DateExpected)
  , DateClosed = coalesce(@dateclosed, DateClosed)
    where id = @opportunityid;


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [fund].[SP_Update_Payment]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [fund].[SP_Update_Payment]
  ( @paymentid int
  , @type varchar(20) = null
  , @status varchar(20) = null
  , @paid bit = null
  --, @AmountReceived decimal(18,2) you cannot alter the payment amount. You must void the payment and create a new one instead.
  , @WrittenOff bit = null
  , @Notes varchar(max) = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if not exists (select id from fund.payment where id = @paymentid)
      RAISERROR ('Payment record does not exist.', 11, 1);

    if @status = 'Void'
      begin
        declare @opportunityid int = (select Opportunityid from fund.Payment where id = @paymentid);
        declare @AmountReceived int = (select AmountReceived from fund.Payment where id = @paymentid);

        if (select status from fund.Opportunity where id = @opportunityid) <> 'Closed Won'
          begin
            update fund.Opportunity set WonAmount = WonAmount - @AmountReceived where id = @opportunityid;
            update fund.Payment set Status = @status where id = @paymentid;
          end
      end
    else
      begin
        update fund.Payment
        set Type = coalesce(@type, Type)
      , Status = coalesce(@Status, Status)
      , Paid = coalesce(@Paid, Paid)
      --, AmountReceived = coalesce(@AmountReceived, AmountReceived)
      , WrittenOff = coalesce(@WrittenOff, WrittenOff)
      , Notes = coalesce(@Notes, Notes)
        where id = @paymentid;
      end

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [volunteer].[SP_Create_Hour]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [volunteer].[SP_Create_Hour]
  ( @ContactId varchar(9)
  , @ShiftId int
  , @skill1 varchar(20) = null
  , @skill2 varchar(20) = null
  , @skill3 varchar(20) = null
  , @CheckInDate datetime = null
  , @CheckOutDate datetime = null
  , @Status varchar(20) = 'Interested')

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if dbo.fnCheckContactExists(@contactid) = 0
      RAISERROR ('Contact does not exist.', 11, 1);
    if not exists (select id from volunteer.shift where id = @shiftid)
      RAISERROR ('Shift does not exist.', 11, 1);
    if exists (select id from volunteer.hour where contactid = @ContactId and shiftid = @ShiftId)
      RAISERROR ('Volunteer hours already exist for this volunteer on this shift.', 11, 1);

    --add Hours
	  Insert into volunteer.hour (ContactId, ShiftId, CheckInDate, CheckOutDate, Status)
    values (@ContactId, @ShiftId, @CheckInDate, @CheckOutDate, @Status)


    --add volunteer skills
    declare @ids table (skill1id int, skill2id int, skill3id int);

    --add job skills
    if @skill1 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill1)
      begin
        declare @skill1id int = (select id from volunteer.SkillAvail where name = @skill1);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill1id)
        values (@skill1);

        set @skill1id = (select skill1id from @ids where skill1id is not null);
      end
      if not exists (select id from volunteer.Detail where contactid = @ContactId and SkillAvailid = @skill1id)
        begin
          insert into volunteer.detail (contactid, SkillAvailId)
          values (@contactid, @skill1id)
        end
    end

    if @skill2 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill2)
      begin
        declare @skill2id int = (select id from volunteer.SkillAvail where name = @skill2);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill2id)
        values (@skill2);

        set @skill2id = (select skill2id from @ids where skill2id is not null);
      end
      if not exists (select id from volunteer.Detail where contactid = @ContactId and SkillAvailid = @skill2id)
        begin
          insert into volunteer.detail (contactid, SkillAvailId)
          values (@contactid, @skill2id)
        end
    end

    if @skill3 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill3)
      begin
        declare @skill3id int = (select id from volunteer.SkillAvail where name = @skill3);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill3id)
        values (@skill3);

        set @skill3id = (select skill3id from @ids where skill3id is not null);
      end
      if not exists (select id from volunteer.Detail where contactid = @ContactId and SkillAvailid = @skill3id)
        begin
          insert into volunteer.detail (contactid, SkillAvailId)
          values (@contactid, @skill3id)
        end
    end


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [volunteer].[SP_Create_Job]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [volunteer].[SP_Create_Job]
  ( @CampaignId varchar(9)
  , @Name varchar(100)
  , @skill1 varchar(20) = null
  , @skill2 varchar(20) = null
  , @skill3 varchar(20) = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if not exists (select id from Campaign where id = @CampaignId)
      RAISERROR ('Campaign does not exist.', 11, 1);
    if exists (select id from volunteer.Job where Campaignid = @CampaignId and Name = @Name)
      RAISERROR ('A Job with this name already exists for this campaign.', 11, 1);

    declare @jobid int;
    declare @ids table (jobid int, skill1id int, skill2id int, skill3id int);

    --add Job
	  Insert into volunteer.Job (CampaignId, Name)
		output inserted.id into @ids (jobid)
    values (@CampaignId, @Name);

    set @jobid = (select jobid from @ids where jobid is not null);

    --add job skills
    if @skill1 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill1)
      begin
        declare @skill1id int = (select id from volunteer.SkillAvail where name = @skill1);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill1id)
        values (@skill1);

        set @skill1id = (select skill1id from @ids where skill1id is not null);
      end
      insert into volunteer.jobdetail (jobid, skillneededid)
      values (@jobid, @skill1id)
    end

    if @skill2 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill2)
      begin
        declare @skill2id int = (select id from volunteer.SkillAvail where name = @skill2);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill2id)
        values (@skill2);

        set @skill2id = (select skill2id from @ids where skill2id is not null);
      end
      insert into volunteer.jobdetail (jobid, skillneededid)
      values (@jobid, @skill2id)
    end

    if @skill3 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill3)
      begin
        declare @skill3id int = (select id from volunteer.SkillAvail where name = @skill3);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill3id)
        values (@skill3);

        set @skill3id = (select skill3id from @ids where skill3id is not null);
      end
      insert into volunteer.jobdetail (jobid, skillneededid)
      values (@jobid, @skill3id)
    end

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [volunteer].[SP_Create_Shift]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create Procedure [volunteer].[SP_Create_Shift]
  ( @JobId int
  , @StartDate datetime = null
  , @EndDate datetime = null
  , @VolNeeded int = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    --add Shift
	  Insert into volunteer.shift (JobId, StartDate, EndDate, VolunteersNeeded)
    values (@JobId, @StartDate, @EndDate, @VolNeeded)

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [volunteer].[SP_Delete_Hour]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [volunteer].[SP_Delete_Hour]
  ( @hourid int
  )

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if not exists (select id from volunteer.hour where id = @hourid)
      RAISERROR ('Volunteer hour record does not exist.', 11, 1);

    declare @shiftid varchar(9) = (select shiftid from volunteer.hour where id = @hourid);

    if (select startdate from volunteer.shift where id = @shiftid) <= getdate()
      RAISERROR ('Shift start date has passed. Cannot cancel hours.', 11, 1);

    update volunteer.Hour set status = 'Cancelled' where id = @hourid;


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [volunteer].[SP_Delete_Jobs]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [volunteer].[SP_Delete_Jobs]
  ( @jobid int
  )

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
    if not exists (select id from volunteer.job where id = @jobid)
      RAISERROR ('Job does not exist.', 11, 1);

	 declare @campaignid varchar(9) = (select CampaignId from volunteer.job where id = @jobid);

   if not ((select enddate from Campaign where id = @campaignid) > getdate()) AND ((select status from Campaign where id = @campaignid) <> 'Completed')
   AND ((select top 1 startdate from volunteer.shift where jobid = @jobid) > getdate())
     RAISERROR ('Campaign or shift already started or is completed.', 11, 1);

    delete from volunteer.JobDetail where jobid = @jobid;
    delete from volunteer.hour where shiftid in (select id from volunteer.Shift where jobid = @jobid);
    delete from volunteer.shift where jobid = @jobid;
    delete from volunteer.Job where id = @jobid;


  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [volunteer].[SP_Delete_Shift]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [volunteer].[SP_Delete_Shift]
  ( @shiftid int
  )

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try

    if not exists (select id from volunteer.shift where id = @shiftid)
      RAISERROR ('Shift does not exist.', 11, 1);

    if (select startdate from volunteer.shift where id = @shiftid) <= getdate()
      RAISERROR ('Shift already started.', 11, 1);

    delete from volunteer.Hour where shiftid = @shiftid;
    delete from volunteer.shift where id = @shiftid;

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
/****** Object:  StoredProcedure [volunteer].[SP_Update_Jobs]    Script Date: 5/16/2020 3:04:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE Procedure [volunteer].[SP_Update_Jobs]
  ( @jobid int
  , @skill1 varchar(20) = null
  , @skill2 varchar(20) = null
  , @skill3 varchar(20) = null)

  as
  begin
  set nocount on
-- SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
  SET XACT_ABORT ON;

  begin tran;

  Begin Try
	  if not exists (select id from volunteer.job where id = @jobid)
      RAISERROR ('Job does not exist.', 11, 1);

    declare @ids table (jobid int, skill1id int, skill2id int, skill3id int);



    --add job skills
    if @skill1 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill1)
      begin
        declare @skill1id int = (select id from volunteer.SkillAvail where name = @skill1);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill1id)
        values (@skill1);

        set @skill1id = (select skill1id from @ids where skill1id is not null);
      end
      if not exists (select id from volunteer.JobDetail where jobid = @jobid and SkillNeededId = @skill1id)
        insert into volunteer.jobdetail (jobid, skillneededid)
        values (@jobid, @skill1id);
    end

    if @skill2 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill2)
      begin
        declare @skill2id int = (select id from volunteer.SkillAvail where name = @skill2);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill2id)
        values (@skill2);

        set @skill2id = (select skill2id from @ids where skill2id is not null);
      end
      if not exists (select id from volunteer.JobDetail where jobid = @jobid and SkillNeededId = @skill2id)
        insert into volunteer.jobdetail (jobid, skillneededid)
        values (@jobid, @skill2id);
    end

    if @skill3 is not null
    begin
      if exists (select id from volunteer.SkillAvail where name = @skill3)
      begin
        declare @skill3id int = (select id from volunteer.SkillAvail where name = @skill3);
      end
      else
      begin
        insert into volunteer.SkillAvail (name)
        output inserted.id into @ids (skill3id)
        values (@skill3);

        set @skill3id = (select skill3id from @ids where skill3id is not null);
      end
      if not exists (select id from volunteer.JobDetail where jobid = @jobid and SkillNeededId = @skill3id)
        insert into volunteer.jobdetail (jobid, skillneededid)
        values (@jobid, @skill3id);
    end

  End Try
  BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo;
	 IF (XACT_STATE()) = -1
    BEGIN
        PRINT
            N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;

    -- Test whether the transaction is committable.
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT
            N'The transaction is committable.' +
            'Committing transaction.'
        COMMIT TRANSACTION;
    END;
END CATCH;
commit;
	end

GO
USE [master]
GO
ALTER DATABASE [dreamLocal] SET  READ_WRITE 
GO
