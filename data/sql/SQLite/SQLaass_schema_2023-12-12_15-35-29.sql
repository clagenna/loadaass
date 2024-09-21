PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE EELettura (
    idLettura     INTEGER PRIMARY KEY,
    idEEFattura   INT                   NOT NULL,
    LettDtPrec    DATE,
    LettPrec      INT,
    TipoLettura   VARCHAR (16),
    LettDtAttuale DATE,
    LettAttuale   INT,
    LettConsumo   FLOAT
);
CREATE TABLE GASLettura (
    idLettura    INTEGER PRIMARY KEY,
    idGASFattura INT                   NOT NULL,
    lettQtaMc    INT,
    LettData     DATE,
    TipoLett     VARCHAR (16),
    Consumofatt  FLOAT
);
CREATE TABLE H2OLettura (
    idLettura    INTEGER PRIMARY KEY,
    idH2OFattura INT                   NOT NULL,
    lettQtaMc    INT,
    LettData     DATE,
    TipoLett     VARCHAR (16),
    Consumofatt  FLOAT
);
CREATE TABLE Intesta (
    idIntesta   INTEGER PRIMARY KEY,
    NomeIntesta NVARCHAR (64),
    dirfatture  NVARCHAR (128)
);
CREATE TABLE prova (chiave INTEGER PRIMARY KEY NOT NULL, stringa TEXT, intero INTEGER, prezzo REAL, dataoggi TEXT, percento REAL, flottante REAL) STRICT;
CREATE TABLE H2OConsumo (idConsumo INTEGER PRIMARY KEY, idH2OFattura INT NOT NULL, tipoSpesa VARCHAR (4), dtIniz DATE, dtFine DATE, stimato INTEGER, prezzoUnit DECIMAL (10, 6), quantita DECIMAL (8, 2), importo MONEY);
CREATE TABLE GASConsumo (idConsumo INTEGER PRIMARY KEY, idGASFattura INT NOT NULL, tipoSpesa VARCHAR (4), dtIniz DATE, dtFine DATE, stimato INTEGER, prezzoUnit DECIMAL (10, 6), quantita DECIMAL (8, 2), importo MONEY);
CREATE TABLE EEConsumo (idEEConsumo INTEGER PRIMARY KEY, idEEFattura INT NOT NULL, tipoSpesa TEXT (2), dtIniz DATE, dtFine DATE, stimato INTEGER, prezzoUnit DECIMAL (10, 6), quantita DECIMAL (8, 2), importo DECIMAL (8, 2));
CREATE TABLE EEFattura (idEEFattura INTEGER PRIMARY KEY, idIntesta INT, annoComp INT, DataEmiss DATE, fattNrAnno INT, fattNrNumero NVARCHAR (50), periodFattDtIniz DATE, periodFattDtFine DATE, CredPrecKwh INT, CredAttKwh INT, addizFER MONEY, impostaQuiet MONEY, TotPagare MONEY, nomeFile TEXT);
CREATE TABLE H2OFattura (idH2OFattura INTEGER PRIMARY KEY, idIntesta INT, annoComp INT, DataEmiss DATE, fattNrAnno INT, fattNrNumero NVARCHAR (50), periodFattDtIniz DATE, periodFattDtFine DATE, periodCongDtIniz DATE, periodCongDtFine DATE, periodAccontoDtIniz DATE, periodAccontoDtFine DATE, assicurazione MONEY, impostaQuiet MONEY, RestituzAccPrec MONEY, TotPagare MONEY, nomeFile TEXT);
CREATE TABLE GASFattura (idGASFattura INTEGER PRIMARY KEY, idIntesta INT, annoComp INT, DataEmiss DATE, fattNrAnno INT, fattNrNumero NVARCHAR (50), periodFattDtIniz DATE, periodFattDtFine DATE, periodEffDtIniz DATE, periodEffDtFine DATE, periodAccontoDtIniz DATE, periodAccontoDtFine DATE, accontoBollPrec MONEY, addizFER MONEY, impostaQuiet MONEY, TotPagare MONEY, nomeFile TEXT);
CREATE VIEW EEScaglioniImporti AS SELECT NomeIntesta,
       annoComp,
       dtIniz,
       IFNULL(SUM(case when tipospesa = 'E1' then importo end), 0) as EESca1,
       IFNULL(SUM(case when tipospesa = 'E2' then importo end), 0) as EESca2,
       IFNULL(SUM(case when tipospesa = 'E3' then importo end), 0) as EESca3,
       IFNULL(SUM(case when tipospesa = 'S1' then importo end), 0) as SpreadSc1,
       IFNULL(SUM(case when tipospesa = 'S2' then importo end), 0) as SpreadSc2,
       IFNULL(SUM(case when tipospesa = 'PU' then importo end), 0) as Pun,
       IFNULL(SUM(case when tipospesa = 'R' then importo end), 0)  as Rifiuti,
       IFNULL(SUM(case when tipospesa = 'P' then importo end), 0) as ImpegnoPot
   FROM EEConsumoMensile
GROUP BY NomeIntesta, annoComp, dtIniz
ORDER BY nomeIntesta, dtIniz;
CREATE VIEW EEConsumoAnnuo AS SELECT NomeIntesta,
       annoComp,
       SUM(quantita) AS totAnno
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              annoComp;
CREATE VIEW EECostoAnnuo AS SELECT NomeIntesta,
       annoComp,
       SUM(importo) AS totAnno
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              annoComp;
CREATE VIEW EEScaglioniPrezzoUnit AS SELECT NomeIntesta,
       annoComp,
       dtIniz,
       SUM(IFNULL((case when tipospesa = 'E1' then prezzoUnit end), 0)) as Sca1,
       SUM(IFNULL((case when tipospesa = 'E2' then prezzoUnit end), 0)) as Sca2,
       SUM(IFNULL((case when tipospesa = 'E3' then prezzoUnit end), 0)) as Sca3,
       SUM(IFNULL((case when tipospesa = 'S1' then prezzoUnit end), 0)) as SpreadSc1,
       SUM(IFNULL((case when tipospesa = 'S2' then prezzoUnit end), 0)) as SpreadSc2,
       SUM(IFNULL((case when tipospesa = 'PU' then prezzoUnit end), 0)) as Pun,
       SUM(IFNULL((case when tipospesa = 'R' then prezzoUnit end), 0)) as Rifiuti,
       SUM(IFNULL((case when tipospesa = 'P' then prezzoUnit end), 0)) as ImpegnoTot
 FROM EEConsumoMensile
GROUP BY NomeIntesta, annoComp, dtIniz;
CREATE VIEW EEConsumoMensile AS SELECT te.NomeIntesta,
           cs.idEEFattura,
           cs.dtIniz,
           strftime('%Y-%m', cs.dtIniz) AS meseComp,
           CAST( strftime('%Y', cs.dtIniz) AS int) as annoComp,
           cs.tipoSpesa,
           cs.prezzoUnit,
           cs.quantita,
           cs.importo
      FROM EEConsumo AS cs
           INNER JOIN
           EEFattura AS ft ON ft.idEEFattura = cs.idEEFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta
     WHERE 1 = 1 AND 
           0 < (
                   SELECT SUM(LettAttuale) 
                     FROM EELettura
                    WHERE idEEFattura = ft.idEEFattura
               );
CREATE VIEW EELettureMensili AS SELECT te.NomeIntesta,
           le.idLettura,
           le.idEEFattura,
           CAST(strftime('%Y', le.LettDtAttuale) AS int) as annoComp,
           le.LettDtPrec,
           -- strftime('%Y.%m',DATE(le.LettDtPrec)) as mmDtPrec,
           le.TipoLettura,
           le.LettPrec,
           le.LettDtAttuale,
           -- strftime('%Y.%m',le.LettDtAttuale) as mmDtAttuale,
           le.LettAttuale,
           le.LettConsumo,
           JULIANDAY(le.LettDtAttuale) - JULIANDAY(le.LettDtPrec) as qtaGG
      FROM EELettura AS le
      INNER JOIN EEFattura AS ft 
         ON ft.idEEFattura = le.idEEFattura
      INNER JOIN intesta AS te 
         ON ft.idIntesta = te.idIntesta
;
CREATE VIEW GASConsumoMensile AS SELECT te.NomeIntesta 
      ,cs.idGASFattura
      --,dbo.toAnnoMese(cs.dtIniz) as dtIniz
      --,dbo.toAnnoMese(cs.dtFine) as dtFine
      ,strftime('%Y-%m', cs.dtIniz) AS meseComp
      ,CAST( strftime('%Y', cs.dtIniz) AS int) as annoComp
      ,cs.dtIniz as dtIniz
      ,cs.dtFine as dtFine
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
      ,JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1 as qtaGG
      ,cs.quantita / (JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1) as mediaGG
      ,cs.importo
  FROM GASConsumo as cs
    INNER JOIN GASFattura as ft
       ON ft.idGASFattura=cs.idGASFattura
    INNER JOIN intesta as te
      ON ft.idIntesta=te.idIntesta
WHERE  ft.periodEffDtIniz IS NOT NULL
   AND cs.dtIniz BETWEEN
	      -- ft.periodEffDtIniz  
		  ( SELECT MIN(lt.lettData) 
		      FROM GASLettura as lt
		     WHERE lt.idGASFattura=ft.idGASFattura )
	   AND 
	      -- ft.periodEffDtFine
  		  ( SELECT MAX(lt.lettData) 
		      FROM GASLettura as lt
		     WHERE lt.idGASFattura=ft.idGASFattura )
;
CREATE VIEW GASScaglioniImporto AS SELECT NomeIntesta
     , idGASFattura
     , annoComp
     , dtIniz
     , dtFine
     , JULIANDAY(dtFine) - JULIANDAY(dtIniz) + 1 as qtaGG
     , SUM(case when tipospesa = 'G1' then importo end) as Scagl1
     , SUM(case when tipospesa = 'G2' then importo end) as Scagl2
     , SUM(case when tipospesa = 'G3' then importo end) as Scagl3

     , COALESCE( SUM(case when tipospesa = 'G1' then importo end), 0)
     + COALESCE( SUM(case when tipospesa = 'G2' then importo end), 0)
     + COALESCE( SUM(case when tipospesa = 'G3' then importo end), 0) as Totale
     

     , ( COALESCE( SUM(case when tipospesa = 'G1' then importo end), 0)
       + COALESCE( SUM(case when tipospesa = 'G2' then importo end), 0)
       + COALESCE( SUM(case when tipospesa = 'G3' then importo end), 0) )
     / (JULIANDAY(dtFine) - JULIANDAY(dtIniz) + 1) as mediaGG
		 
     FROM 	GASConsumoMensile
GROUP BY NomeIntesta
     , idGASFattura
     , dtIniz
     , dtFine;
CREATE VIEW GASScaglioniPrezzoUnit AS SELECT NomeIntesta,
       annoComp,
       dtIniz,
       dtFine,
       JULIANDAY(dtFine) - JULIANDAY(dtIniz) as qtaGG,
       SUM(IFNULL((case when tipospesa = 'G1' then prezzoUnit end), 0)) as Sca1,
       SUM(IFNULL((case when tipospesa = 'G2' then prezzoUnit end), 0)) as Sca2,
       SUM(IFNULL((case when tipospesa = 'G3' then prezzoUnit end), 0)) as Sca3,
       SUM(IFNULL((case when tipospesa = 'G1' then prezzoUnit end), 0)) +
       SUM(IFNULL((case when tipospesa = 'G2' then prezzoUnit end), 0)) +
       SUM(IFNULL((case when tipospesa = 'G3' then prezzoUnit end), 0)) as Totale,
      ( SUM(IFNULL((case when tipospesa = 'G1' then prezzoUnit end), 0)) +
       SUM(IFNULL((case when tipospesa = 'G2' then prezzoUnit end), 0)) +
       SUM(IFNULL((case when tipospesa = 'G3' then prezzoUnit end), 0)) 
       ) / CAST( (JULIANDAY(dtFine) - JULIANDAY(dtIniz)) AS float) as mediaGG
 FROM GASConsumoMensile
GROUP BY NomeIntesta, annoComp, dtIniz;
CREATE VIEW GASConsumoAnnuo AS SELECT NomeIntesta,
       annoComp,
       SUM(quantita) AS consumoAnnuo
      FROM GASConsumoMensile
     GROUP BY NomeIntesta,
              annoComp;
CREATE VIEW GASCostoAnnuo AS SELECT NomeIntesta,
       annoComp,
       SUM(importo) AS costoAnnuo
      FROM GASConsumoMensile
     GROUP BY NomeIntesta,
              annoComp;
CREATE VIEW GASLettureMensili AS SELECT te.NomeIntesta
      ,ft.idGASFattura
      ,ft.annoComp
      ,ft.periodAccontoDtIniz
      ,ft.periodAccontoDtFine
      ,ft.periodEffDtIniz
      ,ft.periodEffDtFine
      ,ft.periodFattDtIniz
      ,ft.periodFattDtFine
      ,le.LettData
      ,le.lettQtaMc
      ,le.TipoLett
      ,le.Consumofatt  
FROM GASLettura as le
	  INNER JOIN GASFattura as ft
		 ON ft.idGASFattura=le.idGASFattura
	  INNER JOIN intesta as te
		 ON ft.idIntesta=te.idIntesta
WHERE  1=1;
CREATE VIEW GASLettureMensiliTipo AS SELECT NomeIntesta
--      ,annoComp
        , COALESCE(periodAccontoDtIniz,periodEffDtIniz,periodFattDtIniz) as dtIniz
        , COALESCE(periodAccontoDtFine,periodEffDtFine,periodFattDtFine) as dtFine
--      ,periodAccontoDtFine
--      ,periodEffDtIniz
--      ,periodEffDtFine
--      ,periodFattDtIniz
--      ,periodFattDtFine
--      ,LettData
      ,SUM(IFNULL((case when tipoLett = 'eff'  then lettQtaMc end), 0)) as qtaMcEff
      ,SUM(IFNULL((case when tipoLett = 'stim' then lettQtaMc end), 0)) as qtaMcStim
      ,SUM(IFNULL((case when tipoLett = 'auto' then lettQtaMc end), 0)) as qtaMcAuto
      ,SUM(IFNULL((case when tipoLett = 'tot'  then lettQtaMc end), 0)) as qtaMcTot

      ,SUM(IFNULL((case when tipoLett = 'eff'  then Consumofatt end), 0)) as ConsumofattEff
      ,SUM(IFNULL((case when tipoLett = 'stim' then Consumofatt end), 0)) as ConsumofattStim
      ,SUM(IFNULL((case when tipoLett = 'auto' then Consumofatt end), 0)) as ConsumofattAuto
      ,SUM(IFNULL((case when tipoLett = 'tot'  then Consumofatt end), 0)) as ConsumofattTot

FROM GASLettureMensili
GROUP BY NomeIntesta, dtIniz, dtFine
;
CREATE VIEW H2OConsumoMensile AS SELECT te.NomeIntesta,
       cs.idH2OFattura,
       CAST (strftime('%Y', cs.dtIniz) AS INT) AS annoComp,
       cs.dtIniz,
       cs.dtFine,
       cs.tipoSpesa,
       cs.prezzoUnit,
       cs.quantita,
       cs.importo
  FROM H2OConsumo AS cs
       INNER JOIN
       H2OFattura AS ft ON ft.idH2OFattura = cs.idH2OFattura
       INNER JOIN
       intesta AS te ON ft.idIntesta = te.idIntesta;
CREATE VIEW H2OScaglioniImporti AS SELECT NomeIntesta,
       annoComp,
       dtIniz,
       dtFine,
       CAST(julianday('%d',dtFine) as int) - CAST(julianday('%d',dtIniz) as int) as qtaGG,
       IFNULL(SUM(case when tipospesa = 'S1' then importo end), 0) as Sca1,
       IFNULL(SUM(case when tipospesa = 'S2' then importo end), 0) as Sca2,
       IFNULL(SUM(case when tipospesa = 'S3' then importo end), 0) as Sca3,
       IFNULL(SUM(case when tipospesa = 'S4' then importo end), 0) as Sca4,

       IFNULL(SUM(case when tipospesa = 'TA1' then importo end), 0) as TarA1,
       IFNULL(SUM(case when tipospesa = 'TA2' then importo end), 0) as TarA2,
       IFNULL(SUM(case when tipospesa = 'TA3' then importo end), 0) as TarA3,
       IFNULL(SUM(case when tipospesa = 'TA4' then importo end), 0) as TarA4,

       IFNULL(SUM(case when tipospesa = 'F' then importo end), 0) as quotaFissa
   FROM H2OConsumoMensile
GROUP BY NomeIntesta, annoComp, dtIniz,dtFine
ORDER BY nomeIntesta, dtIniz;
CREATE VIEW H2OScaglioniPrezzoUnit AS SELECT NomeIntesta,
       annoComp,
       dtIniz,
       dtFine,
       JULIANDAY(dtFine) - JULIANDAY(dtIniz) as qtaGG,
       IFNULL(SUM(case when tipospesa = 'S1' then prezzoUnit end), 0) as Sca1,
       IFNULL(SUM(case when tipospesa = 'S2' then prezzoUnit end), 0) as Sca2,
       IFNULL(SUM(case when tipospesa = 'S3' then prezzoUnit end), 0) as Sca3,
       IFNULL(SUM(case when tipospesa = 'S4' then prezzoUnit end), 0) as Sca4,

       IFNULL(SUM(case when tipospesa = 'TA1' then prezzoUnit end), 0) as TarA1,
       IFNULL(SUM(case when tipospesa = 'TA2' then prezzoUnit end), 0) as TarA2,
       IFNULL(SUM(case when tipospesa = 'TA3' then prezzoUnit end), 0) as TarA3,
       IFNULL(SUM(case when tipospesa = 'TA4' then prezzoUnit end), 0) as TarA4,

       IFNULL(SUM(case when tipospesa = 'F' then prezzoUnit end), 0) as quotaFissa
   FROM H2OConsumoMensile
GROUP BY NomeIntesta, annoComp, dtIniz,dtFine
ORDER BY nomeIntesta, dtIniz;
CREATE UNIQUE INDEX UX_EEFattura_dataEmiss ON EEFattura (
    idIntesta,
    DataEmiss
);
CREATE UNIQUE INDEX UX_H2OFattura_dataEmiss ON H2OFattura (
    idIntesta,
    DataEmiss
);
CREATE UNIQUE INDEX UX_GASFattura_dataEmiss ON GASFattura (
    idIntesta,
    DataEmiss
);
COMMIT;
