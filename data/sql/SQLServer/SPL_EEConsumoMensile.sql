CREATE VIEW [dbo].[EEConsumoMensile]
AS
SELECT te.NomeIntesta 
      ,cs.idEEFattura
      ,YEAR(cs.dtIniz) as annoComp
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

