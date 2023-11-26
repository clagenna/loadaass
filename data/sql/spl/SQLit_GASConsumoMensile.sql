CREATE VIEW GASConsumoMensile AS SELECT te.NomeIntesta 
      ,cs.idGASFattura
      --,dbo.toAnnoMese(cs.dtIniz) as dtIniz
      --,dbo.toAnnoMese(cs.dtFine) as dtFine
      ,cs.dtIniz as dtIniz
      ,cs.dtFine as dtFine
      ,cs.tipoSpesa
      ,cs.prezzoUnit
      ,cs.quantita
      ,JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1 as qtaGG
      ,cs.quantita / (JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1) as mediaGG
      ,cs.importo
  FROM GASConsumo as cs
    INNER JOIN GASFattura as ft
       ON ft.idGASFattura=cs.idGASFattura
    INNER JOIN intesta as te
      ON ft.idIntesta=te.idIntesta
WHERE  ft.periodEffDtIniz IS NOT NULL
   AND cs.dtIniz BETWEEN ft.periodEffDtIniz  AND ft.periodEffDtFine
;

