CREATE VIEW [dbo].[GASScaglioniImporto]
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
	 --, (ISNULL(G1,0) +
	 --  ISNULL(G2,0) +
	 --  ISNULL(G3,0) ) / qtaGG as mediaGG
  FROM (
	SELECT NomeIntesta
	     , idGASFattura
		 , tipoSpesa
		 , dtIniz
		 , dtFine
		 , (DATEDIFF(d, dtIniz, dtFine) + 1) as qtaGG
		 , ISNULL(importo, 0) as importo
     FROM 	dbo.GASConsumoMensile
) consunit PIVOT (
  SUM(importo)
  FOR tipoSpesa in ( G1, G2, G3 )
) AS pivCons

GO

