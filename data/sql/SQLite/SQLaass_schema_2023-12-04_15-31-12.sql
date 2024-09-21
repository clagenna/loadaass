BEGIN;
PRAGMA writable_schema = on;
PRAGMA encoding = 'UTF-8';
PRAGMA page_size = '4096';
PRAGMA auto_vacuum = '0';
PRAGMA user_version = '0';
PRAGMA application_id = '0';
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
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (229, 85, '2020-10-31', 29286, 'real', '2020-11-30', 29491, 205);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (230, 85, '2020-11-30', 29491, 'real', '2020-12-31', 29707, 216);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (231, 86, '2020-12-31', 29707, 'real', '2021-01-31', 29906, 199);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (232, 86, '2021-01-31', 29906, 'real', '2021-02-28', 30066, 160);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (233, 87, '2021-02-28', 30066, 'real', '2021-03-31', 30252, 186);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (234, 87, '2021-03-31', 30252, 'real', '2021-04-30', 30407, 155);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (235, 88, '2021-04-30', 30407, 'real', '2021-05-31', 30550, 143);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (236, 88, '2021-05-31', 30550, 'real', '2021-06-30', 30719, 169);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (237, 89, '2021-06-30', 30719, 'real', '2021-07-31', 30899, 180);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (238, 89, '2021-07-31', 30899, 'real', '2021-08-31', 31091, 192);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (239, 90, '2021-08-31', 31091, 'real', '2021-09-30', 31219, 128);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (240, 90, '2021-09-30', 31219, 'real', '2021-10-31', 31374, 155);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (241, 91, '2021-10-31', 31374, 'real', '2021-11-30', 31529, 155);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (242, 91, '2021-11-30', 31529, 'real', '2021-12-31', 31720, 191);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (243, 92, '2022-02-28', 32085, 'real', '2022-03-31', 32261, 176);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (244, 92, '2022-03-31', 32261, 'real', '2022-04-30', 32419, 158);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (245, 93, '2022-04-30', 32419, 'real', '2022-05-31', 32556, 137);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (246, 93, '2022-05-31', 32556, 'real', '2022-06-30', 32699, 143);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (247, 94, '2022-06-30', 32699, 'real', '2022-07-31', 32880, 181);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (248, 94, '2022-07-31', 32880, 'real', '2022-08-31', 33045, 165);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (249, 95, '2022-08-31', 33045, 'real', '2022-09-30', 33183, 138);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (250, 95, '2022-09-30', 33183, 'real', '2022-10-31', 33364, 181);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (251, 96, '2022-10-31', 33364, 'real', '2022-11-30', 33525, 161);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (252, 96, '2022-11-30', 33525, 'real', '2022-12-31', 33695, 170);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (253, 97, '2022-12-31', 33695, 'real', '2023-01-31', 33865, 170);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (254, 97, '2023-01-31', 33865, 'real', '2023-02-28', 34024, 159);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (255, 98, '2023-02-28', 34024, 'real', '2023-03-31', 34180, 156);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (256, 98, '2023-03-31', 34180, 'real', '2023-04-30', 34325, 145);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (257, 99, '2019-06-30', 23425, 'real', '2019-07-31', 23452, 27);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (258, 99, '2019-07-31', 23452, 'real', '2019-08-31', 23462, 10);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (259, 100, '2019-08-31', 23462, 'real', '2019-09-30', 23501, 39);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (260, 100, '2019-09-30', 23501, 'real', '2019-10-31', 23604, 103);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (261, 101, '2019-10-31', 23604, 'real', '2019-11-30', 23840, 236);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (262, 101, '2019-11-30', 23840, 'real', '2019-12-31', 24249, 409);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (263, 102, '2019-12-31', 24249, 'real', '2020-01-31', 24992, 743);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (264, 102, '2020-01-31', 24992, 'real', '2020-02-29', 25710, 718);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (265, 103, '2020-02-29', 25710, 'real', '2020-03-31', 26218, 508);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (266, 103, '2020-03-31', 26218, 'real', '2020-04-30', 26501, 283);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (267, 104, '2020-04-30', 26501, 'real', '2020-05-31', 26781, 280);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (268, 104, '2020-05-31', 26781, 'real', '2020-06-30', 26896, 115);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (269, 105, '2020-06-30', 26896, 'real', '2020-07-31', 27058, 162);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (270, 105, '2020-07-31', 27058, 'real', '2020-08-31', 27174, 116);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (271, 106, '2020-08-31', 27174, 'real', '2020-09-30', 27290, 116);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (272, 106, '2020-09-30', 27290, 'real', '2020-10-31', 27436, 146);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (273, 107, '2020-10-31', 27436, 'real', '2020-11-30', 27729, 293);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (274, 107, '2020-11-30', 27729, 'real', '2020-12-31', 28072, 343);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (275, 108, '2020-12-31', 28072, 'real', '2021-01-31', 28456, 384);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (276, 108, '2021-01-31', 28456, 'real', '2021-02-28', 28782, 326);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (277, 109, '2021-02-28', 28782, 'real', '2021-03-31', 29091, 309);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (278, 109, '2021-03-31', 29091, 'real', '2021-04-30', 29374, 283);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (279, 110, '2021-04-30', 29374, 'real', '2021-05-31', 29631, 257);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (280, 110, '2021-05-31', 29631, 'real', '2021-06-30', 29836, 205);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (281, 111, '2021-06-30', 29836, 'real', '2021-07-31', 30043, 207);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (282, 111, '2021-07-31', 30043, 'real', '2021-08-31', 30210, 167);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (283, 112, '2021-08-31', 30210, 'real', '2021-09-30', 30414, 204);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (284, 112, '2021-09-30', 30414, 'real', '2021-10-31', 30719, 305);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (285, 113, '2021-10-31', 30719, 'real', '2021-11-30', 31063, 344);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (286, 113, '2021-11-30', 31063, 'real', '2021-12-31', 31342, 279);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (287, 114, '2021-12-31', 31342, 'real', '2022-01-31', 31707, 365);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (288, 114, '2022-01-31', 31707, 'real', '2022-02-28', 31998, 291);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (289, 115, '2022-02-28', 31998, 'real', '2022-03-31', 32313, 315);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (290, 115, '2022-03-31', 32313, 'real', '2022-04-30', 32570, 257);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (327, 132, '2022-04-30', 32570, 'real', '2022-05-31', 32818, 248);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (328, 132, '2022-05-31', 32818, 'real', '2022-06-30', 33064, 246);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (329, 133, '2022-06-30', 0, 'stim', '2022-07-31', 0, 162);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (330, 133, '2022-07-31', 0, 'stim', '2022-08-31', 0, 116);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (331, 134, '2022-06-30', 33064, 'real', '2023-03-31', 35506, 2442);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (332, 134, '2023-03-31', 35506, 'real', '2023-04-26', 35784, 278);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (333, 134, '2023-04-26', 35784, 'real', '2023-04-30', 35824, 40);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (334, 135, '2022-08-31', 0, 'stim', '2022-09-30', 0, 116);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (335, 135, '2022-09-30', 0, 'stim', '2022-10-31', 0, 146);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (89, 36, '2022-10-31', 0, 'stim', '2022-11-30', 0, 293);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (90, 36, '2022-11-30', 0, 'stim', '2022-12-31', 0, 343);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (91, 37, '2022-12-31', 0, 'stim', '2023-01-31', 0, 267);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (92, 37, '2023-01-31', 0, 'stim', '2023-02-28', 0, 266);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (93, 38, '2023-04-30', 35824, 'real', '2023-05-31', 36139, 315);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (94, 38, '2023-05-31', 36139, 'real', '2023-06-30', 36281, 142);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (180, 70, '2019-08-31', 18952, 'real', '2019-09-30', 19221, 269);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (181, 70, '2019-09-30', 19221, 'real', '2019-10-31', 19490, 269);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (182, 71, '2019-10-31', 19490, 'real', '2019-11-30', 19772, 282);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (183, 71, '2019-11-30', 19772, 'real', '2019-12-31', 20089, 317);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (184, 72, '2019-12-31', 20089, 'real', '2020-01-31', 20382, 293);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (185, 72, '2020-01-31', 20382, 'real', '2020-02-29', 20644, 262);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (186, 73, '2020-02-29', 20644, 'real', '2020-03-31', 20958, 314);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (187, 73, '2020-03-31', 20958, 'real', '2020-04-30', 21254, 296);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (188, 74, '2020-04-30', 21254, 'real', '2020-05-31', 21541, 287);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (189, 74, '2020-05-31', 21541, 'real', '2020-06-30', 21803, 262);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (190, 75, '2020-06-30', 21803, 'real', '2020-07-24', 21998, 195);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (191, 75, '2020-07-24', 21998, 'real', '2020-07-31', 22053, 55);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (192, 76, '2020-07-31', 22053, 'real', '2020-08-31', 22376, 323);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (193, 76, '2020-08-31', 22376, 'real', '2020-09-30', 22636, 260);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (194, 76, '2020-09-30', 22636, 'real', '2020-10-31', 22910, 274);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (195, 76, '2020-10-31', 22910, 'real', '2020-11-30', 23217, 307);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (196, 76, '2020-11-30', 23217, 'real', '2020-12-31', 23558, 341);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (197, 77, '2020-12-31', 23558, 'real', '2021-01-31', 23927, 369);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (198, 77, '2021-01-31', 23927, 'real', '2021-02-28', 24245, 318);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (199, 77, '2021-02-28', 24245, 'real', '2021-03-31', 24571, 326);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (200, 77, '2021-03-31', 24571, 'real', '2021-04-30', 24879, 308);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (201, 78, '2021-04-30', 24879, 'real', '2021-05-31', 25173, 294);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (202, 78, '2021-05-31', 25173, 'real', '2021-06-30', 25477, 304);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (203, 78, '2021-06-30', 25477, 'real', '2021-07-31', 25831, 354);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (204, 78, '2021-07-31', 25831, 'real', '2021-08-31', 26192, 361);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (205, 79, '2021-08-31', 26192, 'real', '2021-09-30', 26491, 299);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (206, 79, '2021-09-30', 26491, 'real', '2021-10-31', 26807, 316);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (207, 79, '2021-10-31', 26807, 'real', '2021-11-30', 27132, 325);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (208, 79, '2021-11-30', 27132, 'real', '2021-12-31', 27464, 332);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (209, 80, '2021-12-31', 27464, 'real', '2022-01-31', 27789, 325);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (210, 80, '2022-01-31', 27789, 'real', '2022-02-28', 28090, 301);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (211, 80, '2022-02-28', 28090, 'real', '2022-03-31', 28390, 300);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (212, 80, '2022-03-31', 28390, 'real', '2022-04-30', 28620, 230);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (213, 81, '2022-04-30', 28620, 'real', '2022-05-31', 28931, 311);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (214, 81, '2022-05-31', 28931, 'real', '2022-06-30', 29234, 303);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (215, 81, '2022-06-30', 29234, 'real', '2022-07-31', 29611, 377);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (216, 81, '2022-07-31', 29611, 'real', '2022-08-31', 29968, 357);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (217, 82, '2022-08-31', 29968, 'real', '2022-09-30', 30254, 286);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (218, 82, '2022-09-30', 30254, 'real', '2022-10-31', 30579, 325);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (219, 82, '2022-10-31', 30579, 'real', '2022-11-30', 31228, 649);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (220, 82, '2022-11-30', 31228, 'real', '2022-12-31', 31650, 422);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (221, 83, '2022-12-31', 31650, 'real', '2023-01-31', 32039, 389);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (222, 83, '2023-01-31', 32039, 'real', '2023-02-28', 32384, 345);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (223, 83, '2023-02-28', 32384, 'real', '2023-03-31', 32721, 337);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (224, 83, '2023-03-31', 32721, 'real', '2023-04-30', 33024, 303);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (225, 84, '2023-04-30', 33024, 'real', '2023-05-31', 33333, 309);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (226, 84, '2023-05-31', 33333, 'real', '2023-06-30', 33601, 268);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (227, 84, '2023-06-30', 33601, 'real', '2023-07-31', 33973, 372);
INSERT OR IGNORE INTO 'EELettura'('idLettura', 'idEEFattura', 'LettDtPrec', 'LettPrec', 'TipoLettura', 'LettDtAttuale', 'LettAttuale', 'LettConsumo') VALUES (228, 84, '2023-07-31', 33973, 'real', '2023-08-31', 34411, 438);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (1, 1, 6629, '2019-05-22', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (2, 1, NULL, NULL, 'stim', 222);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (3, 1, NULL, NULL, 'tot', 222);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (4, 2, 6629, '2019-05-22', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (5, 2, 6936, '2019-12-18', 'eff', 307);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (6, 2, NULL, NULL, 'stim', 334);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (7, 2, NULL, NULL, 'tot', 641);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (8, 3, 6936, '2019-12-18', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (9, 3, 7383, '2020-02-24', 'eff', 447);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (10, 3, NULL, NULL, 'stim', 191);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (11, 3, NULL, NULL, 'tot', 638);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (12, 4, 7383, '2020-02-24', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (13, 4, 7642, '2020-05-21', 'eff', 259);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (14, 4, NULL, NULL, 'stim', 13);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (15, 4, NULL, NULL, 'tot', 272);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (16, 5, 7642, '2020-05-21', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (17, 5, NULL, NULL, 'stim', 52);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (18, 5, NULL, NULL, 'tot', 52);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (19, 6, 7642, '2020-05-21', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (20, 6, NULL, NULL, 'stim', 65);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (21, 6, NULL, NULL, 'tot', 65);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (22, 7, 7642, '2020-05-21', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (23, 7, NULL, NULL, 'stim', 222);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (24, 7, NULL, NULL, 'tot', 222);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (25, 8, 7642, '2020-05-21', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (26, 8, 8017, '2020-12-21', 'eff', 375);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (27, 8, NULL, NULL, 'stim', 311);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (28, 8, NULL, NULL, 'tot', 686);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (29, 9, 8017, '2020-12-21', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (30, 9, 8497, '2021-02-19', 'eff', 480);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (31, 9, NULL, NULL, 'stim', 220);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (32, 9, NULL, NULL, 'tot', 700);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (33, 10, 8497, '2021-02-19', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (34, 10, 8712, '2021-04-08', 'eff', 215);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (35, 10, NULL, NULL, 'stim', 116);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (36, 10, NULL, NULL, 'tot', 331);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (37, 11, 8712, '2021-04-08', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (38, 11, NULL, NULL, 'stim', 52);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (39, 11, NULL, NULL, 'tot', 52);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (40, 12, 8712, '2021-04-08', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (41, 12, NULL, NULL, 'stim', 65);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (42, 12, NULL, NULL, 'tot', 65);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (43, 13, 8712, '2021-04-08', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (44, 13, NULL, NULL, 'stim', 222);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (45, 13, NULL, NULL, 'tot', 222);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (46, 14, 8712, '2021-04-08', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (47, 14, 9157, '2021-12-17', 'eff', 445);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (48, 14, NULL, NULL, 'stim', 342);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (49, 14, NULL, NULL, 'tot', 787);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (50, 15, 9157, '2021-12-17', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (51, 15, 9626, '2022-02-16', 'eff', 469);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (52, 15, NULL, NULL, 'stim', 241);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (53, 15, NULL, NULL, 'tot', 710);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (54, 16, 9626, '2022-02-16', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (55, 16, 9905, '2022-04-28', 'eff', 279);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (56, 16, NULL, NULL, 'stim', 46);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (57, 16, NULL, NULL, 'tot', 325);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (58, 17, 9905, '2022-04-28', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (59, 17, NULL, NULL, 'stim', 46);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (60, 17, NULL, NULL, 'tot', 46);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (61, 18, 9905, '2022-04-28', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (62, 18, NULL, NULL, 'stim', 58);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (63, 18, NULL, NULL, 'tot', 58);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (64, 19, 9905, '2022-04-28', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (65, 19, 9998, '2022-11-23', 'eff', 93);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (66, 19, NULL, NULL, 'stim', 33);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (67, 19, NULL, NULL, 'tot', 126);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (68, 20, 9998, '2022-11-23', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (69, 20, 10321, '2023-01-26', 'eff', 323);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (70, 20, NULL, NULL, 'stim', 24);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (71, 20, NULL, NULL, 'tot', 347);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (72, 21, 10321, '2023-01-26', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (73, 21, 10551, '2023-03-23', 'auto', 230);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (74, 21, NULL, NULL, 'stim', 29);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (75, 21, NULL, NULL, 'tot', 259);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (76, 22, 10551, '2023-03-23', 'auto', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (77, 22, 10610, '2023-05-03', 'eff', 59);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (78, 22, NULL, NULL, 'stim', 44);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (79, 22, NULL, NULL, 'tot', 103);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (80, 23, 10610, '2023-05-03', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (81, 23, 10638, '2023-07-04', 'eff', 28);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (82, 23, 10644, '2023-07-31', 'auto', 6);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (83, 23, NULL, NULL, 'stim', 28);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (84, 23, NULL, NULL, 'tot', 74);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (85, 24, 39819, '2020-05-20', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (86, 24, NULL, NULL, 'stim', 213);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (87, 24, NULL, NULL, 'tot', 213);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (88, 25, 39819, '2020-05-20', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (89, 25, 40212, '2020-12-15', 'eff', 393);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (90, 25, NULL, NULL, 'stim', 340);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (91, 25, NULL, NULL, 'tot', 733);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (92, 26, 40212, '2020-12-15', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (93, 26, 40781, '2021-02-22', 'eff', 569);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (94, 26, NULL, NULL, 'stim', 190);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (95, 26, NULL, NULL, 'tot', 759);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (96, 27, 40781, '2021-02-22', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (97, 27, 41047, '2021-04-14', 'eff', 266);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (98, 27, NULL, NULL, 'stim', 91);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (99, 27, NULL, NULL, 'tot', 357);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (100, 28, 41047, '2021-04-14', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (101, 28, NULL, NULL, 'stim', 50);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (102, 28, NULL, NULL, 'tot', 50);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (103, 29, 41047, '2021-04-14', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (104, 29, NULL, NULL, 'stim', 63);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (105, 29, NULL, NULL, 'tot', 63);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (106, 30, 41047, '2021-04-14', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (107, 30, NULL, NULL, 'stim', 213);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (108, 30, NULL, NULL, 'tot', 213);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (109, 31, 41047, '2021-04-14', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (110, 31, 41618, '2021-12-13', 'eff', 571);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (111, 31, NULL, NULL, 'stim', 354);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (112, 31, NULL, NULL, 'tot', 925);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (113, 32, 41618, '2021-12-13', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (114, 32, 42274, '2022-02-22', 'eff', 656);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (115, 32, NULL, NULL, 'stim', 190);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (116, 32, NULL, NULL, 'tot', 846);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (117, 33, 42274, '2022-02-22', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (118, 33, 42705, '2022-04-22', 'eff', 431);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (119, 33, NULL, NULL, 'stim', 65);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (120, 33, NULL, NULL, 'tot', 496);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (121, 34, 42705, '2022-04-22', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (122, 34, NULL, NULL, 'stim', 58);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (123, 34, NULL, NULL, 'tot', 58);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (124, 35, 42705, '2022-04-22', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (125, 35, NULL, NULL, 'stim', 72);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (126, 35, NULL, NULL, 'tot', 72);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (127, 36, 42705, '2022-04-22', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (128, 36, 42854, '2022-11-14', 'eff', 149);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (129, 36, NULL, NULL, 'stim', 92);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (130, 36, NULL, NULL, 'tot', 241);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (131, 37, 42854, '2022-11-14', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (132, 37, 43403, '2023-01-31', 'eff', 549);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (133, 37, NULL, NULL, 'tot', 549);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (134, 38, 43403, '2023-01-31', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (135, 38, NULL, NULL, 'stim', 378);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (136, 38, NULL, NULL, 'tot', 378);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (137, 39, 43403, '2023-01-31', 'eff', NULL);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (138, 39, 43885, '2023-05-04', 'eff', 482);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (139, 39, 43899, '2023-05-15', 'auto', 14);
INSERT OR IGNORE INTO 'GASLettura'('idLettura', 'idGASFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (140, 39, NULL, NULL, 'tot', 527);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (1, 1, 1020, '2019-10-04', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (2, 1, NULL, NULL, 'stim', 63);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (3, 1, NULL, NULL, 'tot', 63);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (4, 2, 1020, '2019-10-04', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (5, 2, 1079, '2020-05-28', 'eff', 59);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (6, 2, NULL, NULL, 'stim', 18);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (7, 2, NULL, NULL, 'tot', 77);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (8, 3, 1079, '2020-05-28', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (9, 3, 1136, '2020-08-25', 'eff', 57);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (10, 3, NULL, NULL, 'stim', 17);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (11, 3, NULL, NULL, 'tot', 74);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (12, 4, 1136, '2020-08-25', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (13, 4, 1171, '2020-12-10', 'eff', 35);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (14, 4, NULL, NULL, 'stim', 52);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (15, 4, NULL, NULL, 'tot', 87);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (16, 5, 1171, '2020-12-10', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (17, 5, 1251, '2021-06-22', 'eff', 80);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (18, 5, NULL, NULL, 'stim', 3);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (19, 5, NULL, NULL, 'tot', 83);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (20, 6, 1251, '2021-06-22', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (21, 6, 1283, '2021-09-10', 'eff', 32);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (22, 6, NULL, NULL, 'stim', 21);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (23, 6, NULL, NULL, 'tot', 53);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (24, 7, 1283, '2021-09-10', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (25, 7, 1346, '2022-03-28', 'eff', 63);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (26, 7, 1398, '2022-07-11', 'eff', 52);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (27, 7, NULL, NULL, 'stim', 8);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (28, 7, NULL, NULL, 'tot', 123);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (29, 8, 1398, '2022-07-11', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (30, 8, 1426, '2022-10-10', 'eff', 28);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (31, 8, NULL, NULL, 'stim', 19);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (32, 8, NULL, NULL, 'tot', 47);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (33, 9, 1426, '2022-10-10', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (34, 9, NULL, NULL, 'stim', 36);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (35, 9, NULL, NULL, 'tot', 36);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (36, 10, 1426, '2022-10-10', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (37, 10, NULL, NULL, 'stim', 36);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (38, 10, NULL, NULL, 'tot', 36);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (39, 11, 4856, '2020-08-18', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (40, 11, 4871, '2020-11-30', 'eff', 15);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (41, 11, NULL, NULL, 'stim', 14);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (42, 11, NULL, NULL, 'tot', 29);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (43, 12, 4871, '2020-11-30', 'eff', NULL);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (44, 12, 4894, '2021-04-16', 'eff', 23);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (45, 12, NULL, NULL, 'stim', 3);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (46, 12, NULL, NULL, 'tot', 36);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (47, 13, NULL, NULL, 'stim', 8);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (48, 13, NULL, NULL, 'tot', 23);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (49, 14, NULL, NULL, 'stim', 12);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (50, 14, NULL, NULL, 'tot', 29);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (51, 15, NULL, NULL, 'stim', 4);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (52, 15, NULL, NULL, 'tot', 38);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (53, 16, NULL, NULL, 'stim', 9);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (54, 16, NULL, NULL, 'tot', 29);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (55, 17, NULL, NULL, 'stim', 27);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (56, 17, NULL, NULL, 'tot', 27);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (57, 18, NULL, NULL, 'stim', 5);
INSERT OR IGNORE INTO 'H2OLettura'('idLettura', 'idH2OFattura', 'lettQtaMc', 'LettData', 'TipoLett', 'Consumofatt') VALUES (58, 18, NULL, NULL, 'tot', 43);
INSERT OR IGNORE INTO 'Intesta'('idIntesta', 'NomeIntesta', 'dirfatture') VALUES (1, 'claudio', 'F:\Google Drive\SMichele\AASS');
INSERT OR IGNORE INTO 'Intesta'('idIntesta', 'NomeIntesta', 'dirfatture') VALUES (2, 'andrea', 'F:\varie\AASS\Andrea');
INSERT OR IGNORE INTO 'Intesta'('idIntesta', 'NomeIntesta', 'dirfatture') VALUES (3, 'alessandro', 'F:\varie\AASS\Alessandro');
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (1, NULL, 21, 12.34, '23/07/1957', 12.3, 3.141534);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (2, 'str2', 22, 23.56, '12/11/1957', 23.4, 2.718281828);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (3, 'str3', 23, 45.77, '22/09/1962', 12.33, 0.3443);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (4, 'str4', 24, 33.21, '23/07/1957', 12.3, 12.3445);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (5, 'str5', 25, 25.85, '12/11/1957', 23.4, NULL);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (6, 'str6', 26, 27.54, '22/09/1962', 12.33, 76.214673);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (7, 'str7', 27, 23.22, '23/07/1957', 12.3, NULL);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (8, 'str8', 28, 21.11, '23/07/1957', 12.3, NULL);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (9, 'str9', 29, 22.33, '12/11/1957', 23.4, NULL);
INSERT OR IGNORE INTO 'prova'('chiave', 'stringa', 'intero', 'prezzo', 'dataoggi', 'percento', 'flottante') VALUES (10, 'str10', 30, 22.66, '22/09/1962', 12.33, NULL);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (225, 18, 'S1', '2023-05-01', '2023-05-31', 0, 0.574103, 4, 2.3);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (226, 18, 'TA1', '2023-05-01', '2023-05-31', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (227, 18, 'S1', '2023-06-01', '2023-06-30', 0, 0.574103, 5, 2.87);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (228, 18, 'TA1', '2023-06-01', '2023-06-30', 0, 0.909679, 5, 4.55);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (229, 18, 'S1', '2023-07-01', '2023-07-10', 0, 0.574103, 1, 5.70000000000000062e-01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (230, 18, 'TA1', '2023-07-01', '2023-07-10', 0, 0.909679, 1, 9.0999999999999992e-01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (231, 18, 'S1', '2023-07-11', '2023-07-31', 1, 0.574103, 4, 2.3);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (232, 18, 'S2', '2023-07-11', '2023-07-31', 1, 1.16659, 1, 1.17);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (233, 18, 'TA1', '2023-07-11', '2023-07-31', 1, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (234, 18, 'TA2', '2023-07-11', '2023-07-31', 1, 0.909679, 1, 9.0999999999999992e-01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1, 1, 'S1', '2019-11-01', '2019-12-31', 0, 0.478419, 12, 5.74);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (2, 1, 'S2', '2019-11-01', '2019-12-31', 0, 0.972158, 12, 11.67);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (3, 1, 'S3', '2019-11-01', '2019-12-31', 0, 1.494522, 8, 1.1959999999999999e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (4, 1, 'TA1', '2019-11-01', '2019-12-31', 0, 0.627365, 12, 7.52999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (5, 1, 'TA2', '2019-11-01', '2019-12-31', 0, 0.627365, 12, 7.52999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (6, 1, 'TA3', '2019-11-01', '2019-12-31', 0, 0.627365, 8, 5.02000000000000046e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (7, 1, 'F', '2019-11-01', '2019-12-31', 0, 0.008548, 61, 0.52);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (8, 1, 'S1', '2020-01-01', '2020-02-29', 0, 0.478419, 12, 5.74);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (9, 1, 'S2', '2020-01-01', '2020-02-29', 0, 0.972158, 12, 11.67);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (10, 1, 'S3', '2020-01-01', '2020-02-29', 0, 1.494522, 7, 1.0459999999999999e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (11, 1, 'TA1', '2020-01-01', '2020-02-29', 0, 0.627365, 12, 7.52999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (12, 1, 'TA2', '2020-01-01', '2020-02-29', 0, 0.627365, 12, 7.52999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (13, 1, 'TA3', '2020-01-01', '2020-02-29', 0, 0.627365, 7, 4.39);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (14, 1, 'F', '2020-01-01', '2020-02-29', 0, 0.008525, 60, 0.51);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (15, 2, 'S1', '2019-10-05', '2019-12-31', 0, 0.478419, 17, 8.129999999999999e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (16, 2, 'S2', '2019-10-05', '2019-12-31', 0, 0.972158, 5, 4.86);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (17, 2, 'TA1', '2019-10-05', '2019-12-31', 0, 0.627365, 17, 10.67);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (18, 2, 'TA2', '2019-10-05', '2019-12-31', 0, 0.627365, 5, 3.13999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (19, 2, 'S1', '2020-01-01', '2020-05-28', 0, 0.478419, 29, 13.87);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (20, 2, 'S2', '2020-01-01', '2020-05-28', 0, 0.972158, 8, 7.77999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (21, 2, 'TA1', '2020-01-01', '2020-05-28', 0, 0.627365, 29, 18.19);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (22, 2, 'TA2', '2020-01-01', '2020-05-28', 0, 0.627365, 8, 5.02000000000000046e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (23, 2, 'F', '2020-03-01', '2020-06-30', 0, 0.008525, 122, 1.04);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (24, 2, 'S1', '2020-05-29', '2020-06-30', 0, 0.478419, 6, 2.87);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (25, 2, 'S2', '2020-05-29', '2020-06-30', 0, 0.972158, 6, 5.83);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (26, 2, 'S3', '2020-05-29', '2020-06-30', 0, 1.494522, 6, 8.97);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (27, 2, 'TA1', '2020-05-29', '2020-06-30', 0, 0.627365, 6, 3.76000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (28, 2, 'TA2', '2020-05-29', '2020-06-30', 0, 0.627365, 6, 3.76000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (29, 2, 'TA3', '2020-05-29', '2020-06-30', 0, 0.627365, 6, 3.76000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (30, 3, 'S1', '2020-05-29', '2020-08-25', 0, 0.478419, 18, 8.61);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (31, 3, 'S2', '2020-05-29', '2020-08-25', 0, 0.972158, 18, 17.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (32, 3, 'S3', '2020-05-29', '2020-08-25', 0, 1.494522, 18, 26.9);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (33, 3, 'S4', '2020-05-29', '2020-08-25', 0, 2.171288, 3, 6.51);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (34, 3, 'TA1', '2020-05-29', '2020-08-25', 0, 0.627365, 18, 1.12900000000000009e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (35, 3, 'TA2', '2020-05-29', '2020-08-25', 0, 0.627365, 18, 1.12900000000000009e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (36, 3, 'TA3', '2020-05-29', '2020-08-25', 0, 0.627365, 18, 1.12900000000000009e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (37, 3, 'TA4', '2020-05-29', '2020-08-25', 0, 0.627365, 3, 1.88000000000000011e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (38, 3, 'F', '2020-07-01', '2020-10-31', 0, 0.008525, 123, 1.05);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (39, 3, 'S1', '2020-08-26', '2020-10-31', 0, 0.478419, 13, 6.22000000000000064e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (40, 3, 'S2', '2020-08-26', '2020-10-31', 0, 0.972158, 4, 3.88999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (41, 3, 'TA1', '2020-08-26', '2020-10-31', 0, 0.627365, 13, 8.16);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (42, 3, 'TA2', '2020-08-26', '2020-10-31', 0, 0.627365, 4, 2.51000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (43, 4, 'S1', '2020-08-26', '2020-12-10', 0, 0.478419, 21, 10.05);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (44, 4, 'S2', '2020-08-26', '2020-12-10', 0, 0.972158, 14, 13.61);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (45, 4, 'TA1', '2020-08-26', '2020-12-10', 0, 0.627365, 21, 1.31699999999999981e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (46, 4, 'TA2', '2020-08-26', '2020-12-10', 0, 0.627365, 14, 8.78);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (47, 4, 'F', '2020-11-01', '2020-12-31', 0, 0.008525, 61, 0.52);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (48, 4, 'S1', '2020-12-11', '2020-12-31', 0, 0.478419, 4, 1.91000000000000014e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (49, 4, 'S2', '2020-12-11', '2020-12-31', 0, 0.972158, 4, 3.88999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (50, 4, 'S3', '2020-12-11', '2020-12-31', 0, 1.494522, 4, 5.97999999999999953e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (51, 4, 'S4', '2020-12-11', '2020-12-31', 0, 2.171288, 2, 4.34);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (52, 4, 'TA1', '2020-12-11', '2020-12-31', 0, 0.627365, 4, 2.51000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (53, 4, 'TA2', '2020-12-11', '2020-12-31', 0, 0.627365, 4, 2.51000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (54, 4, 'TA3', '2020-12-11', '2020-12-31', 0, 0.627365, 4, 2.51000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (55, 4, 'TA4', '2020-12-11', '2020-12-31', 0, 0.627365, 2, 1.25);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (56, 4, 'S1', '2021-01-01', '2021-02-28', 0, 0.478419, 12, 5.74);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (57, 4, 'S2', '2021-01-01', '2021-02-28', 0, 0.972158, 12, 11.67);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (58, 4, 'S3', '2021-01-01', '2021-02-28', 0, 1.494522, 12, 17.93);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (59, 4, 'S4', '2021-01-01', '2021-02-28', 0, 2.171288, 2, 4.34);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (60, 4, 'TA1', '2021-01-01', '2021-02-28', 0, 0.627365, 12, 7.52999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (61, 4, 'TA2', '2021-01-01', '2021-02-28', 0, 0.627365, 12, 7.52999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (62, 4, 'TA3', '2021-01-01', '2021-02-28', 0, 0.627365, 12, 7.52999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (63, 4, 'TA4', '2021-01-01', '2021-02-28', 0, 0.627365, 2, 1.25);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (64, 4, 'F', '2021-01-01', '2021-02-28', 0, 0.008548, 59, 0.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (65, 5, 'S1', '2020-12-11', '2020-12-31', 0, 0.478419, 4, 1.91000000000000014e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (66, 5, 'S2', '2020-12-11', '2020-12-31', 0, 0.972158, 4, 3.88999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (67, 5, 'S3', '2020-12-11', '2020-12-31', 0, 1.494522, 1, 1.49);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (68, 5, 'TA1', '2020-12-11', '2020-12-31', 0, 0.627365, 4, 2.51000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (69, 5, 'TA2', '2020-12-11', '2020-12-31', 0, 0.627365, 4, 2.51000000000000023e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (70, 5, 'TA3', '2020-12-11', '2020-12-31', 0, 0.627365, 1, 0.63);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (71, 5, 'S1', '2021-01-01', '2021-06-22', 0, 0.478419, 34, 16.27);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (72, 5, 'S2', '2021-01-01', '2021-06-22', 0, 0.972158, 34, 33.05);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (73, 5, 'S3', '2021-01-01', '2021-06-22', 0, 1.494522, 3, 4.47999999999999953e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (74, 5, 'TA1', '2021-01-01', '2021-06-22', 0, 0.627365, 34, 2.13300000000000018e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (75, 5, 'TA2', '2021-01-01', '2021-06-22', 0, 0.627365, 34, 2.13300000000000018e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (76, 5, 'TA3', '2021-01-01', '2021-06-22', 0, 0.627365, 3, 1.88000000000000011e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (77, 5, 'F', '2021-03-01', '2021-06-30', 0, 0.008548, 122, 1.04);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (78, 5, 'S1', '2021-06-23', '2021-06-30', 0, 0.478419, 2, 0.96);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (79, 5, 'S2', '2021-06-23', '2021-06-30', 0, 0.972158, 1, 0.97);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (80, 5, 'TA1', '2021-06-23', '2021-06-30', 0, 0.627365, 2, 1.25);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (81, 5, 'TA2', '2021-06-23', '2021-06-30', 0, 0.627365, 1, 0.63);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (82, 6, 'S1', '2021-06-23', '2021-09-10', 0, 0.478419, 16, 7.65);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (83, 6, 'S2', '2021-06-23', '2021-09-10', 0, 0.972158, 16, 15.55);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (84, 6, 'TA1', '2021-06-23', '2021-09-10', 0, 0.627365, 16, 1.00400000000000009e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (85, 6, 'TA2', '2021-06-23', '2021-09-10', 0, 0.627365, 16, 1.00400000000000009e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (86, 6, 'F', '2021-07-01', '2021-10-31', 0, 0.008548, 123, 1.05);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (87, 6, 'S1', '2021-09-11', '2021-10-31', 0, 0.478419, 10, 4.77999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (88, 6, 'S2', '2021-09-11', '2021-10-31', 0, 0.972158, 10, 9.72);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (89, 6, 'S3', '2021-09-11', '2021-10-31', 0, 1.494522, 1, 1.49);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (90, 6, 'TA1', '2021-09-11', '2021-10-31', 0, 0.627365, 10, 6.27000000000000046e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (91, 6, 'TA2', '2021-09-11', '2021-10-31', 0, 0.627365, 10, 6.27000000000000046e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (92, 6, 'TA3', '2021-09-11', '2021-10-31', 0, 0.627365, 1, 0.63);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (93, 7, 'S1', '2021-09-11', '2021-12-31', 0, 0.478419, 22, 10.53);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (94, 7, 'S2', '2021-09-11', '2021-12-31', 0, 0.972158, 13, 12.64);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (95, 7, 'TA1', '2021-09-11', '2021-12-31', 0, 0.627365, 22, 13.8);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (96, 7, 'TA2', '2021-09-11', '2021-12-31', 0, 0.627365, 13, 8.16);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (97, 7, 'S1', '2022-01-01', '2022-03-28', 0, 0.478419, 17, 8.129999999999999e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (98, 7, 'S2', '2022-01-01', '2022-03-28', 0, 0.972158, 11, 1.06900000000000012e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (99, 7, 'TA1', '2022-01-01', '2022-03-28', 0, 0.627365, 17, 10.67);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (100, 7, 'TA2', '2022-01-01', '2022-03-28', 0, 0.627365, 11, 6.9);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (101, 7, 'F', '2022-03-01', '2022-03-31', 0, 0.008548, 31, 0.26);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (102, 7, 'S1', '2022-03-29', '2022-03-31', 0, 0.478419, 1, 0.48);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (103, 7, 'TA1', '2022-03-29', '2022-03-31', 0, 0.627365, 1, 0.63);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (104, 7, 'S1', '2022-04-01', '2022-07-11', 0, 0.526261, 20, 10.53);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (105, 7, 'S2', '2022-04-01', '2022-07-11', 0, 1.069374, 20, 21.39);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (106, 7, 'S3', '2022-04-01', '2022-07-11', 0, 1.643974, 11, 1.80800000000000018e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (107, 7, 'TA1', '2022-04-01', '2022-07-11', 0, 0.909679, 20, 18.19);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (108, 7, 'TA2', '2022-04-01', '2022-07-11', 0, 0.909679, 20, 18.19);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (109, 7, 'TA3', '2022-04-01', '2022-07-11', 0, 0.909679, 11, 10.01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (110, 7, 'F', '2022-04-01', '2022-07-31', 0, 0.011096, 122, 1.35);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (111, 7, 'S1', '2022-07-12', '2022-07-31', 0, 0.526261, 4, 2.11000000000000031e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (112, 7, 'S2', '2022-07-12', '2022-07-31', 0, 1.069374, 4, 4.27999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (113, 7, 'TA1', '2022-07-12', '2022-07-31', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (114, 7, 'TA2', '2022-07-12', '2022-07-31', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (115, 8, 'S1', '2022-07-12', '2022-10-10', 0, 0.526261, 18, 9.47);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (116, 8, 'S2', '2022-07-12', '2022-10-10', 0, 1.069374, 10, 1.06900000000000012e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (117, 8, 'TA1', '2022-07-12', '2022-10-10', 0, 0.909679, 18, 1.63699999999999974e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (118, 8, 'TA2', '2022-07-12', '2022-10-10', 0, 0.909679, 10, 9.1);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (119, 8, 'F', '2022-08-01', '2022-11-30', 0, 0.011096, 122, 1.35);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (120, 8, 'S1', '2022-10-11', '2022-11-30', 1, 0.526261, 10, 5.26);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (121, 8, 'S2', '2022-10-11', '2022-11-30', 1, 1.069374, 9, 9.62000000000000099e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (122, 8, 'TA1', '2022-10-11', '2022-11-30', 1, 0.909679, 10, 9.1);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (123, 8, 'TA2', '2022-10-11', '2022-11-30', 1, 0.909679, 9, 8.19000000000000127e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (124, 9, 'F', '2022-12-01', '2022-12-31', 0, 0.011096, 31, 3.39999999999999968e-01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (125, 9, 'F', '2023-01-01', '2023-03-31', 0, 0.011096, 90, 1);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (126, 9, 'S1', '2022-12-01', '2022-12-31', 1, 0.526261, 6, 3.16);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (127, 9, 'S2', '2022-12-01', '2022-12-31', 1, 1.069374, 3, 3.21);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (128, 9, 'TA1', '2022-12-01', '2022-12-31', 1, 0.909679, 6, 5.46);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (129, 9, 'TA2', '2022-12-01', '2022-12-31', 1, 0.909679, 3, 2.73);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (130, 9, 'S1', '2023-01-01', '2023-03-31', 1, 0.574103, 18, 10.33);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (131, 9, 'S2', '2023-01-01', '2023-03-31', 1, 1.16659, 9, 10.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (132, 9, 'TA1', '2023-01-01', '2023-03-31', 1, 0.909679, 18, 1.63699999999999974e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (133, 9, 'TA2', '2023-01-01', '2023-03-31', 1, 0.909679, 9, 8.19000000000000127e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (134, 10, 'F', '2023-04-01', '2023-07-31', 0, 0.011096, 122, 1.35);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (135, 10, 'S1', '2023-04-01', '2023-04-30', 1, 0.574103, 6, 3.44);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (136, 10, 'S2', '2023-04-01', '2023-04-30', 1, 1.16659, 3, 3.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (137, 10, 'TA1', '2023-04-01', '2023-04-30', 1, 0.909679, 6, 5.46);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (138, 10, 'TA2', '2023-04-01', '2023-04-30', 1, 0.909679, 3, 2.73);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (139, 10, 'S1', '2023-05-01', '2023-05-31', 1, 0.574103, 6, 3.44);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (140, 10, 'S2', '2023-05-01', '2023-05-31', 1, 1.16659, 3, 3.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (141, 10, 'TA1', '2023-05-01', '2023-05-31', 1, 0.909679, 6, 5.46);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (142, 10, 'TA2', '2023-05-01', '2023-05-31', 1, 0.909679, 3, 2.73);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (143, 10, 'S1', '2023-06-01', '2023-06-30', 1, 0.574103, 6, 3.44);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (144, 10, 'S2', '2023-06-01', '2023-06-30', 1, 1.16659, 3, 3.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (145, 10, 'TA1', '2023-06-01', '2023-06-30', 1, 0.909679, 6, 5.46);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (146, 10, 'TA2', '2023-06-01', '2023-06-30', 1, 0.909679, 3, 2.73);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (147, 10, 'S1', '2023-07-01', '2023-07-31', 1, 0.574103, 6, 3.44);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (148, 10, 'S2', '2023-07-01', '2023-07-31', 1, 1.16659, 3, 3.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (149, 10, 'TA1', '2023-07-01', '2023-07-31', 1, 0.909679, 6, 5.46);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (150, 10, 'TA2', '2023-07-01', '2023-07-31', 1, 0.909679, 3, 2.73);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (151, 11, 'S1', '2020-08-19', '2020-11-30', 0, 0.478419, 15, 7.18);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (152, 11, 'TA1', '2020-08-19', '2020-11-30', 0, 0.627365, 15, 9.41);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (153, 11, 'F', '2020-11-01', '2020-12-31', 0, 0.008525, 61, 0.52);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (154, 11, 'S1', '2020-12-01', '2020-12-31', 0, 0.478419, 5, 2.38999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (155, 11, 'TA1', '2020-12-01', '2020-12-31', 0, 0.627365, 5, 3.13999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (156, 11, 'S1', '2021-01-01', '2021-02-28', 0, 0.478419, 9, 4.31000000000000049e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (157, 11, 'TA1', '2021-01-01', '2021-02-28', 0, 0.627365, 9, 5.65);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (158, 11, 'F', '2021-01-01', '2021-02-28', 0, 0.008548, 59, 0.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (159, 12, 'S1', '2020-12-01', '2020-12-31', 0, 0.478419, 5, 2.38999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (160, 12, 'TA1', '2020-12-01', '2020-12-31', 0, 0.627365, 5, 3.13999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (161, 12, 'S1', '2021-01-01', '2021-04-16', 0, 0.478419, 18, 8.61);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (162, 12, 'TA1', '2021-01-01', '2021-04-16', 0, 0.627365, 18, 1.12900000000000009e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (163, 12, 'F', '2021-03-01', '2021-06-30', 0, 0.008548, 122, 1.04);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (164, 12, 'S1', '2021-04-17', '2021-06-11', 0, 0.478419, 10, 4.77999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (165, 12, 'TA1', '2021-04-17', '2021-06-11', 0, 0.627365, 10, 6.27000000000000046e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (166, 12, 'S1', '2021-06-12', '2021-06-30', 0, 0.478419, 3, 1.44);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (167, 12, 'TA1', '2021-06-12', '2021-06-30', 0, 0.627365, 3, 1.88000000000000011e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (168, 13, 'S1', '2021-06-12', '2021-09-10', 0, 0.478419, 15, 7.18);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (169, 13, 'TA1', '2021-06-12', '2021-09-10', 0, 0.627365, 15, 9.41);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (170, 13, 'F', '2021-07-01', '2021-10-31', 0, 0.008548, 123, 1.05);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (171, 13, 'S1', '2021-09-11', '2021-10-31', 0, 0.478419, 8, 3.82999999999999962e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (172, 13, 'TA1', '2021-09-11', '2021-10-31', 0, 0.627365, 8, 5.02000000000000046e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (173, 14, 'S1', '2021-09-11', '2021-12-21', 0, 0.478419, 17, 8.129999999999999e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (174, 14, 'TA1', '2021-09-11', '2021-12-21', 0, 0.627365, 17, 10.67);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (175, 14, 'F', '2021-11-01', '2021-12-31', 0, 0.008548, 61, 0.52);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (176, 14, 'S1', '2021-12-22', '2021-12-31', 0, 0.478419, 2, 0.96);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (177, 14, 'TA1', '2021-12-22', '2021-12-31', 0, 0.627365, 2, 1.25);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (178, 14, 'S1', '2022-01-01', '2022-02-28', 0, 0.478419, 10, 4.77999999999999936e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (179, 14, 'TA1', '2022-01-01', '2022-02-28', 0, 0.627365, 10, 6.27000000000000046e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (180, 14, 'F', '2022-01-01', '2022-02-28', 0, 0.008548, 59, 0.5);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (181, 15, 'S1', '2021-12-22', '2021-12-31', 0, 0.478419, 2, 0.96);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (182, 15, 'TA1', '2021-12-22', '2021-12-31', 0, 0.627365, 2, 1.25);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (183, 15, 'S1', '2022-01-01', '2022-03-31', 0, 0.478419, 16, 7.65);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (184, 15, 'TA1', '2022-01-01', '2022-03-31', 0, 0.627365, 16, 1.00400000000000009e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (185, 15, 'F', '2022-03-01', '2022-03-31', 0, 0.008548, 31, 0.26);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (186, 15, 'S1', '2022-04-01', '2022-04-19', 0, 0.526261, 3, 1.58);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (187, 15, 'TA1', '2022-04-01', '2022-04-19', 0, 0.909679, 3, 2.73);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (188, 15, 'F', '2022-04-01', '2022-07-31', 0, 0.011096, 122, 1.35);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (189, 15, 'S1', '2022-04-20', '2022-07-05', 0, 0.526261, 13, 6.84000000000000074e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (190, 15, 'TA1', '2022-04-20', '2022-07-05', 0, 0.909679, 13, 11.83);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (191, 15, 'S1', '2022-07-06', '2022-07-31', 0, 0.526261, 4, 2.11000000000000031e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (192, 15, 'TA1', '2022-07-06', '2022-07-31', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (193, 16, 'S1', '2022-07-06', '2022-10-05', 0, 0.526261, 18, 9.47);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (194, 16, 'S2', '2022-07-06', '2022-10-05', 0, 1.069374, 2, 2.13999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (195, 16, 'TA1', '2022-07-06', '2022-10-05', 0, 0.909679, 18, 1.63699999999999974e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (196, 16, 'TA2', '2022-07-06', '2022-10-05', 0, 0.909679, 2, 1.81999999999999984e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (197, 16, 'F', '2022-08-01', '2022-11-30', 0, 0.011096, 122, 1.35);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (198, 16, 'S1', '2022-10-06', '2022-11-30', 1, 0.526261, 9, 4.74);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (199, 16, 'TA1', '2022-10-06', '2022-11-30', 1, 0.909679, 9, 8.19000000000000127e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (200, 17, 'F', '2022-12-01', '2022-12-31', 0, 0.011096, 31, 3.39999999999999968e-01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (201, 17, 'F', '2023-01-01', '2023-03-31', 0, 0.011096, 90, 1);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (202, 17, 'S1', '2022-12-01', '2022-12-31', 1, 0.526261, 6, 3.16);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (203, 17, 'S2', '2022-12-01', '2022-12-31', 1, 1.069374, 1, 1.06999999999999984e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (204, 17, 'TA1', '2022-12-01', '2022-12-31', 1, 0.909679, 6, 5.46);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (205, 17, 'TA2', '2022-12-01', '2022-12-31', 1, 0.909679, 1, 9.0999999999999992e-01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (206, 17, 'S1', '2023-01-01', '2023-03-31', 1, 0.574103, 18, 10.33);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (207, 17, 'S2', '2023-01-01', '2023-03-31', 1, 1.16659, 2, 2.33);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (208, 17, 'TA1', '2023-01-01', '2023-03-31', 1, 0.909679, 18, 1.63699999999999974e+01);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (209, 17, 'TA2', '2023-01-01', '2023-03-31', 1, 0.909679, 2, 1.81999999999999984e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (210, 18, 'S1', '2022-10-06', '2022-10-31', 0, 0.526261, 4, 2.11000000000000031e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (211, 18, 'TA1', '2022-10-06', '2022-10-31', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (212, 18, 'S1', '2022-11-01', '2022-11-30', 0, 0.526261, 4, 2.11000000000000031e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (213, 18, 'TA1', '2022-11-01', '2022-11-30', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (214, 18, 'S1', '2022-12-01', '2022-12-31', 0, 0.526261, 4, 2.11000000000000031e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (215, 18, 'TA1', '2022-12-01', '2022-12-31', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (216, 18, 'S1', '2023-01-01', '2023-01-31', 0, 0.574103, 4, 2.3);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (217, 18, 'TA1', '2023-01-01', '2023-01-31', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (218, 18, 'S1', '2023-02-01', '2023-02-28', 0, 0.574103, 4, 2.3);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (219, 18, 'TA1', '2023-02-01', '2023-02-28', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (220, 18, 'S1', '2023-03-01', '2023-03-31', 0, 0.574103, 4, 2.3);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (221, 18, 'TA1', '2023-03-01', '2023-03-31', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (222, 18, 'S1', '2023-04-01', '2023-04-30', 0, 0.574103, 4, 2.3);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (223, 18, 'TA1', '2023-04-01', '2023-04-30', 0, 0.909679, 4, 3.63999999999999968e+00);
INSERT OR IGNORE INTO 'H2OConsumo'('idConsumo', 'idH2OFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (224, 18, 'F', '2023-04-01', '2023-07-31', 0, 0.011096, 122, 1.35);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (151, 31, 'G2', '2021-12-14', '2021-12-31', 0, 0.479373, 44, 21.09);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (152, 31, 'G3', '2021-12-14', '2021-12-31', 0, 0.488772, 60, 2.93300000000000018e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (153, 31, 'G1', '2022-01-01', '2022-01-31', 0, 0.611085, 43, 26.28);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (154, 31, 'G2', '2022-01-01', '2022-01-31', 0, 0.623185, 76, 47.36);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (155, 31, 'G3', '2022-01-01', '2022-01-31', 0, 0.635404, 106, 67.35);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (156, 32, 'G1', '2021-12-14', '2021-12-31', 0, 0.470065, 25, 11.75);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (157, 32, 'G2', '2021-12-14', '2021-12-31', 0, 0.479373, 44, 21.09);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (158, 32, 'G3', '2021-12-14', '2021-12-31', 0, 0.488772, 97, 4.74100000000000036e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (159, 32, 'G1', '2022-01-01', '2022-02-22', 0, 0.611085, 74, 45.22);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (160, 32, 'G2', '2022-01-01', '2022-02-22', 0, 0.623185, 129, 80.39);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (161, 32, 'G3', '2022-01-01', '2022-02-22', 0, 0.635404, 287, 1.82359999999999985e+02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (162, 32, 'G1', '2022-02-23', '2022-03-31', 0, 0.611085, 52, 31.78);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (163, 32, 'G2', '2022-02-23', '2022-03-31', 0, 0.623185, 90, 5.60899999999999963e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (164, 32, 'G3', '2022-02-23', '2022-03-31', 0, 0.635404, 48, 30.5);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (165, 33, 'G1', '2022-02-23', '2022-04-22', 0, 0.611085, 82, 50.11);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (166, 33, 'G2', '2022-02-23', '2022-04-22', 0, 0.623185, 144, 89.74);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (167, 33, 'G3', '2022-02-23', '2022-04-22', 0, 0.635404, 205, 130.26);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (168, 33, 'G1', '2022-04-23', '2022-05-31', 0, 0.611085, 54, 33);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (169, 33, 'G2', '2022-04-23', '2022-05-31', 0, 0.623185, 11, 6.85999999999999943e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (170, 34, 'G1', '2022-06-01', '2022-06-30', 0, 0.611085, 29, 17.72);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (171, 34, 'G1', '2022-07-01', '2022-07-31', 0, 0.79441, 29, 23.04);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (172, 35, 'G1', '2022-08-01', '2022-09-30', 0, 0.79441, 72, 57.2);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (173, 36, 'G1', '2022-04-23', '2022-06-30', 0, 0.611085, 50, 30.55);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (174, 36, 'G1', '2022-07-01', '2022-11-14', 0, 0.79441, 99, 78.65);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (175, 36, 'G1', '2022-11-15', '2022-11-30', 1, 0.79441, 22, 17.48);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (176, 36, 'G2', '2022-11-15', '2022-11-30', 1, 0.81014, 39, 31.6);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (177, 36, 'G3', '2022-11-15', '2022-11-30', 1, 0.826025, 31, 2.56100000000000029e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (178, 37, 'G1', '2022-11-15', '2022-12-31', 0, 0.79441, 66, 5.24299999999999926e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (179, 37, 'G2', '2022-11-15', '2022-12-31', 0, 0.81014, 115, 93.17);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (180, 37, 'G3', '2022-11-15', '2022-12-31', 0, 0.826025, 150, 123.9);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (181, 37, 'G1', '2023-01-01', '2023-01-31', 0, 0.79441, 43, 3.41600000000000036e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (182, 37, 'G2', '2023-01-01', '2023-01-31', 0, 0.81014, 76, 6.15700000000000073e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (183, 37, 'G3', '2023-01-01', '2023-01-31', 0, 0.826025, 99, 81.78);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (184, 38, 'G1', '2023-02-01', '2023-03-31', 1, 0.79441, 82, 65.14);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (185, 38, 'G2', '2023-02-01', '2023-03-31', 1, 0.81014, 144, 116.66);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (186, 38, 'G3', '2023-02-01', '2023-03-31', 1, 0.826025, 152, 1.25559999999999988e+02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (187, 39, 'G1', '2023-02-01', '2023-02-28', 0, 0.79441, 39, 30.98);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (188, 39, 'G2', '2023-02-01', '2023-02-28', 0, 0.81014, 68, 5.50899999999999963e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (189, 39, 'G3', '2023-02-01', '2023-02-28', 0, 0.826025, 38, 3.1389999999999997e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (190, 39, 'G1', '2023-03-01', '2023-03-31', 0, 0.79441, 43, 3.41600000000000036e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (191, 39, 'G2', '2023-03-01', '2023-03-31', 0, 0.81014, 76, 6.15700000000000073e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (192, 39, 'G3', '2023-03-01', '2023-03-31', 0, 0.826025, 42, 34.69);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (193, 39, 'G1', '2023-04-01', '2023-04-30', 0, 0.479694, 42, 20.15);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (194, 39, 'G2', '2023-04-01', '2023-04-30', 0, 0.479694, 73, 3.5019999999999996e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (195, 39, 'G3', '2023-04-01', '2023-04-30', 0, 0.479694, 40, 19.19);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (196, 39, 'S1', '2023-04-01', '2023-04-30', 0, 0.186125, 42, 7.82);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (197, 39, 'S2', '2023-04-01', '2023-04-30', 0, 0.248166, 73, 1.81199999999999974e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (198, 39, 'S3', '2023-04-01', '2023-04-30', 0, 0.37225, 40, 14.89);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (199, 39, 'G1', '2023-05-01', '2023-05-04', 0, 0.364547, 6, 2.19);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (200, 39, 'G2', '2023-05-01', '2023-05-04', 0, 0.364547, 10, 3.65);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (201, 39, 'G3', '2023-05-01', '2023-05-04', 0, 0.364547, 5, 1.81999999999999984e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (202, 39, 'S1', '2023-05-01', '2023-05-04', 0, 0.186125, 6, 1.11999999999999988e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (203, 39, 'S2', '2023-05-01', '2023-05-04', 0, 0.248166, 10, 2.48);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (204, 39, 'S3', '2023-05-01', '2023-05-04', 0, 0.37225, 5, 1.86);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (205, 39, 'G1', '2023-05-05', '2023-05-15', 0, 0.364547, 14, 5.1);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (206, 39, 'S1', '2023-05-05', '2023-05-15', 0, 0.186125, 14, 2.61000000000000031e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (207, 39, 'G1', '2023-05-16', '2023-05-31', 0, 0.364547, 11, 4.01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (208, 39, 'S1', '2023-05-16', '2023-05-31', 0, 0.186125, 11, 2.05);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (209, 39, 'G1', '2023-06-01', '2023-06-30', 0, 0.354598, 20, 7.09000000000000074e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (210, 39, 'S1', '2023-06-01', '2023-06-30', 0, 0.186125, 20, 3.72);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1, 1, 'G1', '2019-10-01', '2019-11-30', 0, 0.470065, 85, 39.96);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (2, 1, 'G2', '2019-10-01', '2019-11-30', 0, 0.479373, 137, 65.67);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (3, 2, 'G1', '2019-05-23', '2019-12-18', 0, 0.470065, 293, 137.73);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (4, 2, 'G2', '2019-05-23', '2019-12-18', 0, 0.479373, 14, 6.70999999999999907e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (5, 2, 'G1', '2019-12-19', '2019-12-31', 0, 0.470065, 18, 8.45999999999999907e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (6, 2, 'G2', '2019-12-19', '2019-12-31', 0, 0.479373, 32, 15.34);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (7, 2, 'G3', '2019-12-19', '2019-12-31', 0, 0.488772, 49, 23.95);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (8, 2, 'G1', '2020-01-01', '2020-01-31', 0, 0.470065, 43, 20.21);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (9, 2, 'G2', '2020-01-01', '2020-01-31', 0, 0.479373, 75, 35.95);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (10, 2, 'G3', '2020-01-01', '2020-01-31', 0, 0.488772, 117, 57.19);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (11, 3, 'G1', '2019-12-19', '2019-12-31', 0, 0.470065, 18, 8.45999999999999907e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (12, 3, 'G2', '2019-12-19', '2019-12-31', 0, 0.479373, 32, 15.34);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (13, 3, 'G3', '2019-12-19', '2019-12-31', 0, 0.488772, 35, 17.11);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (14, 3, 'G1', '2020-01-01', '2020-02-24', 0, 0.470065, 77, 36.2);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (15, 3, 'G2', '2020-01-01', '2020-02-24', 0, 0.479373, 134, 64.24);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (16, 3, 'G3', '2020-01-01', '2020-02-24', 0, 0.488772, 151, 73.8);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (17, 3, 'G1', '2020-02-25', '2020-03-31', 0, 0.470065, 50, 23.5);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (18, 3, 'G2', '2020-02-25', '2020-03-31', 0, 0.479373, 88, 42.18);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (19, 3, 'G3', '2020-02-25', '2020-03-31', 0, 0.488772, 53, 25.9);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (20, 4, 'G1', '2020-02-25', '2020-05-21', 0, 0.470065, 121, 5.68799999999999954e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (21, 4, 'G2', '2020-02-25', '2020-05-21', 0, 0.479373, 138, 66.15);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (22, 4, 'G1', '2020-05-22', '2020-05-31', 0, 0.470065, 13, 6.11);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (23, 5, 'G1', '2020-06-01', '2020-07-31', 0, 0.470065, 52, 24.44);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (24, 6, 'G1', '2020-08-01', '2020-09-30', 0, 0.470065, 65, 30.55);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (25, 7, 'G1', '2020-10-01', '2020-11-30', 0, 0.470065, 85, 39.96);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (26, 7, 'G2', '2020-10-01', '2020-11-30', 0, 0.479373, 137, 65.67);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (27, 8, 'G1', '2020-05-22', '2020-12-21', 0, 0.470065, 298, 1.40079999999999984e+02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (28, 8, 'G2', '2020-05-22', '2020-12-21', 0, 0.479373, 77, 3.69100000000000036e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (29, 8, 'G1', '2020-12-22', '2020-12-31', 0, 0.470065, 14, 6.58);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (30, 8, 'G2', '2020-12-22', '2020-12-31', 0, 0.479373, 24, 11.5);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (31, 8, 'G3', '2020-12-22', '2020-12-31', 0, 0.488772, 38, 18.57);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (32, 8, 'G1', '2021-01-01', '2021-01-31', 0, 0.470065, 43, 20.21);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (33, 8, 'G2', '2021-01-01', '2021-01-31', 0, 0.479373, 76, 36.43);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (34, 8, 'G3', '2021-01-01', '2021-01-31', 0, 0.488772, 116, 56.7);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (35, 9, 'G1', '2020-12-22', '2020-12-31', 0, 0.470065, 14, 6.58);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (36, 9, 'G2', '2020-12-22', '2020-12-31', 0, 0.479373, 24, 11.5);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (37, 9, 'G3', '2020-12-22', '2020-12-31', 0, 0.488772, 42, 20.53);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (38, 9, 'G1', '2021-01-01', '2021-02-19', 0, 0.470065, 70, 32.9);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (39, 9, 'G2', '2021-01-01', '2021-02-19', 0, 0.479373, 122, 58.48);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (40, 9, 'G3', '2021-01-01', '2021-02-19', 0, 0.488772, 208, 101.66);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (41, 9, 'G1', '2021-02-20', '2021-03-31', 0, 0.470065, 56, 26.32);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (42, 9, 'G2', '2021-02-20', '2021-03-31', 0, 0.479373, 98, 4.69800000000000039e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (43, 9, 'G3', '2021-02-20', '2021-03-31', 0, 0.488772, 66, 3.22600000000000051e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (44, 10, 'G1', '2021-02-20', '2021-04-08', 0, 0.470065, 67, 31.49);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (45, 10, 'G2', '2021-02-20', '2021-04-08', 0, 0.479373, 117, 5.60899999999999963e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (46, 10, 'G3', '2021-02-20', '2021-04-08', 0, 0.488772, 31, 15.15);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (47, 10, 'G1', '2021-04-09', '2021-05-31', 0, 0.470065, 74, 34.78);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (48, 10, 'G2', '2021-04-09', '2021-05-31', 0, 0.479373, 42, 2.01300000000000025e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (49, 11, 'G1', '2021-06-01', '2021-07-31', 0, 0.470065, 52, 24.44);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (50, 12, 'G1', '2021-08-01', '2021-09-30', 0, 0.470065, 65, 30.55);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (51, 13, 'G1', '2021-10-01', '2021-11-30', 0, 0.470065, 85, 39.96);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (52, 13, 'G2', '2021-10-01', '2021-11-30', 0, 0.479373, 137, 65.67);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (53, 14, 'G1', '2021-04-09', '2021-12-17', 0, 0.470065, 354, 166.4);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (54, 14, 'G2', '2021-04-09', '2021-12-17', 0, 0.479373, 91, 43.62);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (55, 14, 'G1', '2021-12-18', '2021-12-31', 0, 0.470065, 20, 9.4);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (56, 14, 'G2', '2021-12-18', '2021-12-31', 0, 0.479373, 34, 16.3);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (57, 14, 'G3', '2021-12-18', '2021-12-31', 0, 0.488772, 53, 25.9);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (58, 14, 'G1', '2022-01-01', '2022-01-31', 0, 0.611085, 43, 26.28);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (59, 14, 'G2', '2022-01-01', '2022-01-31', 0, 0.623185, 76, 47.36);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (60, 14, 'G3', '2022-01-01', '2022-01-31', 0, 0.635404, 116, 7.37100000000000079e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (61, 15, 'G1', '2021-12-18', '2021-12-31', 0, 0.470065, 20, 9.4);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (62, 15, 'G2', '2021-12-18', '2021-12-31', 0, 0.479373, 34, 16.3);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (63, 15, 'G3', '2021-12-18', '2021-12-31', 0, 0.488772, 54, 2.6389999999999997e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (64, 15, 'G1', '2022-01-01', '2022-02-16', 0, 0.611085, 66, 40.33);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (65, 15, 'G2', '2022-01-01', '2022-02-16', 0, 0.623185, 115, 71.67);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (66, 15, 'G3', '2022-01-01', '2022-02-16', 0, 0.635404, 180, 114.37);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (67, 15, 'G1', '2022-02-17', '2022-03-31', 0, 0.611085, 60, 36.67);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (68, 15, 'G2', '2022-02-17', '2022-03-31', 0, 0.623185, 105, 6.54299999999999926e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (69, 15, 'G3', '2022-02-17', '2022-03-31', 0, 0.635404, 76, 48.29);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (70, 16, 'G1', '2022-02-17', '2022-04-28', 0, 0.611085, 99, 60.5);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (71, 16, 'G2', '2022-02-17', '2022-04-28', 0, 0.623185, 173, 1.07809999999999988e+02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (72, 16, 'G3', '2022-02-17', '2022-04-28', 0, 0.635404, 7, 4.45);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (73, 16, 'G1', '2022-04-29', '2022-05-31', 0, 0.611085, 46, 2.81100000000000029e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (74, 17, 'G1', '2022-06-01', '2022-06-30', 0, 0.611085, 23, 14.05);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (75, 17, 'G1', '2022-07-01', '2022-07-31', 0, 0.79441, 23, 18.27);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (76, 18, 'G1', '2022-08-01', '2022-09-30', 0, 0.79441, 58, 46.08);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (77, 19, 'G1', '2022-04-29', '2022-06-30', 0, 0.611085, 28, 17.11);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (78, 19, 'G1', '2022-07-01', '2022-11-23', 0, 0.79441, 65, 51.64);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (79, 19, 'G1', '2022-11-24', '2022-11-30', 1, 0.79441, 10, 7.94);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (80, 19, 'G2', '2022-11-24', '2022-11-30', 1, 0.81014, 17, 13.77);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (81, 19, 'G3', '2022-11-24', '2022-11-30', 1, 0.826025, 6, 4.96);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (82, 20, 'G1', '2022-11-24', '2022-12-31', 0, 0.79441, 53, 42.1);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (83, 20, 'G2', '2022-11-24', '2022-12-31', 0, 0.81014, 93, 75.34);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (84, 20, 'G3', '2022-11-24', '2022-12-31', 0, 0.826025, 46, 38);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (85, 20, 'G1', '2023-01-01', '2023-01-26', 0, 0.79441, 36, 28.6);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (86, 20, 'G2', '2023-01-01', '2023-01-26', 0, 0.81014, 63, 51.04);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (87, 20, 'G3', '2023-01-01', '2023-01-26', 0, 0.826025, 32, 26.43);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (88, 20, 'G1', '2023-01-27', '2023-01-31', 1, 0.79441, 7, 5.56000000000000049e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (89, 20, 'G2', '2023-01-27', '2023-01-31', 1, 0.81014, 12, 9.72);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (90, 20, 'G3', '2023-01-27', '2023-01-31', 1, 0.826025, 5, 4.13);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (91, 21, 'G1', '2023-01-27', '2023-03-23', 0, 0.79441, 78, 61.96);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (92, 21, 'G2', '2023-01-27', '2023-03-23', 0, 0.81014, 137, 1.10990000000000009e+02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (93, 21, 'G3', '2023-01-27', '2023-03-23', 0, 0.826025, 15, 12.39);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (94, 21, 'G1', '2023-03-24', '2023-03-31', 1, 0.79441, 11, 8.74);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (95, 21, 'G2', '2023-03-24', '2023-03-31', 1, 0.81014, 18, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (96, 22, 'G1', '2023-03-24', '2023-03-31', 0, 0.79441, 11, 8.74);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (97, 22, 'G2', '2023-03-24', '2023-03-31', 0, 0.81014, 1, 8.09999999999999942e-01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (98, 22, 'G1', '2023-04-01', '2023-04-30', 0, 0.479694, 42, 20.15);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (99, 22, 'G2', '2023-04-01', '2023-04-30', 0, 0.479694, 1, 0.48);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (100, 22, 'S1', '2023-04-01', '2023-04-30', 0, 0.186125, 42, 7.82);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (101, 22, 'S2', '2023-04-01', '2023-04-30', 0, 0.248166, 1, 0.25);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (102, 22, 'G1', '2023-05-01', '2023-05-03', 0, 0.364547, 4, 1.46);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (103, 22, 'S1', '2023-05-01', '2023-05-03', 0, 0.186125, 4, 0.74);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (104, 22, 'G1', '2023-05-04', '2023-05-31', 1, 0.364547, 21, 7.65999999999999925e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (105, 22, 'S1', '2023-05-04', '2023-05-31', 1, 0.186125, 21, 3.91);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (106, 22, 'G1', '2023-06-01', '2023-06-30', 1, 0.354598, 23, 8.16);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (107, 22, 'S1', '2023-06-01', '2023-06-30', 1, 0.186125, 23, 4.27999999999999936e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (108, 23, 'G1', '2023-05-04', '2023-05-31', 0, 0.364547, 13, 4.74);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (109, 23, 'S1', '2023-05-04', '2023-05-31', 0, 0.186125, 13, 2.42);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (110, 23, 'G1', '2023-06-01', '2023-06-30', 0, 0.354598, 14, 4.96);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (111, 23, 'S1', '2023-06-01', '2023-06-30', 0, 0.186125, 14, 2.61000000000000031e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (112, 23, 'G1', '2023-07-01', '2023-07-04', 0, 0.336178, 1, 3.39999999999999968e-01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (113, 23, 'S1', '2023-07-01', '2023-07-04', 0, 0.186125, 1, 0.19);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (114, 23, 'G1', '2023-07-05', '2023-07-31', 0, 0.336178, 6, 2.02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (115, 23, 'S1', '2023-07-05', '2023-07-31', 0, 0.186125, 6, 1.11999999999999988e+00);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (116, 23, 'G1', '2023-08-01', '2023-08-31', 0, 0.355331, 12, 4.26);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (117, 23, 'S1', '2023-08-01', '2023-08-31', 0, 0.186125, 12, 2.23);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (118, 23, 'G1', '2023-09-01', '2023-09-30', 1, 0.396386, 28, 11.1);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (119, 23, 'S1', '2023-09-01', '2023-09-30', 1, 0.186125, 28, 5.21);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (120, 24, 'G1', '2020-10-01', '2020-11-30', 0, 0.470065, 85, 39.96);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (121, 24, 'G2', '2020-10-01', '2020-11-30', 0, 0.479373, 128, 61.36);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (122, 25, 'G1', '2020-05-21', '2020-12-15', 0, 0.470065, 291, 1.3679000000000002e+02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (123, 25, 'G2', '2020-05-21', '2020-12-15', 0, 0.479373, 102, 48.9);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (124, 25, 'G1', '2020-12-16', '2020-12-31', 0, 0.470065, 22, 10.34);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (125, 25, 'G2', '2020-12-16', '2020-12-31', 0, 0.479373, 39, 18.7);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (126, 25, 'G3', '2020-12-16', '2020-12-31', 0, 0.488772, 54, 2.6389999999999997e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (127, 25, 'G1', '2021-01-01', '2021-01-31', 0, 0.470065, 43, 20.21);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (128, 25, 'G2', '2021-01-01', '2021-01-31', 0, 0.479373, 76, 36.43);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (129, 25, 'G3', '2021-01-01', '2021-01-31', 0, 0.488772, 106, 51.81);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (130, 26, 'G1', '2020-12-16', '2020-12-31', 0, 0.470065, 22, 10.34);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (131, 26, 'G2', '2020-12-16', '2020-12-31', 0, 0.479373, 39, 18.7);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (132, 26, 'G3', '2020-12-16', '2020-12-31', 0, 0.488772, 71, 34.7);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (133, 26, 'G1', '2021-01-01', '2021-02-22', 0, 0.470065, 74, 34.78);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (134, 26, 'G2', '2021-01-01', '2021-02-22', 0, 0.479373, 129, 6.18399999999999963e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (135, 26, 'G3', '2021-01-01', '2021-02-22', 0, 0.488772, 234, 114.37);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (136, 26, 'G1', '2021-02-23', '2021-03-31', 0, 0.470065, 52, 24.44);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (137, 26, 'G2', '2021-02-23', '2021-03-31', 0, 0.479373, 90, 43.14);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (138, 26, 'G3', '2021-02-23', '2021-03-31', 0, 0.488772, 48, 23.46);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (139, 27, 'G1', '2021-02-23', '2021-04-14', 0, 0.470065, 71, 33.37);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (140, 27, 'G2', '2021-02-23', '2021-04-14', 0, 0.479373, 124, 59.44);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (141, 27, 'G3', '2021-02-23', '2021-04-14', 0, 0.488772, 71, 34.7);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (142, 27, 'G1', '2021-04-15', '2021-05-31', 0, 0.470065, 66, 31.02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (143, 27, 'G2', '2021-04-15', '2021-05-31', 0, 0.479373, 25, 11.98);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (144, 28, 'G1', '2021-06-01', '2021-07-31', 0, 0.470065, 50, 23.5);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (145, 29, 'G1', '2021-08-01', '2021-09-30', 0, 0.470065, 63, 2.96100000000000029e+01);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (146, 30, 'G1', '2021-10-01', '2021-11-30', 0, 0.470065, 85, 39.96);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (147, 30, 'G2', '2021-10-01', '2021-11-30', 0, 0.479373, 128, 61.36);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (148, 31, 'G1', '2021-04-15', '2021-12-13', 0, 0.470065, 340, 159.82);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (149, 31, 'G2', '2021-04-15', '2021-12-13', 0, 0.479373, 231, 1.10740000000000009e+02);
INSERT OR IGNORE INTO 'GASConsumo'('idConsumo', 'idGASFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (150, 31, 'G1', '2021-12-14', '2021-12-31', 0, 0.470065, 25, 11.75);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1250, 134, 'PU', '2023-02-01', '2023-02-28', 0, 0.16107, 184, 2.9639999999999997e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1251, 134, 'PU', '2023-02-01', '2023-02-28', 0, 0.16107, 66, 1.0629999999999999e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1252, 134, 'S1', '2023-02-01', '2023-02-28', 0, 0.010176, 184, 1.86999999999999988e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1253, 134, 'S2', '2023-02-01', '2023-02-28', 0, 0.030528, 66, 2.01000000000000023e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1254, 134, 'P', '2023-02-01', '2023-02-28', 0, 0.810113, 4.5, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1255, 134, 'R', '2023-02-01', '2023-02-28', 0, 0.05913, 250, 1.47800000000000011e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1256, 134, 'PU', '2023-03-01', '2023-03-31', 0, 0.13638, 204, 27.82);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1257, 134, 'PU', '2023-03-01', '2023-03-31', 0, 0.13638, 72, 9.82);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1258, 134, 'S1', '2023-03-01', '2023-03-31', 0, 0.010176, 204, 2.08);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1259, 134, 'S2', '2023-03-01', '2023-03-31', 0, 0.030528, 72, 2.2);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1260, 134, 'P', '2023-03-01', '2023-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1261, 134, 'R', '2023-03-01', '2023-03-31', 0, 0.05913, 276, 16.32);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1262, 134, 'PU', '2023-04-01', '2023-04-30', 0, 0.13497, 197, 2.65899999999999963e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1263, 134, 'PU', '2023-04-01', '2023-04-30', 0, 0.13497, 121, 1.63300000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1264, 134, 'S1', '2023-04-01', '2023-04-30', 0, 0.010176, 197, 2);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1265, 134, 'S2', '2023-04-01', '2023-04-30', 0, 0.030528, 121, 3.69);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1266, 134, 'P', '2023-04-01', '2023-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1267, 134, 'R', '2023-04-01', '2023-04-30', 0, 0.05913, 170, 10.05);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1268, 135, 'E1', '2022-09-01', '2022-09-30', 1, 0.111813, 116, 1.29699999999999988e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1269, 135, 'P', '2022-09-01', '2022-09-30', 1, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1270, 135, 'E1', '2022-10-01', '2022-10-31', 1, 0.111813, 146, 16.32);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1271, 135, 'P', '2022-10-01', '2022-10-31', 1, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (318, 36, 'P', '2022-12-01', '2022-12-31', 0, 0.89691, 139, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (319, 37, 'P', '2023-02-01', '2023-02-28', 0, 0.810113, 82, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (320, 38, 'PU', '2023-05-01', '2023-05-31', 0, 0.10573, 204, 21.57);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (321, 38, 'PU', '2023-05-01', '2023-05-31', 0, 0.10573, 111, 11.74);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (322, 38, 'S1', '2023-05-01', '2023-05-31', 0, 0.010176, 204, 2.08);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (323, 38, 'S2', '2023-05-01', '2023-05-31', 0, 0.030528, 111, 3.38999999999999968e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (324, 38, 'P', '2023-05-01', '2023-05-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (325, 38, 'R', '2023-05-01', '2023-05-31', 0, 0.05913, 315, 1.86300000000000025e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (326, 38, 'PU', '2023-06-01', '2023-06-30', 0, 0.10534, 142, 1.4959999999999999e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (327, 38, 'S1', '2023-06-01', '2023-06-30', 0, 0.010176, 142, 1.44);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (328, 38, 'P', '2023-06-01', '2023-06-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (329, 38, 'R', '2023-06-01', '2023-06-30', 0, 0.05913, 142, 8.4);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (581, 70, 'E1', '2019-09-01', '2019-09-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (582, 70, 'E2', '2019-09-01', '2019-09-30', 0, 0.18951, 111, 21.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (583, 70, 'P', '2019-09-01', '2019-09-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (584, 70, 'R', '2019-09-01', '2019-09-30', 0, 0.05913, 269, 15.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (585, 70, 'E1', '2019-10-01', '2019-10-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (586, 70, 'E2', '2019-10-01', '2019-10-31', 0, 0.18951, 106, 20.09);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (587, 70, 'P', '2019-10-01', '2019-10-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (588, 70, 'R', '2019-10-01', '2019-10-31', 0, 0.05913, 226, 13.36);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (589, 71, 'E1', '2019-11-01', '2019-11-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (590, 71, 'E2', '2019-11-01', '2019-11-30', 0, 0.18951, 124, 23.5);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (591, 71, 'P', '2019-11-01', '2019-11-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (592, 71, 'R', '2019-11-01', '2019-11-30', 0, 0.05913, 282, 1.66699999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (593, 71, 'E1', '2019-12-01', '2019-12-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (594, 71, 'E2', '2019-12-01', '2019-12-31', 0, 0.18951, 154, 29.18);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (595, 71, 'P', '2019-12-01', '2019-12-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (596, 71, 'R', '2019-12-01', '2019-12-31', 0, 0.05913, 213, 12.59);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (597, 72, 'E1', '2020-01-01', '2020-01-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (598, 72, 'E2', '2020-01-01', '2020-01-31', 0, 0.18951, 130, 24.64);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (599, 72, 'P', '2020-01-01', '2020-01-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (600, 72, 'R', '2020-01-01', '2020-01-31', 0, 0.05913, 293, 1.73300000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (601, 72, 'E1', '2020-02-01', '2020-02-29', 0, 0.08945, 152, 13.6);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (602, 72, 'E2', '2020-02-01', '2020-02-29', 0, 0.18951, 110, 20.85);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (603, 72, 'P', '2020-02-01', '2020-02-29', 0, 0.836753, 4.5, 3.77000000000000046e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (604, 72, 'R', '2020-02-01', '2020-02-29', 0, 0.05913, 194, 11.47);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (605, 73, 'E1', '2020-03-01', '2020-03-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (606, 73, 'E2', '2020-03-01', '2020-03-31', 0, 0.18951, 151, 2.86199999999999974e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (607, 73, 'P', '2020-03-01', '2020-03-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (608, 73, 'R', '2020-03-01', '2020-03-31', 0, 0.05913, 314, 18.57);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (609, 73, 'E1', '2020-04-01', '2020-04-30', 0, 0.08945, 157, 1.40400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (610, 73, 'E2', '2020-04-01', '2020-04-30', 0, 0.18951, 139, 2.63399999999999963e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (611, 73, 'P', '2020-04-01', '2020-04-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (612, 73, 'R', '2020-04-01', '2020-04-30', 0, 0.05913, 180, 10.64);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (613, 74, 'E1', '2020-05-01', '2020-05-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (614, 74, 'E2', '2020-05-01', '2020-05-31', 0, 0.18951, 124, 23.5);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (615, 74, 'P', '2020-05-01', '2020-05-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (616, 74, 'R', '2020-05-01', '2020-05-31', 0, 0.05913, 287, 16.97);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (617, 74, 'E1', '2020-06-01', '2020-06-30', 0, 0.08945, 157, 1.40400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (618, 74, 'E2', '2020-06-01', '2020-06-30', 0, 0.18951, 105, 19.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (619, 74, 'P', '2020-06-01', '2020-06-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (620, 74, 'R', '2020-06-01', '2020-06-30', 0, 0.05913, 208, 12.3);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (621, 75, 'E1', '2020-07-01', '2020-07-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (622, 75, 'E2', '2020-07-01', '2020-07-31', 0, 0.18951, 87, 1.64900000000000019e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (623, 75, 'P', '2020-07-01', '2020-07-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (624, 75, 'R', '2020-07-01', '2020-07-31', 0, 0.05913, 250, 1.47800000000000011e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (625, 76, 'E1', '2020-08-01', '2020-08-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (626, 76, 'E2', '2020-08-01', '2020-08-31', 0, 0.18951, 160, 30.32);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (627, 76, 'P', '2020-08-01', '2020-08-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (628, 76, 'R', '2020-08-01', '2020-08-31', 0, 0.05913, 323, 19.1);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (629, 76, 'E1', '2020-09-01', '2020-09-30', 0, 0.08945, 157, 1.40400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (630, 76, 'E2', '2020-09-01', '2020-09-30', 0, 0.18951, 103, 19.52);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (631, 76, 'P', '2020-09-01', '2020-09-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (632, 76, 'R', '2020-09-01', '2020-09-30', 0, 0.05913, 260, 15.37);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (633, 76, 'E1', '2020-10-01', '2020-10-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (634, 76, 'E2', '2020-10-01', '2020-10-31', 0, 0.18951, 111, 21.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (635, 76, 'P', '2020-10-01', '2020-10-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (636, 76, 'R', '2020-10-01', '2020-10-31', 0, 0.05913, 274, 16.2);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (637, 76, 'E1', '2020-11-01', '2020-11-30', 0, 0.08945, 157, 1.40400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (638, 76, 'E2', '2020-11-01', '2020-11-30', 0, 0.18951, 150, 28.43);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (639, 76, 'P', '2020-11-01', '2020-11-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (640, 76, 'R', '2020-11-01', '2020-11-30', 0, 0.05913, 307, 18.15);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (641, 76, 'E1', '2020-12-01', '2020-12-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (642, 76, 'E2', '2020-12-01', '2020-12-31', 0, 0.18951, 178, 3.37300000000000039e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (643, 76, 'P', '2020-12-01', '2020-12-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (644, 76, 'R', '2020-12-01', '2020-12-31', 0, 0.05913, 70, 4.14);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (645, 77, 'P', '2021-01-01', '2021-01-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (646, 77, 'R', '2021-01-01', '2021-01-31', 0, 0.05913, 369, 21.82);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (647, 77, 'P', '2021-02-01', '2021-02-28', 0, 0.810113, 4.5, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (648, 77, 'R', '2021-02-01', '2021-02-28', 0, 0.05913, 318, 18.8);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (649, 77, 'P', '2021-03-01', '2021-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (650, 77, 'R', '2021-03-01', '2021-03-31', 0, 0.05913, 286, 16.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (651, 77, 'P', '2021-04-01', '2021-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (652, 78, 'P', '2021-05-01', '2021-05-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (653, 78, 'R', '2021-05-01', '2021-05-31', 0, 0.05913, 294, 1.73800000000000025e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (654, 78, 'P', '2021-06-01', '2021-06-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (655, 78, 'R', '2021-06-01', '2021-06-30', 0, 0.05913, 304, 17.98);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (656, 78, 'E1', '2021-07-01', '2021-07-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (657, 78, 'E2', '2021-07-01', '2021-07-31', 0, 0.18951, 156, 2.95600000000000022e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (658, 78, 'P', '2021-07-01', '2021-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (659, 78, 'R', '2021-07-01', '2021-07-31', 0, 0.05913, 354, 20.93);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (660, 78, 'E1', '2021-08-01', '2021-08-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (661, 78, 'E2', '2021-08-01', '2021-08-31', 0, 0.18951, 198, 3.7519999999999996e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (662, 78, 'P', '2021-08-01', '2021-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (663, 78, 'R', '2021-08-01', '2021-08-31', 0, 0.05913, 45, 2.66);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (664, 79, 'E1', '2021-09-01', '2021-09-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (665, 79, 'E2', '2021-09-01', '2021-09-30', 0, 0.18951, 141, 26.72);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (666, 79, 'P', '2021-09-01', '2021-09-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (667, 79, 'R', '2021-09-01', '2021-09-30', 0, 0.05913, 299, 17.68);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (668, 79, 'E1', '2021-10-01', '2021-10-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (669, 79, 'E2', '2021-10-01', '2021-10-31', 0, 0.18951, 153, 29);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (670, 79, 'P', '2021-10-01', '2021-10-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (671, 79, 'R', '2021-10-01', '2021-10-31', 0, 0.05913, 316, 18.69);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (672, 79, 'E1', '2021-11-01', '2021-11-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (673, 79, 'E2', '2021-11-01', '2021-11-30', 0, 0.18951, 167, 31.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (674, 79, 'P', '2021-11-01', '2021-11-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (675, 79, 'R', '2021-11-01', '2021-11-30', 0, 0.05913, 325, 19.22);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (676, 79, 'E1', '2021-12-01', '2021-12-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (677, 79, 'E2', '2021-12-01', '2021-12-31', 0, 0.18951, 169, 32.03);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (678, 79, 'P', '2021-12-01', '2021-12-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (679, 79, 'R', '2021-12-01', '2021-12-31', 0, 0.05913, 50, 2.96);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (680, 80, 'P', '2022-01-01', '2022-01-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (681, 80, 'R', '2022-01-01', '2022-01-31', 0, 0.05913, 325, 19.22);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (682, 80, 'P', '2022-02-01', '2022-02-28', 0, 0.810113, 4.5, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (683, 80, 'R', '2022-02-01', '2022-02-28', 0, 0.05913, 301, 17.8);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (684, 80, 'P', '2022-03-01', '2022-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (685, 80, 'R', '2022-03-01', '2022-03-31', 0, 0.05913, 300, 1.77400000000000019e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (686, 80, 'P', '2022-04-01', '2022-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (687, 80, 'R', '2022-04-01', '2022-04-30', 0, 0.05913, 47, 2.78000000000000024e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (688, 81, 'P', '2022-05-01', '2022-05-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (689, 81, 'R', '2022-05-01', '2022-05-31', 0, 0.05913, 311, 18.39);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (690, 81, 'P', '2022-06-01', '2022-06-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (691, 81, 'R', '2022-06-01', '2022-06-30', 0, 0.05913, 303, 1.79199999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (692, 81, 'P', '2022-07-01', '2022-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (693, 81, 'R', '2022-07-01', '2022-07-31', 0, 0.05913, 377, 22.29);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (694, 81, 'P', '2022-08-01', '2022-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (695, 81, 'R', '2022-08-01', '2022-08-31', 0, 0.05913, 6, 0.35);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (696, 82, 'P', '2022-09-01', '2022-09-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (697, 82, 'R', '2022-09-01', '2022-09-30', 0, 0.05913, 286, 16.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (698, 82, 'P', '2022-10-01', '2022-10-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (699, 82, 'R', '2022-10-01', '2022-10-31', 0, 0.05913, 325, 19.22);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (700, 82, 'P', '2022-11-01', '2022-11-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (701, 82, 'R', '2022-11-01', '2022-11-30', 0, 0.05913, 379, 22.41);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (702, 82, 'P', '2022-12-01', '2022-12-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (703, 83, 'P', '2023-01-01', '2023-01-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (704, 83, 'R', '2023-01-01', '2023-01-31', 0, 0.05913, 389, 23);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (705, 83, 'P', '2023-02-01', '2023-02-28', 0, 0.810113, 4.5, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (706, 83, 'R', '2023-02-01', '2023-02-28', 0, 0.05913, 345, 20.4);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (707, 83, 'P', '2023-03-01', '2023-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (708, 83, 'R', '2023-03-01', '2023-03-31', 0, 0.05913, 239, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (709, 83, 'P', '2023-04-01', '2023-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (710, 84, 'P', '2023-05-01', '2023-05-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (711, 84, 'R', '2023-05-01', '2023-05-31', 0, 0.05913, 309, 18.27);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (712, 84, 'P', '2023-06-01', '2023-06-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (713, 84, 'R', '2023-06-01', '2023-06-30', 0, 0.05913, 268, 15.85);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (714, 84, 'P', '2023-07-01', '2023-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (715, 84, 'R', '2023-07-01', '2023-07-31', 0, 0.05913, 372, 22);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (716, 84, 'P', '2023-08-01', '2023-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (717, 84, 'R', '2023-08-01', '2023-08-31', 0, 0.05913, 48, 2.84);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (718, 85, 'E1', '2020-11-01', '2020-11-30', 0, 0.08945, 157, 1.40400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (719, 85, 'E2', '2020-11-01', '2020-11-30', 0, 0.18951, 48, 9.1);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (720, 85, 'P', '2020-11-01', '2020-11-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (721, 85, 'R', '2020-11-01', '2020-11-30', 0, 0.05913, 205, 1.21200000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (722, 85, 'E1', '2020-12-01', '2020-12-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (723, 85, 'E2', '2020-12-01', '2020-12-31', 0, 0.18951, 53, 1.00400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (724, 85, 'P', '2020-12-01', '2020-12-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (725, 85, 'R', '2020-12-01', '2020-12-31', 0, 0.05913, 216, 12.77);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (726, 86, 'E1', '2021-01-01', '2021-01-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (727, 86, 'E2', '2021-01-01', '2021-01-31', 0, 0.18951, 36, 6.82);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (728, 86, 'P', '2021-01-01', '2021-01-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (729, 86, 'R', '2021-01-01', '2021-01-31', 0, 0.05913, 199, 11.77);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (730, 86, 'E1', '2021-02-01', '2021-02-28', 0, 0.08945, 147, 13.15);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (731, 86, 'E2', '2021-02-01', '2021-02-28', 0, 0.18951, 13, 2.46);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (732, 86, 'P', '2021-02-01', '2021-02-28', 0, 0.810113, 4.5, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (733, 86, 'R', '2021-02-01', '2021-02-28', 0, 0.05913, 160, 9.45999999999999907e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (734, 87, 'E1', '2021-03-01', '2021-03-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (735, 87, 'E2', '2021-03-01', '2021-03-31', 0, 0.18951, 23, 4.36);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (736, 87, 'P', '2021-03-01', '2021-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (737, 87, 'R', '2021-03-01', '2021-03-31', 0, 0.05913, 186, 11);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (738, 87, 'E1', '2021-04-01', '2021-04-30', 0, 0.08945, 155, 13.86);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (739, 87, 'P', '2021-04-01', '2021-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (740, 87, 'R', '2021-04-01', '2021-04-30', 0, 0.05913, 155, 9.17);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (741, 88, 'E1', '2021-05-01', '2021-05-31', 0, 0.08945, 143, 1.27900000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (742, 88, 'P', '2021-05-01', '2021-05-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (743, 88, 'R', '2021-05-01', '2021-05-31', 0, 0.05913, 143, 8.45999999999999907e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (744, 88, 'E1', '2021-06-01', '2021-06-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (745, 88, 'E2', '2021-06-01', '2021-06-30', 0, 0.18951, 11, 2.08);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (746, 88, 'P', '2021-06-01', '2021-06-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (747, 88, 'R', '2021-06-01', '2021-06-30', 0, 0.05913, 169, 9.99);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (748, 89, 'E1', '2021-07-01', '2021-07-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (749, 89, 'E2', '2021-07-01', '2021-07-31', 0, 0.18951, 17, 3.22);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (750, 89, 'P', '2021-07-01', '2021-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (751, 89, 'R', '2021-07-01', '2021-07-31', 0, 0.05913, 180, 10.64);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (752, 89, 'E1', '2021-08-01', '2021-08-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (753, 89, 'E2', '2021-08-01', '2021-08-31', 0, 0.18951, 29, 5.5);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (754, 89, 'P', '2021-08-01', '2021-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (755, 89, 'R', '2021-08-01', '2021-08-31', 0, 0.05913, 192, 11.35);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (756, 90, 'E1', '2021-09-01', '2021-09-30', 0, 0.08945, 128, 11.45);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (757, 90, 'P', '2021-09-01', '2021-09-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (758, 90, 'R', '2021-09-01', '2021-09-30', 0, 0.05913, 128, 7.57);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (759, 90, 'E1', '2021-10-01', '2021-10-31', 0, 0.08945, 155, 13.86);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (760, 90, 'P', '2021-10-01', '2021-10-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (761, 90, 'R', '2021-10-01', '2021-10-31', 0, 0.05913, 155, 9.17);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (762, 91, 'E1', '2021-11-01', '2021-11-30', 0, 0.08945, 155, 13.86);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (763, 91, 'P', '2021-11-01', '2021-11-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (764, 91, 'R', '2021-11-01', '2021-11-30', 0, 0.05913, 155, 9.17);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (765, 91, 'E1', '2021-12-01', '2021-12-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (766, 91, 'E2', '2021-12-01', '2021-12-31', 0, 0.18951, 28, 5.31000000000000049e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (767, 91, 'P', '2021-12-01', '2021-12-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (768, 91, 'R', '2021-12-01', '2021-12-31', 0, 0.05913, 191, 1.12900000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (769, 92, 'E1', '2022-03-01', '2022-03-31', 0, 0.111813, 163, 18.23);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (770, 92, 'E2', '2022-03-01', '2022-03-31', 0, 0.255839, 13, 3.32999999999999962e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (771, 92, 'P', '2022-03-01', '2022-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (772, 92, 'R', '2022-03-01', '2022-03-31', 0, 0.05913, 176, 10.41);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (773, 92, 'E1', '2022-04-01', '2022-04-30', 0, 0.111813, 158, 1.76699999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (774, 92, 'P', '2022-04-01', '2022-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (775, 92, 'R', '2022-04-01', '2022-04-30', 0, 0.05913, 158, 9.34);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (776, 93, 'E1', '2022-05-01', '2022-05-31', 0, 0.111813, 137, 1.53199999999999985e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (777, 93, 'P', '2022-05-01', '2022-05-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (778, 93, 'R', '2022-05-01', '2022-05-31', 0, 0.05913, 137, 8.1);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (779, 93, 'E1', '2022-06-01', '2022-06-30', 0, 0.111813, 143, 15.99);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (780, 93, 'P', '2022-06-01', '2022-06-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (781, 93, 'R', '2022-06-01', '2022-06-30', 0, 0.05913, 143, 8.45999999999999907e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (782, 94, 'E1', '2022-07-01', '2022-07-31', 0, 0.111813, 181, 2.02400000000000019e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (783, 94, 'P', '2022-07-01', '2022-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (784, 94, 'R', '2022-07-01', '2022-07-31', 0, 0.05913, 181, 10.7);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (785, 94, 'E1', '2022-08-01', '2022-08-31', 0, 0.111813, 165, 18.45);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (786, 94, 'P', '2022-08-01', '2022-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (787, 94, 'R', '2022-08-01', '2022-08-31', 0, 0.05913, 165, 9.76);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (788, 95, 'E1', '2022-09-01', '2022-09-30', 0, 0.111813, 138, 1.54300000000000014e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (789, 95, 'P', '2022-09-01', '2022-09-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (790, 95, 'R', '2022-09-01', '2022-09-30', 0, 0.05913, 138, 8.16);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (791, 95, 'E1', '2022-10-01', '2022-10-31', 0, 0.111813, 181, 2.02400000000000019e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (792, 95, 'P', '2022-10-01', '2022-10-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (793, 95, 'R', '2022-10-01', '2022-10-31', 0, 0.05913, 181, 10.7);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (794, 96, 'E1', '2022-11-01', '2022-11-30', 0, 0.111813, 161, 18);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (795, 96, 'P', '2022-11-01', '2022-11-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (796, 96, 'R', '2022-11-01', '2022-11-30', 0, 0.05913, 161, 9.52);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (797, 96, 'PU', '2022-12-01', '2022-12-31', 0, 0.29491, 170, 50.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (798, 96, 'S1', '2022-12-01', '2022-12-31', 0, 0.007135, 170, 1.21);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (799, 96, 'P', '2022-12-01', '2022-12-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (800, 96, 'R', '2022-12-01', '2022-12-31', 0, 0.05913, 170, 10.05);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (801, 97, 'PU', '2023-01-01', '2023-01-31', 0, 0.17449, 170, 2.96600000000000036e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (802, 97, 'S1', '2023-01-01', '2023-01-31', 0, 0.010176, 170, 1.73);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (803, 97, 'P', '2023-01-01', '2023-01-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (804, 97, 'R', '2023-01-01', '2023-01-31', 0, 0.05913, 170, 10.05);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (805, 97, 'PU', '2023-02-01', '2023-02-28', 0, 0.16107, 159, 2.56100000000000029e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (806, 97, 'S1', '2023-02-01', '2023-02-28', 0, 0.010176, 159, 1.61999999999999988e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (807, 97, 'P', '2023-02-01', '2023-02-28', 0, 0.810113, 4.5, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (808, 97, 'R', '2023-02-01', '2023-02-28', 0, 0.05913, 159, 9.4);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (809, 98, 'PU', '2023-03-01', '2023-03-31', 0, 0.13638, 156, 21.28);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (810, 98, 'S1', '2023-03-01', '2023-03-31', 0, 0.010176, 156, 1.59);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (811, 98, 'P', '2023-03-01', '2023-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (812, 98, 'R', '2023-03-01', '2023-03-31', 0, 0.05913, 156, 9.22);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (813, 98, 'PU', '2023-04-01', '2023-04-30', 0, 0.13497, 145, 19.57);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (814, 98, 'S1', '2023-04-01', '2023-04-30', 0, 0.010176, 145, 1.48);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (815, 98, 'P', '2023-04-01', '2023-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (816, 98, 'R', '2023-04-01', '2023-04-30', 0, 0.05913, 145, 8.57);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (817, 99, 'E1', '2019-07-01', '2019-07-31', 0, 0.08945, 27, 2.42);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (818, 99, 'P', '2019-07-01', '2019-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (819, 99, 'R', '2019-07-01', '2019-07-31', 0, 0.05913, 27, 1.6);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (820, 99, 'E1', '2019-08-01', '2019-08-31', 0, 0.08945, 10, 0.89);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (821, 99, 'P', '2019-08-01', '2019-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (822, 99, 'R', '2019-08-01', '2019-08-31', 0, 0.05913, 10, 5.90000000000000079e-01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (823, 100, 'E1', '2019-09-01', '2019-09-30', 0, 0.08945, 39, 3.48999999999999976e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (824, 100, 'P', '2019-09-01', '2019-09-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (825, 100, 'R', '2019-09-01', '2019-09-30', 0, 0.05913, 39, 2.31);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (826, 100, 'E1', '2019-10-01', '2019-10-31', 0, 0.08945, 103, 9.20999999999999907e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (827, 100, 'P', '2019-10-01', '2019-10-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (828, 100, 'R', '2019-10-01', '2019-10-31', 0, 0.05913, 103, 6.09);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (829, 101, 'E1', '2019-11-01', '2019-11-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (830, 101, 'E2', '2019-11-01', '2019-11-30', 0, 0.18951, 78, 1.47800000000000011e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (831, 101, 'P', '2019-11-01', '2019-11-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (832, 101, 'R', '2019-11-01', '2019-11-30', 0, 0.05913, 236, 13.95);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (833, 101, 'E1', '2019-12-01', '2019-12-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (834, 101, 'E2', '2019-12-01', '2019-12-31', 0, 0.18951, 246, 46.62);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (835, 101, 'P', '2019-12-01', '2019-12-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (836, 101, 'R', '2019-12-01', '2019-12-31', 0, 0.05913, 409, 24.18);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (837, 102, 'E1', '2020-01-01', '2020-01-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (838, 102, 'E2', '2020-01-01', '2020-01-31', 0, 0.18951, 580, 109.92);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (839, 102, 'P', '2020-01-01', '2020-01-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (840, 102, 'R', '2020-01-01', '2020-01-31', 0, 0.05913, 487, 28.8);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (841, 102, 'E1', '2020-02-01', '2020-02-29', 0, 0.08945, 152, 13.6);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (842, 102, 'E2', '2020-02-01', '2020-02-29', 0, 0.18951, 566, 1.0725999999999999e+02);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (843, 102, 'P', '2020-02-01', '2020-02-29', 0, 0.836753, 4.5, 3.77000000000000046e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (844, 103, 'E1', '2020-03-01', '2020-03-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (845, 103, 'E2', '2020-03-01', '2020-03-31', 0, 0.18951, 345, 65.38);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (846, 103, 'P', '2020-03-01', '2020-03-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (847, 103, 'R', '2020-03-01', '2020-03-31', 0, 0.05913, 494, 29.21);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (848, 103, 'E1', '2020-04-01', '2020-04-30', 0, 0.08945, 157, 1.40400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (849, 103, 'E2', '2020-04-01', '2020-04-30', 0, 0.18951, 126, 2.38800000000000025e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (850, 103, 'P', '2020-04-01', '2020-04-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (851, 104, 'E1', '2020-05-01', '2020-05-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (852, 104, 'E2', '2020-05-01', '2020-05-31', 0, 0.18951, 117, 2.21699999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (853, 104, 'P', '2020-05-01', '2020-05-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (854, 104, 'R', '2020-05-01', '2020-05-31', 0, 0.05913, 280, 16.56);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (855, 104, 'E1', '2020-06-01', '2020-06-30', 0, 0.08945, 115, 1.02900000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (856, 104, 'P', '2020-06-01', '2020-06-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (857, 104, 'R', '2020-06-01', '2020-06-30', 0, 0.05913, 115, 6.8);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (858, 105, 'E1', '2020-07-01', '2020-07-31', 0, 0.08945, 162, 14.49);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (859, 105, 'P', '2020-07-01', '2020-07-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (860, 105, 'R', '2020-07-01', '2020-07-31', 0, 0.05913, 162, 9.58);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (861, 105, 'E1', '2020-08-01', '2020-08-31', 0, 0.08945, 116, 1.0379999999999999e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (862, 105, 'P', '2020-08-01', '2020-08-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (863, 105, 'R', '2020-08-01', '2020-08-31', 0, 0.05913, 116, 6.85999999999999943e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (864, 106, 'E1', '2020-09-01', '2020-09-30', 0, 0.08945, 116, 1.0379999999999999e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (865, 106, 'P', '2020-09-01', '2020-09-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (866, 106, 'R', '2020-09-01', '2020-09-30', 0, 0.05913, 116, 6.85999999999999943e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (867, 106, 'E1', '2020-10-01', '2020-10-31', 0, 0.08945, 146, 1.30599999999999987e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (868, 106, 'P', '2020-10-01', '2020-10-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (869, 106, 'R', '2020-10-01', '2020-10-31', 0, 0.05913, 146, 8.629999999999999e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (870, 107, 'E1', '2020-11-01', '2020-11-30', 0, 0.08945, 157, 1.40400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (871, 107, 'E2', '2020-11-01', '2020-11-30', 0, 0.18951, 136, 25.77);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (872, 107, 'P', '2020-11-01', '2020-11-30', 0, 0.865606, 4.5, 3.9);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (873, 107, 'R', '2020-11-01', '2020-11-30', 0, 0.05913, 293, 1.73300000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (874, 107, 'E1', '2020-12-01', '2020-12-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (875, 107, 'E2', '2020-12-01', '2020-12-31', 0, 0.18951, 180, 34.11);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (876, 107, 'P', '2020-12-01', '2020-12-31', 0, 0.89446, 4.5, 4.02999999999999936e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (877, 107, 'R', '2020-12-01', '2020-12-31', 0, 0.05913, 343, 20.28);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (878, 108, 'E1', '2021-01-01', '2021-01-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (879, 108, 'E2', '2021-01-01', '2021-01-31', 0, 0.18951, 221, 41.88);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (880, 108, 'P', '2021-01-01', '2021-01-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (881, 108, 'R', '2021-01-01', '2021-01-31', 0, 0.05913, 384, 22.71);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (882, 108, 'E1', '2021-02-01', '2021-02-28', 0, 0.08945, 147, 13.15);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (883, 108, 'E2', '2021-02-01', '2021-02-28', 0, 0.18951, 179, 33.92);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (884, 108, 'P', '2021-02-01', '2021-02-28', 0, 0.810113, 4.5, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (885, 108, 'R', '2021-02-01', '2021-02-28', 0, 0.05913, 94, 5.56000000000000049e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (886, 109, 'E1', '2021-03-01', '2021-03-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (887, 109, 'E2', '2021-03-01', '2021-03-31', 0, 0.18951, 146, 2.76699999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (888, 109, 'P', '2021-03-01', '2021-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (889, 109, 'R', '2021-03-01', '2021-03-31', 0, 0.05913, 309, 18.27);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (890, 109, 'E1', '2021-04-01', '2021-04-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (891, 109, 'E2', '2021-04-01', '2021-04-30', 0, 0.18951, 125, 23.69);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (892, 109, 'P', '2021-04-01', '2021-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (893, 109, 'R', '2021-04-01', '2021-04-30', 0, 0.05913, 186, 11);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (894, 110, 'E1', '2021-05-01', '2021-05-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (895, 110, 'E2', '2021-05-01', '2021-05-31', 0, 0.18951, 94, 17.81);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (896, 110, 'P', '2021-05-01', '2021-05-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (897, 110, 'R', '2021-05-01', '2021-05-31', 0, 0.05913, 257, 15.2);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (898, 110, 'E1', '2021-06-01', '2021-06-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (899, 110, 'E2', '2021-06-01', '2021-06-30', 0, 0.18951, 47, 8.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (900, 110, 'P', '2021-06-01', '2021-06-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (901, 110, 'R', '2021-06-01', '2021-06-30', 0, 0.05913, 205, 1.21200000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (902, 111, 'E1', '2021-07-01', '2021-07-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (903, 111, 'E2', '2021-07-01', '2021-07-31', 0, 0.18951, 44, 8.34);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (904, 111, 'P', '2021-07-01', '2021-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (905, 111, 'R', '2021-07-01', '2021-07-31', 0, 0.05913, 207, 12.24);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (906, 111, 'E1', '2021-08-01', '2021-08-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (907, 111, 'E2', '2021-08-01', '2021-08-31', 0, 0.18951, 4, 0.76);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (908, 111, 'P', '2021-08-01', '2021-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (909, 111, 'R', '2021-08-01', '2021-08-31', 0, 0.05913, 167, 9.87000000000000099e+00);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (910, 112, 'E1', '2021-09-01', '2021-09-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (911, 112, 'E2', '2021-09-01', '2021-09-30', 0, 0.18951, 46, 8.72);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (912, 112, 'P', '2021-09-01', '2021-09-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (913, 112, 'R', '2021-09-01', '2021-09-30', 0, 0.05913, 204, 1.20599999999999987e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (914, 112, 'E1', '2021-10-01', '2021-10-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (915, 112, 'E2', '2021-10-01', '2021-10-31', 0, 0.18951, 142, 2.69100000000000036e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (916, 112, 'P', '2021-10-01', '2021-10-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (917, 112, 'R', '2021-10-01', '2021-10-31', 0, 0.05913, 305, 18.03);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (918, 113, 'E1', '2021-11-01', '2021-11-30', 0, 0.08945, 158, 14.13);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (919, 113, 'E2', '2021-11-01', '2021-11-30', 0, 0.18951, 186, 35.25);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (920, 113, 'P', '2021-11-01', '2021-11-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (921, 113, 'R', '2021-11-01', '2021-11-30', 0, 0.05913, 344, 20.34);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (922, 113, 'E1', '2021-12-01', '2021-12-31', 0, 0.08945, 163, 1.45800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (923, 113, 'E2', '2021-12-01', '2021-12-31', 0, 0.18951, 116, 21.98);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (924, 113, 'P', '2021-12-01', '2021-12-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (925, 113, 'R', '2021-12-01', '2021-12-31', 0, 0.05913, 279, 16.5);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (926, 114, 'E1', '2022-01-01', '2022-01-31', 0, 0.111813, 163, 18.23);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (927, 114, 'E2', '2022-01-01', '2022-01-31', 0, 0.255839, 202, 5.16799999999999926e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (928, 114, 'P', '2022-01-01', '2022-01-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (929, 114, 'R', '2022-01-01', '2022-01-31', 0, 0.05913, 365, 2.15800000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (930, 114, 'E1', '2022-02-01', '2022-02-28', 0, 0.111813, 147, 16.44);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (931, 114, 'E2', '2022-02-01', '2022-02-28', 0, 0.255839, 144, 3.68399999999999963e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (932, 114, 'P', '2022-02-01', '2022-02-28', 0, 0.810113, 4.5, 3.65);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (933, 114, 'R', '2022-02-01', '2022-02-28', 0, 0.05913, 113, 6.68);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (934, 115, 'E1', '2022-03-01', '2022-03-31', 0, 0.111813, 163, 18.23);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (935, 115, 'E2', '2022-03-01', '2022-03-31', 0, 0.255839, 152, 38.89);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (936, 115, 'P', '2022-03-01', '2022-03-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (937, 115, 'R', '2022-03-01', '2022-03-31', 0, 0.05913, 315, 1.86300000000000025e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (938, 115, 'E1', '2022-04-01', '2022-04-30', 0, 0.111813, 158, 1.76699999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (939, 115, 'E2', '2022-04-01', '2022-04-30', 0, 0.255839, 99, 2.53300000000000018e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (940, 115, 'P', '2022-04-01', '2022-04-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (941, 115, 'R', '2022-04-01', '2022-04-30', 0, 0.05913, 180, 10.64);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1206, 132, 'E1', '2022-05-01', '2022-05-31', 0, 0.111813, 204, 22.81);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1207, 132, 'E2', '2022-05-01', '2022-05-31', 0, 0.255839, 44, 11.26);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1208, 132, 'P', '2022-05-01', '2022-05-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1209, 132, 'R', '2022-05-01', '2022-05-31', 0, 0.05913, 248, 14.66);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1210, 132, 'E1', '2022-06-01', '2022-06-30', 0, 0.111813, 197, 22.03);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1211, 132, 'E2', '2022-06-01', '2022-06-30', 0, 0.255839, 49, 1.25400000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1212, 132, 'P', '2022-06-01', '2022-06-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1213, 132, 'R', '2022-06-01', '2022-06-30', 0, 0.05913, 246, 14.55);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1214, 133, 'E1', '2022-07-01', '2022-07-31', 0, 0.111813, 162, 18.11);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1215, 133, 'P', '2022-07-01', '2022-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1216, 133, 'E1', '2022-08-01', '2022-08-31', 0, 0.111813, 116, 1.29699999999999988e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1217, 133, 'P', '2022-08-01', '2022-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1218, 134, 'E1', '2022-07-01', '2022-07-31', 0, 0.111813, 204, 22.81);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1219, 134, 'E2', '2022-07-01', '2022-07-31', 0, 0.255839, 72, 1.84199999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1220, 134, 'P', '2022-07-01', '2022-07-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1221, 134, 'R', '2022-07-01', '2022-07-31', 0, 0.05913, 276, 16.32);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1222, 134, 'E1', '2022-08-01', '2022-08-31', 0, 0.111813, 204, 22.81);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1223, 134, 'E2', '2022-08-01', '2022-08-31', 0, 0.255839, 72, 1.84199999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1224, 134, 'P', '2022-08-01', '2022-08-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1225, 134, 'R', '2022-08-01', '2022-08-31', 0, 0.05913, 276, 16.32);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1226, 134, 'E1', '2022-09-01', '2022-09-30', 0, 0.111813, 197, 22.03);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1227, 134, 'E2', '2022-09-01', '2022-09-30', 0, 0.255839, 70, 17.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1228, 134, 'P', '2022-09-01', '2022-09-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1229, 134, 'R', '2022-09-01', '2022-09-30', 0, 0.05913, 267, 1.57900000000000009e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1230, 134, 'E1', '2022-10-01', '2022-10-31', 0, 0.111813, 204, 22.81);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1231, 134, 'E2', '2022-10-01', '2022-10-31', 0, 0.255839, 72, 1.84199999999999981e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1232, 134, 'P', '2022-10-01', '2022-10-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1233, 134, 'R', '2022-10-01', '2022-10-31', 0, 0.05913, 276, 16.32);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1234, 134, 'E1', '2022-11-01', '2022-11-30', 0, 0.111813, 197, 22.03);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1235, 134, 'E2', '2022-11-01', '2022-11-30', 0, 0.255839, 71, 18.16);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1236, 134, 'P', '2022-11-01', '2022-11-30', 0, 0.867978, 4.5, 3.91);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1237, 134, 'R', '2022-11-01', '2022-11-30', 0, 0.05913, 268, 15.85);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1238, 134, 'PU', '2022-12-01', '2022-12-31', 0, 0.29491, 204, 6.01600000000000037e+01);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1239, 134, 'PU', '2022-12-01', '2022-12-31', 0, 0.29491, 72, 21.23);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1240, 134, 'S1', '2022-12-01', '2022-12-31', 0, 0.007135, 204, 1.46);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1241, 134, 'S2', '2022-12-01', '2022-12-31', 0, 0.021405, 72, 1.54);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1242, 134, 'P', '2022-12-01', '2022-12-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1243, 134, 'R', '2022-12-01', '2022-12-31', 0, 0.05913, 130, 7.69);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1244, 134, 'PU', '2023-01-01', '2023-01-31', 0, 0.17449, 204, 35.6);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1245, 134, 'PU', '2023-01-01', '2023-01-31', 0, 0.17449, 73, 12.74);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1246, 134, 'S1', '2023-01-01', '2023-01-31', 0, 0.010176, 204, 2.08);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1247, 134, 'S2', '2023-01-01', '2023-01-31', 0, 0.030528, 73, 2.23);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1248, 134, 'P', '2023-01-01', '2023-01-31', 0, 0.89691, 4.5, 4.04);
INSERT OR IGNORE INTO 'EEConsumo'('idEEConsumo', 'idEEFattura', 'tipoSpesa', 'dtIniz', 'dtFine', 'stimato', 'prezzoUnit', 'quantita', 'importo') VALUES (1249, 134, 'R', '2023-01-01', '2023-01-31', 0, 0.05913, 277, 1.63800000000000025e+01);
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (94, 2, 2022, '2022-10-14', 2022, '1104011', '2022-07-01', '2022-08-31', 0, 0, 3.39999999999999968e-01, 0.16, 6.80700000000000073e+01, 'EE_2022-07-01_2022-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (95, 2, 2022, '2022-12-15', 2022, '1128269', '2022-09-01', '2022-10-31', 0, 0, 3.2999999999999996e-01, 0.16, 62.81, 'EE_2022-09-01_2022-10-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (96, 2, 2023, '2023-02-13', 2023, '7800', '2022-11-01', '2022-12-31', 0, 0, 3.2999999999999996e-01, 0.16, 97.19, 'EE_2022-11-01_2022-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (97, 2, 2023, '2023-04-25', 2023, '1007077', '2023-01-01', '2023-02-28', 0, 0, 0.32, 0.16, 7.62100000000000079e+01, 'EE_2023-01-01_2023-02-28.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (98, 2, 2023, '2023-06-15', 2023, '1029302', '2023-03-01', '2023-04-30', 0, 0, 3.2999999999999996e-01, 0.16, 65.31, 'EE_2023-03-01_2023-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (99, 3, 2019, '2019-10-15', 2019, '100109767', '2019-07-01', '2019-08-31', 0, 0, 3.39999999999999968e-01, 0.16, 1.39199999999999981e+01, 'EE_2019-07-01_2019-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (100, 3, 2019, '2019-12-13', 2019, '100132147', '2019-09-01', '2019-10-31', 0, 0, 3.2999999999999996e-01, 0.16, 2.93800000000000025e+01, 'EE_2019-09-01_2019-10-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (101, 3, 2020, '2020-02-13', 2020, '102015439', '2019-11-01', '2019-12-31', 0, 0, 2.85, 0.16, 139.25, 'EE_2019-11-01_2019-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (102, 3, 2020, '2020-04-10', 2020, '102039234', '2020-01-01', '2020-02-29', 0, 0, 9.22, 0.16, 291.62, 'EE_2020-01-01_2020-02-29.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (103, 3, 2020, '2020-06-09', 2020, '102061655', '2020-03-01', '2020-04-30', 0, 0, 3.98999999999999976e+00, 0.16, 159.25, 'EE_2020-03-01_2020-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (104, 3, 2020, '2020-08-14', 2020, '102085382', '2020-05-01', '2020-06-30', 0, 0, 1.23, 0.16, 79.56, 'EE_2020-05-01_2020-06-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (105, 3, 2020, '2020-10-15', 2020, '102109019', '2020-07-01', '2020-08-31', 0, 0, 3.39999999999999968e-01, 0.16, 49.71, 'EE_2020-07-01_2020-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (106, 3, 2020, '2020-12-15', 2020, '102131556', '2020-09-01', '2020-10-31', 0, 0, 3.2999999999999996e-01, 0.16, 47.19, 'EE_2020-09-01_2020-10-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (107, 3, 2021, '2021-02-11', 2021, '10014754', '2020-11-01', '2020-12-31', 0, 0, 2.78000000000000024e+00, 0.16, 137.03, 'EE_2020-11-01_2020-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (108, 3, 2021, '2021-04-15', 2021, '10038628', '2021-01-01', '2021-02-28', 0, 0, 3.42000000000000037e+00, 0.16, 143.12, 'EE_2021-01-01_2021-02-28.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (109, 3, 2021, '2021-06-15', 2021, '10061022', '2021-03-01', '2021-04-30', 0, 0, 2.43, 0.16, 119.9, 'EE_2021-03-01_2021-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (110, 3, 2021, '2021-08-27', 2021, '10083390', '2021-05-01', '2021-06-30', 0, 0, 1.43000000000000016e+00, 0.16, 92.13, 'EE_2021-05-01_2021-06-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (111, 3, 2021, '2021-10-19', 2021, '10107226', '2021-07-01', '2021-08-31', 0, 0, 0.71, 0.16, 69.16, 'EE_2021-07-01_2021-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (112, 3, 2021, '2021-12-15', 2021, '10129589', '2021-09-01', '2021-10-31', 0, 0, 1.78999999999999981e+00, 0.16, 104.33, 'EE_2021-09-01_2021-10-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (113, 3, 2022, '2022-02-11', 2022, '1015677', '2021-11-01', '2021-12-31', 0, 0, 2.68, 0.16, 1.33609999999999985e+02, 'EE_2021-11-01_2021-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (114, 3, 2022, '2022-04-14', 2022, '1038176', '2022-01-01', '2022-02-28', 0, 0, 3.94, 0.16, 163.32, 'EE_2022-01-01_2022-02-28.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (115, 3, 2022, '2022-06-15', 2022, '1062269', '2022-03-01', '2022-04-30', 0, 0, 2.96, 0.16, 140.51, 'EE_2022-03-01_2022-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (132, 3, 2022, '2022-08-12', 2022, '1086518', '2022-05-01', '2022-06-30', 0, 0, 1.3, 0.16, 1.0725999999999999e+02, 'EE_2022-05-01_2022-06-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (133, 3, 2022, '2022-10-14', 2022, '1108917', '2022-07-01', '2022-08-31', 0, 0, 3.39999999999999968e-01, 0.16, 39.5, 'EE_2022-07-01_2022-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (134, 3, 2023, '2023-06-15', 2023, '1033960', '2022-07-01', '2023-04-30', 0, 0, 3.45, 0.16, 322.9, 'EE_2022-07-01_2023-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (135, 3, 2022, '2022-12-15', 2022, '1133113', '2022-09-01', '2022-10-31', 0, 0, 3.2999999999999996e-01, 0.16, 37.57, 'EE_2022-09-01_2022-10-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (36, 3, 2023, '2023-02-13', 2023, '12550', '2022-11-01', '2022-12-31', 0, 0, 3.13999999999999968e+00, 0.16, 163.51, NULL);
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (37, 3, 2023, '2023-04-25', 2023, '1011810', '2023-01-01', '2023-02-28', 0, 0, 1.48, 0.16, 1.07140000000000014e+02, NULL);
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (38, 3, 2023, '2023-08-28', 2023, '1058159', '2023-05-01', '2023-06-30', 0, 0, 0.95, 0.16, 91.11, NULL);
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (70, 1, 2019, '2019-12-13', 2019, '100128446', '2019-09-01', '2019-10-31', 0, 0, 2.01000000000000023e+00, 0.16, 1.09229999999999989e+02, 'EE_2019-09-01_2019-10-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (71, 1, 2020, '2020-02-13', 2020, '102011778', '2019-11-01', '2019-12-31', 0, 0, 2.48, 0.16, 1.2125999999999999e+02, 'EE_2019-11-01_2019-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (72, 1, 2020, '2020-04-10', 2020, '102035619', '2020-01-01', '2020-02-29', 0, 0, 2.19, 0.16, 112.63, 'EE_2020-01-01_2020-02-29.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (73, 1, 2020, '2020-06-09', 2020, '102058068', '2020-03-01', '2020-04-30', 0, 0, 2.58, 0.16, 1.23479999999999989e+02, 'EE_2020-03-01_2020-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (74, 1, 2020, '2020-08-14', 2020, '102081806', '2020-05-01', '2020-06-30', 0, 0, 2.11000000000000031e+00, 0.16, 111.5, 'EE_2020-05-01_2020-06-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (75, 1, 2020, '2020-09-29', 2020, '102093513', '2020-07-01', '2020-07-31', 0, 0, 8.4000000000000008e-01, 0.16, 249.08, 'EE_2020-07-01_2020-07-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (76, 1, 2021, '2021-02-19', 2021, '10022766', '2020-08-01', '2020-12-31', 0, 0, 6.27999999999999936e+00, 0.16, 304.45, 'EE_2020-08-01_2020-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (77, 1, 2021, '2021-09-24', 2021, '10092352', '2021-01-01', '2021-04-30', 1954, 633, 0.65, 0.16, 7.38200000000000073e+01, 'EE_2021-01-01_2021-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (78, 1, 2022, '2022-01-28', 2022, '1000885', '2021-05-01', '2021-08-31', 633, 0, 3.41, 0.16, 1.74890000000000014e+02, 'EE_2021-05-01_2021-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (79, 1, 2022, '2022-05-20', 2022, '1047683', '2021-09-01', '2021-12-31', 5096, 0, 5.55, 0.16, 257.21, 'EE_2021-09-01_2021-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (80, 1, 2022, '2022-07-08', 2022, '1071926', '2022-01-01', '2022-04-30', 5096, 3940, 0.65, 0.16, 73.83, 'EE_2022-01-01_2022-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (81, 1, 2022, '2022-10-27', 2022, '1118126', '2022-05-01', '2022-08-31', 3940, 2592, 0.67, 0.16, 75.65, 'EE_2022-05-01_2022-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (82, 1, 2023, '2023-03-17', 2023, '22750', '2022-09-01', '2022-12-31', 2592, 910, 6.5999999999999992e-01, 0.16, 75.1, 'EE_2022-09-01_2022-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (83, 1, 2023, '2023-08-02', 2023, '1044418', '2023-01-01', '2023-04-30', 5489, 4115, 0.65, 0.16, 7.38200000000000073e+01, 'EE_2023-01-01_2023-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (84, 1, 2023, '2023-11-23', 2023, '1090847', '2023-05-01', '2023-08-31', 4115, 2728, 0.67, 0.16, 75.66, 'EE_2023-05-01_2023-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (85, 2, 2021, '2021-02-11', 2021, '10009304', '2020-11-01', '2020-12-31', 0, 0, 1.10999999999999987e+00, 0.16, 82.19, 'EE_2020-11-01_2020-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (86, 2, 2021, '2021-04-15', 2021, '10033266', '2021-01-01', '2021-02-28', 0, 0, 0.7, 0.16, 67.13, 'EE_2021-01-01_2021-02-28.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (87, 2, 2021, '2021-06-15', 2021, '10055715', '2021-03-01', '2021-04-30', 0, 0, 0.5, 0.16, 61.92, 'EE_2021-03-01_2021-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (88, 2, 2021, '2021-08-27', 2021, '10078178', '2021-05-01', '2021-06-30', 0, 0, 4.2000000000000004e-01, 0.16, 5.63200000000000073e+01, 'EE_2021-05-01_2021-06-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (89, 2, 2021, '2021-10-19', 2021, '10102069', '2021-07-01', '2021-08-31', 0, 0, 6.90000000000000057e-01, 0.16, 69.14, 'EE_2021-07-01_2021-08-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (90, 2, 2021, '2021-12-15', 2021, '10124453', '2021-09-01', '2021-10-31', 0, 0, 3.2999999999999996e-01, 0.16, 50.83, 'EE_2021-09-01_2021-10-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (91, 2, 2022, '2022-02-11', 2022, '1010580', '2021-11-01', '2021-12-31', 0, 0, 0.54, 0.16, 63.2, 'EE_2021-11-01_2021-12-31.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (92, 2, 2022, '2022-06-15', 2022, '1057277', '2022-03-01', '2022-04-30', 0, 0, 4.59999999999999964e-01, 0.16, 67.89, 'EE_2022-03-01_2022-04-30.pdf');
INSERT OR IGNORE INTO 'EEFattura'('idEEFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'CredPrecKwh', 'CredAttKwh', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (93, 2, 2022, '2022-08-12', 2022, '1081555', '2022-05-01', '2022-06-30', 0, 0, 3.2999999999999996e-01, 0.16, 56.65, 'EE_2022-05-01_2022-06-30.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (1, 1, 2020, '2020-04-20', 2020, '320016588', '2019-11-01', '2020-02-29', NULL, '2020-02-29', '2019-11-01', NULL, 5.39, 0.17, NULL, 76.88, 'H2O_2019-11-01_2020-02-29.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (2, 1, 2020, '2020-08-04', 2020, '320035544', '2020-03-01', '2020-06-30', '2019-10-05', '2020-05-28', '2020-05-29', '2020-06-30', 6.67, 0.17, NULL, 0, 'H2O_2020-03-01_2020-06-30.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (3, 1, 2020, '2020-12-09', 2020, '320055005', '2020-07-01', '2020-10-31', '2020-05-29', '2020-08-25', '2020-08-26', '2020-10-31', 6.72000000000000064e+00, 0.17, NULL, 9.9289999999999992e+01, 'H2O_2020-07-01_2020-10-31.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (4, 1, 2021, '2021-05-31', 2021, '32016452', '2020-11-01', '2021-02-28', '2020-08-26', '2020-12-10', '2020-12-11', '2021-02-28', 6.56, 0.17, NULL, 1.2100999999999999e+02, 'H2O_2020-11-01_2021-02-28.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (5, 1, 2021, '2021-10-29', 2021, '32035363', '2021-03-01', '2021-06-30', '2020-12-11', '2021-06-22', '2021-06-23', '2021-06-30', 6.68, 0.17, NULL, 34.39, 'H2O_2021-03-01_2021-06-30.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (6, 1, 2022, '2022-01-26', 2022, '32003826', '2021-07-01', '2021-10-31', '2021-06-23', '2021-09-10', '2021-09-11', '2021-10-31', 6.74, 0.17, NULL, 76.42, 'H2O_2021-07-01_2021-10-31.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (7, 1, 2022, '2022-09-26', 2022, '32048878', '2022-03-01', '2022-07-31', '2021-09-11', '2022-03-28', '2022-07-12', '2022-07-31', 8.379999999999999e+00, 0.17, NULL, 1.10359999999999985e+02, 'H2O_2022-03-01_2022-07-31.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (8, 1, 2023, '2023-01-04', 2023, '32003679', '2022-08-01', '2022-11-30', NULL, '2022-10-10', NULL, '2022-11-30', 6.68, 0.17, -1.36699999999999981e+01, 72.16, 'H2O_2022-08-01_2022-11-30.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (9, 1, 2023, '2023-06-26', 2023, '32023573', '2022-12-01', '2023-03-31', NULL, '2023-03-31', NULL, NULL, 6.63, 0.17, NULL, 67.92, 'H2O_2022-12-01_2023-03-31.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (10, 1, 2023, '2023-09-29', 2023, '32043400', '2023-04-01', '2023-07-31', NULL, '2023-07-31', NULL, NULL, 6.68, 0.17, NULL, 68.55, 'H2O_2023-04-01_2023-07-31.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (11, 2, 2021, '2021-05-31', 2021, '32015853', '2020-11-01', '2021-02-28', '2020-08-19', '2020-11-30', '2020-12-01', '2021-02-28', 6.56, 0.17, NULL, 2.6889999999999997e+01, 'H2O_2020-11-01_2021-02-28.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (12, 2, 2021, '2021-10-29', 2021, '32034789', '2021-03-01', '2021-06-30', '2020-12-01', '2021-04-16', '2021-06-12', '2021-06-30', 6.68, 0.17, NULL, 32.53, 'H2O_2021-03-01_2021-06-30.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (13, 2, 2022, '2022-01-26', 2022, '32003247', '2021-07-01', '2021-10-31', '2021-06-12', '2021-09-10', '2021-09-11', '2021-10-31', 6.74, 0.17, NULL, 3.04100000000000036e+01, 'H2O_2021-07-01_2021-10-31.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (14, 2, 2022, '2022-05-31', 2022, '32028444', '2021-11-01', '2022-02-28', '2021-09-11', '2021-12-21', '2021-12-22', '2022-02-28', 6.57, 0.17, NULL, 31.3, 'H2O_2021-11-01_2022-02-28.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (15, 2, 2022, '2022-09-26', 2022, '32048325', '2022-03-01', '2022-07-31', '2021-12-22', '2022-04-19', '2022-07-06', '2022-07-31', 8.379999999999999e+00, 0.17, NULL, 45.86, 'H2O_2022-03-01_2022-07-31.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (16, 2, 2023, '2023-01-04', 2023, '32003129', '2022-08-01', '2022-11-30', NULL, '2022-10-05', NULL, '2022-11-30', 6.68, 0.17, -5.75, 4.50100000000000051e+01, 'H2O_2022-08-01_2022-11-30.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (17, 2, 2023, '2023-06-26', 2023, '32023024', '2022-12-01', '2023-03-31', NULL, '2023-03-31', NULL, NULL, 6.63, 0.17, NULL, 49.42, 'H2O_2022-12-01_2023-03-31.pdf');
INSERT OR IGNORE INTO 'H2OFattura'('idH2OFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodCongDtIniz', 'periodCongDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'assicurazione', 'impostaQuiet', 'RestituzAccPrec', 'TotPagare', 'nomeFile') VALUES (18, 2, 2023, '2023-09-29', 2023, '32042855', '2023-04-01', '2023-07-31', NULL, '2023-07-10', NULL, '2023-07-31', 6.68, 0.17, -54.39, 1.7509999999999998e+01, 'H2O_2023-04-01_2023-07-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (27, 2, 2021, '2021-07-29', 2021, '12068492', '2021-04-01', '2021-05-31', '2021-02-23', '2021-04-14', '2021-04-15', '2021-05-31', -9.1039999999999992e+01, 3.32000000000000028e+00, 0.36, 84.39, 'GAS_2021-04-01_2021-05-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (28, 2, 2021, '2021-09-20', 2021, '12086823', '2021-06-01', '2021-07-31', NULL, NULL, '2021-06-01', '2021-07-31', NULL, 1.03, 0.36, 2.61300000000000025e+01, 'GAS_2021-06-01_2021-07-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (29, 2, 2021, '2021-11-15', 2021, '12105242', '2021-08-01', '2021-09-30', NULL, NULL, '2021-08-01', '2021-09-30', NULL, 1.28, 0.36, 3.24899999999999948e+01, 'GAS_2021-08-01_2021-09-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (30, 2, 2022, '2022-01-13', 2022, '1204787', '2021-10-01', '2021-11-30', NULL, NULL, '2021-10-01', '2021-11-30', NULL, 4.22000000000000063e+00, 0.36, 107.3, 'GAS_2021-10-01_2021-11-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (31, 2, 2022, '2022-03-16', 2022, '1231796', '2021-12-01', '2022-01-31', '2021-04-15', '2021-12-13', '2021-12-14', '2022-01-31', -197.43, 11.39, 0.36, 289.74, 'GAS_2021-12-01_2022-01-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (32, 2, 2022, '2022-05-16', 2022, '1250434', '2022-02-01', '2022-03-31', '2021-12-14', '2022-02-22', '2022-02-23', '2022-03-31', -203.16, 12.5, 0.36, 317.96, 'GAS_2022-02-01_2022-03-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (33, 2, 2022, '2022-07-12', 2022, '1260558', '2022-04-01', '2022-05-31', '2022-02-23', '2022-04-22', '2022-04-23', '2022-05-31', -118.37, 7.92, 0.36, 2.01420000000000015e+02, 'GAS_2022-04-01_2022-05-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (34, 2, 2022, '2022-09-14', 2022, '1279157', '2022-06-01', '2022-07-31', NULL, NULL, '2022-06-01', '2022-07-31', NULL, 1.73999999999999976e+00, 0.36, 44.1, 'GAS_2022-06-01_2022-07-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (35, 2, 2022, '2022-11-14', 2022, '1297658', '2022-08-01', '2022-09-30', NULL, NULL, '2022-08-01', '2022-09-30', NULL, 2.41, 0.36, 61.21, 'GAS_2022-08-01_2022-09-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (36, 2, 2023, '2023-01-13', 2023, '4659', '2022-10-01', '2022-11-30', '2022-04-23', '2022-11-14', '2022-11-15', '2022-11-30', NULL, 1.95, 0.36, 49.62, 'GAS_2022-10-01_2022-11-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (37, 2, 2023, '2023-05-16', 2023, '2012924', '2022-12-01', '2023-01-31', '2022-11-15', '2023-01-31', NULL, NULL, NULL, 1.53300000000000018e+01, 0.36, 389.86, 'GAS_2022-12-01_2023-01-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (38, 2, 2023, '2023-07-14', 2023, '2031279', '2023-02-01', '2023-03-31', NULL, NULL, '2023-02-01', '2023-03-31', NULL, 12.67, 0.36, 322.06, 'GAS_2023-02-01_2023-03-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (39, 2, 2023, '2023-09-18', 2023, '2041500', '2023-04-01', '2023-06-30', '2023-02-01', '2023-05-04', NULL, NULL, NULL, 3.92999999999999971e+00, 0.36, 99.74, 'GAS_2023-04-01_2023-06-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (1, 1, 2020, '2020-01-15', 2020, '120013992', '2019-10-01', '2019-11-30', NULL, NULL, '2019-10-01', '2019-11-30', NULL, 4.4, 0.36, 111.8, 'GAS_2019-10-01_2019-11-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (2, 1, 2020, '2020-03-13', 2020, '120024048', '2019-12-01', '2020-01-31', '2019-05-23', '2019-12-18', '2019-12-19', '2020-01-31', -1.6579000000000002e+02, 5.8, 0.36, 147.4, 'GAS_2019-12-01_2020-01-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (3, 1, 2020, '2020-05-16', 2020, '120050518', '2020-02-01', '2020-03-31', '2019-12-19', '2020-02-24', '2020-02-25', '2020-03-31', -161.1, 6.04, 0.36, 153.48, 'GAS_2020-02-01_2020-03-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (4, 1, 2020, '2020-07-16', 2020, '120069042', '2020-04-01', '2020-05-31', '2020-02-25', '2020-05-21', '2020-05-22', '2020-05-31', -91.58, 1.61, 0.36, 4.0769999999999996e+01, 'GAS_2020-04-01_2020-05-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (5, 1, 2020, '2020-09-09', 2020, '120087431', '2020-06-01', '2020-07-31', NULL, NULL, '2020-06-01', '2020-07-31', NULL, 1.06999999999999984e+00, 0.36, 2.71100000000000029e+01, 'GAS_2020-06-01_2020-07-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (6, 1, 2020, '2020-11-13', 2020, '120105879', '2020-08-01', '2020-09-30', NULL, NULL, '2020-08-01', '2020-09-30', NULL, 1.31999999999999984e+00, 0.36, 33.47, 'GAS_2020-08-01_2020-09-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (7, 1, 2021, '2021-01-14', 2021, '12013676', '2020-10-01', '2020-11-30', NULL, NULL, '2020-10-01', '2020-11-30', NULL, 4.4, 0.36, 111.8, 'GAS_2020-10-01_2020-11-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (8, 1, 2021, '2021-03-15', 2021, '12023848', '2020-12-01', '2021-01-31', '2020-05-22', '2020-12-21', '2020-12-22', '2021-01-31', -166.73, 6.64000000000000056e+00, 0.36, 168.77, 'GAS_2020-12-01_2021-01-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (9, 1, 2021, '2021-05-13', 2021, '12042330', '2021-02-01', '2021-03-31', '2020-12-22', '2021-02-19', '2021-02-20', '2021-03-31', -149.99, 7.74, 0.36, 196.8, 'GAS_2021-02-01_2021-03-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (10, 1, 2021, '2021-07-29', 2021, '12069178', '2021-04-01', '2021-05-31', '2021-02-20', '2021-04-08', '2021-04-09', '2021-05-31', -1.05559999999999988e+02, 2.2, 0.36, 5.58799999999999954e+01, 'GAS_2021-04-01_2021-05-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (11, 1, 2021, '2021-09-20', 2021, '12087506', '2021-06-01', '2021-07-31', NULL, NULL, '2021-06-01', '2021-07-31', NULL, 1.06999999999999984e+00, 0.36, 2.71100000000000029e+01, 'GAS_2021-06-01_2021-07-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (12, 1, 2021, '2021-11-15', 2021, '12105923', '2021-08-01', '2021-09-30', NULL, NULL, '2021-08-01', '2021-09-30', NULL, 1.31999999999999984e+00, 0.36, 33.47, 'GAS_2021-08-01_2021-09-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (13, 1, 2022, '2022-01-13', 2022, '1205461', '2021-10-01', '2021-11-30', NULL, NULL, '2021-10-01', '2021-11-30', NULL, 4.4, 0.36, 111.8, 'GAS_2021-10-01_2021-11-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (14, 1, 2022, '2022-03-16', 2022, '1232466', '2021-12-01', '2022-01-31', '2021-04-09', '2021-12-17', '2021-12-18', '2022-01-31', -2.15530000000000029e+02, 8, 0.36, 203.37, 'GAS_2021-12-01_2022-01-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (15, 1, 2022, '2022-05-16', 2022, '1251102', '2022-02-01', '2022-03-31', '2021-12-18', '2022-02-16', '2022-02-17', '2022-03-31', -198.95, 9.49, 0.36, 241.3, 'GAS_2022-02-01_2022-03-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (16, 1, 2022, '2022-07-12', 2022, '1261218', '2022-04-01', '2022-05-31', '2022-02-17', '2022-04-28', '2022-04-29', '2022-05-31', -1.50390000000000014e+02, 2.13999999999999968e+00, 0.36, 5.42200000000000059e+01, 'GAS_2022-04-01_2022-05-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (17, 1, 2022, '2022-09-14', 2022, '1279815', '2022-06-01', '2022-07-31', NULL, NULL, '2022-06-01', '2022-07-31', NULL, 1.39000000000000012e+00, 0.36, 35.31, 'GAS_2022-06-01_2022-07-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (18, 1, 2022, '2022-11-14', 2022, '1298310', '2022-08-01', '2022-09-30', NULL, NULL, '2022-08-01', '2022-09-30', NULL, 1.95, 0.36, 49.63, 'GAS_2022-08-01_2022-09-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (19, 1, 2023, '2023-01-13', 2023, '5309', '2022-10-01', '2022-11-30', '2022-04-29', '2022-11-23', '2022-11-24', '2022-11-30', NULL, -0.39, 0.36, 0, 'GAS_2022-10-01_2022-11-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (20, 1, 2023, '2023-05-16', 2023, '2013566', '2022-12-01', '2023-01-31', '2022-11-24', '2023-01-26', '2023-01-27', '2023-01-31', NULL, 10.49, 0.36, 256.89, 'GAS_2022-12-01_2023-01-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (21, 1, 2023, '2023-07-14', 2023, '2031916', '2023-02-01', '2023-03-31', '2023-01-27', '2023-03-23', '2023-03-24', '2023-03-31', NULL, 7.82, 0.36, 1.98920000000000015e+02, 'GAS_2023-02-01_2023-03-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (22, 1, 2023, '2023-09-18', 2023, '2042139', '2023-04-01', '2023-06-30', '2023-03-24', '2023-05-03', '2023-05-04', '2023-06-30', NULL, 1.78, 0.36, 45.31, 'GAS_2023-04-01_2023-06-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (23, 1, 2023, '2023-11-20', 2023, '2060846', '2023-07-01', '2023-09-30', '2023-05-04', '2023-07-04', '2023-09-01', '2023-09-30', NULL, 0.8, 0.36, 0, 'GAS_2023-07-01_2023-09-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (24, 2, 2021, '2021-01-14', 2021, '12012973', '2020-10-01', '2020-11-30', NULL, NULL, '2020-10-01', '2020-11-30', NULL, 4.22000000000000063e+00, 0.36, 107.3, 'GAS_2020-10-01_2020-11-30.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (25, 2, 2021, '2021-03-15', 2021, '12023146', '2020-12-01', '2021-01-31', '2020-05-21', '2020-12-15', '2020-12-16', '2021-01-31', -1.6054000000000002e+02, 7.82, 0.36, 198.78, 'GAS_2020-12-01_2021-01-31.pdf');
INSERT OR IGNORE INTO 'GASFattura'('idGASFattura', 'idIntesta', 'annoComp', 'DataEmiss', 'fattNrAnno', 'fattNrNumero', 'periodFattDtIniz', 'periodFattDtFine', 'periodEffDtIniz', 'periodEffDtFine', 'periodAccontoDtIniz', 'periodAccontoDtFine', 'accontoBollPrec', 'addizFER', 'impostaQuiet', 'TotPagare', 'nomeFile') VALUES (26, 2, 2021, '2021-05-13', 2021, '12041633', '2021-02-01', '2021-03-31', '2020-12-16', '2021-02-22', '2021-02-23', '2021-03-31', -163.88, 8.34, 0.36, 212.1, 'GAS_2021-02-01_2021-03-31.pdf');
CREATE TABLE lost_and_found(rootpgno INTEGER, pgno INTEGER, nfield INTEGER, id INTEGER, c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15);
INSERT INTO lost_and_found VALUES(9, 9, 8, 287, NULL, 114, '2021-12-31', 31342, 'real', '2022-01-31', 31707, 365, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(9, 9, 8, 288, NULL, 114, '2022-01-31', 31707, 'real', '2022-02-28', 31998, 291, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(9, 9, 8, 289, NULL, 115, '2022-02-28', 31998, 'real', '2022-03-31', 32313, 315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(9, 9, 8, 290, NULL, 115, '2022-03-31', 32313, 'real', '2022-04-30', 32570, 257, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 606, NULL, 73, 'E2', '2020-03-01', '2020-03-31', 0, 0.18951, 151, 2.86199999999999974e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 607, NULL, 73, 'P', '2020-03-01', '2020-03-31', 0, 0.89446, 4.5, 4.02999999999999936e+00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 608, NULL, 73, 'R', '2020-03-01', '2020-03-31', 0, 0.05913, 314, 18.57, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 609, NULL, 73, 'E1', '2020-04-01', '2020-04-30', 0, 0.08945, 157, 1.40400000000000009e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 610, NULL, 73, 'E2', '2020-04-01', '2020-04-30', 0, 0.18951, 139, 2.63399999999999963e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 611, NULL, 73, 'P', '2020-04-01', '2020-04-30', 0, 0.865606, 4.5, 3.9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 612, NULL, 73, 'R', '2020-04-01', '2020-04-30', 0, 0.05913, 180, 10.64, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 613, NULL, 74, 'E1', '2020-05-01', '2020-05-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 614, NULL, 74, 'E2', '2020-05-01', '2020-05-31', 0, 0.18951, 124, 23.5, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 615, NULL, 74, 'P', '2020-05-01', '2020-05-31', 0, 0.89446, 4.5, 4.02999999999999936e+00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 616, NULL, 74, 'R', '2020-05-01', '2020-05-31', 0, 0.05913, 287, 16.97, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 617, NULL, 74, 'E1', '2020-06-01', '2020-06-30', 0, 0.08945, 157, 1.40400000000000009e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 618, NULL, 74, 'E2', '2020-06-01', '2020-06-30', 0, 0.18951, 105, 19.9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 619, NULL, 74, 'P', '2020-06-01', '2020-06-30', 0, 0.865606, 4.5, 3.9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 620, NULL, 74, 'R', '2020-06-01', '2020-06-30', 0, 0.05913, 208, 12.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 621, NULL, 75, 'E1', '2020-07-01', '2020-07-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 622, NULL, 75, 'E2', '2020-07-01', '2020-07-31', 0, 0.18951, 87, 1.64900000000000019e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 623, NULL, 75, 'P', '2020-07-01', '2020-07-31', 0, 0.89446, 4.5, 4.02999999999999936e+00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 624, NULL, 75, 'R', '2020-07-01', '2020-07-31', 0, 0.05913, 250, 1.47800000000000011e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 625, NULL, 76, 'E1', '2020-08-01', '2020-08-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 626, NULL, 76, 'E2', '2020-08-01', '2020-08-31', 0, 0.18951, 160, 30.32, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 627, NULL, 76, 'P', '2020-08-01', '2020-08-31', 0, 0.89446, 4.5, 4.02999999999999936e+00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 628, NULL, 76, 'R', '2020-08-01', '2020-08-31', 0, 0.05913, 323, 19.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 629, NULL, 76, 'E1', '2020-09-01', '2020-09-30', 0, 0.08945, 157, 1.40400000000000009e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 630, NULL, 76, 'E2', '2020-09-01', '2020-09-30', 0, 0.18951, 103, 19.52, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 631, NULL, 76, 'P', '2020-09-01', '2020-09-30', 0, 0.865606, 4.5, 3.9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 632, NULL, 76, 'R', '2020-09-01', '2020-09-30', 0, 0.05913, 260, 15.37, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 633, NULL, 76, 'E1', '2020-10-01', '2020-10-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 634, NULL, 76, 'E2', '2020-10-01', '2020-10-31', 0, 0.18951, 111, 21.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 635, NULL, 76, 'P', '2020-10-01', '2020-10-31', 0, 0.89446, 4.5, 4.02999999999999936e+00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 636, NULL, 76, 'R', '2020-10-01', '2020-10-31', 0, 0.05913, 274, 16.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 637, NULL, 76, 'E1', '2020-11-01', '2020-11-30', 0, 0.08945, 157, 1.40400000000000009e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 638, NULL, 76, 'E2', '2020-11-01', '2020-11-30', 0, 0.18951, 150, 28.43, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 639, NULL, 76, 'P', '2020-11-01', '2020-11-30', 0, 0.865606, 4.5, 3.9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 640, NULL, 76, 'R', '2020-11-01', '2020-11-30', 0, 0.05913, 307, 18.15, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 641, NULL, 76, 'E1', '2020-12-01', '2020-12-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 642, NULL, 76, 'E2', '2020-12-01', '2020-12-31', 0, 0.18951, 178, 3.37300000000000039e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 643, NULL, 76, 'P', '2020-12-01', '2020-12-31', 0, 0.89446, 4.5, 4.02999999999999936e+00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 644, NULL, 76, 'R', '2020-12-01', '2020-12-31', 0, 0.05913, 70, 4.14, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 645, NULL, 77, 'P', '2021-01-01', '2021-01-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 646, NULL, 77, 'R', '2021-01-01', '2021-01-31', 0, 0.05913, 369, 21.82, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 647, NULL, 77, 'P', '2021-02-01', '2021-02-28', 0, 0.810113, 4.5, 3.65, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 648, NULL, 77, 'R', '2021-02-01', '2021-02-28', 0, 0.05913, 318, 18.8, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 649, NULL, 77, 'P', '2021-03-01', '2021-03-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 650, NULL, 77, 'R', '2021-03-01', '2021-03-31', 0, 0.05913, 286, 16.91, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 651, NULL, 77, 'P', '2021-04-01', '2021-04-30', 0, 0.867978, 4.5, 3.91, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 652, NULL, 78, 'P', '2021-05-01', '2021-05-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 653, NULL, 78, 'R', '2021-05-01', '2021-05-31', 0, 0.05913, 294, 1.73800000000000025e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 654, NULL, 78, 'P', '2021-06-01', '2021-06-30', 0, 0.867978, 4.5, 3.91, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 655, NULL, 78, 'R', '2021-06-01', '2021-06-30', 0, 0.05913, 304, 17.98, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 656, NULL, 78, 'E1', '2021-07-01', '2021-07-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 657, NULL, 78, 'E2', '2021-07-01', '2021-07-31', 0, 0.18951, 156, 2.95600000000000022e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 658, NULL, 78, 'P', '2021-07-01', '2021-07-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 659, NULL, 78, 'R', '2021-07-01', '2021-07-31', 0, 0.05913, 354, 20.93, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 660, NULL, 78, 'E1', '2021-08-01', '2021-08-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 661, NULL, 78, 'E2', '2021-08-01', '2021-08-31', 0, 0.18951, 198, 3.7519999999999996e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 662, NULL, 78, 'P', '2021-08-01', '2021-08-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 663, NULL, 78, 'R', '2021-08-01', '2021-08-31', 0, 0.05913, 45, 2.66, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 664, NULL, 79, 'E1', '2021-09-01', '2021-09-30', 0, 0.08945, 158, 14.13, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 665, NULL, 79, 'E2', '2021-09-01', '2021-09-30', 0, 0.18951, 141, 26.72, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 666, NULL, 79, 'P', '2021-09-01', '2021-09-30', 0, 0.867978, 4.5, 3.91, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 667, NULL, 79, 'R', '2021-09-01', '2021-09-30', 0, 0.05913, 299, 17.68, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 668, NULL, 79, 'E1', '2021-10-01', '2021-10-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 669, NULL, 79, 'E2', '2021-10-01', '2021-10-31', 0, 0.18951, 153, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 670, NULL, 79, 'P', '2021-10-01', '2021-10-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 671, NULL, 79, 'R', '2021-10-01', '2021-10-31', 0, 0.05913, 316, 18.69, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 672, NULL, 79, 'E1', '2021-11-01', '2021-11-30', 0, 0.08945, 158, 14.13, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 673, NULL, 79, 'E2', '2021-11-01', '2021-11-30', 0, 0.18951, 167, 31.65, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 674, NULL, 79, 'P', '2021-11-01', '2021-11-30', 0, 0.867978, 4.5, 3.91, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 675, NULL, 79, 'R', '2021-11-01', '2021-11-30', 0, 0.05913, 325, 19.22, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(33, 33, 9, 676, NULL, 79, 'E1', '2021-12-01', '2021-12-31', 0, 0.08945, 163, 1.45800000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1185, NULL, 130, 'PU', '2023-02-01', '2023-02-28', 0, 0.16107, 66, 1.0629999999999999e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1186, NULL, 130, 'S1', '2023-02-01', '2023-02-28', 0, 0.010176, 184, 1.86999999999999988e+00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1187, NULL, 130, 'S2', '2023-02-01', '2023-02-28', 0, 0.030528, 66, 2.01000000000000023e+00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1188, NULL, 130, 'P', '2023-02-01', '2023-02-28', 0, 0.810113, 4.5, 3.65, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1189, NULL, 130, 'R', '2023-02-01', '2023-02-28', 0, 0.05913, 250, 1.47800000000000011e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1190, NULL, 130, 'PU', '2023-03-01', '2023-03-31', 0, 0.13638, 204, 27.82, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1191, NULL, 130, 'PU', '2023-03-01', '2023-03-31', 0, 0.13638, 72, 9.82, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1192, NULL, 130, 'S1', '2023-03-01', '2023-03-31', 0, 0.010176, 204, 2.08, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1193, NULL, 130, 'S2', '2023-03-01', '2023-03-31', 0, 0.030528, 72, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1194, NULL, 130, 'P', '2023-03-01', '2023-03-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1195, NULL, 130, 'R', '2023-03-01', '2023-03-31', 0, 0.05913, 276, 16.32, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1196, NULL, 130, 'PU', '2023-04-01', '2023-04-30', 0, 0.13497, 197, 2.65899999999999963e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1197, NULL, 130, 'PU', '2023-04-01', '2023-04-30', 0, 0.13497, 121, 1.63300000000000018e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1198, NULL, 130, 'S1', '2023-04-01', '2023-04-30', 0, 0.010176, 197, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1199, NULL, 130, 'S2', '2023-04-01', '2023-04-30', 0, 0.030528, 121, 3.69, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1200, NULL, 130, 'P', '2023-04-01', '2023-04-30', 0, 0.867978, 4.5, 3.91, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1201, NULL, 130, 'R', '2023-04-01', '2023-04-30', 0, 0.05913, 170, 10.05, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1202, NULL, 131, 'E1', '2022-09-01', '2022-09-30', 1, 0.111813, 116, 1.29699999999999988e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1203, NULL, 131, 'P', '2022-09-01', '2022-09-30', 1, 0.867978, 4.5, 3.91, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1204, NULL, 131, 'E1', '2022-10-01', '2022-10-31', 1, 0.111813, 146, 16.32, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1205, NULL, 131, 'P', '2022-10-01', '2022-10-31', 1, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1206, NULL, 132, 'E1', '2022-05-01', '2022-05-31', 0, 0.111813, 204, 22.81, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1207, NULL, 132, 'E2', '2022-05-01', '2022-05-31', 0, 0.255839, 44, 11.26, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1208, NULL, 132, 'P', '2022-05-01', '2022-05-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1209, NULL, 132, 'R', '2022-05-01', '2022-05-31', 0, 0.05913, 248, 14.66, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1210, NULL, 132, 'E1', '2022-06-01', '2022-06-30', 0, 0.111813, 197, 22.03, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1211, NULL, 132, 'E2', '2022-06-01', '2022-06-30', 0, 0.255839, 49, 1.25400000000000009e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1212, NULL, 132, 'P', '2022-06-01', '2022-06-30', 0, 0.867978, 4.5, 3.91, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1213, NULL, 132, 'R', '2022-06-01', '2022-06-30', 0, 0.05913, 246, 14.55, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1214, NULL, 133, 'E1', '2022-07-01', '2022-07-31', 0, 0.111813, 162, 18.11, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1215, NULL, 133, 'P', '2022-07-01', '2022-07-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1216, NULL, 133, 'E1', '2022-08-01', '2022-08-31', 0, 0.111813, 116, 1.29699999999999988e+01, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(38, 38, 9, 1217, NULL, 133, 'P', '2022-08-01', '2022-08-31', 0, 0.89691, 4.5, 4.04, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO lost_and_found VALUES(45, 45, 16, 74, 74, 1, 2022, '2022-01-13', 2022, '1205461', '2021-10-01', '2021-11-30', NULL, NULL, '2021-10-01', '2021-11-30', NULL, 4.4, 0.36, 111.8);
INSERT INTO lost_and_found VALUES(45, 45, 16, 75, 75, 1, 2022, '2022-03-16', 2022, '1232466', '2021-12-01', '2022-01-31', '2021-04-09', '2021-12-17', '2021-12-18', '2022-01-31', -2.15530000000000029e+02, 8, 0.36, 203.37);
INSERT INTO lost_and_found VALUES(45, 45, 16, 76, 76, 1, 2022, '2022-05-16', 2022, '1251102', '2022-02-01', '2022-03-31', '2021-12-18', '2022-02-16', '2022-02-17', '2022-03-31', -198.95, 9.49, 0.36, 241.3);
INSERT INTO lost_and_found VALUES(45, 45, 16, 77, 77, 1, 2022, '2022-07-12', 2022, '1261218', '2022-04-01', '2022-05-31', '2022-02-17', '2022-04-28', '2022-04-29', '2022-05-31', -1.50390000000000014e+02, 2.13999999999999968e+00, 0.36, 5.42200000000000059e+01);
INSERT INTO lost_and_found VALUES(45, 45, 16, 78, 78, 1, 2022, '2022-09-14', 2022, '1279815', '2022-06-01', '2022-07-31', NULL, NULL, '2022-06-01', '2022-07-31', NULL, 1.39000000000000012e+00, 0.36, 35.31);
INSERT INTO lost_and_found VALUES(45, 45, 16, 79, 79, 1, 2022, '2022-11-14', 2022, '1298310', '2022-08-01', '2022-09-30', NULL, NULL, '2022-08-01', '2022-09-30', NULL, 1.95, 0.36, 49.63);
INSERT INTO lost_and_found VALUES(45, 45, 16, 80, 80, 1, 2023, '2023-01-13', 2023, '5309', '2022-10-01', '2022-11-30', '2022-04-29', '2022-11-23', '2022-11-24', '2022-11-30', NULL, -0.39, 0.36, 0);
INSERT INTO lost_and_found VALUES(45, 45, 16, 81, 81, 1, 2023, '2023-05-16', 2023, '2013566', '2022-12-01', '2023-01-31', '2022-11-24', '2023-01-26', '2023-01-27', '2023-01-31', NULL, 10.49, 0.36, 256.89);
INSERT INTO lost_and_found VALUES(45, 45, 16, 82, 82, 1, 2023, '2023-07-14', 2023, '2031916', '2023-02-01', '2023-03-31', '2023-01-27', '2023-03-23', '2023-03-24', '2023-03-31', NULL, 7.82, 0.36, 1.98920000000000015e+02);
INSERT INTO lost_and_found VALUES(45, 45, 16, 83, 83, 1, 2023, '2023-09-18', 2023, '2042139', '2023-04-01', '2023-06-30', '2023-03-24', '2023-05-03', '2023-05-04', '2023-06-30', NULL, 1.78, 0.36, 45.31);
INSERT INTO lost_and_found VALUES(45, 45, 16, 84, 84, 1, 2023, '2023-11-20', 2023, '2060846', '2023-07-01', '2023-09-30', '2023-05-04', '2023-07-04', '2023-09-01', '2023-09-30', NULL, 0.8, 0.36, 0);
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
         ON ft.idIntesta = te.idIntesta;
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
		     WHERE lt.idGASFattura=ft.idGASFattura );
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
GROUP BY NomeIntesta, dtIniz, dtFine;
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
PRAGMA writable_schema = off;
COMMIT;
