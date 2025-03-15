USE [aass]
GO

DECLARE @idList nvarchar(1024)

CREATE TABLE #dist(dtex nvarchar(12) )
INSERT INTO #dist  
		SELECT DISTINCT dtExam
   FROM viewEsami
   ORDER BY dtExam
SELECT @idList = COALESCE(@idList + ',', '') + '[' + CAST(dtex as nvarchar(12)) + ']'
   FROM #dist ORDER BY dtex
DROP TABLE #dist
DECLARE @qry nvarchar(1024)
SET @qry = '
SELECT * 
FROM  ( 
   SELECT esame,esito,dtexam FROM viewEsami 
  ) as src
  PIVOT (
    SUM(esito) FOR dtexam in (' + @idList + ' )
  ) AS pvt'

EXEC (@qry)