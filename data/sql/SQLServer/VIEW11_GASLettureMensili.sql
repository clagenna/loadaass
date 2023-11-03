USE aass
GO

DROP VIEW IF EXISTS dbo.GASLettureMensili
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.GASLettureMensili
AS
SELECT te.NomeIntesta
      -- ,le.idLettura
      -- ,le.idGASFattura
	  ,dbo.toAnnoMese(ft.periodFattDtIniz) as dtFattIniz
	  ,dbo.toAnnoMese(ft.periodFattDtFine) as dtFattFine
      ,dbo.toAnnoMese(le.LettData) as lettDtPrec
	  ,le.TipoLett
      ,le.Consumofatt
  FROM dbo.GASLettura as le
  INNER JOIN dbo.GASFattura as ft
		 ON ft.idGASFattura=le.idGASFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta
GO
