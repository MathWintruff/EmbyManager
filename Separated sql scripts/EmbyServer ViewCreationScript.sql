GO
CREATE VIEW ViewMedia AS
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
