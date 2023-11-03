USE [aass]
GO
ALTER TABLE [dbo].[EELettura] DROP CONSTRAINT [FK_EELettura_EEFattura]
GO
ALTER TABLE [dbo].[EEConsumo] DROP CONSTRAINT [FK_EEConsumo_EEFattura]
GO
DROP TABLE [dbo].[EELettura]
GO
DROP TABLE [dbo].[EEFattura]
GO
DROP TABLE [dbo].[EEConsumo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EEConsumo](
	[idEEConsumo] [int] IDENTITY(1,1) NOT NULL,
	[idEEFattura] [int] NOT NULL,
	[tipoSpesa] [nvarchar](2) COLLATE Latin1_General_CI_AS NULL,
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
CREATE TABLE [dbo].[EEFattura](
	[idEEFattura] [int] IDENTITY(1,1) NOT NULL,
	[annoComp] [int] NULL,
	[DataEmiss] [date] NULL,
	[fattNrAnno] [int] NULL,
	[fattNrNumero] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
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
