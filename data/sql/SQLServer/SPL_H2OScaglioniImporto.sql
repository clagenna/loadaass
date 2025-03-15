CREATE VIEW [dbo].[H2OScaglioniImporto]
AS
SELECT NomeIntesta
     , idH2OFattura
	 , YEAR(dtIniz) as annoComp
     , dtIniz	
     , dtFine
	 , qtaGG
	 , ISNULL(S1,0) AS Scagl1
	 , ISNULL(S2,0) AS Scagl2
	 , ISNULL(S3,0) AS Scagl3
	 , ISNULL(S4,0) AS Scagl4
	 , ISNULL(F,0) AS Amb
	 , ISNULL(S1,0) +
	   ISNULL(S2,0) +
	   ISNULL(S3,0) +
	   ISNULL(S4,0) +
	   ISNULL(F,0) AS Totale
	 --, (ISNULL(G1,0) +
	 --  ISNULL(G2,0) +
	 --  ISNULL(G3,0) ) / qtaGG as mediaGG
  FROM (
	SELECT NomeIntesta
	     , idH2OFattura
		 , tipoSpesa
		 , dtIniz
		 , dtFine
		 , (DATEDIFF(d, dtIniz, dtFine) + 1) as qtaGG
		 , ISNULL(importo, 0) as importo
     FROM 	dbo.H2OConsumoMensile
) consunit PIVOT (
  SUM(importo)
  FOR tipoSpesa in ( S1, S2, S3, S4, F )
) AS pivCons

GO

