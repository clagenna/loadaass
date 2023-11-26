CREATE VIEW EEConsumoMensPivot AS SELECT te.NomeIntesta,
       cs.dtIniz,
--       cast(cs.dtIniz as int) as anno,
--       cs.tipoSpesa,
       SUM(case when cs.tipospesa = 'E1' then cs.importo end) as E1,
       SUM(case when cs.tipospesa = 'E2' then cs.importo end) as E2,
       SUM(case when cs.tipospesa = 'P' then cs.importo end) as P,
       SUM(case when cs.tipospesa = 'R' then cs.importo end) as R,
       SUM(case when cs.tipospesa = 'PU' then cs.importo end) as PU,
       SUM(case when cs.tipospesa = 'S1' then cs.importo end) as S1,
       SUM(case when cs.tipospesa = 'S2' then cs.importo end) as S2
--       ,cs.quantita
--       ,cs.importo      
   FROM EEConsumo AS cs           
     INNER JOIN EEFattura AS ft 
         ON ft.idEEFattura = cs.idEEFattura
     INNER JOIN intesta AS te
         ON ft.idIntesta = te.idIntesta
 WHERE 1=1
GROUP BY te.nomeIntesta, cs.dtIniz
ORDER BY te.nomeIntesta, cs.dtIniz
;

