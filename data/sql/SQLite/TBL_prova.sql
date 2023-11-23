--
-- File generato con SQLiteStudio v3.4.4 su sab nov 18 18:28:12 2023
--
-- Codifica del testo utilizzata: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Tabella: prova
DROP TABLE IF EXISTS prova;

CREATE TABLE IF NOT EXISTS prova (
    chiave    INTEGER PRIMARY KEY
                      NOT NULL,
    stringa   TEXT,
    intero    INTEGER,
    prezzo    REAL,
    dataoggi  TEXT,
    percento  REAL,
    flottante REAL
)
STRICT;

INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (1, NULL, 21, 12.34, '23/07/1957', 12.3, 3.141534);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (2, 'str2', 22, 23.56, '12/11/1957', 23.4, 2.718281828);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (3, 'str3', 23, 45.77, '22/09/1962', 12.33, 0.3443);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (4, 'str4', 24, 33.21, '23/07/1957', 12.3, 12.3445);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (5, 'str5', 25, 25.85, '12/11/1957', 23.4, NULL);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (6, 'str6', 26, 27.54, '22/09/1962', 12.33, 76.214673);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (7, 'str7', 27, 23.22, '23/07/1957', 12.3, NULL);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (8, 'str8', 28, 21.11, '23/07/1957', 12.3, NULL);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (9, 'str9', 29, 22.33, '12/11/1957', 23.4, NULL);
INSERT INTO prova (chiave, stringa, intero, prezzo, dataoggi, percento, flottante) VALUES (10, 'str10', 30, 22.66, '22/09/1962', 12.33, NULL);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
