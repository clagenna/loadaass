CREATE VIEW EEConsumoMensile AS SELECT te.NomeIntesta,           
       cs.idEEFattura,           
       cs.dtIniz,           
       cast(cs.dtIniz as int) as annoComp,           
       cs.tipoSpesa,           
       cs.prezzoUnit,           
       cs.quantita,           
       cs.importo      
   FROM EEConsumo AS cs           
     INNER JOIN EEFattura AS ft 
         ON ft.idEEFattura = cs.idEEFattura           
     INNER JOIN intesta AS te 
         ON ft.idIntesta = te.idIntesta     
 WHERE 1=1;

