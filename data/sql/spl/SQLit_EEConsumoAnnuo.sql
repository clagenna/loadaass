CREATE VIEW EEConsumoAnnuo AS
    SELECT NomeIntesta,
           CAST (dtIniz AS INT) AS anno,
           SUM(importo) AS totAnno
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              CAST (dtIniz AS INT);

