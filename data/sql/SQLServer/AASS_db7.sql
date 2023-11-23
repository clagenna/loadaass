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
WHERE  ft.periodEffDtIniz IS NOT NULL
	  AND cs.dtIniz BETWEEN ft.periodEffDtIniz  AND ft.periodEffDtFine
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
	 --, (ISNULL(G1,0) +
	 --  ISNULL(G2,0) +
	 --  ISNULL(G3,0) ) / qtaGG as mediaGG
  FROM (
	SELECT NomeIntesta
	     , idGASFattura
		 , tipoSpesa
		 , dtIniz
		 , dtFine
		 , (DATEDIFF(d, dtIniz, dtFine) + 1) as qtaGG
		 , ISNULL(importo, 0) as importo
     FROM 	dbo.GASConsumoMensile
) consunit PIVOT (
  SUM(importo)
  FOR tipoSpesa in ( G1, G2, G3 )
) AS pivCons

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[GASScaglioniQuantita]
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
	SELECT NomeIntesta
	     , idGASFattura
		 , tipoSpesa
		 , dtIniz
		 , dtFine
		 , (DATEDIFF(d, dtIniz, dtFine) + 1) as qtaGG
		 , ISNULL(quantita, 0) as quantita
     FROM 	dbo.GASConsumoMensile
) consunit PIVOT (
  SUM(quantita)
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prova](
	[chiave] [int] NOT NULL,
	[stringa] [text] NULL,
	[intero] [int] NULL,
	[prezzo] [real] NULL,
	[dataoggi] [text] NULL,
	[percento] [real] NULL,
	[flottante] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[chiave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
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
