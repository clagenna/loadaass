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
     , idGASFattura
     , dtIniz	
     , dtFine
	 , qtaGG
	 , ISNULL(G1,0) AS Scagl1
	 , ISNULL(G2,0) AS Scagl2
	 , ISNULL(G3,0) AS Scagl3
	 , ISNULL(G1,0) +
	   ISNULL(G2,0) +
	   ISNULL(G3,0) AS Totale
	 , (ISNULL(G1,0) +
	   ISNULL(G2,0) +
	   ISNULL(G3,0) ) / qtaGG as mediaGG
  FROM (
  	SELECT te.NomeIntesta
	     , cs.idGASFattura
		 , tipoSpesa
		 , cs.dtIniz
		 , cs.dtFine
		 , (DATEDIFF(d, cs.dtIniz, cs.dtFine) + 1) as qtaGG
		 , ISNULL(cs.importo, 0) as importo
	  FROM dbo.GASConsumo AS cs
		INNER JOIN dbo.GASFattura as ft
			ON ft.idGASFattura=cs.idGASFattura
		INNER JOIN dbo.intesta as te
			ON ft.idIntesta=te.idIntesta
    WHERE cs.dtIniz BETWEEN ft.periodCongDtIniz and ft.periodCongDtFine
	  AND cs.dtFine BETWEEN ft.periodCongDtIniz and ft.periodCongDtFine
) consunit PIVOT (
  SUM(importo)
  FOR tipoSpesa in ( G1, G2, G3 )
) AS pivCons

GO

DECLARE @nome varchar(32) = 'andrea',
        @dtRif date       = '2020-12-16'

SELECT TOP (1000) NomeIntesta
      ,dtIniz
	  ,qtaGG
      ,Scagl1
      ,Scagl2
      ,Scagl3
      ,Totale
	  ,( Totale / qtaGG )  as mediaMens
  FROM aass.dbo.GASScaglioniImporto
  WHERE 1=1
    AND NomeIntesta = @nome
    --AND @dtRif between dtIniz and dtFine
ORDER BY NomeIntesta, dtIniz


