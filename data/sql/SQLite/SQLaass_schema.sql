--
-- File generato con SQLiteStudio v3.4.4 su dom ott 13 15:42:31 2024
--
-- Codifica del testo utilizzata: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Tabella: EEConsumo
DROP TABLE IF EXISTS EEConsumo;

CREATE TABLE IF NOT EXISTS EEConsumo (
    idEEConsumo INTEGER         PRIMARY KEY,
    idEEFattura INT             NOT NULL,
    tipoSpesa   TEXT (2),
    dtIniz      DATE,
    dtFine      DATE,
    stimato     INTEGER,
    prezzoUnit  DECIMAL (10, 6),
    quantita    DECIMAL (8, 2),
    importo     DECIMAL (8, 2) 
);


-- Tabella: EEFattura
DROP TABLE IF EXISTS EEFattura;

CREATE TABLE IF NOT EXISTS EEFattura (
    idEEFattura      INTEGER       PRIMARY KEY,
    idIntesta        INT,
    annoComp         INT,
    DataEmiss        DATE,
    fattNrAnno       INT,
    fattNrNumero     NVARCHAR (50),
    periodFattDtIniz DATE,
    periodFattDtFine DATE,
    CredPrecKwh      INT,
    CredAttKwh       INT,
    addizFER         MONEY,
    impostaQuiet     MONEY,
    TotPagare        MONEY,
    nomeFile         TEXT
);


-- Tabella: EELettura
DROP TABLE IF EXISTS EELettura;

CREATE TABLE IF NOT EXISTS EELettura (
    idLettura     INTEGER      PRIMARY KEY,
    idEEFattura   INT          NOT NULL,
    LettDtPrec    DATE,
    LettPrec      INT,
    TipoLettura   VARCHAR (16),
    LettDtAttuale DATE,
    LettAttuale   INT,
    LettConsumo   FLOAT
);

-- Tabella: EETipoConsumo
DROP TABLE IF EXISTS EETipoConsumo;

CREATE TABLE IF NOT EXISTS EETipoConsumo (
    EEtp      TEXT PRIMARY KEY,
    EEtpDescr TEXT
);

INSERT INTO EETipoConsumo (EEtp, EEtpDescr) VALUES ('R', 'Rifiuti');
INSERT INTO EETipoConsumo (EEtp, EEtpDescr) VALUES ('P', 'Potenza imp.');
INSERT INTO EETipoConsumo (EEtp, EEtpDescr) VALUES ('PU', 'Ener. PUN');
INSERT INTO EETipoConsumo (EEtp, EEtpDescr) VALUES ('S1', 'Spread Sc.1');
INSERT INTO EETipoConsumo (EEtp, EEtpDescr) VALUES ('S2', 'Spread Sc.2');
INSERT INTO EETipoConsumo (EEtp, EEtpDescr) VALUES ('E1', 'Ener. Scgl.1');
INSERT INTO EETipoConsumo (EEtp, EEtpDescr) VALUES ('E2', 'Ener. Scgl.2');
INSERT INTO EETipoConsumo (EEtp, EEtpDescr) VALUES ('E3', 'Ener. Scgl.3');

-- Tabella: GASConsumo
DROP TABLE IF EXISTS GASConsumo;

CREATE TABLE IF NOT EXISTS GASConsumo (
    idConsumo    INTEGER         PRIMARY KEY,
    idGASFattura INT             NOT NULL,
    tipoSpesa    VARCHAR (4),
    dtIniz       DATE,
    dtFine       DATE,
    stimato      INTEGER,
    prezzoUnit   DECIMAL (10, 6),
    quantita     DECIMAL (8, 2),
    importo      MONEY
);


-- Tabella: GASFattura
DROP TABLE IF EXISTS GASFattura;

CREATE TABLE IF NOT EXISTS GASFattura (
    idGASFattura        INTEGER       PRIMARY KEY,
    idIntesta           INT,
    annoComp            INT,
    DataEmiss           DATE,
    fattNrAnno          INT,
    fattNrNumero        NVARCHAR (50),
    periodFattDtIniz    DATE,
    periodFattDtFine    DATE,
    periodEffDtIniz     DATE,
    periodEffDtFine     DATE,
    periodAccontoDtIniz DATE,
    periodAccontoDtFine DATE,
    accontoBollPrec     MONEY,
    addizFER            MONEY,
    impostaQuiet        MONEY,
    TotPagare           MONEY,
    nomeFile            TEXT
);

-- Tabella: GASLettura
DROP TABLE IF EXISTS GASLettura;

CREATE TABLE IF NOT EXISTS GASLettura (
    idLettura    INTEGER      PRIMARY KEY,
    idGASFattura INT          NOT NULL,
    lettQtaMc    INT,
    LettData     DATE,
    TipoLett     VARCHAR (16),
    Consumofatt  FLOAT
);

-- Tabella: H2OConsumo
DROP TABLE IF EXISTS H2OConsumo;

CREATE TABLE IF NOT EXISTS H2OConsumo (
    idConsumo    INTEGER         PRIMARY KEY,
    idH2OFattura INT             NOT NULL,
    tipoSpesa    VARCHAR (4),
    dtIniz       DATE,
    dtFine       DATE,
    stimato      INTEGER,
    prezzoUnit   DECIMAL (10, 6),
    quantita     DECIMAL (8, 2),
    importo      MONEY
);

-- Tabella: H2OFattura
DROP TABLE IF EXISTS H2OFattura;

CREATE TABLE IF NOT EXISTS H2OFattura (
    idH2OFattura        INTEGER       PRIMARY KEY,
    idIntesta           INT,
    annoComp            INT,
    DataEmiss           DATE,
    fattNrAnno          INT,
    fattNrNumero        NVARCHAR (50),
    periodFattDtIniz    DATE,
    periodFattDtFine    DATE,
    periodCongDtIniz    DATE,
    periodCongDtFine    DATE,
    periodAccontoDtIniz DATE,
    periodAccontoDtFine DATE,
    assicurazione       MONEY,
    impostaQuiet        MONEY,
    RestituzAccPrec     MONEY,
    TotPagare           MONEY,
    nomeFile            TEXT
);


-- Tabella: H2OLettura
DROP TABLE IF EXISTS H2OLettura;

CREATE TABLE IF NOT EXISTS H2OLettura (
    idLettura    INTEGER      PRIMARY KEY,
    idH2OFattura INT          NOT NULL,
    lettQtaMc    INT,
    LettData     DATE,
    TipoLett     VARCHAR (16),
    Consumofatt  FLOAT
);


-- Tabella: Intesta
DROP TABLE IF EXISTS Intesta;

CREATE TABLE IF NOT EXISTS Intesta (
    idIntesta   INTEGER        PRIMARY KEY,
    NomeIntesta NVARCHAR (64),
    dirfatture  NVARCHAR (128) 
);

INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (1, 'claudio', 'F:\Google Drive\SMichele\AASS');
INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (2, 'alessandro', 'F:\varie\AASS\Alessandro');
INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (3, 'andrea', 'F:\varie\AASS\Andrea');

-- Tabella: prova
DROP TABLE IF EXISTS prova;

-- Indice: UX_EEFattura_dataEmiss
DROP INDEX IF EXISTS UX_EEFattura_dataEmiss;

CREATE UNIQUE INDEX IF NOT EXISTS UX_EEFattura_dataEmiss ON EEFattura (
    idIntesta,
    DataEmiss
);


-- Indice: UX_GASFattura_dataEmiss
DROP INDEX IF EXISTS UX_GASFattura_dataEmiss;

CREATE UNIQUE INDEX IF NOT EXISTS UX_GASFattura_dataEmiss ON GASFattura (
    idIntesta,
    DataEmiss
);


-- Indice: UX_H2OFattura_dataEmiss
DROP INDEX IF EXISTS UX_H2OFattura_dataEmiss;

CREATE UNIQUE INDEX IF NOT EXISTS UX_H2OFattura_dataEmiss ON H2OFattura (
    idIntesta,
    DataEmiss
);


-- Vista: EEConsumoAnnuo
DROP VIEW IF EXISTS EEConsumoAnnuo;
CREATE VIEW IF NOT EXISTS EEConsumoAnnuo AS
    SELECT NomeIntesta,
           annoComp,
           SUM(quantita) AS totAnno
      FROM EEConsumoMensile
     WHERE stimato = 0
     GROUP BY NomeIntesta,
              annoComp;


-- Vista: EEConsumoMensile
DROP VIEW IF EXISTS EEConsumoMensile;
CREATE VIEW IF NOT EXISTS EEConsumoMensile AS
    SELECT te.NomeIntesta,
           cs.idEEFattura,
           cs.dtIniz,
           strftime('%Y-%m', cs.dtIniz) AS meseComp,
           CAST (strftime('%Y', cs.dtIniz) AS INT) AS annoComp,
           cs.tipoSpesa,
           tpee.EEtpDescr,
           cs.prezzoUnit,
           cs.stimato,
           cs.quantita,
           cs.importo,
           ft.nomeFile
      FROM EEConsumo AS cs
           INNER JOIN
           EEFattura AS ft ON ft.idEEFattura = cs.idEEFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta
           LEFT OUTER JOIN
           EETipoConsumo tpee ON cs.tipospesa = tpee.EEtp
     WHERE 1 = 1 AND 
           0 < (
                   SELECT SUM(LettAttuale) 
                     FROM EELettura
                    WHERE idEEFattura = ft.idEEFattura
               );


-- Vista: EECostoAnnuo
DROP VIEW IF EXISTS EECostoAnnuo;
CREATE VIEW IF NOT EXISTS EECostoAnnuo AS
    SELECT NomeIntesta,
           annoComp,
           SUM(importo) AS totAnno
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              annoComp;


-- Vista: EELettureMensili
DROP VIEW IF EXISTS EELettureMensili;
CREATE VIEW IF NOT EXISTS EELettureMensili AS
    SELECT te.NomeIntesta,
           le.idLettura,
           le.idEEFattura,
           CAST (strftime('%Y', le.LettDtAttuale) AS INT) AS annoComp,
           le.LettDtPrec,-- strftime('%Y.%m',DATE(le.LettDtPrec)) as mmDtPrec,
           le.TipoLettura,
           le.LettPrec,
           le.LettDtAttuale,
           strftime('%Y-%m', le.LettDtAttuale) AS meseComp,
           le.LettAttuale,
           le.LettConsumo,
           JULIANDAY(le.LettDtAttuale) - JULIANDAY(le.LettDtPrec) AS qtaGG
      FROM EELettura AS le
           INNER JOIN
           EEFattura AS ft ON ft.idEEFattura = le.idEEFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta;


-- Vista: EEScaglioniImporti
DROP VIEW IF EXISTS EEScaglioniImporti;
CREATE VIEW IF NOT EXISTS EEScaglioniImporti AS
    SELECT NomeIntesta,
           annoComp,
           dtIniz,
           IFNULL(SUM(CASE WHEN tipospesa = 'E1' THEN importo END), 0) AS EESca1,
           IFNULL(SUM(CASE WHEN tipospesa = 'E2' THEN importo END), 0) AS EESca2,
           IFNULL(SUM(CASE WHEN tipospesa = 'E3' THEN importo END), 0) AS EESca3,
           IFNULL(SUM(CASE WHEN tipospesa = 'S1' THEN importo END), 0) AS SpreadSc1,
           IFNULL(SUM(CASE WHEN tipospesa = 'S2' THEN importo END), 0) AS SpreadSc2,
           IFNULL(SUM(CASE WHEN tipospesa = 'PU' THEN importo END), 0) AS Pun,
           IFNULL(SUM(CASE WHEN tipospesa = 'R' THEN importo END), 0) AS Rifiuti,
           IFNULL(SUM(CASE WHEN tipospesa = 'P' THEN importo END), 0) AS ImpegnoPot
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              annoComp,
              dtIniz
     ORDER BY nomeIntesta,
              dtIniz;


-- Vista: EEScaglioniPrezzoUnit
DROP VIEW IF EXISTS EEScaglioniPrezzoUnit;
CREATE VIEW IF NOT EXISTS EEScaglioniPrezzoUnit AS
    SELECT NomeIntesta,
           annoComp,
           dtIniz,
           SUM(IFNULL( (CASE WHEN tipospesa = 'E1' THEN prezzoUnit END), 0) ) AS Sca1,
           SUM(IFNULL( (CASE WHEN tipospesa = 'E2' THEN prezzoUnit END), 0) ) AS Sca2,
           SUM(IFNULL( (CASE WHEN tipospesa = 'E3' THEN prezzoUnit END), 0) ) AS Sca3,
           SUM(IFNULL( (CASE WHEN tipospesa = 'S1' THEN prezzoUnit END), 0) ) AS SpreadSc1,
           SUM(IFNULL( (CASE WHEN tipospesa = 'S2' THEN prezzoUnit END), 0) ) AS SpreadSc2,
           SUM(IFNULL( (CASE WHEN tipospesa = 'PU' THEN prezzoUnit END), 0) ) AS Pun,
           SUM(IFNULL( (CASE WHEN tipospesa = 'R' THEN prezzoUnit END), 0) ) AS Rifiuti,
           SUM(IFNULL( (CASE WHEN tipospesa = 'P' THEN prezzoUnit END), 0) ) AS ImpegnoTot
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              annoComp,
              dtIniz;


-- Vista: GASConsumoAnnuo
DROP VIEW IF EXISTS GASConsumoAnnuo;
CREATE VIEW IF NOT EXISTS GASConsumoAnnuo AS
    SELECT NomeIntesta,
           annoComp,
           SUM(quantita) AS consumoAnnuo
      FROM GASConsumoMensile
     WHERE stimato = 0
     GROUP BY NomeIntesta,
              annoComp;


-- Vista: GASConsumoMensile
DROP VIEW IF EXISTS GASConsumoMensile;
CREATE VIEW IF NOT EXISTS GASConsumoMensile AS
    SELECT te.NomeIntesta,
           cs.idGASFattura/* ,dbo.toAnnoMese(cs.dtIniz) as dtIniz */,
           strftime('%Y-%m', cs.dtIniz) AS meseComp,
           CAST (strftime('%Y', cs.dtIniz) AS INT) AS annoComp,
           cs.dtIniz AS dtIniz,
           cs.dtFine AS dtFine,
           ft.periodFattDtIniz,
           ft.periodFattDtFine,
           cs.tipoSpesa,
           cs.prezzoUnit,
           cs.quantita,
           cs.stimato,
           JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1 AS qtaGG,
           cs.quantita / (JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1) AS mediaGG,
           cs.importo,
           ft.nomeFile
      FROM GASConsumo AS cs
           INNER JOIN
           GASFattura AS ft ON ft.idGASFattura = cs.idGASFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta
     WHERE ft.periodEffDtIniz IS NOT NULL;
-- ,dbo.toAnnoMese(cs.dtFine) as dtFine-- AND cs.dtIniz BETWEEN-- ft.periodEffDtIniz-- ( SELECT MIN(lt.lettData)-- FROM GASLettura as lt-- WHERE lt.idGASFattura=ft.idGASFattura )-- AND-- ft.periodEffDtFine-- ( SELECT MAX(lt.lettData)-- FROM GASLettura as lt-- WHERE lt.idGASFattura=ft.idGASFattura )

-- Vista: GASCostoAnnuo
DROP VIEW IF EXISTS GASCostoAnnuo;
CREATE VIEW IF NOT EXISTS GASCostoAnnuo AS
    SELECT NomeIntesta,
           annoComp,
           SUM(importo) AS costoAnnuo
      FROM GASConsumoMensile
     WHERE stimato = 0
     GROUP BY NomeIntesta,
              annoComp;


-- Vista: GASLettureMensili
DROP VIEW IF EXISTS GASLettureMensili;
CREATE VIEW IF NOT EXISTS GASLettureMensili AS
    SELECT te.NomeIntesta,
           ft.idGASFattura,
           ft.annoComp,
           strftime('%Y-%m', le.LettData) AS meseComp,
           ft.periodAccontoDtIniz,
           ft.periodAccontoDtFine,
           ft.periodEffDtIniz,
           ft.periodEffDtFine,
           ft.periodFattDtIniz,
           ft.periodFattDtFine,
           le.LettData,
           le.lettQtaMc,
           le.TipoLett,
           le.Consumofatt,
           ft.nomeFile
      FROM GASLettura AS le
           INNER JOIN
           GASFattura AS ft ON ft.idGASFattura = le.idGASFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta
     WHERE 1 = 1;


-- Vista: GASLettureMensiliTipo
DROP VIEW IF EXISTS GASLettureMensiliTipo;
CREATE VIEW IF NOT EXISTS GASLettureMensiliTipo AS
    SELECT NomeIntesta/* ,annoComp */,
           idGASFattura,
           strftime('%Y-%m-%d', COALESCE(periodAccontoDtIniz, periodEffDtIniz, periodFattDtIniz) ) AS dtIniz,
           strftime('%Y-%m-%d', COALESCE(periodAccontoDtFine, periodEffDtFine, periodFattDtFine) ) AS dtFine/* ,periodAccontoDtFine */,
           SUM(IFNULL( (CASE WHEN tipoLett = 'eff' THEN lettQtaMc END), 0) ) AS qtaMcEff,
           SUM(IFNULL( (CASE WHEN tipoLett = 'stim' THEN lettQtaMc END), 0) ) AS qtaMcStim,
           SUM(IFNULL( (CASE WHEN tipoLett = 'auto' THEN lettQtaMc END), 0) ) AS qtaMcAuto,
           SUM(IFNULL( (CASE WHEN tipoLett = 'tot' THEN lettQtaMc END), 0) ) AS qtaMcTot,
           SUM(IFNULL( (CASE WHEN tipoLett = 'eff' THEN Consumofatt END), 0) ) AS ConsumofattEff,
           SUM(IFNULL( (CASE WHEN tipoLett = 'stim' THEN Consumofatt END), 0) ) AS ConsumofattStim,
           SUM(IFNULL( (CASE WHEN tipoLett = 'auto' THEN Consumofatt END), 0) ) AS ConsumofattAuto,
           SUM(IFNULL( (CASE WHEN tipoLett = 'tot' THEN Consumofatt END), 0) ) AS ConsumofattTot
      FROM GASLettureMensili
     GROUP BY NomeIntesta,
              dtIniz,
              dtFine;
-- ,periodEffDtIniz-- ,periodEffDtFine-- ,periodFattDtIniz-- ,periodFattDtFine-- ,LettData

-- Vista: GASScaglioniImporto
DROP VIEW IF EXISTS GASScaglioniImporto;
CREATE VIEW IF NOT EXISTS GASScaglioniImporto AS
SELECT
    NomeIntesta                                       ,
    idGASFattura                                      ,
    annoComp                                          ,
    dtIniz                                            ,
    dtFine                                            ,
    JULIANDAY(dtFine) - JULIANDAY(dtIniz) + 1 AS qtaGG,
    SUM(CASE WHEN tipospesa = 'G1' THEN importo END) AS Scagl1,
    SUM(CASE WHEN tipospesa = 'G2' THEN importo END) AS Scagl2,
    SUM(CASE WHEN tipospesa = 'G3' THEN importo END) AS Scagl3,
    COALESCE(SUM(CASE WHEN tipospesa = 'G1' THEN importo END), 0) + 
	COALESCE(SUM(CASE WHEN tipospesa = 'G2' THEN importo END), 0) + 
	COALESCE(SUM(CASE WHEN tipospesa = 'G3' THEN importo END), 0) AS Totale,
    (COALESCE(SUM(CASE WHEN tipospesa = 'G1' THEN importo END), 0) + 
	 COALESCE(SUM(CASE WHEN tipospesa = 'G2' THEN importo END), 0) + 
	 COALESCE(SUM(CASE WHEN tipospesa = 'G3' THEN importo END), 0) ) / 
	 (JULIANDAY(dtFine) - JULIANDAY(dtIniz) + 1) AS mediaGG
FROM
    GASConsumoMensile
GROUP BY
    NomeIntesta ,
    idGASFattura,
    dtIniz      ,
    dtFine;

-- Vista: GASScaglioniPrezzoUnit
DROP VIEW IF EXISTS GASScaglioniPrezzoUnit;
CREATE VIEW IF NOT EXISTS GASScaglioniPrezzoUnit AS
    SELECT NomeIntesta,
           annoComp,
           dtIniz,
           dtFine,
           JULIANDAY(dtFine) - JULIANDAY(dtIniz) AS qtaGG,
           SUM(IFNULL( (CASE WHEN tipospesa = 'G1' THEN prezzoUnit END), 0) ) AS Sca1,
           SUM(IFNULL( (CASE WHEN tipospesa = 'G2' THEN prezzoUnit END), 0) ) AS Sca2,
           SUM(IFNULL( (CASE WHEN tipospesa = 'G3' THEN prezzoUnit END), 0) ) AS Sca3,
           SUM(IFNULL( (CASE WHEN tipospesa = 'G1' THEN prezzoUnit END), 0) ) + SUM(IFNULL( (CASE WHEN tipospesa = 'G2' THEN prezzoUnit END), 0) ) + SUM(IFNULL( (CASE WHEN tipospesa = 'G3' THEN prezzoUnit END), 0) ) AS Totale,
           (SUM(IFNULL( (CASE WHEN tipospesa = 'G1' THEN prezzoUnit END), 0) ) + SUM(IFNULL( (CASE WHEN tipospesa = 'G2' THEN prezzoUnit END), 0) ) + SUM(IFNULL( (CASE WHEN tipospesa = 'G3' THEN prezzoUnit END), 0) ) ) / CAST ( (JULIANDAY(dtFine) - JULIANDAY(dtIniz) ) AS FLOAT) AS mediaGG
      FROM GASConsumoMensile
     GROUP BY NomeIntesta,
              annoComp,
              dtIniz;


-- Vista: H2OConsumoMensile
DROP VIEW IF EXISTS H2OConsumoMensile;
CREATE VIEW IF NOT EXISTS H2OConsumoMensile AS
    SELECT te.NomeIntesta,
           cs.idH2OFattura,
           CAST (strftime('%Y', cs.dtIniz) AS INT) AS annoComp,
           cs.dtIniz,
           cs.dtFine,
           cs.tipoSpesa,
           cs.stimato,
           cs.prezzoUnit,
           cs.quantita,
           cs.importo,
           ft.nomeFile
      FROM H2OConsumo AS cs
           INNER JOIN
           H2OFattura AS ft ON ft.idH2OFattura = cs.idH2OFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta;


-- Vista: H2OScaglioniImporti
DROP VIEW IF EXISTS H2OScaglioniImporti;
CREATE VIEW IF NOT EXISTS H2OScaglioniImporti AS
    SELECT NomeIntesta,
           annoComp,
           dtIniz,
           dtFine,
           CAST (julianday('%d', dtFine) AS INT) - CAST (julianday('%d', dtIniz) AS INT) AS qtaGG,
           IFNULL(SUM(CASE WHEN tipospesa = 'S1' THEN importo END), 0) AS Sca1,
           IFNULL(SUM(CASE WHEN tipospesa = 'S2' THEN importo END), 0) AS Sca2,
           IFNULL(SUM(CASE WHEN tipospesa = 'S3' THEN importo END), 0) AS Sca3,
           IFNULL(SUM(CASE WHEN tipospesa = 'S4' THEN importo END), 0) AS Sca4,
           IFNULL(SUM(CASE WHEN tipospesa = 'TA1' THEN importo END), 0) AS TarA1,
           IFNULL(SUM(CASE WHEN tipospesa = 'TA2' THEN importo END), 0) AS TarA2,
           IFNULL(SUM(CASE WHEN tipospesa = 'TA3' THEN importo END), 0) AS TarA3,
           IFNULL(SUM(CASE WHEN tipospesa = 'TA4' THEN importo END), 0) AS TarA4,
           IFNULL(SUM(CASE WHEN tipospesa = 'F' THEN importo END), 0) AS quotaFissa
      FROM H2OConsumoMensile
     GROUP BY NomeIntesta,
              annoComp,
              dtIniz,
              dtFine
     ORDER BY nomeIntesta,
              dtIniz;


-- Vista: H2OScaglioniPrezzoUnit
DROP VIEW IF EXISTS H2OScaglioniPrezzoUnit;
CREATE VIEW IF NOT EXISTS H2OScaglioniPrezzoUnit AS
    SELECT NomeIntesta,
           annoComp,
           dtIniz,
           dtFine,
           JULIANDAY(dtFine) - JULIANDAY(dtIniz) AS qtaGG,
           IFNULL(SUM(CASE WHEN tipospesa = 'S1' THEN prezzoUnit END), 0) AS Sca1,
           IFNULL(SUM(CASE WHEN tipospesa = 'S2' THEN prezzoUnit END), 0) AS Sca2,
           IFNULL(SUM(CASE WHEN tipospesa = 'S3' THEN prezzoUnit END), 0) AS Sca3,
           IFNULL(SUM(CASE WHEN tipospesa = 'S4' THEN prezzoUnit END), 0) AS Sca4,
           IFNULL(SUM(CASE WHEN tipospesa = 'TA1' THEN prezzoUnit END), 0) AS TarA1,
           IFNULL(SUM(CASE WHEN tipospesa = 'TA2' THEN prezzoUnit END), 0) AS TarA2,
           IFNULL(SUM(CASE WHEN tipospesa = 'TA3' THEN prezzoUnit END), 0) AS TarA3,
           IFNULL(SUM(CASE WHEN tipospesa = 'TA4' THEN prezzoUnit END), 0) AS TarA4,
           IFNULL(SUM(CASE WHEN tipospesa = 'F' THEN prezzoUnit END), 0) AS quotaFissa
      FROM H2OConsumoMensile
     GROUP BY NomeIntesta,
              annoComp,
              dtIniz,
              dtFine
     ORDER BY nomeIntesta,
              dtIniz;


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
