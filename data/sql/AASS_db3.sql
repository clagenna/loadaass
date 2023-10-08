USE [master]
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

ALTER SERVER ROLE [sysadmin] ADD MEMBER [sqlserver]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [sqlgianni]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [sqlgestore]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [sqladmin]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\Winmgmt]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLWriter]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLSERVERAGENT]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT Service\MSSQLSERVER]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [claudio]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [CASA2019\claudio]
GO
USE [aass]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EEFattura](
	[idEEFattura] [int] IDENTITY(1,1) NOT NULL,
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
create view [dbo].[EETotConsumo]
as
SELECT fa.idEEFattura
      ,fa.annoComp
      ,fa.DataEmiss
      ,fa.fattNrAnno
      ,fa.fattNrNumero
      ,fa.periodFattDtIniz
      ,fa.periodFattDtFine
      ,fa.CredPrecKwh
      ,fa.CredAttKwh
      ,fa.addizFER
      ,fa.impostaQuiet
      ,fa.TotPagare
	  , sum(le.LettConsumo) as consumo
  FROM dbo.EEFattura as fa
  inner join dbo.EELettura as le
    on le.idEEFattura=fa.idEEFattura
GROUP BY fa.idEEFattura
      ,fa.annoComp
      ,fa.DataEmiss
      ,fa.fattNrAnno
      ,fa.fattNrNumero
      ,fa.periodFattDtIniz
      ,fa.periodFattDtFine
      ,fa.CredPrecKwh
      ,fa.CredAttKwh
      ,fa.addizFER
      ,fa.impostaQuiet
      ,fa.TotPagare
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[EEConsumoAnnuo]
as
SELECT annoComp
      ,sum(TotPagare) as TotPagare
      ,sum(consumo)   as TotConsumo
  FROM aass.dbo.EETotConsumo
group by annoComp
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
ALTER TABLE [dbo].[H2OLettura]  WITH CHECK ADD  CONSTRAINT [FK_H2OLettura_H2OFattura] FOREIGN KEY([idH2OFattura])
REFERENCES [dbo].[H2OFattura] ([idH2OFattura])
GO
ALTER TABLE [dbo].[H2OLettura] CHECK CONSTRAINT [FK_H2OLettura_H2OFattura]
GO
USE [master]
GO
ALTER DATABASE [aass] SET  READ_WRITE 
GO
