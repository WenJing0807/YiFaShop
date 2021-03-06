USE [master]
GO
/****** Object:  Database [YiFaDB]    Script Date: 2022/4/6 下午 10:29:53 ******/
CREATE DATABASE [YiFaDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YiFaDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\YiFaDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'YiFaDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\YiFaDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [YiFaDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YiFaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YiFaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YiFaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YiFaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YiFaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YiFaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [YiFaDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YiFaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YiFaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YiFaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YiFaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YiFaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YiFaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YiFaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YiFaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YiFaDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YiFaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YiFaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YiFaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YiFaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YiFaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YiFaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YiFaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YiFaDB] SET RECOVERY FULL 
GO
ALTER DATABASE [YiFaDB] SET  MULTI_USER 
GO
ALTER DATABASE [YiFaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YiFaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YiFaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YiFaDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [YiFaDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [YiFaDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'YiFaDB', N'ON'
GO
ALTER DATABASE [YiFaDB] SET QUERY_STORE = OFF
GO
USE [YiFaDB]
GO
/****** Object:  Table [dbo].[tAdmin]    Script Date: 2022/4/6 下午 10:29:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAdmin](
	[fId] [int] IDENTITY(1,1) NOT NULL,
	[fAdminId] [nvarchar](50) NULL,
	[fPwd] [nvarchar](50) NULL,
	[fName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tAdmin] PRIMARY KEY CLUSTERED 
(
	[fId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tMember]    Script Date: 2022/4/6 下午 10:29:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tMember](
	[fId] [int] IDENTITY(1,1) NOT NULL,
	[fUserId] [nvarchar](50) NULL,
	[fPwd] [nvarchar](50) NULL,
	[fName] [nvarchar](50) NULL,
	[fEmail] [nvarchar](50) NULL,
 CONSTRAINT [PK_tMember] PRIMARY KEY CLUSTERED 
(
	[fId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tOrder]    Script Date: 2022/4/6 下午 10:29:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tOrder](
	[fId] [int] IDENTITY(1,1) NOT NULL,
	[fOrderGuid] [nvarchar](50) NULL,
	[fUserId] [nvarchar](50) NULL,
	[fReceiver] [nvarchar](50) NULL,
	[fEmail] [nvarchar](50) NULL,
	[fAddress] [nvarchar](100) NULL,
	[fDate] [datetime] NOT NULL,
	[fStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_tOrder] PRIMARY KEY CLUSTERED 
(
	[fId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tOrderDetail]    Script Date: 2022/4/6 下午 10:29:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tOrderDetail](
	[fId] [int] IDENTITY(1,1) NOT NULL,
	[fOrderGuid] [nvarchar](50) NULL,
	[fUserId] [nvarchar](50) NULL,
	[fPId] [nvarchar](50) NULL,
	[fName] [nvarchar](50) NULL,
	[fPrice] [int] NULL,
	[fQty] [int] NULL,
	[fIsApproved] [nvarchar](50) NULL,
 CONSTRAINT [PK_tOrderDetail] PRIMARY KEY CLUSTERED 
(
	[fId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tProduct]    Script Date: 2022/4/6 下午 10:29:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tProduct](
	[fId] [int] IDENTITY(1,1) NOT NULL,
	[fPId] [nvarchar](50) NULL,
	[fName] [nvarchar](50) NULL,
	[fPrice] [int] NOT NULL,
	[fImg] [nvarchar](50) NULL,
 CONSTRAINT [PK_tProduct] PRIMARY KEY CLUSTERED 
(
	[fId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tAdmin] ON 

INSERT [dbo].[tAdmin] ([fId], [fAdminId], [fPwd], [fName]) VALUES (1, N'phoebe0807', N'phoebe1211', N'Phoebe')
SET IDENTITY_INSERT [dbo].[tAdmin] OFF
GO
SET IDENTITY_INSERT [dbo].[tMember] ON 

INSERT [dbo].[tMember] ([fId], [fUserId], [fPwd], [fName], [fEmail]) VALUES (1, N'chen123', N'chenchen', N'Phoebe', N'phoebe@gmail.com')
INSERT [dbo].[tMember] ([fId], [fUserId], [fPwd], [fName], [fEmail]) VALUES (2, N'jack123', N'12345', N'Jack', N'jack@gmail.com')
SET IDENTITY_INSERT [dbo].[tMember] OFF
GO
SET IDENTITY_INSERT [dbo].[tOrder] ON 

INSERT [dbo].[tOrder] ([fId], [fOrderGuid], [fUserId], [fReceiver], [fEmail], [fAddress], [fDate], [fStatus]) VALUES (1, N'b12100be-81f1-4d9c-8f4f-e248030be0eb', N'chen123', N'陳玟靜', N'qunphoe0807@gmail.com', N'國盛四街50號', CAST(N'2022-03-30T20:04:56.137' AS DateTime), N'未處理')
INSERT [dbo].[tOrder] ([fId], [fOrderGuid], [fUserId], [fReceiver], [fEmail], [fAddress], [fDate], [fStatus]) VALUES (2, N'b3abe54c-3124-49ea-9eb5-b48cfede018b', N'chen123', N'陳玟靜', N'qunphoe0807@gmail.com', N'國盛四街50號', CAST(N'2022-04-04T14:16:10.373' AS DateTime), N'已完成')
INSERT [dbo].[tOrder] ([fId], [fOrderGuid], [fUserId], [fReceiver], [fEmail], [fAddress], [fDate], [fStatus]) VALUES (3, N'f2d4ff7c-50bd-44ef-8334-f3de47b01d19', N'chen123', N'Jack', N'jack@gmail.com', N'高雄市前金區', CAST(N'2022-04-04T15:51:22.880' AS DateTime), N'已完成')
INSERT [dbo].[tOrder] ([fId], [fOrderGuid], [fUserId], [fReceiver], [fEmail], [fAddress], [fDate], [fStatus]) VALUES (4, N'60480b7c-d2d7-419b-855c-735dc6efa257', N'jack123', N'Jack', N'jack@gmail.com', N'高雄市前金區', CAST(N'2022-04-04T16:50:42.513' AS DateTime), N'未處理')
INSERT [dbo].[tOrder] ([fId], [fOrderGuid], [fUserId], [fReceiver], [fEmail], [fAddress], [fDate], [fStatus]) VALUES (5, N'53a3ba84-e4d2-4736-9224-a16ad33ecb07', N'jack123', N'Jack', N'jack@gmail.com', N'高雄市前金區', CAST(N'2022-04-04T17:00:31.093' AS DateTime), N'已完成')
INSERT [dbo].[tOrder] ([fId], [fOrderGuid], [fUserId], [fReceiver], [fEmail], [fAddress], [fDate], [fStatus]) VALUES (6, N'dbf994e5-743a-43e1-9fc6-b0b681238b36', N'jack123', N'Jack', N'jack@gmail.com', N'高雄市前金區', CAST(N'2022-04-04T17:04:41.500' AS DateTime), N'未處理')
SET IDENTITY_INSERT [dbo].[tOrder] OFF
GO
SET IDENTITY_INSERT [dbo].[tOrderDetail] ON 

INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (1, N'b12100be-81f1-4d9c-8f4f-e248030be0eb', N'chen123', N'6', N'皮蛋', 60, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (2, N'b12100be-81f1-4d9c-8f4f-e248030be0eb', N'chen123', N'5', N'鹹蛋', 45, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (3, N'b3abe54c-3124-49ea-9eb5-b48cfede018b', N'chen123', N'2', N'紅蛋', 43, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (6, N'f2d4ff7c-50bd-44ef-8334-f3de47b01d19', N'chen123', N'3', N'有機紅仁蛋', 50, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (7, N'f2d4ff7c-50bd-44ef-8334-f3de47b01d19', N'chen123', N'6', N'皮蛋', 60, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (8, N'f2d4ff7c-50bd-44ef-8334-f3de47b01d19', N'chen123', N'5', N'鹹蛋', 45, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (9, N'60480b7c-d2d7-419b-855c-735dc6efa257', N'jack123', N'6', N'皮蛋', 60, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (10, N'60480b7c-d2d7-419b-855c-735dc6efa257', N'jack123', N'7', N'鹹鴨蛋', 52, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (11, N'60480b7c-d2d7-419b-855c-735dc6efa257', N'jack123', N'3', N'有機紅仁蛋', 50, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (12, N'53a3ba84-e4d2-4736-9224-a16ad33ecb07', N'jack123', N'2', N'紅蛋', 43, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (13, N'53a3ba84-e4d2-4736-9224-a16ad33ecb07', N'jack123', N'1', N'白蛋', 40, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (14, N'dbf994e5-743a-43e1-9fc6-b0b681238b36', N'jack123', N'4', N'土雞蛋', 55, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (15, N'dbf994e5-743a-43e1-9fc6-b0b681238b36', N'jack123', N'1', N'白蛋', 40, 1, N'是')
INSERT [dbo].[tOrderDetail] ([fId], [fOrderGuid], [fUserId], [fPId], [fName], [fPrice], [fQty], [fIsApproved]) VALUES (16, N'dbf994e5-743a-43e1-9fc6-b0b681238b36', N'jack123', N'5', N'鹹蛋', 45, 1, N'是')
SET IDENTITY_INSERT [dbo].[tOrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[tProduct] ON 

INSERT [dbo].[tProduct] ([fId], [fPId], [fName], [fPrice], [fImg]) VALUES (1, N'1', N'白蛋', 40, N'1.jpg')
INSERT [dbo].[tProduct] ([fId], [fPId], [fName], [fPrice], [fImg]) VALUES (2, N'2', N'紅蛋', 43, N'2.jpg')
INSERT [dbo].[tProduct] ([fId], [fPId], [fName], [fPrice], [fImg]) VALUES (3, N'3', N'有機紅仁蛋', 50, N'3.jpg')
INSERT [dbo].[tProduct] ([fId], [fPId], [fName], [fPrice], [fImg]) VALUES (4, N'4', N'土雞蛋', 55, N'4.jpg')
INSERT [dbo].[tProduct] ([fId], [fPId], [fName], [fPrice], [fImg]) VALUES (5, N'5', N'鹹蛋', 45, N'5.jpg')
INSERT [dbo].[tProduct] ([fId], [fPId], [fName], [fPrice], [fImg]) VALUES (6, N'6', N'皮蛋', 60, N'6.jpg')
INSERT [dbo].[tProduct] ([fId], [fPId], [fName], [fPrice], [fImg]) VALUES (7, N'7', N'鹹鴨蛋', 52, N'7.jpg')
SET IDENTITY_INSERT [dbo].[tProduct] OFF
GO
USE [master]
GO
ALTER DATABASE [YiFaDB] SET  READ_WRITE 
GO
