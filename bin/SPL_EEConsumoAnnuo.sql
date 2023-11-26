CREATE VIEW [dbo].[EEConsumoAnnuo]
AS
SELECT NomeIntesta
      ,CAST(dtIniz as int) as annoComp
      ,SUM(importo) as totAnno
  FROM aass.dbo.EEConsumoMensile
GROUP BY NomeIntesta, CAST(dtIniz as int)
GO

