USE [aass]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[deleteFatture]( @idItesta int = 1 ) 
AS

DELETE FROM EEconsumo 
	WHERE idEEFattura in ( 
		SELECT idEEFattura 
		  FROM dbo.EEFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM EELettura 
	WHERE idEEFattura in ( 
		SELECT idEEFattura 
		  FROM dbo.EEFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM EEFattura
	where idIntesta = @idItesta



DELETE FROM GASconsumo 
	WHERE idGASFattura in ( 
		SELECT idGASFattura 
		  FROM dbo.GASFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM GASLettura 
	WHERE idGASFattura in ( 
		SELECT idGASFattura 
		  FROM dbo.GASFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM GASFattura
	where idIntesta = @idItesta


DELETE FROM H2Oconsumo 
	WHERE idH2OFattura in ( 
		SELECT idH2OFattura 
		  FROM dbo.H2OFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)



DELETE FROM H2OLettura 
	WHERE idH2OFattura in ( 
		SELECT idH2OFattura 
		  FROM dbo.H2OFattura as ft
		    INNER JOIN dbo.Intesta as te
			  ON ft.idIntesta=te.idIntesta
		    WHERE te.idIntesta=@idItesta
		)

DELETE FROM H2OFattura
	where idIntesta = @idItesta

GO
