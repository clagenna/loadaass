USE aass
GO

DROP VIEW IF EXISTS dbo.GASConsumoMensile
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW dbo.GASConsumoMensile
AS
SELECT te.NomeIntesta 
      ,cs.idGASFattura
      ,dbo.toAnnoMese(cs.dtIniz) as dtIniz
      ,dbo.toAnnoMese(cs.dtFine) as dtFine
	  ,DATEDIFF(d,cs.dtIniz, cs.dtFine) + 1 as qtaGG
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
      ,cs.quantita / (DATEDIFF(d,cs.dtIniz, cs.dtFine) + 1 ) as mediaGG
      ,cs.importo
  FROM aass.dbo.GASConsumo as cs
	  INNER JOIN dbo.GASFattura as ft
		 ON ft.idGASFattura=cs.idGASFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta

GO
