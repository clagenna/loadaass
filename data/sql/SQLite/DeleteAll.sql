CREATE TEMP TABLE IF NOT EXISTS vars( pIdIntesta INTEGER );
CREATE TEMP TABLE IF NOT EXISTS idf( idEEFattura INTEGER );
-- ----------------------------------
INSERT INTO vars VALUES(3);
-- ----------------------------------

-- ---------------  ELETTRICITA  -----------------------------------
INSERT INTO idf
     SELECT idEEFattura 
       FROM EEFattura 
      WHERE idIntesta IN ( SELECT pIdIntesta FROM vars );
      
DELETE FROM EEConsumo
   WHERE idEEFattura IN ( SELECT idEEFattura FROM idf );

DELETE FROM EELettura
   WHERE idEEFattura IN (
       SELECT idEEFattura 
         FROM idf
   );

DELETE FROM EEFattura
   WHERE idEEFattura IN (
       SELECT idEEFattura 
         FROM idf
   );
   
-- ---------------  GAS  -----------------------------------
DELETE FROM idf;
INSERT INTO idf
     SELECT idGASFattura 
       FROM GASFattura 
      WHERE idIntesta IN ( SELECT pIdIntesta FROM vars );

DELETE FROM GASConsumo
   WHERE idGASFattura IN ( SELECT idGASFattura FROM idf );

DELETE FROM GASLettura
   WHERE idGASFattura IN (
       SELECT idGASFattura 
         FROM idf
   );

DELETE FROM GASFattura
   WHERE idGASFattura IN (
       SELECT idGASFattura 
         FROM idf
   );

-- ----------------  ACQUA  ----------------------------------
DELETE FROM idf;
INSERT INTO idf
     SELECT idH2OFattura 
       FROM H2OFattura 
      WHERE idIntesta IN ( SELECT pIdIntesta FROM vars );
      
DELETE FROM H2OConsumo
   WHERE idH2OFattura IN ( SELECT idH2OFattura FROM idf );

DELETE FROM H2OLettura
   WHERE idH2OFattura IN (
       SELECT idH2OFattura 
         FROM idf
   );

DELETE FROM H2OFattura
   WHERE idH2OFattura IN (
       SELECT idH2OFattura 
         FROM idf
   );

   
DROP TABLE IF EXISTS vars;
DROP TABLE IF EXISTS idf;
