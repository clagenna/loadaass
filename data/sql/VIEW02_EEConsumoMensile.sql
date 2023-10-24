USE [aass]
GO

DROP VIEW [dbo].[EEConsumoMensile]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[EEConsumoMensile]
AS
SELECT te.NomeIntesta 
      ,cs.idEEFattura
      ,dbo.toAnnoMese(cs.dtIniz) as dtIniz
	  ,dbo.EESumLettAttuale(cs.idEEFattura) as totLett
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
      ,cs.importo
  FROM aass.dbo.EEConsumo as cs
	  INNER JOIN dbo.EEFattura as ft
		 ON ft.idEEFattura=cs.idEEFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta
  WHERE dbo.EESumLettAttuale(cs.idEEFattura) > 0
GO
