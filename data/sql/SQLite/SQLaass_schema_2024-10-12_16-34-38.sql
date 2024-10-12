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
CREATE TABLE prova (chiave INTEGER PRIMARY KEY NOT NULL, stringa TEXT, intero INTEGER, prezzo REAL, dataoggi TEXT, percento REAL, flottante REAL) STRICT;
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
ORDER BY nomeIntesta, dtIniz
/* EEScaglioniImporti(NomeIntesta,annoComp,dtIniz,EESca1,EESca2,EESca3,SpreadSc1,SpreadSc2,Pun,Rifiuti,ImpegnoPot) */;
CREATE VIEW EEConsumoAnnuo AS SELECT NomeIntesta,
       annoComp,
       SUM(quantita) AS totAnno
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              annoComp
/* EEConsumoAnnuo(NomeIntesta,annoComp,totAnno) */;
CREATE VIEW EECostoAnnuo AS SELECT NomeIntesta,
       annoComp,
       SUM(importo) AS totAnno
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              annoComp
/* EECostoAnnuo(NomeIntesta,annoComp,totAnno) */;
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
GROUP BY NomeIntesta, annoComp, dtIniz
/* EEScaglioniPrezzoUnit(NomeIntesta,annoComp,dtIniz,Sca1,Sca2,Sca3,SpreadSc1,SpreadSc2,Pun,Rifiuti,ImpegnoTot) */;
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
     , dtFine
/* GASScaglioniImporto(NomeIntesta,idGASFattura,annoComp,dtIniz,dtFine,qtaGG,Scagl1,Scagl2,Scagl3,Totale,mediaGG) */;
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
GROUP BY NomeIntesta, annoComp, dtIniz
/* GASScaglioniPrezzoUnit(NomeIntesta,annoComp,dtIniz,dtFine,qtaGG,Sca1,Sca2,Sca3,Totale,mediaGG) */;
CREATE VIEW GASConsumoAnnuo AS SELECT NomeIntesta,
       annoComp,
       SUM(quantita) AS consumoAnnuo
      FROM GASConsumoMensile
     GROUP BY NomeIntesta,
              annoComp
/* GASConsumoAnnuo(NomeIntesta,annoComp,consumoAnnuo) */;
CREATE VIEW GASCostoAnnuo AS SELECT NomeIntesta,
       annoComp,
       SUM(importo) AS costoAnnuo
      FROM GASConsumoMensile
     GROUP BY NomeIntesta,
              annoComp
/* GASCostoAnnuo(NomeIntesta,annoComp,costoAnnuo) */;
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
/* GASLettureMensiliTipo(NomeIntesta,dtIniz,dtFine,qtaMcEff,qtaMcStim,qtaMcAuto,qtaMcTot,ConsumofattEff,ConsumofattStim,ConsumofattAuto,ConsumofattTot) */;
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
ORDER BY nomeIntesta, dtIniz
/* H2OScaglioniImporti(NomeIntesta,annoComp,dtIniz,dtFine,qtaGG,Sca1,Sca2,Sca3,Sca4,TarA1,TarA2,TarA3,TarA4,quotaFissa) */;
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
ORDER BY nomeIntesta, dtIniz
/* H2OScaglioniPrezzoUnit(NomeIntesta,annoComp,dtIniz,dtFine,qtaGG,Sca1,Sca2,Sca3,Sca4,TarA1,TarA2,TarA3,TarA4,quotaFissa) */;
CREATE TABLE H2OConsumo (idConsumo INTEGER PRIMARY KEY, idH2OFattura INT NOT NULL, tipoSpesa VARCHAR (4), dtIniz DATE, dtFine DATE, stimato INTEGER, prezzoUnit DECIMAL (10, 6), quantita DECIMAL (8, 2), importo MONEY);
CREATE TABLE GASConsumo (idConsumo INTEGER PRIMARY KEY, idGASFattura INT NOT NULL, tipoSpesa VARCHAR (4), dtIniz DATE, dtFine DATE, stimato INTEGER, prezzoUnit DECIMAL (10, 6), quantita DECIMAL (8, 2), importo MONEY);
CREATE TABLE EEConsumo (idEEConsumo INTEGER PRIMARY KEY, idEEFattura INT NOT NULL, tipoSpesa TEXT (2), dtIniz DATE, dtFine DATE, stimato INTEGER, prezzoUnit DECIMAL (10, 6), quantita DECIMAL (8, 2), importo DECIMAL (8, 2));
CREATE TABLE EEFattura (idEEFattura INTEGER PRIMARY KEY, idIntesta INT, annoComp INT, DataEmiss DATE, fattNrAnno INT, fattNrNumero NVARCHAR (50), periodFattDtIniz DATE, periodFattDtFine DATE, CredPrecKwh INT, CredAttKwh INT, addizFER MONEY, impostaQuiet MONEY, TotPagare MONEY, nomeFile TEXT);
CREATE TABLE H2OFattura (idH2OFattura INTEGER PRIMARY KEY, idIntesta INT, annoComp INT, DataEmiss DATE, fattNrAnno INT, fattNrNumero NVARCHAR (50), periodFattDtIniz DATE, periodFattDtFine DATE, periodCongDtIniz DATE, periodCongDtFine DATE, periodAccontoDtIniz DATE, periodAccontoDtFine DATE, assicurazione MONEY, impostaQuiet MONEY, RestituzAccPrec MONEY, TotPagare MONEY, nomeFile TEXT);
CREATE TABLE GASFattura (idGASFattura INTEGER PRIMARY KEY, idIntesta INT, annoComp INT, DataEmiss DATE, fattNrAnno INT, fattNrNumero NVARCHAR (50), periodFattDtIniz DATE, periodFattDtFine DATE, periodEffDtIniz DATE, periodEffDtFine DATE, periodAccontoDtIniz DATE, periodAccontoDtFine DATE, accontoBollPrec MONEY, addizFER MONEY, impostaQuiet MONEY, TotPagare MONEY, nomeFile TEXT);
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
CREATE TABLE Intesta (idIntesta INTEGER NOT NULL, NomeIntesta NVARCHAR (64) NOT NULL, dirfatture NVARCHAR (128) NOT NULL);
CREATE VIEW EEConsumoMensile AS SELECT te.NomeIntesta, cs.idEEFattura, cs.dtIniz, strftime('%Y-%m', cs.dtIniz) AS meseComp, CAST (strftime('%Y', cs.dtIniz) AS int) AS annoComp, cs.tipoSpesa, cs.prezzoUnit, cs.quantita, cs.importo FROM EEConsumo AS cs INNER JOIN EEFattura AS ft ON ft.idEEFattura = cs.idEEFattura INNER JOIN Intesta AS te ON ft.idIntesta = te.idIntesta WHERE 1 = 1 AND 0 < (SELECT SUM(LettAttuale) FROM EELettura WHERE idEEFattura = ft.idEEFattura)
/* EEConsumoMensile(NomeIntesta,idEEFattura,dtIniz,meseComp,annoComp,tipoSpesa,prezzoUnit,quantita,importo) */;
CREATE VIEW EELettureMensili AS SELECT te.NomeIntesta, le.idLettura, le.idEEFattura, CAST (strftime('%Y', le.LettDtAttuale) AS int) AS annoComp, le.LettDtPrec, le.TipoLettura, le.LettPrec, le.LettDtAttuale, le.LettAttuale, le.LettConsumo, JULIANDAY(le.LettDtAttuale) - JULIANDAY(le.LettDtPrec) AS qtaGG FROM EELettura AS le INNER JOIN EEFattura AS ft ON ft.idEEFattura = le.idEEFattura INNER JOIN Intesta AS te ON ft.idIntesta = te.idIntesta
/* EELettureMensili(NomeIntesta,idLettura,idEEFattura,annoComp,LettDtPrec,TipoLettura,LettPrec,LettDtAttuale,LettAttuale,LettConsumo,qtaGG) */;
CREATE VIEW GASConsumoMensile AS SELECT te.NomeIntesta, cs.idGASFattura, strftime('%Y-%m', cs.dtIniz) AS meseComp, CAST (strftime('%Y', cs.dtIniz) AS int) AS annoComp, cs.dtIniz AS dtIniz, cs.dtFine AS dtFine, cs.tipoSpesa, cs.prezzoUnit, cs.quantita, JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1 AS qtaGG, cs.quantita / (JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1) AS mediaGG, cs.importo FROM GASConsumo AS cs INNER JOIN GASFattura AS ft ON ft.idGASFattura = cs.idGASFattura INNER JOIN Intesta AS te ON ft.idIntesta = te.idIntesta WHERE ft.periodEffDtIniz IS NOT NULL AND cs.dtIniz BETWEEN (SELECT MIN(lt.lettData) FROM GASLettura AS lt WHERE lt.idGASFattura = ft.idGASFattura) AND (SELECT MAX(lt.lettData) FROM GASLettura AS lt WHERE lt.idGASFattura = ft.idGASFattura)
/* GASConsumoMensile(NomeIntesta,idGASFattura,meseComp,annoComp,dtIniz,dtFine,tipoSpesa,prezzoUnit,quantita,qtaGG,mediaGG,importo) */;
CREATE VIEW GASLettureMensili AS SELECT te.NomeIntesta, ft.idGASFattura, ft.annoComp, ft.periodAccontoDtIniz, ft.periodAccontoDtFine, ft.periodEffDtIniz, ft.periodEffDtFine, ft.periodFattDtIniz, ft.periodFattDtFine, le.LettData, le.lettQtaMc, le.TipoLett, le.Consumofatt FROM GASLettura AS le INNER JOIN GASFattura AS ft ON ft.idGASFattura = le.idGASFattura INNER JOIN Intesta AS te ON ft.idIntesta = te.idIntesta WHERE 1 = 1
/* GASLettureMensili(NomeIntesta,idGASFattura,annoComp,periodAccontoDtIniz,periodAccontoDtFine,periodEffDtIniz,periodEffDtFine,periodFattDtIniz,periodFattDtFine,LettData,lettQtaMc,TipoLett,Consumofatt) */;
CREATE VIEW H2OConsumoMensile AS SELECT te.NomeIntesta, cs.idH2OFattura, CAST (strftime('%Y', cs.dtIniz) AS INT) AS annoComp, cs.dtIniz, cs.dtFine, cs.tipoSpesa, cs.prezzoUnit, cs.quantita, cs.importo FROM H2OConsumo AS cs INNER JOIN H2OFattura AS ft ON ft.idH2OFattura = cs.idH2OFattura INNER JOIN Intesta AS te ON ft.idIntesta = te.idIntesta
/* H2OConsumoMensile(NomeIntesta,idH2OFattura,annoComp,dtIniz,dtFine,tipoSpesa,prezzoUnit,quantita,importo) */;
