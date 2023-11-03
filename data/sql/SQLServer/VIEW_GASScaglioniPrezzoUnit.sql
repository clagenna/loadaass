USE [aass]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GASScaglioniPrezzoUnit]
AS
SELECT * FROM (
	SELECT cs.tipoSpesa,
	       cs.dtIniz,
		   cs.prezzoUnit
	  FROM dbo.GASConsumo as cs
	  WHERE cs.tipoSpesa in ( 'G1','G2','G3' )
 ) consunit  PIVOT (
	SUM(prezzoUnit)
	FOR tipoSpesa in ( [G1],[G2], [G3] )
 ) AS pivot_cons
GO
