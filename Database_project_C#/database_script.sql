USE [master]
GO
/****** Object:  Database [PV_project]    Script Date: 15.03.2023 23:42:47 ******/
CREATE DATABASE [PV_project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PV_project', FILENAME = N'D:\School\MSSQL16.MSSQLSERVER\MSSQL\DATA\PV_project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PV_project_log', FILENAME = N'D:\School\MSSQL16.MSSQLSERVER\MSSQL\DATA\PV_project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PV_project] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PV_project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PV_project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PV_project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PV_project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PV_project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PV_project] SET ARITHABORT OFF 
GO
ALTER DATABASE [PV_project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PV_project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PV_project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PV_project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PV_project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PV_project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PV_project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PV_project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PV_project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PV_project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PV_project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PV_project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PV_project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PV_project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PV_project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PV_project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PV_project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PV_project] SET RECOVERY FULL 
GO
ALTER DATABASE [PV_project] SET  MULTI_USER 
GO
ALTER DATABASE [PV_project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PV_project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PV_project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PV_project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PV_project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PV_project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PV_project', N'ON'
GO
ALTER DATABASE [PV_project] SET QUERY_STORE = ON
GO
ALTER DATABASE [PV_project] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PV_project]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 15.03.2023 23:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[SenderId] [int] NOT NULL,
	[Subject] [nvarchar](100) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[receiverId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipients]    Script Date: 15.03.2023 23:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipients](
	[RecipientId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[MessageId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecipientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 15.03.2023 23:42:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserPassword] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Unique_UserName] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Unique_UserPassword] UNIQUE NONCLUSTERED 
(
	[UserPassword] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users_SenderId] FOREIGN KEY([SenderId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users_SenderId]
GO
ALTER TABLE [dbo].[Recipients]  WITH CHECK ADD  CONSTRAINT [FK_Recipients_Messages_MessageId] FOREIGN KEY([MessageId])
REFERENCES [dbo].[Messages] ([MessageId])
GO
ALTER TABLE [dbo].[Recipients] CHECK CONSTRAINT [FK_Recipients_Messages_MessageId]
GO
ALTER TABLE [dbo].[Recipients]  WITH CHECK ADD  CONSTRAINT [FK_Recipients_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Recipients] CHECK CONSTRAINT [FK_Recipients_Users_UserId]
GO
USE [master]
GO
ALTER DATABASE [PV_project] SET  READ_WRITE 
GO
