USE [aass]
GO

DROP VIEW [dbo].[EELettureMensili]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[EELettureMensili]
as
SELECT te.NomeIntesta
      ,le.idLettura
      ,le.idEEFattura
      ,dbo.toAnnoMese(le.LettDtPrec) as lettDtPrec
	  ,le.TipoLettura
      ,le.LettPrec
      ,dbo.toAnnoMese(le.LettDtAttuale) as lettDtAttuale
      ,le.LettAttuale
      ,le.LettConsumo
  FROM dbo.EELettura as le
  INNER JOIN dbo.EEFattura as ft
		 ON ft.idEEFattura=le.idEEFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta
GO
