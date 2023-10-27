
-- =============================================
-- Author:		Claudio
-- Create date: 16/10/2023
-- Description:	sum delle letture attuale per idFattura
-- =============================================
CREATE FUNCTION EESumLettAttuale ( @p1 int )
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT @result = sum(le.lettAttuale) 
	  FROM EELettura as le
     WHERE idEEFattura = @p1

	RETURN @Result

END
;

-- =============================================
-- Author:		Claudio
-- Create date: 16/10/23
-- Description:	converte Date in un decimal(6,2) per anno,mese
-- =============================================
CREATE FUNCTION toAnnoMese ( @p1 date )
RETURNS decimal(6,2)
AS
BEGIN
	DECLARE @Result decimal(6,2) =	CONVERT(decimal(6,2), cast(year(@p1) as float) + cast(datepart(M,@p1) as float) / 100) 
	RETURN @Result
END
;

CREATE VIEW EELettureMensili
as
SELECT te.NomeIntesta
      ,le.idLettura
      ,le.idEEFattura
      ,toAnnoMese(le.LettDtPrec) as lettDtPrec
	  ,le.TipoLettura
      ,le.LettPrec
      ,toAnnoMese(le.LettDtAttuale) as lettDtAttuale
      ,le.LettAttuale
      ,le.LettConsumo
  FROM EELettura as le
  INNER JOIN EEFattura as ft
		 ON ft.idEEFattura=le.idEEFattura
	  INNER JOIN intesta as te
		 ON ft.idIntesta=te.idIntesta
;

CREATE VIEW EEConsumoMensile
AS
SELECT te.NomeIntesta 
      ,cs.idEEFattura
      ,toAnnoMese(cs.dtIniz) as dtIniz
	  ,EESumLettAttuale(cs.idEEFattura) as totLett
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
      ,cs.importo
  FROM EEConsumo as cs
	  INNER JOIN EEFattura as ft
		 ON ft.idEEFattura=cs.idEEFattura
	  INNER JOIN intesta as te
		 ON ft.idIntesta=te.idIntesta
  WHERE EESumLettAttuale(cs.idEEFattura) > 0
;

CREATE VIEW EEConsumoAnnuo
AS
SELECT NomeIntesta
      ,CAST(dtIniz as int) as anno
      ,SUM(importo) as totAnno
  FROM EEConsumoMensile
GROUP BY NomeIntesta, CAST(dtIniz as int)
;

CREATE view EEScaglioniImporti
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
		   toAnnoMese(cs.dtIniz) as dtIniz,
		   ISNULL(cs.importo, 0) as importo
	  FROM EEConsumo as cs
	    INNER JOIN EEFattura as ft
        ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN intesta as te
        ON ft.idIntesta=te.idIntesta
	  WHERE cs.tipoSpesa in ( 'E1','E2','E3', 'S1','S2','PU', 'R', 'P' )
	    AND EESumLettAttuale(cs.idEEFattura) > 0
 ) consunit  PIVOT (
	SUM(importo)
	FOR tipoSpesa in ( E1,E2, E3, S1, S2, PU,  R, P )
 ) AS pivot_cons
;

CREATE VIEW EEScaglioniPrezzoUnit
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
	       toAnnoMese(cs.dtIniz) as dtIniz,
		   ISNULL(cs.prezzoUnit,0) as prezzoUnit
	  FROM EEConsumo as cs
 	    INNER JOIN EEFattura as ft
           ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN intesta as te
           ON ft.idIntesta=te.idIntesta
	  WHERE cs.tipoSpesa in ( 'E1','E2','E3', 'S1','S2','PU', 'R', 'P' )
	    AND EESumLettAttuale(cs.idEEFattura) > 0
 ) consunit  PIVOT (
	SUM(prezzoUnit)
	FOR tipoSpesa in ( E1,E2, E3, S1, S2, PU,  R, P )
 ) AS pivot_cons
;

CREATE VIEW EESpeseMensili
as
SELECT te.nomeIntesta,
	   toAnnoMese(cs.dtIniz) as dtIniz,
       SUM(cs.quantita) as quantita,
	   SUM(cs.importo) as importo
  FROM EEConsumo as cs
   	    INNER JOIN EEFattura as ft
        ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN intesta as te
        ON ft.idIntesta=te.idIntesta
  WHERE EESumLettAttuale(cs.idEEFattura) > 0
GROUP BY te.nomeIntesta, toAnnoMese(cs.dtIniz)
;

CREATE VIEW EECostoAnnuale
AS
SELECT * FROM (
SELECT NomeIntesta
      ,anno
      ,totAnno
  FROM EEConsumoAnnuo
) pvtanno PIVOT (
   SUM(totAnno)
   FOR nomeIntesta IN ( alessandro, andrea, claudio )
) as pvt
;

CREATE VIEW GASConsumoMensile
AS
SELECT te.NomeIntesta 
      ,cs.idGASFattura
      --,toAnnoMese(cs.dtIniz) as dtIniz
      --,toAnnoMese(cs.dtFine) as dtFine
      ,cs.dtIniz as dtIniz
      ,cs.dtFine as dtFine
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
	  ,DATEDIFF(d,cs.dtIniz, cs.dtFine) + 1 as qtaGG
      ,cs.quantita / (DATEDIFF(d,cs.dtIniz, cs.dtFine) + 1 ) as mediaGG
      ,cs.importo
  FROM GASConsumo as cs
	  INNER JOIN GASFattura as ft
		 ON ft.idGASFattura=cs.idGASFattura
	  INNER JOIN intesta as te
		 ON ft.idIntesta=te.idIntesta

;

CREATE VIEW GASLettureMensili
AS
SELECT te.NomeIntesta
      -- ,le.idLettura
      -- ,le.idGASFattura
	  ,toAnnoMese(ft.periodFattDtIniz) as dtFattIniz
	  ,toAnnoMese(ft.periodFattDtFine) as dtFattFine
      ,toAnnoMese(le.LettData) as lettDtPrec
	  ,le.TipoLett
      ,le.Consumofatt
  FROM GASLettura as le
  INNER JOIN GASFattura as ft
		 ON ft.idGASFattura=le.idGASFattura
	  INNER JOIN intesta as te
		 ON ft.idIntesta=te.idIntesta
;

CREATE VIEW GASScaglioniImporto
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
	 , (ISNULL(G1,0) +
	   ISNULL(G2,0) +
	   ISNULL(G3,0) ) / qtaGG as mediaGG
  FROM (
  	SELECT te.NomeIntesta
	     , cs.idGASFattura
		 , tipoSpesa
		 , cs.dtIniz
		 , cs.dtFine
		 , (DATEDIFF(d, cs.dtIniz, cs.dtFine) + 1) as qtaGG
		 , ISNULL(cs.importo, 0) as importo
	  FROM GASConsumo AS cs
		INNER JOIN GASFattura as ft
			ON ft.idGASFattura=cs.idGASFattura
		INNER JOIN intesta as te
			ON ft.idIntesta=te.idIntesta
    WHERE cs.dtIniz BETWEEN ft.periodCongDtIniz and ft.periodCongDtFine
	  AND cs.dtFine BETWEEN ft.periodCongDtIniz and ft.periodCongDtFine
) consunit PIVOT (
  SUM(importo)
  FOR tipoSpesa in ( G1, G2, G3 )
) AS pivCons

;
SET IDENTITY_INSERT EEConsumo ON 

INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1700, 182, 'E1', CAST(N'2019-07-01' AS Date), CAST(N'2019-07-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(27.00 AS Decimal(8, 2)), 2.4200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1701, 182, 'P', CAST(N'2019-07-01' AS Date), CAST(N'2019-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1702, 182, 'R', CAST(N'2019-07-01' AS Date), CAST(N'2019-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(27.00 AS Decimal(8, 2)), 1.6000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1703, 182, 'E1', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 0.8900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1704, 182, 'P', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1705, 182, 'R', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 0.5900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1706, 183, 'E1', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 3.4900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1707, 183, 'P', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1708, 183, 'R', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 2.3100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1709, 183, 'E1', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(103.00 AS Decimal(8, 2)), 9.2100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1710, 183, 'P', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1711, 183, 'R', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(103.00 AS Decimal(8, 2)), 6.0900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1712, 184, 'E1', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1713, 184, 'E2', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(78.00 AS Decimal(8, 2)), 14.7800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1714, 184, 'P', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1715, 184, 'R', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(236.00 AS Decimal(8, 2)), 13.9500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1716, 184, 'E1', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1717, 184, 'E2', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(246.00 AS Decimal(8, 2)), 46.6200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1718, 184, 'P', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1719, 184, 'R', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(409.00 AS Decimal(8, 2)), 24.1800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1837, 201, 'E1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 22.8100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1838, 201, 'E2', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 18.4200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1839, 201, 'P', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1840, 201, 'R', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(276.00 AS Decimal(8, 2)), 16.3200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1841, 201, 'E1', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 22.8100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1842, 201, 'E2', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 18.4200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1843, 201, 'P', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1844, 201, 'R', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(276.00 AS Decimal(8, 2)), 16.3200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1845, 201, 'E1', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(197.00 AS Decimal(8, 2)), 22.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1846, 201, 'E2', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(70.00 AS Decimal(8, 2)), 17.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1847, 201, 'P', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1848, 201, 'R', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(267.00 AS Decimal(8, 2)), 15.7900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1849, 201, 'E1', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 22.8100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1850, 201, 'E2', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 18.4200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1851, 201, 'P', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1852, 201, 'R', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(276.00 AS Decimal(8, 2)), 16.3200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1853, 201, 'E1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(197.00 AS Decimal(8, 2)), 22.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1854, 201, 'E2', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 18.1600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1855, 201, 'P', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1856, 201, 'R', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(268.00 AS Decimal(8, 2)), 15.8500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1857, 201, 'PU', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.294910 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 60.1600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1858, 201, 'PU', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.294910 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 21.2300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1859, 201, 'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.007135 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 1.4600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1860, 201, 'S2', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.021405 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 1.5400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1861, 201, 'P', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1862, 201, 'R', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(130.00 AS Decimal(8, 2)), 7.6900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1863, 201, 'PU', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.174490 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 35.6000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1864, 201, 'PU', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.174490 AS Decimal(10, 6)), CAST(73.00 AS Decimal(8, 2)), 12.7400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1865, 201, 'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 2.0800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1866, 201, 'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(73.00 AS Decimal(8, 2)), 2.2300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1867, 201, 'P', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1868, 201, 'R', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(277.00 AS Decimal(8, 2)), 16.3800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1869, 201, 'PU', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.161070 AS Decimal(10, 6)), CAST(184.00 AS Decimal(8, 2)), 29.6400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1870, 201, 'PU', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.161070 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 10.6300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1871, 201, 'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(184.00 AS Decimal(8, 2)), 1.8700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1872, 201, 'S2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 2.0100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1873, 201, 'P', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1874, 201, 'R', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(250.00 AS Decimal(8, 2)), 14.7800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1875, 201, 'PU', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.136380 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 27.8200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1876, 201, 'PU', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.136380 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 9.8200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1877, 201, 'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 2.0800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1878, 201, 'S2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 2.2000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1879, 201, 'P', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1880, 201, 'R', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(276.00 AS Decimal(8, 2)), 16.3200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1881, 201, 'PU', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.134970 AS Decimal(10, 6)), CAST(197.00 AS Decimal(8, 2)), 26.5900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1882, 201, 'PU', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.134970 AS Decimal(10, 6)), CAST(121.00 AS Decimal(8, 2)), 16.3300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1883, 201, 'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(197.00 AS Decimal(8, 2)), 2.0000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1884, 201, 'S2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(121.00 AS Decimal(8, 2)), 3.6900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1885, 201, 'P', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1886, 201, 'R', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 10.0500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1887, 202, 'P', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(146.00 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1888, 203, 'P', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(139.00 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1889, 204, 'P', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(82.00 AS Decimal(8, 2)), 3.6500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1890, 205, 'PU', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.105730 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 21.5700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1891, 205, 'PU', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.105730 AS Decimal(10, 6)), CAST(111.00 AS Decimal(8, 2)), 11.7400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1892, 205, 'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 2.0800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1893, 205, 'S2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(111.00 AS Decimal(8, 2)), 3.3900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1894, 205, 'P', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1895, 205, 'R', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(315.00 AS Decimal(8, 2)), 18.6300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1896, 205, 'PU', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.105340 AS Decimal(10, 6)), CAST(142.00 AS Decimal(8, 2)), 14.9600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1897, 205, 'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(142.00 AS Decimal(8, 2)), 1.4400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1898, 205, 'P', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1899, 205, 'R', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(142.00 AS Decimal(8, 2)), 8.4000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1900, 206, 'E1', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1901, 206, 'E2', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(111.00 AS Decimal(8, 2)), 21.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1902, 206, 'P', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1903, 206, 'R', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(269.00 AS Decimal(8, 2)), 15.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1904, 206, 'E1', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1905, 206, 'E2', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(106.00 AS Decimal(8, 2)), 20.0900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1906, 206, 'P', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1907, 206, 'R', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(226.00 AS Decimal(8, 2)), 13.3600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1908, 207, 'E1', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1909, 207, 'E2', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(124.00 AS Decimal(8, 2)), 23.5000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1910, 207, 'P', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1911, 207, 'R', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(282.00 AS Decimal(8, 2)), 16.6700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1912, 207, 'E1', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1913, 207, 'E2', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(154.00 AS Decimal(8, 2)), 29.1800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1914, 207, 'P', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1915, 207, 'R', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(213.00 AS Decimal(8, 2)), 12.5900)
;
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1916, 208, 'E1', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1917, 208, 'E2', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(130.00 AS Decimal(8, 2)), 24.6400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1918, 208, 'P', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1919, 208, 'R', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(293.00 AS Decimal(8, 2)), 17.3300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1920, 208, 'E1', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(152.00 AS Decimal(8, 2)), 13.6000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1921, 208, 'E2', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(110.00 AS Decimal(8, 2)), 20.8500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1922, 208, 'P', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.836753 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.7700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1923, 208, 'R', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(194.00 AS Decimal(8, 2)), 11.4700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1924, 209, 'E1', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1925, 209, 'E2', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(151.00 AS Decimal(8, 2)), 28.6200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1926, 209, 'P', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1927, 209, 'R', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(314.00 AS Decimal(8, 2)), 18.5700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1928, 209, 'E1', CAST(N'2020-04-01' AS Date), CAST(N'2020-04-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1929, 209, 'E2', CAST(N'2020-04-01' AS Date), CAST(N'2020-04-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(139.00 AS Decimal(8, 2)), 26.3400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1930, 209, 'P', CAST(N'2020-04-01' AS Date), CAST(N'2020-04-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1931, 209, 'R', CAST(N'2020-04-01' AS Date), CAST(N'2020-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(180.00 AS Decimal(8, 2)), 10.6400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1932, 210, 'E1', CAST(N'2020-05-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1933, 210, 'E2', CAST(N'2020-05-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(124.00 AS Decimal(8, 2)), 23.5000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1934, 210, 'P', CAST(N'2020-05-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1935, 210, 'R', CAST(N'2020-05-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(287.00 AS Decimal(8, 2)), 16.9700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1936, 210, 'E1', CAST(N'2020-06-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1937, 210, 'E2', CAST(N'2020-06-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(105.00 AS Decimal(8, 2)), 19.9000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1938, 210, 'P', CAST(N'2020-06-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1939, 210, 'R', CAST(N'2020-06-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(208.00 AS Decimal(8, 2)), 12.3000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1940, 211, 'E1', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1941, 211, 'E2', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(87.00 AS Decimal(8, 2)), 16.4900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1942, 211, 'P', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1943, 211, 'R', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(250.00 AS Decimal(8, 2)), 14.7800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1944, 212, 'E1', CAST(N'2020-08-01' AS Date), CAST(N'2020-08-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1945, 212, 'E2', CAST(N'2020-08-01' AS Date), CAST(N'2020-08-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(160.00 AS Decimal(8, 2)), 30.3200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1946, 212, 'P', CAST(N'2020-08-01' AS Date), CAST(N'2020-08-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1947, 212, 'R', CAST(N'2020-08-01' AS Date), CAST(N'2020-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(323.00 AS Decimal(8, 2)), 19.1000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1948, 212, 'E1', CAST(N'2020-09-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1949, 212, 'E2', CAST(N'2020-09-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(103.00 AS Decimal(8, 2)), 19.5200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1950, 212, 'P', CAST(N'2020-09-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1951, 212, 'R', CAST(N'2020-09-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(260.00 AS Decimal(8, 2)), 15.3700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1952, 212, 'E1', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1953, 212, 'E2', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(111.00 AS Decimal(8, 2)), 21.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1954, 212, 'P', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1955, 212, 'R', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(274.00 AS Decimal(8, 2)), 16.2000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1956, 212, 'E1', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1957, 212, 'E2', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(150.00 AS Decimal(8, 2)), 28.4300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1958, 212, 'P', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1959, 212, 'R', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(307.00 AS Decimal(8, 2)), 18.1500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1960, 212, 'E1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1961, 212, 'E2', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(178.00 AS Decimal(8, 2)), 33.7300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1962, 212, 'P', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1963, 212, 'R', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(70.00 AS Decimal(8, 2)), 4.1400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1964, 213, 'P', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1965, 213, 'R', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(369.00 AS Decimal(8, 2)), 21.8200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1966, 213, 'P', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1967, 213, 'R', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(318.00 AS Decimal(8, 2)), 18.8000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1968, 213, 'P', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1969, 213, 'R', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(286.00 AS Decimal(8, 2)), 16.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1970, 213, 'P', CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1971, 214, 'P', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1972, 214, 'R', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(294.00 AS Decimal(8, 2)), 17.3800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1973, 214, 'P', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1974, 214, 'R', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(304.00 AS Decimal(8, 2)), 17.9800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1975, 214, 'E1', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1976, 214, 'E2', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(156.00 AS Decimal(8, 2)), 29.5600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1977, 214, 'P', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1978, 214, 'R', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(354.00 AS Decimal(8, 2)), 20.9300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1979, 214, 'E1', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1980, 214, 'E2', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(198.00 AS Decimal(8, 2)), 37.5200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1981, 214, 'P', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1982, 214, 'R', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(45.00 AS Decimal(8, 2)), 2.6600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1983, 215, 'E1', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1984, 215, 'E2', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(141.00 AS Decimal(8, 2)), 26.7200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1985, 215, 'P', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1986, 215, 'R', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(299.00 AS Decimal(8, 2)), 17.6800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1987, 215, 'E1', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1988, 215, 'E2', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(153.00 AS Decimal(8, 2)), 29.0000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1989, 215, 'P', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1990, 215, 'R', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(316.00 AS Decimal(8, 2)), 18.6900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1991, 215, 'E1', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1992, 215, 'E2', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(167.00 AS Decimal(8, 2)), 31.6500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1993, 215, 'P', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1994, 215, 'R', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(325.00 AS Decimal(8, 2)), 19.2200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1995, 215, 'E1', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1996, 215, 'E2', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(169.00 AS Decimal(8, 2)), 32.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1997, 215, 'P', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1998, 215, 'R', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 2.9600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1999, 216, 'P', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2000, 216, 'R', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(325.00 AS Decimal(8, 2)), 19.2200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2001, 216, 'P', CAST(N'2022-02-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2002, 216, 'R', CAST(N'2022-02-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(301.00 AS Decimal(8, 2)), 17.8000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2003, 216, 'P', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2004, 216, 'R', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(300.00 AS Decimal(8, 2)), 17.7400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2005, 216, 'P', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2006, 216, 'R', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(47.00 AS Decimal(8, 2)), 2.7800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2007, 217, 'P', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2008, 217, 'R', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(311.00 AS Decimal(8, 2)), 18.3900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2009, 217, 'P', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2010, 217, 'R', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(303.00 AS Decimal(8, 2)), 17.9200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2011, 217, 'P', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2012, 217, 'R', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(377.00 AS Decimal(8, 2)), 22.2900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2013, 217, 'P', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2014, 217, 'R', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 0.3500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2015, 218, 'P', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
;
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2016, 218, 'R', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(286.00 AS Decimal(8, 2)), 16.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2017, 218, 'P', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2018, 218, 'R', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(325.00 AS Decimal(8, 2)), 19.2200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2019, 218, 'P', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2020, 218, 'R', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(379.00 AS Decimal(8, 2)), 22.4100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2021, 218, 'P', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2022, 219, 'P', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2023, 219, 'R', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(389.00 AS Decimal(8, 2)), 23.0000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2024, 219, 'P', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2025, 219, 'R', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(345.00 AS Decimal(8, 2)), 20.4000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2026, 219, 'P', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2027, 219, 'R', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(239.00 AS Decimal(8, 2)), 14.1300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2028, 219, 'P', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2036, 221, 'E1', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2037, 221, 'E2', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(48.00 AS Decimal(8, 2)), 9.1000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2038, 221, 'P', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2039, 221, 'R', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(205.00 AS Decimal(8, 2)), 12.1200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2040, 221, 'E1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2041, 221, 'E2', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(53.00 AS Decimal(8, 2)), 10.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2042, 221, 'P', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2043, 221, 'R', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(216.00 AS Decimal(8, 2)), 12.7700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2044, 222, 'E1', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2045, 222, 'E2', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(36.00 AS Decimal(8, 2)), 6.8200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2046, 222, 'P', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2047, 222, 'R', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(199.00 AS Decimal(8, 2)), 11.7700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2048, 222, 'E1', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(147.00 AS Decimal(8, 2)), 13.1500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2049, 222, 'E2', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 2.4600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2050, 222, 'P', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2051, 222, 'R', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(160.00 AS Decimal(8, 2)), 9.4600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2052, 223, 'E1', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2053, 223, 'E2', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(23.00 AS Decimal(8, 2)), 4.3600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2054, 223, 'P', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2055, 223, 'R', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(186.00 AS Decimal(8, 2)), 11.0000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2056, 223, 'E1', CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 13.8600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2057, 223, 'P', CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2058, 223, 'R', CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 9.1700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2059, 224, 'E1', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(143.00 AS Decimal(8, 2)), 12.7900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2060, 224, 'P', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2061, 224, 'R', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(143.00 AS Decimal(8, 2)), 8.4600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2062, 224, 'E1', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2063, 224, 'E2', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 2.0800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2064, 224, 'P', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2065, 224, 'R', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(169.00 AS Decimal(8, 2)), 9.9900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2066, 225, 'E1', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2067, 225, 'E2', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 3.2200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2068, 225, 'P', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2069, 225, 'R', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(180.00 AS Decimal(8, 2)), 10.6400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2070, 225, 'E1', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2071, 225, 'E2', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 5.5000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2072, 225, 'P', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2073, 225, 'R', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(192.00 AS Decimal(8, 2)), 11.3500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2074, 226, 'E1', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(128.00 AS Decimal(8, 2)), 11.4500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2075, 226, 'P', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2076, 226, 'R', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(128.00 AS Decimal(8, 2)), 7.5700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2077, 226, 'E1', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 13.8600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2078, 226, 'P', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2079, 226, 'R', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 9.1700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2080, 227, 'E1', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 13.8600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2081, 227, 'P', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2082, 227, 'R', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 9.1700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2083, 227, 'E1', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2084, 227, 'E2', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 5.3100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2085, 227, 'P', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2086, 227, 'R', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(191.00 AS Decimal(8, 2)), 11.2900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2087, 228, 'E1', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 18.2300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2088, 228, 'E2', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 3.3300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2089, 228, 'P', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2090, 228, 'R', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(176.00 AS Decimal(8, 2)), 10.4100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2091, 228, 'E1', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 17.6700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2092, 228, 'P', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2093, 228, 'R', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 9.3400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2094, 229, 'E1', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 15.3200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2095, 229, 'P', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2096, 229, 'R', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 8.1000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2097, 229, 'E1', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(143.00 AS Decimal(8, 2)), 15.9900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2098, 229, 'P', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2099, 229, 'R', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(143.00 AS Decimal(8, 2)), 8.4600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2100, 230, 'E1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(181.00 AS Decimal(8, 2)), 20.2400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2101, 230, 'P', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2102, 230, 'R', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(181.00 AS Decimal(8, 2)), 10.7000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2103, 230, 'E1', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(165.00 AS Decimal(8, 2)), 18.4500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2104, 230, 'P', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2105, 230, 'R', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(165.00 AS Decimal(8, 2)), 9.7600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2106, 231, 'E1', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(138.00 AS Decimal(8, 2)), 15.4300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2107, 231, 'P', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2108, 231, 'R', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(138.00 AS Decimal(8, 2)), 8.1600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2109, 231, 'E1', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(181.00 AS Decimal(8, 2)), 20.2400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2110, 231, 'P', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2111, 231, 'R', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(181.00 AS Decimal(8, 2)), 10.7000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2112, 232, 'E1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(161.00 AS Decimal(8, 2)), 18.0000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2113, 232, 'P', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2114, 232, 'R', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(161.00 AS Decimal(8, 2)), 9.5200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2115, 232, 'PU', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.294910 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 50.1300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2116, 232, 'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.007135 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 1.2100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2117, 232, 'P', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2118, 232, 'R', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 10.0500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2119, 233, 'PU', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.174490 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 29.6600)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2120, 233, 'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 1.7300)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2121, 233, 'P', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2122, 233, 'R', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 10.0500)
;
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2123, 233, 'PU', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.161070 AS Decimal(10, 6)), CAST(159.00 AS Decimal(8, 2)), 25.6100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2124, 233, 'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(159.00 AS Decimal(8, 2)), 1.6200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2125, 233, 'P', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2126, 233, 'R', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(159.00 AS Decimal(8, 2)), 9.4000)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2127, 234, 'PU', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.136380 AS Decimal(10, 6)), CAST(156.00 AS Decimal(8, 2)), 21.2800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2128, 234, 'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(156.00 AS Decimal(8, 2)), 1.5900)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2129, 234, 'P', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2130, 234, 'R', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(156.00 AS Decimal(8, 2)), 9.2200)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2131, 234, 'PU', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.134970 AS Decimal(10, 6)), CAST(145.00 AS Decimal(8, 2)), 19.5700)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2132, 234, 'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(145.00 AS Decimal(8, 2)), 1.4800)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2133, 234, 'P', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2134, 234, 'R', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(145.00 AS Decimal(8, 2)), 8.5700)
SET IDENTITY_INSERT EEConsumo OFF
SET IDENTITY_INSERT EEFattura ON 

INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (182, 3, 2019, CAST(N'2019-10-15' AS Date), 2019, '100109767', CAST(N'2019-07-01' AS Date), CAST(N'2019-08-31' AS Date), 0, 0, 0.3400, 0.1600, 13.9200)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (183, 3, 2019, CAST(N'2019-12-13' AS Date), 2019, '100132147', CAST(N'2019-09-01' AS Date), CAST(N'2019-10-31' AS Date), 0, 0, 0.3300, 0.1600, 29.3800)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (184, 3, 2020, CAST(N'2020-02-13' AS Date), 2020, '102015439', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), 0, 0, 2.8500, 0.1600, 139.2500)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (201, 3, 2023, CAST(N'2023-06-15' AS Date), 2023, '1033960', CAST(N'2022-07-01' AS Date), CAST(N'2023-04-30' AS Date), 0, 0, 3.4500, 0.1600, 322.9000)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (202, 3, 2022, CAST(N'2022-12-15' AS Date), 2022, '1133113', CAST(N'2022-09-01' AS Date), CAST(N'2022-10-31' AS Date), 0, 0, 0.3300, 0.1600, 37.5700)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (203, 3, 2023, CAST(N'2023-02-13' AS Date), 2023, '12550', CAST(N'2022-11-01' AS Date), CAST(N'2022-12-31' AS Date), 0, 0, 3.1400, 0.1600, 163.5100)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (204, 3, 2023, CAST(N'2023-04-25' AS Date), 2023, '1011810', CAST(N'2023-01-01' AS Date), CAST(N'2023-02-28' AS Date), 0, 0, 1.4800, 0.1600, 107.1400)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (205, 3, 2023, CAST(N'2023-08-28' AS Date), 2023, '1058159', CAST(N'2023-05-01' AS Date), CAST(N'2023-06-30' AS Date), 0, 0, 0.9500, 0.1600, 91.1100)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (206, 1, 2019, CAST(N'2019-12-13' AS Date), 2019, '100128446', CAST(N'2019-09-01' AS Date), CAST(N'2019-10-31' AS Date), 0, 0, 2.0100, 0.1600, 109.2300)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (207, 1, 2020, CAST(N'2020-02-13' AS Date), 2020, '102011778', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), 0, 0, 2.4800, 0.1600, 121.2600)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (208, 1, 2020, CAST(N'2020-04-10' AS Date), 2020, '102035619', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), 0, 0, 2.1900, 0.1600, 112.6300)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (209, 1, 2020, CAST(N'2020-06-09' AS Date), 2020, '102058068', CAST(N'2020-03-01' AS Date), CAST(N'2020-04-30' AS Date), 0, 0, 2.5800, 0.1600, 123.4800)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (210, 1, 2020, CAST(N'2020-08-14' AS Date), 2020, '102081806', CAST(N'2020-05-01' AS Date), CAST(N'2020-06-30' AS Date), 0, 0, 2.1100, 0.1600, 111.5000)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (211, 1, 2020, CAST(N'2020-09-29' AS Date), 2020, '102093513', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), 0, 0, 0.8400, 0.1600, 249.0800)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (212, 1, 2021, CAST(N'2021-02-19' AS Date), 2021, '10022766', CAST(N'2020-08-01' AS Date), CAST(N'2020-12-31' AS Date), 0, 0, 6.2800, 0.1600, 304.4500)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (213, 1, 2021, CAST(N'2021-09-24' AS Date), 2021, '10092352', CAST(N'2021-01-01' AS Date), CAST(N'2021-04-30' AS Date), 1954, 633, 0.6500, 0.1600, 73.8200)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (214, 1, 2022, CAST(N'2022-01-28' AS Date), 2022, '1000885', CAST(N'2021-05-01' AS Date), CAST(N'2021-08-31' AS Date), 633, 0, 3.4100, 0.1600, 174.8900)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (215, 1, 2022, CAST(N'2022-05-20' AS Date), 2022, '1047683', CAST(N'2021-09-01' AS Date), CAST(N'2021-12-31' AS Date), 5096, 0, 5.5500, 0.1600, 257.2100)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (216, 1, 2022, CAST(N'2022-07-08' AS Date), 2022, '1071926', CAST(N'2022-01-01' AS Date), CAST(N'2022-04-30' AS Date), 5096, 3940, 0.6500, 0.1600, 73.8300)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (217, 1, 2022, CAST(N'2022-10-27' AS Date), 2022, '1118126', CAST(N'2022-05-01' AS Date), CAST(N'2022-08-31' AS Date), 3940, 2592, 0.6700, 0.1600, 75.6500)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (218, 1, 2023, CAST(N'2023-03-17' AS Date), 2023, '22750', CAST(N'2022-09-01' AS Date), CAST(N'2022-12-31' AS Date), 2592, 910, 0.6600, 0.1600, 75.1000)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (219, 1, 2023, CAST(N'2023-08-02' AS Date), 2023, '1044418', CAST(N'2023-01-01' AS Date), CAST(N'2023-04-30' AS Date), 5489, 4115, 0.6500, 0.1600, 73.8200)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (221, 2, 2021, CAST(N'2021-02-11' AS Date), 2021, '10009304', CAST(N'2020-11-01' AS Date), CAST(N'2020-12-31' AS Date), 0, 0, 1.1100, 0.1600, 82.1900)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (222, 2, 2021, CAST(N'2021-04-15' AS Date), 2021, '10033266', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), 0, 0, 0.7000, 0.1600, 67.1300)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (223, 2, 2021, CAST(N'2021-06-15' AS Date), 2021, '10055715', CAST(N'2021-03-01' AS Date), CAST(N'2021-04-30' AS Date), 0, 0, 0.5000, 0.1600, 61.9200)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (224, 2, 2021, CAST(N'2021-08-27' AS Date), 2021, '10078178', CAST(N'2021-05-01' AS Date), CAST(N'2021-06-30' AS Date), 0, 0, 0.4200, 0.1600, 56.3200)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (225, 2, 2021, CAST(N'2021-10-19' AS Date), 2021, '10102069', CAST(N'2021-07-01' AS Date), CAST(N'2021-08-31' AS Date), 0, 0, 0.6900, 0.1600, 69.1400)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (226, 2, 2021, CAST(N'2021-12-15' AS Date), 2021, '10124453', CAST(N'2021-09-01' AS Date), CAST(N'2021-10-31' AS Date), 0, 0, 0.3300, 0.1600, 50.8300)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (227, 2, 2022, CAST(N'2022-02-11' AS Date), 2022, '1010580', CAST(N'2021-11-01' AS Date), CAST(N'2021-12-31' AS Date), 0, 0, 0.5400, 0.1600, 63.2000)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (228, 2, 2022, CAST(N'2022-06-15' AS Date), 2022, '1057277', CAST(N'2022-03-01' AS Date), CAST(N'2022-04-30' AS Date), 0, 0, 0.4600, 0.1600, 67.8900)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (229, 2, 2022, CAST(N'2022-08-12' AS Date), 2022, '1081555', CAST(N'2022-05-01' AS Date), CAST(N'2022-06-30' AS Date), 0, 0, 0.3300, 0.1600, 56.6500)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (230, 2, 2022, CAST(N'2022-10-14' AS Date), 2022, '1104011', CAST(N'2022-07-01' AS Date), CAST(N'2022-08-31' AS Date), 0, 0, 0.3400, 0.1600, 68.0700)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (231, 2, 2022, CAST(N'2022-12-15' AS Date), 2022, '1128269', CAST(N'2022-09-01' AS Date), CAST(N'2022-10-31' AS Date), 0, 0, 0.3300, 0.1600, 62.8100)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (232, 2, 2023, CAST(N'2023-02-13' AS Date), 2023, '7800', CAST(N'2022-11-01' AS Date), CAST(N'2022-12-31' AS Date), 0, 0, 0.3300, 0.1600, 97.1900)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (233, 2, 2023, CAST(N'2023-04-25' AS Date), 2023, '1007077', CAST(N'2023-01-01' AS Date), CAST(N'2023-02-28' AS Date), 0, 0, 0.3200, 0.1600, 76.2100)
INSERT EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (234, 2, 2023, CAST(N'2023-06-15' AS Date), 2023, '1029302', CAST(N'2023-03-01' AS Date), CAST(N'2023-04-30' AS Date), 0, 0, 0.3300, 0.1600, 65.3100)
SET IDENTITY_INSERT EEFattura OFF
SET IDENTITY_INSERT EELettura ON 

INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (420, 182, CAST(N'2019-06-30' AS Date), 23425, 'real', CAST(N'2019-07-31' AS Date), 23452, 27)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (421, 182, CAST(N'2019-07-31' AS Date), 23452, 'real', CAST(N'2019-08-31' AS Date), 23462, 10)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (422, 183, CAST(N'2019-08-31' AS Date), 23462, 'real', CAST(N'2019-09-30' AS Date), 23501, 39)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (423, 183, CAST(N'2019-09-30' AS Date), 23501, 'real', CAST(N'2019-10-31' AS Date), 23604, 103)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (424, 184, CAST(N'2019-10-31' AS Date), 23604, 'real', CAST(N'2019-11-30' AS Date), 23840, 236)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (425, 184, CAST(N'2019-11-30' AS Date), 23840, 'real', CAST(N'2019-12-31' AS Date), 24249, 409)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (458, 201, CAST(N'2022-06-30' AS Date), 33064, 'real', CAST(N'2023-03-31' AS Date), 35506, 2442)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (459, 201, CAST(N'2023-03-31' AS Date), 35506, 'real', CAST(N'2023-04-26' AS Date), 35784, 278)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (460, 201, CAST(N'2023-04-26' AS Date), 35784, 'real', CAST(N'2023-04-30' AS Date), 35824, 40)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (461, 202, CAST(N'2022-08-31' AS Date), 0, 'stim', CAST(N'2022-09-30' AS Date), 0, 116)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (462, 202, CAST(N'2022-09-30' AS Date), 0, 'stim', CAST(N'2022-10-31' AS Date), 0, 146)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (463, 203, CAST(N'2022-10-31' AS Date), 0, 'stim', CAST(N'2022-11-30' AS Date), 0, 293)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (464, 203, CAST(N'2022-11-30' AS Date), 0, 'stim', CAST(N'2022-12-31' AS Date), 0, 343)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (465, 204, CAST(N'2022-12-31' AS Date), 0, 'stim', CAST(N'2023-01-31' AS Date), 0, 267)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (466, 204, CAST(N'2023-01-31' AS Date), 0, 'stim', CAST(N'2023-02-28' AS Date), 0, 266)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (467, 205, CAST(N'2023-04-30' AS Date), 35824, 'real', CAST(N'2023-05-31' AS Date), 36139, 315)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (468, 205, CAST(N'2023-05-31' AS Date), 36139, 'real', CAST(N'2023-06-30' AS Date), 36281, 142)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (469, 206, CAST(N'2019-08-31' AS Date), 18952, 'real', CAST(N'2019-09-30' AS Date), 19221, 269)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (470, 206, CAST(N'2019-09-30' AS Date), 19221, 'real', CAST(N'2019-10-31' AS Date), 19490, 269)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (471, 207, CAST(N'2019-10-31' AS Date), 19490, 'real', CAST(N'2019-11-30' AS Date), 19772, 282)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (472, 207, CAST(N'2019-11-30' AS Date), 19772, 'real', CAST(N'2019-12-31' AS Date), 20089, 317)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (473, 208, CAST(N'2019-12-31' AS Date), 20089, 'real', CAST(N'2020-01-31' AS Date), 20382, 293)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (474, 208, CAST(N'2020-01-31' AS Date), 20382, 'real', CAST(N'2020-02-29' AS Date), 20644, 262)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (475, 209, CAST(N'2020-02-29' AS Date), 20644, 'real', CAST(N'2020-03-31' AS Date), 20958, 314)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (476, 209, CAST(N'2020-03-31' AS Date), 20958, 'real', CAST(N'2020-04-30' AS Date), 21254, 296)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (477, 210, CAST(N'2020-04-30' AS Date), 21254, 'real', CAST(N'2020-05-31' AS Date), 21541, 287)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (478, 210, CAST(N'2020-05-31' AS Date), 21541, 'real', CAST(N'2020-06-30' AS Date), 21803, 262)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (479, 211, CAST(N'2020-06-30' AS Date), 21803, 'real', CAST(N'2020-07-24' AS Date), 21998, 195)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (480, 211, CAST(N'2020-07-24' AS Date), 21998, 'real', CAST(N'2020-07-31' AS Date), 22053, 55)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (481, 212, CAST(N'2020-07-31' AS Date), 22053, 'real', CAST(N'2020-08-31' AS Date), 22376, 323)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (482, 212, CAST(N'2020-08-31' AS Date), 22376, 'real', CAST(N'2020-09-30' AS Date), 22636, 260)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (483, 212, CAST(N'2020-09-30' AS Date), 22636, 'real', CAST(N'2020-10-31' AS Date), 22910, 274)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (484, 212, CAST(N'2020-10-31' AS Date), 22910, 'real', CAST(N'2020-11-30' AS Date), 23217, 307)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (485, 212, CAST(N'2020-11-30' AS Date), 23217, 'real', CAST(N'2020-12-31' AS Date), 23558, 341)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (486, 213, CAST(N'2020-12-31' AS Date), 23558, 'real', CAST(N'2021-01-31' AS Date), 23927, 369)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (487, 213, CAST(N'2021-01-31' AS Date), 23927, 'real', CAST(N'2021-02-28' AS Date), 24245, 318)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (488, 213, CAST(N'2021-02-28' AS Date), 24245, 'real', CAST(N'2021-03-31' AS Date), 24571, 326)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (489, 213, CAST(N'2021-03-31' AS Date), 24571, 'real', CAST(N'2021-04-30' AS Date), 24879, 308)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (490, 214, CAST(N'2021-04-30' AS Date), 24879, 'real', CAST(N'2021-05-31' AS Date), 25173, 294)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (491, 214, CAST(N'2021-05-31' AS Date), 25173, 'real', CAST(N'2021-06-30' AS Date), 25477, 304)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (492, 214, CAST(N'2021-06-30' AS Date), 25477, 'real', CAST(N'2021-07-31' AS Date), 25831, 354)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (493, 214, CAST(N'2021-07-31' AS Date), 25831, 'real', CAST(N'2021-08-31' AS Date), 26192, 361)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (494, 215, CAST(N'2021-08-31' AS Date), 26192, 'real', CAST(N'2021-09-30' AS Date), 26491, 299)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (495, 215, CAST(N'2021-09-30' AS Date), 26491, 'real', CAST(N'2021-10-31' AS Date), 26807, 316)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (496, 215, CAST(N'2021-10-31' AS Date), 26807, 'real', CAST(N'2021-11-30' AS Date), 27132, 325)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (497, 215, CAST(N'2021-11-30' AS Date), 27132, 'real', CAST(N'2021-12-31' AS Date), 27464, 332)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (498, 216, CAST(N'2021-12-31' AS Date), 27464, 'real', CAST(N'2022-01-31' AS Date), 27789, 325)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (499, 216, CAST(N'2022-01-31' AS Date), 27789, 'real', CAST(N'2022-02-28' AS Date), 28090, 301)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (500, 216, CAST(N'2022-02-28' AS Date), 28090, 'real', CAST(N'2022-03-31' AS Date), 28390, 300)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (501, 216, CAST(N'2022-03-31' AS Date), 28390, 'real', CAST(N'2022-04-30' AS Date), 28620, 230)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (502, 217, CAST(N'2022-04-30' AS Date), 28620, 'real', CAST(N'2022-05-31' AS Date), 28931, 311)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (503, 217, CAST(N'2022-05-31' AS Date), 28931, 'real', CAST(N'2022-06-30' AS Date), 29234, 303)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (504, 217, CAST(N'2022-06-30' AS Date), 29234, 'real', CAST(N'2022-07-31' AS Date), 29611, 377)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (505, 217, CAST(N'2022-07-31' AS Date), 29611, 'real', CAST(N'2022-08-31' AS Date), 29968, 357)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (506, 218, CAST(N'2022-08-31' AS Date), 29968, 'real', CAST(N'2022-09-30' AS Date), 30254, 286)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (507, 218, CAST(N'2022-09-30' AS Date), 30254, 'real', CAST(N'2022-10-31' AS Date), 30579, 325)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (508, 218, CAST(N'2022-10-31' AS Date), 30579, 'real', CAST(N'2022-11-30' AS Date), 31228, 649)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (509, 218, CAST(N'2022-11-30' AS Date), 31228, 'real', CAST(N'2022-12-31' AS Date), 31650, 422)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (510, 219, CAST(N'2022-12-31' AS Date), 31650, 'real', CAST(N'2023-01-31' AS Date), 32039, 389)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (511, 219, CAST(N'2023-01-31' AS Date), 32039, 'real', CAST(N'2023-02-28' AS Date), 32384, 345)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (512, 219, CAST(N'2023-02-28' AS Date), 32384, 'real', CAST(N'2023-03-31' AS Date), 32721, 337)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (513, 219, CAST(N'2023-03-31' AS Date), 32721, 'real', CAST(N'2023-04-30' AS Date), 33024, 303)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (515, 221, CAST(N'2020-10-31' AS Date), 29286, 'real', CAST(N'2020-11-30' AS Date), 29491, 205)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (516, 221, CAST(N'2020-11-30' AS Date), 29491, 'real', CAST(N'2020-12-31' AS Date), 29707, 216)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (517, 222, CAST(N'2020-12-31' AS Date), 29707, 'real', CAST(N'2021-01-31' AS Date), 29906, 199)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (518, 222, CAST(N'2021-01-31' AS Date), 29906, 'real', CAST(N'2021-02-28' AS Date), 30066, 160)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (519, 223, CAST(N'2021-02-28' AS Date), 30066, 'real', CAST(N'2021-03-31' AS Date), 30252, 186)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (520, 223, CAST(N'2021-03-31' AS Date), 30252, 'real', CAST(N'2021-04-30' AS Date), 30407, 155)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (521, 224, CAST(N'2021-04-30' AS Date), 30407, 'real', CAST(N'2021-05-31' AS Date), 30550, 143)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (522, 224, CAST(N'2021-05-31' AS Date), 30550, 'real', CAST(N'2021-06-30' AS Date), 30719, 169)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (523, 225, CAST(N'2021-06-30' AS Date), 30719, 'real', CAST(N'2021-07-31' AS Date), 30899, 180)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (524, 225, CAST(N'2021-07-31' AS Date), 30899, 'real', CAST(N'2021-08-31' AS Date), 31091, 192)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (525, 226, CAST(N'2021-08-31' AS Date), 31091, 'real', CAST(N'2021-09-30' AS Date), 31219, 128)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (526, 226, CAST(N'2021-09-30' AS Date), 31219, 'real', CAST(N'2021-10-31' AS Date), 31374, 155)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (527, 227, CAST(N'2021-10-31' AS Date), 31374, 'real', CAST(N'2021-11-30' AS Date), 31529, 155)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (528, 227, CAST(N'2021-11-30' AS Date), 31529, 'real', CAST(N'2021-12-31' AS Date), 31720, 191)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (529, 228, CAST(N'2022-02-28' AS Date), 32085, 'real', CAST(N'2022-03-31' AS Date), 32261, 176)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (530, 228, CAST(N'2022-03-31' AS Date), 32261, 'real', CAST(N'2022-04-30' AS Date), 32419, 158)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (531, 229, CAST(N'2022-04-30' AS Date), 32419, 'real', CAST(N'2022-05-31' AS Date), 32556, 137)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (532, 229, CAST(N'2022-05-31' AS Date), 32556, 'real', CAST(N'2022-06-30' AS Date), 32699, 143)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (533, 230, CAST(N'2022-06-30' AS Date), 32699, 'real', CAST(N'2022-07-31' AS Date), 32880, 181)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (534, 230, CAST(N'2022-07-31' AS Date), 32880, 'real', CAST(N'2022-08-31' AS Date), 33045, 165)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (535, 231, CAST(N'2022-08-31' AS Date), 33045, 'real', CAST(N'2022-09-30' AS Date), 33183, 138)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (536, 231, CAST(N'2022-09-30' AS Date), 33183, 'real', CAST(N'2022-10-31' AS Date), 33364, 181)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (537, 232, CAST(N'2022-10-31' AS Date), 33364, 'real', CAST(N'2022-11-30' AS Date), 33525, 161)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (538, 232, CAST(N'2022-11-30' AS Date), 33525, 'real', CAST(N'2022-12-31' AS Date), 33695, 170)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (539, 233, CAST(N'2022-12-31' AS Date), 33695, 'real', CAST(N'2023-01-31' AS Date), 33865, 170)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (540, 233, CAST(N'2023-01-31' AS Date), 33865, 'real', CAST(N'2023-02-28' AS Date), 34024, 159)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (541, 234, CAST(N'2023-02-28' AS Date), 34024, 'real', CAST(N'2023-03-31' AS Date), 34180, 156)
INSERT EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (542, 234, CAST(N'2023-03-31' AS Date), 34180, 'real', CAST(N'2023-04-30' AS Date), 34325, 145)
SET IDENTITY_INSERT EELettura OFF
SET IDENTITY_INSERT GASConsumo ON 

INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (811, 203, 'G1', CAST(N'2019-05-18' AS Date), CAST(N'2019-12-13' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(293.00 AS Decimal(8, 2)), 137.7300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (812, 203, 'G2', CAST(N'2019-05-18' AS Date), CAST(N'2019-12-13' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 18.7000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (813, 204, 'G1', CAST(N'2019-12-14' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.7500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (814, 204, 'G2', CAST(N'2019-12-14' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(44.00 AS Decimal(8, 2)), 21.0900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (815, 204, 'G3', CAST(N'2019-12-14' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.8000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (816, 204, 'G1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-18' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(68.00 AS Decimal(8, 2)), 31.9600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (817, 204, 'G2', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-18' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(119.00 AS Decimal(8, 2)), 57.0500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (818, 204, 'G3', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-18' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 24.4400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (819, 208, 'G1', CAST(N'2020-05-21' AS Date), CAST(N'2020-12-15' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(225.00 AS Decimal(8, 2)), 105.7600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (820, 209, 'G1', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 10.3400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (821, 209, 'G2', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 18.7000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (822, 209, 'G3', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 15.6400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (823, 209, 'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 34.7800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (824, 209, 'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(129.00 AS Decimal(8, 2)), 61.8400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (825, 209, 'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(106.00 AS Decimal(8, 2)), 51.8100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (826, 210, 'G1', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 33.3700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (827, 210, 'G2', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(99.00 AS Decimal(8, 2)), 47.4600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (828, 212, 'G1', CAST(N'2021-04-15' AS Date), CAST(N'2021-12-13' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(307.00 AS Decimal(8, 2)), 144.3100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (829, 213, 'G1', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.7500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (830, 213, 'G2', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(44.00 AS Decimal(8, 2)), 21.0900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (831, 213, 'G3', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 15.1500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (832, 213, 'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 45.2200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (833, 213, 'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(129.00 AS Decimal(8, 2)), 80.3900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (834, 213, 'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(91.00 AS Decimal(8, 2)), 57.8200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (835, 214, 'G1', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(82.00 AS Decimal(8, 2)), 50.1100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (836, 214, 'G2', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(126.00 AS Decimal(8, 2)), 78.5200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (837, 215, 'G1', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.0000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (838, 215, 'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 14.3000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (839, 216, 'G1', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(45.00 AS Decimal(8, 2)), 35.7500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (840, 217, 'G2', CAST(N'2022-10-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(65.00 AS Decimal(8, 2)), 52.6600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (841, 218, 'G1', CAST(N'2022-04-23' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(37.00 AS Decimal(8, 2)), 22.6100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (842, 218, 'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-12-02' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(83.00 AS Decimal(8, 2)), 65.9400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (843, 218, 'G3', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(40.00 AS Decimal(8, 2)), 33.0400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (844, 219, 'G2', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(121.00 AS Decimal(8, 2)), 98.0300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (845, 220, 'G1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 30.9800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (846, 220, 'G2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 22.6800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (847, 220, 'G1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 34.1600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (848, 220, 'G2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 25.1100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (849, 220, 'G1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.1500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (850, 220, 'G2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 13.4300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (851, 220, 'G1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.1900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (852, 220, 'G2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.4600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (853, 220, 'G1', CAST(N'2023-05-05' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.1900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (854, 220, 'G1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.354598 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 2.4800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (855, 221, 'G1', CAST(N'2019-10-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (856, 221, 'G2', CAST(N'2019-10-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 65.6700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (857, 222, 'G1', CAST(N'2019-05-23' AS Date), CAST(N'2019-12-18' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(293.00 AS Decimal(8, 2)), 137.7300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (858, 222, 'G2', CAST(N'2019-05-23' AS Date), CAST(N'2019-12-18' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 6.7100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (859, 222, 'G1', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.4600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (860, 222, 'G2', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 15.3400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (861, 222, 'G3', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(49.00 AS Decimal(8, 2)), 23.9500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (862, 222, 'G1', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 20.2100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (863, 222, 'G2', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(75.00 AS Decimal(8, 2)), 35.9500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (864, 222, 'G3', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(117.00 AS Decimal(8, 2)), 57.1900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (865, 223, 'G1', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.4600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (866, 223, 'G2', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 15.3400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (867, 223, 'G3', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(35.00 AS Decimal(8, 2)), 17.1100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (868, 223, 'G1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-24' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(77.00 AS Decimal(8, 2)), 36.2000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (869, 223, 'G2', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-24' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(134.00 AS Decimal(8, 2)), 64.2400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (870, 223, 'G3', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-24' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(151.00 AS Decimal(8, 2)), 73.8000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (871, 223, 'G1', CAST(N'2020-02-25' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 23.5000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (872, 223, 'G2', CAST(N'2020-02-25' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(88.00 AS Decimal(8, 2)), 42.1800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (873, 223, 'G3', CAST(N'2020-02-25' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(53.00 AS Decimal(8, 2)), 25.9000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (874, 224, 'G1', CAST(N'2020-02-25' AS Date), CAST(N'2020-05-21' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(121.00 AS Decimal(8, 2)), 56.8800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (875, 224, 'G2', CAST(N'2020-02-25' AS Date), CAST(N'2020-05-21' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(138.00 AS Decimal(8, 2)), 66.1500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (876, 224, 'G1', CAST(N'2020-05-22' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 6.1100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (877, 225, 'G1', CAST(N'2020-06-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(52.00 AS Decimal(8, 2)), 24.4400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (878, 226, 'G1', CAST(N'2020-08-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(65.00 AS Decimal(8, 2)), 30.5500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (879, 227, 'G1', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (880, 227, 'G2', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 65.6700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (881, 228, 'G1', CAST(N'2020-05-22' AS Date), CAST(N'2020-12-21' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(298.00 AS Decimal(8, 2)), 140.0800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (882, 228, 'G2', CAST(N'2020-05-22' AS Date), CAST(N'2020-12-21' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(77.00 AS Decimal(8, 2)), 36.9100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (883, 228, 'G1', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 6.5800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (884, 228, 'G2', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(24.00 AS Decimal(8, 2)), 11.5000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (885, 228, 'G3', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(38.00 AS Decimal(8, 2)), 18.5700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (886, 228, 'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 20.2100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (887, 228, 'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 36.4300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (888, 228, 'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(116.00 AS Decimal(8, 2)), 56.7000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (889, 229, 'G1', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 6.5800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (890, 229, 'G2', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(24.00 AS Decimal(8, 2)), 11.5000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (891, 229, 'G3', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.5300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (892, 229, 'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-19' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(70.00 AS Decimal(8, 2)), 32.9000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (893, 229, 'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-19' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 58.4800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (894, 229, 'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-19' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(208.00 AS Decimal(8, 2)), 101.6600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (895, 229, 'G1', CAST(N'2021-02-20' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(56.00 AS Decimal(8, 2)), 26.3200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (896, 229, 'G2', CAST(N'2021-02-20' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(98.00 AS Decimal(8, 2)), 46.9800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (897, 229, 'G3', CAST(N'2021-02-20' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 32.2600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (898, 230, 'G1', CAST(N'2021-02-20' AS Date), CAST(N'2021-04-08' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(67.00 AS Decimal(8, 2)), 31.4900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (899, 230, 'G2', CAST(N'2021-02-20' AS Date), CAST(N'2021-04-08' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(117.00 AS Decimal(8, 2)), 56.0900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (900, 230, 'G3', CAST(N'2021-02-20' AS Date), CAST(N'2021-04-08' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 15.1500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (901, 230, 'G1', CAST(N'2021-04-09' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 34.7800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (902, 230, 'G2', CAST(N'2021-04-09' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.1300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (903, 231, 'G1', CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(52.00 AS Decimal(8, 2)), 24.4400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (904, 232, 'G1', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(65.00 AS Decimal(8, 2)), 30.5500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (905, 233, 'G1', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (906, 233, 'G2', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 65.6700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (907, 234, 'G1', CAST(N'2021-04-09' AS Date), CAST(N'2021-12-17' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(354.00 AS Decimal(8, 2)), 166.4000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (908, 234, 'G2', CAST(N'2021-04-09' AS Date), CAST(N'2021-12-17' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(91.00 AS Decimal(8, 2)), 43.6200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (909, 234, 'G1', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 9.4000)
;
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (910, 234, 'G2', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 16.3000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (911, 234, 'G3', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(53.00 AS Decimal(8, 2)), 25.9000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (912, 234, 'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 26.2800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (913, 234, 'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 47.3600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (914, 234, 'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(116.00 AS Decimal(8, 2)), 73.7100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (915, 235, 'G1', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 9.4000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (916, 235, 'G2', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 16.3000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (917, 235, 'G3', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(54.00 AS Decimal(8, 2)), 26.3900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (918, 235, 'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-16' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 40.3300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (919, 235, 'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-16' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(115.00 AS Decimal(8, 2)), 71.6700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (920, 235, 'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-16' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(180.00 AS Decimal(8, 2)), 114.3700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (921, 235, 'G1', CAST(N'2022-02-17' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(60.00 AS Decimal(8, 2)), 36.6700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (922, 235, 'G2', CAST(N'2022-02-17' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(105.00 AS Decimal(8, 2)), 65.4300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (923, 235, 'G3', CAST(N'2022-02-17' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 48.2900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (924, 236, 'G1', CAST(N'2022-02-17' AS Date), CAST(N'2022-04-28' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(99.00 AS Decimal(8, 2)), 60.5000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (925, 236, 'G2', CAST(N'2022-02-17' AS Date), CAST(N'2022-04-28' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(173.00 AS Decimal(8, 2)), 107.8100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (926, 236, 'G3', CAST(N'2022-02-17' AS Date), CAST(N'2022-04-28' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.4500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (927, 236, 'G1', CAST(N'2022-04-29' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(46.00 AS Decimal(8, 2)), 28.1100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (928, 237, 'G1', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(23.00 AS Decimal(8, 2)), 14.0500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (929, 237, 'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(23.00 AS Decimal(8, 2)), 18.2700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (930, 238, 'G1', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(58.00 AS Decimal(8, 2)), 46.0800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (931, 239, 'G1', CAST(N'2022-04-29' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 17.1100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (932, 239, 'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-11-23' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(65.00 AS Decimal(8, 2)), 51.6400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (933, 239, 'G3', CAST(N'2022-11-24' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 4.9600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (934, 240, 'G1', CAST(N'2022-11-24' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(53.00 AS Decimal(8, 2)), 42.1000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (935, 240, 'G2', CAST(N'2022-11-24' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(93.00 AS Decimal(8, 2)), 75.3400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (936, 240, 'G3', CAST(N'2022-11-24' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(46.00 AS Decimal(8, 2)), 38.0000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (937, 240, 'G1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-26' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(36.00 AS Decimal(8, 2)), 28.6000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (938, 240, 'G2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-26' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(63.00 AS Decimal(8, 2)), 51.0400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (939, 240, 'G3', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-26' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 26.4300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (940, 240, 'G3', CAST(N'2023-01-27' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.1300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (941, 241, 'G1', CAST(N'2023-01-27' AS Date), CAST(N'2023-03-23' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(78.00 AS Decimal(8, 2)), 61.9600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (942, 241, 'G2', CAST(N'2023-01-27' AS Date), CAST(N'2023-03-23' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 110.9900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (943, 241, 'G3', CAST(N'2023-01-27' AS Date), CAST(N'2023-03-23' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 12.3900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (944, 241, 'G2', CAST(N'2023-03-24' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 14.5800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (945, 242, 'G1', CAST(N'2023-03-24' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 8.7400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (946, 242, 'G2', CAST(N'2023-03-24' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.8100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (947, 242, 'G1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.1500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (948, 242, 'G2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.4800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (949, 242, 'G1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-03' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.4600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (950, 242, 'G1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.354598 AS Decimal(10, 6)), CAST(23.00 AS Decimal(8, 2)), 8.1600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1038, 261, 'G1', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1039, 261, 'G2', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(128.00 AS Decimal(8, 2)), 61.3600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1040, 262, 'G1', CAST(N'2020-05-21' AS Date), CAST(N'2020-12-15' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(291.00 AS Decimal(8, 2)), 136.7900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1041, 262, 'G2', CAST(N'2020-05-21' AS Date), CAST(N'2020-12-15' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(102.00 AS Decimal(8, 2)), 48.9000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1042, 262, 'G1', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 10.3400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1043, 262, 'G2', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 18.7000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1044, 262, 'G3', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(54.00 AS Decimal(8, 2)), 26.3900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1045, 262, 'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 20.2100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1046, 262, 'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 36.4300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1047, 262, 'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(106.00 AS Decimal(8, 2)), 51.8100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1048, 263, 'G1', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 10.3400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1049, 263, 'G2', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 18.7000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1050, 263, 'G3', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 34.7000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1051, 263, 'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 34.7800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1052, 263, 'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(129.00 AS Decimal(8, 2)), 61.8400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1053, 263, 'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(234.00 AS Decimal(8, 2)), 114.3700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1054, 263, 'G1', CAST(N'2021-02-23' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(52.00 AS Decimal(8, 2)), 24.4400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1055, 263, 'G2', CAST(N'2021-02-23' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 43.1400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1056, 263, 'G3', CAST(N'2021-02-23' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(48.00 AS Decimal(8, 2)), 23.4600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1057, 264, 'G1', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 33.3700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1058, 264, 'G2', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(124.00 AS Decimal(8, 2)), 59.4400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1059, 264, 'G3', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 34.7000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1060, 264, 'G1', CAST(N'2021-04-15' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 31.0200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1061, 264, 'G2', CAST(N'2021-04-15' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.9800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1062, 265, 'G1', CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 23.5000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1063, 266, 'G1', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(63.00 AS Decimal(8, 2)), 29.6100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1064, 267, 'G1', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1065, 267, 'G2', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(128.00 AS Decimal(8, 2)), 61.3600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1066, 268, 'G1', CAST(N'2021-04-15' AS Date), CAST(N'2021-12-13' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(340.00 AS Decimal(8, 2)), 159.8200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1067, 268, 'G2', CAST(N'2021-04-15' AS Date), CAST(N'2021-12-13' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(231.00 AS Decimal(8, 2)), 110.7400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1068, 268, 'G1', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.7500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1069, 268, 'G2', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(44.00 AS Decimal(8, 2)), 21.0900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1070, 268, 'G3', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(60.00 AS Decimal(8, 2)), 29.3300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1071, 268, 'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 26.2800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1072, 268, 'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 47.3600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1073, 268, 'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(106.00 AS Decimal(8, 2)), 67.3500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1074, 269, 'G1', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.7500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1075, 269, 'G2', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(44.00 AS Decimal(8, 2)), 21.0900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1076, 269, 'G3', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(97.00 AS Decimal(8, 2)), 47.4100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1077, 269, 'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 45.2200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1078, 269, 'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(129.00 AS Decimal(8, 2)), 80.3900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1079, 269, 'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(287.00 AS Decimal(8, 2)), 182.3600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1080, 269, 'G1', CAST(N'2022-02-23' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(52.00 AS Decimal(8, 2)), 31.7800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1081, 269, 'G2', CAST(N'2022-02-23' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 56.0900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1082, 269, 'G3', CAST(N'2022-02-23' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(48.00 AS Decimal(8, 2)), 30.5000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1083, 270, 'G1', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(82.00 AS Decimal(8, 2)), 50.1100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1084, 270, 'G2', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(144.00 AS Decimal(8, 2)), 89.7400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1085, 270, 'G3', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(205.00 AS Decimal(8, 2)), 130.2600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1086, 270, 'G1', CAST(N'2022-04-23' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(54.00 AS Decimal(8, 2)), 33.0000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1087, 270, 'G2', CAST(N'2022-04-23' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 6.8600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1088, 271, 'G1', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 17.7200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1089, 271, 'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 23.0400)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1090, 272, 'G1', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 57.2000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1091, 273, 'G1', CAST(N'2022-04-23' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 30.5500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1092, 273, 'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-11-14' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(99.00 AS Decimal(8, 2)), 78.6500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1093, 273, 'G3', CAST(N'2022-11-15' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 25.6100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1094, 274, 'G1', CAST(N'2022-11-15' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 52.4300)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1095, 274, 'G2', CAST(N'2022-11-15' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(115.00 AS Decimal(8, 2)), 93.1700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1096, 274, 'G3', CAST(N'2022-11-15' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(150.00 AS Decimal(8, 2)), 123.9000)
;
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1097, 274, 'G1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 34.1600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1098, 274, 'G2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 61.5700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1099, 274, 'G3', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(99.00 AS Decimal(8, 2)), 81.7800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1100, 275, 'G3', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(152.00 AS Decimal(8, 2)), 125.5600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1101, 276, 'G1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 30.9800)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1102, 276, 'G2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(68.00 AS Decimal(8, 2)), 55.0900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1103, 276, 'G3', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(38.00 AS Decimal(8, 2)), 31.3900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1104, 276, 'G1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 34.1600)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1105, 276, 'G2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 61.5700)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1106, 276, 'G3', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 34.6900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1107, 276, 'G1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.1500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1108, 276, 'G2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(73.00 AS Decimal(8, 2)), 35.0200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1109, 276, 'G3', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(40.00 AS Decimal(8, 2)), 19.1900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1110, 276, 'G1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.1900)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1111, 276, 'G2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 3.6500)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1112, 276, 'G3', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 1.8200)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1113, 276, 'G1', CAST(N'2023-05-05' AS Date), CAST(N'2023-05-15' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 5.1000)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1114, 276, 'G1', CAST(N'2023-05-16' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 4.0100)
INSERT GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1115, 276, 'G1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.354598 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 7.0900)
SET IDENTITY_INSERT GASConsumo OFF
SET IDENTITY_INSERT GASFattura ON 

INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (201, 3, 2019, CAST(N'2019-11-14' AS Date), 2019, '10107788', CAST(N'2019-08-01' AS Date), CAST(N'2019-09-30' AS Date), NULL, CAST(N'2019-09-30' AS Date), NULL, NULL, CAST(N'2019-08-01' AS Date), NULL, NULL, 0.0700, 0.3600, 0.0000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (202, 3, 2020, CAST(N'2020-01-15' AS Date), 2020, '120015400', CAST(N'2019-10-01' AS Date), CAST(N'2019-11-30' AS Date), NULL, CAST(N'2019-11-30' AS Date), NULL, NULL, CAST(N'2019-10-01' AS Date), NULL, NULL, 0.0700, 0.3600, 5.5100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (203, 3, 2020, CAST(N'2020-03-13' AS Date), 2020, '120025438', CAST(N'2019-12-01' AS Date), CAST(N'2020-01-31' AS Date), NULL, CAST(N'2020-01-31' AS Date), NULL, NULL, CAST(N'2019-12-14' AS Date), NULL, NULL, 6.4800, 0.3600, 164.7900)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (204, 3, 2020, CAST(N'2020-05-16' AS Date), 2020, '120051904', CAST(N'2020-02-01' AS Date), CAST(N'2020-03-31' AS Date), NULL, CAST(N'2020-03-31' AS Date), NULL, NULL, CAST(N'2020-02-19' AS Date), NULL, NULL, 6.4200, 0.3600, 163.3300)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (205, 3, 2020, CAST(N'2020-09-09' AS Date), 2020, '120088801', CAST(N'2020-06-01' AS Date), CAST(N'2020-07-31' AS Date), NULL, CAST(N'2020-07-31' AS Date), NULL, NULL, CAST(N'2020-06-01' AS Date), NULL, NULL, 0.0700, 0.3600, 0.0000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (206, 3, 2020, CAST(N'2020-11-13' AS Date), 2020, '120107222', CAST(N'2020-08-01' AS Date), CAST(N'2020-09-30' AS Date), NULL, CAST(N'2020-09-30' AS Date), NULL, NULL, CAST(N'2020-08-01' AS Date), NULL, NULL, 0.0700, 0.3600, 0.0000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (207, 3, 2021, CAST(N'2021-01-14' AS Date), 2021, '12015014', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), NULL, CAST(N'2020-11-30' AS Date), NULL, NULL, CAST(N'2020-10-01' AS Date), NULL, NULL, 0.0700, 0.3600, 5.0100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (208, 3, 2021, CAST(N'2021-03-15' AS Date), 2021, '12025158', CAST(N'2020-12-01' AS Date), CAST(N'2021-01-31' AS Date), NULL, CAST(N'2021-01-31' AS Date), NULL, NULL, CAST(N'2020-12-16' AS Date), NULL, NULL, 4.4000, 0.3600, 111.9600)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (209, 3, 2021, CAST(N'2021-05-13' AS Date), 2021, '12043637', CAST(N'2021-02-01' AS Date), CAST(N'2021-03-31' AS Date), NULL, CAST(N'2021-03-31' AS Date), NULL, NULL, CAST(N'2021-02-23' AS Date), NULL, NULL, 7.9800, 0.3600, 202.9400)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (210, 3, 2021, CAST(N'2021-07-29' AS Date), 2021, '12070438', CAST(N'2021-04-01' AS Date), CAST(N'2021-05-31' AS Date), NULL, CAST(N'2021-05-31' AS Date), NULL, NULL, CAST(N'2021-04-15' AS Date), NULL, NULL, 3.3800, 0.3600, 85.8100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (211, 3, 2021, CAST(N'2021-11-15' AS Date), 2021, '12107174', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), NULL, CAST(N'2021-09-30' AS Date), NULL, NULL, CAST(N'2021-08-01' AS Date), NULL, NULL, 0.0700, 0.3600, 0.0000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (212, 3, 2022, CAST(N'2022-03-16' AS Date), 2022, '1233693', CAST(N'2021-12-01' AS Date), CAST(N'2022-01-31' AS Date), NULL, CAST(N'2022-01-31' AS Date), NULL, NULL, CAST(N'2021-12-14' AS Date), NULL, NULL, 5.9800, 0.3600, 152.1500)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (213, 3, 2022, CAST(N'2022-05-16' AS Date), 2022, '1252325', CAST(N'2022-02-01' AS Date), CAST(N'2022-03-31' AS Date), NULL, CAST(N'2022-03-31' AS Date), NULL, NULL, CAST(N'2022-02-23' AS Date), NULL, NULL, 9.5500, 0.3600, 242.8800)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (214, 3, 2022, CAST(N'2022-07-12' AS Date), 2022, '1262434', CAST(N'2022-04-01' AS Date), CAST(N'2022-05-31' AS Date), NULL, CAST(N'2022-05-31' AS Date), NULL, NULL, CAST(N'2022-04-23' AS Date), NULL, NULL, 5.3400, 0.3600, 135.7700)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (215, 3, 2022, CAST(N'2022-09-14' AS Date), 2022, '1281022', CAST(N'2022-06-01' AS Date), CAST(N'2022-07-31' AS Date), NULL, CAST(N'2022-07-31' AS Date), NULL, NULL, CAST(N'2022-06-01' AS Date), NULL, NULL, 1.1000, 0.3600, 28.0000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (216, 3, 2022, CAST(N'2022-11-14' AS Date), 2022, '1299503', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), NULL, CAST(N'2022-09-30' AS Date), NULL, NULL, CAST(N'2022-08-01' AS Date), NULL, NULL, 1.5300, 0.3600, 38.8800)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (217, 3, 2023, CAST(N'2023-01-13' AS Date), 2023, '6499', CAST(N'2022-10-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-11-30' AS Date), NULL, NULL, NULL, NULL, NULL, 4.9900, 0.3600, 126.9600)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (218, 3, 2023, CAST(N'2023-03-22' AS Date), 2023, '33600', CAST(N'2022-12-01' AS Date), CAST(N'2023-01-31' AS Date), NULL, CAST(N'2022-12-02' AS Date), NULL, NULL, NULL, CAST(N'2023-01-31' AS Date), NULL, 6.4900, 0.3600, 165.1100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (219, 3, 2023, CAST(N'2023-07-14' AS Date), 2023, '2033084', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-31' AS Date), NULL, NULL, NULL, NULL, NULL, 6.7500, 0.3600, 171.7300)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (220, 3, 2023, CAST(N'2023-09-18' AS Date), 2023, '2043292', CAST(N'2023-04-01' AS Date), CAST(N'2023-06-30' AS Date), NULL, CAST(N'2023-05-04' AS Date), NULL, NULL, NULL, NULL, NULL, 0.5500, 0.3600, 13.9000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (221, 1, 2020, CAST(N'2020-01-15' AS Date), 2020, '120013992', CAST(N'2019-10-01' AS Date), CAST(N'2019-11-30' AS Date), NULL, CAST(N'2019-11-30' AS Date), NULL, NULL, CAST(N'2019-10-01' AS Date), NULL, NULL, 4.4000, 0.3600, 111.8000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (222, 1, 2020, CAST(N'2020-03-13' AS Date), 2020, '120024048', CAST(N'2019-12-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(N'2019-05-23' AS Date), CAST(N'2019-12-18' AS Date), NULL, NULL, CAST(N'2019-12-19' AS Date), CAST(N'2020-01-31' AS Date), -165.7900, 5.8000, 0.3600, 147.4000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (223, 1, 2020, CAST(N'2020-05-16' AS Date), 2020, '120050518', CAST(N'2020-02-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(N'2019-12-19' AS Date), CAST(N'2020-02-24' AS Date), NULL, NULL, CAST(N'2020-02-25' AS Date), CAST(N'2020-03-31' AS Date), -161.1000, 6.0400, 0.3600, 153.4800)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (224, 1, 2020, CAST(N'2020-07-16' AS Date), 2020, '120069042', CAST(N'2020-04-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(N'2020-02-25' AS Date), CAST(N'2020-05-21' AS Date), NULL, NULL, CAST(N'2020-05-22' AS Date), CAST(N'2020-05-31' AS Date), -91.5800, 1.6100, 0.3600, 40.7700)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (225, 1, 2020, CAST(N'2020-09-09' AS Date), 2020, '120087431', CAST(N'2020-06-01' AS Date), CAST(N'2020-07-31' AS Date), NULL, CAST(N'2020-07-31' AS Date), NULL, NULL, CAST(N'2020-06-01' AS Date), NULL, NULL, 1.0700, 0.3600, 27.1100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (226, 1, 2020, CAST(N'2020-11-13' AS Date), 2020, '120105879', CAST(N'2020-08-01' AS Date), CAST(N'2020-09-30' AS Date), NULL, CAST(N'2020-09-30' AS Date), NULL, NULL, CAST(N'2020-08-01' AS Date), NULL, NULL, 1.3200, 0.3600, 33.4700)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (227, 1, 2021, CAST(N'2021-01-14' AS Date), 2021, '12013676', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), NULL, CAST(N'2020-11-30' AS Date), NULL, NULL, CAST(N'2020-10-01' AS Date), NULL, NULL, 4.4000, 0.3600, 111.8000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (228, 1, 2021, CAST(N'2021-03-15' AS Date), 2021, '12023848', CAST(N'2020-12-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(N'2020-05-22' AS Date), CAST(N'2020-12-21' AS Date), NULL, NULL, CAST(N'2020-12-22' AS Date), CAST(N'2021-01-31' AS Date), -166.7300, 6.6400, 0.3600, 168.7700)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (229, 1, 2021, CAST(N'2021-05-13' AS Date), 2021, '12042330', CAST(N'2021-02-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(N'2020-12-22' AS Date), CAST(N'2021-02-19' AS Date), NULL, NULL, CAST(N'2021-02-20' AS Date), CAST(N'2021-03-31' AS Date), -149.9900, 7.7400, 0.3600, 196.8000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (230, 1, 2021, CAST(N'2021-07-29' AS Date), 2021, '12069178', CAST(N'2021-04-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(N'2021-02-20' AS Date), CAST(N'2021-04-08' AS Date), NULL, NULL, CAST(N'2021-04-09' AS Date), CAST(N'2021-05-31' AS Date), -105.5600, 2.2000, 0.3600, 55.8800)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (231, 1, 2021, CAST(N'2021-09-20' AS Date), 2021, '12087506', CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), NULL, CAST(N'2021-07-31' AS Date), NULL, NULL, CAST(N'2021-06-01' AS Date), NULL, NULL, 1.0700, 0.3600, 27.1100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (232, 1, 2021, CAST(N'2021-11-15' AS Date), 2021, '12105923', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), NULL, CAST(N'2021-09-30' AS Date), NULL, NULL, CAST(N'2021-08-01' AS Date), NULL, NULL, 1.3200, 0.3600, 33.4700)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (233, 1, 2022, CAST(N'2022-01-13' AS Date), 2022, '1205461', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), NULL, CAST(N'2021-11-30' AS Date), NULL, NULL, CAST(N'2021-10-01' AS Date), NULL, NULL, 4.4000, 0.3600, 111.8000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (234, 1, 2022, CAST(N'2022-03-16' AS Date), 2022, '1232466', CAST(N'2021-12-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(N'2021-04-09' AS Date), CAST(N'2021-12-17' AS Date), NULL, NULL, CAST(N'2021-12-18' AS Date), CAST(N'2022-01-31' AS Date), -215.5300, 8.0000, 0.3600, 203.3700)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (235, 1, 2022, CAST(N'2022-05-16' AS Date), 2022, '1251102', CAST(N'2022-02-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(N'2021-12-18' AS Date), CAST(N'2022-02-16' AS Date), NULL, NULL, CAST(N'2022-02-17' AS Date), CAST(N'2022-03-31' AS Date), -198.9500, 9.4900, 0.3600, 241.3000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (236, 1, 2022, CAST(N'2022-07-12' AS Date), 2022, '1261218', CAST(N'2022-04-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(N'2022-02-17' AS Date), CAST(N'2022-04-28' AS Date), NULL, NULL, CAST(N'2022-04-29' AS Date), CAST(N'2022-05-31' AS Date), -150.3900, 2.1400, 0.3600, 54.2200)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (237, 1, 2022, CAST(N'2022-09-14' AS Date), 2022, '1279815', CAST(N'2022-06-01' AS Date), CAST(N'2022-07-31' AS Date), NULL, CAST(N'2022-07-31' AS Date), NULL, NULL, CAST(N'2022-06-01' AS Date), NULL, NULL, 1.3900, 0.3600, 35.3100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (238, 1, 2022, CAST(N'2022-11-14' AS Date), 2022, '1298310', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), NULL, CAST(N'2022-09-30' AS Date), NULL, NULL, CAST(N'2022-08-01' AS Date), NULL, NULL, 1.9500, 0.3600, 49.6300)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (239, 1, 2023, CAST(N'2023-01-13' AS Date), 2023, '5309', CAST(N'2022-10-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-11-23' AS Date), NULL, NULL, NULL, CAST(N'2022-11-30' AS Date), NULL, -0.3900, 0.3600, 0.0000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (240, 1, 2023, CAST(N'2023-05-16' AS Date), 2023, '2013566', CAST(N'2022-12-01' AS Date), CAST(N'2023-01-31' AS Date), NULL, CAST(N'2023-01-26' AS Date), NULL, NULL, NULL, CAST(N'2023-01-31' AS Date), NULL, 10.4900, 0.3600, 256.8900)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (241, 1, 2023, CAST(N'2023-07-14' AS Date), 2023, '2031916', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-23' AS Date), NULL, NULL, NULL, CAST(N'2023-03-31' AS Date), NULL, 7.8200, 0.3600, 198.9200)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (242, 1, 2023, CAST(N'2023-09-18' AS Date), 2023, '2042139', CAST(N'2023-04-01' AS Date), CAST(N'2023-06-30' AS Date), NULL, CAST(N'2023-05-03' AS Date), NULL, NULL, NULL, CAST(N'2023-06-30' AS Date), NULL, 1.7800, 0.3600, 45.3100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (261, 2, 2021, CAST(N'2021-01-14' AS Date), 2021, '12012973', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), NULL, NULL, NULL, NULL, CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), NULL, 4.2200, 0.3600, 107.3000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (262, 2, 2021, CAST(N'2021-03-15' AS Date), 2021, '12023146', CAST(N'2020-12-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(N'2020-05-21' AS Date), CAST(N'2020-12-15' AS Date), NULL, NULL, CAST(N'2020-12-16' AS Date), CAST(N'2021-01-31' AS Date), -160.5400, 7.8200, 0.3600, 198.7800)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (263, 2, 2021, CAST(N'2021-05-13' AS Date), 2021, '12041633', CAST(N'2021-02-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(N'2020-12-16' AS Date), CAST(N'2021-02-22' AS Date), NULL, NULL, CAST(N'2021-02-23' AS Date), CAST(N'2021-03-31' AS Date), -163.8800, 8.3400, 0.3600, 212.1000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (264, 2, 2021, CAST(N'2021-07-29' AS Date), 2021, '12068492', CAST(N'2021-04-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), NULL, NULL, CAST(N'2021-04-15' AS Date), CAST(N'2021-05-31' AS Date), -91.0400, 3.3200, 0.3600, 84.3900)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (265, 2, 2021, CAST(N'2021-09-20' AS Date), 2021, '12086823', CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), NULL, NULL, NULL, NULL, CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), NULL, 1.0300, 0.3600, 26.1300)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (266, 2, 2021, CAST(N'2021-11-15' AS Date), 2021, '12105242', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), NULL, NULL, NULL, NULL, CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), NULL, 1.2800, 0.3600, 32.4900)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (267, 2, 2022, CAST(N'2022-01-13' AS Date), 2022, '1204787', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), NULL, NULL, NULL, NULL, CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), NULL, 4.2200, 0.3600, 107.3000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (268, 2, 2022, CAST(N'2022-03-16' AS Date), 2022, '1231796', CAST(N'2021-12-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(N'2021-04-15' AS Date), CAST(N'2021-12-13' AS Date), NULL, NULL, CAST(N'2021-12-14' AS Date), CAST(N'2022-01-31' AS Date), -197.4300, 11.3900, 0.3600, 289.7400)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (269, 2, 2022, CAST(N'2022-05-16' AS Date), 2022, '1250434', CAST(N'2022-02-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(N'2021-12-14' AS Date), CAST(N'2022-02-22' AS Date), NULL, NULL, CAST(N'2022-02-23' AS Date), CAST(N'2022-03-31' AS Date), -203.1600, 12.5000, 0.3600, 317.9600)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (270, 2, 2022, CAST(N'2022-07-12' AS Date), 2022, '1260558', CAST(N'2022-04-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), NULL, NULL, CAST(N'2022-04-23' AS Date), CAST(N'2022-05-31' AS Date), -118.3700, 7.9200, 0.3600, 201.4200)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (271, 2, 2022, CAST(N'2022-09-14' AS Date), 2022, '1279157', CAST(N'2022-06-01' AS Date), CAST(N'2022-07-31' AS Date), NULL, NULL, NULL, NULL, CAST(N'2022-06-01' AS Date), CAST(N'2022-07-31' AS Date), NULL, 1.7400, 0.3600, 44.1000)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (272, 2, 2022, CAST(N'2022-11-14' AS Date), 2022, '1297658', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), NULL, NULL, NULL, NULL, CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), NULL, 2.4100, 0.3600, 61.2100)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (273, 2, 2023, CAST(N'2023-01-13' AS Date), 2023, '4659', CAST(N'2022-10-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, NULL, CAST(N'2022-04-23' AS Date), CAST(N'2022-11-14' AS Date), NULL, NULL, NULL, 1.9500, 0.3600, 49.6200)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (274, 2, 2023, CAST(N'2023-05-16' AS Date), 2023, '2012924', CAST(N'2022-12-01' AS Date), CAST(N'2023-01-31' AS Date), NULL, NULL, CAST(N'2022-11-15' AS Date), CAST(N'2023-01-31' AS Date), NULL, NULL, NULL, 15.3300, 0.3600, 389.8600)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (275, 2, 2023, CAST(N'2023-07-14' AS Date), 2023, '2031279', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12.6700, 0.3600, 322.0600)
INSERT GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (276, 2, 2023, CAST(N'2023-09-18' AS Date), 2023, '2041500', CAST(N'2023-04-01' AS Date), CAST(N'2023-06-30' AS Date), NULL, NULL, CAST(N'2023-02-01' AS Date), CAST(N'2023-05-04' AS Date), NULL, NULL, NULL, 3.9300, 0.3600, 99.7400)
SET IDENTITY_INSERT GASFattura OFF
SET IDENTITY_INSERT GASLettura ON 

INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (707, 201, 81240, CAST(N'2019-05-17' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (708, 201, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (709, 201, NULL, NULL, 'tot', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (710, 202, 81240, CAST(N'2019-05-17' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (711, 202, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (712, 202, NULL, NULL, 'tot', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (713, 203, 81240, CAST(N'2019-05-17' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (714, 203, 81572, CAST(N'2019-12-13' AS Date), 'eff', 332)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (715, 203, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (716, 203, NULL, NULL, 'tot', 332)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (717, 204, 81572, CAST(N'2019-12-13' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (718, 204, 81896, CAST(N'2020-02-18' AS Date), 'eff', 324)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (719, 204, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (720, 204, NULL, NULL, 'tot', 324)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (721, 205, 82137, CAST(N'2020-05-20' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (722, 205, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (723, 205, NULL, NULL, 'tot', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (724, 206, 82137, CAST(N'2020-05-20' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (725, 206, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (726, 206, NULL, NULL, 'tot', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (727, 207, 82137, CAST(N'2020-05-20' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (728, 207, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (729, 207, NULL, NULL, 'tot', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (730, 208, 82137, CAST(N'2020-05-20' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (731, 208, 82362, CAST(N'2020-12-15' AS Date), 'eff', 225)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (732, 208, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (733, 208, NULL, NULL, 'tot', 225)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (734, 209, 82362, CAST(N'2020-12-15' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (735, 209, 82764, CAST(N'2021-02-22' AS Date), 'eff', 402)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (736, 209, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (737, 209, NULL, NULL, 'tot', 402)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (738, 210, 82764, CAST(N'2021-02-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (739, 210, 82934, CAST(N'2021-04-14' AS Date), 'eff', 170)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (740, 210, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (741, 210, NULL, NULL, 'tot', 170)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (742, 211, 82934, CAST(N'2021-04-14' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (743, 211, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (744, 211, NULL, NULL, 'tot', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (745, 212, 82934, CAST(N'2021-04-14' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (746, 212, 83241, CAST(N'2021-12-13' AS Date), 'eff', 307)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (747, 212, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (748, 212, NULL, NULL, 'tot', 307)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (749, 213, 83241, CAST(N'2021-12-13' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (750, 213, 83635, CAST(N'2022-02-22' AS Date), 'eff', 394)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (751, 213, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (752, 213, NULL, NULL, 'tot', 394)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (753, 214, 83635, CAST(N'2022-02-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (754, 214, 83843, CAST(N'2022-04-22' AS Date), 'eff', 208)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (755, 214, NULL, NULL, 'stim', 0)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (756, 214, NULL, NULL, 'tot', 208)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (757, 215, 83843, CAST(N'2022-04-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (758, 215, NULL, NULL, 'stim', 36)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (759, 215, NULL, NULL, 'tot', 36)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (760, 216, 83843, CAST(N'2022-04-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (761, 216, NULL, NULL, 'stim', 45)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (762, 216, NULL, NULL, 'tot', 45)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (763, 217, 83843, CAST(N'2022-04-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (764, 217, NULL, NULL, 'stim', 150)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (765, 217, NULL, NULL, 'tot', 150)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (766, 218, 83843, CAST(N'2022-04-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (767, 218, 83963, CAST(N'2022-12-02' AS Date), 'eff', 120)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (768, 218, NULL, NULL, 'stim', 308)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (769, 218, NULL, NULL, 'tot', 428)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (770, 219, 84236, CAST(N'2023-01-31' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (771, 219, NULL, NULL, 'stim', 203)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (772, 219, NULL, NULL, 'tot', 203)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (773, 220, 84236, CAST(N'2023-01-31' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (774, 220, 84457, CAST(N'2023-05-04' AS Date), 'eff', 221)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (775, 220, 84470, CAST(N'2023-06-30' AS Date), 'eff', 13)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (776, 220, NULL, NULL, 'tot', 234)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (777, 221, 6629, CAST(N'2019-05-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (778, 221, NULL, NULL, 'stim', 222)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (779, 221, NULL, NULL, 'tot', 222)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (780, 222, 6629, CAST(N'2019-05-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (781, 222, 6936, CAST(N'2019-12-18' AS Date), 'eff', 307)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (782, 222, NULL, NULL, 'stim', 334)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (783, 222, NULL, NULL, 'tot', 641)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (784, 223, 6936, CAST(N'2019-12-18' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (785, 223, 7383, CAST(N'2020-02-24' AS Date), 'eff', 447)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (786, 223, NULL, NULL, 'stim', 191)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (787, 223, NULL, NULL, 'tot', 638)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (788, 224, 7383, CAST(N'2020-02-24' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (789, 224, 7642, CAST(N'2020-05-21' AS Date), 'eff', 259)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (790, 224, NULL, NULL, 'stim', 13)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (791, 224, NULL, NULL, 'tot', 272)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (792, 225, 7642, CAST(N'2020-05-21' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (793, 225, NULL, NULL, 'stim', 52)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (794, 225, NULL, NULL, 'tot', 52)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (795, 226, 7642, CAST(N'2020-05-21' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (796, 226, NULL, NULL, 'stim', 65)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (797, 226, NULL, NULL, 'tot', 65)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (798, 227, 7642, CAST(N'2020-05-21' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (799, 227, NULL, NULL, 'stim', 222)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (800, 227, NULL, NULL, 'tot', 222)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (801, 228, 7642, CAST(N'2020-05-21' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (802, 228, 8017, CAST(N'2020-12-21' AS Date), 'eff', 375)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (803, 228, NULL, NULL, 'stim', 311)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (804, 228, NULL, NULL, 'tot', 686)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (805, 229, 8017, CAST(N'2020-12-21' AS Date), 'eff', NULL)
;
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (806, 229, 8497, CAST(N'2021-02-19' AS Date), 'eff', 480)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (807, 229, NULL, NULL, 'stim', 220)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (808, 229, NULL, NULL, 'tot', 700)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (809, 230, 8497, CAST(N'2021-02-19' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (810, 230, 8712, CAST(N'2021-04-08' AS Date), 'eff', 215)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (811, 230, NULL, NULL, 'stim', 116)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (812, 230, NULL, NULL, 'tot', 331)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (813, 231, 8712, CAST(N'2021-04-08' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (814, 231, NULL, NULL, 'stim', 52)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (815, 231, NULL, NULL, 'tot', 52)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (816, 232, 8712, CAST(N'2021-04-08' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (817, 232, NULL, NULL, 'stim', 65)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (818, 232, NULL, NULL, 'tot', 65)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (819, 233, 8712, CAST(N'2021-04-08' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (820, 233, NULL, NULL, 'stim', 222)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (821, 233, NULL, NULL, 'tot', 222)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (822, 234, 8712, CAST(N'2021-04-08' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (823, 234, 9157, CAST(N'2021-12-17' AS Date), 'eff', 445)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (824, 234, NULL, NULL, 'stim', 342)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (825, 234, NULL, NULL, 'tot', 787)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (826, 235, 9157, CAST(N'2021-12-17' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (827, 235, 9626, CAST(N'2022-02-16' AS Date), 'eff', 469)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (828, 235, NULL, NULL, 'stim', 241)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (829, 235, NULL, NULL, 'tot', 710)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (830, 236, 9626, CAST(N'2022-02-16' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (831, 236, 9905, CAST(N'2022-04-28' AS Date), 'eff', 279)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (832, 236, NULL, NULL, 'stim', 46)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (833, 236, NULL, NULL, 'tot', 325)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (834, 237, 9905, CAST(N'2022-04-28' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (835, 237, NULL, NULL, 'stim', 46)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (836, 237, NULL, NULL, 'tot', 46)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (837, 238, 9905, CAST(N'2022-04-28' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (838, 238, NULL, NULL, 'stim', 58)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (839, 238, NULL, NULL, 'tot', 58)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (840, 239, 9905, CAST(N'2022-04-28' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (841, 239, 9998, CAST(N'2022-11-23' AS Date), 'eff', 93)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (842, 239, NULL, NULL, 'stim', 33)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (843, 239, NULL, NULL, 'tot', 126)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (844, 240, 9998, CAST(N'2022-11-23' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (845, 240, 10321, CAST(N'2023-01-26' AS Date), 'eff', 323)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (846, 240, NULL, NULL, 'stim', 24)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (847, 240, NULL, NULL, 'tot', 347)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (848, 241, 10321, CAST(N'2023-01-26' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (849, 241, 10551, CAST(N'2023-03-23' AS Date), 'auto', 230)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (850, 241, NULL, NULL, 'stim', 29)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (851, 241, NULL, NULL, 'tot', 259)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (852, 242, 10551, CAST(N'2023-03-23' AS Date), 'auto', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (853, 242, 10610, CAST(N'2023-05-03' AS Date), 'eff', 59)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (854, 242, NULL, NULL, 'stim', 44)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (855, 242, NULL, NULL, 'tot', 103)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (920, 261, 39819, CAST(N'2020-05-20' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (921, 261, NULL, NULL, 'stim', 213)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (922, 261, NULL, NULL, 'tot', 213)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (923, 262, 39819, CAST(N'2020-05-20' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (924, 262, 40212, CAST(N'2020-12-15' AS Date), 'eff', 393)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (925, 262, NULL, NULL, 'stim', 340)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (926, 262, NULL, NULL, 'tot', 733)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (927, 263, 40212, CAST(N'2020-12-15' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (928, 263, 40781, CAST(N'2021-02-22' AS Date), 'eff', 569)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (929, 263, NULL, NULL, 'stim', 190)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (930, 263, NULL, NULL, 'tot', 759)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (931, 264, 40781, CAST(N'2021-02-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (932, 264, 41047, CAST(N'2021-04-14' AS Date), 'eff', 266)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (933, 264, NULL, NULL, 'stim', 91)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (934, 264, NULL, NULL, 'tot', 357)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (935, 265, 41047, CAST(N'2021-04-14' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (936, 265, NULL, NULL, 'stim', 50)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (937, 265, NULL, NULL, 'tot', 50)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (938, 266, 41047, CAST(N'2021-04-14' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (939, 266, NULL, NULL, 'stim', 63)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (940, 266, NULL, NULL, 'tot', 63)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (941, 267, 41047, CAST(N'2021-04-14' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (942, 267, NULL, NULL, 'stim', 213)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (943, 267, NULL, NULL, 'tot', 213)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (944, 268, 41047, CAST(N'2021-04-14' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (945, 268, 41618, CAST(N'2021-12-13' AS Date), 'eff', 571)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (946, 268, NULL, NULL, 'stim', 354)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (947, 268, NULL, NULL, 'tot', 925)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (948, 269, 41618, CAST(N'2021-12-13' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (949, 269, 42274, CAST(N'2022-02-22' AS Date), 'eff', 656)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (950, 269, NULL, NULL, 'stim', 190)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (951, 269, NULL, NULL, 'tot', 846)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (952, 270, 42274, CAST(N'2022-02-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (953, 270, 42705, CAST(N'2022-04-22' AS Date), 'eff', 431)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (954, 270, NULL, NULL, 'stim', 65)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (955, 270, NULL, NULL, 'tot', 496)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (956, 271, 42705, CAST(N'2022-04-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (957, 271, NULL, NULL, 'stim', 58)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (958, 271, NULL, NULL, 'tot', 58)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (959, 272, 42705, CAST(N'2022-04-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (960, 272, NULL, NULL, 'stim', 72)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (961, 272, NULL, NULL, 'tot', 72)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (962, 273, 42705, CAST(N'2022-04-22' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (963, 273, 42854, CAST(N'2022-11-14' AS Date), 'eff', 149)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (964, 273, NULL, NULL, 'stim', 92)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (965, 273, NULL, NULL, 'tot', 241)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (966, 274, 42854, CAST(N'2022-11-14' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (967, 274, 43403, CAST(N'2023-01-31' AS Date), 'eff', 549)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (968, 274, NULL, NULL, 'tot', 549)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (969, 275, 43403, CAST(N'2023-01-31' AS Date), 'eff', NULL)
;
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (970, 275, NULL, NULL, 'stim', 378)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (971, 275, NULL, NULL, 'tot', 378)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (972, 276, 43403, CAST(N'2023-01-31' AS Date), 'eff', NULL)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (973, 276, 43885, CAST(N'2023-05-04' AS Date), 'eff', 482)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (974, 276, 43899, CAST(N'2023-05-15' AS Date), 'auto', 14)
INSERT GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (975, 276, NULL, NULL, 'tot', 527)
SET IDENTITY_INSERT GASLettura OFF
SET IDENTITY_INSERT H2OConsumo ON 

INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1200, 101, 'S1', CAST(N'2019-06-11' AS Date), CAST(N'2019-09-24' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 5.2600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1201, 101, 'S1', CAST(N'2019-06-11' AS Date), CAST(N'2019-09-24' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 6.9000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1202, 101, 'F', CAST(N'2019-07-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1203, 101, 'S1', CAST(N'2019-09-25' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.4800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1204, 101, 'S1', CAST(N'2019-09-25' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1205, 102, 'S1', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.8700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1206, 102, 'S1', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1207, 102, 'F', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1208, 102, 'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.8700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1209, 102, 'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1210, 102, 'F', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(60.00 AS Decimal(8, 2)), 0.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1211, 103, 'S1', CAST(N'2019-09-25' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 9.0900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1212, 103, 'S2', CAST(N'2019-09-25' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.7500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1213, 103, 'S1', CAST(N'2019-09-25' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 11.9200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1214, 103, 'S2', CAST(N'2019-09-25' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 5.6500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1215, 103, 'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-22' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 13.4000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1216, 103, 'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-22' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 13.6100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1217, 103, 'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 17.5700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1218, 103, 'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 8.7800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1219, 103, 'F', CAST(N'2020-03-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1220, 103, 'S1', CAST(N'2020-05-23' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.9100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1221, 103, 'S1', CAST(N'2020-05-23' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1222, 104, 'S1', CAST(N'2020-05-23' AS Date), CAST(N'2020-08-18' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1223, 104, 'S1', CAST(N'2020-05-23' AS Date), CAST(N'2020-08-18' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 3.1400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1224, 104, 'F', CAST(N'2020-07-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1225, 104, 'S1', CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 7.1800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1226, 104, 'S2', CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 6.8100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1227, 104, 'S1', CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 9.4100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1228, 104, 'S2', CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1229, 105, 'S1', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 3.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1230, 105, 'S2', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 6.8100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1231, 105, 'S3', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 2.9900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1232, 105, 'S1', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1233, 105, 'S2', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1234, 105, 'S3', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1235, 105, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 15.3100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1236, 105, 'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 31.1100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1237, 105, 'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 13.4500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1238, 105, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 20.0800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1239, 105, 'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 20.0800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1240, 105, 'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 5.6500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1241, 105, 'F', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1242, 106, 'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 3.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1243, 106, 'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1244, 106, 'F', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1245, 106, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 4.7800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1246, 106, 'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 9.7200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1247, 106, 'S3', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 4.4800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1248, 106, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1249, 106, 'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1250, 106, 'S3', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1251, 107, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 9.5700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1252, 107, 'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.7500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1253, 107, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 12.5500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1254, 107, 'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 5.6500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1255, 107, 'F', CAST(N'2021-11-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1256, 107, 'S1', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.4800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1257, 107, 'S1', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1258, 107, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.9100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1259, 107, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1260, 107, 'F', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(59.00 AS Decimal(8, 2)), 0.5000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1261, 108, 'S1', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 0.9600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1262, 108, 'S2', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.9400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1263, 108, 'S1', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1264, 108, 'S2', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1265, 108, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.6100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1266, 108, 'S2', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 17.5000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1267, 108, 'S3', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 4.4800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1268, 108, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1269, 108, 'S2', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1270, 108, 'S3', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1271, 108, 'F', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.2600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1272, 108, 'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 10.0000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1273, 108, 'S2', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 20.3200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1274, 108, 'S3', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(1.643974 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 4.9300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1275, 108, 'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 17.2800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1276, 108, 'S2', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 17.2800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1277, 108, 'S3', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1278, 108, 'F', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1279, 108, 'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.6300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1280, 108, 'S2', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 3.2100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1281, 108, 'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.5500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1282, 108, 'S2', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1283, 109, 'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1284, 109, 'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1285, 109, 'F', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1286, 109, 'S3', CAST(N'2022-10-06' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.8200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1287, 110, 'F', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.3400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1288, 110, 'F', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 1.0000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1289, 111, 'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.6300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1290, 111, 'S2', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 3.2100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1291, 111, 'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.5500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1292, 111, 'S2', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1293, 111, 'S1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.1600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1294, 111, 'S2', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.2800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1295, 111, 'S1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1296, 111, 'S2', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1297, 111, 'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.1600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1298, 111, 'S2', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.2800)
;
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1299, 111, 'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1300, 111, 'S2', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1301, 111, 'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1302, 111, 'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1303, 111, 'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1304, 111, 'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1305, 111, 'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1306, 111, 'S2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 3.5000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1307, 111, 'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1308, 111, 'S2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1309, 111, 'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1310, 111, 'S2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1311, 111, 'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1312, 111, 'S2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1313, 111, 'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1314, 111, 'S2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1315, 111, 'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1316, 111, 'S2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1317, 111, 'F', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1318, 111, 'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1319, 111, 'S2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1320, 111, 'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1321, 111, 'S2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1322, 111, 'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1323, 111, 'S2', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1324, 111, 'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1325, 111, 'S2', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1326, 111, 'S1', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.1500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1327, 111, 'S2', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 1.1700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1328, 111, 'S1', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.8200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1329, 111, 'S2', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1330, 112, 'S1', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 5.7400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1331, 112, 'S2', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 11.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1332, 112, 'S3', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 11.9600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1333, 112, 'S1', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1334, 112, 'S2', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1335, 112, 'S3', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 5.0200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1336, 112, 'F', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1337, 112, 'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 5.7400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1338, 112, 'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 11.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1339, 112, 'S3', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 10.4600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1340, 112, 'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1341, 112, 'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1342, 112, 'S3', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1343, 112, 'F', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(60.00 AS Decimal(8, 2)), 0.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1344, 113, 'S1', CAST(N'2019-10-05' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 8.1300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1345, 113, 'S2', CAST(N'2019-10-05' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.8600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1346, 113, 'S1', CAST(N'2019-10-05' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 10.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1347, 113, 'S2', CAST(N'2019-10-05' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 3.1400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1348, 113, 'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 13.8700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1349, 113, 'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-28' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 7.7800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1350, 113, 'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 18.1900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1351, 113, 'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 5.0200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1352, 113, 'F', CAST(N'2020-03-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1353, 113, 'S1', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.8700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1354, 113, 'S2', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.8300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1355, 113, 'S3', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 8.9700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1356, 113, 'S1', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1357, 113, 'S2', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1358, 113, 'S3', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1359, 114, 'S1', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.6100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1360, 114, 'S2', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 17.5000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1361, 114, 'S3', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 26.9000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1362, 114, 'S4', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(2.171288 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 6.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1363, 114, 'S1', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1364, 114, 'S2', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1365, 114, 'S3', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1366, 114, 'S4', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1367, 114, 'F', CAST(N'2020-07-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1368, 114, 'S1', CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 6.2200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1369, 114, 'S2', CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.8900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1370, 114, 'S1', CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 8.1600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1371, 114, 'S2', CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1372, 115, 'S1', CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(21.00 AS Decimal(8, 2)), 10.0500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1373, 115, 'S2', CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 13.6100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1374, 115, 'S1', CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(21.00 AS Decimal(8, 2)), 13.1700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1375, 115, 'S2', CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 8.7800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1376, 115, 'F', CAST(N'2020-11-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1377, 115, 'S1', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.9100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1378, 115, 'S2', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.8900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1379, 115, 'S3', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 5.9800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1380, 115, 'S4', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(2.171288 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 4.3400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1381, 115, 'S1', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1382, 115, 'S2', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1383, 115, 'S3', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1384, 115, 'S4', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1385, 115, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 5.7400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1386, 115, 'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 11.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1387, 115, 'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 17.9300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1388, 115, 'S4', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(2.171288 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 4.3400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1389, 115, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1390, 115, 'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1391, 115, 'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1392, 115, 'S4', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1393, 115, 'F', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(59.00 AS Decimal(8, 2)), 0.5000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1394, 116, 'S1', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.9100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1395, 116, 'S2', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.8900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1396, 116, 'S3', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 1.4900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1397, 116, 'S1', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1398, 116, 'S2', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
;
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1399, 116, 'S3', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1400, 116, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 16.2700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1401, 116, 'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 33.0500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1402, 116, 'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 4.4800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1403, 116, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 21.3300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1404, 116, 'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 21.3300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1405, 116, 'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1406, 116, 'F', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1407, 116, 'S1', CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 0.9600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1408, 116, 'S2', CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1409, 116, 'S1', CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1410, 116, 'S2', CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1411, 117, 'S1', CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 7.6500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1412, 117, 'S2', CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 15.5500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1413, 117, 'S1', CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 10.0400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1414, 117, 'S2', CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 10.0400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1415, 117, 'F', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1416, 117, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 4.7800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1417, 117, 'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 9.7200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1418, 117, 'S3', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 1.4900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1419, 117, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1420, 117, 'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1421, 117, 'S3', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1422, 118, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 10.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1423, 118, 'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 12.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1424, 118, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 13.8000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1425, 118, 'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 8.1600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1426, 118, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 8.1300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1427, 118, 'S2', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-28' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 10.6900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1428, 118, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 10.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1429, 118, 'S2', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 6.9000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1430, 118, 'F', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.2600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1431, 118, 'S1', CAST(N'2022-03-29' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.4800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1432, 118, 'S1', CAST(N'2022-03-29' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1433, 118, 'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 10.5300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1434, 118, 'S2', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 21.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1435, 118, 'S3', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(1.643974 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 18.0800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1436, 118, 'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 18.1900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1437, 118, 'S2', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 18.1900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1438, 118, 'S3', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 10.0100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1439, 118, 'F', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1440, 118, 'S1', CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1441, 118, 'S2', CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.2800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1442, 118, 'S1', CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1443, 118, 'S2', CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1444, 119, 'S1', CAST(N'2022-07-12' AS Date), CAST(N'2022-10-10' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 9.4700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1445, 119, 'S2', CAST(N'2022-07-12' AS Date), CAST(N'2022-10-10' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 10.6900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1446, 119, 'S1', CAST(N'2022-07-12' AS Date), CAST(N'2022-10-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 16.3700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1447, 119, 'S2', CAST(N'2022-07-12' AS Date), CAST(N'2022-10-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 9.1000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1448, 119, 'F', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1449, 119, 'S2', CAST(N'2022-10-11' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.1900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1450, 120, 'F', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.3400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1451, 120, 'F', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 1.0000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1452, 120, 'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.1900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1453, 121, 'F', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1454, 121, 'S2', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1455, 122, 'S1', CAST(N'2020-08-19' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 7.1800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1456, 122, 'S1', CAST(N'2020-08-19' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 9.4100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1457, 122, 'F', CAST(N'2020-11-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1458, 122, 'S1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1459, 122, 'S1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 3.1400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1460, 122, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 4.3100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1461, 122, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 5.6500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1462, 122, 'F', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(59.00 AS Decimal(8, 2)), 0.5000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1463, 123, 'S1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.3900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1464, 123, 'S1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 3.1400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1465, 123, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-04-16' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.6100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1466, 123, 'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-04-16' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1467, 123, 'F', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1468, 123, 'S1', CAST(N'2021-04-17' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 4.7800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1469, 123, 'S1', CAST(N'2021-04-17' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1470, 123, 'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.4400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1471, 123, 'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1472, 124, 'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 7.1800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1473, 124, 'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 9.4100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1474, 124, 'F', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1475, 124, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 3.8300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1476, 124, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 5.0200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1477, 125, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-21' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 8.1300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1478, 125, 'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-21' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 10.6700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1479, 125, 'F', CAST(N'2021-11-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1480, 125, 'S1', CAST(N'2021-12-22' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 0.9600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1481, 125, 'S1', CAST(N'2021-12-22' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1482, 125, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 4.7800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1483, 125, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1484, 125, 'F', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(59.00 AS Decimal(8, 2)), 0.5000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1485, 126, 'S1', CAST(N'2021-12-22' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 0.9600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1486, 126, 'S1', CAST(N'2021-12-22' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1487, 126, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 7.6500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1488, 126, 'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 10.0400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1489, 126, 'F', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.2600)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1490, 126, 'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-19' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.5800)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1491, 126, 'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-19' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1492, 126, 'F', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1493, 126, 'S1', CAST(N'2022-04-20' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 6.8400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1494, 126, 'S1', CAST(N'2022-04-20' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 11.8300)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1495, 126, 'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1496, 126, 'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1497, 127, 'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 9.4700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1498, 127, 'S2', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 2.1400)
;
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1499, 127, 'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 16.3700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1500, 127, 'S2', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.8200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1501, 127, 'F', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1502, 127, 'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.1900)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1503, 128, 'F', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.3400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1504, 128, 'F', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 1.0000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1505, 128, 'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.8200)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1506, 129, 'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1507, 129, 'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1508, 129, 'S1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1509, 129, 'S1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1510, 129, 'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1511, 129, 'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1512, 129, 'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1513, 129, 'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1514, 129, 'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1515, 129, 'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1516, 129, 'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1517, 129, 'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1518, 129, 'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1519, 129, 'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1520, 129, 'F', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1521, 129, 'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1522, 129, 'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1523, 129, 'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.8700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1524, 129, 'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.5500)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1525, 129, 'S1', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.5700)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1526, 129, 'S1', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9100)
INSERT H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1527, 129, 'S2', CAST(N'2023-07-11' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9100)
SET IDENTITY_INSERT H2OConsumo OFF
SET IDENTITY_INSERT H2OFattura ON 

INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (101, 3, 2019, CAST(N'2019-11-28' AS Date), 2019, '30063070', CAST(N'2019-07-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(N'2019-06-11' AS Date), CAST(N'2019-09-24' AS Date), CAST(N'2019-09-25' AS Date), CAST(N'2019-10-31' AS Date), 4.2500, 0.1700, NULL, 17.4600)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (102, 3, 2020, CAST(N'2020-04-20' AS Date), 2020, '320017682', CAST(N'2019-11-01' AS Date), CAST(N'2020-02-29' AS Date), NULL, CAST(N'2020-02-29' AS Date), CAST(N'2019-11-01' AS Date), NULL, 5.3900, 0.1700, NULL, 19.6800)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (103, 3, 2020, CAST(N'2020-08-04' AS Date), 2020, '320036603', CAST(N'2020-03-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(N'2019-09-25' AS Date), CAST(N'2020-05-22' AS Date), CAST(N'2020-05-23' AS Date), CAST(N'2020-06-30' AS Date), 6.6700, 0.1700, NULL, 86.5300)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (104, 3, 2020, CAST(N'2020-12-09' AS Date), 2020, '320056036', CAST(N'2020-07-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(N'2020-05-23' AS Date), CAST(N'2020-08-18' AS Date), CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), 6.7200, 0.1700, NULL, 36.6700)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (105, 3, 2021, CAST(N'2021-10-29' AS Date), 2021, '32036324', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(N'2020-11-27' AS Date), CAST(N'2021-06-11' AS Date), CAST(N'2021-06-12' AS Date), CAST(N'2021-06-30' AS Date), 6.6800, 0.1700, NULL, 117.6700)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (106, 3, 2022, CAST(N'2022-01-26' AS Date), 2022, '32004781', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-09-10' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), 6.7400, 0.1700, NULL, 48.9300)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (107, 3, 2022, CAST(N'2022-05-31' AS Date), 2022, '32029941', CAST(N'2021-11-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(N'2021-12-23' AS Date), CAST(N'2022-02-28' AS Date), 6.5700, 0.1700, NULL, 16.2400)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (108, 3, 2022, CAST(N'2022-09-26' AS Date), 2022, '32049794', CAST(N'2022-03-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(N'2021-12-23' AS Date), CAST(N'2022-07-05' AS Date), CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), 8.3800, 0.1700, NULL, 150.8000)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (109, 3, 2023, CAST(N'2023-01-04' AS Date), 2023, '32004580', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-10-05' AS Date), NULL, CAST(N'2022-11-30' AS Date), 6.6800, 0.1700, -13.1200, 39.0300)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (110, 3, 2023, CAST(N'2023-06-26' AS Date), 2023, '32024453', CAST(N'2022-12-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-31' AS Date), NULL, NULL, 6.6300, 0.1700, NULL, 7.9700)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (111, 3, 2023, CAST(N'2023-09-29' AS Date), 2023, '32044264', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), NULL, CAST(N'2023-07-10' AS Date), NULL, CAST(N'2023-07-31' AS Date), 6.6800, 0.1700, -42.6800, 117.9600)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (112, 1, 2020, CAST(N'2020-04-20' AS Date), 2020, '320016588', CAST(N'2019-11-01' AS Date), CAST(N'2020-02-29' AS Date), NULL, CAST(N'2020-02-29' AS Date), CAST(N'2019-11-01' AS Date), NULL, 5.3900, 0.1700, NULL, 76.8800)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (113, 1, 2020, CAST(N'2020-08-04' AS Date), 2020, '320035544', CAST(N'2020-03-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(N'2019-10-05' AS Date), CAST(N'2020-05-28' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), 6.6700, 0.1700, NULL, 0.0000)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (114, 1, 2020, CAST(N'2020-12-09' AS Date), 2020, '320055005', CAST(N'2020-07-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), 6.7200, 0.1700, NULL, 99.2900)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (115, 1, 2021, CAST(N'2021-05-31' AS Date), 2021, '32016452', CAST(N'2020-11-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(N'2020-12-11' AS Date), CAST(N'2021-02-28' AS Date), 6.5600, 0.1700, NULL, 121.0100)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (116, 1, 2021, CAST(N'2021-10-29' AS Date), 2021, '32035363', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(N'2020-12-11' AS Date), CAST(N'2021-06-22' AS Date), CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), 6.6800, 0.1700, NULL, 34.3900)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (117, 1, 2022, CAST(N'2022-01-26' AS Date), 2022, '32003826', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), 6.7400, 0.1700, NULL, 76.4200)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (118, 1, 2022, CAST(N'2022-09-26' AS Date), 2022, '32048878', CAST(N'2022-03-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2022-03-28' AS Date), CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), 8.3800, 0.1700, NULL, 110.3600)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (119, 1, 2023, CAST(N'2023-01-04' AS Date), 2023, '32003679', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-10-10' AS Date), NULL, CAST(N'2022-11-30' AS Date), 6.6800, 0.1700, -13.6700, 72.1600)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (120, 1, 2023, CAST(N'2023-06-26' AS Date), 2023, '32023573', CAST(N'2022-12-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-31' AS Date), NULL, NULL, 6.6300, 0.1700, NULL, 67.9200)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (121, 1, 2023, CAST(N'2023-09-29' AS Date), 2023, '32043400', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), NULL, CAST(N'2023-07-31' AS Date), NULL, NULL, 6.6800, 0.1700, NULL, 68.5500)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (122, 2, 2021, CAST(N'2021-05-31' AS Date), 2021, '32015853', CAST(N'2020-11-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(N'2020-08-19' AS Date), CAST(N'2020-11-30' AS Date), CAST(N'2020-12-01' AS Date), CAST(N'2021-02-28' AS Date), 6.5600, 0.1700, NULL, 26.8900)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (123, 2, 2021, CAST(N'2021-10-29' AS Date), 2021, '32034789', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(N'2020-12-01' AS Date), CAST(N'2021-04-16' AS Date), CAST(N'2021-06-12' AS Date), CAST(N'2021-06-30' AS Date), 6.6800, 0.1700, NULL, 32.5300)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (124, 2, 2022, CAST(N'2022-01-26' AS Date), 2022, '32003247', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), 6.7400, 0.1700, NULL, 30.4100)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (125, 2, 2022, CAST(N'2022-05-31' AS Date), 2022, '32028444', CAST(N'2021-11-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-12-21' AS Date), CAST(N'2021-12-22' AS Date), CAST(N'2022-02-28' AS Date), 6.5700, 0.1700, NULL, 31.3000)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (126, 2, 2022, CAST(N'2022-09-26' AS Date), 2022, '32048325', CAST(N'2022-03-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(N'2021-12-22' AS Date), CAST(N'2022-04-19' AS Date), CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), 8.3800, 0.1700, NULL, 45.8600)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (127, 2, 2023, CAST(N'2023-01-04' AS Date), 2023, '32003129', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-10-05' AS Date), NULL, CAST(N'2022-11-30' AS Date), 6.6800, 0.1700, -5.7500, 45.0100)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (128, 2, 2023, CAST(N'2023-06-26' AS Date), 2023, '32023024', CAST(N'2022-12-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-31' AS Date), NULL, NULL, 6.6300, 0.1700, NULL, 49.4200)
INSERT H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (129, 2, 2023, CAST(N'2023-09-29' AS Date), 2023, '32042855', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), NULL, CAST(N'2023-07-10' AS Date), NULL, CAST(N'2023-07-31' AS Date), 6.6800, 0.1700, -54.3900, 17.5100)
SET IDENTITY_INSERT H2OFattura OFF
SET IDENTITY_INSERT H2OLettura ON 

INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (337, 101, 6369, CAST(N'2019-06-10' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (338, 101, 6380, CAST(N'2019-09-24' AS Date), 'eff', 11)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (339, 101, NULL, NULL, 'stim', 1)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (340, 101, NULL, NULL, 'tot', 12)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (341, 102, 6380, CAST(N'2019-09-24' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (342, 102, NULL, NULL, 'stim', 12)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (343, 102, NULL, NULL, 'tot', 12)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (344, 103, 6380, CAST(N'2019-09-24' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (345, 103, 6450, CAST(N'2020-05-22' AS Date), 'eff', 70)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (346, 103, NULL, NULL, 'stim', 4)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (347, 103, NULL, NULL, 'tot', 74)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (348, 104, 6450, CAST(N'2020-05-22' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (349, 104, 6455, CAST(N'2020-08-18' AS Date), 'eff', 5)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (350, 104, NULL, NULL, 'stim', 22)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (351, 104, NULL, NULL, 'tot', 27)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (352, 105, 6456, CAST(N'2020-11-26' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (353, 105, 6545, CAST(N'2021-06-11' AS Date), 'eff', 89)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (354, 105, NULL, NULL, 'stim', 0)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (355, 105, NULL, NULL, 'tot', 89)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (356, 106, 6545, CAST(N'2021-06-11' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (357, 106, 6552, CAST(N'2021-09-10' AS Date), 'eff', 7)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (358, 106, NULL, NULL, 'stim', 23)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (359, 106, NULL, NULL, 'tot', 30)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (360, 107, 6552, CAST(N'2021-09-10' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (361, 107, 6581, CAST(N'2021-12-22' AS Date), 'eff', 29)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (362, 107, NULL, NULL, 'stim', 5)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (363, 107, NULL, NULL, 'tot', 34)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (364, 108, 6581, CAST(N'2021-12-22' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (365, 108, 6665, CAST(N'2022-07-05' AS Date), 'eff', 84)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (366, 108, NULL, NULL, 'stim', 8)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (367, 108, NULL, NULL, 'tot', 92)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (368, 109, 6665, CAST(N'2022-07-05' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (369, 109, 6666, CAST(N'2022-10-05' AS Date), 'eff', 1)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (370, 109, NULL, NULL, 'stim', 24)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (371, 109, NULL, NULL, 'tot', 25)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (372, 110, 6666, CAST(N'2022-10-05' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (373, 110, NULL, NULL, 'stim', 0)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (374, 110, NULL, NULL, 'tot', 0)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (375, 111, 6666, CAST(N'2022-10-05' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (376, 111, 6756, CAST(N'2023-07-10' AS Date), 'eff', 90)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (377, 111, NULL, NULL, 'stim', 0)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (378, 111, NULL, NULL, 'tot', 90)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (379, 112, 1020, CAST(N'2019-10-04' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (380, 112, NULL, NULL, 'stim', 63)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (381, 112, NULL, NULL, 'tot', 63)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (382, 113, 1020, CAST(N'2019-10-04' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (383, 113, 1079, CAST(N'2020-05-28' AS Date), 'eff', 59)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (384, 113, NULL, NULL, 'stim', 18)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (385, 113, NULL, NULL, 'tot', 77)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (386, 114, 1079, CAST(N'2020-05-28' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (387, 114, 1136, CAST(N'2020-08-25' AS Date), 'eff', 57)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (388, 114, NULL, NULL, 'stim', 17)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (389, 114, NULL, NULL, 'tot', 74)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (390, 115, 1136, CAST(N'2020-08-25' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (391, 115, 1171, CAST(N'2020-12-10' AS Date), 'eff', 35)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (392, 115, NULL, NULL, 'stim', 52)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (393, 115, NULL, NULL, 'tot', 87)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (394, 116, 1171, CAST(N'2020-12-10' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (395, 116, 1251, CAST(N'2021-06-22' AS Date), 'eff', 80)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (396, 116, NULL, NULL, 'stim', 3)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (397, 116, NULL, NULL, 'tot', 83)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (398, 117, 1251, CAST(N'2021-06-22' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (399, 117, 1283, CAST(N'2021-09-10' AS Date), 'eff', 32)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (400, 117, NULL, NULL, 'stim', 21)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (401, 117, NULL, NULL, 'tot', 53)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (402, 118, 1283, CAST(N'2021-09-10' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (403, 118, 1346, CAST(N'2022-03-28' AS Date), 'eff', 63)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (404, 118, 1398, CAST(N'2022-07-11' AS Date), 'eff', 52)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (405, 118, NULL, NULL, 'stim', 8)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (406, 118, NULL, NULL, 'tot', 123)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (407, 119, 1398, CAST(N'2022-07-11' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (408, 119, 1426, CAST(N'2022-10-10' AS Date), 'eff', 28)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (409, 119, NULL, NULL, 'stim', 19)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (410, 119, NULL, NULL, 'tot', 47)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (411, 120, 1426, CAST(N'2022-10-10' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (412, 120, NULL, NULL, 'stim', 36)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (413, 120, NULL, NULL, 'tot', 36)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (414, 121, 1426, CAST(N'2022-10-10' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (415, 121, NULL, NULL, 'stim', 36)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (416, 121, NULL, NULL, 'tot', 36)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (417, 122, 4856, CAST(N'2020-08-18' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (418, 122, 4871, CAST(N'2020-11-30' AS Date), 'eff', 15)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (419, 122, NULL, NULL, 'stim', 14)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (420, 122, NULL, NULL, 'tot', 29)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (421, 123, 4871, CAST(N'2020-11-30' AS Date), 'eff', NULL)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (422, 123, 4894, CAST(N'2021-04-16' AS Date), 'eff', 23)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (423, 123, NULL, NULL, 'stim', 3)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (424, 123, NULL, NULL, 'tot', 36)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (425, 124, NULL, NULL, 'stim', 8)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (426, 124, NULL, NULL, 'tot', 23)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (427, 125, NULL, NULL, 'stim', 12)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (428, 125, NULL, NULL, 'tot', 29)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (429, 126, NULL, NULL, 'stim', 4)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (430, 126, NULL, NULL, 'tot', 38)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (431, 127, NULL, NULL, 'stim', 9)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (432, 127, NULL, NULL, 'tot', 29)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (433, 128, NULL, NULL, 'stim', 27)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (434, 128, NULL, NULL, 'tot', 27)
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (435, 129, NULL, NULL, 'stim', 5)
;
INSERT H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (436, 129, NULL, NULL, 'tot', 43)
SET IDENTITY_INSERT H2OLettura OFF
SET IDENTITY_INSERT Intesta ON 

INSERT Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (1, 'claudio', 'F:\Google Drive\SMichele\AASS')
INSERT Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (2, 'andrea', 'F:\varie\AASS\Andrea')
INSERT Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (3, 'alessandro', 'F:\varie\AASS\Alessandro')
SET IDENTITY_INSERT Intesta OFF
ALTER TABLE EEConsumo  WITH CHECK ADD  CONSTRAINT FK_EEConsumo_EEFattura FOREIGN KEY(idEEFattura)
REFERENCES EEFattura (idEEFattura)
;
ALTER TABLE EEConsumo CHECK CONSTRAINT FK_EEConsumo_EEFattura
;
ALTER TABLE EEFattura  WITH CHECK ADD  CONSTRAINT FK_EEFattura_Intesta FOREIGN KEY(idIntesta)
REFERENCES Intesta (idIntesta)
;
ALTER TABLE EEFattura CHECK CONSTRAINT FK_EEFattura_Intesta
;
ALTER TABLE EELettura  WITH CHECK ADD  CONSTRAINT FK_EELettura_EEFattura FOREIGN KEY(idEEFattura)
REFERENCES EEFattura (idEEFattura)
;
ALTER TABLE EELettura CHECK CONSTRAINT FK_EELettura_EEFattura
;
ALTER TABLE GASConsumo  WITH CHECK ADD  CONSTRAINT FK_GASConsumo_GASFattura FOREIGN KEY(idGASFattura)
REFERENCES GASFattura (idGASFattura)
;
ALTER TABLE GASConsumo CHECK CONSTRAINT FK_GASConsumo_GASFattura
;
ALTER TABLE GASFattura  WITH CHECK ADD  CONSTRAINT FK_GASFattura_Intesta FOREIGN KEY(idIntesta)
REFERENCES Intesta (idIntesta)
;
ALTER TABLE GASFattura CHECK CONSTRAINT FK_GASFattura_Intesta
;
ALTER TABLE GASLettura  WITH CHECK ADD  CONSTRAINT FK_GASLettura_GASFattura FOREIGN KEY(idGASFattura)
REFERENCES GASFattura (idGASFattura)
;
ALTER TABLE GASLettura CHECK CONSTRAINT FK_GASLettura_GASFattura
;
ALTER TABLE H2OConsumo  WITH CHECK ADD  CONSTRAINT FK_H2OConsumo_H2OFattura FOREIGN KEY(idH2OFattura)
REFERENCES H2OFattura (idH2OFattura)
;
ALTER TABLE H2OConsumo CHECK CONSTRAINT FK_H2OConsumo_H2OFattura
;
ALTER TABLE H2OFattura  WITH CHECK ADD  CONSTRAINT FK_H2OFattura_Intesta FOREIGN KEY(idIntesta)
REFERENCES Intesta (idIntesta)
;
ALTER TABLE H2OFattura CHECK CONSTRAINT FK_H2OFattura_Intesta
;
ALTER TABLE H2OLettura  WITH CHECK ADD  CONSTRAINT FK_H2OLettura_H2OFattura FOREIGN KEY(idH2OFattura)
REFERENCES H2OFattura (idH2OFattura)
;
ALTER TABLE H2OLettura CHECK CONSTRAINT FK_H2OLettura_H2OFattura
;
;
;
 CREATE  PROCEDURE cercaBuchiDateConsumoEE(  @Nomeintesta varchar(128)  )
 AS
DECLARE	@dtMin decimal(6,2),
		@dtMax decimal(6,2),
		@dec decimal(6,2),
		@dtCurr date
		


SELECT @dtMin = min(dtIniz), 
	   @dtMax = max(dtIniz)
  FROM EEConsumoMensile
  WHERE NomeIntesta=@Nomeintesta


SET @dtCurr = CAST( REPLACE( CAST(@dtMin as  varchar(18)) + '.01', '.', '-') as date)
SET @dec = toAnnoMese(@dtCurr)

CREATE TABLE #miedate ( miadt decimal(6,2) )

WHILE @dec <= @dtMax
BEGIN
   INSERT into #miedate VALUES (@dec) 
   SET @dtCurr = DATEADD(m, 1, @dtCurr)
   SET @dec = toAnnoMese(@dtCurr)
END

SELECT *
   FROM #miedate
   WHERE miadt NOT IN 
		( SELECT   dtIniz
            FROM EEConsumoMensile
           WHERE NomeIntesta=@Nomeintesta
	    )
DROP TABLE #miedate
;
;
;
CREATE Procedure deleteFatture( @idItesta int = 1 ) 
AS

DELETE FROM EEconsumo 
	WHERE idEEFattura in ( 
		SELECT idEEFattura 
		  FROM EEFattura as ft
		    INNER JOIN Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM EELettura 
	WHERE idEEFattura in ( 
		SELECT idEEFattura 
		  FROM EEFattura as ft
		    INNER JOIN Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM EEFattura
	where idIntesta = @idItesta



DELETE FROM GASconsumo 
	WHERE idGASFattura in ( 
		SELECT idGASFattura 
		  FROM GASFattura as ft
		    INNER JOIN Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM GASLettura 
	WHERE idGASFattura in ( 
		SELECT idGASFattura 
		  FROM GASFattura as ft
		    INNER JOIN Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM GASFattura
	where idIntesta = @idItesta


DELETE FROM H2Oconsumo 
	WHERE idH2OFattura in ( 
		SELECT idH2OFattura 
		  FROM H2OFattura as ft
		    INNER JOIN Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM H2OLettura 
	WHERE idH2OFattura in ( 
		SELECT idH2OFattura 
		  FROM H2OFattura as ft
		    INNER JOIN Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM H2OFattura
	where idIntesta = @idItesta

;
USE master
;
ALTER DATABASE aass SET  READ_WRITE 
;
