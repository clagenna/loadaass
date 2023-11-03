USE [aass]
GO

DROP VIEW [dbo].[EEConsumoAnnuo]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[EEConsumoAnnuo]
AS
SELECT NomeIntesta
      ,CAST(dtIniz as int) as anno
      ,SUM(importo) as totAnno
  FROM aass.dbo.EEConsumoMensile
GROUP BY NomeIntesta, CAST(dtIniz as int)
GO
