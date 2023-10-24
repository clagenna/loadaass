USE aass
GO

DROP VIEW IF EXISTS dbo.GASScaglioniImporto
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.GASScaglioniImporto
AS
SELECT NomeIntesta	
     , dtIniz	
	 , qtaMesi
	 , ISNULL(G1,0) AS Scagl1
	 , ISNULL(G2,0) AS Scagl2
	 , ISNULL(G3,0) AS Scagl3
	 , ISNULL(G1,0) +
	   ISNULL(G2,0) +
	   ISNULL(G3,0) AS Totale
  FROM (

	SELECT te.NomeIntesta
		 , tipoSpesa
		 , dbo.toAnnoMese(cs.dtIniz) as dtIniz
		 , DATEDIFF(m, cs.dtIniz, cs.dtFine) as qtaMesi
		 , ISNULL(cs.importo, 0) as importo
	  FROM dbo.GASConsumo AS cs
		INNER JOIN dbo.GASFattura as ft
			ON ft.idGASFattura=cs.idGASFattura
		INNER JOIN dbo.intesta as te
			ON ft.idIntesta=te.idIntesta
) consunit PIVOT (
  SUM(importo)
  FOR tipoSpesa in ( G1, G2, G3 )
) AS pivCons

GO

SELECT TOP (1000) NomeIntesta
      ,dtIniz
	  ,qtaMesi
      ,Scagl1
      ,Scagl2
      ,Scagl3
      ,Totale
	  ,CASE
		 WHEN qtaMesi = 0 THEN Totale
		 ELSE Totale / qtaMesi
	   END as mediaMens
  FROM aass.dbo.GASScaglioniImporto
ORDER BY NomeIntesta, dtIniz