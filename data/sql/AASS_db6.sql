USE [master]
GO
CREATE DATABASE [aass]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'aass', FILENAME = N'F:\sql2017\MSSQL14.MSSQLSERVER\MSSQL\DATA\aass.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'aass_log', FILENAME = N'F:\sql2017\MSSQL14.MSSQLSERVER\MSSQL\DATA\aass_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [aass] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [aass].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [aass] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [aass] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [aass] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [aass] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [aass] SET ARITHABORT OFF 
GO
ALTER DATABASE [aass] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [aass] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [aass] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [aass] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [aass] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [aass] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [aass] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [aass] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [aass] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [aass] SET  DISABLE_BROKER 
GO
ALTER DATABASE [aass] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [aass] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [aass] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [aass] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [aass] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [aass] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [aass] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [aass] SET RECOVERY FULL 
GO
ALTER DATABASE [aass] SET  MULTI_USER 
GO
ALTER DATABASE [aass] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [aass] SET DB_CHAINING OFF 
GO
ALTER DATABASE [aass] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [aass] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [aass] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'aass', N'ON'
GO
ALTER DATABASE [aass] SET QUERY_STORE = OFF
GO
USE [aass]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Claudio
-- Create date: 16/10/2023
-- Description:	sum delle letture attuale per idFattura
-- =============================================
CREATE FUNCTION [dbo].[EESumLettAttuale] ( @p1 int )
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT @result = sum(le.lettAttuale) 
	  FROM dbo.EELettura as le
     WHERE idEEFattura = @p1

	RETURN @Result

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Claudio
-- Create date: 16/10/23
-- Description:	converte Date in un decimal(6,2) per anno,mese
-- =============================================
CREATE FUNCTION [dbo].[toAnnoMese] ( @p1 date )
RETURNS decimal(6,2)
AS
BEGIN
	DECLARE @Result decimal(6,2) =	CONVERT(decimal(6,2), cast(year(@p1) as float) + cast(datepart(M,@p1) as float) / 100) 
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EEFattura](
	[idEEFattura] [int] IDENTITY(1,1) NOT NULL,
	[idIntesta] [int] NULL,
	[annoComp] [int] NULL,
	[DataEmiss] [date] NULL,
	[fattNrAnno] [int] NULL,
	[fattNrNumero] [nvarchar](50) NULL,
	[periodFattDtIniz] [date] NULL,
	[periodFattDtFine] [date] NULL,
	[CredPrecKwh] [int] NULL,
	[CredAttKwh] [int] NULL,
	[addizFER] [money] NULL,
	[impostaQuiet] [money] NULL,
	[TotPagare] [money] NULL,
 CONSTRAINT [PK_EEFatture] PRIMARY KEY CLUSTERED 
(
	[idEEFattura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EELettura](
	[idLettura] [int] IDENTITY(1,1) NOT NULL,
	[idEEFattura] [int] NOT NULL,
	[LettDtPrec] [date] NULL,
	[LettPrec] [int] NULL,
	[TipoLettura] [varchar](16) NULL,
	[LettDtAttuale] [date] NULL,
	[LettAttuale] [int] NULL,
	[LettConsumo] [float] NULL,
 CONSTRAINT [PK_EELetture] PRIMARY KEY CLUSTERED 
(
	[idLettura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intesta](
	[idIntesta] [int] IDENTITY(1,1) NOT NULL,
	[NomeIntesta] [nvarchar](64) NULL,
	[dirfatture] [nvarchar](128) NULL,
 CONSTRAINT [PK_Intesta] PRIMARY KEY CLUSTERED 
(
	[idIntesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[EELettureMensili]
as
SELECT te.NomeIntesta
      ,le.idLettura
      ,le.idEEFattura
      ,dbo.toAnnoMese(le.LettDtPrec) as lettDtPrec
	  ,le.TipoLettura
      ,le.LettPrec
      ,dbo.toAnnoMese(le.LettDtAttuale) as lettDtAttuale
      ,le.LettAttuale
      ,le.LettConsumo
  FROM dbo.EELettura as le
  INNER JOIN dbo.EEFattura as ft
		 ON ft.idEEFattura=le.idEEFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EEConsumo](
	[idEEConsumo] [int] IDENTITY(1,1) NOT NULL,
	[idEEFattura] [int] NOT NULL,
	[tipoSpesa] [nvarchar](2) NULL,
	[dtIniz] [date] NULL,
	[dtFine] [date] NULL,
	[prezzoUnit] [decimal](10, 6) NULL,
	[quantita] [decimal](8, 2) NULL,
	[importo] [money] NULL,
 CONSTRAINT [PK_EEConsumi] PRIMARY KEY CLUSTERED 
(
	[idEEConsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[EEConsumoMensile]
AS
SELECT te.NomeIntesta 
      ,cs.idEEFattura
      ,dbo.toAnnoMese(cs.dtIniz) as dtIniz
	  ,dbo.EESumLettAttuale(cs.idEEFattura) as totLett
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
      ,cs.importo
  FROM aass.dbo.EEConsumo as cs
	  INNER JOIN dbo.EEFattura as ft
		 ON ft.idEEFattura=cs.idEEFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta
  WHERE dbo.EESumLettAttuale(cs.idEEFattura) > 0
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[EEConsumoAnnuo]
AS
SELECT NomeIntesta
      ,CAST(dtIniz as int) as anno
      ,SUM(importo) as totAnno
  FROM aass.dbo.EEConsumoMensile
GROUP BY NomeIntesta, CAST(dtIniz as int)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[EEScaglioniImporti]
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[EEScaglioniPrezzoUnit]
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
		   ISNULL(cs.prezzoUnit,0) as prezzoUnit
	  FROM dbo.EEConsumo as cs
 	    INNER JOIN dbo.EEFattura as ft
           ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN dbo.intesta as te
           ON ft.idIntesta=te.idIntesta
	  WHERE cs.tipoSpesa in ( 'E1','E2','E3', 'S1','S2','PU', 'R', 'P' )
	    AND dbo.EESumLettAttuale(cs.idEEFattura) > 0
 ) consunit  PIVOT (
	SUM(prezzoUnit)
	FOR tipoSpesa in ( E1,E2, E3, S1, S2, PU,  R, P )
 ) AS pivot_cons
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[EESpeseMensili]
as
SELECT te.nomeIntesta,
	   dbo.toAnnoMese(cs.dtIniz) as dtIniz,
       SUM(cs.quantita) as quantita,
	   SUM(cs.importo) as importo
  FROM dbo.EEConsumo as cs
   	    INNER JOIN dbo.EEFattura as ft
        ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN dbo.intesta as te
        ON ft.idIntesta=te.idIntesta
  WHERE dbo.EESumLettAttuale(cs.idEEFattura) > 0
GROUP BY te.nomeIntesta, dbo.toAnnoMese(cs.dtIniz)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EECostoAnnuale]
AS
SELECT * FROM (
SELECT NomeIntesta
      ,anno
      ,totAnno
  FROM aass.dbo.EEConsumoAnnuo
) pvtanno PIVOT (
   SUM(totAnno)
   FOR nomeIntesta IN ( alessandro, andrea, claudio )
) as pvt
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GASConsumo](
	[idConsumo] [int] IDENTITY(1,1) NOT NULL,
	[idGASFattura] [int] NOT NULL,
	[tipoSpesa] [varchar](4) NULL,
	[dtIniz] [date] NULL,
	[dtFine] [date] NULL,
	[prezzoUnit] [decimal](10, 6) NULL,
	[quantita] [decimal](8, 2) NULL,
	[importo] [money] NULL,
 CONSTRAINT [PK_GASConsumi] PRIMARY KEY CLUSTERED 
(
	[idConsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GASFattura](
	[idGASFattura] [int] IDENTITY(1,1) NOT NULL,
	[idIntesta] [int] NULL,
	[annoComp] [int] NULL,
	[DataEmiss] [date] NULL,
	[fattNrAnno] [int] NULL,
	[fattNrNumero] [nvarchar](50) NULL,
	[periodFattDtIniz] [date] NULL,
	[periodFattDtFine] [date] NULL,
	[periodCongDtIniz] [date] NULL,
	[periodCongDtFine] [date] NULL,
	[periodEffDtIniz] [date] NULL,
	[periodEffDtFine] [date] NULL,
	[periodAccontoDtIniz] [date] NULL,
	[periodAccontoDtFine] [date] NULL,
	[accontoBollPrec] [money] NULL,
	[addizFER] [money] NULL,
	[impostaQuiet] [money] NULL,
	[TotPagare] [money] NULL,
 CONSTRAINT [PK_GASFatture] PRIMARY KEY CLUSTERED 
(
	[idGASFattura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[GASConsumoMensile]
AS
SELECT te.NomeIntesta 
      ,cs.idGASFattura
      --,dbo.toAnnoMese(cs.dtIniz) as dtIniz
      --,dbo.toAnnoMese(cs.dtFine) as dtFine
      ,cs.dtIniz as dtIniz
      ,cs.dtFine as dtFine
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
	  ,DATEDIFF(d,cs.dtIniz, cs.dtFine) + 1 as qtaGG
      ,cs.quantita / (DATEDIFF(d,cs.dtIniz, cs.dtFine) + 1 ) as mediaGG
      ,cs.importo
  FROM aass.dbo.GASConsumo as cs
	  INNER JOIN dbo.GASFattura as ft
		 ON ft.idGASFattura=cs.idGASFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GASLettura](
	[idLettura] [int] IDENTITY(1,1) NOT NULL,
	[idGASFattura] [int] NOT NULL,
	[lettQtaMc] [int] NULL,
	[LettData] [date] NULL,
	[TipoLett] [varchar](16) NULL,
	[Consumofatt] [float] NULL,
 CONSTRAINT [PK_GASLetture] PRIMARY KEY CLUSTERED 
(
	[idLettura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GASLettureMensili]
AS
SELECT te.NomeIntesta
      -- ,le.idLettura
      -- ,le.idGASFattura
	  ,dbo.toAnnoMese(ft.periodFattDtIniz) as dtFattIniz
	  ,dbo.toAnnoMese(ft.periodFattDtFine) as dtFattFine
      ,dbo.toAnnoMese(le.LettData) as lettDtPrec
	  ,le.TipoLett
      ,le.Consumofatt
  FROM dbo.GASLettura as le
  INNER JOIN dbo.GASFattura as ft
		 ON ft.idGASFattura=le.idGASFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GASScaglioniImporto]
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
	  FROM dbo.GASConsumo AS cs
		INNER JOIN dbo.GASFattura as ft
			ON ft.idGASFattura=cs.idGASFattura
		INNER JOIN dbo.intesta as te
			ON ft.idIntesta=te.idIntesta
    WHERE cs.dtIniz BETWEEN ft.periodCongDtIniz and ft.periodCongDtFine
	  AND cs.dtFine BETWEEN ft.periodCongDtIniz and ft.periodCongDtFine
) consunit PIVOT (
  SUM(importo)
  FOR tipoSpesa in ( G1, G2, G3 )
) AS pivCons

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[H2OConsumo](
	[idConsumo] [int] IDENTITY(1,1) NOT NULL,
	[idH2OFattura] [int] NOT NULL,
	[tipoSpesa] [varchar](4) NULL,
	[dtIniz] [date] NULL,
	[dtFine] [date] NULL,
	[prezzoUnit] [decimal](10, 6) NULL,
	[quantita] [decimal](8, 2) NULL,
	[importo] [money] NULL,
 CONSTRAINT [PK_H2OConsumi] PRIMARY KEY CLUSTERED 
(
	[idConsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[H2OFattura](
	[idH2OFattura] [int] IDENTITY(1,1) NOT NULL,
	[idIntesta] [int] NULL,
	[annoComp] [int] NULL,
	[DataEmiss] [date] NULL,
	[fattNrAnno] [int] NULL,
	[fattNrNumero] [nvarchar](50) NULL,
	[periodFattDtIniz] [date] NULL,
	[periodFattDtFine] [date] NULL,
	[periodCongDtIniz] [date] NULL,
	[periodCongDtFine] [date] NULL,
	[periodAccontoDtIniz] [date] NULL,
	[periodAccontoDtFine] [date] NULL,
	[assicurazione] [money] NULL,
	[impostaQuiet] [money] NULL,
	[RestituzAccPrec] [money] NULL,
	[TotPagare] [money] NULL,
 CONSTRAINT [PK_H2OFatture] PRIMARY KEY CLUSTERED 
(
	[idH2OFattura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[H2OLettura](
	[idLettura] [int] IDENTITY(1,1) NOT NULL,
	[idH2OFattura] [int] NOT NULL,
	[lettQtaMc] [int] NULL,
	[LettData] [date] NULL,
	[TipoLett] [varchar](16) NULL,
	[Consumofatt] [float] NULL,
 CONSTRAINT [PK_H2OLetture] PRIMARY KEY CLUSTERED 
(
	[idLettura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[EEConsumo] ON 

INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1700, 182, N'E1', CAST(N'2019-07-01' AS Date), CAST(N'2019-07-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(27.00 AS Decimal(8, 2)), 2.4200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1701, 182, N'P', CAST(N'2019-07-01' AS Date), CAST(N'2019-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1702, 182, N'R', CAST(N'2019-07-01' AS Date), CAST(N'2019-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(27.00 AS Decimal(8, 2)), 1.6000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1703, 182, N'E1', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 0.8900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1704, 182, N'P', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1705, 182, N'R', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 0.5900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1706, 183, N'E1', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 3.4900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1707, 183, N'P', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1708, 183, N'R', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 2.3100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1709, 183, N'E1', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(103.00 AS Decimal(8, 2)), 9.2100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1710, 183, N'P', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1711, 183, N'R', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(103.00 AS Decimal(8, 2)), 6.0900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1712, 184, N'E1', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1713, 184, N'E2', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(78.00 AS Decimal(8, 2)), 14.7800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1714, 184, N'P', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1715, 184, N'R', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(236.00 AS Decimal(8, 2)), 13.9500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1716, 184, N'E1', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1717, 184, N'E2', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(246.00 AS Decimal(8, 2)), 46.6200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1718, 184, N'P', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1719, 184, N'R', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(409.00 AS Decimal(8, 2)), 24.1800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1837, 201, N'E1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 22.8100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1838, 201, N'E2', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 18.4200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1839, 201, N'P', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1840, 201, N'R', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(276.00 AS Decimal(8, 2)), 16.3200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1841, 201, N'E1', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 22.8100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1842, 201, N'E2', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 18.4200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1843, 201, N'P', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1844, 201, N'R', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(276.00 AS Decimal(8, 2)), 16.3200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1845, 201, N'E1', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(197.00 AS Decimal(8, 2)), 22.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1846, 201, N'E2', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(70.00 AS Decimal(8, 2)), 17.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1847, 201, N'P', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1848, 201, N'R', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(267.00 AS Decimal(8, 2)), 15.7900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1849, 201, N'E1', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 22.8100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1850, 201, N'E2', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 18.4200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1851, 201, N'P', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1852, 201, N'R', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(276.00 AS Decimal(8, 2)), 16.3200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1853, 201, N'E1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(197.00 AS Decimal(8, 2)), 22.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1854, 201, N'E2', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 18.1600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1855, 201, N'P', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1856, 201, N'R', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(268.00 AS Decimal(8, 2)), 15.8500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1857, 201, N'PU', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.294910 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 60.1600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1858, 201, N'PU', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.294910 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 21.2300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1859, 201, N'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.007135 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 1.4600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1860, 201, N'S2', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.021405 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 1.5400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1861, 201, N'P', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1862, 201, N'R', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(130.00 AS Decimal(8, 2)), 7.6900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1863, 201, N'PU', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.174490 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 35.6000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1864, 201, N'PU', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.174490 AS Decimal(10, 6)), CAST(73.00 AS Decimal(8, 2)), 12.7400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1865, 201, N'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 2.0800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1866, 201, N'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(73.00 AS Decimal(8, 2)), 2.2300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1867, 201, N'P', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1868, 201, N'R', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(277.00 AS Decimal(8, 2)), 16.3800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1869, 201, N'PU', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.161070 AS Decimal(10, 6)), CAST(184.00 AS Decimal(8, 2)), 29.6400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1870, 201, N'PU', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.161070 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 10.6300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1871, 201, N'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(184.00 AS Decimal(8, 2)), 1.8700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1872, 201, N'S2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 2.0100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1873, 201, N'P', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1874, 201, N'R', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(250.00 AS Decimal(8, 2)), 14.7800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1875, 201, N'PU', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.136380 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 27.8200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1876, 201, N'PU', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.136380 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 9.8200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1877, 201, N'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 2.0800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1878, 201, N'S2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 2.2000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1879, 201, N'P', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1880, 201, N'R', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(276.00 AS Decimal(8, 2)), 16.3200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1881, 201, N'PU', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.134970 AS Decimal(10, 6)), CAST(197.00 AS Decimal(8, 2)), 26.5900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1882, 201, N'PU', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.134970 AS Decimal(10, 6)), CAST(121.00 AS Decimal(8, 2)), 16.3300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1883, 201, N'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(197.00 AS Decimal(8, 2)), 2.0000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1884, 201, N'S2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(121.00 AS Decimal(8, 2)), 3.6900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1885, 201, N'P', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1886, 201, N'R', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 10.0500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1887, 202, N'P', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(146.00 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1888, 203, N'P', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(139.00 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1889, 204, N'P', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(82.00 AS Decimal(8, 2)), 3.6500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1890, 205, N'PU', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.105730 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 21.5700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1891, 205, N'PU', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.105730 AS Decimal(10, 6)), CAST(111.00 AS Decimal(8, 2)), 11.7400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1892, 205, N'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(204.00 AS Decimal(8, 2)), 2.0800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1893, 205, N'S2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.030528 AS Decimal(10, 6)), CAST(111.00 AS Decimal(8, 2)), 3.3900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1894, 205, N'P', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1895, 205, N'R', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(315.00 AS Decimal(8, 2)), 18.6300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1896, 205, N'PU', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.105340 AS Decimal(10, 6)), CAST(142.00 AS Decimal(8, 2)), 14.9600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1897, 205, N'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(142.00 AS Decimal(8, 2)), 1.4400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1898, 205, N'P', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1899, 205, N'R', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(142.00 AS Decimal(8, 2)), 8.4000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1900, 206, N'E1', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1901, 206, N'E2', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(111.00 AS Decimal(8, 2)), 21.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1902, 206, N'P', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1903, 206, N'R', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(269.00 AS Decimal(8, 2)), 15.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1904, 206, N'E1', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1905, 206, N'E2', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(106.00 AS Decimal(8, 2)), 20.0900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1906, 206, N'P', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1907, 206, N'R', CAST(N'2019-10-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(226.00 AS Decimal(8, 2)), 13.3600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1908, 207, N'E1', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1909, 207, N'E2', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(124.00 AS Decimal(8, 2)), 23.5000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1910, 207, N'P', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1911, 207, N'R', CAST(N'2019-11-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(282.00 AS Decimal(8, 2)), 16.6700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1912, 207, N'E1', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1913, 207, N'E2', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(154.00 AS Decimal(8, 2)), 29.1800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1914, 207, N'P', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1915, 207, N'R', CAST(N'2019-12-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(213.00 AS Decimal(8, 2)), 12.5900)
GO
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1916, 208, N'E1', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1917, 208, N'E2', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(130.00 AS Decimal(8, 2)), 24.6400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1918, 208, N'P', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1919, 208, N'R', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(293.00 AS Decimal(8, 2)), 17.3300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1920, 208, N'E1', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(152.00 AS Decimal(8, 2)), 13.6000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1921, 208, N'E2', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(110.00 AS Decimal(8, 2)), 20.8500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1922, 208, N'P', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.836753 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.7700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1923, 208, N'R', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(194.00 AS Decimal(8, 2)), 11.4700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1924, 209, N'E1', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1925, 209, N'E2', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(151.00 AS Decimal(8, 2)), 28.6200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1926, 209, N'P', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1927, 209, N'R', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(314.00 AS Decimal(8, 2)), 18.5700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1928, 209, N'E1', CAST(N'2020-04-01' AS Date), CAST(N'2020-04-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1929, 209, N'E2', CAST(N'2020-04-01' AS Date), CAST(N'2020-04-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(139.00 AS Decimal(8, 2)), 26.3400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1930, 209, N'P', CAST(N'2020-04-01' AS Date), CAST(N'2020-04-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1931, 209, N'R', CAST(N'2020-04-01' AS Date), CAST(N'2020-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(180.00 AS Decimal(8, 2)), 10.6400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1932, 210, N'E1', CAST(N'2020-05-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1933, 210, N'E2', CAST(N'2020-05-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(124.00 AS Decimal(8, 2)), 23.5000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1934, 210, N'P', CAST(N'2020-05-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1935, 210, N'R', CAST(N'2020-05-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(287.00 AS Decimal(8, 2)), 16.9700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1936, 210, N'E1', CAST(N'2020-06-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1937, 210, N'E2', CAST(N'2020-06-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(105.00 AS Decimal(8, 2)), 19.9000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1938, 210, N'P', CAST(N'2020-06-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1939, 210, N'R', CAST(N'2020-06-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(208.00 AS Decimal(8, 2)), 12.3000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1940, 211, N'E1', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1941, 211, N'E2', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(87.00 AS Decimal(8, 2)), 16.4900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1942, 211, N'P', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1943, 211, N'R', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(250.00 AS Decimal(8, 2)), 14.7800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1944, 212, N'E1', CAST(N'2020-08-01' AS Date), CAST(N'2020-08-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1945, 212, N'E2', CAST(N'2020-08-01' AS Date), CAST(N'2020-08-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(160.00 AS Decimal(8, 2)), 30.3200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1946, 212, N'P', CAST(N'2020-08-01' AS Date), CAST(N'2020-08-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1947, 212, N'R', CAST(N'2020-08-01' AS Date), CAST(N'2020-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(323.00 AS Decimal(8, 2)), 19.1000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1948, 212, N'E1', CAST(N'2020-09-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1949, 212, N'E2', CAST(N'2020-09-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(103.00 AS Decimal(8, 2)), 19.5200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1950, 212, N'P', CAST(N'2020-09-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1951, 212, N'R', CAST(N'2020-09-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(260.00 AS Decimal(8, 2)), 15.3700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1952, 212, N'E1', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1953, 212, N'E2', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(111.00 AS Decimal(8, 2)), 21.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1954, 212, N'P', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1955, 212, N'R', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(274.00 AS Decimal(8, 2)), 16.2000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1956, 212, N'E1', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1957, 212, N'E2', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(150.00 AS Decimal(8, 2)), 28.4300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1958, 212, N'P', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1959, 212, N'R', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(307.00 AS Decimal(8, 2)), 18.1500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1960, 212, N'E1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1961, 212, N'E2', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(178.00 AS Decimal(8, 2)), 33.7300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1962, 212, N'P', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1963, 212, N'R', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(70.00 AS Decimal(8, 2)), 4.1400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1964, 213, N'P', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1965, 213, N'R', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(369.00 AS Decimal(8, 2)), 21.8200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1966, 213, N'P', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1967, 213, N'R', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(318.00 AS Decimal(8, 2)), 18.8000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1968, 213, N'P', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1969, 213, N'R', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(286.00 AS Decimal(8, 2)), 16.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1970, 213, N'P', CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1971, 214, N'P', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1972, 214, N'R', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(294.00 AS Decimal(8, 2)), 17.3800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1973, 214, N'P', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1974, 214, N'R', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(304.00 AS Decimal(8, 2)), 17.9800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1975, 214, N'E1', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1976, 214, N'E2', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(156.00 AS Decimal(8, 2)), 29.5600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1977, 214, N'P', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1978, 214, N'R', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(354.00 AS Decimal(8, 2)), 20.9300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1979, 214, N'E1', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1980, 214, N'E2', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(198.00 AS Decimal(8, 2)), 37.5200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1981, 214, N'P', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1982, 214, N'R', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(45.00 AS Decimal(8, 2)), 2.6600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1983, 215, N'E1', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1984, 215, N'E2', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(141.00 AS Decimal(8, 2)), 26.7200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1985, 215, N'P', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1986, 215, N'R', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(299.00 AS Decimal(8, 2)), 17.6800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1987, 215, N'E1', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1988, 215, N'E2', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(153.00 AS Decimal(8, 2)), 29.0000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1989, 215, N'P', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1990, 215, N'R', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(316.00 AS Decimal(8, 2)), 18.6900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1991, 215, N'E1', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1992, 215, N'E2', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(167.00 AS Decimal(8, 2)), 31.6500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1993, 215, N'P', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1994, 215, N'R', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(325.00 AS Decimal(8, 2)), 19.2200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1995, 215, N'E1', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1996, 215, N'E2', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(169.00 AS Decimal(8, 2)), 32.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1997, 215, N'P', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1998, 215, N'R', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 2.9600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1999, 216, N'P', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2000, 216, N'R', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(325.00 AS Decimal(8, 2)), 19.2200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2001, 216, N'P', CAST(N'2022-02-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2002, 216, N'R', CAST(N'2022-02-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(301.00 AS Decimal(8, 2)), 17.8000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2003, 216, N'P', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2004, 216, N'R', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(300.00 AS Decimal(8, 2)), 17.7400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2005, 216, N'P', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2006, 216, N'R', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(47.00 AS Decimal(8, 2)), 2.7800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2007, 217, N'P', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2008, 217, N'R', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(311.00 AS Decimal(8, 2)), 18.3900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2009, 217, N'P', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2010, 217, N'R', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(303.00 AS Decimal(8, 2)), 17.9200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2011, 217, N'P', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2012, 217, N'R', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(377.00 AS Decimal(8, 2)), 22.2900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2013, 217, N'P', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2014, 217, N'R', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 0.3500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2015, 218, N'P', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
GO
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2016, 218, N'R', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(286.00 AS Decimal(8, 2)), 16.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2017, 218, N'P', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2018, 218, N'R', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(325.00 AS Decimal(8, 2)), 19.2200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2019, 218, N'P', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2020, 218, N'R', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(379.00 AS Decimal(8, 2)), 22.4100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2021, 218, N'P', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2022, 219, N'P', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2023, 219, N'R', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(389.00 AS Decimal(8, 2)), 23.0000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2024, 219, N'P', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2025, 219, N'R', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(345.00 AS Decimal(8, 2)), 20.4000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2026, 219, N'P', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2027, 219, N'R', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(239.00 AS Decimal(8, 2)), 14.1300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2028, 219, N'P', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2036, 221, N'E1', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(157.00 AS Decimal(8, 2)), 14.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2037, 221, N'E2', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(48.00 AS Decimal(8, 2)), 9.1000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2038, 221, N'P', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.865606 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2039, 221, N'R', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(205.00 AS Decimal(8, 2)), 12.1200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2040, 221, N'E1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2041, 221, N'E2', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(53.00 AS Decimal(8, 2)), 10.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2042, 221, N'P', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.894460 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2043, 221, N'R', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(216.00 AS Decimal(8, 2)), 12.7700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2044, 222, N'E1', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2045, 222, N'E2', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(36.00 AS Decimal(8, 2)), 6.8200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2046, 222, N'P', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2047, 222, N'R', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(199.00 AS Decimal(8, 2)), 11.7700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2048, 222, N'E1', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(147.00 AS Decimal(8, 2)), 13.1500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2049, 222, N'E2', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 2.4600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2050, 222, N'P', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2051, 222, N'R', CAST(N'2021-02-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(160.00 AS Decimal(8, 2)), 9.4600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2052, 223, N'E1', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2053, 223, N'E2', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(23.00 AS Decimal(8, 2)), 4.3600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2054, 223, N'P', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2055, 223, N'R', CAST(N'2021-03-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(186.00 AS Decimal(8, 2)), 11.0000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2056, 223, N'E1', CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 13.8600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2057, 223, N'P', CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2058, 223, N'R', CAST(N'2021-04-01' AS Date), CAST(N'2021-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 9.1700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2059, 224, N'E1', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(143.00 AS Decimal(8, 2)), 12.7900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2060, 224, N'P', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2061, 224, N'R', CAST(N'2021-05-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(143.00 AS Decimal(8, 2)), 8.4600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2062, 224, N'E1', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 14.1300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2063, 224, N'E2', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 2.0800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2064, 224, N'P', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2065, 224, N'R', CAST(N'2021-06-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(169.00 AS Decimal(8, 2)), 9.9900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2066, 225, N'E1', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2067, 225, N'E2', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 3.2200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2068, 225, N'P', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2069, 225, N'R', CAST(N'2021-07-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(180.00 AS Decimal(8, 2)), 10.6400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2070, 225, N'E1', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2071, 225, N'E2', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 5.5000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2072, 225, N'P', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2073, 225, N'R', CAST(N'2021-08-01' AS Date), CAST(N'2021-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(192.00 AS Decimal(8, 2)), 11.3500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2074, 226, N'E1', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(128.00 AS Decimal(8, 2)), 11.4500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2075, 226, N'P', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2076, 226, N'R', CAST(N'2021-09-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(128.00 AS Decimal(8, 2)), 7.5700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2077, 226, N'E1', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 13.8600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2078, 226, N'P', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2079, 226, N'R', CAST(N'2021-10-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 9.1700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2080, 227, N'E1', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 13.8600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2081, 227, N'P', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2082, 227, N'R', CAST(N'2021-11-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(155.00 AS Decimal(8, 2)), 9.1700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2083, 227, N'E1', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.089450 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2084, 227, N'E2', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.189510 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 5.3100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2085, 227, N'P', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2086, 227, N'R', CAST(N'2021-12-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(191.00 AS Decimal(8, 2)), 11.2900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2087, 228, N'E1', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(163.00 AS Decimal(8, 2)), 18.2300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2088, 228, N'E2', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.255839 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 3.3300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2089, 228, N'P', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2090, 228, N'R', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(176.00 AS Decimal(8, 2)), 10.4100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2091, 228, N'E1', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 17.6700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2092, 228, N'P', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2093, 228, N'R', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(158.00 AS Decimal(8, 2)), 9.3400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2094, 229, N'E1', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 15.3200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2095, 229, N'P', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2096, 229, N'R', CAST(N'2022-05-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 8.1000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2097, 229, N'E1', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(143.00 AS Decimal(8, 2)), 15.9900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2098, 229, N'P', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2099, 229, N'R', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(143.00 AS Decimal(8, 2)), 8.4600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2100, 230, N'E1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(181.00 AS Decimal(8, 2)), 20.2400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2101, 230, N'P', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2102, 230, N'R', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(181.00 AS Decimal(8, 2)), 10.7000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2103, 230, N'E1', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(165.00 AS Decimal(8, 2)), 18.4500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2104, 230, N'P', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2105, 230, N'R', CAST(N'2022-08-01' AS Date), CAST(N'2022-08-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(165.00 AS Decimal(8, 2)), 9.7600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2106, 231, N'E1', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(138.00 AS Decimal(8, 2)), 15.4300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2107, 231, N'P', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2108, 231, N'R', CAST(N'2022-09-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(138.00 AS Decimal(8, 2)), 8.1600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2109, 231, N'E1', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(181.00 AS Decimal(8, 2)), 20.2400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2110, 231, N'P', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2111, 231, N'R', CAST(N'2022-10-01' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(181.00 AS Decimal(8, 2)), 10.7000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2112, 232, N'E1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.111813 AS Decimal(10, 6)), CAST(161.00 AS Decimal(8, 2)), 18.0000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2113, 232, N'P', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2114, 232, N'R', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(161.00 AS Decimal(8, 2)), 9.5200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2115, 232, N'PU', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.294910 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 50.1300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2116, 232, N'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.007135 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 1.2100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2117, 232, N'P', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2118, 232, N'R', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 10.0500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2119, 233, N'PU', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.174490 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 29.6600)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2120, 233, N'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 1.7300)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2121, 233, N'P', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2122, 233, N'R', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(170.00 AS Decimal(8, 2)), 10.0500)
GO
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2123, 233, N'PU', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.161070 AS Decimal(10, 6)), CAST(159.00 AS Decimal(8, 2)), 25.6100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2124, 233, N'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(159.00 AS Decimal(8, 2)), 1.6200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2125, 233, N'P', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810113 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.6500)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2126, 233, N'R', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(159.00 AS Decimal(8, 2)), 9.4000)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2127, 234, N'PU', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.136380 AS Decimal(10, 6)), CAST(156.00 AS Decimal(8, 2)), 21.2800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2128, 234, N'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(156.00 AS Decimal(8, 2)), 1.5900)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2129, 234, N'P', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.896910 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 4.0400)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2130, 234, N'R', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(156.00 AS Decimal(8, 2)), 9.2200)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2131, 234, N'PU', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.134970 AS Decimal(10, 6)), CAST(145.00 AS Decimal(8, 2)), 19.5700)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2132, 234, N'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.010176 AS Decimal(10, 6)), CAST(145.00 AS Decimal(8, 2)), 1.4800)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2133, 234, N'P', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.867978 AS Decimal(10, 6)), CAST(4.50 AS Decimal(8, 2)), 3.9100)
INSERT [dbo].[EEConsumo] ([idEEConsumo], [idEEFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (2134, 234, N'R', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.059130 AS Decimal(10, 6)), CAST(145.00 AS Decimal(8, 2)), 8.5700)
SET IDENTITY_INSERT [dbo].[EEConsumo] OFF
SET IDENTITY_INSERT [dbo].[EEFattura] ON 

INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (182, 3, 2019, CAST(N'2019-10-15' AS Date), 2019, N'100109767', CAST(N'2019-07-01' AS Date), CAST(N'2019-08-31' AS Date), 0, 0, 0.3400, 0.1600, 13.9200)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (183, 3, 2019, CAST(N'2019-12-13' AS Date), 2019, N'100132147', CAST(N'2019-09-01' AS Date), CAST(N'2019-10-31' AS Date), 0, 0, 0.3300, 0.1600, 29.3800)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (184, 3, 2020, CAST(N'2020-02-13' AS Date), 2020, N'102015439', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), 0, 0, 2.8500, 0.1600, 139.2500)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (201, 3, 2023, CAST(N'2023-06-15' AS Date), 2023, N'1033960', CAST(N'2022-07-01' AS Date), CAST(N'2023-04-30' AS Date), 0, 0, 3.4500, 0.1600, 322.9000)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (202, 3, 2022, CAST(N'2022-12-15' AS Date), 2022, N'1133113', CAST(N'2022-09-01' AS Date), CAST(N'2022-10-31' AS Date), 0, 0, 0.3300, 0.1600, 37.5700)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (203, 3, 2023, CAST(N'2023-02-13' AS Date), 2023, N'12550', CAST(N'2022-11-01' AS Date), CAST(N'2022-12-31' AS Date), 0, 0, 3.1400, 0.1600, 163.5100)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (204, 3, 2023, CAST(N'2023-04-25' AS Date), 2023, N'1011810', CAST(N'2023-01-01' AS Date), CAST(N'2023-02-28' AS Date), 0, 0, 1.4800, 0.1600, 107.1400)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (205, 3, 2023, CAST(N'2023-08-28' AS Date), 2023, N'1058159', CAST(N'2023-05-01' AS Date), CAST(N'2023-06-30' AS Date), 0, 0, 0.9500, 0.1600, 91.1100)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (206, 1, 2019, CAST(N'2019-12-13' AS Date), 2019, N'100128446', CAST(N'2019-09-01' AS Date), CAST(N'2019-10-31' AS Date), 0, 0, 2.0100, 0.1600, 109.2300)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (207, 1, 2020, CAST(N'2020-02-13' AS Date), 2020, N'102011778', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), 0, 0, 2.4800, 0.1600, 121.2600)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (208, 1, 2020, CAST(N'2020-04-10' AS Date), 2020, N'102035619', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), 0, 0, 2.1900, 0.1600, 112.6300)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (209, 1, 2020, CAST(N'2020-06-09' AS Date), 2020, N'102058068', CAST(N'2020-03-01' AS Date), CAST(N'2020-04-30' AS Date), 0, 0, 2.5800, 0.1600, 123.4800)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (210, 1, 2020, CAST(N'2020-08-14' AS Date), 2020, N'102081806', CAST(N'2020-05-01' AS Date), CAST(N'2020-06-30' AS Date), 0, 0, 2.1100, 0.1600, 111.5000)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (211, 1, 2020, CAST(N'2020-09-29' AS Date), 2020, N'102093513', CAST(N'2020-07-01' AS Date), CAST(N'2020-07-31' AS Date), 0, 0, 0.8400, 0.1600, 249.0800)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (212, 1, 2021, CAST(N'2021-02-19' AS Date), 2021, N'10022766', CAST(N'2020-08-01' AS Date), CAST(N'2020-12-31' AS Date), 0, 0, 6.2800, 0.1600, 304.4500)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (213, 1, 2021, CAST(N'2021-09-24' AS Date), 2021, N'10092352', CAST(N'2021-01-01' AS Date), CAST(N'2021-04-30' AS Date), 1954, 633, 0.6500, 0.1600, 73.8200)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (214, 1, 2022, CAST(N'2022-01-28' AS Date), 2022, N'1000885', CAST(N'2021-05-01' AS Date), CAST(N'2021-08-31' AS Date), 633, 0, 3.4100, 0.1600, 174.8900)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (215, 1, 2022, CAST(N'2022-05-20' AS Date), 2022, N'1047683', CAST(N'2021-09-01' AS Date), CAST(N'2021-12-31' AS Date), 5096, 0, 5.5500, 0.1600, 257.2100)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (216, 1, 2022, CAST(N'2022-07-08' AS Date), 2022, N'1071926', CAST(N'2022-01-01' AS Date), CAST(N'2022-04-30' AS Date), 5096, 3940, 0.6500, 0.1600, 73.8300)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (217, 1, 2022, CAST(N'2022-10-27' AS Date), 2022, N'1118126', CAST(N'2022-05-01' AS Date), CAST(N'2022-08-31' AS Date), 3940, 2592, 0.6700, 0.1600, 75.6500)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (218, 1, 2023, CAST(N'2023-03-17' AS Date), 2023, N'22750', CAST(N'2022-09-01' AS Date), CAST(N'2022-12-31' AS Date), 2592, 910, 0.6600, 0.1600, 75.1000)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (219, 1, 2023, CAST(N'2023-08-02' AS Date), 2023, N'1044418', CAST(N'2023-01-01' AS Date), CAST(N'2023-04-30' AS Date), 5489, 4115, 0.6500, 0.1600, 73.8200)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (221, 2, 2021, CAST(N'2021-02-11' AS Date), 2021, N'10009304', CAST(N'2020-11-01' AS Date), CAST(N'2020-12-31' AS Date), 0, 0, 1.1100, 0.1600, 82.1900)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (222, 2, 2021, CAST(N'2021-04-15' AS Date), 2021, N'10033266', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), 0, 0, 0.7000, 0.1600, 67.1300)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (223, 2, 2021, CAST(N'2021-06-15' AS Date), 2021, N'10055715', CAST(N'2021-03-01' AS Date), CAST(N'2021-04-30' AS Date), 0, 0, 0.5000, 0.1600, 61.9200)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (224, 2, 2021, CAST(N'2021-08-27' AS Date), 2021, N'10078178', CAST(N'2021-05-01' AS Date), CAST(N'2021-06-30' AS Date), 0, 0, 0.4200, 0.1600, 56.3200)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (225, 2, 2021, CAST(N'2021-10-19' AS Date), 2021, N'10102069', CAST(N'2021-07-01' AS Date), CAST(N'2021-08-31' AS Date), 0, 0, 0.6900, 0.1600, 69.1400)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (226, 2, 2021, CAST(N'2021-12-15' AS Date), 2021, N'10124453', CAST(N'2021-09-01' AS Date), CAST(N'2021-10-31' AS Date), 0, 0, 0.3300, 0.1600, 50.8300)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (227, 2, 2022, CAST(N'2022-02-11' AS Date), 2022, N'1010580', CAST(N'2021-11-01' AS Date), CAST(N'2021-12-31' AS Date), 0, 0, 0.5400, 0.1600, 63.2000)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (228, 2, 2022, CAST(N'2022-06-15' AS Date), 2022, N'1057277', CAST(N'2022-03-01' AS Date), CAST(N'2022-04-30' AS Date), 0, 0, 0.4600, 0.1600, 67.8900)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (229, 2, 2022, CAST(N'2022-08-12' AS Date), 2022, N'1081555', CAST(N'2022-05-01' AS Date), CAST(N'2022-06-30' AS Date), 0, 0, 0.3300, 0.1600, 56.6500)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (230, 2, 2022, CAST(N'2022-10-14' AS Date), 2022, N'1104011', CAST(N'2022-07-01' AS Date), CAST(N'2022-08-31' AS Date), 0, 0, 0.3400, 0.1600, 68.0700)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (231, 2, 2022, CAST(N'2022-12-15' AS Date), 2022, N'1128269', CAST(N'2022-09-01' AS Date), CAST(N'2022-10-31' AS Date), 0, 0, 0.3300, 0.1600, 62.8100)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (232, 2, 2023, CAST(N'2023-02-13' AS Date), 2023, N'7800', CAST(N'2022-11-01' AS Date), CAST(N'2022-12-31' AS Date), 0, 0, 0.3300, 0.1600, 97.1900)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (233, 2, 2023, CAST(N'2023-04-25' AS Date), 2023, N'1007077', CAST(N'2023-01-01' AS Date), CAST(N'2023-02-28' AS Date), 0, 0, 0.3200, 0.1600, 76.2100)
INSERT [dbo].[EEFattura] ([idEEFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [CredPrecKwh], [CredAttKwh], [addizFER], [impostaQuiet], [TotPagare]) VALUES (234, 2, 2023, CAST(N'2023-06-15' AS Date), 2023, N'1029302', CAST(N'2023-03-01' AS Date), CAST(N'2023-04-30' AS Date), 0, 0, 0.3300, 0.1600, 65.3100)
SET IDENTITY_INSERT [dbo].[EEFattura] OFF
SET IDENTITY_INSERT [dbo].[EELettura] ON 

INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (420, 182, CAST(N'2019-06-30' AS Date), 23425, N'real', CAST(N'2019-07-31' AS Date), 23452, 27)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (421, 182, CAST(N'2019-07-31' AS Date), 23452, N'real', CAST(N'2019-08-31' AS Date), 23462, 10)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (422, 183, CAST(N'2019-08-31' AS Date), 23462, N'real', CAST(N'2019-09-30' AS Date), 23501, 39)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (423, 183, CAST(N'2019-09-30' AS Date), 23501, N'real', CAST(N'2019-10-31' AS Date), 23604, 103)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (424, 184, CAST(N'2019-10-31' AS Date), 23604, N'real', CAST(N'2019-11-30' AS Date), 23840, 236)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (425, 184, CAST(N'2019-11-30' AS Date), 23840, N'real', CAST(N'2019-12-31' AS Date), 24249, 409)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (458, 201, CAST(N'2022-06-30' AS Date), 33064, N'real', CAST(N'2023-03-31' AS Date), 35506, 2442)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (459, 201, CAST(N'2023-03-31' AS Date), 35506, N'real', CAST(N'2023-04-26' AS Date), 35784, 278)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (460, 201, CAST(N'2023-04-26' AS Date), 35784, N'real', CAST(N'2023-04-30' AS Date), 35824, 40)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (461, 202, CAST(N'2022-08-31' AS Date), 0, N'stim', CAST(N'2022-09-30' AS Date), 0, 116)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (462, 202, CAST(N'2022-09-30' AS Date), 0, N'stim', CAST(N'2022-10-31' AS Date), 0, 146)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (463, 203, CAST(N'2022-10-31' AS Date), 0, N'stim', CAST(N'2022-11-30' AS Date), 0, 293)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (464, 203, CAST(N'2022-11-30' AS Date), 0, N'stim', CAST(N'2022-12-31' AS Date), 0, 343)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (465, 204, CAST(N'2022-12-31' AS Date), 0, N'stim', CAST(N'2023-01-31' AS Date), 0, 267)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (466, 204, CAST(N'2023-01-31' AS Date), 0, N'stim', CAST(N'2023-02-28' AS Date), 0, 266)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (467, 205, CAST(N'2023-04-30' AS Date), 35824, N'real', CAST(N'2023-05-31' AS Date), 36139, 315)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (468, 205, CAST(N'2023-05-31' AS Date), 36139, N'real', CAST(N'2023-06-30' AS Date), 36281, 142)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (469, 206, CAST(N'2019-08-31' AS Date), 18952, N'real', CAST(N'2019-09-30' AS Date), 19221, 269)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (470, 206, CAST(N'2019-09-30' AS Date), 19221, N'real', CAST(N'2019-10-31' AS Date), 19490, 269)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (471, 207, CAST(N'2019-10-31' AS Date), 19490, N'real', CAST(N'2019-11-30' AS Date), 19772, 282)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (472, 207, CAST(N'2019-11-30' AS Date), 19772, N'real', CAST(N'2019-12-31' AS Date), 20089, 317)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (473, 208, CAST(N'2019-12-31' AS Date), 20089, N'real', CAST(N'2020-01-31' AS Date), 20382, 293)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (474, 208, CAST(N'2020-01-31' AS Date), 20382, N'real', CAST(N'2020-02-29' AS Date), 20644, 262)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (475, 209, CAST(N'2020-02-29' AS Date), 20644, N'real', CAST(N'2020-03-31' AS Date), 20958, 314)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (476, 209, CAST(N'2020-03-31' AS Date), 20958, N'real', CAST(N'2020-04-30' AS Date), 21254, 296)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (477, 210, CAST(N'2020-04-30' AS Date), 21254, N'real', CAST(N'2020-05-31' AS Date), 21541, 287)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (478, 210, CAST(N'2020-05-31' AS Date), 21541, N'real', CAST(N'2020-06-30' AS Date), 21803, 262)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (479, 211, CAST(N'2020-06-30' AS Date), 21803, N'real', CAST(N'2020-07-24' AS Date), 21998, 195)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (480, 211, CAST(N'2020-07-24' AS Date), 21998, N'real', CAST(N'2020-07-31' AS Date), 22053, 55)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (481, 212, CAST(N'2020-07-31' AS Date), 22053, N'real', CAST(N'2020-08-31' AS Date), 22376, 323)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (482, 212, CAST(N'2020-08-31' AS Date), 22376, N'real', CAST(N'2020-09-30' AS Date), 22636, 260)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (483, 212, CAST(N'2020-09-30' AS Date), 22636, N'real', CAST(N'2020-10-31' AS Date), 22910, 274)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (484, 212, CAST(N'2020-10-31' AS Date), 22910, N'real', CAST(N'2020-11-30' AS Date), 23217, 307)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (485, 212, CAST(N'2020-11-30' AS Date), 23217, N'real', CAST(N'2020-12-31' AS Date), 23558, 341)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (486, 213, CAST(N'2020-12-31' AS Date), 23558, N'real', CAST(N'2021-01-31' AS Date), 23927, 369)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (487, 213, CAST(N'2021-01-31' AS Date), 23927, N'real', CAST(N'2021-02-28' AS Date), 24245, 318)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (488, 213, CAST(N'2021-02-28' AS Date), 24245, N'real', CAST(N'2021-03-31' AS Date), 24571, 326)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (489, 213, CAST(N'2021-03-31' AS Date), 24571, N'real', CAST(N'2021-04-30' AS Date), 24879, 308)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (490, 214, CAST(N'2021-04-30' AS Date), 24879, N'real', CAST(N'2021-05-31' AS Date), 25173, 294)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (491, 214, CAST(N'2021-05-31' AS Date), 25173, N'real', CAST(N'2021-06-30' AS Date), 25477, 304)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (492, 214, CAST(N'2021-06-30' AS Date), 25477, N'real', CAST(N'2021-07-31' AS Date), 25831, 354)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (493, 214, CAST(N'2021-07-31' AS Date), 25831, N'real', CAST(N'2021-08-31' AS Date), 26192, 361)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (494, 215, CAST(N'2021-08-31' AS Date), 26192, N'real', CAST(N'2021-09-30' AS Date), 26491, 299)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (495, 215, CAST(N'2021-09-30' AS Date), 26491, N'real', CAST(N'2021-10-31' AS Date), 26807, 316)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (496, 215, CAST(N'2021-10-31' AS Date), 26807, N'real', CAST(N'2021-11-30' AS Date), 27132, 325)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (497, 215, CAST(N'2021-11-30' AS Date), 27132, N'real', CAST(N'2021-12-31' AS Date), 27464, 332)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (498, 216, CAST(N'2021-12-31' AS Date), 27464, N'real', CAST(N'2022-01-31' AS Date), 27789, 325)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (499, 216, CAST(N'2022-01-31' AS Date), 27789, N'real', CAST(N'2022-02-28' AS Date), 28090, 301)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (500, 216, CAST(N'2022-02-28' AS Date), 28090, N'real', CAST(N'2022-03-31' AS Date), 28390, 300)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (501, 216, CAST(N'2022-03-31' AS Date), 28390, N'real', CAST(N'2022-04-30' AS Date), 28620, 230)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (502, 217, CAST(N'2022-04-30' AS Date), 28620, N'real', CAST(N'2022-05-31' AS Date), 28931, 311)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (503, 217, CAST(N'2022-05-31' AS Date), 28931, N'real', CAST(N'2022-06-30' AS Date), 29234, 303)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (504, 217, CAST(N'2022-06-30' AS Date), 29234, N'real', CAST(N'2022-07-31' AS Date), 29611, 377)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (505, 217, CAST(N'2022-07-31' AS Date), 29611, N'real', CAST(N'2022-08-31' AS Date), 29968, 357)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (506, 218, CAST(N'2022-08-31' AS Date), 29968, N'real', CAST(N'2022-09-30' AS Date), 30254, 286)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (507, 218, CAST(N'2022-09-30' AS Date), 30254, N'real', CAST(N'2022-10-31' AS Date), 30579, 325)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (508, 218, CAST(N'2022-10-31' AS Date), 30579, N'real', CAST(N'2022-11-30' AS Date), 31228, 649)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (509, 218, CAST(N'2022-11-30' AS Date), 31228, N'real', CAST(N'2022-12-31' AS Date), 31650, 422)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (510, 219, CAST(N'2022-12-31' AS Date), 31650, N'real', CAST(N'2023-01-31' AS Date), 32039, 389)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (511, 219, CAST(N'2023-01-31' AS Date), 32039, N'real', CAST(N'2023-02-28' AS Date), 32384, 345)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (512, 219, CAST(N'2023-02-28' AS Date), 32384, N'real', CAST(N'2023-03-31' AS Date), 32721, 337)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (513, 219, CAST(N'2023-03-31' AS Date), 32721, N'real', CAST(N'2023-04-30' AS Date), 33024, 303)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (515, 221, CAST(N'2020-10-31' AS Date), 29286, N'real', CAST(N'2020-11-30' AS Date), 29491, 205)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (516, 221, CAST(N'2020-11-30' AS Date), 29491, N'real', CAST(N'2020-12-31' AS Date), 29707, 216)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (517, 222, CAST(N'2020-12-31' AS Date), 29707, N'real', CAST(N'2021-01-31' AS Date), 29906, 199)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (518, 222, CAST(N'2021-01-31' AS Date), 29906, N'real', CAST(N'2021-02-28' AS Date), 30066, 160)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (519, 223, CAST(N'2021-02-28' AS Date), 30066, N'real', CAST(N'2021-03-31' AS Date), 30252, 186)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (520, 223, CAST(N'2021-03-31' AS Date), 30252, N'real', CAST(N'2021-04-30' AS Date), 30407, 155)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (521, 224, CAST(N'2021-04-30' AS Date), 30407, N'real', CAST(N'2021-05-31' AS Date), 30550, 143)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (522, 224, CAST(N'2021-05-31' AS Date), 30550, N'real', CAST(N'2021-06-30' AS Date), 30719, 169)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (523, 225, CAST(N'2021-06-30' AS Date), 30719, N'real', CAST(N'2021-07-31' AS Date), 30899, 180)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (524, 225, CAST(N'2021-07-31' AS Date), 30899, N'real', CAST(N'2021-08-31' AS Date), 31091, 192)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (525, 226, CAST(N'2021-08-31' AS Date), 31091, N'real', CAST(N'2021-09-30' AS Date), 31219, 128)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (526, 226, CAST(N'2021-09-30' AS Date), 31219, N'real', CAST(N'2021-10-31' AS Date), 31374, 155)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (527, 227, CAST(N'2021-10-31' AS Date), 31374, N'real', CAST(N'2021-11-30' AS Date), 31529, 155)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (528, 227, CAST(N'2021-11-30' AS Date), 31529, N'real', CAST(N'2021-12-31' AS Date), 31720, 191)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (529, 228, CAST(N'2022-02-28' AS Date), 32085, N'real', CAST(N'2022-03-31' AS Date), 32261, 176)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (530, 228, CAST(N'2022-03-31' AS Date), 32261, N'real', CAST(N'2022-04-30' AS Date), 32419, 158)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (531, 229, CAST(N'2022-04-30' AS Date), 32419, N'real', CAST(N'2022-05-31' AS Date), 32556, 137)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (532, 229, CAST(N'2022-05-31' AS Date), 32556, N'real', CAST(N'2022-06-30' AS Date), 32699, 143)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (533, 230, CAST(N'2022-06-30' AS Date), 32699, N'real', CAST(N'2022-07-31' AS Date), 32880, 181)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (534, 230, CAST(N'2022-07-31' AS Date), 32880, N'real', CAST(N'2022-08-31' AS Date), 33045, 165)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (535, 231, CAST(N'2022-08-31' AS Date), 33045, N'real', CAST(N'2022-09-30' AS Date), 33183, 138)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (536, 231, CAST(N'2022-09-30' AS Date), 33183, N'real', CAST(N'2022-10-31' AS Date), 33364, 181)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (537, 232, CAST(N'2022-10-31' AS Date), 33364, N'real', CAST(N'2022-11-30' AS Date), 33525, 161)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (538, 232, CAST(N'2022-11-30' AS Date), 33525, N'real', CAST(N'2022-12-31' AS Date), 33695, 170)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (539, 233, CAST(N'2022-12-31' AS Date), 33695, N'real', CAST(N'2023-01-31' AS Date), 33865, 170)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (540, 233, CAST(N'2023-01-31' AS Date), 33865, N'real', CAST(N'2023-02-28' AS Date), 34024, 159)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (541, 234, CAST(N'2023-02-28' AS Date), 34024, N'real', CAST(N'2023-03-31' AS Date), 34180, 156)
INSERT [dbo].[EELettura] ([idLettura], [idEEFattura], [LettDtPrec], [LettPrec], [TipoLettura], [LettDtAttuale], [LettAttuale], [LettConsumo]) VALUES (542, 234, CAST(N'2023-03-31' AS Date), 34180, N'real', CAST(N'2023-04-30' AS Date), 34325, 145)
SET IDENTITY_INSERT [dbo].[EELettura] OFF
SET IDENTITY_INSERT [dbo].[GASConsumo] ON 

INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (811, 203, N'G1', CAST(N'2019-05-18' AS Date), CAST(N'2019-12-13' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(293.00 AS Decimal(8, 2)), 137.7300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (812, 203, N'G2', CAST(N'2019-05-18' AS Date), CAST(N'2019-12-13' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 18.7000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (813, 204, N'G1', CAST(N'2019-12-14' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.7500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (814, 204, N'G2', CAST(N'2019-12-14' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(44.00 AS Decimal(8, 2)), 21.0900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (815, 204, N'G3', CAST(N'2019-12-14' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.8000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (816, 204, N'G1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-18' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(68.00 AS Decimal(8, 2)), 31.9600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (817, 204, N'G2', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-18' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(119.00 AS Decimal(8, 2)), 57.0500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (818, 204, N'G3', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-18' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 24.4400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (819, 208, N'G1', CAST(N'2020-05-21' AS Date), CAST(N'2020-12-15' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(225.00 AS Decimal(8, 2)), 105.7600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (820, 209, N'G1', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 10.3400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (821, 209, N'G2', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 18.7000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (822, 209, N'G3', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 15.6400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (823, 209, N'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 34.7800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (824, 209, N'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(129.00 AS Decimal(8, 2)), 61.8400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (825, 209, N'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(106.00 AS Decimal(8, 2)), 51.8100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (826, 210, N'G1', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 33.3700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (827, 210, N'G2', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(99.00 AS Decimal(8, 2)), 47.4600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (828, 212, N'G1', CAST(N'2021-04-15' AS Date), CAST(N'2021-12-13' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(307.00 AS Decimal(8, 2)), 144.3100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (829, 213, N'G1', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.7500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (830, 213, N'G2', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(44.00 AS Decimal(8, 2)), 21.0900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (831, 213, N'G3', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 15.1500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (832, 213, N'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 45.2200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (833, 213, N'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(129.00 AS Decimal(8, 2)), 80.3900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (834, 213, N'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(91.00 AS Decimal(8, 2)), 57.8200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (835, 214, N'G1', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(82.00 AS Decimal(8, 2)), 50.1100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (836, 214, N'G2', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(126.00 AS Decimal(8, 2)), 78.5200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (837, 215, N'G1', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.0000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (838, 215, N'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 14.3000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (839, 216, N'G1', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(45.00 AS Decimal(8, 2)), 35.7500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (840, 217, N'G2', CAST(N'2022-10-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(65.00 AS Decimal(8, 2)), 52.6600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (841, 218, N'G1', CAST(N'2022-04-23' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(37.00 AS Decimal(8, 2)), 22.6100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (842, 218, N'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-12-02' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(83.00 AS Decimal(8, 2)), 65.9400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (843, 218, N'G3', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(40.00 AS Decimal(8, 2)), 33.0400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (844, 219, N'G2', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(121.00 AS Decimal(8, 2)), 98.0300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (845, 220, N'G1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 30.9800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (846, 220, N'G2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 22.6800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (847, 220, N'G1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 34.1600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (848, 220, N'G2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 25.1100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (849, 220, N'G1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.1500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (850, 220, N'G2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 13.4300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (851, 220, N'G1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.1900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (852, 220, N'G2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.4600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (853, 220, N'G1', CAST(N'2023-05-05' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.1900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (854, 220, N'G1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.354598 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 2.4800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (855, 221, N'G1', CAST(N'2019-10-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (856, 221, N'G2', CAST(N'2019-10-01' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 65.6700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (857, 222, N'G1', CAST(N'2019-05-23' AS Date), CAST(N'2019-12-18' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(293.00 AS Decimal(8, 2)), 137.7300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (858, 222, N'G2', CAST(N'2019-05-23' AS Date), CAST(N'2019-12-18' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 6.7100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (859, 222, N'G1', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.4600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (860, 222, N'G2', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 15.3400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (861, 222, N'G3', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(49.00 AS Decimal(8, 2)), 23.9500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (862, 222, N'G1', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 20.2100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (863, 222, N'G2', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(75.00 AS Decimal(8, 2)), 35.9500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (864, 222, N'G3', CAST(N'2020-01-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(117.00 AS Decimal(8, 2)), 57.1900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (865, 223, N'G1', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.4600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (866, 223, N'G2', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 15.3400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (867, 223, N'G3', CAST(N'2019-12-19' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(35.00 AS Decimal(8, 2)), 17.1100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (868, 223, N'G1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-24' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(77.00 AS Decimal(8, 2)), 36.2000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (869, 223, N'G2', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-24' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(134.00 AS Decimal(8, 2)), 64.2400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (870, 223, N'G3', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-24' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(151.00 AS Decimal(8, 2)), 73.8000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (871, 223, N'G1', CAST(N'2020-02-25' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 23.5000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (872, 223, N'G2', CAST(N'2020-02-25' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(88.00 AS Decimal(8, 2)), 42.1800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (873, 223, N'G3', CAST(N'2020-02-25' AS Date), CAST(N'2020-03-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(53.00 AS Decimal(8, 2)), 25.9000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (874, 224, N'G1', CAST(N'2020-02-25' AS Date), CAST(N'2020-05-21' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(121.00 AS Decimal(8, 2)), 56.8800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (875, 224, N'G2', CAST(N'2020-02-25' AS Date), CAST(N'2020-05-21' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(138.00 AS Decimal(8, 2)), 66.1500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (876, 224, N'G1', CAST(N'2020-05-22' AS Date), CAST(N'2020-05-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 6.1100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (877, 225, N'G1', CAST(N'2020-06-01' AS Date), CAST(N'2020-07-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(52.00 AS Decimal(8, 2)), 24.4400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (878, 226, N'G1', CAST(N'2020-08-01' AS Date), CAST(N'2020-09-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(65.00 AS Decimal(8, 2)), 30.5500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (879, 227, N'G1', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (880, 227, N'G2', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 65.6700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (881, 228, N'G1', CAST(N'2020-05-22' AS Date), CAST(N'2020-12-21' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(298.00 AS Decimal(8, 2)), 140.0800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (882, 228, N'G2', CAST(N'2020-05-22' AS Date), CAST(N'2020-12-21' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(77.00 AS Decimal(8, 2)), 36.9100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (883, 228, N'G1', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 6.5800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (884, 228, N'G2', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(24.00 AS Decimal(8, 2)), 11.5000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (885, 228, N'G3', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(38.00 AS Decimal(8, 2)), 18.5700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (886, 228, N'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 20.2100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (887, 228, N'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 36.4300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (888, 228, N'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(116.00 AS Decimal(8, 2)), 56.7000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (889, 229, N'G1', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 6.5800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (890, 229, N'G2', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(24.00 AS Decimal(8, 2)), 11.5000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (891, 229, N'G3', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.5300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (892, 229, N'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-19' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(70.00 AS Decimal(8, 2)), 32.9000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (893, 229, N'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-19' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 58.4800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (894, 229, N'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-19' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(208.00 AS Decimal(8, 2)), 101.6600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (895, 229, N'G1', CAST(N'2021-02-20' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(56.00 AS Decimal(8, 2)), 26.3200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (896, 229, N'G2', CAST(N'2021-02-20' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(98.00 AS Decimal(8, 2)), 46.9800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (897, 229, N'G3', CAST(N'2021-02-20' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 32.2600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (898, 230, N'G1', CAST(N'2021-02-20' AS Date), CAST(N'2021-04-08' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(67.00 AS Decimal(8, 2)), 31.4900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (899, 230, N'G2', CAST(N'2021-02-20' AS Date), CAST(N'2021-04-08' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(117.00 AS Decimal(8, 2)), 56.0900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (900, 230, N'G3', CAST(N'2021-02-20' AS Date), CAST(N'2021-04-08' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 15.1500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (901, 230, N'G1', CAST(N'2021-04-09' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 34.7800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (902, 230, N'G2', CAST(N'2021-04-09' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.1300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (903, 231, N'G1', CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(52.00 AS Decimal(8, 2)), 24.4400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (904, 232, N'G1', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(65.00 AS Decimal(8, 2)), 30.5500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (905, 233, N'G1', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (906, 233, N'G2', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 65.6700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (907, 234, N'G1', CAST(N'2021-04-09' AS Date), CAST(N'2021-12-17' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(354.00 AS Decimal(8, 2)), 166.4000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (908, 234, N'G2', CAST(N'2021-04-09' AS Date), CAST(N'2021-12-17' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(91.00 AS Decimal(8, 2)), 43.6200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (909, 234, N'G1', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 9.4000)
GO
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (910, 234, N'G2', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 16.3000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (911, 234, N'G3', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(53.00 AS Decimal(8, 2)), 25.9000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (912, 234, N'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 26.2800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (913, 234, N'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 47.3600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (914, 234, N'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(116.00 AS Decimal(8, 2)), 73.7100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (915, 235, N'G1', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 9.4000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (916, 235, N'G2', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 16.3000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (917, 235, N'G3', CAST(N'2021-12-18' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(54.00 AS Decimal(8, 2)), 26.3900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (918, 235, N'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-16' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 40.3300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (919, 235, N'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-16' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(115.00 AS Decimal(8, 2)), 71.6700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (920, 235, N'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-16' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(180.00 AS Decimal(8, 2)), 114.3700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (921, 235, N'G1', CAST(N'2022-02-17' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(60.00 AS Decimal(8, 2)), 36.6700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (922, 235, N'G2', CAST(N'2022-02-17' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(105.00 AS Decimal(8, 2)), 65.4300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (923, 235, N'G3', CAST(N'2022-02-17' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 48.2900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (924, 236, N'G1', CAST(N'2022-02-17' AS Date), CAST(N'2022-04-28' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(99.00 AS Decimal(8, 2)), 60.5000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (925, 236, N'G2', CAST(N'2022-02-17' AS Date), CAST(N'2022-04-28' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(173.00 AS Decimal(8, 2)), 107.8100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (926, 236, N'G3', CAST(N'2022-02-17' AS Date), CAST(N'2022-04-28' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.4500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (927, 236, N'G1', CAST(N'2022-04-29' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(46.00 AS Decimal(8, 2)), 28.1100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (928, 237, N'G1', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(23.00 AS Decimal(8, 2)), 14.0500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (929, 237, N'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(23.00 AS Decimal(8, 2)), 18.2700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (930, 238, N'G1', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(58.00 AS Decimal(8, 2)), 46.0800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (931, 239, N'G1', CAST(N'2022-04-29' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 17.1100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (932, 239, N'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-11-23' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(65.00 AS Decimal(8, 2)), 51.6400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (933, 239, N'G3', CAST(N'2022-11-24' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 4.9600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (934, 240, N'G1', CAST(N'2022-11-24' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(53.00 AS Decimal(8, 2)), 42.1000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (935, 240, N'G2', CAST(N'2022-11-24' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(93.00 AS Decimal(8, 2)), 75.3400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (936, 240, N'G3', CAST(N'2022-11-24' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(46.00 AS Decimal(8, 2)), 38.0000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (937, 240, N'G1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-26' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(36.00 AS Decimal(8, 2)), 28.6000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (938, 240, N'G2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-26' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(63.00 AS Decimal(8, 2)), 51.0400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (939, 240, N'G3', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-26' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 26.4300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (940, 240, N'G3', CAST(N'2023-01-27' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.1300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (941, 241, N'G1', CAST(N'2023-01-27' AS Date), CAST(N'2023-03-23' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(78.00 AS Decimal(8, 2)), 61.9600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (942, 241, N'G2', CAST(N'2023-01-27' AS Date), CAST(N'2023-03-23' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(137.00 AS Decimal(8, 2)), 110.9900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (943, 241, N'G3', CAST(N'2023-01-27' AS Date), CAST(N'2023-03-23' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 12.3900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (944, 241, N'G2', CAST(N'2023-03-24' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 14.5800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (945, 242, N'G1', CAST(N'2023-03-24' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 8.7400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (946, 242, N'G2', CAST(N'2023-03-24' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.8100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (947, 242, N'G1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.1500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (948, 242, N'G2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.4800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (949, 242, N'G1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-03' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.4600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (950, 242, N'G1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.354598 AS Decimal(10, 6)), CAST(23.00 AS Decimal(8, 2)), 8.1600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1038, 261, N'G1', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1039, 261, N'G2', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(128.00 AS Decimal(8, 2)), 61.3600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1040, 262, N'G1', CAST(N'2020-05-21' AS Date), CAST(N'2020-12-15' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(291.00 AS Decimal(8, 2)), 136.7900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1041, 262, N'G2', CAST(N'2020-05-21' AS Date), CAST(N'2020-12-15' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(102.00 AS Decimal(8, 2)), 48.9000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1042, 262, N'G1', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 10.3400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1043, 262, N'G2', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 18.7000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1044, 262, N'G3', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(54.00 AS Decimal(8, 2)), 26.3900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1045, 262, N'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 20.2100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1046, 262, N'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 36.4300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1047, 262, N'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(106.00 AS Decimal(8, 2)), 51.8100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1048, 263, N'G1', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 10.3400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1049, 263, N'G2', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 18.7000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1050, 263, N'G3', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 34.7000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1051, 263, N'G1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 34.7800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1052, 263, N'G2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(129.00 AS Decimal(8, 2)), 61.8400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1053, 263, N'G3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-22' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(234.00 AS Decimal(8, 2)), 114.3700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1054, 263, N'G1', CAST(N'2021-02-23' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(52.00 AS Decimal(8, 2)), 24.4400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1055, 263, N'G2', CAST(N'2021-02-23' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 43.1400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1056, 263, N'G3', CAST(N'2021-02-23' AS Date), CAST(N'2021-03-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(48.00 AS Decimal(8, 2)), 23.4600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1057, 264, N'G1', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 33.3700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1058, 264, N'G2', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(124.00 AS Decimal(8, 2)), 59.4400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1059, 264, N'G3', CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(71.00 AS Decimal(8, 2)), 34.7000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1060, 264, N'G1', CAST(N'2021-04-15' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 31.0200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1061, 264, N'G2', CAST(N'2021-04-15' AS Date), CAST(N'2021-05-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.9800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1062, 265, N'G1', CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 23.5000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1063, 266, N'G1', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(63.00 AS Decimal(8, 2)), 29.6100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1064, 267, N'G1', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(85.00 AS Decimal(8, 2)), 39.9600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1065, 267, N'G2', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(128.00 AS Decimal(8, 2)), 61.3600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1066, 268, N'G1', CAST(N'2021-04-15' AS Date), CAST(N'2021-12-13' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(340.00 AS Decimal(8, 2)), 159.8200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1067, 268, N'G2', CAST(N'2021-04-15' AS Date), CAST(N'2021-12-13' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(231.00 AS Decimal(8, 2)), 110.7400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1068, 268, N'G1', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.7500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1069, 268, N'G2', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(44.00 AS Decimal(8, 2)), 21.0900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1070, 268, N'G3', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(60.00 AS Decimal(8, 2)), 29.3300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1071, 268, N'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 26.2800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1072, 268, N'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 47.3600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1073, 268, N'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(106.00 AS Decimal(8, 2)), 67.3500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1074, 269, N'G1', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.470065 AS Decimal(10, 6)), CAST(25.00 AS Decimal(8, 2)), 11.7500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1075, 269, N'G2', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.479373 AS Decimal(10, 6)), CAST(44.00 AS Decimal(8, 2)), 21.0900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1076, 269, N'G3', CAST(N'2021-12-14' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.488772 AS Decimal(10, 6)), CAST(97.00 AS Decimal(8, 2)), 47.4100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1077, 269, N'G1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(74.00 AS Decimal(8, 2)), 45.2200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1078, 269, N'G2', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(129.00 AS Decimal(8, 2)), 80.3900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1079, 269, N'G3', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-22' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(287.00 AS Decimal(8, 2)), 182.3600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1080, 269, N'G1', CAST(N'2022-02-23' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(52.00 AS Decimal(8, 2)), 31.7800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1081, 269, N'G2', CAST(N'2022-02-23' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 56.0900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1082, 269, N'G3', CAST(N'2022-02-23' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(48.00 AS Decimal(8, 2)), 30.5000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1083, 270, N'G1', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(82.00 AS Decimal(8, 2)), 50.1100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1084, 270, N'G2', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(144.00 AS Decimal(8, 2)), 89.7400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1085, 270, N'G3', CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), CAST(0.635404 AS Decimal(10, 6)), CAST(205.00 AS Decimal(8, 2)), 130.2600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1086, 270, N'G1', CAST(N'2022-04-23' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(54.00 AS Decimal(8, 2)), 33.0000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1087, 270, N'G2', CAST(N'2022-04-23' AS Date), CAST(N'2022-05-31' AS Date), CAST(0.623185 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 6.8600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1088, 271, N'G1', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 17.7200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1089, 271, N'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 23.0400)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1090, 272, N'G1', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(72.00 AS Decimal(8, 2)), 57.2000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1091, 273, N'G1', CAST(N'2022-04-23' AS Date), CAST(N'2022-06-30' AS Date), CAST(0.611085 AS Decimal(10, 6)), CAST(50.00 AS Decimal(8, 2)), 30.5500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1092, 273, N'G1', CAST(N'2022-07-01' AS Date), CAST(N'2022-11-14' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(99.00 AS Decimal(8, 2)), 78.6500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1093, 273, N'G3', CAST(N'2022-11-15' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 25.6100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1094, 274, N'G1', CAST(N'2022-11-15' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(66.00 AS Decimal(8, 2)), 52.4300)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1095, 274, N'G2', CAST(N'2022-11-15' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(115.00 AS Decimal(8, 2)), 93.1700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1096, 274, N'G3', CAST(N'2022-11-15' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(150.00 AS Decimal(8, 2)), 123.9000)
GO
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1097, 274, N'G1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 34.1600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1098, 274, N'G2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 61.5700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1099, 274, N'G3', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(99.00 AS Decimal(8, 2)), 81.7800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1100, 275, N'G3', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(152.00 AS Decimal(8, 2)), 125.5600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1101, 276, N'G1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(39.00 AS Decimal(8, 2)), 30.9800)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1102, 276, N'G2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(68.00 AS Decimal(8, 2)), 55.0900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1103, 276, N'G3', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(38.00 AS Decimal(8, 2)), 31.3900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1104, 276, N'G1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.794410 AS Decimal(10, 6)), CAST(43.00 AS Decimal(8, 2)), 34.1600)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1105, 276, N'G2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.810140 AS Decimal(10, 6)), CAST(76.00 AS Decimal(8, 2)), 61.5700)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1106, 276, N'G3', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.826025 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 34.6900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1107, 276, N'G1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(42.00 AS Decimal(8, 2)), 20.1500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1108, 276, N'G2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(73.00 AS Decimal(8, 2)), 35.0200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1109, 276, N'G3', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.479694 AS Decimal(10, 6)), CAST(40.00 AS Decimal(8, 2)), 19.1900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1110, 276, N'G1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.1900)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1111, 276, N'G2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 3.6500)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1112, 276, N'G3', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-04' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 1.8200)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1113, 276, N'G1', CAST(N'2023-05-05' AS Date), CAST(N'2023-05-15' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 5.1000)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1114, 276, N'G1', CAST(N'2023-05-16' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.364547 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 4.0100)
INSERT [dbo].[GASConsumo] ([idConsumo], [idGASFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1115, 276, N'G1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.354598 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 7.0900)
SET IDENTITY_INSERT [dbo].[GASConsumo] OFF
SET IDENTITY_INSERT [dbo].[GASFattura] ON 

INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (201, 3, 2019, CAST(N'2019-11-14' AS Date), 2019, N'10107788', CAST(N'2019-08-01' AS Date), CAST(N'2019-09-30' AS Date), NULL, CAST(N'2019-09-30' AS Date), NULL, NULL, CAST(N'2019-08-01' AS Date), NULL, NULL, 0.0700, 0.3600, 0.0000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (202, 3, 2020, CAST(N'2020-01-15' AS Date), 2020, N'120015400', CAST(N'2019-10-01' AS Date), CAST(N'2019-11-30' AS Date), NULL, CAST(N'2019-11-30' AS Date), NULL, NULL, CAST(N'2019-10-01' AS Date), NULL, NULL, 0.0700, 0.3600, 5.5100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (203, 3, 2020, CAST(N'2020-03-13' AS Date), 2020, N'120025438', CAST(N'2019-12-01' AS Date), CAST(N'2020-01-31' AS Date), NULL, CAST(N'2020-01-31' AS Date), NULL, NULL, CAST(N'2019-12-14' AS Date), NULL, NULL, 6.4800, 0.3600, 164.7900)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (204, 3, 2020, CAST(N'2020-05-16' AS Date), 2020, N'120051904', CAST(N'2020-02-01' AS Date), CAST(N'2020-03-31' AS Date), NULL, CAST(N'2020-03-31' AS Date), NULL, NULL, CAST(N'2020-02-19' AS Date), NULL, NULL, 6.4200, 0.3600, 163.3300)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (205, 3, 2020, CAST(N'2020-09-09' AS Date), 2020, N'120088801', CAST(N'2020-06-01' AS Date), CAST(N'2020-07-31' AS Date), NULL, CAST(N'2020-07-31' AS Date), NULL, NULL, CAST(N'2020-06-01' AS Date), NULL, NULL, 0.0700, 0.3600, 0.0000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (206, 3, 2020, CAST(N'2020-11-13' AS Date), 2020, N'120107222', CAST(N'2020-08-01' AS Date), CAST(N'2020-09-30' AS Date), NULL, CAST(N'2020-09-30' AS Date), NULL, NULL, CAST(N'2020-08-01' AS Date), NULL, NULL, 0.0700, 0.3600, 0.0000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (207, 3, 2021, CAST(N'2021-01-14' AS Date), 2021, N'12015014', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), NULL, CAST(N'2020-11-30' AS Date), NULL, NULL, CAST(N'2020-10-01' AS Date), NULL, NULL, 0.0700, 0.3600, 5.0100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (208, 3, 2021, CAST(N'2021-03-15' AS Date), 2021, N'12025158', CAST(N'2020-12-01' AS Date), CAST(N'2021-01-31' AS Date), NULL, CAST(N'2021-01-31' AS Date), NULL, NULL, CAST(N'2020-12-16' AS Date), NULL, NULL, 4.4000, 0.3600, 111.9600)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (209, 3, 2021, CAST(N'2021-05-13' AS Date), 2021, N'12043637', CAST(N'2021-02-01' AS Date), CAST(N'2021-03-31' AS Date), NULL, CAST(N'2021-03-31' AS Date), NULL, NULL, CAST(N'2021-02-23' AS Date), NULL, NULL, 7.9800, 0.3600, 202.9400)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (210, 3, 2021, CAST(N'2021-07-29' AS Date), 2021, N'12070438', CAST(N'2021-04-01' AS Date), CAST(N'2021-05-31' AS Date), NULL, CAST(N'2021-05-31' AS Date), NULL, NULL, CAST(N'2021-04-15' AS Date), NULL, NULL, 3.3800, 0.3600, 85.8100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (211, 3, 2021, CAST(N'2021-11-15' AS Date), 2021, N'12107174', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), NULL, CAST(N'2021-09-30' AS Date), NULL, NULL, CAST(N'2021-08-01' AS Date), NULL, NULL, 0.0700, 0.3600, 0.0000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (212, 3, 2022, CAST(N'2022-03-16' AS Date), 2022, N'1233693', CAST(N'2021-12-01' AS Date), CAST(N'2022-01-31' AS Date), NULL, CAST(N'2022-01-31' AS Date), NULL, NULL, CAST(N'2021-12-14' AS Date), NULL, NULL, 5.9800, 0.3600, 152.1500)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (213, 3, 2022, CAST(N'2022-05-16' AS Date), 2022, N'1252325', CAST(N'2022-02-01' AS Date), CAST(N'2022-03-31' AS Date), NULL, CAST(N'2022-03-31' AS Date), NULL, NULL, CAST(N'2022-02-23' AS Date), NULL, NULL, 9.5500, 0.3600, 242.8800)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (214, 3, 2022, CAST(N'2022-07-12' AS Date), 2022, N'1262434', CAST(N'2022-04-01' AS Date), CAST(N'2022-05-31' AS Date), NULL, CAST(N'2022-05-31' AS Date), NULL, NULL, CAST(N'2022-04-23' AS Date), NULL, NULL, 5.3400, 0.3600, 135.7700)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (215, 3, 2022, CAST(N'2022-09-14' AS Date), 2022, N'1281022', CAST(N'2022-06-01' AS Date), CAST(N'2022-07-31' AS Date), NULL, CAST(N'2022-07-31' AS Date), NULL, NULL, CAST(N'2022-06-01' AS Date), NULL, NULL, 1.1000, 0.3600, 28.0000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (216, 3, 2022, CAST(N'2022-11-14' AS Date), 2022, N'1299503', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), NULL, CAST(N'2022-09-30' AS Date), NULL, NULL, CAST(N'2022-08-01' AS Date), NULL, NULL, 1.5300, 0.3600, 38.8800)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (217, 3, 2023, CAST(N'2023-01-13' AS Date), 2023, N'6499', CAST(N'2022-10-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-11-30' AS Date), NULL, NULL, NULL, NULL, NULL, 4.9900, 0.3600, 126.9600)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (218, 3, 2023, CAST(N'2023-03-22' AS Date), 2023, N'33600', CAST(N'2022-12-01' AS Date), CAST(N'2023-01-31' AS Date), NULL, CAST(N'2022-12-02' AS Date), NULL, NULL, NULL, CAST(N'2023-01-31' AS Date), NULL, 6.4900, 0.3600, 165.1100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (219, 3, 2023, CAST(N'2023-07-14' AS Date), 2023, N'2033084', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-31' AS Date), NULL, NULL, NULL, NULL, NULL, 6.7500, 0.3600, 171.7300)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (220, 3, 2023, CAST(N'2023-09-18' AS Date), 2023, N'2043292', CAST(N'2023-04-01' AS Date), CAST(N'2023-06-30' AS Date), NULL, CAST(N'2023-05-04' AS Date), NULL, NULL, NULL, NULL, NULL, 0.5500, 0.3600, 13.9000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (221, 1, 2020, CAST(N'2020-01-15' AS Date), 2020, N'120013992', CAST(N'2019-10-01' AS Date), CAST(N'2019-11-30' AS Date), NULL, CAST(N'2019-11-30' AS Date), NULL, NULL, CAST(N'2019-10-01' AS Date), NULL, NULL, 4.4000, 0.3600, 111.8000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (222, 1, 2020, CAST(N'2020-03-13' AS Date), 2020, N'120024048', CAST(N'2019-12-01' AS Date), CAST(N'2020-01-31' AS Date), CAST(N'2019-05-23' AS Date), CAST(N'2019-12-18' AS Date), NULL, NULL, CAST(N'2019-12-19' AS Date), CAST(N'2020-01-31' AS Date), -165.7900, 5.8000, 0.3600, 147.4000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (223, 1, 2020, CAST(N'2020-05-16' AS Date), 2020, N'120050518', CAST(N'2020-02-01' AS Date), CAST(N'2020-03-31' AS Date), CAST(N'2019-12-19' AS Date), CAST(N'2020-02-24' AS Date), NULL, NULL, CAST(N'2020-02-25' AS Date), CAST(N'2020-03-31' AS Date), -161.1000, 6.0400, 0.3600, 153.4800)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (224, 1, 2020, CAST(N'2020-07-16' AS Date), 2020, N'120069042', CAST(N'2020-04-01' AS Date), CAST(N'2020-05-31' AS Date), CAST(N'2020-02-25' AS Date), CAST(N'2020-05-21' AS Date), NULL, NULL, CAST(N'2020-05-22' AS Date), CAST(N'2020-05-31' AS Date), -91.5800, 1.6100, 0.3600, 40.7700)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (225, 1, 2020, CAST(N'2020-09-09' AS Date), 2020, N'120087431', CAST(N'2020-06-01' AS Date), CAST(N'2020-07-31' AS Date), NULL, CAST(N'2020-07-31' AS Date), NULL, NULL, CAST(N'2020-06-01' AS Date), NULL, NULL, 1.0700, 0.3600, 27.1100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (226, 1, 2020, CAST(N'2020-11-13' AS Date), 2020, N'120105879', CAST(N'2020-08-01' AS Date), CAST(N'2020-09-30' AS Date), NULL, CAST(N'2020-09-30' AS Date), NULL, NULL, CAST(N'2020-08-01' AS Date), NULL, NULL, 1.3200, 0.3600, 33.4700)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (227, 1, 2021, CAST(N'2021-01-14' AS Date), 2021, N'12013676', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), NULL, CAST(N'2020-11-30' AS Date), NULL, NULL, CAST(N'2020-10-01' AS Date), NULL, NULL, 4.4000, 0.3600, 111.8000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (228, 1, 2021, CAST(N'2021-03-15' AS Date), 2021, N'12023848', CAST(N'2020-12-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(N'2020-05-22' AS Date), CAST(N'2020-12-21' AS Date), NULL, NULL, CAST(N'2020-12-22' AS Date), CAST(N'2021-01-31' AS Date), -166.7300, 6.6400, 0.3600, 168.7700)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (229, 1, 2021, CAST(N'2021-05-13' AS Date), 2021, N'12042330', CAST(N'2021-02-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(N'2020-12-22' AS Date), CAST(N'2021-02-19' AS Date), NULL, NULL, CAST(N'2021-02-20' AS Date), CAST(N'2021-03-31' AS Date), -149.9900, 7.7400, 0.3600, 196.8000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (230, 1, 2021, CAST(N'2021-07-29' AS Date), 2021, N'12069178', CAST(N'2021-04-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(N'2021-02-20' AS Date), CAST(N'2021-04-08' AS Date), NULL, NULL, CAST(N'2021-04-09' AS Date), CAST(N'2021-05-31' AS Date), -105.5600, 2.2000, 0.3600, 55.8800)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (231, 1, 2021, CAST(N'2021-09-20' AS Date), 2021, N'12087506', CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), NULL, CAST(N'2021-07-31' AS Date), NULL, NULL, CAST(N'2021-06-01' AS Date), NULL, NULL, 1.0700, 0.3600, 27.1100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (232, 1, 2021, CAST(N'2021-11-15' AS Date), 2021, N'12105923', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), NULL, CAST(N'2021-09-30' AS Date), NULL, NULL, CAST(N'2021-08-01' AS Date), NULL, NULL, 1.3200, 0.3600, 33.4700)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (233, 1, 2022, CAST(N'2022-01-13' AS Date), 2022, N'1205461', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), NULL, CAST(N'2021-11-30' AS Date), NULL, NULL, CAST(N'2021-10-01' AS Date), NULL, NULL, 4.4000, 0.3600, 111.8000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (234, 1, 2022, CAST(N'2022-03-16' AS Date), 2022, N'1232466', CAST(N'2021-12-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(N'2021-04-09' AS Date), CAST(N'2021-12-17' AS Date), NULL, NULL, CAST(N'2021-12-18' AS Date), CAST(N'2022-01-31' AS Date), -215.5300, 8.0000, 0.3600, 203.3700)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (235, 1, 2022, CAST(N'2022-05-16' AS Date), 2022, N'1251102', CAST(N'2022-02-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(N'2021-12-18' AS Date), CAST(N'2022-02-16' AS Date), NULL, NULL, CAST(N'2022-02-17' AS Date), CAST(N'2022-03-31' AS Date), -198.9500, 9.4900, 0.3600, 241.3000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (236, 1, 2022, CAST(N'2022-07-12' AS Date), 2022, N'1261218', CAST(N'2022-04-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(N'2022-02-17' AS Date), CAST(N'2022-04-28' AS Date), NULL, NULL, CAST(N'2022-04-29' AS Date), CAST(N'2022-05-31' AS Date), -150.3900, 2.1400, 0.3600, 54.2200)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (237, 1, 2022, CAST(N'2022-09-14' AS Date), 2022, N'1279815', CAST(N'2022-06-01' AS Date), CAST(N'2022-07-31' AS Date), NULL, CAST(N'2022-07-31' AS Date), NULL, NULL, CAST(N'2022-06-01' AS Date), NULL, NULL, 1.3900, 0.3600, 35.3100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (238, 1, 2022, CAST(N'2022-11-14' AS Date), 2022, N'1298310', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), NULL, CAST(N'2022-09-30' AS Date), NULL, NULL, CAST(N'2022-08-01' AS Date), NULL, NULL, 1.9500, 0.3600, 49.6300)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (239, 1, 2023, CAST(N'2023-01-13' AS Date), 2023, N'5309', CAST(N'2022-10-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-11-23' AS Date), NULL, NULL, NULL, CAST(N'2022-11-30' AS Date), NULL, -0.3900, 0.3600, 0.0000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (240, 1, 2023, CAST(N'2023-05-16' AS Date), 2023, N'2013566', CAST(N'2022-12-01' AS Date), CAST(N'2023-01-31' AS Date), NULL, CAST(N'2023-01-26' AS Date), NULL, NULL, NULL, CAST(N'2023-01-31' AS Date), NULL, 10.4900, 0.3600, 256.8900)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (241, 1, 2023, CAST(N'2023-07-14' AS Date), 2023, N'2031916', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-23' AS Date), NULL, NULL, NULL, CAST(N'2023-03-31' AS Date), NULL, 7.8200, 0.3600, 198.9200)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (242, 1, 2023, CAST(N'2023-09-18' AS Date), 2023, N'2042139', CAST(N'2023-04-01' AS Date), CAST(N'2023-06-30' AS Date), NULL, CAST(N'2023-05-03' AS Date), NULL, NULL, NULL, CAST(N'2023-06-30' AS Date), NULL, 1.7800, 0.3600, 45.3100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (261, 2, 2021, CAST(N'2021-01-14' AS Date), 2021, N'12012973', CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), NULL, NULL, NULL, NULL, CAST(N'2020-10-01' AS Date), CAST(N'2020-11-30' AS Date), NULL, 4.2200, 0.3600, 107.3000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (262, 2, 2021, CAST(N'2021-03-15' AS Date), 2021, N'12023146', CAST(N'2020-12-01' AS Date), CAST(N'2021-01-31' AS Date), CAST(N'2020-05-21' AS Date), CAST(N'2020-12-15' AS Date), NULL, NULL, CAST(N'2020-12-16' AS Date), CAST(N'2021-01-31' AS Date), -160.5400, 7.8200, 0.3600, 198.7800)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (263, 2, 2021, CAST(N'2021-05-13' AS Date), 2021, N'12041633', CAST(N'2021-02-01' AS Date), CAST(N'2021-03-31' AS Date), CAST(N'2020-12-16' AS Date), CAST(N'2021-02-22' AS Date), NULL, NULL, CAST(N'2021-02-23' AS Date), CAST(N'2021-03-31' AS Date), -163.8800, 8.3400, 0.3600, 212.1000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (264, 2, 2021, CAST(N'2021-07-29' AS Date), 2021, N'12068492', CAST(N'2021-04-01' AS Date), CAST(N'2021-05-31' AS Date), CAST(N'2021-02-23' AS Date), CAST(N'2021-04-14' AS Date), NULL, NULL, CAST(N'2021-04-15' AS Date), CAST(N'2021-05-31' AS Date), -91.0400, 3.3200, 0.3600, 84.3900)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (265, 2, 2021, CAST(N'2021-09-20' AS Date), 2021, N'12086823', CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), NULL, NULL, NULL, NULL, CAST(N'2021-06-01' AS Date), CAST(N'2021-07-31' AS Date), NULL, 1.0300, 0.3600, 26.1300)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (266, 2, 2021, CAST(N'2021-11-15' AS Date), 2021, N'12105242', CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), NULL, NULL, NULL, NULL, CAST(N'2021-08-01' AS Date), CAST(N'2021-09-30' AS Date), NULL, 1.2800, 0.3600, 32.4900)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (267, 2, 2022, CAST(N'2022-01-13' AS Date), 2022, N'1204787', CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), NULL, NULL, NULL, NULL, CAST(N'2021-10-01' AS Date), CAST(N'2021-11-30' AS Date), NULL, 4.2200, 0.3600, 107.3000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (268, 2, 2022, CAST(N'2022-03-16' AS Date), 2022, N'1231796', CAST(N'2021-12-01' AS Date), CAST(N'2022-01-31' AS Date), CAST(N'2021-04-15' AS Date), CAST(N'2021-12-13' AS Date), NULL, NULL, CAST(N'2021-12-14' AS Date), CAST(N'2022-01-31' AS Date), -197.4300, 11.3900, 0.3600, 289.7400)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (269, 2, 2022, CAST(N'2022-05-16' AS Date), 2022, N'1250434', CAST(N'2022-02-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(N'2021-12-14' AS Date), CAST(N'2022-02-22' AS Date), NULL, NULL, CAST(N'2022-02-23' AS Date), CAST(N'2022-03-31' AS Date), -203.1600, 12.5000, 0.3600, 317.9600)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (270, 2, 2022, CAST(N'2022-07-12' AS Date), 2022, N'1260558', CAST(N'2022-04-01' AS Date), CAST(N'2022-05-31' AS Date), CAST(N'2022-02-23' AS Date), CAST(N'2022-04-22' AS Date), NULL, NULL, CAST(N'2022-04-23' AS Date), CAST(N'2022-05-31' AS Date), -118.3700, 7.9200, 0.3600, 201.4200)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (271, 2, 2022, CAST(N'2022-09-14' AS Date), 2022, N'1279157', CAST(N'2022-06-01' AS Date), CAST(N'2022-07-31' AS Date), NULL, NULL, NULL, NULL, CAST(N'2022-06-01' AS Date), CAST(N'2022-07-31' AS Date), NULL, 1.7400, 0.3600, 44.1000)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (272, 2, 2022, CAST(N'2022-11-14' AS Date), 2022, N'1297658', CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), NULL, NULL, NULL, NULL, CAST(N'2022-08-01' AS Date), CAST(N'2022-09-30' AS Date), NULL, 2.4100, 0.3600, 61.2100)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (273, 2, 2023, CAST(N'2023-01-13' AS Date), 2023, N'4659', CAST(N'2022-10-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, NULL, CAST(N'2022-04-23' AS Date), CAST(N'2022-11-14' AS Date), NULL, NULL, NULL, 1.9500, 0.3600, 49.6200)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (274, 2, 2023, CAST(N'2023-05-16' AS Date), 2023, N'2012924', CAST(N'2022-12-01' AS Date), CAST(N'2023-01-31' AS Date), NULL, NULL, CAST(N'2022-11-15' AS Date), CAST(N'2023-01-31' AS Date), NULL, NULL, NULL, 15.3300, 0.3600, 389.8600)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (275, 2, 2023, CAST(N'2023-07-14' AS Date), 2023, N'2031279', CAST(N'2023-02-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12.6700, 0.3600, 322.0600)
INSERT [dbo].[GASFattura] ([idGASFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodEffDtIniz], [periodEffDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [accontoBollPrec], [addizFER], [impostaQuiet], [TotPagare]) VALUES (276, 2, 2023, CAST(N'2023-09-18' AS Date), 2023, N'2041500', CAST(N'2023-04-01' AS Date), CAST(N'2023-06-30' AS Date), NULL, NULL, CAST(N'2023-02-01' AS Date), CAST(N'2023-05-04' AS Date), NULL, NULL, NULL, 3.9300, 0.3600, 99.7400)
SET IDENTITY_INSERT [dbo].[GASFattura] OFF
SET IDENTITY_INSERT [dbo].[GASLettura] ON 

INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (707, 201, 81240, CAST(N'2019-05-17' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (708, 201, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (709, 201, NULL, NULL, N'tot', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (710, 202, 81240, CAST(N'2019-05-17' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (711, 202, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (712, 202, NULL, NULL, N'tot', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (713, 203, 81240, CAST(N'2019-05-17' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (714, 203, 81572, CAST(N'2019-12-13' AS Date), N'eff', 332)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (715, 203, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (716, 203, NULL, NULL, N'tot', 332)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (717, 204, 81572, CAST(N'2019-12-13' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (718, 204, 81896, CAST(N'2020-02-18' AS Date), N'eff', 324)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (719, 204, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (720, 204, NULL, NULL, N'tot', 324)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (721, 205, 82137, CAST(N'2020-05-20' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (722, 205, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (723, 205, NULL, NULL, N'tot', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (724, 206, 82137, CAST(N'2020-05-20' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (725, 206, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (726, 206, NULL, NULL, N'tot', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (727, 207, 82137, CAST(N'2020-05-20' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (728, 207, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (729, 207, NULL, NULL, N'tot', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (730, 208, 82137, CAST(N'2020-05-20' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (731, 208, 82362, CAST(N'2020-12-15' AS Date), N'eff', 225)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (732, 208, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (733, 208, NULL, NULL, N'tot', 225)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (734, 209, 82362, CAST(N'2020-12-15' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (735, 209, 82764, CAST(N'2021-02-22' AS Date), N'eff', 402)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (736, 209, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (737, 209, NULL, NULL, N'tot', 402)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (738, 210, 82764, CAST(N'2021-02-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (739, 210, 82934, CAST(N'2021-04-14' AS Date), N'eff', 170)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (740, 210, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (741, 210, NULL, NULL, N'tot', 170)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (742, 211, 82934, CAST(N'2021-04-14' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (743, 211, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (744, 211, NULL, NULL, N'tot', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (745, 212, 82934, CAST(N'2021-04-14' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (746, 212, 83241, CAST(N'2021-12-13' AS Date), N'eff', 307)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (747, 212, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (748, 212, NULL, NULL, N'tot', 307)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (749, 213, 83241, CAST(N'2021-12-13' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (750, 213, 83635, CAST(N'2022-02-22' AS Date), N'eff', 394)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (751, 213, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (752, 213, NULL, NULL, N'tot', 394)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (753, 214, 83635, CAST(N'2022-02-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (754, 214, 83843, CAST(N'2022-04-22' AS Date), N'eff', 208)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (755, 214, NULL, NULL, N'stim', 0)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (756, 214, NULL, NULL, N'tot', 208)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (757, 215, 83843, CAST(N'2022-04-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (758, 215, NULL, NULL, N'stim', 36)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (759, 215, NULL, NULL, N'tot', 36)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (760, 216, 83843, CAST(N'2022-04-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (761, 216, NULL, NULL, N'stim', 45)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (762, 216, NULL, NULL, N'tot', 45)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (763, 217, 83843, CAST(N'2022-04-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (764, 217, NULL, NULL, N'stim', 150)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (765, 217, NULL, NULL, N'tot', 150)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (766, 218, 83843, CAST(N'2022-04-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (767, 218, 83963, CAST(N'2022-12-02' AS Date), N'eff', 120)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (768, 218, NULL, NULL, N'stim', 308)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (769, 218, NULL, NULL, N'tot', 428)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (770, 219, 84236, CAST(N'2023-01-31' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (771, 219, NULL, NULL, N'stim', 203)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (772, 219, NULL, NULL, N'tot', 203)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (773, 220, 84236, CAST(N'2023-01-31' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (774, 220, 84457, CAST(N'2023-05-04' AS Date), N'eff', 221)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (775, 220, 84470, CAST(N'2023-06-30' AS Date), N'eff', 13)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (776, 220, NULL, NULL, N'tot', 234)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (777, 221, 6629, CAST(N'2019-05-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (778, 221, NULL, NULL, N'stim', 222)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (779, 221, NULL, NULL, N'tot', 222)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (780, 222, 6629, CAST(N'2019-05-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (781, 222, 6936, CAST(N'2019-12-18' AS Date), N'eff', 307)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (782, 222, NULL, NULL, N'stim', 334)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (783, 222, NULL, NULL, N'tot', 641)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (784, 223, 6936, CAST(N'2019-12-18' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (785, 223, 7383, CAST(N'2020-02-24' AS Date), N'eff', 447)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (786, 223, NULL, NULL, N'stim', 191)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (787, 223, NULL, NULL, N'tot', 638)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (788, 224, 7383, CAST(N'2020-02-24' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (789, 224, 7642, CAST(N'2020-05-21' AS Date), N'eff', 259)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (790, 224, NULL, NULL, N'stim', 13)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (791, 224, NULL, NULL, N'tot', 272)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (792, 225, 7642, CAST(N'2020-05-21' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (793, 225, NULL, NULL, N'stim', 52)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (794, 225, NULL, NULL, N'tot', 52)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (795, 226, 7642, CAST(N'2020-05-21' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (796, 226, NULL, NULL, N'stim', 65)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (797, 226, NULL, NULL, N'tot', 65)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (798, 227, 7642, CAST(N'2020-05-21' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (799, 227, NULL, NULL, N'stim', 222)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (800, 227, NULL, NULL, N'tot', 222)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (801, 228, 7642, CAST(N'2020-05-21' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (802, 228, 8017, CAST(N'2020-12-21' AS Date), N'eff', 375)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (803, 228, NULL, NULL, N'stim', 311)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (804, 228, NULL, NULL, N'tot', 686)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (805, 229, 8017, CAST(N'2020-12-21' AS Date), N'eff', NULL)
GO
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (806, 229, 8497, CAST(N'2021-02-19' AS Date), N'eff', 480)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (807, 229, NULL, NULL, N'stim', 220)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (808, 229, NULL, NULL, N'tot', 700)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (809, 230, 8497, CAST(N'2021-02-19' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (810, 230, 8712, CAST(N'2021-04-08' AS Date), N'eff', 215)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (811, 230, NULL, NULL, N'stim', 116)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (812, 230, NULL, NULL, N'tot', 331)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (813, 231, 8712, CAST(N'2021-04-08' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (814, 231, NULL, NULL, N'stim', 52)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (815, 231, NULL, NULL, N'tot', 52)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (816, 232, 8712, CAST(N'2021-04-08' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (817, 232, NULL, NULL, N'stim', 65)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (818, 232, NULL, NULL, N'tot', 65)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (819, 233, 8712, CAST(N'2021-04-08' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (820, 233, NULL, NULL, N'stim', 222)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (821, 233, NULL, NULL, N'tot', 222)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (822, 234, 8712, CAST(N'2021-04-08' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (823, 234, 9157, CAST(N'2021-12-17' AS Date), N'eff', 445)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (824, 234, NULL, NULL, N'stim', 342)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (825, 234, NULL, NULL, N'tot', 787)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (826, 235, 9157, CAST(N'2021-12-17' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (827, 235, 9626, CAST(N'2022-02-16' AS Date), N'eff', 469)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (828, 235, NULL, NULL, N'stim', 241)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (829, 235, NULL, NULL, N'tot', 710)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (830, 236, 9626, CAST(N'2022-02-16' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (831, 236, 9905, CAST(N'2022-04-28' AS Date), N'eff', 279)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (832, 236, NULL, NULL, N'stim', 46)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (833, 236, NULL, NULL, N'tot', 325)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (834, 237, 9905, CAST(N'2022-04-28' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (835, 237, NULL, NULL, N'stim', 46)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (836, 237, NULL, NULL, N'tot', 46)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (837, 238, 9905, CAST(N'2022-04-28' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (838, 238, NULL, NULL, N'stim', 58)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (839, 238, NULL, NULL, N'tot', 58)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (840, 239, 9905, CAST(N'2022-04-28' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (841, 239, 9998, CAST(N'2022-11-23' AS Date), N'eff', 93)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (842, 239, NULL, NULL, N'stim', 33)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (843, 239, NULL, NULL, N'tot', 126)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (844, 240, 9998, CAST(N'2022-11-23' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (845, 240, 10321, CAST(N'2023-01-26' AS Date), N'eff', 323)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (846, 240, NULL, NULL, N'stim', 24)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (847, 240, NULL, NULL, N'tot', 347)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (848, 241, 10321, CAST(N'2023-01-26' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (849, 241, 10551, CAST(N'2023-03-23' AS Date), N'auto', 230)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (850, 241, NULL, NULL, N'stim', 29)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (851, 241, NULL, NULL, N'tot', 259)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (852, 242, 10551, CAST(N'2023-03-23' AS Date), N'auto', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (853, 242, 10610, CAST(N'2023-05-03' AS Date), N'eff', 59)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (854, 242, NULL, NULL, N'stim', 44)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (855, 242, NULL, NULL, N'tot', 103)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (920, 261, 39819, CAST(N'2020-05-20' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (921, 261, NULL, NULL, N'stim', 213)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (922, 261, NULL, NULL, N'tot', 213)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (923, 262, 39819, CAST(N'2020-05-20' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (924, 262, 40212, CAST(N'2020-12-15' AS Date), N'eff', 393)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (925, 262, NULL, NULL, N'stim', 340)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (926, 262, NULL, NULL, N'tot', 733)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (927, 263, 40212, CAST(N'2020-12-15' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (928, 263, 40781, CAST(N'2021-02-22' AS Date), N'eff', 569)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (929, 263, NULL, NULL, N'stim', 190)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (930, 263, NULL, NULL, N'tot', 759)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (931, 264, 40781, CAST(N'2021-02-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (932, 264, 41047, CAST(N'2021-04-14' AS Date), N'eff', 266)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (933, 264, NULL, NULL, N'stim', 91)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (934, 264, NULL, NULL, N'tot', 357)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (935, 265, 41047, CAST(N'2021-04-14' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (936, 265, NULL, NULL, N'stim', 50)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (937, 265, NULL, NULL, N'tot', 50)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (938, 266, 41047, CAST(N'2021-04-14' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (939, 266, NULL, NULL, N'stim', 63)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (940, 266, NULL, NULL, N'tot', 63)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (941, 267, 41047, CAST(N'2021-04-14' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (942, 267, NULL, NULL, N'stim', 213)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (943, 267, NULL, NULL, N'tot', 213)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (944, 268, 41047, CAST(N'2021-04-14' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (945, 268, 41618, CAST(N'2021-12-13' AS Date), N'eff', 571)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (946, 268, NULL, NULL, N'stim', 354)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (947, 268, NULL, NULL, N'tot', 925)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (948, 269, 41618, CAST(N'2021-12-13' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (949, 269, 42274, CAST(N'2022-02-22' AS Date), N'eff', 656)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (950, 269, NULL, NULL, N'stim', 190)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (951, 269, NULL, NULL, N'tot', 846)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (952, 270, 42274, CAST(N'2022-02-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (953, 270, 42705, CAST(N'2022-04-22' AS Date), N'eff', 431)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (954, 270, NULL, NULL, N'stim', 65)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (955, 270, NULL, NULL, N'tot', 496)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (956, 271, 42705, CAST(N'2022-04-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (957, 271, NULL, NULL, N'stim', 58)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (958, 271, NULL, NULL, N'tot', 58)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (959, 272, 42705, CAST(N'2022-04-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (960, 272, NULL, NULL, N'stim', 72)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (961, 272, NULL, NULL, N'tot', 72)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (962, 273, 42705, CAST(N'2022-04-22' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (963, 273, 42854, CAST(N'2022-11-14' AS Date), N'eff', 149)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (964, 273, NULL, NULL, N'stim', 92)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (965, 273, NULL, NULL, N'tot', 241)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (966, 274, 42854, CAST(N'2022-11-14' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (967, 274, 43403, CAST(N'2023-01-31' AS Date), N'eff', 549)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (968, 274, NULL, NULL, N'tot', 549)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (969, 275, 43403, CAST(N'2023-01-31' AS Date), N'eff', NULL)
GO
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (970, 275, NULL, NULL, N'stim', 378)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (971, 275, NULL, NULL, N'tot', 378)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (972, 276, 43403, CAST(N'2023-01-31' AS Date), N'eff', NULL)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (973, 276, 43885, CAST(N'2023-05-04' AS Date), N'eff', 482)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (974, 276, 43899, CAST(N'2023-05-15' AS Date), N'auto', 14)
INSERT [dbo].[GASLettura] ([idLettura], [idGASFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (975, 276, NULL, NULL, N'tot', 527)
SET IDENTITY_INSERT [dbo].[GASLettura] OFF
SET IDENTITY_INSERT [dbo].[H2OConsumo] ON 

INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1200, 101, N'S1', CAST(N'2019-06-11' AS Date), CAST(N'2019-09-24' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 5.2600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1201, 101, N'S1', CAST(N'2019-06-11' AS Date), CAST(N'2019-09-24' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 6.9000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1202, 101, N'F', CAST(N'2019-07-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1203, 101, N'S1', CAST(N'2019-09-25' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.4800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1204, 101, N'S1', CAST(N'2019-09-25' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1205, 102, N'S1', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.8700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1206, 102, N'S1', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1207, 102, N'F', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1208, 102, N'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.8700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1209, 102, N'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1210, 102, N'F', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(60.00 AS Decimal(8, 2)), 0.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1211, 103, N'S1', CAST(N'2019-09-25' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 9.0900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1212, 103, N'S2', CAST(N'2019-09-25' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.7500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1213, 103, N'S1', CAST(N'2019-09-25' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 11.9200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1214, 103, N'S2', CAST(N'2019-09-25' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 5.6500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1215, 103, N'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-22' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 13.4000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1216, 103, N'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-22' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 13.6100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1217, 103, N'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(28.00 AS Decimal(8, 2)), 17.5700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1218, 103, N'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 8.7800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1219, 103, N'F', CAST(N'2020-03-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1220, 103, N'S1', CAST(N'2020-05-23' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.9100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1221, 103, N'S1', CAST(N'2020-05-23' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1222, 104, N'S1', CAST(N'2020-05-23' AS Date), CAST(N'2020-08-18' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1223, 104, N'S1', CAST(N'2020-05-23' AS Date), CAST(N'2020-08-18' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 3.1400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1224, 104, N'F', CAST(N'2020-07-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1225, 104, N'S1', CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 7.1800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1226, 104, N'S2', CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 6.8100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1227, 104, N'S1', CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 9.4100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1228, 104, N'S2', CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1229, 105, N'S1', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 3.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1230, 105, N'S2', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 6.8100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1231, 105, N'S3', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 2.9900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1232, 105, N'S1', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1233, 105, N'S2', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1234, 105, N'S3', CAST(N'2020-11-27' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1235, 105, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 15.3100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1236, 105, N'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 31.1100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1237, 105, N'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 13.4500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1238, 105, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 20.0800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1239, 105, N'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(32.00 AS Decimal(8, 2)), 20.0800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1240, 105, N'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 5.6500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1241, 105, N'F', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1242, 106, N'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 3.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1243, 106, N'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1244, 106, N'F', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1245, 106, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 4.7800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1246, 106, N'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 9.7200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1247, 106, N'S3', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 4.4800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1248, 106, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1249, 106, N'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1250, 106, N'S3', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1251, 107, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 9.5700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1252, 107, N'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.7500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1253, 107, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 12.5500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1254, 107, N'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 5.6500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1255, 107, N'F', CAST(N'2021-11-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1256, 107, N'S1', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.4800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1257, 107, N'S1', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1258, 107, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.9100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1259, 107, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1260, 107, N'F', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(59.00 AS Decimal(8, 2)), 0.5000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1261, 108, N'S1', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 0.9600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1262, 108, N'S2', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.9400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1263, 108, N'S1', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1264, 108, N'S2', CAST(N'2021-12-23' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1265, 108, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.6100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1266, 108, N'S2', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 17.5000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1267, 108, N'S3', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 4.4800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1268, 108, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1269, 108, N'S2', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1270, 108, N'S3', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1271, 108, N'F', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.2600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1272, 108, N'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 10.0000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1273, 108, N'S2', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 20.3200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1274, 108, N'S3', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(1.643974 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 4.9300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1275, 108, N'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 17.2800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1276, 108, N'S2', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(19.00 AS Decimal(8, 2)), 17.2800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1277, 108, N'S3', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1278, 108, N'F', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1279, 108, N'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.6300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1280, 108, N'S2', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 3.2100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1281, 108, N'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.5500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1282, 108, N'S2', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1283, 109, N'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1284, 109, N'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1285, 109, N'F', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1286, 109, N'S3', CAST(N'2022-10-06' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.8200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1287, 110, N'F', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.3400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1288, 110, N'F', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 1.0000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1289, 111, N'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.6300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1290, 111, N'S2', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 3.2100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1291, 111, N'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.5500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1292, 111, N'S2', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1293, 111, N'S1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.1600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1294, 111, N'S2', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.2800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1295, 111, N'S1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1296, 111, N'S2', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1297, 111, N'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.1600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1298, 111, N'S2', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.2800)
GO
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1299, 111, N'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1300, 111, N'S2', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1301, 111, N'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1302, 111, N'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1303, 111, N'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1304, 111, N'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1305, 111, N'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1306, 111, N'S2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 3.5000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1307, 111, N'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1308, 111, N'S2', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1309, 111, N'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1310, 111, N'S2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1311, 111, N'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1312, 111, N'S2', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1313, 111, N'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1314, 111, N'S2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1315, 111, N'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1316, 111, N'S2', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1317, 111, N'F', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1318, 111, N'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1319, 111, N'S2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1320, 111, N'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1321, 111, N'S2', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1322, 111, N'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.4400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1323, 111, N'S2', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1324, 111, N'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1325, 111, N'S2', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1326, 111, N'S1', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.1500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1327, 111, N'S2', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(1.166590 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 1.1700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1328, 111, N'S1', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.8200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1329, 111, N'S2', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1330, 112, N'S1', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 5.7400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1331, 112, N'S2', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 11.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1332, 112, N'S3', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 11.9600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1333, 112, N'S1', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1334, 112, N'S2', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1335, 112, N'S3', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 5.0200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1336, 112, N'F', CAST(N'2019-11-01' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1337, 112, N'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 5.7400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1338, 112, N'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 11.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1339, 112, N'S3', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 10.4600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1340, 112, N'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1341, 112, N'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1342, 112, N'S3', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(7.00 AS Decimal(8, 2)), 4.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1343, 112, N'F', CAST(N'2020-01-01' AS Date), CAST(N'2020-02-29' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(60.00 AS Decimal(8, 2)), 0.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1344, 113, N'S1', CAST(N'2019-10-05' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 8.1300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1345, 113, N'S2', CAST(N'2019-10-05' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.8600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1346, 113, N'S1', CAST(N'2019-10-05' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 10.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1347, 113, N'S2', CAST(N'2019-10-05' AS Date), CAST(N'2019-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 3.1400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1348, 113, N'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 13.8700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1349, 113, N'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-28' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 7.7800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1350, 113, N'S1', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(29.00 AS Decimal(8, 2)), 18.1900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1351, 113, N'S2', CAST(N'2020-01-01' AS Date), CAST(N'2020-05-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 5.0200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1352, 113, N'F', CAST(N'2020-03-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1353, 113, N'S1', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 2.8700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1354, 113, N'S2', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 5.8300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1355, 113, N'S3', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 8.9700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1356, 113, N'S1', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1357, 113, N'S2', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1358, 113, N'S3', CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(6.00 AS Decimal(8, 2)), 3.7600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1359, 114, N'S1', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.6100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1360, 114, N'S2', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 17.5000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1361, 114, N'S3', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 26.9000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1362, 114, N'S4', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(2.171288 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 6.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1363, 114, N'S1', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1364, 114, N'S2', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1365, 114, N'S3', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1366, 114, N'S4', CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1367, 114, N'F', CAST(N'2020-07-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1368, 114, N'S1', CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 6.2200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1369, 114, N'S2', CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.8900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1370, 114, N'S1', CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 8.1600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1371, 114, N'S2', CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1372, 115, N'S1', CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(21.00 AS Decimal(8, 2)), 10.0500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1373, 115, N'S2', CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 13.6100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1374, 115, N'S1', CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(21.00 AS Decimal(8, 2)), 13.1700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1375, 115, N'S2', CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(14.00 AS Decimal(8, 2)), 8.7800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1376, 115, N'F', CAST(N'2020-11-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1377, 115, N'S1', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.9100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1378, 115, N'S2', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.8900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1379, 115, N'S3', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 5.9800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1380, 115, N'S4', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(2.171288 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 4.3400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1381, 115, N'S1', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1382, 115, N'S2', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1383, 115, N'S3', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1384, 115, N'S4', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1385, 115, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 5.7400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1386, 115, N'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 11.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1387, 115, N'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 17.9300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1388, 115, N'S4', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(2.171288 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 4.3400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1389, 115, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1390, 115, N'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1391, 115, N'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(12.00 AS Decimal(8, 2)), 7.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1392, 115, N'S4', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1393, 115, N'F', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(59.00 AS Decimal(8, 2)), 0.5000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1394, 116, N'S1', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 1.9100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1395, 116, N'S2', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.8900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1396, 116, N'S3', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 1.4900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1397, 116, N'S1', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1398, 116, N'S2', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.5100)
GO
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1399, 116, N'S3', CAST(N'2020-12-11' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1400, 116, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 16.2700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1401, 116, N'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 33.0500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1402, 116, N'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 4.4800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1403, 116, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 21.3300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1404, 116, N'S2', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(34.00 AS Decimal(8, 2)), 21.3300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1405, 116, N'S3', CAST(N'2021-01-01' AS Date), CAST(N'2021-06-22' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1406, 116, N'F', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1407, 116, N'S1', CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 0.9600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1408, 116, N'S2', CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1409, 116, N'S1', CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1410, 116, N'S2', CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1411, 117, N'S1', CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 7.6500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1412, 117, N'S2', CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 15.5500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1413, 117, N'S1', CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 10.0400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1414, 117, N'S2', CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 10.0400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1415, 117, N'F', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1416, 117, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 4.7800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1417, 117, N'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 9.7200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1418, 117, N'S3', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(1.494522 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 1.4900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1419, 117, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1420, 117, N'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1421, 117, N'S3', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1422, 118, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 10.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1423, 118, N'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 12.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1424, 118, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(22.00 AS Decimal(8, 2)), 13.8000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1425, 118, N'S2', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 8.1600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1426, 118, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 8.1300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1427, 118, N'S2', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-28' AS Date), CAST(0.972158 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 10.6900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1428, 118, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 10.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1429, 118, N'S2', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 6.9000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1430, 118, N'F', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.2600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1431, 118, N'S1', CAST(N'2022-03-29' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.4800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1432, 118, N'S1', CAST(N'2022-03-29' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.6300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1433, 118, N'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 10.5300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1434, 118, N'S2', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 21.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1435, 118, N'S3', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(1.643974 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 18.0800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1436, 118, N'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 18.1900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1437, 118, N'S2', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(20.00 AS Decimal(8, 2)), 18.1900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1438, 118, N'S3', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-11' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(11.00 AS Decimal(8, 2)), 10.0100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1439, 118, N'F', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1440, 118, N'S1', CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1441, 118, N'S2', CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 4.2800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1442, 118, N'S1', CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1443, 118, N'S2', CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1444, 119, N'S1', CAST(N'2022-07-12' AS Date), CAST(N'2022-10-10' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 9.4700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1445, 119, N'S2', CAST(N'2022-07-12' AS Date), CAST(N'2022-10-10' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 10.6900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1446, 119, N'S1', CAST(N'2022-07-12' AS Date), CAST(N'2022-10-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 16.3700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1447, 119, N'S2', CAST(N'2022-07-12' AS Date), CAST(N'2022-10-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 9.1000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1448, 119, N'F', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1449, 119, N'S2', CAST(N'2022-10-11' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.1900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1450, 120, N'F', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.3400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1451, 120, N'F', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 1.0000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1452, 120, N'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.1900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1453, 121, N'F', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1454, 121, N'S2', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1455, 122, N'S1', CAST(N'2020-08-19' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 7.1800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1456, 122, N'S1', CAST(N'2020-08-19' AS Date), CAST(N'2020-11-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 9.4100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1457, 122, N'F', CAST(N'2020-11-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.008525 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1458, 122, N'S1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1459, 122, N'S1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 3.1400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1460, 122, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 4.3100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1461, 122, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 5.6500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1462, 122, N'F', CAST(N'2021-01-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(59.00 AS Decimal(8, 2)), 0.5000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1463, 123, N'S1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.3900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1464, 123, N'S1', CAST(N'2020-12-01' AS Date), CAST(N'2020-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 3.1400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1465, 123, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-04-16' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 8.6100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1466, 123, N'S1', CAST(N'2021-01-01' AS Date), CAST(N'2021-04-16' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 11.2900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1467, 123, N'F', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.0400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1468, 123, N'S1', CAST(N'2021-04-17' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 4.7800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1469, 123, N'S1', CAST(N'2021-04-17' AS Date), CAST(N'2021-06-11' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1470, 123, N'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.4400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1471, 123, N'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-06-30' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.8800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1472, 124, N'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 7.1800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1473, 124, N'S1', CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(15.00 AS Decimal(8, 2)), 9.4100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1474, 124, N'F', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(123.00 AS Decimal(8, 2)), 1.0500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1475, 124, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 3.8300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1476, 124, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(8.00 AS Decimal(8, 2)), 5.0200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1477, 125, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-21' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 8.1300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1478, 125, N'S1', CAST(N'2021-09-11' AS Date), CAST(N'2021-12-21' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(17.00 AS Decimal(8, 2)), 10.6700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1479, 125, N'F', CAST(N'2021-11-01' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(61.00 AS Decimal(8, 2)), 0.5200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1480, 125, N'S1', CAST(N'2021-12-22' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 0.9600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1481, 125, N'S1', CAST(N'2021-12-22' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1482, 125, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 4.7800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1483, 125, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(10.00 AS Decimal(8, 2)), 6.2700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1484, 125, N'F', CAST(N'2022-01-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(59.00 AS Decimal(8, 2)), 0.5000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1485, 126, N'S1', CAST(N'2021-12-22' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 0.9600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1486, 126, N'S1', CAST(N'2021-12-22' AS Date), CAST(N'2021-12-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.2500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1487, 126, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.478419 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 7.6500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1488, 126, N'S1', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.627365 AS Decimal(10, 6)), CAST(16.00 AS Decimal(8, 2)), 10.0400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1489, 126, N'F', CAST(N'2022-03-01' AS Date), CAST(N'2022-03-31' AS Date), CAST(0.008548 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.2600)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1490, 126, N'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-19' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 1.5800)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1491, 126, N'S1', CAST(N'2022-04-01' AS Date), CAST(N'2022-04-19' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(3.00 AS Decimal(8, 2)), 2.7300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1492, 126, N'F', CAST(N'2022-04-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1493, 126, N'S1', CAST(N'2022-04-20' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 6.8400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1494, 126, N'S1', CAST(N'2022-04-20' AS Date), CAST(N'2022-07-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(13.00 AS Decimal(8, 2)), 11.8300)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1495, 126, N'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1496, 126, N'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1497, 127, N'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 9.4700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1498, 127, N'S2', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(1.069374 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 2.1400)
GO
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1499, 127, N'S1', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(18.00 AS Decimal(8, 2)), 16.3700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1500, 127, N'S2', CAST(N'2022-07-06' AS Date), CAST(N'2022-10-05' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.8200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1501, 127, N'F', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1502, 127, N'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(9.00 AS Decimal(8, 2)), 8.1900)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1503, 128, N'F', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(31.00 AS Decimal(8, 2)), 0.3400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1504, 128, N'F', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(90.00 AS Decimal(8, 2)), 1.0000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1505, 128, N'S2', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(2.00 AS Decimal(8, 2)), 1.8200)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1506, 129, N'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1507, 129, N'S1', CAST(N'2022-10-06' AS Date), CAST(N'2022-10-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1508, 129, N'S1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1509, 129, N'S1', CAST(N'2022-11-01' AS Date), CAST(N'2022-11-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1510, 129, N'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.526261 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.1100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1511, 129, N'S1', CAST(N'2022-12-01' AS Date), CAST(N'2022-12-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1512, 129, N'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1513, 129, N'S1', CAST(N'2023-01-01' AS Date), CAST(N'2023-01-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1514, 129, N'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1515, 129, N'S1', CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1516, 129, N'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1517, 129, N'S1', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1518, 129, N'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1519, 129, N'S1', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1520, 129, N'F', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.011096 AS Decimal(10, 6)), CAST(122.00 AS Decimal(8, 2)), 1.3500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1521, 129, N'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 2.3000)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1522, 129, N'S1', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(4.00 AS Decimal(8, 2)), 3.6400)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1523, 129, N'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 2.8700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1524, 129, N'S1', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-30' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(5.00 AS Decimal(8, 2)), 4.5500)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1525, 129, N'S1', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.574103 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.5700)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1526, 129, N'S1', CAST(N'2023-07-01' AS Date), CAST(N'2023-07-10' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9100)
INSERT [dbo].[H2OConsumo] ([idConsumo], [idH2OFattura], [tipoSpesa], [dtIniz], [dtFine], [prezzoUnit], [quantita], [importo]) VALUES (1527, 129, N'S2', CAST(N'2023-07-11' AS Date), CAST(N'2023-07-31' AS Date), CAST(0.909679 AS Decimal(10, 6)), CAST(1.00 AS Decimal(8, 2)), 0.9100)
SET IDENTITY_INSERT [dbo].[H2OConsumo] OFF
SET IDENTITY_INSERT [dbo].[H2OFattura] ON 

INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (101, 3, 2019, CAST(N'2019-11-28' AS Date), 2019, N'30063070', CAST(N'2019-07-01' AS Date), CAST(N'2019-10-31' AS Date), CAST(N'2019-06-11' AS Date), CAST(N'2019-09-24' AS Date), CAST(N'2019-09-25' AS Date), CAST(N'2019-10-31' AS Date), 4.2500, 0.1700, NULL, 17.4600)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (102, 3, 2020, CAST(N'2020-04-20' AS Date), 2020, N'320017682', CAST(N'2019-11-01' AS Date), CAST(N'2020-02-29' AS Date), NULL, CAST(N'2020-02-29' AS Date), CAST(N'2019-11-01' AS Date), NULL, 5.3900, 0.1700, NULL, 19.6800)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (103, 3, 2020, CAST(N'2020-08-04' AS Date), 2020, N'320036603', CAST(N'2020-03-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(N'2019-09-25' AS Date), CAST(N'2020-05-22' AS Date), CAST(N'2020-05-23' AS Date), CAST(N'2020-06-30' AS Date), 6.6700, 0.1700, NULL, 86.5300)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (104, 3, 2020, CAST(N'2020-12-09' AS Date), 2020, N'320056036', CAST(N'2020-07-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(N'2020-05-23' AS Date), CAST(N'2020-08-18' AS Date), CAST(N'2020-08-19' AS Date), CAST(N'2020-10-31' AS Date), 6.7200, 0.1700, NULL, 36.6700)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (105, 3, 2021, CAST(N'2021-10-29' AS Date), 2021, N'32036324', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(N'2020-11-27' AS Date), CAST(N'2021-06-11' AS Date), CAST(N'2021-06-12' AS Date), CAST(N'2021-06-30' AS Date), 6.6800, 0.1700, NULL, 117.6700)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (106, 3, 2022, CAST(N'2022-01-26' AS Date), 2022, N'32004781', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-09-10' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), 6.7400, 0.1700, NULL, 48.9300)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (107, 3, 2022, CAST(N'2022-05-31' AS Date), 2022, N'32029941', CAST(N'2021-11-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-12-22' AS Date), CAST(N'2021-12-23' AS Date), CAST(N'2022-02-28' AS Date), 6.5700, 0.1700, NULL, 16.2400)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (108, 3, 2022, CAST(N'2022-09-26' AS Date), 2022, N'32049794', CAST(N'2022-03-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(N'2021-12-23' AS Date), CAST(N'2022-07-05' AS Date), CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), 8.3800, 0.1700, NULL, 150.8000)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (109, 3, 2023, CAST(N'2023-01-04' AS Date), 2023, N'32004580', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-10-05' AS Date), NULL, CAST(N'2022-11-30' AS Date), 6.6800, 0.1700, -13.1200, 39.0300)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (110, 3, 2023, CAST(N'2023-06-26' AS Date), 2023, N'32024453', CAST(N'2022-12-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-31' AS Date), NULL, NULL, 6.6300, 0.1700, NULL, 7.9700)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (111, 3, 2023, CAST(N'2023-09-29' AS Date), 2023, N'32044264', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), NULL, CAST(N'2023-07-10' AS Date), NULL, CAST(N'2023-07-31' AS Date), 6.6800, 0.1700, -42.6800, 117.9600)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (112, 1, 2020, CAST(N'2020-04-20' AS Date), 2020, N'320016588', CAST(N'2019-11-01' AS Date), CAST(N'2020-02-29' AS Date), NULL, CAST(N'2020-02-29' AS Date), CAST(N'2019-11-01' AS Date), NULL, 5.3900, 0.1700, NULL, 76.8800)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (113, 1, 2020, CAST(N'2020-08-04' AS Date), 2020, N'320035544', CAST(N'2020-03-01' AS Date), CAST(N'2020-06-30' AS Date), CAST(N'2019-10-05' AS Date), CAST(N'2020-05-28' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-06-30' AS Date), 6.6700, 0.1700, NULL, 0.0000)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (114, 1, 2020, CAST(N'2020-12-09' AS Date), 2020, N'320055005', CAST(N'2020-07-01' AS Date), CAST(N'2020-10-31' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-08-25' AS Date), CAST(N'2020-08-26' AS Date), CAST(N'2020-10-31' AS Date), 6.7200, 0.1700, NULL, 99.2900)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (115, 1, 2021, CAST(N'2021-05-31' AS Date), 2021, N'32016452', CAST(N'2020-11-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(N'2020-08-26' AS Date), CAST(N'2020-12-10' AS Date), CAST(N'2020-12-11' AS Date), CAST(N'2021-02-28' AS Date), 6.5600, 0.1700, NULL, 121.0100)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (116, 1, 2021, CAST(N'2021-10-29' AS Date), 2021, N'32035363', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(N'2020-12-11' AS Date), CAST(N'2021-06-22' AS Date), CAST(N'2021-06-23' AS Date), CAST(N'2021-06-30' AS Date), 6.6800, 0.1700, NULL, 34.3900)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (117, 1, 2022, CAST(N'2022-01-26' AS Date), 2022, N'32003826', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(N'2021-06-23' AS Date), CAST(N'2021-09-10' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), 6.7400, 0.1700, NULL, 76.4200)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (118, 1, 2022, CAST(N'2022-09-26' AS Date), 2022, N'32048878', CAST(N'2022-03-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2022-03-28' AS Date), CAST(N'2022-07-12' AS Date), CAST(N'2022-07-31' AS Date), 8.3800, 0.1700, NULL, 110.3600)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (119, 1, 2023, CAST(N'2023-01-04' AS Date), 2023, N'32003679', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-10-10' AS Date), NULL, CAST(N'2022-11-30' AS Date), 6.6800, 0.1700, -13.6700, 72.1600)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (120, 1, 2023, CAST(N'2023-06-26' AS Date), 2023, N'32023573', CAST(N'2022-12-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-31' AS Date), NULL, NULL, 6.6300, 0.1700, NULL, 67.9200)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (121, 1, 2023, CAST(N'2023-09-29' AS Date), 2023, N'32043400', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), NULL, CAST(N'2023-07-31' AS Date), NULL, NULL, 6.6800, 0.1700, NULL, 68.5500)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (122, 2, 2021, CAST(N'2021-05-31' AS Date), 2021, N'32015853', CAST(N'2020-11-01' AS Date), CAST(N'2021-02-28' AS Date), CAST(N'2020-08-19' AS Date), CAST(N'2020-11-30' AS Date), CAST(N'2020-12-01' AS Date), CAST(N'2021-02-28' AS Date), 6.5600, 0.1700, NULL, 26.8900)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (123, 2, 2021, CAST(N'2021-10-29' AS Date), 2021, N'32034789', CAST(N'2021-03-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(N'2020-12-01' AS Date), CAST(N'2021-04-16' AS Date), CAST(N'2021-06-12' AS Date), CAST(N'2021-06-30' AS Date), 6.6800, 0.1700, NULL, 32.5300)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (124, 2, 2022, CAST(N'2022-01-26' AS Date), 2022, N'32003247', CAST(N'2021-07-01' AS Date), CAST(N'2021-10-31' AS Date), CAST(N'2021-06-12' AS Date), CAST(N'2021-09-10' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-10-31' AS Date), 6.7400, 0.1700, NULL, 30.4100)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (125, 2, 2022, CAST(N'2022-05-31' AS Date), 2022, N'32028444', CAST(N'2021-11-01' AS Date), CAST(N'2022-02-28' AS Date), CAST(N'2021-09-11' AS Date), CAST(N'2021-12-21' AS Date), CAST(N'2021-12-22' AS Date), CAST(N'2022-02-28' AS Date), 6.5700, 0.1700, NULL, 31.3000)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (126, 2, 2022, CAST(N'2022-09-26' AS Date), 2022, N'32048325', CAST(N'2022-03-01' AS Date), CAST(N'2022-07-31' AS Date), CAST(N'2021-12-22' AS Date), CAST(N'2022-04-19' AS Date), CAST(N'2022-07-06' AS Date), CAST(N'2022-07-31' AS Date), 8.3800, 0.1700, NULL, 45.8600)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (127, 2, 2023, CAST(N'2023-01-04' AS Date), 2023, N'32003129', CAST(N'2022-08-01' AS Date), CAST(N'2022-11-30' AS Date), NULL, CAST(N'2022-10-05' AS Date), NULL, CAST(N'2022-11-30' AS Date), 6.6800, 0.1700, -5.7500, 45.0100)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (128, 2, 2023, CAST(N'2023-06-26' AS Date), 2023, N'32023024', CAST(N'2022-12-01' AS Date), CAST(N'2023-03-31' AS Date), NULL, CAST(N'2023-03-31' AS Date), NULL, NULL, 6.6300, 0.1700, NULL, 49.4200)
INSERT [dbo].[H2OFattura] ([idH2OFattura], [idIntesta], [annoComp], [DataEmiss], [fattNrAnno], [fattNrNumero], [periodFattDtIniz], [periodFattDtFine], [periodCongDtIniz], [periodCongDtFine], [periodAccontoDtIniz], [periodAccontoDtFine], [assicurazione], [impostaQuiet], [RestituzAccPrec], [TotPagare]) VALUES (129, 2, 2023, CAST(N'2023-09-29' AS Date), 2023, N'32042855', CAST(N'2023-04-01' AS Date), CAST(N'2023-07-31' AS Date), NULL, CAST(N'2023-07-10' AS Date), NULL, CAST(N'2023-07-31' AS Date), 6.6800, 0.1700, -54.3900, 17.5100)
SET IDENTITY_INSERT [dbo].[H2OFattura] OFF
SET IDENTITY_INSERT [dbo].[H2OLettura] ON 

INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (337, 101, 6369, CAST(N'2019-06-10' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (338, 101, 6380, CAST(N'2019-09-24' AS Date), N'eff', 11)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (339, 101, NULL, NULL, N'stim', 1)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (340, 101, NULL, NULL, N'tot', 12)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (341, 102, 6380, CAST(N'2019-09-24' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (342, 102, NULL, NULL, N'stim', 12)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (343, 102, NULL, NULL, N'tot', 12)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (344, 103, 6380, CAST(N'2019-09-24' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (345, 103, 6450, CAST(N'2020-05-22' AS Date), N'eff', 70)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (346, 103, NULL, NULL, N'stim', 4)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (347, 103, NULL, NULL, N'tot', 74)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (348, 104, 6450, CAST(N'2020-05-22' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (349, 104, 6455, CAST(N'2020-08-18' AS Date), N'eff', 5)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (350, 104, NULL, NULL, N'stim', 22)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (351, 104, NULL, NULL, N'tot', 27)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (352, 105, 6456, CAST(N'2020-11-26' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (353, 105, 6545, CAST(N'2021-06-11' AS Date), N'eff', 89)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (354, 105, NULL, NULL, N'stim', 0)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (355, 105, NULL, NULL, N'tot', 89)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (356, 106, 6545, CAST(N'2021-06-11' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (357, 106, 6552, CAST(N'2021-09-10' AS Date), N'eff', 7)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (358, 106, NULL, NULL, N'stim', 23)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (359, 106, NULL, NULL, N'tot', 30)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (360, 107, 6552, CAST(N'2021-09-10' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (361, 107, 6581, CAST(N'2021-12-22' AS Date), N'eff', 29)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (362, 107, NULL, NULL, N'stim', 5)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (363, 107, NULL, NULL, N'tot', 34)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (364, 108, 6581, CAST(N'2021-12-22' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (365, 108, 6665, CAST(N'2022-07-05' AS Date), N'eff', 84)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (366, 108, NULL, NULL, N'stim', 8)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (367, 108, NULL, NULL, N'tot', 92)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (368, 109, 6665, CAST(N'2022-07-05' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (369, 109, 6666, CAST(N'2022-10-05' AS Date), N'eff', 1)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (370, 109, NULL, NULL, N'stim', 24)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (371, 109, NULL, NULL, N'tot', 25)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (372, 110, 6666, CAST(N'2022-10-05' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (373, 110, NULL, NULL, N'stim', 0)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (374, 110, NULL, NULL, N'tot', 0)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (375, 111, 6666, CAST(N'2022-10-05' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (376, 111, 6756, CAST(N'2023-07-10' AS Date), N'eff', 90)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (377, 111, NULL, NULL, N'stim', 0)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (378, 111, NULL, NULL, N'tot', 90)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (379, 112, 1020, CAST(N'2019-10-04' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (380, 112, NULL, NULL, N'stim', 63)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (381, 112, NULL, NULL, N'tot', 63)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (382, 113, 1020, CAST(N'2019-10-04' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (383, 113, 1079, CAST(N'2020-05-28' AS Date), N'eff', 59)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (384, 113, NULL, NULL, N'stim', 18)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (385, 113, NULL, NULL, N'tot', 77)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (386, 114, 1079, CAST(N'2020-05-28' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (387, 114, 1136, CAST(N'2020-08-25' AS Date), N'eff', 57)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (388, 114, NULL, NULL, N'stim', 17)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (389, 114, NULL, NULL, N'tot', 74)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (390, 115, 1136, CAST(N'2020-08-25' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (391, 115, 1171, CAST(N'2020-12-10' AS Date), N'eff', 35)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (392, 115, NULL, NULL, N'stim', 52)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (393, 115, NULL, NULL, N'tot', 87)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (394, 116, 1171, CAST(N'2020-12-10' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (395, 116, 1251, CAST(N'2021-06-22' AS Date), N'eff', 80)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (396, 116, NULL, NULL, N'stim', 3)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (397, 116, NULL, NULL, N'tot', 83)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (398, 117, 1251, CAST(N'2021-06-22' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (399, 117, 1283, CAST(N'2021-09-10' AS Date), N'eff', 32)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (400, 117, NULL, NULL, N'stim', 21)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (401, 117, NULL, NULL, N'tot', 53)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (402, 118, 1283, CAST(N'2021-09-10' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (403, 118, 1346, CAST(N'2022-03-28' AS Date), N'eff', 63)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (404, 118, 1398, CAST(N'2022-07-11' AS Date), N'eff', 52)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (405, 118, NULL, NULL, N'stim', 8)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (406, 118, NULL, NULL, N'tot', 123)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (407, 119, 1398, CAST(N'2022-07-11' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (408, 119, 1426, CAST(N'2022-10-10' AS Date), N'eff', 28)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (409, 119, NULL, NULL, N'stim', 19)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (410, 119, NULL, NULL, N'tot', 47)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (411, 120, 1426, CAST(N'2022-10-10' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (412, 120, NULL, NULL, N'stim', 36)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (413, 120, NULL, NULL, N'tot', 36)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (414, 121, 1426, CAST(N'2022-10-10' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (415, 121, NULL, NULL, N'stim', 36)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (416, 121, NULL, NULL, N'tot', 36)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (417, 122, 4856, CAST(N'2020-08-18' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (418, 122, 4871, CAST(N'2020-11-30' AS Date), N'eff', 15)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (419, 122, NULL, NULL, N'stim', 14)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (420, 122, NULL, NULL, N'tot', 29)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (421, 123, 4871, CAST(N'2020-11-30' AS Date), N'eff', NULL)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (422, 123, 4894, CAST(N'2021-04-16' AS Date), N'eff', 23)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (423, 123, NULL, NULL, N'stim', 3)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (424, 123, NULL, NULL, N'tot', 36)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (425, 124, NULL, NULL, N'stim', 8)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (426, 124, NULL, NULL, N'tot', 23)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (427, 125, NULL, NULL, N'stim', 12)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (428, 125, NULL, NULL, N'tot', 29)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (429, 126, NULL, NULL, N'stim', 4)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (430, 126, NULL, NULL, N'tot', 38)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (431, 127, NULL, NULL, N'stim', 9)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (432, 127, NULL, NULL, N'tot', 29)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (433, 128, NULL, NULL, N'stim', 27)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (434, 128, NULL, NULL, N'tot', 27)
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (435, 129, NULL, NULL, N'stim', 5)
GO
INSERT [dbo].[H2OLettura] ([idLettura], [idH2OFattura], [lettQtaMc], [LettData], [TipoLett], [Consumofatt]) VALUES (436, 129, NULL, NULL, N'tot', 43)
SET IDENTITY_INSERT [dbo].[H2OLettura] OFF
SET IDENTITY_INSERT [dbo].[Intesta] ON 

INSERT [dbo].[Intesta] ([idIntesta], [NomeIntesta], [dirfatture]) VALUES (1, N'claudio', N'F:\Google Drive\SMichele\AASS')
INSERT [dbo].[Intesta] ([idIntesta], [NomeIntesta], [dirfatture]) VALUES (2, N'andrea', N'F:\varie\AASS\Andrea')
INSERT [dbo].[Intesta] ([idIntesta], [NomeIntesta], [dirfatture]) VALUES (3, N'alessandro', N'F:\varie\AASS\Alessandro')
SET IDENTITY_INSERT [dbo].[Intesta] OFF
ALTER TABLE [dbo].[EEConsumo]  WITH CHECK ADD  CONSTRAINT [FK_EEConsumo_EEFattura] FOREIGN KEY([idEEFattura])
REFERENCES [dbo].[EEFattura] ([idEEFattura])
GO
ALTER TABLE [dbo].[EEConsumo] CHECK CONSTRAINT [FK_EEConsumo_EEFattura]
GO
ALTER TABLE [dbo].[EEFattura]  WITH CHECK ADD  CONSTRAINT [FK_EEFattura_Intesta] FOREIGN KEY([idIntesta])
REFERENCES [dbo].[Intesta] ([idIntesta])
GO
ALTER TABLE [dbo].[EEFattura] CHECK CONSTRAINT [FK_EEFattura_Intesta]
GO
ALTER TABLE [dbo].[EELettura]  WITH CHECK ADD  CONSTRAINT [FK_EELettura_EEFattura] FOREIGN KEY([idEEFattura])
REFERENCES [dbo].[EEFattura] ([idEEFattura])
GO
ALTER TABLE [dbo].[EELettura] CHECK CONSTRAINT [FK_EELettura_EEFattura]
GO
ALTER TABLE [dbo].[GASConsumo]  WITH CHECK ADD  CONSTRAINT [FK_GASConsumo_GASFattura] FOREIGN KEY([idGASFattura])
REFERENCES [dbo].[GASFattura] ([idGASFattura])
GO
ALTER TABLE [dbo].[GASConsumo] CHECK CONSTRAINT [FK_GASConsumo_GASFattura]
GO
ALTER TABLE [dbo].[GASFattura]  WITH CHECK ADD  CONSTRAINT [FK_GASFattura_Intesta] FOREIGN KEY([idIntesta])
REFERENCES [dbo].[Intesta] ([idIntesta])
GO
ALTER TABLE [dbo].[GASFattura] CHECK CONSTRAINT [FK_GASFattura_Intesta]
GO
ALTER TABLE [dbo].[GASLettura]  WITH CHECK ADD  CONSTRAINT [FK_GASLettura_GASFattura] FOREIGN KEY([idGASFattura])
REFERENCES [dbo].[GASFattura] ([idGASFattura])
GO
ALTER TABLE [dbo].[GASLettura] CHECK CONSTRAINT [FK_GASLettura_GASFattura]
GO
ALTER TABLE [dbo].[H2OConsumo]  WITH CHECK ADD  CONSTRAINT [FK_H2OConsumo_H2OFattura] FOREIGN KEY([idH2OFattura])
REFERENCES [dbo].[H2OFattura] ([idH2OFattura])
GO
ALTER TABLE [dbo].[H2OConsumo] CHECK CONSTRAINT [FK_H2OConsumo_H2OFattura]
GO
ALTER TABLE [dbo].[H2OFattura]  WITH CHECK ADD  CONSTRAINT [FK_H2OFattura_Intesta] FOREIGN KEY([idIntesta])
REFERENCES [dbo].[Intesta] ([idIntesta])
GO
ALTER TABLE [dbo].[H2OFattura] CHECK CONSTRAINT [FK_H2OFattura_Intesta]
GO
ALTER TABLE [dbo].[H2OLettura]  WITH CHECK ADD  CONSTRAINT [FK_H2OLettura_H2OFattura] FOREIGN KEY([idH2OFattura])
REFERENCES [dbo].[H2OFattura] ([idH2OFattura])
GO
ALTER TABLE [dbo].[H2OLettura] CHECK CONSTRAINT [FK_H2OLettura_H2OFattura]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE  PROCEDURE [dbo].[cercaBuchiDateConsumoEE](  @Nomeintesta varchar(128)  )
 AS
DECLARE	@dtMin decimal(6,2),
		@dtMax decimal(6,2),
		@dec decimal(6,2),
		@dtCurr date
		


SELECT @dtMin = min(dtIniz), 
	   @dtMax = max(dtIniz)
  FROM dbo.EEConsumoMensile
  WHERE NomeIntesta=@Nomeintesta


SET @dtCurr = CAST( REPLACE( CAST(@dtMin as  varchar(18)) + '.01', '.', '-') as date)
SET @dec = dbo.toAnnoMese(@dtCurr)

CREATE TABLE #miedate ( miadt decimal(6,2) )

WHILE @dec <= @dtMax
BEGIN
   INSERT into #miedate VALUES (@dec) 
   SET @dtCurr = DATEADD(m, 1, @dtCurr)
   SET @dec = dbo.toAnnoMese(@dtCurr)
END

SELECT *
   FROM #miedate
   WHERE miadt NOT IN 
		( SELECT   dtIniz
            FROM aass.dbo.EEConsumoMensile
           WHERE NomeIntesta=@Nomeintesta
	    )
DROP TABLE #miedate
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[deleteFatture]( @idItesta int = 1 ) 
AS

DELETE FROM EEconsumo 
	WHERE idEEFattura in ( 
		SELECT idEEFattura 
		  FROM dbo.EEFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM EELettura 
	WHERE idEEFattura in ( 
		SELECT idEEFattura 
		  FROM dbo.EEFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM EEFattura
	where idIntesta = @idItesta



DELETE FROM GASconsumo 
	WHERE idGASFattura in ( 
		SELECT idGASFattura 
		  FROM dbo.GASFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM GASLettura 
	WHERE idGASFattura in ( 
		SELECT idGASFattura 
		  FROM dbo.GASFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM GASFattura
	where idIntesta = @idItesta


DELETE FROM H2Oconsumo 
	WHERE idH2OFattura in ( 
		SELECT idH2OFattura 
		  FROM dbo.H2OFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM H2OLettura 
	WHERE idH2OFattura in ( 
		SELECT idH2OFattura 
		  FROM dbo.H2OFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM H2OFattura
	where idIntesta = @idItesta

GO
USE [master]
GO
ALTER DATABASE [aass] SET  READ_WRITE 
GO
