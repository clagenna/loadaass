CREATE VIEW [dbo].[GASConsumoMensile]
AS
SELECT te.NomeIntesta 
      ,cs.idGASFattura
      ,YEAR(cs.dtIniz) as annoComp
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
WHERE  1=1
   --  AND ft.periodEffDtIniz IS NOT NULL
	  AND cs.dtIniz BETWEEN
	      -- ft.periodEffDtIniz  
		  ( SELECT MIN(lt.lettData) 
		      FROM dbo.GASLettura as lt
		     WHERE lt.idGASFattura=ft.idGASFattura )
	   AND 
	      -- ft.periodEffDtFine
  		  ( SELECT MAX(lt.lettData) 
		      FROM dbo.GASLettura as lt
		     WHERE lt.idGASFattura=ft.idGASFattura )

GO

