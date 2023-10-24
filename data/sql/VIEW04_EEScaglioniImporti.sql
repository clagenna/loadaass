USE aass
GO

DROP VIEW dbo.EEScaglioniImporti
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view dbo.EEScaglioniImporti
AS
SELECT 
	NomeIntesta,
	dtIniz,
	ISNULL(E1, 0) AS EESca1,
	ISNULL(E2, 0) AS EESca2,
	ISNULL(E3, 0) AS EESca3,
	ISNULL(S1, 0) AS EESpreadSca1,
	ISNULL(S2, 0) AS EESpreadSca2,
	ISNULL(PU, 0) AS EEPun,
	ISNULL(R,  0) AS Rifiuti,
	ISNULL(P,  0) AS ImpegnoPot,
	ISNULL(E1, 0) +
	ISNULL(E2, 0) +
	ISNULL(E3, 0) +
	ISNULL(S1, 0) +
	ISNULL(S2, 0) +
	ISNULL(PU, 0) +
	ISNULL(R,  0) +
	ISNULL(P,  0)  AS TotRiga
 FROM (
	SELECT te.NomeIntesta,
	       cs.tipoSpesa,
		   dbo.toAnnoMese(cs.dtIniz) as dtIniz,
		   ISNULL(cs.importo, 0) as importo
	  FROM dbo.EEConsumo as cs
	    INNER JOIN dbo.EEFattura as ft
        ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN dbo.intesta as te
        ON ft.idIntesta=te.idIntesta
	  WHERE cs.tipoSpesa in ( 'E1','E2','E3', 'S1','S2','PU', 'R', 'P' )
	    AND dbo.EESumLettAttuale(cs.idEEFattura) > 0
 ) consunit  PIVOT (
	SUM(importo)
	FOR tipoSpesa in ( E1,E2, E3, S1, S2, PU,  R, P )
 ) AS pivot_cons
GO


