
CREATE FUNCTION deleteFatture( pIdIntesta INTEGER ) RETURNS INT
AS BEGIN
DECLARE retV INTEGER;

DELETE FROM EEconsumo 
	WHERE idEEFattura in ( 
		SELECT idEEFattura 
		  FROM dbo.EEFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=pIdIntesta
		);

DELETE FROM EELettura 
	WHERE idEEFattura in ( 
		SELECT idEEFattura 
		  FROM dbo.EEFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=pIdIntesta
		);

DELETE FROM EEFattura
	where idIntesta = pIdIntesta;



DELETE FROM GASconsumo 
	WHERE idGASFattura in ( 
		SELECT idGASFattura 
		  FROM dbo.GASFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=pIdIntesta
		);

DELETE FROM GASLettura 
	WHERE idGASFattura in ( 
		SELECT idGASFattura 
		  FROM dbo.GASFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=pIdIntesta
		);

DELETE FROM GASFattura
	where idIntesta = pIdIntesta;


DELETE FROM H2Oconsumo 
	WHERE idH2OFattura in ( 
		SELECT idH2OFattura 
		  FROM dbo.H2OFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=pIdIntesta
		);



DELETE FROM H2OLettura 
	WHERE idH2OFattura in ( 
		SELECT idH2OFattura 
		  FROM dbo.H2OFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=pIdIntesta
		);

DELETE FROM H2OFattura
	where idIntesta = pIdIntesta;

END;
