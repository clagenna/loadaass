USE [aass]
GO

DROP FUNCTION [dbo].[toAnnoMese]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Claudio
-- Create date: 16/10/23
-- Description:	converte Date in un decimal(6,2) per anno,mese
-- =============================================
CREATE FUNCTION [dbo].[toAnnoMese] ( @p1 date )
RETURNS decimal(6,2)
AS
BEGIN
	DECLARE @Result decimal(6,2) =	CONVERT(decimal(6,2), cast(year(@p1) as float) + cast(datepart(M,@p1) as float) / 100) 
	RETURN @Result
END
GO
