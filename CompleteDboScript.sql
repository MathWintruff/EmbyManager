USE [master]
GO
/****** Object:  Database [EmbyManager]    Script Date: 11/17/2019 23:17:15 ******/
CREATE DATABASE [EmbyManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmbyManager', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DUODEBUGSQLSERVER\MSSQL\DATA\EmbyManager.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EmbyManager_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DUODEBUGSQLSERVER\MSSQL\DATA\EmbyManager_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EmbyManager] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmbyManager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmbyManager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmbyManager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmbyManager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmbyManager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmbyManager] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmbyManager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmbyManager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmbyManager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmbyManager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmbyManager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmbyManager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmbyManager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmbyManager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmbyManager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmbyManager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmbyManager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmbyManager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmbyManager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmbyManager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmbyManager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmbyManager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmbyManager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmbyManager] SET RECOVERY FULL 
GO
ALTER DATABASE [EmbyManager] SET  MULTI_USER 
GO
ALTER DATABASE [EmbyManager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmbyManager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmbyManager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmbyManager] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmbyManager] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmbyManager', N'ON'
GO
ALTER DATABASE [EmbyManager] SET QUERY_STORE = OFF
GO
USE [EmbyManager]
GO
/****** Object:  User [Manager]    Script Date: 11/17/2019 23:17:16 ******/
CREATE USER [Manager] FOR LOGIN [Manager] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Manager]
GO
/****** Object:  Table [dbo].[Server Status]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Server Status](
	[CdServerStatus] [tinyint] IDENTITY(10,1) NOT NULL,
	[NmServerStatus] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Server Status] PRIMARY KEY CLUSTERED 
(
	[CdServerStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Media Type]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media Type](
	[CdType] [tinyint] IDENTITY(10,1) NOT NULL,
	[NmType] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Media Type] PRIMARY KEY CLUSTERED 
(
	[CdType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Media Status]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media Status](
	[CdMediaStatus] [tinyint] IDENTITY(10,1) NOT NULL,
	[NmMediaStatus] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Media Status] PRIMARY KEY CLUSTERED 
(
	[CdMediaStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Media]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media](
	[CdMedia] [int] IDENTITY(1000,1) NOT NULL,
	[NmMedia] [varchar](80) NOT NULL,
	[NmEnMedia] [varchar](80) NOT NULL,
	[CdType] [tinyint] NOT NULL,
	[CdMediaStatus] [tinyint] NOT NULL,
	[CdServerStatus] [tinyint] NOT NULL,
	[IdMedia] [int] NOT NULL,
	[QtdEpisodesMedia] [smallint] NOT NULL,
	[DtMedia] [date] NULL,
 CONSTRAINT [PkMedia] PRIMARY KEY CLUSTERED 
(
	[CdMedia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Unique] UNIQUE NONCLUSTERED 
(
	[NmEnMedia] ASC,
	[NmMedia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewMedia]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewMedia] AS
  SELECT
    CdMedia AS [Dbo Code],
    NmMedia AS Tittle,
    NmEnMedia AS [English Tittle],
    NmType AS [Media Type],
    NmMediaStatus AS [Status],
    NmServerStatus AS [Server Status],
    IdMedia AS [Id Code],
    QtdEpisodesMedia AS [Qtd Episodes],
    DtMedia AS [Release Date]

  FROM Media
    INNER JOIN [Media Type] ON Media.CdType = [Media Type].CdType
    INNER JOIN [Media Status] ON Media.CdMediaStatus = [Media Status].CdMediaStatus
    INNER JOIN [Server Status] ON Media.CdServerStatus = [Server Status].CdServerStatus;
GO
/****** Object:  Index [PkMediaStatus]    Script Date: 11/17/2019 23:17:16 ******/
CREATE NONCLUSTERED INDEX [PkMediaStatus] ON [dbo].[Media]
(
	[CdMediaStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PkServerStatus]    Script Date: 11/17/2019 23:17:16 ******/
CREATE NONCLUSTERED INDEX [PkServerStatus] ON [dbo].[Media]
(
	[CdServerStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PkType]    Script Date: 11/17/2019 23:17:16 ******/
CREATE NONCLUSTERED INDEX [PkType] ON [dbo].[Media]
(
	[CdType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [1/N Media-MediaStatus] FOREIGN KEY([CdMediaStatus])
REFERENCES [dbo].[Media Status] ([CdMediaStatus])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [1/N Media-MediaStatus]
GO
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [1/N Media-MediaType] FOREIGN KEY([CdType])
REFERENCES [dbo].[Media Type] ([CdType])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [1/N Media-MediaType]
GO
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [1/N Media-ServerStatus] FOREIGN KEY([CdServerStatus])
REFERENCES [dbo].[Server Status] ([CdServerStatus])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [1/N Media-ServerStatus]
GO
/****** Object:  StoredProcedure [dbo].[AddGenericInformation]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
[dbo].[AddGenericInformation]
  @InformationCode varchar(2),
  @InformationLabel VarChar(30) AS
    BEGIN
      IF(@InformationCode = 'MT')
        BEGIN
          INSERT INTO [Media Type] VALUES(@InformationLabel)
        END
      IF(@InformationCode = 'MS')
        BEGIN
          INSERT INTO [Media Status] VALUES(@InformationLabel)
        END
      IF(@InformationCode = 'SS')
        BEGIN
          INSERT INTO [Server Status] VALUES(@InformationLabel)
        END
    END;


GO
/****** Object:  StoredProcedure [dbo].[AddMedia]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
[dbo].[AddMedia]
  @Name varchar(80),
  @EnName VarChar(80),
  @CodType TinyInt,
  @CodStatus TinyInt,
  @CodServerStatus TinyInt,
  @IdNum int,
  @QtdEpisodes smallint,
  @ReDate date AS
    BEGIN
      INSERT INTO Media VALUES(@Name, @EnName, @CodType, @CodStatus, @CodServerStatus, @IdNum, @QtdEpisodes, @ReDate)
    END;

GO
/****** Object:  StoredProcedure [dbo].[GetGenericInformation]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
[dbo].[GetGenericInformation]
  @InformationCode varchar(2) AS
    BEGIN
      IF(@InformationCode = 'MT')
        BEGIN
          SELECT CdType AS [Media Type Code], NmType AS [Media Type Name] FROM [Media Type];
        END
      IF(@InformationCode = 'MS')
        BEGIN
          SELECT CdMediaStatus AS [Media Status Code], NmMediaStatus AS [Media Status Name] FROM [Media Status];
        END
      IF(@InformationCode = 'SS')
        BEGIN
          SELECT CdServerStatus AS [Server Status Code], NmServerStatus AS [Server Status Name] FROM [Server Status];
        END
    END;


GO
/****** Object:  StoredProcedure [dbo].[GetMedia]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
[dbo].[GetMedia] As SELECT * FROM ViewMedia;


GO
/****** Object:  StoredProcedure [dbo].[RemoveMedia]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
[dbo].[RemoveMedia] @DboCode int AS DELETE FROM Media WHERE CdMedia = @DboCode;

GO
/****** Object:  StoredProcedure [dbo].[SearchMediaFiltered]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
[dbo].[SearchMediaFiltered]
  @Name varchar(80) = '',
  @CodType TinyInt = 0,
  @CodStatus TinyInt = 0,
  @CodServerStatus TinyInt = 0,
  @ReDate date = NULL AS
    BEGIN
  	  SELECT * INTO TempTable FROM Media
      SELECT * INTO FilteredByName FROM TempTable WHERE (NmMedia LIKE '%'+@Name+'%')
  	  DROP TABLE TempTable
  	  SELECT * INTO TempTable FROM FilteredByName
  	  DROP TABLE FilteredByName

      IF(@CodType > 9)
    		BEGIN
    			SELECT * INTO FilteredByType FROM TempTable WHERE CdType = @CodType
    			DROP TABLE TempTable
    			SELECT * INTO TempTable FROM FilteredByType
    			DROP TABLE FilteredByType
    		END

      IF(@CodStatus > 9)
    		BEGIN
    			SELECT * INTO FilteredByStatus FROM TempTable WHERE CdMediaStatus = @CodStatus
    			DROP TABLE TempTable
    			SELECT * INTO TempTable FROM FilteredByStatus
    			DROP TABLE FilteredByStatus
    		END

      IF(@CodServerStatus > 9)
    		BEGIN
    			SELECT * INTO FilteredByServerStatus FROM TempTable WHERE CdServerStatus = @CodServerStatus
    			DROP TABLE TempTable
    			SELECT * INTO TempTable FROM FilteredByServerStatus
    			DROP TABLE FilteredByServerStatus
    		END

      IF(@ReDate <> NULL)
    		BEGIN
    			SELECT * INTO FilteredByDate FROM TempTable WHERE YEAR(DtMedia) = YEAR(@ReDate) AND MONTH(DtMedia) = MONTH(@ReDate)
    			DROP TABLE TempTable
    			SELECT * INTO TempTable FROM FilteredByDate
    			DROP TABLE FilteredByDate
    		END

      SELECT
        CdMedia AS [Dbo Code],
        NmMedia AS Tittle,
        NmEnMedia AS [English Tittle],
        NmType AS [Media Type],
        NmMediaStatus AS [Status],
        NmServerStatus AS [Server Status],
        IdMedia AS [Id Code],
        QtdEpisodesMedia AS [Qts Episodes],
        DtMedia AS [Release Date]
        FROM TempTable
        INNER JOIN [Media Type] ON TempTable.CdType = [Media Type].CdType
        INNER JOIN [Media Status] ON TempTable.CdMediaStatus = [Media Status].CdMediaStatus
        INNER JOIN [Server Status] ON TempTable.CdServerStatus = [Server Status].CdServerStatus

      DROP TABLE TempTable
    END;


GO
/****** Object:  StoredProcedure [dbo].[UpdateMedia]    Script Date: 11/17/2019 23:17:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
[dbo].[UpdateMedia]
  @DboCode int,
  @Name varchar(80),
  @EnName VarChar(80),
  @CodType TinyInt,
  @CodStatus TinyInt,
  @CodServerStatus TinyInt,
  @IdNum int,
  @QtdEpisodes smallint,
  @ReDate date AS
    BEGIN
      UPDATE Media SET
      NmMedia = @Name,
      NmEnMedia = @EnName,
      CdType = @CodType,
      IdMedia = @IdNum,
      QtdEpisodesMedia = @QtdEpisodes,
      DtMedia = @ReDate,
      CdMediaStatus = @CodStatus,
      CdServerStatus = @CodServerStatus
    WHERE CdMedia = @DboCode;
    END;

GO
USE [master]
GO
ALTER DATABASE [EmbyManager] SET  READ_WRITE 
GO
