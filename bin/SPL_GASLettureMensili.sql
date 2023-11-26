CREATE VIEW [dbo].[GASLettureMensili]
AS
SELECT te.NomeIntesta
      -- ,le.idLettura
      -- ,le.idGASFattura
	  ,ft.periodFattDtIniz
	  ,ft.periodFattDtFine
      ,le.LettData
	  ,le.TipoLett
      ,le.Consumofatt
  FROM dbo.GASLettura as le
  INNER JOIN dbo.GASFattura as ft
		 ON ft.idGASFattura=le.idGASFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta
GO

