CREATE TABLE Intesta (
    idIntesta   INTEGER PRIMARY KEY,
    NomeIntesta NVARCHAR (64),
    dirfatture  NVARCHAR (128)
);

CREATE TABLE EEFattura (
    idEEFattura      INTEGER PRIMARY KEY,
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
	FOREIGN KEY(idIntesta) REFERENCES Intesta(idIntesta)
);
CREATE TABLE EELettura (
    idLettura     INTEGER PRIMARY KEY,
    idEEFattura   INT                   NOT NULL,
    LettDtPrec    DATE,
    LettPrec      INT,
    TipoLettura   VARCHAR (16),
    LettDtAttuale DATE,
    LettAttuale   INT,
    LettConsumo   FLOAT,
	FOREIGN KEY(idEEFattura) REFERENCES EEFattura(idEEFattura)
);
CREATE TABLE EEConsumo (
    idEEConsumo INTEGER         PRIMARY KEY,
    idEEFattura INT             NOT NULL,
    tipoSpesa   TEXT (2),
    dtIniz      DATE,
    dtFine      DATE,
    prezzoUnit  DECIMAL (10, 6),
    quantita    DECIMAL (8, 2),
    importo     DECIMAL (8,2),
	FOREIGN KEY(idEEFattura) REFERENCES EEFattura(idEEFattura)
);

CREATE TABLE GASFattura (
    idGASFattura        INTEGER PRIMARY KEY,
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
	FOREIGN KEY(idIntesta) REFERENCES Intesta(idIntesta)
);
CREATE TABLE GASLettura (
    idLettura    INTEGER PRIMARY KEY,
    idGASFattura INT                   NOT NULL,
    lettQtaMc    INT,
    LettData     DATE,
    TipoLett     VARCHAR (16),
    Consumofatt  FLOAT,
	FOREIGN KEY(idGASFattura) REFERENCES GASFattura(idGASFattura)
);
CREATE TABLE GASConsumo (
    idConsumo    INTEGER PRIMARY KEY,
    idGASFattura INT                   NOT NULL,
    tipoSpesa    VARCHAR (4),
    dtIniz       DATE,
    dtFine       DATE,
    prezzoUnit   DECIMAL (10, 6),
    quantita     DECIMAL (8, 2),
    importo      MONEY,
	FOREIGN KEY(idGASFattura) REFERENCES GASFattura(idGASFattura)
);

CREATE TABLE H2OFattura (
    idH2OFattura        INTEGER PRIMARY KEY,
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
	FOREIGN KEY(idIntesta) REFERENCES Intesta(idIntesta)
);
CREATE TABLE H2OLettura (
    idLettura    INTEGER PRIMARY KEY,
    idH2OFattura INT                   NOT NULL,
    lettQtaMc    INT,
    LettData     DATE,
    TipoLett     VARCHAR (16),
    Consumofatt  FLOAT,
	FOREIGN KEY(idH2OFattura) REFERENCES H2OFattura(idH2OFattura)
);
CREATE TABLE H2OConsumo (
    idConsumo    INTEGER PRIMARY KEY,
    idH2OFattura INT                   NOT NULL,
    tipoSpesa    VARCHAR (4),
    dtIniz       DATE,
    dtFine       DATE,
    prezzoUnit   DECIMAL (10, 6),
    quantita     DECIMAL (8, 2),
    importo      MONEY,
	FOREIGN KEY(idH2OFattura) REFERENCES H2OFattura(idH2OFattura)
);

CREATE TABLE prova (
	chiave INTEGER PRIMARY KEY NOT NULL, 
	stringa TEXT, 
	intero INTEGER, 
	prezzo REAL, 
	dataoggi TEXT, 
    percento REAL, 
    flottante REAL
) STRICT;


CREATE VIEW EEConsumoAnnuo AS
    SELECT NomeIntesta,
           CAST (dtIniz AS INT) AS anno,
           SUM(importo) AS totAnno
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              CAST (dtIniz AS INT)
/* EEConsumoAnnuo(NomeIntesta,anno,totAnno) */;

CREATE VIEW EEConsumoMensPivot AS SELECT te.NomeIntesta,
       cs.dtIniz,
--       cast(cs.dtIniz as int) as anno,
--       cs.tipoSpesa,
       SUM(case when cs.tipospesa = 'E1' then cs.importo end) as E1,
       SUM(case when cs.tipospesa = 'E2' then cs.importo end) as E2,
       SUM(case when cs.tipospesa = 'P' then cs.importo end) as P,
       SUM(case when cs.tipospesa = 'R' then cs.importo end) as R,
       SUM(case when cs.tipospesa = 'PU' then cs.importo end) as PU,
       SUM(case when cs.tipospesa = 'S1' then cs.importo end) as S1,
       SUM(case when cs.tipospesa = 'S2' then cs.importo end) as S2
--       ,cs.quantita
--       ,cs.importo      
   FROM EEConsumo AS cs           
     INNER JOIN EEFattura AS ft 
         ON ft.idEEFattura = cs.idEEFattura
     INNER JOIN intesta AS te
         ON ft.idIntesta = te.idIntesta
 WHERE 1=1
GROUP BY te.nomeIntesta, cs.dtIniz
ORDER BY te.nomeIntesta, cs.dtIniz
/* EEConsumoMensPivot(NomeIntesta,dtIniz,E1,E2,P,R,PU,S1,S2) */;
CREATE VIEW EEConsumoMensile AS SELECT te.NomeIntesta,           
       cs.idEEFattura,           
       cs.dtIniz,           
       cast(cs.dtIniz as int) as annoComp,           
       cs.tipoSpesa,           
       cs.prezzoUnit,           
       cs.quantita,           
       cs.importo      
   FROM EEConsumo AS cs           
     INNER JOIN EEFattura AS ft 
         ON ft.idEEFattura = cs.idEEFattura           
     INNER JOIN intesta AS te 
         ON ft.idIntesta = te.idIntesta     
 WHERE 1=1
/* EEConsumoMensile(NomeIntesta,idEEFattura,dtIniz,annoComp,tipoSpesa,prezzoUnit,quantita,importo) */;
CREATE VIEW EELettureMensili AS SELECT te.NomeIntesta,
           le.idLettura,
           le.idEEFattura,
           le.LettDtPrec,
           strftime('%Y.%m',DATE(le.LettDtPrec)) as mmDtPrec,
           le.TipoLettura,
           le.LettPrec,
           le.LettDtAttuale,
           strftime('%Y.%m',le.LettDtAttuale) as mmDtAttuale,
           le.LettAttuale,
           le.LettConsumo
      FROM EELettura AS le
           INNER JOIN
           EEFattura AS ft ON ft.idEEFattura = le.idEEFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta
/* EELettureMensili(NomeIntesta,idLettura,idEEFattura,LettDtPrec,mmDtPrec,TipoLettura,LettPrec,LettDtAttuale,mmDtAttuale,LettAttuale,LettConsumo) */;
CREATE VIEW GASConsumoMensile AS SELECT te.NomeIntesta 
      ,cs.idGASFattura
      --,dbo.toAnnoMese(cs.dtIniz) as dtIniz
      --,dbo.toAnnoMese(cs.dtFine) as dtFine
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
   AND cs.dtIniz BETWEEN ft.periodEffDtIniz  AND ft.periodEffDtFine
/* GASConsumoMensile(NomeIntesta,idGASFattura,dtIniz,dtFine,tipoSpesa,prezzoUnit,quantita,qtaGG,mediaGG,importo) */;
CREATE VIEW GASLettureMensili AS SELECT te.NomeIntesta
      -- ,le.idLettura
      -- ,le.idGASFattura
      ,ft.periodFattDtIniz as dtFattIniz
      ,ft.periodFattDtFine as dtFattFine
      ,le.LettData  as lettDtPrec
      ,le.TipoLett
      ,le.Consumofatt
  FROM GASLettura as le
    INNER JOIN GASFattura as ft
        ON ft.idGASFattura=le.idGASFattura
    INNER JOIN intesta as te
        ON ft.idIntesta=te.idIntesta
/* GASLettureMensili(NomeIntesta,dtFattIniz,dtFattFine,lettDtPrec,TipoLett,Consumofatt) */;
CREATE VIEW GASScaglioniImporto AS SELECT NomeIntesta
     , idGASFattura
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
/* GASScaglioniImporto(NomeIntesta,idGASFattura,dtIniz,dtFine,qtaGG,Scagl1,Scagl2,Scagl3,Totale,mediaGG) */;
