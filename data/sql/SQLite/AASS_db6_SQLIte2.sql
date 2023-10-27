-- DROP TABLE Intesta;


CREATE TABLE Intesta(
	idIntesta int IDENTITY(1,1) NOT NULL,
	NomeIntesta nvarchar(64) NULL,
	dirfatture nvarchar(128) NULL,
 CONSTRAINT PK_Intesta PRIMARY KEY  (	idIntesta ASC )
);

-- --------------------------------------------------------------
CREATE TABLE EEFattura(
	idEEFattura int IDENTITY(1,1) NOT NULL,
	idIntesta int NULL,
	annoComp int NULL,
	DataEmiss date NULL,
	fattNrAnno int NULL,
	fattNrNumero nvarchar(50) NULL,
	periodFattDtIniz date NULL,
	periodFattDtFine date NULL,
	CredPrecKwh int NULL,
	CredAttKwh int NULL,
	addizFER money NULL,
	impostaQuiet money NULL,
	TotPagare money NULL,
 CONSTRAINT PK_EEFatture PRIMARY KEY ( idEEFattura ASC )
); 

CREATE TABLE EELettura(
	idLettura int IDENTITY(1,1) NOT NULL,
	idEEFattura int NOT NULL,
	LettDtPrec date NULL,
	LettPrec int NULL,
	TipoLettura varchar(16) NULL,
	LettDtAttuale date NULL,
	LettAttuale int NULL,
	LettConsumo float NULL,
 CONSTRAINT PK_EELetture PRIMARY KEY  (	idLettura ASC)
); 

CREATE TABLE EEConsumo(
	idEEConsumo int IDENTITY(1,1) NOT NULL,
	idEEFattura int NOT NULL,
	tipoSpesa nvarchar(2) NULL,
	dtIniz date NULL,
	dtFine date NULL,
	prezzoUnit decimal(10, 6) NULL,
	quantita decimal(8, 2) NULL,
	importo money NULL,
 CONSTRAINT PK_EEConsumi PRIMARY KEY ( idEEConsumo ASC ) 
);
-- --------------------------------------------------------------
CREATE TABLE GASFattura(
	idGASFattura int IDENTITY(1,1) NOT NULL,
	idIntesta int NULL,
	annoComp int NULL,
	DataEmiss date NULL,
	fattNrAnno int NULL,
	fattNrNumero nvarchar(50) NULL,
	periodFattDtIniz date NULL,
	periodFattDtFine date NULL,
	periodCongDtIniz date NULL,
	periodCongDtFine date NULL,
	periodEffDtIniz date NULL,
	periodEffDtFine date NULL,
	periodAccontoDtIniz date NULL,
	periodAccontoDtFine date NULL,
	accontoBollPrec money NULL,
	addizFER money NULL,
	impostaQuiet money NULL,
	TotPagare money NULL,
 CONSTRAINT PK_GASFatture PRIMARY KEY  ( idGASFattura ASC )
); 

CREATE TABLE GASLettura(
	idLettura int IDENTITY(1,1) NOT NULL,
	idGASFattura int NOT NULL,
	lettQtaMc int NULL,
	LettData date NULL,
	TipoLett varchar(16) NULL,
	Consumofatt float NULL,
 CONSTRAINT PK_GASLetture PRIMARY KEY  ( idLettura ASC )
); 

CREATE TABLE GASConsumo(
	idConsumo int IDENTITY(1,1) NOT NULL,
	idGASFattura int NOT NULL,
	tipoSpesa varchar(4) NULL,
	dtIniz date NULL,
	dtFine date NULL,
	prezzoUnit decimal(10, 6) NULL,
	quantita decimal(8, 2) NULL,
	importo money NULL,
 CONSTRAINT PK_GASConsumi PRIMARY KEY  ( idConsumo ASC )
); 
-- --------------------------------------------------------------
CREATE TABLE H2OFattura(
	idH2OFattura int IDENTITY(1,1) NOT NULL,
	idIntesta int NULL,
	annoComp int NULL,
	DataEmiss date NULL,
	fattNrAnno int NULL,
	fattNrNumero nvarchar(50) NULL,
	periodFattDtIniz date NULL,
	periodFattDtFine date NULL,
	periodCongDtIniz date NULL,
	periodCongDtFine date NULL,
	periodAccontoDtIniz date NULL,
	periodAccontoDtFine date NULL,
	assicurazione money NULL,
	impostaQuiet money NULL,
	RestituzAccPrec money NULL,
	TotPagare money NULL,
 CONSTRAINT PK_H2OFatture PRIMARY KEY  ( idH2OFattura ASC )
 );
 
CREATE TABLE H2OLettura(
	idLettura int IDENTITY(1,1) NOT NULL,
	idH2OFattura int NOT NULL,
	lettQtaMc int NULL,
	LettData date NULL,
	TipoLett varchar(16) NULL,
	Consumofatt float NULL,
 CONSTRAINT PK_H2OLetture PRIMARY KEY  ( idLettura ASC )
); 
CREATE TABLE H2OConsumo(
	idConsumo int IDENTITY(1,1) NOT NULL,
	idH2OFattura int NOT NULL,
	tipoSpesa varchar(4) NULL,
	dtIniz date NULL,
	dtFine date NULL,
	prezzoUnit decimal(10, 6) NULL,
	quantita decimal(8, 2) NULL,
	importo money NULL,
 CONSTRAINT PK_H2OConsumi PRIMARY KEY ( idConsumo ASC )
); 

-- SET IDENTITY_INSERT Intesta ON;

INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (1, 'claudio', 'F:\Google Drive\SMichele\AASS');
INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (2, 'andrea', 'F:\varie\AASS\Andrea');
INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (3, 'alessandro', 'F:\varie\AASS\Alessandro');

-- SET IDENTITY_INSERT Intesta OFF

