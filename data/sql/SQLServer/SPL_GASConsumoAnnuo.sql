CREATE VIEW [dbo].[GASConsumoAnnuo]
AS
SELECT NomeIntesta
      ,YEAR(dtIniz) as annoComp
      ,SUM(importo) as totAnno
  FROM aass.dbo.GASConsumoMensile
GROUP BY NomeIntesta, YEAR(dtIniz) 
GO

