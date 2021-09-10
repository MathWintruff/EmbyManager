USE EmbyManager

GO
CREATE PROCEDURE
AddGenericInformation
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
CREATE PROCEDURE
GetGenericInformation
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
CREATE PROCEDURE
AddMedia
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
CREATE PROCEDURE
GetMedia As SELECT * FROM ViewMedia;


GO
CREATE PROCEDURE
SearchMediaFiltered
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
CREATE PROCEDURE
RemoveMedia @DboCode int AS DELETE FROM Media WHERE CdMedia = @DboCode;

GO
CREATE PROCEDURE
UpdateMedia
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
