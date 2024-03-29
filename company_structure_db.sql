CREATE DATABASE curs3_db;
USE curs3_db;

-- departament: id(PK), denumire, acronim
CREATE TABLE departament(
	id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    denumire VARCHAR(50) NOT NULL,
    acronim VARCHAR(4)
);

-- angajat: id(PK), nume, prenume, data_angajare, data_demisie, salariu, id_departament(FK)
CREATE TABLE angajat(
	id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR(50) NOT NULL,
    prenume VARCHAR(50) NOT NULL,
    data_angajare DATE NOT NULL,
    data_demisie DATE NULL,
    salariu INT(5) NOT NULL DEFAULT 3000,
    id_departament TINYINT NOT NULL,
    FOREIGN KEY(id_departament) REFERENCES departament(id)
);


-- adaugarea datelor(CREATE -> clauza:insert)
INSERT INTO departament VALUES(NULL,'Development','DEV');

-- preluarea datelor(READ -> clauza)
SELECT * FROM departament;
SELECT id, denumire, acronim FROM departament;

INSERT INTO departament
VALUES
(NULL,'Human Resources','HR'),
(NULL,'Quality Assurance','QA'),
(NULL,'Accounting',NULL);

INSERT INTO departament(acronim,denumire)
VALUES
('R&D','Research&Dev'),
(NULL,'Finance');

INSERT INTO departament
SET denumire = 'Operations' , acronim = 'OPS';

INSERT INTO departament VALUES(); -- adauga doar null sau valori default

-- resetare auto-increment
DELETE FROM departament; -- sterg toate inregistrarile

-- ii fac un auto_increment de la 1 ca sa inceapa de la 1
ALTER TABLE departament AUTO_INCREMENT = 1;

-- sterge date din departament(nu poate fi stearsa - tabela angajat are legatura cu tabela departament)
TRUNCATE departament;

INSERT INTO angajat
VALUES
(NULL,'Popa','Matei',20190315,NULL,4500,3),
(NULL,'Rusu','Dan',20180523,NULL,5000,7),
(NULL,'Popa','Tania',20190315,NULL,4600,3),
(NULL,'Nistor','Andrei',20190315,NULL,6000,1),
(NULL,'Voicu','Ana',20190315,NULL,5000,1),
(NULL,'Dinu','Bogdan',20190315,NULL,4600,2),
(NULL,'Florescu','Gina',20190315,NULL,4300,5);

SELECT * FROM angajat;

-- update
-- un angajat si-a dat demisia azi
UPDATE angajat
SET data_demisie = CURDATE()
WHERE nume = 'Popa' AND prenume = 'Matei';

UPDATE angajat
SET data_demisie = 20210627
WHERE id = 2;

UPDATE angajat
SET data_demisie = '2021-06-27'
WHERE id = 1;

-- salariile din dept 1 si 2 s-au majorat cu 10%
UPDATE angajat
SET salariu = salariu * 1.1
WHERE id_departament = 1 OR id_departament= 2;

UPDATE angajat
SET salariu = salariu * 1.1
WHERE id_departament IN (1,2);

-- statisticile: salariul minim, mediu, maxim
SELECT
MIN(salariu) AS minim,
MAX(salariu) maxim,
AVG(salariu) mediu
FROM angajat;

-- cati angajati si-au dat demisia
SELECT COUNT(*) nr_angajati
FROM angajat
WHERE data_demisie IS NOT NULL;

-- angajatii curenti, ordonati dupa salariu
SELECT *
FROM angajat
WHERE data_demisie IS NULL
ORDER BY salariu DESC;

-- angajatul cu cel mai mare salariu

SELECT * 
FROM angajat
ORDER BY salariu DESC
LIMIT 1;

SELECT *
FROM angajat
ORDER BY salariu DESC
LIMIT 1,1; -- limit m,n = sar peste m inregistrari si le afisez pe urmatoarele n
