CREATE VIEW [dbo].[H2OConsumoAnnuo]
AS
SELECT NomeIntesta
      ,YEAR(dtIniz) as annoComp
      ,SUM(importo) as totAnno
  FROM aass.dbo.H2OConsumoMensile
GROUP BY NomeIntesta, YEAR(dtIniz) 
GO

