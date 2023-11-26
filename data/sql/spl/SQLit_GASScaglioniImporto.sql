CREATE VIEW GASScaglioniImporto AS SELECT NomeIntesta
     , idGASFattura
     , dtIniz
     , dtFine
     , JULIANDAY(dtFine) - JULIANDAY(dtIniz) + 1 as qtaGG
     , SUM(case when tipospesa = 'G1' then importo end) as Scagl1
     , SUM(case when tipospesa = 'G2' then importo end) as Scagl2
     , SUM(case when tipospesa = 'G3' then importo end) as Scagl3

     , COALESCE( SUM(case when tipospesa = 'G1' then importo end), 0)
     + COALESCE( SUM(case when tipospesa = 'G2' then importo end), 0)
     + COALESCE( SUM(case when tipospesa = 'G3' then importo end), 0) as Totale
     

     , ( COALESCE( SUM(case when tipospesa = 'G1' then importo end), 0)
       + COALESCE( SUM(case when tipospesa = 'G2' then importo end), 0)
       + COALESCE( SUM(case when tipospesa = 'G3' then importo end), 0) )
     / (JULIANDAY(dtFine) - JULIANDAY(dtIniz) + 1) as mediaGG
		 
     FROM 	GASConsumoMensile
GROUP BY NomeIntesta
     , idGASFattura
     , dtIniz
     , dtFine;

