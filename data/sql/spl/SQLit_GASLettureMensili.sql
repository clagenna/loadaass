CREATE VIEW GASLettureMensili AS SELECT te.NomeIntesta
      -- ,le.idLettura
      -- ,le.idGASFattura
      ,ft.periodFattDtIniz as dtFattIniz
      ,ft.periodFattDtFine as dtFattFine
      ,le.LettData  as lettDtPrec
      ,le.TipoLett
      ,le.Consumofatt
  FROM GASLettura as le
    INNER JOIN GASFattura as ft
        ON ft.idGASFattura=le.idGASFattura
    INNER JOIN intesta as te
        ON ft.idIntesta=te.idIntesta
;

