USE [aass]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Claudio
-- Create date: 16/10/2023
-- Description:	sum delle letture attuale per idFattura
-- =============================================
CREATE FUNCTION [dbo].[EESumLettAttuale] ( @p1 int )
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT @result = sum(le.lettAttuale) 
	  FROM dbo.EELettura as le
     WHERE idEEFattura = @p1

	RETURN @Result

END
GO
