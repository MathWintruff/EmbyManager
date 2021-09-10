-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Server Status]
Use EmbyManager
CREATE TABLE [Server Status]
(
 [CdServerStatus] tinyint IDENTITY (10, 1) NOT NULL ,
 [NmServerStatus] varchar(30) NOT NULL ,


 CONSTRAINT [PK_Server Status] PRIMARY KEY CLUSTERED ([CdServerStatus] ASC)
);
GO

-- ************************************** [Media Type]

CREATE TABLE [Media Type]
(
 [CdType] tinyint IDENTITY (10, 1) NOT NULL ,
 [NmType] varchar(20) NOT NULL ,


 CONSTRAINT [PK_Media Type] PRIMARY KEY CLUSTERED ([CdType] ASC)
);
GO

-- ************************************** [Media Status]

CREATE TABLE [Media Status]
(
 [CdMediaStatus] tinyint IDENTITY (10, 1) NOT NULL ,
 [NmMediaStatus] varchar(30) NOT NULL ,


 CONSTRAINT [PK_Media Status] PRIMARY KEY CLUSTERED ([CdMediaStatus] ASC)
);
GO

-- ************************************** [Media]

CREATE TABLE [Media]
(
 [CdMedia]          int IDENTITY (1000, 1) NOT NULL ,
 [NmMedia]          varchar(80) NOT NULL ,
 [NmEnMedia]        varchar(80) NOT NULL ,
 [CdType]           tinyint NOT NULL ,
 [CdMediaStatus]    tinyint NOT NULL ,
 [CdServerStatus]   tinyint NOT NULL ,
 [IdMedia]          int NOT NULL ,
 [QtdEpisodesMedia] smallint NOT NULL ,
 [DtMedia]          date NULL ,


 CONSTRAINT [PkMedia] PRIMARY KEY CLUSTERED ([CdMedia] ASC),
 CONSTRAINT [Unique] UNIQUE NONCLUSTERED ([NmEnMedia] ASC, [NmMedia] ASC),
 CONSTRAINT [1/N Media-MediaStatus] FOREIGN KEY ([CdMediaStatus])  REFERENCES [Media Status]([CdMediaStatus]),
 CONSTRAINT [1/N Media-MediaType] FOREIGN KEY ([CdType])  REFERENCES [Media Type]([CdType]),
 CONSTRAINT [1/N Media-ServerStatus] FOREIGN KEY ([CdServerStatus])  REFERENCES [Server Status]([CdServerStatus])
);
GO


CREATE NONCLUSTERED INDEX [PkMediaStatus] ON [Media]
 (
  [CdMediaStatus] ASC
 )

GO

CREATE NONCLUSTERED INDEX [PkServerStatus] ON [Media]
 (
  [CdServerStatus] ASC
 )

GO

CREATE NONCLUSTERED INDEX [PkType] ON [Media]
 (
  [CdType] ASC
 )

GO
