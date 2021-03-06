USE [master]
GO
/****** Object:  Database [vsaTest]    Script Date: 09/25/2020 01:36:51 ******/
CREATE DATABASE [vsaTest] ON  PRIMARY 
( NAME = N'vsaTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\vsaTest.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'vsaTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\vsaTest_log.LDF' , SIZE = 576KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [vsaTest] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [vsaTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [vsaTest] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [vsaTest] SET ANSI_NULLS OFF
GO
ALTER DATABASE [vsaTest] SET ANSI_PADDING OFF
GO
ALTER DATABASE [vsaTest] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [vsaTest] SET ARITHABORT OFF
GO
ALTER DATABASE [vsaTest] SET AUTO_CLOSE ON
GO
ALTER DATABASE [vsaTest] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [vsaTest] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [vsaTest] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [vsaTest] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [vsaTest] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [vsaTest] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [vsaTest] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [vsaTest] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [vsaTest] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [vsaTest] SET  ENABLE_BROKER
GO
ALTER DATABASE [vsaTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [vsaTest] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [vsaTest] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [vsaTest] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [vsaTest] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [vsaTest] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [vsaTest] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [vsaTest] SET  READ_WRITE
GO
ALTER DATABASE [vsaTest] SET RECOVERY SIMPLE
GO
ALTER DATABASE [vsaTest] SET  MULTI_USER
GO
ALTER DATABASE [vsaTest] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [vsaTest] SET DB_CHAINING OFF
GO
USE [vsaTest]
GO
/****** Object:  Table [dbo].[tblTest]    Script Date: 09/25/2020 01:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReceivedDate] [datetime] NOT NULL,
	[SentDate] [datetime] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ClaimsAdministrator] [varchar](50) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Request] [varchar](50) NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[Employer] [varchar](50) NULL,
 CONSTRAINT [PK_tblTestD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spInsertData]    Script Date: 09/25/2020 01:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spInsertData]
(
@ReceivedDate datetime,
@SentDate datetime,
@Name varchar(50),
@ClaimsAdministrator varchar(50),
@Employer varchar(50),
@Description varchar(50),
@Request varchar(50),
@DueDate datetime
)
as begin
set xact_abort on
begin try
	begin tran
		Insert into tblTest(ReceivedDate,SentDate,Name,ClaimsAdministrator,
		Employer,[Description],Request,DueDate)
		values(@ReceivedDate,@SentDate,@Name,@ClaimsAdministrator,
		@Employer,@Description,@Request,@DueDate)
	commit tran
end try
begin catch
	if xact_state() = -1
	rollback tran
end catch
end
GO
/****** Object:  StoredProcedure [dbo].[spGetDataByDates]    Script Date: 09/25/2020 01:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetDataByDates]
(
@ReceiveDate datetime = null,
@SentDate datetime = null,
@DueDate datetime = null
)
as begin
	if(@ReceiveDate is not null and @SentDate is not null)
	begin
		Select 
		Convert(varchar(10),ReceivedDate,103) as ReceivedDate,
		Convert(varchar(10),SentDate,103) as SentDate,
		Name,
		ClaimsAdministrator,
		Employer,
		Description,
		Request,
		Convert(varchar(10),DueDate,103) as DueDate
		from tblTest
			where ReceivedDate = @ReceiveDate and SentDate = @SentDate
	end
	else 
	begin
		if(@DueDate is not null)
		begin
			Select 
		Convert(varchar(10),ReceivedDate,103) as ReceivedDate,
		Convert(varchar(10),SentDate,103) as SentDate,
		Name,
		ClaimsAdministrator,
		Employer,
		Description,
		Request,
		Convert(varchar(10),DueDate,103) as DueDate
		from tblTest
			where DueDate = @DueDate
		end
	end
end
GO
/****** Object:  StoredProcedure [dbo].[spDeleteData]    Script Date: 09/25/2020 01:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spDeleteData]
(
@Id int
)
as begin
set xact_abort on
begin try
	begin tran
		Delete from tblTest where Id = @Id
	commit tran
end try
begin catch
	if xact_state() = -1
	rollback tran
end catch
end
GO
