CREATE VIEW [dbo].[H2OConsumoMensile]
AS
SELECT te.NomeIntesta 
      ,cs.idH2OFattura
      ,YEAR(cs.dtIniz) as annoComp
      ,cs.dtIniz
      ,cs.dtFine
	  -- ,dbo.EESumLettAttuale(cs.idEEFattura) as totLett
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
      ,cs.importo
  FROM aass.dbo.H2OConsumo as cs
	  INNER JOIN dbo.H2OFattura as ft
		 ON ft.idH2OFattura=cs.idH2OFattura
	  INNER JOIN dbo.intesta as te
		 ON ft.idIntesta=te.idIntesta
--   WHERE dbo.EESumLettAttuale(cs.idH2OFattura) > 0
GO

