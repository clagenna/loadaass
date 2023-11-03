PRAGMA foreign_keys = 0;

CREATE TABLE sqlitestudio_temp_table AS SELECT *
                                          FROM EEConsumo;

DROP TABLE EEConsumo;

CREATE TABLE EEConsumo (
    idEEConsumo INTEGER         PRIMARY KEY,
    idEEFattura INT             NOT NULL,
    tipoSpesa   TEXT (2),
    dtIniz      DATE,
    dtFine      DATE,
    prezzoUnit  DECIMAL (10, 6),
    quantita    DECIMAL (8, 2),
    importo     DECIMAL (8,2)
);

INSERT INTO EEConsumo (
                          idEEConsumo,
                          idEEFattura,
                          tipoSpesa,
                          dtIniz,
                          dtFine,
                          prezzoUnit,
                          quantita,
                          importo
                      )
                      SELECT idEEConsumo,
                             idEEFattura,
                             tipoSpesa,
                             dtIniz,
                             dtFine,
                             prezzoUnit,
                             quantita,
                             importo
                        FROM sqlitestudio_temp_table;

DROP TABLE sqlitestudio_temp_table;

PRAGMA foreign_keys = 1;
