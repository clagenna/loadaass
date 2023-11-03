USE [aass]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GASScaglioniImporto]
AS
SELECT * FROM (
	SELECT cs.tipoSpesa,
	       cs.dtIniz,
		   cs.importo
	  FROM dbo.GASConsumo as cs
	  WHERE cs.tipoSpesa in ( 'G1','G2','G3', 'R' )
 ) consunit  PIVOT (
	SUM(importo)
	FOR tipoSpesa in ( [G1],[G2], [G3], [R] )
 ) AS pivot_cons
GO
