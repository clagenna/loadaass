--
-- File generato con SQLiteStudio v3.4.4 su gio nov 16 15:39:06 2023
--
-- Codifica del testo utilizzata: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Tabella: EEConsumo
DROP TABLE IF EXISTS EEConsumo;

CREATE TABLE IF NOT EXISTS EEConsumo (
    idEEConsumo INTEGER         PRIMARY KEY,
    idEEFattura INT             NOT NULL,
    tipoSpesa   TEXT (2),
    dtIniz      DATE,
    dtFine      DATE,
    prezzoUnit  DECIMAL (10, 6),
    quantita    DECIMAL (8, 2),
    importo     DECIMAL (8, 2) 
);

INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1, 1, 'E1', '2019-09-01', '2019-09-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2, 1, 'E2', '2019-09-01', '2019-09-30', 0.18951, 111, 21.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (3, 1, 'P', '2019-09-01', '2019-09-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (4, 1, 'R', '2019-09-01', '2019-09-30', 0.05913, 269, 15.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (5, 1, 'E1', '2019-10-01', '2019-10-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (6, 1, 'E2', '2019-10-01', '2019-10-31', 0.18951, 106, 20.09);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (7, 1, 'P', '2019-10-01', '2019-10-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (8, 1, 'R', '2019-10-01', '2019-10-31', 0.05913, 226, 13.36);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (9, 2, 'E1', '2019-11-01', '2019-11-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (10, 2, 'E2', '2019-11-01', '2019-11-30', 0.18951, 124, 23.5);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (11, 2, 'P', '2019-11-01', '2019-11-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (12, 2, 'R', '2019-11-01', '2019-11-30', 0.05913, 282, 16.67);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (13, 2, 'E1', '2019-12-01', '2019-12-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (14, 2, 'E2', '2019-12-01', '2019-12-31', 0.18951, 154, 29.18);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (15, 2, 'P', '2019-12-01', '2019-12-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (16, 2, 'R', '2019-12-01', '2019-12-31', 0.05913, 213, 12.59);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (17, 3, 'E1', '2020-01-01', '2020-01-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (18, 3, 'E2', '2020-01-01', '2020-01-31', 0.18951, 130, 24.64);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (19, 3, 'P', '2020-01-01', '2020-01-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (20, 3, 'R', '2020-01-01', '2020-01-31', 0.05913, 293, 17.33);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (21, 3, 'E1', '2020-02-01', '2020-02-29', 0.08945, 152, 13.6);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (22, 3, 'E2', '2020-02-01', '2020-02-29', 0.18951, 110, 20.85);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (23, 3, 'P', '2020-02-01', '2020-02-29', 0.836753, 4.5, 3.77);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (24, 3, 'R', '2020-02-01', '2020-02-29', 0.05913, 194, 11.47);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (25, 4, 'E1', '2020-03-01', '2020-03-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (26, 4, 'E2', '2020-03-01', '2020-03-31', 0.18951, 151, 28.62);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (27, 4, 'P', '2020-03-01', '2020-03-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (28, 4, 'R', '2020-03-01', '2020-03-31', 0.05913, 314, 18.57);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (29, 4, 'E1', '2020-04-01', '2020-04-30', 0.08945, 157, 14.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (30, 4, 'E2', '2020-04-01', '2020-04-30', 0.18951, 139, 26.34);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (31, 4, 'P', '2020-04-01', '2020-04-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (32, 4, 'R', '2020-04-01', '2020-04-30', 0.05913, 180, 10.64);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (33, 5, 'E1', '2020-05-01', '2020-05-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (34, 5, 'E2', '2020-05-01', '2020-05-31', 0.18951, 124, 23.5);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (35, 5, 'P', '2020-05-01', '2020-05-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (36, 5, 'R', '2020-05-01', '2020-05-31', 0.05913, 287, 16.97);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (37, 5, 'E1', '2020-06-01', '2020-06-30', 0.08945, 157, 14.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (38, 5, 'E2', '2020-06-01', '2020-06-30', 0.18951, 105, 19.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (39, 5, 'P', '2020-06-01', '2020-06-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (40, 5, 'R', '2020-06-01', '2020-06-30', 0.05913, 208, 12.3);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (41, 6, 'E1', '2020-07-01', '2020-07-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (42, 6, 'E2', '2020-07-01', '2020-07-31', 0.18951, 87, 16.49);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (43, 6, 'P', '2020-07-01', '2020-07-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (44, 6, 'R', '2020-07-01', '2020-07-31', 0.05913, 250, 14.78);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (45, 7, 'E1', '2020-08-01', '2020-08-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (46, 7, 'E2', '2020-08-01', '2020-08-31', 0.18951, 160, 30.32);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (47, 7, 'P', '2020-08-01', '2020-08-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (48, 7, 'R', '2020-08-01', '2020-08-31', 0.05913, 323, 19.1);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (49, 7, 'E1', '2020-09-01', '2020-09-30', 0.08945, 157, 14.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (50, 7, 'E2', '2020-09-01', '2020-09-30', 0.18951, 103, 19.52);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (51, 7, 'P', '2020-09-01', '2020-09-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (52, 7, 'R', '2020-09-01', '2020-09-30', 0.05913, 260, 15.37);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (53, 7, 'E1', '2020-10-01', '2020-10-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (54, 7, 'E2', '2020-10-01', '2020-10-31', 0.18951, 111, 21.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (55, 7, 'P', '2020-10-01', '2020-10-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (56, 7, 'R', '2020-10-01', '2020-10-31', 0.05913, 274, 16.2);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (57, 7, 'E1', '2020-11-01', '2020-11-30', 0.08945, 157, 14.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (58, 7, 'E2', '2020-11-01', '2020-11-30', 0.18951, 150, 28.43);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (59, 7, 'P', '2020-11-01', '2020-11-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (60, 7, 'R', '2020-11-01', '2020-11-30', 0.05913, 307, 18.15);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (61, 7, 'E1', '2020-12-01', '2020-12-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (62, 7, 'E2', '2020-12-01', '2020-12-31', 0.18951, 178, 33.73);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (63, 7, 'P', '2020-12-01', '2020-12-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (64, 7, 'R', '2020-12-01', '2020-12-31', 0.05913, 70, 4.14);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (65, 8, 'P', '2021-01-01', '2021-01-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (66, 8, 'R', '2021-01-01', '2021-01-31', 0.05913, 369, 21.82);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (67, 8, 'P', '2021-02-01', '2021-02-28', 0.810113, 4.5, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (68, 8, 'R', '2021-02-01', '2021-02-28', 0.05913, 318, 18.8);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (69, 8, 'P', '2021-03-01', '2021-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (70, 8, 'R', '2021-03-01', '2021-03-31', 0.05913, 286, 16.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (71, 8, 'P', '2021-04-01', '2021-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (72, 9, 'P', '2021-05-01', '2021-05-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (73, 9, 'R', '2021-05-01', '2021-05-31', 0.05913, 294, 17.38);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (74, 9, 'P', '2021-06-01', '2021-06-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (75, 9, 'R', '2021-06-01', '2021-06-30', 0.05913, 304, 17.98);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (76, 9, 'E1', '2021-07-01', '2021-07-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (77, 9, 'E2', '2021-07-01', '2021-07-31', 0.18951, 156, 29.56);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (78, 9, 'P', '2021-07-01', '2021-07-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (79, 9, 'R', '2021-07-01', '2021-07-31', 0.05913, 354, 20.93);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (80, 9, 'E1', '2021-08-01', '2021-08-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (81, 9, 'E2', '2021-08-01', '2021-08-31', 0.18951, 198, 37.52);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (82, 9, 'P', '2021-08-01', '2021-08-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (83, 9, 'R', '2021-08-01', '2021-08-31', 0.05913, 45, 2.66);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (84, 10, 'E1', '2021-09-01', '2021-09-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (85, 10, 'E2', '2021-09-01', '2021-09-30', 0.18951, 141, 26.72);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (86, 10, 'P', '2021-09-01', '2021-09-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (87, 10, 'R', '2021-09-01', '2021-09-30', 0.05913, 299, 17.68);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (88, 10, 'E1', '2021-10-01', '2021-10-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (89, 10, 'E2', '2021-10-01', '2021-10-31', 0.18951, 153, 29);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (90, 10, 'P', '2021-10-01', '2021-10-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (91, 10, 'R', '2021-10-01', '2021-10-31', 0.05913, 316, 18.69);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (92, 10, 'E1', '2021-11-01', '2021-11-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (93, 10, 'E2', '2021-11-01', '2021-11-30', 0.18951, 167, 31.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (94, 10, 'P', '2021-11-01', '2021-11-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (95, 10, 'R', '2021-11-01', '2021-11-30', 0.05913, 325, 19.22);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (96, 10, 'E1', '2021-12-01', '2021-12-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (97, 10, 'E2', '2021-12-01', '2021-12-31', 0.18951, 169, 32.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (98, 10, 'P', '2021-12-01', '2021-12-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (99, 10, 'R', '2021-12-01', '2021-12-31', 0.05913, 50, 2.96);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (100, 11, 'P', '2022-01-01', '2022-01-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (101, 11, 'R', '2022-01-01', '2022-01-31', 0.05913, 325, 19.22);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (102, 11, 'P', '2022-02-01', '2022-02-28', 0.810113, 4.5, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (103, 11, 'R', '2022-02-01', '2022-02-28', 0.05913, 301, 17.8);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (104, 11, 'P', '2022-03-01', '2022-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (105, 11, 'R', '2022-03-01', '2022-03-31', 0.05913, 300, 17.74);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (106, 11, 'P', '2022-04-01', '2022-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (107, 11, 'R', '2022-04-01', '2022-04-30', 0.05913, 47, 2.78);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (108, 12, 'P', '2022-05-01', '2022-05-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (109, 12, 'R', '2022-05-01', '2022-05-31', 0.05913, 311, 18.39);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (110, 12, 'P', '2022-06-01', '2022-06-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (111, 12, 'R', '2022-06-01', '2022-06-30', 0.05913, 303, 17.92);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (112, 12, 'P', '2022-07-01', '2022-07-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (113, 12, 'R', '2022-07-01', '2022-07-31', 0.05913, 377, 22.29);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (114, 12, 'P', '2022-08-01', '2022-08-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (115, 12, 'R', '2022-08-01', '2022-08-31', 0.05913, 6, 0.35);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (116, 13, 'P', '2022-09-01', '2022-09-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (117, 13, 'R', '2022-09-01', '2022-09-30', 0.05913, 286, 16.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (118, 13, 'P', '2022-10-01', '2022-10-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (119, 13, 'R', '2022-10-01', '2022-10-31', 0.05913, 325, 19.22);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (120, 13, 'P', '2022-11-01', '2022-11-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (121, 13, 'R', '2022-11-01', '2022-11-30', 0.05913, 379, 22.41);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (122, 13, 'P', '2022-12-01', '2022-12-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (123, 14, 'P', '2023-01-01', '2023-01-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (124, 14, 'R', '2023-01-01', '2023-01-31', 0.05913, 389, 23);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (125, 14, 'P', '2023-02-01', '2023-02-28', 0.810113, 4.5, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (126, 14, 'R', '2023-02-01', '2023-02-28', 0.05913, 345, 20.4);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (127, 14, 'P', '2023-03-01', '2023-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (128, 14, 'R', '2023-03-01', '2023-03-31', 0.05913, 239, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (129, 14, 'P', '2023-04-01', '2023-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (130, 15, 'E1', '2019-07-01', '2019-07-31', 0.08945, 27, 2.42);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (131, 15, 'P', '2019-07-01', '2019-07-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (132, 15, 'R', '2019-07-01', '2019-07-31', 0.05913, 27, 1.6);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (133, 15, 'E1', '2019-08-01', '2019-08-31', 0.08945, 10, 0.89);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (134, 15, 'P', '2019-08-01', '2019-08-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (135, 15, 'R', '2019-08-01', '2019-08-31', 0.05913, 10, 0.59);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (136, 16, 'E1', '2019-09-01', '2019-09-30', 0.08945, 39, 3.49);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (137, 16, 'P', '2019-09-01', '2019-09-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (138, 16, 'R', '2019-09-01', '2019-09-30', 0.05913, 39, 2.31);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (139, 16, 'E1', '2019-10-01', '2019-10-31', 0.08945, 103, 9.21);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (140, 16, 'P', '2019-10-01', '2019-10-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (141, 16, 'R', '2019-10-01', '2019-10-31', 0.05913, 103, 6.09);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (142, 17, 'E1', '2019-11-01', '2019-11-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (143, 17, 'E2', '2019-11-01', '2019-11-30', 0.18951, 78, 14.78);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (144, 17, 'P', '2019-11-01', '2019-11-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (145, 17, 'R', '2019-11-01', '2019-11-30', 0.05913, 236, 13.95);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (146, 17, 'E1', '2019-12-01', '2019-12-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (147, 17, 'E2', '2019-12-01', '2019-12-31', 0.18951, 246, 46.62);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (148, 17, 'P', '2019-12-01', '2019-12-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (149, 17, 'R', '2019-12-01', '2019-12-31', 0.05913, 409, 24.18);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (150, 18, 'E1', '2020-01-01', '2020-01-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (151, 18, 'E2', '2020-01-01', '2020-01-31', 0.18951, 580, 109.92);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (152, 18, 'P', '2020-01-01', '2020-01-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (153, 18, 'R', '2020-01-01', '2020-01-31', 0.05913, 487, 28.8);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (154, 18, 'E1', '2020-02-01', '2020-02-29', 0.08945, 152, 13.6);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (155, 18, 'E2', '2020-02-01', '2020-02-29', 0.18951, 566, 107.25999999999999);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (156, 18, 'P', '2020-02-01', '2020-02-29', 0.836753, 4.5, 3.77);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (157, 19, 'E1', '2020-03-01', '2020-03-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (158, 19, 'E2', '2020-03-01', '2020-03-31', 0.18951, 345, 65.38);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (159, 19, 'P', '2020-03-01', '2020-03-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (160, 19, 'R', '2020-03-01', '2020-03-31', 0.05913, 494, 29.21);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (161, 19, 'E1', '2020-04-01', '2020-04-30', 0.08945, 157, 14.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (162, 19, 'E2', '2020-04-01', '2020-04-30', 0.18951, 126, 23.88);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (163, 19, 'P', '2020-04-01', '2020-04-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (164, 20, 'E1', '2020-05-01', '2020-05-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (165, 20, 'E2', '2020-05-01', '2020-05-31', 0.18951, 117, 22.17);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (166, 20, 'P', '2020-05-01', '2020-05-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (167, 20, 'R', '2020-05-01', '2020-05-31', 0.05913, 280, 16.56);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (168, 20, 'E1', '2020-06-01', '2020-06-30', 0.08945, 115, 10.29);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (169, 20, 'P', '2020-06-01', '2020-06-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (170, 20, 'R', '2020-06-01', '2020-06-30', 0.05913, 115, 6.8);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (171, 21, 'E1', '2020-07-01', '2020-07-31', 0.08945, 162, 14.49);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (172, 21, 'P', '2020-07-01', '2020-07-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (173, 21, 'R', '2020-07-01', '2020-07-31', 0.05913, 162, 9.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (174, 21, 'E1', '2020-08-01', '2020-08-31', 0.08945, 116, 10.38);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (175, 21, 'P', '2020-08-01', '2020-08-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (176, 21, 'R', '2020-08-01', '2020-08-31', 0.05913, 116, 6.86);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (177, 22, 'E1', '2020-09-01', '2020-09-30', 0.08945, 116, 10.38);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (178, 22, 'P', '2020-09-01', '2020-09-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (179, 22, 'R', '2020-09-01', '2020-09-30', 0.05913, 116, 6.86);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (180, 22, 'E1', '2020-10-01', '2020-10-31', 0.08945, 146, 13.06);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (181, 22, 'P', '2020-10-01', '2020-10-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (182, 22, 'R', '2020-10-01', '2020-10-31', 0.05913, 146, 8.63);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (183, 23, 'E1', '2020-11-01', '2020-11-30', 0.08945, 157, 14.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (184, 23, 'E2', '2020-11-01', '2020-11-30', 0.18951, 136, 25.77);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (185, 23, 'P', '2020-11-01', '2020-11-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (186, 23, 'R', '2020-11-01', '2020-11-30', 0.05913, 293, 17.33);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (187, 23, 'E1', '2020-12-01', '2020-12-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (188, 23, 'E2', '2020-12-01', '2020-12-31', 0.18951, 180, 34.11);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (189, 23, 'P', '2020-12-01', '2020-12-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (190, 23, 'R', '2020-12-01', '2020-12-31', 0.05913, 343, 20.28);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (191, 24, 'E1', '2021-01-01', '2021-01-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (192, 24, 'E2', '2021-01-01', '2021-01-31', 0.18951, 221, 41.88);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (193, 24, 'P', '2021-01-01', '2021-01-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (194, 24, 'R', '2021-01-01', '2021-01-31', 0.05913, 384, 22.71);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (195, 24, 'E1', '2021-02-01', '2021-02-28', 0.08945, 147, 13.15);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (196, 24, 'E2', '2021-02-01', '2021-02-28', 0.18951, 179, 33.92);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (197, 24, 'P', '2021-02-01', '2021-02-28', 0.810113, 4.5, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (198, 24, 'R', '2021-02-01', '2021-02-28', 0.05913, 94, 5.56);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (199, 25, 'E1', '2021-03-01', '2021-03-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (200, 25, 'E2', '2021-03-01', '2021-03-31', 0.18951, 146, 27.67);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (201, 25, 'P', '2021-03-01', '2021-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (202, 25, 'R', '2021-03-01', '2021-03-31', 0.05913, 309, 18.27);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (203, 25, 'E1', '2021-04-01', '2021-04-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (204, 25, 'E2', '2021-04-01', '2021-04-30', 0.18951, 125, 23.69);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (205, 25, 'P', '2021-04-01', '2021-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (206, 25, 'R', '2021-04-01', '2021-04-30', 0.05913, 186, 11);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (207, 26, 'E1', '2021-05-01', '2021-05-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (208, 26, 'E2', '2021-05-01', '2021-05-31', 0.18951, 94, 17.81);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (209, 26, 'P', '2021-05-01', '2021-05-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (210, 26, 'R', '2021-05-01', '2021-05-31', 0.05913, 257, 15.2);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (211, 26, 'E1', '2021-06-01', '2021-06-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (212, 26, 'E2', '2021-06-01', '2021-06-30', 0.18951, 47, 8.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (213, 26, 'P', '2021-06-01', '2021-06-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (214, 26, 'R', '2021-06-01', '2021-06-30', 0.05913, 205, 12.12);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (215, 27, 'E1', '2021-07-01', '2021-07-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (216, 27, 'E2', '2021-07-01', '2021-07-31', 0.18951, 44, 8.34);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (217, 27, 'P', '2021-07-01', '2021-07-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (218, 27, 'R', '2021-07-01', '2021-07-31', 0.05913, 207, 12.24);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (219, 27, 'E1', '2021-08-01', '2021-08-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (220, 27, 'E2', '2021-08-01', '2021-08-31', 0.18951, 4, 0.76);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (221, 27, 'P', '2021-08-01', '2021-08-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (222, 27, 'R', '2021-08-01', '2021-08-31', 0.05913, 167, 9.87);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (223, 28, 'E1', '2021-09-01', '2021-09-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (224, 28, 'E2', '2021-09-01', '2021-09-30', 0.18951, 46, 8.72);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (225, 28, 'P', '2021-09-01', '2021-09-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (226, 28, 'R', '2021-09-01', '2021-09-30', 0.05913, 204, 12.06);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (227, 28, 'E1', '2021-10-01', '2021-10-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (228, 28, 'E2', '2021-10-01', '2021-10-31', 0.18951, 142, 26.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (229, 28, 'P', '2021-10-01', '2021-10-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (230, 28, 'R', '2021-10-01', '2021-10-31', 0.05913, 305, 18.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (231, 29, 'E1', '2021-11-01', '2021-11-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (232, 29, 'E2', '2021-11-01', '2021-11-30', 0.18951, 186, 35.25);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (233, 29, 'P', '2021-11-01', '2021-11-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (234, 29, 'R', '2021-11-01', '2021-11-30', 0.05913, 344, 20.34);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (235, 29, 'E1', '2021-12-01', '2021-12-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (236, 29, 'E2', '2021-12-01', '2021-12-31', 0.18951, 116, 21.98);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (237, 29, 'P', '2021-12-01', '2021-12-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (238, 29, 'R', '2021-12-01', '2021-12-31', 0.05913, 279, 16.5);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (239, 30, 'E1', '2022-01-01', '2022-01-31', 0.111813, 163, 18.23);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (240, 30, 'E2', '2022-01-01', '2022-01-31', 0.255839, 202, 51.67999999999999);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (241, 30, 'P', '2022-01-01', '2022-01-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (242, 30, 'R', '2022-01-01', '2022-01-31', 0.05913, 365, 21.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (243, 30, 'E1', '2022-02-01', '2022-02-28', 0.111813, 147, 16.44);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (244, 30, 'E2', '2022-02-01', '2022-02-28', 0.255839, 144, 36.84);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (245, 30, 'P', '2022-02-01', '2022-02-28', 0.810113, 4.5, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (246, 30, 'R', '2022-02-01', '2022-02-28', 0.05913, 113, 6.68);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (247, 31, 'E1', '2022-03-01', '2022-03-31', 0.111813, 163, 18.23);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (248, 31, 'E2', '2022-03-01', '2022-03-31', 0.255839, 152, 38.89);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (249, 31, 'P', '2022-03-01', '2022-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (250, 31, 'R', '2022-03-01', '2022-03-31', 0.05913, 315, 18.63);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (251, 31, 'E1', '2022-04-01', '2022-04-30', 0.111813, 158, 17.67);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (252, 31, 'E2', '2022-04-01', '2022-04-30', 0.255839, 99, 25.33);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (253, 31, 'P', '2022-04-01', '2022-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (254, 31, 'R', '2022-04-01', '2022-04-30', 0.05913, 180, 10.64);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (255, 32, 'E1', '2022-05-01', '2022-05-31', 0.111813, 204, 22.81);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (256, 32, 'E2', '2022-05-01', '2022-05-31', 0.255839, 44, 11.26);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (257, 32, 'P', '2022-05-01', '2022-05-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (258, 32, 'R', '2022-05-01', '2022-05-31', 0.05913, 248, 14.66);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (259, 32, 'E1', '2022-06-01', '2022-06-30', 0.111813, 197, 22.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (260, 32, 'E2', '2022-06-01', '2022-06-30', 0.255839, 49, 12.54);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (261, 32, 'P', '2022-06-01', '2022-06-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (262, 32, 'R', '2022-06-01', '2022-06-30', 0.05913, 246, 14.55);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (263, 33, 'E1', '2022-07-01', '2022-07-31', 0.111813, 162, 18.11);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (264, 33, 'P', '2022-07-01', '2022-07-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (265, 33, 'E1', '2022-08-01', '2022-08-31', 0.111813, 116, 12.97);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (266, 33, 'P', '2022-08-01', '2022-08-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (267, 34, 'E1', '2022-07-01', '2022-07-31', 0.111813, 204, 22.81);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (268, 34, 'E2', '2022-07-01', '2022-07-31', 0.255839, 72, 18.42);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (269, 34, 'P', '2022-07-01', '2022-07-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (270, 34, 'R', '2022-07-01', '2022-07-31', 0.05913, 276, 16.32);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (271, 34, 'E1', '2022-08-01', '2022-08-31', 0.111813, 204, 22.81);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (272, 34, 'E2', '2022-08-01', '2022-08-31', 0.255839, 72, 18.42);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (273, 34, 'P', '2022-08-01', '2022-08-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (274, 34, 'R', '2022-08-01', '2022-08-31', 0.05913, 276, 16.32);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (275, 34, 'E1', '2022-09-01', '2022-09-30', 0.111813, 197, 22.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (276, 34, 'E2', '2022-09-01', '2022-09-30', 0.255839, 70, 17.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (277, 34, 'P', '2022-09-01', '2022-09-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (278, 34, 'R', '2022-09-01', '2022-09-30', 0.05913, 267, 15.79);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (279, 34, 'E1', '2022-10-01', '2022-10-31', 0.111813, 204, 22.81);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (280, 34, 'E2', '2022-10-01', '2022-10-31', 0.255839, 72, 18.42);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (281, 34, 'P', '2022-10-01', '2022-10-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (282, 34, 'R', '2022-10-01', '2022-10-31', 0.05913, 276, 16.32);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (283, 34, 'E1', '2022-11-01', '2022-11-30', 0.111813, 197, 22.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (284, 34, 'E2', '2022-11-01', '2022-11-30', 0.255839, 71, 18.16);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (285, 34, 'P', '2022-11-01', '2022-11-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (286, 34, 'R', '2022-11-01', '2022-11-30', 0.05913, 268, 15.85);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (287, 34, 'PU', '2022-12-01', '2022-12-31', 0.29491, 204, 60.16);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (288, 34, 'PU', '2022-12-01', '2022-12-31', 0.29491, 72, 21.23);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (289, 34, 'S1', '2022-12-01', '2022-12-31', 0.007135, 204, 1.46);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (290, 34, 'S2', '2022-12-01', '2022-12-31', 0.021405, 72, 1.54);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (291, 34, 'P', '2022-12-01', '2022-12-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (292, 34, 'R', '2022-12-01', '2022-12-31', 0.05913, 130, 7.69);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (293, 34, 'PU', '2023-01-01', '2023-01-31', 0.17449, 204, 35.6);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (294, 34, 'PU', '2023-01-01', '2023-01-31', 0.17449, 73, 12.74);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (295, 34, 'S1', '2023-01-01', '2023-01-31', 0.010176, 204, 2.08);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (296, 34, 'S2', '2023-01-01', '2023-01-31', 0.030528, 73, 2.23);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (297, 34, 'P', '2023-01-01', '2023-01-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (298, 34, 'R', '2023-01-01', '2023-01-31', 0.05913, 277, 16.38);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (299, 34, 'PU', '2023-02-01', '2023-02-28', 0.16107, 184, 29.64);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (300, 34, 'PU', '2023-02-01', '2023-02-28', 0.16107, 66, 10.63);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (301, 34, 'S1', '2023-02-01', '2023-02-28', 0.010176, 184, 1.87);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (302, 34, 'S2', '2023-02-01', '2023-02-28', 0.030528, 66, 2.01);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (303, 34, 'P', '2023-02-01', '2023-02-28', 0.810113, 4.5, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (304, 34, 'R', '2023-02-01', '2023-02-28', 0.05913, 250, 14.78);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (305, 34, 'PU', '2023-03-01', '2023-03-31', 0.13638, 204, 27.82);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (306, 34, 'PU', '2023-03-01', '2023-03-31', 0.13638, 72, 9.82);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (307, 34, 'S1', '2023-03-01', '2023-03-31', 0.010176, 204, 2.08);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (308, 34, 'S2', '2023-03-01', '2023-03-31', 0.030528, 72, 2.2);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (309, 34, 'P', '2023-03-01', '2023-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (310, 34, 'R', '2023-03-01', '2023-03-31', 0.05913, 276, 16.32);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (311, 34, 'PU', '2023-04-01', '2023-04-30', 0.13497, 197, 26.59);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (312, 34, 'PU', '2023-04-01', '2023-04-30', 0.13497, 121, 16.33);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (313, 34, 'S1', '2023-04-01', '2023-04-30', 0.010176, 197, 2);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (314, 34, 'S2', '2023-04-01', '2023-04-30', 0.030528, 121, 3.69);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (315, 34, 'P', '2023-04-01', '2023-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (316, 34, 'R', '2023-04-01', '2023-04-30', 0.05913, 170, 10.05);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (317, 35, 'P', '2022-10-01', '2022-10-31', 0.89691, 146, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (318, 36, 'P', '2022-12-01', '2022-12-31', 0.89691, 139, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (319, 37, 'P', '2023-02-01', '2023-02-28', 0.810113, 82, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (320, 38, 'PU', '2023-05-01', '2023-05-31', 0.10573, 204, 21.57);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (321, 38, 'PU', '2023-05-01', '2023-05-31', 0.10573, 111, 11.74);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (322, 38, 'S1', '2023-05-01', '2023-05-31', 0.010176, 204, 2.08);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (323, 38, 'S2', '2023-05-01', '2023-05-31', 0.030528, 111, 3.39);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (324, 38, 'P', '2023-05-01', '2023-05-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (325, 38, 'R', '2023-05-01', '2023-05-31', 0.05913, 315, 18.63);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (326, 38, 'PU', '2023-06-01', '2023-06-30', 0.10534, 142, 14.96);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (327, 38, 'S1', '2023-06-01', '2023-06-30', 0.010176, 142, 1.44);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (328, 38, 'P', '2023-06-01', '2023-06-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (329, 38, 'R', '2023-06-01', '2023-06-30', 0.05913, 142, 8.4);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (330, 39, 'E1', '2020-11-01', '2020-11-30', 0.08945, 157, 14.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (331, 39, 'E2', '2020-11-01', '2020-11-30', 0.18951, 48, 9.1);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (332, 39, 'P', '2020-11-01', '2020-11-30', 0.865606, 4.5, 3.9);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (333, 39, 'R', '2020-11-01', '2020-11-30', 0.05913, 205, 12.12);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (334, 39, 'E1', '2020-12-01', '2020-12-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (335, 39, 'E2', '2020-12-01', '2020-12-31', 0.18951, 53, 10.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (336, 39, 'P', '2020-12-01', '2020-12-31', 0.89446, 4.5, 4.03);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (337, 39, 'R', '2020-12-01', '2020-12-31', 0.05913, 216, 12.77);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (338, 40, 'E1', '2021-01-01', '2021-01-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (339, 40, 'E2', '2021-01-01', '2021-01-31', 0.18951, 36, 6.82);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (340, 40, 'P', '2021-01-01', '2021-01-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (341, 40, 'R', '2021-01-01', '2021-01-31', 0.05913, 199, 11.77);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (342, 40, 'E1', '2021-02-01', '2021-02-28', 0.08945, 147, 13.15);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (343, 40, 'E2', '2021-02-01', '2021-02-28', 0.18951, 13, 2.46);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (344, 40, 'P', '2021-02-01', '2021-02-28', 0.810113, 4.5, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (345, 40, 'R', '2021-02-01', '2021-02-28', 0.05913, 160, 9.46);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (346, 41, 'E1', '2021-03-01', '2021-03-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (347, 41, 'E2', '2021-03-01', '2021-03-31', 0.18951, 23, 4.36);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (348, 41, 'P', '2021-03-01', '2021-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (349, 41, 'R', '2021-03-01', '2021-03-31', 0.05913, 186, 11);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (350, 41, 'E1', '2021-04-01', '2021-04-30', 0.08945, 155, 13.86);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (351, 41, 'P', '2021-04-01', '2021-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (352, 41, 'R', '2021-04-01', '2021-04-30', 0.05913, 155, 9.17);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (353, 42, 'E1', '2021-05-01', '2021-05-31', 0.08945, 143, 12.79);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (354, 42, 'P', '2021-05-01', '2021-05-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (355, 42, 'R', '2021-05-01', '2021-05-31', 0.05913, 143, 8.46);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (356, 42, 'E1', '2021-06-01', '2021-06-30', 0.08945, 158, 14.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (357, 42, 'E2', '2021-06-01', '2021-06-30', 0.18951, 11, 2.08);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (358, 42, 'P', '2021-06-01', '2021-06-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (359, 42, 'R', '2021-06-01', '2021-06-30', 0.05913, 169, 9.99);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (360, 43, 'E1', '2021-07-01', '2021-07-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (361, 43, 'E2', '2021-07-01', '2021-07-31', 0.18951, 17, 3.22);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (362, 43, 'P', '2021-07-01', '2021-07-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (363, 43, 'R', '2021-07-01', '2021-07-31', 0.05913, 180, 10.64);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (364, 43, 'E1', '2021-08-01', '2021-08-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (365, 43, 'E2', '2021-08-01', '2021-08-31', 0.18951, 29, 5.5);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (366, 43, 'P', '2021-08-01', '2021-08-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (367, 43, 'R', '2021-08-01', '2021-08-31', 0.05913, 192, 11.35);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (368, 44, 'E1', '2021-09-01', '2021-09-30', 0.08945, 128, 11.45);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (369, 44, 'P', '2021-09-01', '2021-09-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (370, 44, 'R', '2021-09-01', '2021-09-30', 0.05913, 128, 7.57);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (371, 44, 'E1', '2021-10-01', '2021-10-31', 0.08945, 155, 13.86);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (372, 44, 'P', '2021-10-01', '2021-10-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (373, 44, 'R', '2021-10-01', '2021-10-31', 0.05913, 155, 9.17);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (374, 45, 'E1', '2021-11-01', '2021-11-30', 0.08945, 155, 13.86);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (375, 45, 'P', '2021-11-01', '2021-11-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (376, 45, 'R', '2021-11-01', '2021-11-30', 0.05913, 155, 9.17);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (377, 45, 'E1', '2021-12-01', '2021-12-31', 0.08945, 163, 14.58);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (378, 45, 'E2', '2021-12-01', '2021-12-31', 0.18951, 28, 5.31);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (379, 45, 'P', '2021-12-01', '2021-12-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (380, 45, 'R', '2021-12-01', '2021-12-31', 0.05913, 191, 11.29);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (381, 46, 'E1', '2022-03-01', '2022-03-31', 0.111813, 163, 18.23);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (382, 46, 'E2', '2022-03-01', '2022-03-31', 0.255839, 13, 3.33);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (383, 46, 'P', '2022-03-01', '2022-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (384, 46, 'R', '2022-03-01', '2022-03-31', 0.05913, 176, 10.41);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (385, 46, 'E1', '2022-04-01', '2022-04-30', 0.111813, 158, 17.67);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (386, 46, 'P', '2022-04-01', '2022-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (387, 46, 'R', '2022-04-01', '2022-04-30', 0.05913, 158, 9.34);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (388, 47, 'E1', '2022-05-01', '2022-05-31', 0.111813, 137, 15.32);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (389, 47, 'P', '2022-05-01', '2022-05-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (390, 47, 'R', '2022-05-01', '2022-05-31', 0.05913, 137, 8.1);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (391, 47, 'E1', '2022-06-01', '2022-06-30', 0.111813, 143, 15.99);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (392, 47, 'P', '2022-06-01', '2022-06-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (393, 47, 'R', '2022-06-01', '2022-06-30', 0.05913, 143, 8.46);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (394, 48, 'E1', '2022-07-01', '2022-07-31', 0.111813, 181, 20.24);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (395, 48, 'P', '2022-07-01', '2022-07-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (396, 48, 'R', '2022-07-01', '2022-07-31', 0.05913, 181, 10.7);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (397, 48, 'E1', '2022-08-01', '2022-08-31', 0.111813, 165, 18.45);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (398, 48, 'P', '2022-08-01', '2022-08-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (399, 48, 'R', '2022-08-01', '2022-08-31', 0.05913, 165, 9.76);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (400, 49, 'E1', '2022-09-01', '2022-09-30', 0.111813, 138, 15.43);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (401, 49, 'P', '2022-09-01', '2022-09-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (402, 49, 'R', '2022-09-01', '2022-09-30', 0.05913, 138, 8.16);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (403, 49, 'E1', '2022-10-01', '2022-10-31', 0.111813, 181, 20.24);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (404, 49, 'P', '2022-10-01', '2022-10-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (405, 49, 'R', '2022-10-01', '2022-10-31', 0.05913, 181, 10.7);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (406, 50, 'E1', '2022-11-01', '2022-11-30', 0.111813, 161, 18);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (407, 50, 'P', '2022-11-01', '2022-11-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (408, 50, 'R', '2022-11-01', '2022-11-30', 0.05913, 161, 9.52);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (409, 50, 'PU', '2022-12-01', '2022-12-31', 0.29491, 170, 50.13);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (410, 50, 'S1', '2022-12-01', '2022-12-31', 0.007135, 170, 1.21);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (411, 50, 'P', '2022-12-01', '2022-12-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (412, 50, 'R', '2022-12-01', '2022-12-31', 0.05913, 170, 10.05);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (413, 51, 'PU', '2023-01-01', '2023-01-31', 0.17449, 170, 29.66);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (414, 51, 'S1', '2023-01-01', '2023-01-31', 0.010176, 170, 1.73);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (415, 51, 'P', '2023-01-01', '2023-01-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (416, 51, 'R', '2023-01-01', '2023-01-31', 0.05913, 170, 10.05);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (417, 51, 'PU', '2023-02-01', '2023-02-28', 0.16107, 159, 25.61);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (418, 51, 'S1', '2023-02-01', '2023-02-28', 0.010176, 159, 1.62);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (419, 51, 'P', '2023-02-01', '2023-02-28', 0.810113, 4.5, 3.65);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (420, 51, 'R', '2023-02-01', '2023-02-28', 0.05913, 159, 9.4);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (421, 52, 'PU', '2023-03-01', '2023-03-31', 0.13638, 156, 21.28);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (422, 52, 'S1', '2023-03-01', '2023-03-31', 0.010176, 156, 1.59);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (423, 52, 'P', '2023-03-01', '2023-03-31', 0.89691, 4.5, 4.04);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (424, 52, 'R', '2023-03-01', '2023-03-31', 0.05913, 156, 9.22);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (425, 52, 'PU', '2023-04-01', '2023-04-30', 0.13497, 145, 19.57);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (426, 52, 'S1', '2023-04-01', '2023-04-30', 0.010176, 145, 1.48);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (427, 52, 'P', '2023-04-01', '2023-04-30', 0.867978, 4.5, 3.91);
INSERT INTO EEConsumo (idEEConsumo, idEEFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (428, 52, 'R', '2023-04-01', '2023-04-30', 0.05913, 145, 8.57);

-- Tabella: EEFattura
DROP TABLE IF EXISTS EEFattura;

CREATE TABLE IF NOT EXISTS EEFattura (
    idEEFattura      INTEGER       PRIMARY KEY,
    idIntesta        INT,
    annoComp         INT,
    DataEmiss        DATE,
    fattNrAnno       INT,
    fattNrNumero     NVARCHAR (50),
    periodFattDtIniz DATE,
    periodFattDtFine DATE,
    CredPrecKwh      INT,
    CredAttKwh       INT,
    addizFER         MONEY,
    impostaQuiet     MONEY,
    TotPagare        MONEY
);

INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (1, 1, 2019, '2019-12-13', 2019, '100128446', '2019-09-01', '2019-10-31', 0, 0, 2.01, 0.16, 109.22999999999999);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (2, 1, 2020, '2020-02-13', 2020, '102011778', '2019-11-01', '2019-12-31', 0, 0, 2.48, 0.16, 121.25999999999999);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (3, 1, 2020, '2020-04-10', 2020, '102035619', '2020-01-01', '2020-02-29', 0, 0, 2.19, 0.16, 112.63);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (4, 1, 2020, '2020-06-09', 2020, '102058068', '2020-03-01', '2020-04-30', 0, 0, 2.58, 0.16, 123.47999999999999);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (5, 1, 2020, '2020-08-14', 2020, '102081806', '2020-05-01', '2020-06-30', 0, 0, 2.11, 0.16, 111.5);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (6, 1, 2020, '2020-09-29', 2020, '102093513', '2020-07-01', '2020-07-31', 0, 0, 0.84, 0.16, 249.08);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (7, 1, 2021, '2021-02-19', 2021, '10022766', '2020-08-01', '2020-12-31', 0, 0, 6.28, 0.16, 304.45);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (8, 1, 2021, '2021-09-24', 2021, '10092352', '2021-01-01', '2021-04-30', 1954, 633, 0.65, 0.16, 73.82000000000001);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (9, 1, 2022, '2022-01-28', 2022, '1000885', '2021-05-01', '2021-08-31', 633, 0, 3.41, 0.16, 174.89000000000001);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (10, 1, 2022, '2022-05-20', 2022, '1047683', '2021-09-01', '2021-12-31', 5096, 0, 5.55, 0.16, 257.21);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (11, 1, 2022, '2022-07-08', 2022, '1071926', '2022-01-01', '2022-04-30', 5096, 3940, 0.65, 0.16, 73.83);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (12, 1, 2022, '2022-10-27', 2022, '1118126', '2022-05-01', '2022-08-31', 3940, 2592, 0.67, 0.16, 75.65);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (13, 1, 2023, '2023-03-17', 2023, '22750', '2022-09-01', '2022-12-31', 2592, 910, 0.66, 0.16, 75.1);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (14, 1, 2023, '2023-08-02', 2023, '1044418', '2023-01-01', '2023-04-30', 5489, 4115, 0.65, 0.16, 73.82000000000001);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (15, 3, 2019, '2019-10-15', 2019, '100109767', '2019-07-01', '2019-08-31', 0, 0, 0.34, 0.16, 13.92);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (16, 3, 2019, '2019-12-13', 2019, '100132147', '2019-09-01', '2019-10-31', 0, 0, 0.33, 0.16, 29.38);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (17, 3, 2020, '2020-02-13', 2020, '102015439', '2019-11-01', '2019-12-31', 0, 0, 2.85, 0.16, 139.25);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (18, 3, 2020, '2020-04-10', 2020, '102039234', '2020-01-01', '2020-02-29', 0, 0, 9.22, 0.16, 291.62);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (19, 3, 2020, '2020-06-09', 2020, '102061655', '2020-03-01', '2020-04-30', 0, 0, 3.99, 0.16, 159.25);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (20, 3, 2020, '2020-08-14', 2020, '102085382', '2020-05-01', '2020-06-30', 0, 0, 1.23, 0.16, 79.56);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (21, 3, 2020, '2020-10-15', 2020, '102109019', '2020-07-01', '2020-08-31', 0, 0, 0.34, 0.16, 49.71);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (22, 3, 2020, '2020-12-15', 2020, '102131556', '2020-09-01', '2020-10-31', 0, 0, 0.33, 0.16, 47.19);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (23, 3, 2021, '2021-02-11', 2021, '10014754', '2020-11-01', '2020-12-31', 0, 0, 2.78, 0.16, 137.03);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (24, 3, 2021, '2021-04-15', 2021, '10038628', '2021-01-01', '2021-02-28', 0, 0, 3.42, 0.16, 143.12);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (25, 3, 2021, '2021-06-15', 2021, '10061022', '2021-03-01', '2021-04-30', 0, 0, 2.43, 0.16, 119.9);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (26, 3, 2021, '2021-08-27', 2021, '10083390', '2021-05-01', '2021-06-30', 0, 0, 1.43, 0.16, 92.13);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (27, 3, 2021, '2021-10-19', 2021, '10107226', '2021-07-01', '2021-08-31', 0, 0, 0.71, 0.16, 69.16);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (28, 3, 2021, '2021-12-15', 2021, '10129589', '2021-09-01', '2021-10-31', 0, 0, 1.79, 0.16, 104.33);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (29, 3, 2022, '2022-02-11', 2022, '1015677', '2021-11-01', '2021-12-31', 0, 0, 2.68, 0.16, 133.60999999999999);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (30, 3, 2022, '2022-04-14', 2022, '1038176', '2022-01-01', '2022-02-28', 0, 0, 3.94, 0.16, 163.32);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (31, 3, 2022, '2022-06-15', 2022, '1062269', '2022-03-01', '2022-04-30', 0, 0, 2.96, 0.16, 140.51);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (32, 3, 2022, '2022-08-12', 2022, '1086518', '2022-05-01', '2022-06-30', 0, 0, 1.3, 0.16, 107.25999999999999);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (33, 3, 2022, '2022-10-14', 2022, '1108917', '2022-07-01', '2022-08-31', 0, 0, 0.34, 0.16, 39.5);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (34, 3, 2023, '2023-06-15', 2023, '1033960', '2022-07-01', '2023-04-30', 0, 0, 3.45, 0.16, 322.9);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (35, 3, 2022, '2022-12-15', 2022, '1133113', '2022-09-01', '2022-10-31', 0, 0, 0.33, 0.16, 37.57);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (36, 3, 2023, '2023-02-13', 2023, '12550', '2022-11-01', '2022-12-31', 0, 0, 3.14, 0.16, 163.51);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (37, 3, 2023, '2023-04-25', 2023, '1011810', '2023-01-01', '2023-02-28', 0, 0, 1.48, 0.16, 107.14000000000001);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (38, 3, 2023, '2023-08-28', 2023, '1058159', '2023-05-01', '2023-06-30', 0, 0, 0.95, 0.16, 91.11);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (39, 2, 2021, '2021-02-11', 2021, '10009304', '2020-11-01', '2020-12-31', 0, 0, 1.11, 0.16, 82.19);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (40, 2, 2021, '2021-04-15', 2021, '10033266', '2021-01-01', '2021-02-28', 0, 0, 0.7, 0.16, 67.13);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (41, 2, 2021, '2021-06-15', 2021, '10055715', '2021-03-01', '2021-04-30', 0, 0, 0.5, 0.16, 61.92);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (42, 2, 2021, '2021-08-27', 2021, '10078178', '2021-05-01', '2021-06-30', 0, 0, 0.42, 0.16, 56.32000000000001);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (43, 2, 2021, '2021-10-19', 2021, '10102069', '2021-07-01', '2021-08-31', 0, 0, 0.69, 0.16, 69.14);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (44, 2, 2021, '2021-12-15', 2021, '10124453', '2021-09-01', '2021-10-31', 0, 0, 0.33, 0.16, 50.83);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (45, 2, 2022, '2022-02-11', 2022, '1010580', '2021-11-01', '2021-12-31', 0, 0, 0.54, 0.16, 63.2);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (46, 2, 2022, '2022-06-15', 2022, '1057277', '2022-03-01', '2022-04-30', 0, 0, 0.46, 0.16, 67.89);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (47, 2, 2022, '2022-08-12', 2022, '1081555', '2022-05-01', '2022-06-30', 0, 0, 0.33, 0.16, 56.65);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (48, 2, 2022, '2022-10-14', 2022, '1104011', '2022-07-01', '2022-08-31', 0, 0, 0.34, 0.16, 68.07000000000001);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (49, 2, 2022, '2022-12-15', 2022, '1128269', '2022-09-01', '2022-10-31', 0, 0, 0.33, 0.16, 62.81);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (50, 2, 2023, '2023-02-13', 2023, '7800', '2022-11-01', '2022-12-31', 0, 0, 0.33, 0.16, 97.19);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (51, 2, 2023, '2023-04-25', 2023, '1007077', '2023-01-01', '2023-02-28', 0, 0, 0.32, 0.16, 76.21000000000001);
INSERT INTO EEFattura (idEEFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, CredPrecKwh, CredAttKwh, addizFER, impostaQuiet, TotPagare) VALUES (52, 2, 2023, '2023-06-15', 2023, '1029302', '2023-03-01', '2023-04-30', 0, 0, 0.33, 0.16, 65.31);

-- Tabella: EELettura
DROP TABLE IF EXISTS EELettura;

CREATE TABLE IF NOT EXISTS EELettura (
    idLettura     INTEGER      PRIMARY KEY,
    idEEFattura   INT          NOT NULL,
    LettDtPrec    DATE,
    LettPrec      INT,
    TipoLettura   VARCHAR (16),
    LettDtAttuale DATE,
    LettAttuale   INT,
    LettConsumo   FLOAT
);

INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (1, 1, '2019-08-31', 18952, 'real', '2019-09-30', 19221, 269.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (2, 1, '2019-09-30', 19221, 'real', '2019-10-31', 19490, 269.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (3, 2, '2019-10-31', 19490, 'real', '2019-11-30', 19772, 282.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (4, 2, '2019-11-30', 19772, 'real', '2019-12-31', 20089, 317.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (5, 3, '2019-12-31', 20089, 'real', '2020-01-31', 20382, 293.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (6, 3, '2020-01-31', 20382, 'real', '2020-02-29', 20644, 262.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (7, 4, '2020-02-29', 20644, 'real', '2020-03-31', 20958, 314.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (8, 4, '2020-03-31', 20958, 'real', '2020-04-30', 21254, 296.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (9, 5, '2020-04-30', 21254, 'real', '2020-05-31', 21541, 287.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (10, 5, '2020-05-31', 21541, 'real', '2020-06-30', 21803, 262.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (11, 6, '2020-06-30', 21803, 'real', '2020-07-24', 21998, 195.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (12, 6, '2020-07-24', 21998, 'real', '2020-07-31', 22053, 55.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (13, 7, '2020-07-31', 22053, 'real', '2020-08-31', 22376, 323.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (14, 7, '2020-08-31', 22376, 'real', '2020-09-30', 22636, 260.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (15, 7, '2020-09-30', 22636, 'real', '2020-10-31', 22910, 274.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (16, 7, '2020-10-31', 22910, 'real', '2020-11-30', 23217, 307.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (17, 7, '2020-11-30', 23217, 'real', '2020-12-31', 23558, 341.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (18, 8, '2020-12-31', 23558, 'real', '2021-01-31', 23927, 369.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (19, 8, '2021-01-31', 23927, 'real', '2021-02-28', 24245, 318.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (20, 8, '2021-02-28', 24245, 'real', '2021-03-31', 24571, 326.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (21, 8, '2021-03-31', 24571, 'real', '2021-04-30', 24879, 308.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (22, 9, '2021-04-30', 24879, 'real', '2021-05-31', 25173, 294.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (23, 9, '2021-05-31', 25173, 'real', '2021-06-30', 25477, 304.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (24, 9, '2021-06-30', 25477, 'real', '2021-07-31', 25831, 354.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (25, 9, '2021-07-31', 25831, 'real', '2021-08-31', 26192, 361.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (26, 10, '2021-08-31', 26192, 'real', '2021-09-30', 26491, 299.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (27, 10, '2021-09-30', 26491, 'real', '2021-10-31', 26807, 316.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (28, 10, '2021-10-31', 26807, 'real', '2021-11-30', 27132, 325.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (29, 10, '2021-11-30', 27132, 'real', '2021-12-31', 27464, 332.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (30, 11, '2021-12-31', 27464, 'real', '2022-01-31', 27789, 325.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (31, 11, '2022-01-31', 27789, 'real', '2022-02-28', 28090, 301.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (32, 11, '2022-02-28', 28090, 'real', '2022-03-31', 28390, 300.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (33, 11, '2022-03-31', 28390, 'real', '2022-04-30', 28620, 230.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (34, 12, '2022-04-30', 28620, 'real', '2022-05-31', 28931, 311.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (35, 12, '2022-05-31', 28931, 'real', '2022-06-30', 29234, 303.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (36, 12, '2022-06-30', 29234, 'real', '2022-07-31', 29611, 377.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (37, 12, '2022-07-31', 29611, 'real', '2022-08-31', 29968, 357.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (38, 13, '2022-08-31', 29968, 'real', '2022-09-30', 30254, 286.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (39, 13, '2022-09-30', 30254, 'real', '2022-10-31', 30579, 325.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (40, 13, '2022-10-31', 30579, 'real', '2022-11-30', 31228, 649.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (41, 13, '2022-11-30', 31228, 'real', '2022-12-31', 31650, 422.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (42, 14, '2022-12-31', 31650, 'real', '2023-01-31', 32039, 389.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (43, 14, '2023-01-31', 32039, 'real', '2023-02-28', 32384, 345.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (44, 14, '2023-02-28', 32384, 'real', '2023-03-31', 32721, 337.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (45, 14, '2023-03-31', 32721, 'real', '2023-04-30', 33024, 303.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (46, 15, '2019-06-30', 23425, 'real', '2019-07-31', 23452, 27.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (47, 15, '2019-07-31', 23452, 'real', '2019-08-31', 23462, 10.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (48, 16, '2019-08-31', 23462, 'real', '2019-09-30', 23501, 39.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (49, 16, '2019-09-30', 23501, 'real', '2019-10-31', 23604, 103.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (50, 17, '2019-10-31', 23604, 'real', '2019-11-30', 23840, 236.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (51, 17, '2019-11-30', 23840, 'real', '2019-12-31', 24249, 409.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (52, 18, '2019-12-31', 24249, 'real', '2020-01-31', 24992, 743.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (53, 18, '2020-01-31', 24992, 'real', '2020-02-29', 25710, 718.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (54, 19, '2020-02-29', 25710, 'real', '2020-03-31', 26218, 508.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (55, 19, '2020-03-31', 26218, 'real', '2020-04-30', 26501, 283.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (56, 20, '2020-04-30', 26501, 'real', '2020-05-31', 26781, 280.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (57, 20, '2020-05-31', 26781, 'real', '2020-06-30', 26896, 115.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (58, 21, '2020-06-30', 26896, 'real', '2020-07-31', 27058, 162.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (59, 21, '2020-07-31', 27058, 'real', '2020-08-31', 27174, 116.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (60, 22, '2020-08-31', 27174, 'real', '2020-09-30', 27290, 116.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (61, 22, '2020-09-30', 27290, 'real', '2020-10-31', 27436, 146.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (62, 23, '2020-10-31', 27436, 'real', '2020-11-30', 27729, 293.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (63, 23, '2020-11-30', 27729, 'real', '2020-12-31', 28072, 343.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (64, 24, '2020-12-31', 28072, 'real', '2021-01-31', 28456, 384.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (65, 24, '2021-01-31', 28456, 'real', '2021-02-28', 28782, 326.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (66, 25, '2021-02-28', 28782, 'real', '2021-03-31', 29091, 309.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (67, 25, '2021-03-31', 29091, 'real', '2021-04-30', 29374, 283.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (68, 26, '2021-04-30', 29374, 'real', '2021-05-31', 29631, 257.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (69, 26, '2021-05-31', 29631, 'real', '2021-06-30', 29836, 205.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (70, 27, '2021-06-30', 29836, 'real', '2021-07-31', 30043, 207.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (71, 27, '2021-07-31', 30043, 'real', '2021-08-31', 30210, 167.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (72, 28, '2021-08-31', 30210, 'real', '2021-09-30', 30414, 204.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (73, 28, '2021-09-30', 30414, 'real', '2021-10-31', 30719, 305.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (74, 29, '2021-10-31', 30719, 'real', '2021-11-30', 31063, 344.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (75, 29, '2021-11-30', 31063, 'real', '2021-12-31', 31342, 279.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (76, 30, '2021-12-31', 31342, 'real', '2022-01-31', 31707, 365.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (77, 30, '2022-01-31', 31707, 'real', '2022-02-28', 31998, 291.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (78, 31, '2022-02-28', 31998, 'real', '2022-03-31', 32313, 315.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (79, 31, '2022-03-31', 32313, 'real', '2022-04-30', 32570, 257.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (80, 32, '2022-04-30', 32570, 'real', '2022-05-31', 32818, 248.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (81, 32, '2022-05-31', 32818, 'real', '2022-06-30', 33064, 246.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (82, 33, '2022-06-30', 0, 'stim', '2022-07-31', 0, 162.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (83, 33, '2022-07-31', 0, 'stim', '2022-08-31', 0, 116.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (84, 34, '2022-06-30', 33064, 'real', '2023-03-31', 35506, 2442.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (85, 34, '2023-03-31', 35506, 'real', '2023-04-26', 35784, 278.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (86, 34, '2023-04-26', 35784, 'real', '2023-04-30', 35824, 40.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (87, 35, '2022-08-31', 0, 'stim', '2022-09-30', 0, 116.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (88, 35, '2022-09-30', 0, 'stim', '2022-10-31', 0, 146.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (89, 36, '2022-10-31', 0, 'stim', '2022-11-30', 0, 293.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (90, 36, '2022-11-30', 0, 'stim', '2022-12-31', 0, 343.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (91, 37, '2022-12-31', 0, 'stim', '2023-01-31', 0, 267.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (92, 37, '2023-01-31', 0, 'stim', '2023-02-28', 0, 266.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (93, 38, '2023-04-30', 35824, 'real', '2023-05-31', 36139, 315.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (94, 38, '2023-05-31', 36139, 'real', '2023-06-30', 36281, 142.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (95, 39, '2020-10-31', 29286, 'real', '2020-11-30', 29491, 205.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (96, 39, '2020-11-30', 29491, 'real', '2020-12-31', 29707, 216.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (97, 40, '2020-12-31', 29707, 'real', '2021-01-31', 29906, 199.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (98, 40, '2021-01-31', 29906, 'real', '2021-02-28', 30066, 160.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (99, 41, '2021-02-28', 30066, 'real', '2021-03-31', 30252, 186.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (100, 41, '2021-03-31', 30252, 'real', '2021-04-30', 30407, 155.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (101, 42, '2021-04-30', 30407, 'real', '2021-05-31', 30550, 143.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (102, 42, '2021-05-31', 30550, 'real', '2021-06-30', 30719, 169.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (103, 43, '2021-06-30', 30719, 'real', '2021-07-31', 30899, 180.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (104, 43, '2021-07-31', 30899, 'real', '2021-08-31', 31091, 192.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (105, 44, '2021-08-31', 31091, 'real', '2021-09-30', 31219, 128.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (106, 44, '2021-09-30', 31219, 'real', '2021-10-31', 31374, 155.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (107, 45, '2021-10-31', 31374, 'real', '2021-11-30', 31529, 155.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (108, 45, '2021-11-30', 31529, 'real', '2021-12-31', 31720, 191.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (109, 46, '2022-02-28', 32085, 'real', '2022-03-31', 32261, 176.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (110, 46, '2022-03-31', 32261, 'real', '2022-04-30', 32419, 158.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (111, 47, '2022-04-30', 32419, 'real', '2022-05-31', 32556, 137.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (112, 47, '2022-05-31', 32556, 'real', '2022-06-30', 32699, 143.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (113, 48, '2022-06-30', 32699, 'real', '2022-07-31', 32880, 181.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (114, 48, '2022-07-31', 32880, 'real', '2022-08-31', 33045, 165.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (115, 49, '2022-08-31', 33045, 'real', '2022-09-30', 33183, 138.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (116, 49, '2022-09-30', 33183, 'real', '2022-10-31', 33364, 181.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (117, 50, '2022-10-31', 33364, 'real', '2022-11-30', 33525, 161.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (118, 50, '2022-11-30', 33525, 'real', '2022-12-31', 33695, 170.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (119, 51, '2022-12-31', 33695, 'real', '2023-01-31', 33865, 170.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (120, 51, '2023-01-31', 33865, 'real', '2023-02-28', 34024, 159.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (121, 52, '2023-02-28', 34024, 'real', '2023-03-31', 34180, 156.0);
INSERT INTO EELettura (idLettura, idEEFattura, LettDtPrec, LettPrec, TipoLettura, LettDtAttuale, LettAttuale, LettConsumo) VALUES (122, 52, '2023-03-31', 34180, 'real', '2023-04-30', 34325, 145.0);

-- Tabella: GASConsumo
DROP TABLE IF EXISTS GASConsumo;

CREATE TABLE IF NOT EXISTS GASConsumo (
    idConsumo    INTEGER         PRIMARY KEY,
    idGASFattura INT             NOT NULL,
    tipoSpesa    VARCHAR (4),
    dtIniz       DATE,
    dtFine       DATE,
    prezzoUnit   DECIMAL (10, 6),
    quantita     DECIMAL (8, 2),
    importo      MONEY
);

INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1, 1, 'G1', '2019-10-01', '2019-11-30', 0.470065, 85, 39.96);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2, 1, 'G2', '2019-10-01', '2019-11-30', 0.479373, 137, 65.67);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (3, 2, 'G1', '2019-05-23', '2019-12-18', 0.470065, 293, 137.73);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (4, 2, 'G2', '2019-05-23', '2019-12-18', 0.479373, 14, 6.71);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (5, 2, 'G1', '2019-12-19', '2019-12-31', 0.470065, 18, 8.46);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (6, 2, 'G2', '2019-12-19', '2019-12-31', 0.479373, 32, 15.34);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (7, 2, 'G3', '2019-12-19', '2019-12-31', 0.488772, 49, 23.95);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (8, 2, 'G1', '2020-01-01', '2020-01-31', 0.470065, 43, 20.21);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (9, 2, 'G2', '2020-01-01', '2020-01-31', 0.479373, 75, 35.95);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (10, 2, 'G3', '2020-01-01', '2020-01-31', 0.488772, 117, 57.19);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (11, 3, 'G1', '2019-12-19', '2019-12-31', 0.470065, 18, 8.46);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (12, 3, 'G2', '2019-12-19', '2019-12-31', 0.479373, 32, 15.34);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (13, 3, 'G3', '2019-12-19', '2019-12-31', 0.488772, 35, 17.11);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (14, 3, 'G1', '2020-01-01', '2020-02-24', 0.470065, 77, 36.2);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (15, 3, 'G2', '2020-01-01', '2020-02-24', 0.479373, 134, 64.24);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (16, 3, 'G3', '2020-01-01', '2020-02-24', 0.488772, 151, 73.8);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (17, 3, 'G1', '2020-02-25', '2020-03-31', 0.470065, 50, 23.5);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (18, 3, 'G2', '2020-02-25', '2020-03-31', 0.479373, 88, 42.18);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (19, 3, 'G3', '2020-02-25', '2020-03-31', 0.488772, 53, 25.9);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (20, 4, 'G1', '2020-02-25', '2020-05-21', 0.470065, 121, 56.88);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (21, 4, 'G2', '2020-02-25', '2020-05-21', 0.479373, 138, 66.15);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (22, 4, 'G1', '2020-05-22', '2020-05-31', 0.470065, 13, 6.11);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (23, 5, 'G1', '2020-06-01', '2020-07-31', 0.470065, 52, 24.44);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (24, 6, 'G1', '2020-08-01', '2020-09-30', 0.470065, 65, 30.55);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (25, 7, 'G1', '2020-10-01', '2020-11-30', 0.470065, 85, 39.96);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (26, 7, 'G2', '2020-10-01', '2020-11-30', 0.479373, 137, 65.67);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (27, 8, 'G1', '2020-05-22', '2020-12-21', 0.470065, 298, 140.07999999999998);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (28, 8, 'G2', '2020-05-22', '2020-12-21', 0.479373, 77, 36.91);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (29, 8, 'G1', '2020-12-22', '2020-12-31', 0.470065, 14, 6.58);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (30, 8, 'G2', '2020-12-22', '2020-12-31', 0.479373, 24, 11.5);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (31, 8, 'G3', '2020-12-22', '2020-12-31', 0.488772, 38, 18.57);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (32, 8, 'G1', '2021-01-01', '2021-01-31', 0.470065, 43, 20.21);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (33, 8, 'G2', '2021-01-01', '2021-01-31', 0.479373, 76, 36.43);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (34, 8, 'G3', '2021-01-01', '2021-01-31', 0.488772, 116, 56.7);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (35, 9, 'G1', '2020-12-22', '2020-12-31', 0.470065, 14, 6.58);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (36, 9, 'G2', '2020-12-22', '2020-12-31', 0.479373, 24, 11.5);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (37, 9, 'G3', '2020-12-22', '2020-12-31', 0.488772, 42, 20.53);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (38, 9, 'G1', '2021-01-01', '2021-02-19', 0.470065, 70, 32.9);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (39, 9, 'G2', '2021-01-01', '2021-02-19', 0.479373, 122, 58.48);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (40, 9, 'G3', '2021-01-01', '2021-02-19', 0.488772, 208, 101.66);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (41, 9, 'G1', '2021-02-20', '2021-03-31', 0.470065, 56, 26.32);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (42, 9, 'G2', '2021-02-20', '2021-03-31', 0.479373, 98, 46.98);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (43, 9, 'G3', '2021-02-20', '2021-03-31', 0.488772, 66, 32.26000000000001);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (44, 10, 'G1', '2021-02-20', '2021-04-08', 0.470065, 67, 31.49);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (45, 10, 'G2', '2021-02-20', '2021-04-08', 0.479373, 117, 56.09);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (46, 10, 'G3', '2021-02-20', '2021-04-08', 0.488772, 31, 15.15);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (47, 10, 'G1', '2021-04-09', '2021-05-31', 0.470065, 74, 34.78);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (48, 10, 'G2', '2021-04-09', '2021-05-31', 0.479373, 42, 20.13);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (49, 11, 'G1', '2021-06-01', '2021-07-31', 0.470065, 52, 24.44);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (50, 12, 'G1', '2021-08-01', '2021-09-30', 0.470065, 65, 30.55);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (51, 13, 'G1', '2021-10-01', '2021-11-30', 0.470065, 85, 39.96);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (52, 13, 'G2', '2021-10-01', '2021-11-30', 0.479373, 137, 65.67);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (53, 14, 'G1', '2021-04-09', '2021-12-17', 0.470065, 354, 166.4);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (54, 14, 'G2', '2021-04-09', '2021-12-17', 0.479373, 91, 43.62);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (55, 14, 'G1', '2021-12-18', '2021-12-31', 0.470065, 20, 9.4);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (56, 14, 'G2', '2021-12-18', '2021-12-31', 0.479373, 34, 16.3);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (57, 14, 'G3', '2021-12-18', '2021-12-31', 0.488772, 53, 25.9);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (58, 14, 'G1', '2022-01-01', '2022-01-31', 0.611085, 43, 26.28);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (59, 14, 'G2', '2022-01-01', '2022-01-31', 0.623185, 76, 47.36);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (60, 14, 'G3', '2022-01-01', '2022-01-31', 0.635404, 116, 73.71000000000001);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (61, 15, 'G1', '2021-12-18', '2021-12-31', 0.470065, 20, 9.4);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (62, 15, 'G2', '2021-12-18', '2021-12-31', 0.479373, 34, 16.3);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (63, 15, 'G3', '2021-12-18', '2021-12-31', 0.488772, 54, 26.39);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (64, 15, 'G1', '2022-01-01', '2022-02-16', 0.611085, 66, 40.33);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (65, 15, 'G2', '2022-01-01', '2022-02-16', 0.623185, 115, 71.67);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (66, 15, 'G3', '2022-01-01', '2022-02-16', 0.635404, 180, 114.37);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (67, 15, 'G1', '2022-02-17', '2022-03-31', 0.611085, 60, 36.67);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (68, 15, 'G2', '2022-02-17', '2022-03-31', 0.623185, 105, 65.42999999999999);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (69, 15, 'G3', '2022-02-17', '2022-03-31', 0.635404, 76, 48.29);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (70, 16, 'G1', '2022-02-17', '2022-04-28', 0.611085, 99, 60.5);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (71, 16, 'G2', '2022-02-17', '2022-04-28', 0.623185, 173, 107.80999999999999);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (72, 16, 'G3', '2022-02-17', '2022-04-28', 0.635404, 7, 4.45);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (73, 16, 'G1', '2022-04-29', '2022-05-31', 0.611085, 46, 28.11);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (74, 17, 'G1', '2022-06-01', '2022-06-30', 0.611085, 23, 14.05);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (75, 17, 'G1', '2022-07-01', '2022-07-31', 0.79441, 23, 18.27);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (76, 18, 'G1', '2022-08-01', '2022-09-30', 0.79441, 58, 46.08);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (77, 19, 'G1', '2022-04-29', '2022-06-30', 0.611085, 28, 17.11);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (78, 19, 'G1', '2022-07-01', '2022-11-23', 0.79441, 65, 51.64);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (79, 19, 'G3', '2022-11-24', '2022-11-30', 0.826025, 6, 4.96);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (80, 20, 'G1', '2022-11-24', '2022-12-31', 0.79441, 53, 42.1);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (81, 20, 'G2', '2022-11-24', '2022-12-31', 0.81014, 93, 75.34);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (82, 20, 'G3', '2022-11-24', '2022-12-31', 0.826025, 46, 38);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (83, 20, 'G1', '2023-01-01', '2023-01-26', 0.79441, 36, 28.6);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (84, 20, 'G2', '2023-01-01', '2023-01-26', 0.81014, 63, 51.04);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (85, 20, 'G3', '2023-01-01', '2023-01-26', 0.826025, 32, 26.43);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (86, 20, 'G3', '2023-01-27', '2023-01-31', 0.826025, 5, 4.13);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (87, 21, 'G1', '2023-01-27', '2023-03-23', 0.79441, 78, 61.96);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (88, 21, 'G2', '2023-01-27', '2023-03-23', 0.81014, 137, 110.99000000000001);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (89, 21, 'G3', '2023-01-27', '2023-03-23', 0.826025, 15, 12.39);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (90, 21, 'G2', '2023-03-24', '2023-03-31', 0.81014, 18, 14.58);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (91, 22, 'G1', '2023-03-24', '2023-03-31', 0.79441, 11, 8.74);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (92, 22, 'G2', '2023-03-24', '2023-03-31', 0.81014, 1, 0.81);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (93, 22, 'G1', '2023-04-01', '2023-04-30', 0.479694, 42, 20.15);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (94, 22, 'G2', '2023-04-01', '2023-04-30', 0.479694, 1, 0.48);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (95, 22, 'G1', '2023-05-01', '2023-05-03', 0.364547, 4, 1.46);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (96, 22, 'G1', '2023-06-01', '2023-06-30', 0.354598, 23, 8.16);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (97, 25, 'G1', '2019-05-18', '2019-12-13', 0.470065, 293, 137.73);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (98, 25, 'G2', '2019-05-18', '2019-12-13', 0.479373, 39, 18.7);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (99, 26, 'G1', '2019-12-14', '2019-12-31', 0.470065, 25, 11.75);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (100, 26, 'G2', '2019-12-14', '2019-12-31', 0.479373, 44, 21.09);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (101, 26, 'G3', '2019-12-14', '2019-12-31', 0.488772, 18, 8.8);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (102, 26, 'G1', '2020-01-01', '2020-02-18', 0.470065, 68, 31.96);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (103, 26, 'G2', '2020-01-01', '2020-02-18', 0.479373, 119, 57.05);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (104, 26, 'G3', '2020-01-01', '2020-02-18', 0.488772, 50, 24.44);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (105, 30, 'G1', '2020-05-21', '2020-12-15', 0.470065, 225, 105.75999999999999);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (106, 31, 'G1', '2020-12-16', '2020-12-31', 0.470065, 22, 10.34);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (107, 31, 'G2', '2020-12-16', '2020-12-31', 0.479373, 39, 18.7);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (108, 31, 'G3', '2020-12-16', '2020-12-31', 0.488772, 32, 15.64);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (109, 31, 'G1', '2021-01-01', '2021-02-22', 0.470065, 74, 34.78);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (110, 31, 'G2', '2021-01-01', '2021-02-22', 0.479373, 129, 61.84);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (111, 31, 'G3', '2021-01-01', '2021-02-22', 0.488772, 106, 51.81);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (112, 32, 'G1', '2021-02-23', '2021-04-14', 0.470065, 71, 33.37);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (113, 32, 'G2', '2021-02-23', '2021-04-14', 0.479373, 99, 47.46);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (114, 34, 'G1', '2021-04-15', '2021-12-13', 0.470065, 307, 144.31);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (115, 35, 'G1', '2021-12-14', '2021-12-31', 0.470065, 25, 11.75);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (116, 35, 'G2', '2021-12-14', '2021-12-31', 0.479373, 44, 21.09);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (117, 35, 'G3', '2021-12-14', '2021-12-31', 0.488772, 31, 15.15);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (118, 35, 'G1', '2022-01-01', '2022-02-22', 0.611085, 74, 45.22);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (119, 35, 'G2', '2022-01-01', '2022-02-22', 0.623185, 129, 80.39);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (120, 35, 'G3', '2022-01-01', '2022-02-22', 0.635404, 91, 57.82000000000001);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (121, 36, 'G1', '2022-02-23', '2022-04-22', 0.611085, 82, 50.11);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (122, 36, 'G2', '2022-02-23', '2022-04-22', 0.623185, 126, 78.52000000000001);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (123, 37, 'G1', '2022-06-01', '2022-06-30', 0.611085, 18, 11);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (124, 37, 'G1', '2022-07-01', '2022-07-31', 0.79441, 18, 14.3);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (125, 38, 'G1', '2022-08-01', '2022-09-30', 0.79441, 45, 35.75);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (126, 39, 'G2', '2022-10-01', '2022-11-30', 0.81014, 65, 52.66);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (127, 40, 'G1', '2022-04-23', '2022-06-30', 0.611085, 37, 22.61);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (128, 40, 'G1', '2022-07-01', '2022-12-02', 0.79441, 83, 65.94);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (129, 40, 'G3', '2023-01-01', '2023-01-31', 0.826025, 40, 33.04);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (130, 41, 'G2', '2023-02-01', '2023-03-31', 0.81014, 121, 98.03);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (131, 42, 'G1', '2023-02-01', '2023-02-28', 0.79441, 39, 30.98);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (132, 42, 'G2', '2023-02-01', '2023-02-28', 0.81014, 28, 22.68);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (133, 42, 'G1', '2023-03-01', '2023-03-31', 0.79441, 43, 34.16);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (134, 42, 'G2', '2023-03-01', '2023-03-31', 0.81014, 31, 25.11);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (135, 42, 'G1', '2023-04-01', '2023-04-30', 0.479694, 42, 20.15);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (136, 42, 'G2', '2023-04-01', '2023-04-30', 0.479694, 28, 13.43);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (137, 42, 'G1', '2023-05-01', '2023-05-04', 0.364547, 6, 2.19);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (138, 42, 'G2', '2023-05-01', '2023-05-04', 0.364547, 4, 1.46);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (139, 42, 'G1', '2023-05-05', '2023-05-31', 0.364547, 6, 2.19);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (140, 42, 'G1', '2023-06-01', '2023-06-30', 0.354598, 7, 2.48);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (141, 43, 'G1', '2020-10-01', '2020-11-30', 0.470065, 85, 39.96);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (142, 43, 'G2', '2020-10-01', '2020-11-30', 0.479373, 128, 61.36);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (143, 44, 'G1', '2020-05-21', '2020-12-15', 0.470065, 291, 136.79000000000002);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (144, 44, 'G2', '2020-05-21', '2020-12-15', 0.479373, 102, 48.9);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (145, 44, 'G1', '2020-12-16', '2020-12-31', 0.470065, 22, 10.34);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (146, 44, 'G2', '2020-12-16', '2020-12-31', 0.479373, 39, 18.7);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (147, 44, 'G3', '2020-12-16', '2020-12-31', 0.488772, 54, 26.39);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (148, 44, 'G1', '2021-01-01', '2021-01-31', 0.470065, 43, 20.21);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (149, 44, 'G2', '2021-01-01', '2021-01-31', 0.479373, 76, 36.43);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (150, 44, 'G3', '2021-01-01', '2021-01-31', 0.488772, 106, 51.81);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (151, 45, 'G1', '2020-12-16', '2020-12-31', 0.470065, 22, 10.34);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (152, 45, 'G2', '2020-12-16', '2020-12-31', 0.479373, 39, 18.7);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (153, 45, 'G3', '2020-12-16', '2020-12-31', 0.488772, 71, 34.7);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (154, 45, 'G1', '2021-01-01', '2021-02-22', 0.470065, 74, 34.78);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (155, 45, 'G2', '2021-01-01', '2021-02-22', 0.479373, 129, 61.84);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (156, 45, 'G3', '2021-01-01', '2021-02-22', 0.488772, 234, 114.37);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (157, 45, 'G1', '2021-02-23', '2021-03-31', 0.470065, 52, 24.44);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (158, 45, 'G2', '2021-02-23', '2021-03-31', 0.479373, 90, 43.14);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (159, 45, 'G3', '2021-02-23', '2021-03-31', 0.488772, 48, 23.46);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (160, 46, 'G1', '2021-02-23', '2021-04-14', 0.470065, 71, 33.37);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (161, 46, 'G2', '2021-02-23', '2021-04-14', 0.479373, 124, 59.44);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (162, 46, 'G3', '2021-02-23', '2021-04-14', 0.488772, 71, 34.7);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (163, 46, 'G1', '2021-04-15', '2021-05-31', 0.470065, 66, 31.02);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (164, 46, 'G2', '2021-04-15', '2021-05-31', 0.479373, 25, 11.98);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (165, 47, 'G1', '2021-06-01', '2021-07-31', 0.470065, 50, 23.5);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (166, 48, 'G1', '2021-08-01', '2021-09-30', 0.470065, 63, 29.61);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (167, 49, 'G1', '2021-10-01', '2021-11-30', 0.470065, 85, 39.96);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (168, 49, 'G2', '2021-10-01', '2021-11-30', 0.479373, 128, 61.36);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (169, 50, 'G1', '2021-04-15', '2021-12-13', 0.470065, 340, 159.82);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (170, 50, 'G2', '2021-04-15', '2021-12-13', 0.479373, 231, 110.74000000000001);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (171, 50, 'G1', '2021-12-14', '2021-12-31', 0.470065, 25, 11.75);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (172, 50, 'G2', '2021-12-14', '2021-12-31', 0.479373, 44, 21.09);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (173, 50, 'G3', '2021-12-14', '2021-12-31', 0.488772, 60, 29.33);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (174, 50, 'G1', '2022-01-01', '2022-01-31', 0.611085, 43, 26.28);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (175, 50, 'G2', '2022-01-01', '2022-01-31', 0.623185, 76, 47.36);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (176, 50, 'G3', '2022-01-01', '2022-01-31', 0.635404, 106, 67.35);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (177, 51, 'G1', '2021-12-14', '2021-12-31', 0.470065, 25, 11.75);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (178, 51, 'G2', '2021-12-14', '2021-12-31', 0.479373, 44, 21.09);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (179, 51, 'G3', '2021-12-14', '2021-12-31', 0.488772, 97, 47.41);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (180, 51, 'G1', '2022-01-01', '2022-02-22', 0.611085, 74, 45.22);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (181, 51, 'G2', '2022-01-01', '2022-02-22', 0.623185, 129, 80.39);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (182, 51, 'G3', '2022-01-01', '2022-02-22', 0.635404, 287, 182.35999999999999);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (183, 51, 'G1', '2022-02-23', '2022-03-31', 0.611085, 52, 31.78);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (184, 51, 'G2', '2022-02-23', '2022-03-31', 0.623185, 90, 56.09);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (185, 51, 'G3', '2022-02-23', '2022-03-31', 0.635404, 48, 30.5);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (186, 52, 'G1', '2022-02-23', '2022-04-22', 0.611085, 82, 50.11);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (187, 52, 'G2', '2022-02-23', '2022-04-22', 0.623185, 144, 89.74);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (188, 52, 'G3', '2022-02-23', '2022-04-22', 0.635404, 205, 130.26);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (189, 52, 'G1', '2022-04-23', '2022-05-31', 0.611085, 54, 33);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (190, 52, 'G2', '2022-04-23', '2022-05-31', 0.623185, 11, 6.86);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (191, 53, 'G1', '2022-06-01', '2022-06-30', 0.611085, 29, 17.72);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (192, 53, 'G1', '2022-07-01', '2022-07-31', 0.79441, 29, 23.04);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (193, 54, 'G1', '2022-08-01', '2022-09-30', 0.79441, 72, 57.2);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (194, 55, 'G1', '2022-04-23', '2022-06-30', 0.611085, 50, 30.55);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (195, 55, 'G1', '2022-07-01', '2022-11-14', 0.79441, 99, 78.65);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (196, 55, 'G3', '2022-11-15', '2022-11-30', 0.826025, 31, 25.61);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (197, 56, 'G1', '2022-11-15', '2022-12-31', 0.79441, 66, 52.42999999999999);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (198, 56, 'G2', '2022-11-15', '2022-12-31', 0.81014, 115, 93.17);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (199, 56, 'G3', '2022-11-15', '2022-12-31', 0.826025, 150, 123.9);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (200, 56, 'G1', '2023-01-01', '2023-01-31', 0.79441, 43, 34.16);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (201, 56, 'G2', '2023-01-01', '2023-01-31', 0.81014, 76, 61.57000000000001);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (202, 56, 'G3', '2023-01-01', '2023-01-31', 0.826025, 99, 81.78);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (203, 57, 'G3', '2023-02-01', '2023-03-31', 0.826025, 152, 125.55999999999999);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (204, 58, 'G1', '2023-02-01', '2023-02-28', 0.79441, 39, 30.98);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (205, 58, 'G2', '2023-02-01', '2023-02-28', 0.81014, 68, 55.09);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (206, 58, 'G3', '2023-02-01', '2023-02-28', 0.826025, 38, 31.39);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (207, 58, 'G1', '2023-03-01', '2023-03-31', 0.79441, 43, 34.16);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (208, 58, 'G2', '2023-03-01', '2023-03-31', 0.81014, 76, 61.57000000000001);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (209, 58, 'G3', '2023-03-01', '2023-03-31', 0.826025, 42, 34.69);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (210, 58, 'G1', '2023-04-01', '2023-04-30', 0.479694, 42, 20.15);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (211, 58, 'G2', '2023-04-01', '2023-04-30', 0.479694, 73, 35.02);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (212, 58, 'G3', '2023-04-01', '2023-04-30', 0.479694, 40, 19.19);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (213, 58, 'G1', '2023-05-01', '2023-05-04', 0.364547, 6, 2.19);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (214, 58, 'G2', '2023-05-01', '2023-05-04', 0.364547, 10, 3.65);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (215, 58, 'G3', '2023-05-01', '2023-05-04', 0.364547, 5, 1.82);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (216, 58, 'G1', '2023-05-05', '2023-05-15', 0.364547, 14, 5.1);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (217, 58, 'G1', '2023-05-16', '2023-05-31', 0.364547, 11, 4.01);
INSERT INTO GASConsumo (idConsumo, idGASFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (218, 58, 'G1', '2023-06-01', '2023-06-30', 0.354598, 20, 7.09);

-- Tabella: GASFattura
DROP TABLE IF EXISTS GASFattura;

CREATE TABLE IF NOT EXISTS GASFattura (
    idGASFattura        INTEGER       PRIMARY KEY,
    idIntesta           INT,
    annoComp            INT,
    DataEmiss           DATE,
    fattNrAnno          INT,
    fattNrNumero        NVARCHAR (50),
    periodFattDtIniz    DATE,
    periodFattDtFine    DATE,
    periodEffDtIniz     DATE,
    periodEffDtFine     DATE,
    periodAccontoDtIniz DATE,
    periodAccontoDtFine DATE,
    accontoBollPrec     MONEY,
    addizFER            MONEY,
    impostaQuiet        MONEY,
    TotPagare           MONEY
);

INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (1, 1, 2020, '2020-01-15', 2020, '120013992', '2019-10-01', '2019-11-30', NULL, NULL, '2019-10-01', '2019-11-30', NULL, 4.4, 0.36, 111.8);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (2, 1, 2020, '2020-03-13', 2020, '120024048', '2019-12-01', '2020-01-31', NULL, NULL, '2019-12-19', '2020-01-31', -165.79000000000002, 5.8, 0.36, 147.4);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (3, 1, 2020, '2020-05-16', 2020, '120050518', '2020-02-01', '2020-03-31', NULL, NULL, '2020-02-25', '2020-03-31', -161.1, 6.04, 0.36, 153.48);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (4, 1, 2020, '2020-07-16', 2020, '120069042', '2020-04-01', '2020-05-31', NULL, NULL, '2020-05-22', '2020-05-31', -91.58, 1.61, 0.36, 40.77);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (5, 1, 2020, '2020-09-09', 2020, '120087431', '2020-06-01', '2020-07-31', NULL, NULL, '2020-06-01', '2020-07-31', NULL, 1.07, 0.36, 27.11);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (6, 1, 2020, '2020-11-13', 2020, '120105879', '2020-08-01', '2020-09-30', NULL, NULL, '2020-08-01', '2020-09-30', NULL, 1.32, 0.36, 33.47);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (7, 1, 2021, '2021-01-14', 2021, '12013676', '2020-10-01', '2020-11-30', NULL, NULL, '2020-10-01', '2020-11-30', NULL, 4.4, 0.36, 111.8);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (8, 1, 2021, '2021-03-15', 2021, '12023848', '2020-12-01', '2021-01-31', NULL, NULL, '2020-12-22', '2021-01-31', -166.73, 6.64, 0.36, 168.77);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (9, 1, 2021, '2021-05-13', 2021, '12042330', '2021-02-01', '2021-03-31', NULL, NULL, '2021-02-20', '2021-03-31', -149.99, 7.74, 0.36, 196.8);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (10, 1, 2021, '2021-07-29', 2021, '12069178', '2021-04-01', '2021-05-31', NULL, NULL, '2021-04-09', '2021-05-31', -105.55999999999999, 2.2, 0.36, 55.88);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (11, 1, 2021, '2021-09-20', 2021, '12087506', '2021-06-01', '2021-07-31', NULL, NULL, '2021-06-01', '2021-07-31', NULL, 1.07, 0.36, 27.11);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (12, 1, 2021, '2021-11-15', 2021, '12105923', '2021-08-01', '2021-09-30', NULL, NULL, '2021-08-01', '2021-09-30', NULL, 1.32, 0.36, 33.47);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (13, 1, 2022, '2022-01-13', 2022, '1205461', '2021-10-01', '2021-11-30', NULL, NULL, '2021-10-01', '2021-11-30', NULL, 4.4, 0.36, 111.8);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (14, 1, 2022, '2022-03-16', 2022, '1232466', '2021-12-01', '2022-01-31', NULL, NULL, '2021-12-18', '2022-01-31', -215.53000000000003, 8, 0.36, 203.37);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (15, 1, 2022, '2022-05-16', 2022, '1251102', '2022-02-01', '2022-03-31', NULL, NULL, '2022-02-17', '2022-03-31', -198.95, 9.49, 0.36, 241.3);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (16, 1, 2022, '2022-07-12', 2022, '1261218', '2022-04-01', '2022-05-31', NULL, NULL, '2022-04-29', '2022-05-31', -150.39000000000001, 2.14, 0.36, 54.22000000000001);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (17, 1, 2022, '2022-09-14', 2022, '1279815', '2022-06-01', '2022-07-31', NULL, NULL, '2022-06-01', '2022-07-31', NULL, 1.39, 0.36, 35.31);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (18, 1, 2022, '2022-11-14', 2022, '1298310', '2022-08-01', '2022-09-30', NULL, NULL, '2022-08-01', '2022-09-30', NULL, 1.95, 0.36, 49.63);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (19, 1, 2023, '2023-01-13', 2023, '5309', '2022-10-01', '2022-11-30', '2022-04-29', '2022-11-23', NULL, NULL, NULL, -0.39, 0.36, 0);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (20, 1, 2023, '2023-05-16', 2023, '2013566', '2022-12-01', '2023-01-31', '2022-11-24', '2023-01-26', NULL, NULL, NULL, 10.49, 0.36, 256.89);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (21, 1, 2023, '2023-07-14', 2023, '2031916', '2023-02-01', '2023-03-31', '2023-01-27', '2023-03-23', NULL, NULL, NULL, 7.82, 0.36, 198.92000000000002);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (22, 1, 2023, '2023-09-18', 2023, '2042139', '2023-04-01', '2023-06-30', '2023-03-24', '2023-05-03', NULL, NULL, NULL, 1.78, 0.36, 45.31);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (23, 3, 2019, '2019-11-14', 2019, '10107788', '2019-08-01', '2019-09-30', NULL, NULL, '2019-08-01', '2019-09-30', NULL, 0.07, 0.36, 0);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (24, 3, 2020, '2020-01-15', 2020, '120015400', '2019-10-01', '2019-11-30', NULL, NULL, '2019-10-01', '2019-11-30', NULL, 0.07, 0.36, 5.51);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (25, 3, 2020, '2020-03-13', 2020, '120025438', '2019-12-01', '2020-01-31', NULL, NULL, '2019-12-14', '2020-01-31', NULL, 6.48, 0.36, 164.79000000000002);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (26, 3, 2020, '2020-05-16', 2020, '120051904', '2020-02-01', '2020-03-31', NULL, NULL, '2020-02-19', '2020-03-31', NULL, 6.42, 0.36, 163.32999999999998);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (27, 3, 2020, '2020-09-09', 2020, '120088801', '2020-06-01', '2020-07-31', NULL, NULL, '2020-06-01', '2020-07-31', NULL, 0.07, 0.36, 0);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (28, 3, 2020, '2020-11-13', 2020, '120107222', '2020-08-01', '2020-09-30', NULL, NULL, '2020-08-01', '2020-09-30', NULL, 0.07, 0.36, 0);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (29, 3, 2021, '2021-01-14', 2021, '12015014', '2020-10-01', '2020-11-30', NULL, NULL, '2020-10-01', '2020-11-30', NULL, 0.07, 0.36, 5.01);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (30, 3, 2021, '2021-03-15', 2021, '12025158', '2020-12-01', '2021-01-31', NULL, NULL, '2020-12-16', '2021-01-31', NULL, 4.4, 0.36, 111.96);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (31, 3, 2021, '2021-05-13', 2021, '12043637', '2021-02-01', '2021-03-31', NULL, NULL, '2021-02-23', '2021-03-31', NULL, 7.98, 0.36, 202.94);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (32, 3, 2021, '2021-07-29', 2021, '12070438', '2021-04-01', '2021-05-31', NULL, NULL, '2021-04-15', '2021-05-31', NULL, 3.38, 0.36, 85.81);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (33, 3, 2021, '2021-11-15', 2021, '12107174', '2021-08-01', '2021-09-30', NULL, NULL, '2021-08-01', '2021-09-30', NULL, 0.07, 0.36, 0);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (34, 3, 2022, '2022-03-16', 2022, '1233693', '2021-12-01', '2022-01-31', NULL, NULL, '2021-12-14', '2022-01-31', NULL, 5.98, 0.36, 152.15);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (35, 3, 2022, '2022-05-16', 2022, '1252325', '2022-02-01', '2022-03-31', NULL, NULL, '2022-02-23', '2022-03-31', NULL, 9.55, 0.36, 242.88000000000002);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (36, 3, 2022, '2022-07-12', 2022, '1262434', '2022-04-01', '2022-05-31', NULL, NULL, '2022-04-23', '2022-05-31', NULL, 5.34, 0.36, 135.77);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (37, 3, 2022, '2022-09-14', 2022, '1281022', '2022-06-01', '2022-07-31', NULL, NULL, '2022-06-01', '2022-07-31', NULL, 1.1, 0.36, 28);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (38, 3, 2022, '2022-11-14', 2022, '1299503', '2022-08-01', '2022-09-30', NULL, NULL, '2022-08-01', '2022-09-30', NULL, 1.53, 0.36, 38.88);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (39, 3, 2023, '2023-01-13', 2023, '6499', '2022-10-01', '2022-11-30', NULL, NULL, NULL, NULL, NULL, 4.99, 0.36, 126.96);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (40, 3, 2023, '2023-03-22', 2023, '33600', '2022-12-01', '2023-01-31', '2022-06-01', '2022-12-02', NULL, NULL, NULL, 6.49, 0.36, 165.10999999999999);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (41, 3, 2023, '2023-07-14', 2023, '2033084', '2023-02-01', '2023-03-31', NULL, NULL, NULL, NULL, NULL, 6.75, 0.36, 171.73);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (42, 3, 2023, '2023-09-18', 2023, '2043292', '2023-04-01', '2023-06-30', '2023-02-01', '2023-05-04', NULL, NULL, NULL, 0.55, 0.36, 13.9);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (43, 2, 2021, '2021-01-14', 2021, '12012973', '2020-10-01', '2020-11-30', NULL, NULL, '2020-10-01', '2020-11-30', NULL, 4.22, 0.36, 107.3);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (44, 2, 2021, '2021-03-15', 2021, '12023146', '2020-12-01', '2021-01-31', NULL, NULL, '2020-12-16', '2021-01-31', -160.54000000000002, 7.82, 0.36, 198.78);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (45, 2, 2021, '2021-05-13', 2021, '12041633', '2021-02-01', '2021-03-31', NULL, NULL, '2021-02-23', '2021-03-31', -163.88, 8.34, 0.36, 212.1);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (46, 2, 2021, '2021-07-29', 2021, '12068492', '2021-04-01', '2021-05-31', NULL, NULL, '2021-04-15', '2021-05-31', -91.03999999999999, 3.32, 0.36, 84.39);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (47, 2, 2021, '2021-09-20', 2021, '12086823', '2021-06-01', '2021-07-31', NULL, NULL, '2021-06-01', '2021-07-31', NULL, 1.03, 0.36, 26.13);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (48, 2, 2021, '2021-11-15', 2021, '12105242', '2021-08-01', '2021-09-30', NULL, NULL, '2021-08-01', '2021-09-30', NULL, 1.28, 0.36, 32.48999999999999);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (49, 2, 2022, '2022-01-13', 2022, '1204787', '2021-10-01', '2021-11-30', NULL, NULL, '2021-10-01', '2021-11-30', NULL, 4.22, 0.36, 107.3);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (50, 2, 2022, '2022-03-16', 2022, '1231796', '2021-12-01', '2022-01-31', NULL, NULL, '2021-12-14', '2022-01-31', -197.43, 11.39, 0.36, 289.74);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (51, 2, 2022, '2022-05-16', 2022, '1250434', '2022-02-01', '2022-03-31', NULL, NULL, '2022-02-23', '2022-03-31', -203.16, 12.5, 0.36, 317.96);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (52, 2, 2022, '2022-07-12', 2022, '1260558', '2022-04-01', '2022-05-31', NULL, NULL, '2022-04-23', '2022-05-31', -118.37, 7.92, 0.36, 201.42000000000002);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (53, 2, 2022, '2022-09-14', 2022, '1279157', '2022-06-01', '2022-07-31', NULL, NULL, '2022-06-01', '2022-07-31', NULL, 1.74, 0.36, 44.1);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (54, 2, 2022, '2022-11-14', 2022, '1297658', '2022-08-01', '2022-09-30', NULL, NULL, '2022-08-01', '2022-09-30', NULL, 2.41, 0.36, 61.21);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (55, 2, 2023, '2023-01-13', 2023, '4659', '2022-10-01', '2022-11-30', '2022-04-23', '2022-11-14', NULL, NULL, NULL, 1.95, 0.36, 49.62);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (56, 2, 2023, '2023-05-16', 2023, '2012924', '2022-12-01', '2023-01-31', '2022-11-15', '2023-01-31', NULL, NULL, NULL, 15.33, 0.36, 389.86);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (57, 2, 2023, '2023-07-14', 2023, '2031279', '2023-02-01', '2023-03-31', NULL, NULL, NULL, NULL, NULL, 12.67, 0.36, 322.06);
INSERT INTO GASFattura (idGASFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodEffDtIniz, periodEffDtFine, periodAccontoDtIniz, periodAccontoDtFine, accontoBollPrec, addizFER, impostaQuiet, TotPagare) VALUES (58, 2, 2023, '2023-09-18', 2023, '2041500', '2023-04-01', '2023-06-30', '2023-02-01', '2023-05-04', NULL, NULL, NULL, 3.93, 0.36, 99.74);

-- Tabella: GASLettura
DROP TABLE IF EXISTS GASLettura;

CREATE TABLE IF NOT EXISTS GASLettura (
    idLettura    INTEGER      PRIMARY KEY,
    idGASFattura INT          NOT NULL,
    lettQtaMc    INT,
    LettData     DATE,
    TipoLett     VARCHAR (16),
    Consumofatt  FLOAT
);

INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (1, 1, 6629, '2019-05-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (2, 1, NULL, NULL, 'stim', 222.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (3, 1, NULL, NULL, 'tot', 222.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (4, 2, 6629, '2019-05-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (5, 2, 6936, '2019-12-18', 'eff', 307.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (6, 2, NULL, NULL, 'stim', 334.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (7, 2, NULL, NULL, 'tot', 641.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (8, 3, 6936, '2019-12-18', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (9, 3, 7383, '2020-02-24', 'eff', 447.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (10, 3, NULL, NULL, 'stim', 191.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (11, 3, NULL, NULL, 'tot', 638.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (12, 4, 7383, '2020-02-24', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (13, 4, 7642, '2020-05-21', 'eff', 259.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (14, 4, NULL, NULL, 'stim', 13.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (15, 4, NULL, NULL, 'tot', 272.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (16, 5, 7642, '2020-05-21', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (17, 5, NULL, NULL, 'stim', 52.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (18, 5, NULL, NULL, 'tot', 52.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (19, 6, 7642, '2020-05-21', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (20, 6, NULL, NULL, 'stim', 65.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (21, 6, NULL, NULL, 'tot', 65.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (22, 7, 7642, '2020-05-21', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (23, 7, NULL, NULL, 'stim', 222.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (24, 7, NULL, NULL, 'tot', 222.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (25, 8, 7642, '2020-05-21', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (26, 8, 8017, '2020-12-21', 'eff', 375.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (27, 8, NULL, NULL, 'stim', 311.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (28, 8, NULL, NULL, 'tot', 686.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (29, 9, 8017, '2020-12-21', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (30, 9, 8497, '2021-02-19', 'eff', 480.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (31, 9, NULL, NULL, 'stim', 220.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (32, 9, NULL, NULL, 'tot', 700.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (33, 10, 8497, '2021-02-19', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (34, 10, 8712, '2021-04-08', 'eff', 215.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (35, 10, NULL, NULL, 'stim', 116.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (36, 10, NULL, NULL, 'tot', 331.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (37, 11, 8712, '2021-04-08', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (38, 11, NULL, NULL, 'stim', 52.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (39, 11, NULL, NULL, 'tot', 52.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (40, 12, 8712, '2021-04-08', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (41, 12, NULL, NULL, 'stim', 65.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (42, 12, NULL, NULL, 'tot', 65.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (43, 13, 8712, '2021-04-08', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (44, 13, NULL, NULL, 'stim', 222.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (45, 13, NULL, NULL, 'tot', 222.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (46, 14, 8712, '2021-04-08', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (47, 14, 9157, '2021-12-17', 'eff', 445.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (48, 14, NULL, NULL, 'stim', 342.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (49, 14, NULL, NULL, 'tot', 787.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (50, 15, 9157, '2021-12-17', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (51, 15, 9626, '2022-02-16', 'eff', 469.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (52, 15, NULL, NULL, 'stim', 241.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (53, 15, NULL, NULL, 'tot', 710.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (54, 16, 9626, '2022-02-16', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (55, 16, 9905, '2022-04-28', 'eff', 279.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (56, 16, NULL, NULL, 'stim', 46.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (57, 16, NULL, NULL, 'tot', 325.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (58, 17, 9905, '2022-04-28', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (59, 17, NULL, NULL, 'stim', 46.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (60, 17, NULL, NULL, 'tot', 46.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (61, 18, 9905, '2022-04-28', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (62, 18, NULL, NULL, 'stim', 58.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (63, 18, NULL, NULL, 'tot', 58.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (64, 19, 9905, '2022-04-28', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (65, 19, 9998, '2022-11-23', 'eff', 93.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (66, 19, NULL, NULL, 'stim', 33.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (67, 19, NULL, NULL, 'tot', 126.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (68, 20, 9998, '2022-11-23', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (69, 20, 10321, '2023-01-26', 'eff', 323.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (70, 20, NULL, NULL, 'stim', 24.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (71, 20, NULL, NULL, 'tot', 347.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (72, 21, 10321, '2023-01-26', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (73, 21, 10551, '2023-03-23', 'auto', 230.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (74, 21, NULL, NULL, 'stim', 29.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (75, 21, NULL, NULL, 'tot', 259.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (76, 22, 10551, '2023-03-23', 'auto', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (77, 22, 10610, '2023-05-03', 'eff', 59.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (78, 22, NULL, NULL, 'stim', 44.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (79, 22, NULL, NULL, 'tot', 103.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (80, 23, 81240, '2019-05-17', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (81, 23, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (82, 23, NULL, NULL, 'tot', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (83, 24, 81240, '2019-05-17', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (84, 24, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (85, 24, NULL, NULL, 'tot', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (86, 25, 81240, '2019-05-17', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (87, 25, 81572, '2019-12-13', 'eff', 332.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (88, 25, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (89, 25, NULL, NULL, 'tot', 332.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (90, 26, 81572, '2019-12-13', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (91, 26, 81896, '2020-02-18', 'eff', 324.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (92, 26, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (93, 26, NULL, NULL, 'tot', 324.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (94, 27, 82137, '2020-05-20', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (95, 27, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (96, 27, NULL, NULL, 'tot', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (97, 28, 82137, '2020-05-20', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (98, 28, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (99, 28, NULL, NULL, 'tot', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (100, 29, 82137, '2020-05-20', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (101, 29, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (102, 29, NULL, NULL, 'tot', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (103, 30, 82137, '2020-05-20', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (104, 30, 82362, '2020-12-15', 'eff', 225.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (105, 30, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (106, 30, NULL, NULL, 'tot', 225.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (107, 31, 82362, '2020-12-15', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (108, 31, 82764, '2021-02-22', 'eff', 402.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (109, 31, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (110, 31, NULL, NULL, 'tot', 402.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (111, 32, 82764, '2021-02-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (112, 32, 82934, '2021-04-14', 'eff', 170.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (113, 32, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (114, 32, NULL, NULL, 'tot', 170.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (115, 33, 82934, '2021-04-14', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (116, 33, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (117, 33, NULL, NULL, 'tot', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (118, 34, 82934, '2021-04-14', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (119, 34, 83241, '2021-12-13', 'eff', 307.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (120, 34, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (121, 34, NULL, NULL, 'tot', 307.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (122, 35, 83241, '2021-12-13', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (123, 35, 83635, '2022-02-22', 'eff', 394.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (124, 35, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (125, 35, NULL, NULL, 'tot', 394.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (126, 36, 83635, '2022-02-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (127, 36, 83843, '2022-04-22', 'eff', 208.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (128, 36, NULL, NULL, 'stim', 0.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (129, 36, NULL, NULL, 'tot', 208.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (130, 37, 83843, '2022-04-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (131, 37, NULL, NULL, 'stim', 36.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (132, 37, NULL, NULL, 'tot', 36.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (133, 38, 83843, '2022-04-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (134, 38, NULL, NULL, 'stim', 45.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (135, 38, NULL, NULL, 'tot', 45.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (136, 39, 83843, '2022-04-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (137, 39, NULL, NULL, 'stim', 150.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (138, 39, NULL, NULL, 'tot', 150.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (139, 40, 83843, '2022-04-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (140, 40, 83963, '2022-12-02', 'eff', 120.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (141, 40, NULL, NULL, 'stim', 308.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (142, 40, NULL, NULL, 'tot', 428.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (143, 41, 84236, '2023-01-31', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (144, 41, NULL, NULL, 'stim', 203.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (145, 41, NULL, NULL, 'tot', 203.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (146, 42, 84236, '2023-01-31', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (147, 42, 84457, '2023-05-04', 'eff', 221.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (148, 42, 84470, '2023-06-30', 'eff', 13.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (149, 42, NULL, NULL, 'tot', 234.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (150, 43, 39819, '2020-05-20', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (151, 43, NULL, NULL, 'stim', 213.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (152, 43, NULL, NULL, 'tot', 213.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (153, 44, 39819, '2020-05-20', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (154, 44, 40212, '2020-12-15', 'eff', 393.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (155, 44, NULL, NULL, 'stim', 340.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (156, 44, NULL, NULL, 'tot', 733.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (157, 45, 40212, '2020-12-15', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (158, 45, 40781, '2021-02-22', 'eff', 569.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (159, 45, NULL, NULL, 'stim', 190.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (160, 45, NULL, NULL, 'tot', 759.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (161, 46, 40781, '2021-02-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (162, 46, 41047, '2021-04-14', 'eff', 266.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (163, 46, NULL, NULL, 'stim', 91.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (164, 46, NULL, NULL, 'tot', 357.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (165, 47, 41047, '2021-04-14', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (166, 47, NULL, NULL, 'stim', 50.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (167, 47, NULL, NULL, 'tot', 50.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (168, 48, 41047, '2021-04-14', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (169, 48, NULL, NULL, 'stim', 63.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (170, 48, NULL, NULL, 'tot', 63.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (171, 49, 41047, '2021-04-14', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (172, 49, NULL, NULL, 'stim', 213.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (173, 49, NULL, NULL, 'tot', 213.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (174, 50, 41047, '2021-04-14', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (175, 50, 41618, '2021-12-13', 'eff', 571.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (176, 50, NULL, NULL, 'stim', 354.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (177, 50, NULL, NULL, 'tot', 925.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (178, 51, 41618, '2021-12-13', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (179, 51, 42274, '2022-02-22', 'eff', 656.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (180, 51, NULL, NULL, 'stim', 190.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (181, 51, NULL, NULL, 'tot', 846.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (182, 52, 42274, '2022-02-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (183, 52, 42705, '2022-04-22', 'eff', 431.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (184, 52, NULL, NULL, 'stim', 65.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (185, 52, NULL, NULL, 'tot', 496.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (186, 53, 42705, '2022-04-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (187, 53, NULL, NULL, 'stim', 58.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (188, 53, NULL, NULL, 'tot', 58.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (189, 54, 42705, '2022-04-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (190, 54, NULL, NULL, 'stim', 72.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (191, 54, NULL, NULL, 'tot', 72.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (192, 55, 42705, '2022-04-22', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (193, 55, 42854, '2022-11-14', 'eff', 149.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (194, 55, NULL, NULL, 'stim', 92.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (195, 55, NULL, NULL, 'tot', 241.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (196, 56, 42854, '2022-11-14', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (197, 56, 43403, '2023-01-31', 'eff', 549.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (198, 56, NULL, NULL, 'tot', 549.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (199, 57, 43403, '2023-01-31', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (200, 57, NULL, NULL, 'stim', 378.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (201, 57, NULL, NULL, 'tot', 378.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (202, 58, 43403, '2023-01-31', 'eff', NULL);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (203, 58, 43885, '2023-05-04', 'eff', 482.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (204, 58, 43899, '2023-05-15', 'auto', 14.0);
INSERT INTO GASLettura (idLettura, idGASFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (205, 58, NULL, NULL, 'tot', 527.0);

-- Tabella: H2OConsumo
DROP TABLE IF EXISTS H2OConsumo;

CREATE TABLE IF NOT EXISTS H2OConsumo (
    idConsumo    INTEGER         PRIMARY KEY,
    idH2OFattura INT             NOT NULL,
    tipoSpesa    VARCHAR (4),
    dtIniz       DATE,
    dtFine       DATE,
    prezzoUnit   DECIMAL (10, 6),
    quantita     DECIMAL (8, 2),
    importo      MONEY
);

INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (1, 1, 'S1', '2019-11-01', '2019-12-31', 0.478419, 12, 5.74);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (2, 1, 'S2', '2019-11-01', '2019-12-31', 0.972158, 12, 11.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (3, 1, 'S3', '2019-11-01', '2019-12-31', 1.494522, 8, 11.96);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (4, 1, 'S1', '2019-11-01', '2019-12-31', 0.627365, 12, 7.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (5, 1, 'S2', '2019-11-01', '2019-12-31', 0.627365, 12, 7.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (6, 1, 'S3', '2019-11-01', '2019-12-31', 0.627365, 8, 5.02);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (7, 1, 'F', '2019-11-01', '2019-12-31', 0.008548, 61, 0.52);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (8, 1, 'S1', '2020-01-01', '2020-02-29', 0.478419, 12, 5.74);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (9, 1, 'S2', '2020-01-01', '2020-02-29', 0.972158, 12, 11.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (10, 1, 'S3', '2020-01-01', '2020-02-29', 1.494522, 7, 10.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (11, 1, 'S1', '2020-01-01', '2020-02-29', 0.627365, 12, 7.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (12, 1, 'S2', '2020-01-01', '2020-02-29', 0.627365, 12, 7.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (13, 1, 'S3', '2020-01-01', '2020-02-29', 0.627365, 7, 4.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (14, 1, 'F', '2020-01-01', '2020-02-29', 0.008525, 60, 0.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (15, 2, 'S1', '2019-10-05', '2019-12-31', 0.478419, 17, 8.13);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (16, 2, 'S2', '2019-10-05', '2019-12-31', 0.972158, 5, 4.86);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (17, 2, 'S1', '2019-10-05', '2019-12-31', 0.627365, 17, 10.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (18, 2, 'S2', '2019-10-05', '2019-12-31', 0.627365, 5, 3.14);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (19, 2, 'S1', '2020-01-01', '2020-05-28', 0.478419, 29, 13.87);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (20, 2, 'S2', '2020-01-01', '2020-05-28', 0.972158, 8, 7.78);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (21, 2, 'S1', '2020-01-01', '2020-05-28', 0.627365, 29, 18.19);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (22, 2, 'S2', '2020-01-01', '2020-05-28', 0.627365, 8, 5.02);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (23, 2, 'F', '2020-03-01', '2020-06-30', 0.008525, 122, 1.04);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (24, 2, 'S1', '2020-05-29', '2020-06-30', 0.478419, 6, 2.87);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (25, 2, 'S2', '2020-05-29', '2020-06-30', 0.972158, 6, 5.83);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (26, 2, 'S3', '2020-05-29', '2020-06-30', 1.494522, 6, 8.97);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (27, 2, 'S1', '2020-05-29', '2020-06-30', 0.627365, 6, 3.76);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (28, 2, 'S2', '2020-05-29', '2020-06-30', 0.627365, 6, 3.76);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (29, 2, 'S3', '2020-05-29', '2020-06-30', 0.627365, 6, 3.76);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (30, 3, 'S1', '2020-05-29', '2020-08-25', 0.478419, 18, 8.61);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (31, 3, 'S2', '2020-05-29', '2020-08-25', 0.972158, 18, 17.5);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (32, 3, 'S3', '2020-05-29', '2020-08-25', 1.494522, 18, 26.9);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (33, 3, 'S4', '2020-05-29', '2020-08-25', 2.171288, 3, 6.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (34, 3, 'S1', '2020-05-29', '2020-08-25', 0.627365, 18, 11.29);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (35, 3, 'S2', '2020-05-29', '2020-08-25', 0.627365, 18, 11.29);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (36, 3, 'S3', '2020-05-29', '2020-08-25', 0.627365, 18, 11.29);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (37, 3, 'S4', '2020-05-29', '2020-08-25', 0.627365, 3, 1.88);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (38, 3, 'F', '2020-07-01', '2020-10-31', 0.008525, 123, 1.05);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (39, 3, 'S1', '2020-08-26', '2020-10-31', 0.478419, 13, 6.22);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (40, 3, 'S2', '2020-08-26', '2020-10-31', 0.972158, 4, 3.89);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (41, 3, 'S1', '2020-08-26', '2020-10-31', 0.627365, 13, 8.16);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (42, 3, 'S2', '2020-08-26', '2020-10-31', 0.627365, 4, 2.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (43, 4, 'S1', '2020-08-26', '2020-12-10', 0.478419, 21, 10.05);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (44, 4, 'S2', '2020-08-26', '2020-12-10', 0.972158, 14, 13.61);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (45, 4, 'S1', '2020-08-26', '2020-12-10', 0.627365, 21, 13.17);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (46, 4, 'S2', '2020-08-26', '2020-12-10', 0.627365, 14, 8.78);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (47, 4, 'F', '2020-11-01', '2020-12-31', 0.008525, 61, 0.52);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (48, 4, 'S1', '2020-12-11', '2020-12-31', 0.478419, 4, 1.91);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (49, 4, 'S2', '2020-12-11', '2020-12-31', 0.972158, 4, 3.89);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (50, 4, 'S3', '2020-12-11', '2020-12-31', 1.494522, 4, 5.98);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (51, 4, 'S4', '2020-12-11', '2020-12-31', 2.171288, 2, 4.34);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (52, 4, 'S1', '2020-12-11', '2020-12-31', 0.627365, 4, 2.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (53, 4, 'S2', '2020-12-11', '2020-12-31', 0.627365, 4, 2.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (54, 4, 'S3', '2020-12-11', '2020-12-31', 0.627365, 4, 2.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (55, 4, 'S4', '2020-12-11', '2020-12-31', 0.627365, 2, 1.25);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (56, 4, 'S1', '2021-01-01', '2021-02-28', 0.478419, 12, 5.74);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (57, 4, 'S2', '2021-01-01', '2021-02-28', 0.972158, 12, 11.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (58, 4, 'S3', '2021-01-01', '2021-02-28', 1.494522, 12, 17.93);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (59, 4, 'S4', '2021-01-01', '2021-02-28', 2.171288, 2, 4.34);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (60, 4, 'S1', '2021-01-01', '2021-02-28', 0.627365, 12, 7.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (61, 4, 'S2', '2021-01-01', '2021-02-28', 0.627365, 12, 7.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (62, 4, 'S3', '2021-01-01', '2021-02-28', 0.627365, 12, 7.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (63, 4, 'S4', '2021-01-01', '2021-02-28', 0.627365, 2, 1.25);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (64, 4, 'F', '2021-01-01', '2021-02-28', 0.008548, 59, 0.5);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (65, 5, 'S1', '2020-12-11', '2020-12-31', 0.478419, 4, 1.91);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (66, 5, 'S2', '2020-12-11', '2020-12-31', 0.972158, 4, 3.89);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (67, 5, 'S3', '2020-12-11', '2020-12-31', 1.494522, 1, 1.49);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (68, 5, 'S1', '2020-12-11', '2020-12-31', 0.627365, 4, 2.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (69, 5, 'S2', '2020-12-11', '2020-12-31', 0.627365, 4, 2.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (70, 5, 'S3', '2020-12-11', '2020-12-31', 0.627365, 1, 0.63);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (71, 5, 'S1', '2021-01-01', '2021-06-22', 0.478419, 34, 16.27);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (72, 5, 'S2', '2021-01-01', '2021-06-22', 0.972158, 34, 33.05);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (73, 5, 'S3', '2021-01-01', '2021-06-22', 1.494522, 3, 4.48);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (74, 5, 'S1', '2021-01-01', '2021-06-22', 0.627365, 34, 21.33);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (75, 5, 'S2', '2021-01-01', '2021-06-22', 0.627365, 34, 21.33);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (76, 5, 'S3', '2021-01-01', '2021-06-22', 0.627365, 3, 1.88);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (77, 5, 'F', '2021-03-01', '2021-06-30', 0.008548, 122, 1.04);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (78, 5, 'S1', '2021-06-23', '2021-06-30', 0.478419, 2, 0.96);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (79, 5, 'S2', '2021-06-23', '2021-06-30', 0.972158, 1, 0.97);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (80, 5, 'S1', '2021-06-23', '2021-06-30', 0.627365, 2, 1.25);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (81, 5, 'S2', '2021-06-23', '2021-06-30', 0.627365, 1, 0.63);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (82, 6, 'S1', '2021-06-23', '2021-09-10', 0.478419, 16, 7.65);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (83, 6, 'S2', '2021-06-23', '2021-09-10', 0.972158, 16, 15.55);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (84, 6, 'S1', '2021-06-23', '2021-09-10', 0.627365, 16, 10.04);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (85, 6, 'S2', '2021-06-23', '2021-09-10', 0.627365, 16, 10.04);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (86, 6, 'F', '2021-07-01', '2021-10-31', 0.008548, 123, 1.05);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (87, 6, 'S1', '2021-09-11', '2021-10-31', 0.478419, 10, 4.78);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (88, 6, 'S2', '2021-09-11', '2021-10-31', 0.972158, 10, 9.72);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (89, 6, 'S3', '2021-09-11', '2021-10-31', 1.494522, 1, 1.49);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (90, 6, 'S1', '2021-09-11', '2021-10-31', 0.627365, 10, 6.27);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (91, 6, 'S2', '2021-09-11', '2021-10-31', 0.627365, 10, 6.27);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (92, 6, 'S3', '2021-09-11', '2021-10-31', 0.627365, 1, 0.63);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (93, 7, 'S1', '2021-09-11', '2021-12-31', 0.478419, 22, 10.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (94, 7, 'S2', '2021-09-11', '2021-12-31', 0.972158, 13, 12.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (95, 7, 'S1', '2021-09-11', '2021-12-31', 0.627365, 22, 13.8);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (96, 7, 'S2', '2021-09-11', '2021-12-31', 0.627365, 13, 8.16);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (97, 7, 'S1', '2022-01-01', '2022-03-28', 0.478419, 17, 8.13);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (98, 7, 'S2', '2022-01-01', '2022-03-28', 0.972158, 11, 10.69);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (99, 7, 'S1', '2022-01-01', '2022-03-28', 0.627365, 17, 10.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (100, 7, 'S2', '2022-01-01', '2022-03-28', 0.627365, 11, 6.9);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (101, 7, 'F', '2022-03-01', '2022-03-31', 0.008548, 31, 0.26);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (102, 7, 'S1', '2022-03-29', '2022-03-31', 0.478419, 1, 0.48);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (103, 7, 'S1', '2022-03-29', '2022-03-31', 0.627365, 1, 0.63);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (104, 7, 'S1', '2022-04-01', '2022-07-11', 0.526261, 20, 10.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (105, 7, 'S2', '2022-04-01', '2022-07-11', 1.069374, 20, 21.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (106, 7, 'S3', '2022-04-01', '2022-07-11', 1.643974, 11, 18.08);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (107, 7, 'S1', '2022-04-01', '2022-07-11', 0.909679, 20, 18.19);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (108, 7, 'S2', '2022-04-01', '2022-07-11', 0.909679, 20, 18.19);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (109, 7, 'S3', '2022-04-01', '2022-07-11', 0.909679, 11, 10.01);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (110, 7, 'F', '2022-04-01', '2022-07-31', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (111, 7, 'S1', '2022-07-12', '2022-07-31', 0.526261, 4, 2.11);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (112, 7, 'S2', '2022-07-12', '2022-07-31', 1.069374, 4, 4.28);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (113, 7, 'S1', '2022-07-12', '2022-07-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (114, 7, 'S2', '2022-07-12', '2022-07-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (115, 8, 'S1', '2022-07-12', '2022-10-10', 0.526261, 18, 9.47);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (116, 8, 'S2', '2022-07-12', '2022-10-10', 1.069374, 10, 10.69);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (117, 8, 'S1', '2022-07-12', '2022-10-10', 0.909679, 18, 16.37);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (118, 8, 'S2', '2022-07-12', '2022-10-10', 0.909679, 10, 9.1);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (119, 8, 'F', '2022-08-01', '2022-11-30', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (120, 8, 'S2', '2022-10-11', '2022-11-30', 0.909679, 9, 8.19);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (121, 9, 'F', '2022-12-01', '2022-12-31', 0.011096, 31, 0.34);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (122, 9, 'F', '2023-01-01', '2023-03-31', 0.011096, 90, 1);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (123, 9, 'S2', '2023-01-01', '2023-03-31', 0.909679, 9, 8.19);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (124, 10, 'F', '2023-04-01', '2023-07-31', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (125, 10, 'S2', '2023-07-01', '2023-07-31', 0.909679, 3, 2.73);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (126, 11, 'S1', '2019-06-11', '2019-09-24', 0.478419, 11, 5.26);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (127, 11, 'S1', '2019-06-11', '2019-09-24', 0.627365, 11, 6.9);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (128, 11, 'F', '2019-07-01', '2019-10-31', 0.008548, 123, 1.05);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (129, 11, 'S1', '2019-09-25', '2019-10-31', 0.478419, 1, 0.48);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (130, 11, 'S1', '2019-09-25', '2019-10-31', 0.627365, 1, 0.63);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (131, 12, 'S1', '2019-11-01', '2019-12-31', 0.478419, 6, 2.87);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (132, 12, 'S1', '2019-11-01', '2019-12-31', 0.627365, 6, 3.76);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (133, 12, 'F', '2019-11-01', '2019-12-31', 0.008548, 61, 0.52);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (134, 12, 'S1', '2020-01-01', '2020-02-29', 0.478419, 6, 2.87);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (135, 12, 'S1', '2020-01-01', '2020-02-29', 0.627365, 6, 3.76);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (136, 12, 'F', '2020-01-01', '2020-02-29', 0.008525, 60, 0.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (137, 13, 'S1', '2019-09-25', '2019-12-31', 0.478419, 19, 9.09);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (138, 13, 'S2', '2019-09-25', '2019-12-31', 0.972158, 9, 8.75);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (139, 13, 'S1', '2019-09-25', '2019-12-31', 0.627365, 19, 11.92);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (140, 13, 'S2', '2019-09-25', '2019-12-31', 0.627365, 9, 5.65);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (141, 13, 'S1', '2020-01-01', '2020-05-22', 0.478419, 28, 13.4);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (142, 13, 'S2', '2020-01-01', '2020-05-22', 0.972158, 14, 13.61);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (143, 13, 'S1', '2020-01-01', '2020-05-22', 0.627365, 28, 17.57);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (144, 13, 'S2', '2020-01-01', '2020-05-22', 0.627365, 14, 8.78);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (145, 13, 'F', '2020-03-01', '2020-06-30', 0.008525, 122, 1.04);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (146, 13, 'S1', '2020-05-23', '2020-06-30', 0.478419, 4, 1.91);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (147, 13, 'S1', '2020-05-23', '2020-06-30', 0.627365, 4, 2.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (148, 14, 'S1', '2020-05-23', '2020-08-18', 0.478419, 5, 2.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (149, 14, 'S1', '2020-05-23', '2020-08-18', 0.627365, 5, 3.14);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (150, 14, 'F', '2020-07-01', '2020-10-31', 0.008525, 123, 1.05);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (151, 14, 'S1', '2020-08-19', '2020-10-31', 0.478419, 15, 7.18);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (152, 14, 'S2', '2020-08-19', '2020-10-31', 0.972158, 7, 6.81);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (153, 14, 'S1', '2020-08-19', '2020-10-31', 0.627365, 15, 9.41);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (154, 14, 'S2', '2020-08-19', '2020-10-31', 0.627365, 7, 4.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (155, 15, 'S1', '2020-11-27', '2020-12-31', 0.478419, 7, 3.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (156, 15, 'S2', '2020-11-27', '2020-12-31', 0.972158, 7, 6.81);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (157, 15, 'S3', '2020-11-27', '2020-12-31', 1.494522, 2, 2.99);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (158, 15, 'S1', '2020-11-27', '2020-12-31', 0.627365, 7, 4.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (159, 15, 'S2', '2020-11-27', '2020-12-31', 0.627365, 7, 4.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (160, 15, 'S3', '2020-11-27', '2020-12-31', 0.627365, 2, 1.25);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (161, 15, 'S1', '2021-01-01', '2021-06-11', 0.478419, 32, 15.31);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (162, 15, 'S2', '2021-01-01', '2021-06-11', 0.972158, 32, 31.11);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (163, 15, 'S3', '2021-01-01', '2021-06-11', 1.494522, 9, 13.45);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (164, 15, 'S1', '2021-01-01', '2021-06-11', 0.627365, 32, 20.08);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (165, 15, 'S2', '2021-01-01', '2021-06-11', 0.627365, 32, 20.08);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (166, 15, 'S3', '2021-01-01', '2021-06-11', 0.627365, 9, 5.65);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (167, 15, 'F', '2021-03-01', '2021-06-30', 0.008548, 122, 1.04);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (168, 16, 'S1', '2021-06-12', '2021-09-10', 0.478419, 7, 3.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (169, 16, 'S1', '2021-06-12', '2021-09-10', 0.627365, 7, 4.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (170, 16, 'F', '2021-07-01', '2021-10-31', 0.008548, 123, 1.05);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (171, 16, 'S1', '2021-09-11', '2021-10-31', 0.478419, 10, 4.78);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (172, 16, 'S2', '2021-09-11', '2021-10-31', 0.972158, 10, 9.72);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (173, 16, 'S3', '2021-09-11', '2021-10-31', 1.494522, 3, 4.48);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (174, 16, 'S1', '2021-09-11', '2021-10-31', 0.627365, 10, 6.27);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (175, 16, 'S2', '2021-09-11', '2021-10-31', 0.627365, 10, 6.27);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (176, 16, 'S3', '2021-09-11', '2021-10-31', 0.627365, 3, 1.88);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (177, 17, 'S1', '2021-09-11', '2021-12-22', 0.478419, 20, 9.57);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (178, 17, 'S2', '2021-09-11', '2021-12-22', 0.972158, 9, 8.75);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (179, 17, 'S1', '2021-09-11', '2021-12-22', 0.627365, 20, 12.55);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (180, 17, 'S2', '2021-09-11', '2021-12-22', 0.627365, 9, 5.65);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (181, 17, 'F', '2021-11-01', '2021-12-31', 0.008548, 61, 0.52);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (182, 17, 'S1', '2021-12-23', '2021-12-31', 0.478419, 1, 0.48);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (183, 17, 'S1', '2021-12-23', '2021-12-31', 0.627365, 1, 0.63);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (184, 17, 'S1', '2022-01-01', '2022-02-28', 0.478419, 4, 1.91);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (185, 17, 'S1', '2022-01-01', '2022-02-28', 0.627365, 4, 2.51);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (186, 17, 'F', '2022-01-01', '2022-02-28', 0.008548, 59, 0.5);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (187, 18, 'S1', '2021-12-23', '2021-12-31', 0.478419, 2, 0.96);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (188, 18, 'S2', '2021-12-23', '2021-12-31', 0.972158, 2, 1.94);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (189, 18, 'S1', '2021-12-23', '2021-12-31', 0.627365, 2, 1.25);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (190, 18, 'S2', '2021-12-23', '2021-12-31', 0.627365, 2, 1.25);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (191, 18, 'S1', '2022-01-01', '2022-03-31', 0.478419, 18, 8.61);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (192, 18, 'S2', '2022-01-01', '2022-03-31', 0.972158, 18, 17.5);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (193, 18, 'S3', '2022-01-01', '2022-03-31', 1.494522, 3, 4.48);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (194, 18, 'S1', '2022-01-01', '2022-03-31', 0.627365, 18, 11.29);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (195, 18, 'S2', '2022-01-01', '2022-03-31', 0.627365, 18, 11.29);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (196, 18, 'S3', '2022-01-01', '2022-03-31', 0.627365, 3, 1.88);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (197, 18, 'F', '2022-03-01', '2022-03-31', 0.008548, 31, 0.26);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (198, 18, 'S1', '2022-04-01', '2022-07-05', 0.526261, 19, 10);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (199, 18, 'S2', '2022-04-01', '2022-07-05', 1.069374, 19, 20.32);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (200, 18, 'S3', '2022-04-01', '2022-07-05', 1.643974, 3, 4.93);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (201, 18, 'S1', '2022-04-01', '2022-07-05', 0.909679, 19, 17.28);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (202, 18, 'S2', '2022-04-01', '2022-07-05', 0.909679, 19, 17.28);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (203, 18, 'S3', '2022-04-01', '2022-07-05', 0.909679, 3, 2.73);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (204, 18, 'F', '2022-04-01', '2022-07-31', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (205, 18, 'S1', '2022-07-06', '2022-07-31', 0.526261, 5, 2.63);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (206, 18, 'S2', '2022-07-06', '2022-07-31', 1.069374, 3, 3.21);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (207, 18, 'S1', '2022-07-06', '2022-07-31', 0.909679, 5, 4.55);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (208, 18, 'S2', '2022-07-06', '2022-07-31', 0.909679, 3, 2.73);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (209, 19, 'S1', '2022-07-06', '2022-10-05', 0.526261, 1, 0.53);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (210, 19, 'S1', '2022-07-06', '2022-10-05', 0.909679, 1, 0.91);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (211, 19, 'F', '2022-08-01', '2022-11-30', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (212, 19, 'S3', '2022-10-06', '2022-11-30', 0.909679, 2, 1.82);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (213, 20, 'F', '2022-12-01', '2022-12-31', 0.011096, 31, 0.34);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (214, 20, 'F', '2023-01-01', '2023-03-31', 0.011096, 90, 1);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (215, 21, 'S1', '2022-10-06', '2022-10-31', 0.526261, 5, 2.63);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (216, 21, 'S2', '2022-10-06', '2022-10-31', 1.069374, 3, 3.21);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (217, 21, 'S1', '2022-10-06', '2022-10-31', 0.909679, 5, 4.55);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (218, 21, 'S2', '2022-10-06', '2022-10-31', 0.909679, 3, 2.73);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (219, 21, 'S1', '2022-11-01', '2022-11-30', 0.526261, 6, 3.16);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (220, 21, 'S2', '2022-11-01', '2022-11-30', 1.069374, 4, 4.28);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (221, 21, 'S1', '2022-11-01', '2022-11-30', 0.909679, 6, 5.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (222, 21, 'S2', '2022-11-01', '2022-11-30', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (223, 21, 'S1', '2022-12-01', '2022-12-31', 0.526261, 6, 3.16);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (224, 21, 'S2', '2022-12-01', '2022-12-31', 1.069374, 4, 4.28);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (225, 21, 'S1', '2022-12-01', '2022-12-31', 0.909679, 6, 5.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (226, 21, 'S2', '2022-12-01', '2022-12-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (227, 21, 'S1', '2023-01-01', '2023-01-31', 0.574103, 6, 3.44);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (228, 21, 'S2', '2023-01-01', '2023-01-31', 1.16659, 4, 4.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (229, 21, 'S1', '2023-01-01', '2023-01-31', 0.909679, 6, 5.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (230, 21, 'S2', '2023-01-01', '2023-01-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (231, 21, 'S1', '2023-02-01', '2023-02-28', 0.574103, 6, 3.44);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (232, 21, 'S2', '2023-02-01', '2023-02-28', 1.16659, 3, 3.5);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (233, 21, 'S1', '2023-02-01', '2023-02-28', 0.909679, 6, 5.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (234, 21, 'S2', '2023-02-01', '2023-02-28', 0.909679, 3, 2.73);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (235, 21, 'S1', '2023-03-01', '2023-03-31', 0.574103, 6, 3.44);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (236, 21, 'S2', '2023-03-01', '2023-03-31', 1.16659, 4, 4.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (237, 21, 'S1', '2023-03-01', '2023-03-31', 0.909679, 6, 5.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (238, 21, 'S2', '2023-03-01', '2023-03-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (239, 21, 'S1', '2023-04-01', '2023-04-30', 0.574103, 6, 3.44);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (240, 21, 'S2', '2023-04-01', '2023-04-30', 1.16659, 4, 4.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (241, 21, 'S1', '2023-04-01', '2023-04-30', 0.909679, 6, 5.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (242, 21, 'S2', '2023-04-01', '2023-04-30', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (243, 21, 'F', '2023-04-01', '2023-07-31', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (244, 21, 'S1', '2023-05-01', '2023-05-31', 0.574103, 6, 3.44);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (245, 21, 'S2', '2023-05-01', '2023-05-31', 1.16659, 4, 4.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (246, 21, 'S1', '2023-05-01', '2023-05-31', 0.909679, 6, 5.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (247, 21, 'S2', '2023-05-01', '2023-05-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (248, 21, 'S1', '2023-06-01', '2023-06-30', 0.574103, 6, 3.44);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (249, 21, 'S2', '2023-06-01', '2023-06-30', 1.16659, 4, 4.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (250, 21, 'S1', '2023-06-01', '2023-06-30', 0.909679, 6, 5.46);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (251, 21, 'S2', '2023-06-01', '2023-06-30', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (252, 21, 'S1', '2023-07-01', '2023-07-10', 0.574103, 2, 1.15);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (253, 21, 'S2', '2023-07-01', '2023-07-10', 1.16659, 1, 1.17);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (254, 21, 'S1', '2023-07-01', '2023-07-10', 0.909679, 2, 1.82);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (255, 21, 'S2', '2023-07-01', '2023-07-10', 0.909679, 1, 0.91);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (256, 22, 'S1', '2020-08-19', '2020-11-30', 0.478419, 15, 7.18);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (257, 22, 'S1', '2020-08-19', '2020-11-30', 0.627365, 15, 9.41);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (258, 22, 'F', '2020-11-01', '2020-12-31', 0.008525, 61, 0.52);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (259, 22, 'S1', '2020-12-01', '2020-12-31', 0.478419, 5, 2.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (260, 22, 'S1', '2020-12-01', '2020-12-31', 0.627365, 5, 3.14);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (261, 22, 'S1', '2021-01-01', '2021-02-28', 0.478419, 9, 4.31);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (262, 22, 'S1', '2021-01-01', '2021-02-28', 0.627365, 9, 5.65);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (263, 22, 'F', '2021-01-01', '2021-02-28', 0.008548, 59, 0.5);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (264, 23, 'S1', '2020-12-01', '2020-12-31', 0.478419, 5, 2.39);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (265, 23, 'S1', '2020-12-01', '2020-12-31', 0.627365, 5, 3.14);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (266, 23, 'S1', '2021-01-01', '2021-04-16', 0.478419, 18, 8.61);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (267, 23, 'S1', '2021-01-01', '2021-04-16', 0.627365, 18, 11.29);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (268, 23, 'F', '2021-03-01', '2021-06-30', 0.008548, 122, 1.04);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (269, 23, 'S1', '2021-04-17', '2021-06-11', 0.478419, 10, 4.78);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (270, 23, 'S1', '2021-04-17', '2021-06-11', 0.627365, 10, 6.27);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (271, 23, 'S1', '2021-06-12', '2021-06-30', 0.478419, 3, 1.44);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (272, 23, 'S1', '2021-06-12', '2021-06-30', 0.627365, 3, 1.88);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (273, 24, 'S1', '2021-06-12', '2021-09-10', 0.478419, 15, 7.18);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (274, 24, 'S1', '2021-06-12', '2021-09-10', 0.627365, 15, 9.41);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (275, 24, 'F', '2021-07-01', '2021-10-31', 0.008548, 123, 1.05);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (276, 24, 'S1', '2021-09-11', '2021-10-31', 0.478419, 8, 3.83);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (277, 24, 'S1', '2021-09-11', '2021-10-31', 0.627365, 8, 5.02);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (278, 25, 'S1', '2021-09-11', '2021-12-21', 0.478419, 17, 8.13);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (279, 25, 'S1', '2021-09-11', '2021-12-21', 0.627365, 17, 10.67);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (280, 25, 'F', '2021-11-01', '2021-12-31', 0.008548, 61, 0.52);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (281, 25, 'S1', '2021-12-22', '2021-12-31', 0.478419, 2, 0.96);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (282, 25, 'S1', '2021-12-22', '2021-12-31', 0.627365, 2, 1.25);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (283, 25, 'S1', '2022-01-01', '2022-02-28', 0.478419, 10, 4.78);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (284, 25, 'S1', '2022-01-01', '2022-02-28', 0.627365, 10, 6.27);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (285, 25, 'F', '2022-01-01', '2022-02-28', 0.008548, 59, 0.5);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (286, 26, 'S1', '2021-12-22', '2021-12-31', 0.478419, 2, 0.96);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (287, 26, 'S1', '2021-12-22', '2021-12-31', 0.627365, 2, 1.25);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (288, 26, 'S1', '2022-01-01', '2022-03-31', 0.478419, 16, 7.65);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (289, 26, 'S1', '2022-01-01', '2022-03-31', 0.627365, 16, 10.04);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (290, 26, 'F', '2022-03-01', '2022-03-31', 0.008548, 31, 0.26);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (291, 26, 'S1', '2022-04-01', '2022-04-19', 0.526261, 3, 1.58);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (292, 26, 'S1', '2022-04-01', '2022-04-19', 0.909679, 3, 2.73);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (293, 26, 'F', '2022-04-01', '2022-07-31', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (294, 26, 'S1', '2022-04-20', '2022-07-05', 0.526261, 13, 6.84);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (295, 26, 'S1', '2022-04-20', '2022-07-05', 0.909679, 13, 11.83);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (296, 26, 'S1', '2022-07-06', '2022-07-31', 0.526261, 4, 2.11);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (297, 26, 'S1', '2022-07-06', '2022-07-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (298, 27, 'S1', '2022-07-06', '2022-10-05', 0.526261, 18, 9.47);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (299, 27, 'S2', '2022-07-06', '2022-10-05', 1.069374, 2, 2.14);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (300, 27, 'S1', '2022-07-06', '2022-10-05', 0.909679, 18, 16.37);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (301, 27, 'S2', '2022-07-06', '2022-10-05', 0.909679, 2, 1.82);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (302, 27, 'F', '2022-08-01', '2022-11-30', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (303, 27, 'S1', '2022-10-06', '2022-11-30', 0.909679, 9, 8.19);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (304, 28, 'F', '2022-12-01', '2022-12-31', 0.011096, 31, 0.34);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (305, 28, 'F', '2023-01-01', '2023-03-31', 0.011096, 90, 1);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (306, 28, 'S2', '2023-01-01', '2023-03-31', 0.909679, 2, 1.82);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (307, 29, 'S1', '2022-10-06', '2022-10-31', 0.526261, 4, 2.11);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (308, 29, 'S1', '2022-10-06', '2022-10-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (309, 29, 'S1', '2022-11-01', '2022-11-30', 0.526261, 4, 2.11);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (310, 29, 'S1', '2022-11-01', '2022-11-30', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (311, 29, 'S1', '2022-12-01', '2022-12-31', 0.526261, 4, 2.11);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (312, 29, 'S1', '2022-12-01', '2022-12-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (313, 29, 'S1', '2023-01-01', '2023-01-31', 0.574103, 4, 2.3);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (314, 29, 'S1', '2023-01-01', '2023-01-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (315, 29, 'S1', '2023-02-01', '2023-02-28', 0.574103, 4, 2.3);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (316, 29, 'S1', '2023-02-01', '2023-02-28', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (317, 29, 'S1', '2023-03-01', '2023-03-31', 0.574103, 4, 2.3);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (318, 29, 'S1', '2023-03-01', '2023-03-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (319, 29, 'S1', '2023-04-01', '2023-04-30', 0.574103, 4, 2.3);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (320, 29, 'S1', '2023-04-01', '2023-04-30', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (321, 29, 'F', '2023-04-01', '2023-07-31', 0.011096, 122, 1.35);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (322, 29, 'S1', '2023-05-01', '2023-05-31', 0.574103, 4, 2.3);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (323, 29, 'S1', '2023-05-01', '2023-05-31', 0.909679, 4, 3.64);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (324, 29, 'S1', '2023-06-01', '2023-06-30', 0.574103, 5, 2.87);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (325, 29, 'S1', '2023-06-01', '2023-06-30', 0.909679, 5, 4.55);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (326, 29, 'S1', '2023-07-01', '2023-07-10', 0.574103, 1, 0.57);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (327, 29, 'S1', '2023-07-01', '2023-07-10', 0.909679, 1, 0.91);
INSERT INTO H2OConsumo (idConsumo, idH2OFattura, tipoSpesa, dtIniz, dtFine, prezzoUnit, quantita, importo) VALUES (328, 29, 'S2', '2023-07-11', '2023-07-31', 0.909679, 1, 0.91);

-- Tabella: H2OFattura
DROP TABLE IF EXISTS H2OFattura;

CREATE TABLE IF NOT EXISTS H2OFattura (
    idH2OFattura        INTEGER       PRIMARY KEY,
    idIntesta           INT,
    annoComp            INT,
    DataEmiss           DATE,
    fattNrAnno          INT,
    fattNrNumero        NVARCHAR (50),
    periodFattDtIniz    DATE,
    periodFattDtFine    DATE,
    periodCongDtIniz    DATE,
    periodCongDtFine    DATE,
    periodAccontoDtIniz DATE,
    periodAccontoDtFine DATE,
    assicurazione       MONEY,
    impostaQuiet        MONEY,
    RestituzAccPrec     MONEY,
    TotPagare           MONEY
);

INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (1, 1, 2020, '2020-04-20', 2020, '320016588', '2019-11-01', '2020-02-29', NULL, '2020-02-29', '2019-11-01', NULL, 5.39, 0.17, NULL, 76.88);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (2, 1, 2020, '2020-08-04', 2020, '320035544', '2020-03-01', '2020-06-30', '2019-10-05', '2020-05-28', '2020-05-29', '2020-06-30', 6.67, 0.17, NULL, 0);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (3, 1, 2020, '2020-12-09', 2020, '320055005', '2020-07-01', '2020-10-31', '2020-05-29', '2020-08-25', '2020-08-26', '2020-10-31', 6.72, 0.17, NULL, 99.28999999999999);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (4, 1, 2021, '2021-05-31', 2021, '32016452', '2020-11-01', '2021-02-28', '2020-08-26', '2020-12-10', '2020-12-11', '2021-02-28', 6.56, 0.17, NULL, 121.00999999999999);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (5, 1, 2021, '2021-10-29', 2021, '32035363', '2021-03-01', '2021-06-30', '2020-12-11', '2021-06-22', '2021-06-23', '2021-06-30', 6.68, 0.17, NULL, 34.39);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (6, 1, 2022, '2022-01-26', 2022, '32003826', '2021-07-01', '2021-10-31', '2021-06-23', '2021-09-10', '2021-09-11', '2021-10-31', 6.74, 0.17, NULL, 76.42);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (7, 1, 2022, '2022-09-26', 2022, '32048878', '2022-03-01', '2022-07-31', '2021-09-11', '2022-03-28', '2022-07-12', '2022-07-31', 8.38, 0.17, NULL, 110.35999999999999);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (8, 1, 2023, '2023-01-04', 2023, '32003679', '2022-08-01', '2022-11-30', NULL, '2022-10-10', NULL, '2022-11-30', 6.68, 0.17, -13.67, 72.16);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (9, 1, 2023, '2023-06-26', 2023, '32023573', '2022-12-01', '2023-03-31', NULL, '2023-03-31', NULL, NULL, 6.63, 0.17, NULL, 67.92);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (10, 1, 2023, '2023-09-29', 2023, '32043400', '2023-04-01', '2023-07-31', NULL, '2023-07-31', NULL, NULL, 6.68, 0.17, NULL, 68.55);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (11, 3, 2019, '2019-11-28', 2019, '30063070', '2019-07-01', '2019-10-31', '2019-06-11', '2019-09-24', '2019-09-25', '2019-10-31', 4.25, 0.17, NULL, 17.46);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (12, 3, 2020, '2020-04-20', 2020, '320017682', '2019-11-01', '2020-02-29', NULL, '2020-02-29', '2019-11-01', NULL, 5.39, 0.17, NULL, 19.68);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (13, 3, 2020, '2020-08-04', 2020, '320036603', '2020-03-01', '2020-06-30', '2019-09-25', '2020-05-22', '2020-05-23', '2020-06-30', 6.67, 0.17, NULL, 86.53);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (14, 3, 2020, '2020-12-09', 2020, '320056036', '2020-07-01', '2020-10-31', '2020-05-23', '2020-08-18', '2020-08-19', '2020-10-31', 6.72, 0.17, NULL, 36.67);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (15, 3, 2021, '2021-10-29', 2021, '32036324', '2021-03-01', '2021-06-30', '2020-11-27', '2021-06-11', '2021-06-12', '2021-06-30', 6.68, 0.17, NULL, 117.67);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (16, 3, 2022, '2022-01-26', 2022, '32004781', '2021-07-01', '2021-10-31', '2021-09-11', '2021-09-10', '2021-09-11', '2021-10-31', 6.74, 0.17, NULL, 48.93);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (17, 3, 2022, '2022-05-31', 2022, '32029941', '2021-11-01', '2022-02-28', '2021-09-11', '2021-12-22', '2021-12-23', '2022-02-28', 6.57, 0.17, NULL, 16.24);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (18, 3, 2022, '2022-09-26', 2022, '32049794', '2022-03-01', '2022-07-31', '2021-12-23', '2022-07-05', '2022-07-06', '2022-07-31', 8.38, 0.17, NULL, 150.8);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (19, 3, 2023, '2023-01-04', 2023, '32004580', '2022-08-01', '2022-11-30', NULL, '2022-10-05', NULL, '2022-11-30', 6.68, 0.17, -13.12, 39.03);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (20, 3, 2023, '2023-06-26', 2023, '32024453', '2022-12-01', '2023-03-31', NULL, '2023-03-31', NULL, NULL, 6.63, 0.17, NULL, 7.97);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (21, 3, 2023, '2023-09-29', 2023, '32044264', '2023-04-01', '2023-07-31', NULL, '2023-07-10', NULL, '2023-07-31', 6.68, 0.17, -42.68, 117.96);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (22, 2, 2021, '2021-05-31', 2021, '32015853', '2020-11-01', '2021-02-28', '2020-08-19', '2020-11-30', '2020-12-01', '2021-02-28', 6.56, 0.17, NULL, 26.89);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (23, 2, 2021, '2021-10-29', 2021, '32034789', '2021-03-01', '2021-06-30', '2020-12-01', '2021-04-16', '2021-06-12', '2021-06-30', 6.68, 0.17, NULL, 32.53);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (24, 2, 2022, '2022-01-26', 2022, '32003247', '2021-07-01', '2021-10-31', '2021-06-12', '2021-09-10', '2021-09-11', '2021-10-31', 6.74, 0.17, NULL, 30.41);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (25, 2, 2022, '2022-05-31', 2022, '32028444', '2021-11-01', '2022-02-28', '2021-09-11', '2021-12-21', '2021-12-22', '2022-02-28', 6.57, 0.17, NULL, 31.3);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (26, 2, 2022, '2022-09-26', 2022, '32048325', '2022-03-01', '2022-07-31', '2021-12-22', '2022-04-19', '2022-07-06', '2022-07-31', 8.38, 0.17, NULL, 45.86);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (27, 2, 2023, '2023-01-04', 2023, '32003129', '2022-08-01', '2022-11-30', NULL, '2022-10-05', NULL, '2022-11-30', 6.68, 0.17, -5.75, 45.01000000000001);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (28, 2, 2023, '2023-06-26', 2023, '32023024', '2022-12-01', '2023-03-31', NULL, '2023-03-31', NULL, NULL, 6.63, 0.17, NULL, 49.42);
INSERT INTO H2OFattura (idH2OFattura, idIntesta, annoComp, DataEmiss, fattNrAnno, fattNrNumero, periodFattDtIniz, periodFattDtFine, periodCongDtIniz, periodCongDtFine, periodAccontoDtIniz, periodAccontoDtFine, assicurazione, impostaQuiet, RestituzAccPrec, TotPagare) VALUES (29, 2, 2023, '2023-09-29', 2023, '32042855', '2023-04-01', '2023-07-31', NULL, '2023-07-10', NULL, '2023-07-31', 6.68, 0.17, -54.39, 17.51);

-- Tabella: H2OLettura
DROP TABLE IF EXISTS H2OLettura;

CREATE TABLE IF NOT EXISTS H2OLettura (
    idLettura    INTEGER      PRIMARY KEY,
    idH2OFattura INT          NOT NULL,
    lettQtaMc    INT,
    LettData     DATE,
    TipoLett     VARCHAR (16),
    Consumofatt  FLOAT
);

INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (1, 1, 1020, '2019-10-04', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (2, 1, NULL, NULL, 'stim', 63.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (3, 1, NULL, NULL, 'tot', 63.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (4, 2, 1020, '2019-10-04', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (5, 2, 1079, '2020-05-28', 'eff', 59.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (6, 2, NULL, NULL, 'stim', 18.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (7, 2, NULL, NULL, 'tot', 77.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (8, 3, 1079, '2020-05-28', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (9, 3, 1136, '2020-08-25', 'eff', 57.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (10, 3, NULL, NULL, 'stim', 17.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (11, 3, NULL, NULL, 'tot', 74.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (12, 4, 1136, '2020-08-25', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (13, 4, 1171, '2020-12-10', 'eff', 35.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (14, 4, NULL, NULL, 'stim', 52.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (15, 4, NULL, NULL, 'tot', 87.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (16, 5, 1171, '2020-12-10', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (17, 5, 1251, '2021-06-22', 'eff', 80.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (18, 5, NULL, NULL, 'stim', 3.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (19, 5, NULL, NULL, 'tot', 83.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (20, 6, 1251, '2021-06-22', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (21, 6, 1283, '2021-09-10', 'eff', 32.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (22, 6, NULL, NULL, 'stim', 21.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (23, 6, NULL, NULL, 'tot', 53.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (24, 7, 1283, '2021-09-10', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (25, 7, 1346, '2022-03-28', 'eff', 63.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (26, 7, 1398, '2022-07-11', 'eff', 52.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (27, 7, NULL, NULL, 'stim', 8.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (28, 7, NULL, NULL, 'tot', 123.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (29, 8, 1398, '2022-07-11', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (30, 8, 1426, '2022-10-10', 'eff', 28.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (31, 8, NULL, NULL, 'stim', 19.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (32, 8, NULL, NULL, 'tot', 47.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (33, 9, 1426, '2022-10-10', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (34, 9, NULL, NULL, 'stim', 36.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (35, 9, NULL, NULL, 'tot', 36.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (36, 10, 1426, '2022-10-10', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (37, 10, NULL, NULL, 'stim', 36.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (38, 10, NULL, NULL, 'tot', 36.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (39, 11, 6369, '2019-06-10', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (40, 11, 6380, '2019-09-24', 'eff', 11.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (41, 11, NULL, NULL, 'stim', 1.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (42, 11, NULL, NULL, 'tot', 12.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (43, 12, 6380, '2019-09-24', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (44, 12, NULL, NULL, 'stim', 12.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (45, 12, NULL, NULL, 'tot', 12.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (46, 13, 6380, '2019-09-24', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (47, 13, 6450, '2020-05-22', 'eff', 70.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (48, 13, NULL, NULL, 'stim', 4.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (49, 13, NULL, NULL, 'tot', 74.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (50, 14, 6450, '2020-05-22', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (51, 14, 6455, '2020-08-18', 'eff', 5.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (52, 14, NULL, NULL, 'stim', 22.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (53, 14, NULL, NULL, 'tot', 27.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (54, 15, 6456, '2020-11-26', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (55, 15, 6545, '2021-06-11', 'eff', 89.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (56, 15, NULL, NULL, 'stim', 0.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (57, 15, NULL, NULL, 'tot', 89.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (58, 16, 6545, '2021-06-11', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (59, 16, 6552, '2021-09-10', 'eff', 7.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (60, 16, NULL, NULL, 'stim', 23.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (61, 16, NULL, NULL, 'tot', 30.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (62, 17, 6552, '2021-09-10', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (63, 17, 6581, '2021-12-22', 'eff', 29.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (64, 17, NULL, NULL, 'stim', 5.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (65, 17, NULL, NULL, 'tot', 34.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (66, 18, 6581, '2021-12-22', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (67, 18, 6665, '2022-07-05', 'eff', 84.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (68, 18, NULL, NULL, 'stim', 8.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (69, 18, NULL, NULL, 'tot', 92.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (70, 19, 6665, '2022-07-05', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (71, 19, 6666, '2022-10-05', 'eff', 1.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (72, 19, NULL, NULL, 'stim', 24.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (73, 19, NULL, NULL, 'tot', 25.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (74, 20, 6666, '2022-10-05', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (75, 20, NULL, NULL, 'stim', 0.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (76, 20, NULL, NULL, 'tot', 0.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (77, 21, 6666, '2022-10-05', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (78, 21, 6756, '2023-07-10', 'eff', 90.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (79, 21, NULL, NULL, 'stim', 0.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (80, 21, NULL, NULL, 'tot', 90.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (81, 22, 4856, '2020-08-18', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (82, 22, 4871, '2020-11-30', 'eff', 15.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (83, 22, NULL, NULL, 'stim', 14.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (84, 22, NULL, NULL, 'tot', 29.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (85, 23, 4871, '2020-11-30', 'eff', NULL);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (86, 23, 4894, '2021-04-16', 'eff', 23.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (87, 23, NULL, NULL, 'stim', 3.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (88, 23, NULL, NULL, 'tot', 36.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (89, 24, NULL, NULL, 'stim', 8.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (90, 24, NULL, NULL, 'tot', 23.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (91, 25, NULL, NULL, 'stim', 12.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (92, 25, NULL, NULL, 'tot', 29.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (93, 26, NULL, NULL, 'stim', 4.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (94, 26, NULL, NULL, 'tot', 38.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (95, 27, NULL, NULL, 'stim', 9.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (96, 27, NULL, NULL, 'tot', 29.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (97, 28, NULL, NULL, 'stim', 27.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (98, 28, NULL, NULL, 'tot', 27.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (99, 29, NULL, NULL, 'stim', 5.0);
INSERT INTO H2OLettura (idLettura, idH2OFattura, lettQtaMc, LettData, TipoLett, Consumofatt) VALUES (100, 29, NULL, NULL, 'tot', 43.0);

-- Tabella: Intesta
DROP TABLE IF EXISTS Intesta;

CREATE TABLE IF NOT EXISTS Intesta (
    idIntesta   INTEGER        PRIMARY KEY,
    NomeIntesta NVARCHAR (64),
    dirfatture  NVARCHAR (128) 
);

INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (1, 'claudio', 'F:\Google Drive\SMichele\AASS');
INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (2, 'andrea', 'F:\varie\AASS\Andrea');
INSERT INTO Intesta (idIntesta, NomeIntesta, dirfatture) VALUES (3, 'alessandro', 'F:\varie\AASS\Alessandro');

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

-- Vista: EEConsumoAnnuo
DROP VIEW IF EXISTS EEConsumoAnnuo;
CREATE VIEW IF NOT EXISTS EEConsumoAnnuo AS
    SELECT NomeIntesta,
           CAST (dtIniz AS INT) AS anno,
           SUM(importo) AS totAnno
      FROM EEConsumoMensile
     GROUP BY NomeIntesta,
              CAST (dtIniz AS INT);


-- Vista: EEConsumoMensile
DROP VIEW IF EXISTS EEConsumoMensile;
CREATE VIEW IF NOT EXISTS EEConsumoMensile AS
    SELECT te.NomeIntesta,
           cs.idEEFattura,
           cs.dtIniz,
           CAST (cs.dtIniz AS INT) AS annoComp,
           cs.tipoSpesa,
           cs.prezzoUnit,
           cs.quantita,
           cs.importo
      FROM EEConsumo AS cs
           INNER JOIN
           EEFattura AS ft ON ft.idEEFattura = cs.idEEFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta
     WHERE 1 = 1;


-- Vista: EEConsumoMensPivot
DROP VIEW IF EXISTS EEConsumoMensPivot;
CREATE VIEW IF NOT EXISTS EEConsumoMensPivot AS
    SELECT te.NomeIntesta,
           cs.dtIniz,-- cast(cs.dtIniz as int) as anno,
           /* cs.tipoSpesa, */SUM(CASE WHEN cs.tipospesa = 'E1' THEN cs.importo END) AS E1,
           SUM(CASE WHEN cs.tipospesa = 'E2' THEN cs.importo END) AS E2,
           SUM(CASE WHEN cs.tipospesa = 'P' THEN cs.importo END) AS P,
           SUM(CASE WHEN cs.tipospesa = 'R' THEN cs.importo END) AS R,
           SUM(CASE WHEN cs.tipospesa = 'PU' THEN cs.importo END) AS PU,
           SUM(CASE WHEN cs.tipospesa = 'S1' THEN cs.importo END) AS S1,
           SUM(CASE WHEN cs.tipospesa = 'S2' THEN cs.importo END) AS S2-- ,cs.quantita
      /* ,cs.importo */FROM EEConsumo AS cs
           INNER JOIN
           EEFattura AS ft ON ft.idEEFattura = cs.idEEFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta
     WHERE 1 = 1
     GROUP BY te.nomeIntesta,
              cs.dtIniz
     ORDER BY te.nomeIntesta,
              cs.dtIniz;


-- Vista: EELettureMensili
DROP VIEW IF EXISTS EELettureMensili;
CREATE VIEW IF NOT EXISTS EELettureMensili AS
    SELECT te.NomeIntesta,
           le.idLettura,
           le.idEEFattura,
           le.LettDtPrec,
           strftime('%Y.%m', DATE(le.LettDtPrec) ) AS mmDtPrec,
           le.TipoLettura,
           le.LettPrec,
           le.LettDtAttuale,
           strftime('%Y.%m', le.LettDtAttuale) AS mmDtAttuale,
           le.LettAttuale,
           le.LettConsumo
      FROM EELettura AS le
           INNER JOIN
           EEFattura AS ft ON ft.idEEFattura = le.idEEFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta;


-- Vista: GASConsumoMensile
DROP VIEW IF EXISTS GASConsumoMensile;
CREATE VIEW IF NOT EXISTS GASConsumoMensile AS
    SELECT te.NomeIntesta,
           cs.idGASFattura/* ,dbo.toAnnoMese(cs.dtIniz) as dtIniz */,
           cs.dtIniz AS dtIniz,
           cs.dtFine AS dtFine,
           cs.tipoSpesa,
           cs.prezzoUnit,
           cs.quantita,
           JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1 AS qtaGG,
           cs.quantita / (JULIANDAY(cs.dtFine) - JULIANDAY(cs.dtIniz) + 1) AS mediaGG,
           cs.importo
      FROM GASConsumo AS cs
           INNER JOIN
           GASFattura AS ft ON ft.idGASFattura = cs.idGASFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta
     WHERE ft.periodEffDtIniz IS NOT NULL AND 
           cs.dtIniz BETWEEN ft.periodEffDtIniz AND ft.periodEffDtFine;
-- ,dbo.toAnnoMese(cs.dtFine) as dtFine

-- Vista: GASLettureMensili
DROP VIEW IF EXISTS GASLettureMensili;
CREATE VIEW IF NOT EXISTS GASLettureMensili AS
    SELECT te.NomeIntesta/* ,le.idLettura */,
           ft.periodFattDtIniz AS dtFattIniz,
           ft.periodFattDtFine AS dtFattFine,
           le.LettData AS lettDtPrec,
           le.TipoLett,
           le.Consumofatt
      FROM GASLettura AS le
           INNER JOIN
           GASFattura AS ft ON ft.idGASFattura = le.idGASFattura
           INNER JOIN
           intesta AS te ON ft.idIntesta = te.idIntesta;
-- ,le.idGASFattura

-- Vista: GASScaglioniImporto
DROP VIEW IF EXISTS GASScaglioniImporto;
CREATE VIEW IF NOT EXISTS GASScaglioniImporto AS
    SELECT NomeIntesta,
           idGASFattura,
           dtIniz,
           dtFine,
           JULIANDAY(dtFine) - JULIANDAY(dtIniz) + 1 AS qtaGG,
           SUM(CASE WHEN tipospesa = 'G1' THEN importo END) AS Scagl1,
           SUM(CASE WHEN tipospesa = 'G2' THEN importo END) AS Scagl2,
           SUM(CASE WHEN tipospesa = 'G3' THEN importo END) AS Scagl3,
           COALESCE(SUM(CASE WHEN tipospesa = 'G1' THEN importo END), 0) + COALESCE(SUM(CASE WHEN tipospesa = 'G2' THEN importo END), 0) + COALESCE(SUM(CASE WHEN tipospesa = 'G3' THEN importo END), 0) AS Totale,
           (COALESCE(SUM(CASE WHEN tipospesa = 'G1' THEN importo END), 0) + COALESCE(SUM(CASE WHEN tipospesa = 'G2' THEN importo END), 0) + COALESCE(SUM(CASE WHEN tipospesa = 'G3' THEN importo END), 0) ) / (JULIANDAY(dtFine) - JULIANDAY(dtIniz) + 1) AS mediaGG
      FROM GASConsumoMensile
     GROUP BY NomeIntesta,
              idGASFattura,
              dtIniz,
              dtFine;


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
