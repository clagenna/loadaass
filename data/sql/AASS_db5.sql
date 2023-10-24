USE [aass]
GO
DROP PROCEDURE [dbo].[deleteFatture]
GO
DROP PROCEDURE [dbo].[cercaBuchiDateConsumoEE]
GO
ALTER TABLE [dbo].[H2OLettura] DROP CONSTRAINT [FK_H2OLettura_H2OFattura]
GO
ALTER TABLE [dbo].[H2OFattura] DROP CONSTRAINT [FK_H2OFattura_Intesta]
GO
ALTER TABLE [dbo].[H2OConsumo] DROP CONSTRAINT [FK_H2OConsumo_H2OFattura]
GO
ALTER TABLE [dbo].[GASLettura] DROP CONSTRAINT [FK_GASLettura_GASFattura]
GO
ALTER TABLE [dbo].[GASFattura] DROP CONSTRAINT [FK_GASFattura_Intesta]
GO
ALTER TABLE [dbo].[GASConsumo] DROP CONSTRAINT [FK_GASConsumo_GASFattura]
GO
ALTER TABLE [dbo].[EELettura] DROP CONSTRAINT [FK_EELettura_EEFattura]
GO
ALTER TABLE [dbo].[EEFattura] DROP CONSTRAINT [FK_EEFattura_Intesta]
GO
ALTER TABLE [dbo].[EEConsumo] DROP CONSTRAINT [FK_EEConsumo_EEFattura]
GO
DROP TABLE [dbo].[H2OLettura]
GO
DROP TABLE [dbo].[H2OFattura]
GO
DROP TABLE [dbo].[H2OConsumo]
GO
DROP TABLE [dbo].[GASLettura]
GO
DROP VIEW [dbo].[GASElencoConsumi]
GO
DROP TABLE [dbo].[GASFattura]
GO
DROP VIEW [dbo].[GASScaglioniPrezzoUnit]
GO
DROP VIEW [dbo].[GASScaglioniImporto]
GO
DROP TABLE [dbo].[GASConsumo]
GO
DROP VIEW [dbo].[EEScaglioniImporti]
GO
DROP VIEW [dbo].[EELettureMensili]
GO
DROP TABLE [dbo].[EELettura]
GO
DROP VIEW [dbo].[EEConsumoAnnuo]
GO
DROP VIEW [dbo].[EEConsumoMensile]
GO
DROP VIEW [dbo].[EESpeseMensili]
GO
DROP VIEW [dbo].[EEScaglioniPrezzoUnit]
GO
DROP TABLE [dbo].[Intesta]
GO
DROP TABLE [dbo].[EEConsumo]
GO
DROP TABLE [dbo].[EEFattura]
GO
DROP FUNCTION [dbo].[toAnnoMese]
GO
DROP FUNCTION [dbo].[EESumLettAttuale]
GO
USE [master]
GO
DROP DATABASE [aass]
GO
CREATE DATABASE [aass]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'aass', FILENAME = N'F:\sql2017\MSSQL14.MSSQLSERVER\MSSQL\DATA\aass.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'aass_log', FILENAME = N'F:\sql2017\MSSQL14.MSSQLSERVER\MSSQL\DATA\aass_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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

CREATE VIEW [dbo].[EEScaglioniPrezzoUnit]
AS
SELECT * FROM (
	SELECT te.NomeIntesta,
	       cs.tipoSpesa,
	       cs.dtIniz,
		   cs.prezzoUnit
	  FROM dbo.EEConsumo as cs
 	    INNER JOIN dbo.EEFattura as ft
        ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN dbo.intesta as te
        ON ft.idIntesta=te.idIntesta

	  WHERE cs.tipoSpesa in ( 'E1','E2','E3', 'R' )
 ) consunit  PIVOT (
	SUM(prezzoUnit)
	FOR tipoSpesa in ( [E1],[E2], [E3], [R] )
 ) AS pivot_cons
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[EESpeseMensili]
as
SELECT te.nomeIntesta,
       CONVERT(DECIMAL(6,2), CAST(YEAR(cs.dtIniz) as float ) +  CAST(DATEPART(m, cs.dtIniz) as float) / 100 ) as mese,
       SUM(cs.quantita) as quantita,
	   SUM(cs.importo) as importo
  FROM dbo.EEConsumo as cs
   	    INNER JOIN dbo.EEFattura as ft
        ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN dbo.intesta as te
        ON ft.idIntesta=te.idIntesta

GROUP BY te.nomeIntesta, CAST(YEAR(cs.dtIniz) as float ) +  CAST(DATEPART(m, cs.dtIniz) as float) / 100 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[EEConsumoMensile]
AS
SELECT te.NomeIntesta 
      ,cs.idEEFattura
      ,CONVERT(decimal(6,2), cast(year(cs.dtIniz) as float) + cast(datepart(M,cs.dtIniz) as float) / 100) as dtIniz
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
CREATE TABLE [dbo].[EELettura](
	[idLettura] [int] IDENTITY(1,1) NOT NULL,
	[idEEFattura] [int] NOT NULL,
	[LettDtPrec] [date] NULL,
	[LettPrec] [int] NULL,
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
create view [dbo].[EELettureMensili]
as
SELECT te.NomeIntesta
      ,le.idLettura
      ,le.idEEFattura
      ,dbo.toAnnoMese(le.LettDtPrec) as lettDtPrec
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




CREATE view [dbo].[EEScaglioniImporti]
AS
SELECT 
	NomeIntesta,
	dtIniz,
	ISNULL([E1], 0) AS [E1],
	ISNULL([E2], 0) AS [E2],
	ISNULL([E3], 0) AS [E3],
	ISNULL([R],  0) AS [R],
	ISNULL([P],  0) AS [P]
 FROM (
	SELECT te.NomeIntesta,
	       cs.tipoSpesa,
	       CONVERT( DECIMAL(6,2)
			   , CAST( YEAR(cs.dtIniz) as float) 
			   + CAST(DATEPART(M, cs.dtIniz) as float) / 100 ) as dtIniz,
		   ISNULL(cs.importo, 0) as importo
	  FROM dbo.EEConsumo as cs
	    INNER JOIN dbo.EEFattura as ft
        ON ft.idEEFattura=cs.idEEFattura
        INNER JOIN dbo.intesta as te
        ON ft.idIntesta=te.idIntesta
	  WHERE cs.tipoSpesa in ( 'E1','E2','E3', 'R', 'P' )
	    AND dbo.EESumLettAttuale(cs.idEEFattura) > 0
 ) consunit  PIVOT (
	SUM(importo)
	FOR tipoSpesa in ( [E1],[E2], [E3], [R], [P] )
 ) AS pivot_cons
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
CREATE VIEW [dbo].[GASScaglioniImporto]
AS
SELECT * FROM (
	SELECT cs.tipoSpesa,
	       cs.dtIniz,
		   cs.importo
	  FROM dbo.GASConsumo as cs
	  WHERE cs.tipoSpesa in ( 'G1','G2','G3', 'R' )
 ) consunit  PIVOT (
	SUM(importo)
	FOR tipoSpesa in ( [G1],[G2], [G3], [R] )
 ) AS pivot_cons
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GASScaglioniPrezzoUnit]
AS
SELECT * FROM (
	SELECT cs.tipoSpesa,
	       cs.dtIniz,
		   cs.prezzoUnit
	  FROM dbo.GASConsumo as cs
	  WHERE cs.tipoSpesa in ( 'G1','G2','G3' )
 ) consunit  PIVOT (
	SUM(prezzoUnit)
	FOR tipoSpesa in ( [G1],[G2], [G3] )
 ) AS pivot_cons
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
CREATE view [dbo].[GASElencoConsumi]
as
SELECT
	CAST(YEAR(cs.dtIniz) as float) + CAST(DATEPART(m, cs.dtIniz) as float) / 100 as mese,
	ft.DataEmiss,
	cs.tipospesa,
	cs.prezzoUnit,
	cs.quantita,
	cs.importo,
	cs.dtIniz, cs.dtFine
FROM dbo.GASFattura as ft
  INNER JOIN dbo.GASConsumo as cs
  ON ft.idGASFattura=cs.idGASFattura
-- order by CAST(YEAR(cs.dtIniz) as float) + CAST(DATEPART(m, cs.dtIniz) as float) / 100, cs.tipoSpesa, ft.DataEmiss
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
