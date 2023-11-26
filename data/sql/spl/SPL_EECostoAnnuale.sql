CREATE VIEW [dbo].[EECostoAnnuale]
AS
SELECT * FROM (
SELECT NomeIntesta
      ,anno
      ,totAnno
  FROM aass.dbo.EEConsumoAnnuo
) pvtanno PIVOT (
   SUM(totAnno)
   FOR nomeIntesta IN ( alessandro, andrea, claudio )
) as pvt
GO

