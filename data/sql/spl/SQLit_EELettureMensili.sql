CREATE VIEW EELettureMensili AS SELECT te.NomeIntesta,
           le.idLettura,
           le.idEEFattura,
           le.LettDtPrec,
           strftime('%Y.%m',DATE(le.LettDtPrec)) as mmDtPrec,
           le.TipoLettura,
           le.LettPrec,
           le.LettDtAttuale,
           strftime('%Y.%m',le.LettDtAttuale) as mmDtAttuale,
           le.LettAttuale,
           le.LettConsumo
      FROM EELettura AS le
           INNER JOIN
           EEFattura AS ft ON ft.idEEFattura = le.idEEFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta;

