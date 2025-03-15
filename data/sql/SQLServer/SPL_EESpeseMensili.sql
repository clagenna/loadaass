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

