USE [aass]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[cercaBuchiDateConsumoEE](  @Nomeintesta varchar(128)  )
 AS
DECLARE	@dtMin decimal(6,2),
		@dtMax decimal(6,2),
		@dec decimal(6,2),
		@dtCurr date
		


SELECT @dtMin = min(dtIniz), 
	   @dtMax = max(dtIniz)
  FROM dbo.EEConsumoMensile
  WHERE NomeIntesta=@Nomeintesta


SET @dtCurr = CAST( REPLACE( CAST(@dtMin as  varchar(18)) + '.01', '.', '-') as date)
SET @dec = dbo.toAnnoMese(@dtCurr)

CREATE TABLE #miedate ( miadt decimal(6,2) )

WHILE @dec <= @dtMax
BEGIN
   INSERT into #miedate VALUES (@dec) 
   SET @dtCurr = DATEADD(m, 1, @dtCurr)
   SET @dec = dbo.toAnnoMese(@dtCurr)
END

SELECT *
   FROM #miedate
   WHERE miadt NOT IN 
		( SELECT   dtIniz
            FROM aass.dbo.EEConsumoMensile
           WHERE NomeIntesta=@Nomeintesta
	    )
DROP TABLE #miedate
GO
