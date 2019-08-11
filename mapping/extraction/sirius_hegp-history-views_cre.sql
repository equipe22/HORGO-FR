/* ==============================================================================
 Création des vues cumulative des données SIRIUS
   2015-2016 et 2019
 ================================================================================ */
SET SCHEMA 'sirius';

CREATE OR REPLACE FUNCTION createValidTimePeriod(beginDate TEXT, endDate TEXT, modifDate TEXT)
  RETURNS DATERANGE AS
  $$
    SELECT
      CASE WHEN endDate <> '' THEN
        daterange(to_date(beginDate, 'DD-MM-YYYY'), to_date(endDate, 'DD-MM-YYYY'), '[]')
      ELSE daterange(to_date(beginDate, 'DD-MM-YYYY'), null)
      END AS vt;
  $$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION createDuringPeriod(beginDate TEXT, endDate TEXT, modifDate TEXT)
  RETURNS DATERANGE AS
  $$
    SELECT
      CASE WHEN endDate <> '' THEN
        daterange(to_date(beginDate, 'DD-MM-YYYY'), to_date(endDate, 'DD-MM-YYYY'), '[]')
      WHEN endDate = '' AND modifDate <> '' AND modifDate <> beginDate AND modifDate <> endDate THEN
        daterange(to_date(beginDate, 'DD-MM-YYYY'), to_date(modifDate, 'DD-MM-YYYY'), '[]')
      ELSE null
      END AS vt;
  $$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION createSincePeriod(beginDate TEXT)
  RETURNS DATERANGE AS
  $$
    SELECT daterange(to_date(beginDate, 'DD-MM-YYYY'), null) AS vt;
  $$ LANGUAGE SQL;

/* ==============================================================================
 Les données des poles
 ================================================================================ */
CREATE OR REPLACE VIEW pole AS
WITH pole_2019 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "pole" AS label,
    "type_pole",
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createSincePeriod("DATE EFFET CREA POLE") AS vbx,
    createDuringPeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS vbe
    ,'2019' AS fileDate
  FROM "ges-hegp_2019"
  WHERE "CODE POLE" <> ''
  UNION
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "pole" AS label,
    "type_pole",
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createSincePeriod("DATE EFFET CREA POLE") AS vbx,
    createDuringPeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS vbe
    ,'2019' AS fileDate
  FROM "med-hegp_2019"
  WHERE "CODE POLE" <> ''
), pole_2017 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "pole" AS label,
    "TYPE POLE",
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createSincePeriod("DATE EFFET CREA POLE") AS vbx,
    createDuringPeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS vbe
    ,'2017' AS fileDate
  FROM "hupo_2017"
  WHERE "CODE HOPITAL" = '075' AND "CODE POLE" <> '' AND "TYPE POLE" <> ''
), pole_2016 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "pole" AS label,
    "type_pole",
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createSincePeriod("DATE EFFET CREA POLE") AS vbx,
    createDuringPeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS vbe
    ,'2016' AS fileDate
  FROM "ges-hegp_2016"
  WHERE "CODE POLE" <> ''
  UNION
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "pole" AS label,
    "type_pole",
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createSincePeriod("DATE EFFET CREA POLE") AS vbx,
    createDuringPeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS vbe
    ,'2016' AS fileDate
  FROM "med-hegp_2016"
  WHERE "CODE POLE" <> ''
), pole_2015 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "pole" AS label,
    "type_pole",
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createSincePeriod("DATE EFFET CREA POLE") AS vbx,
    createDuringPeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS vbe
    ,'2015' AS fileDate
  FROM "ges-hegp_2015"
  WHERE "CODE POLE" <> ''
  UNION
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "pole" AS label,
    "type_pole",
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createSincePeriod("DATE EFFET CREA POLE") AS vbx,
    createDuringPeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS vbe
    ,'2015' AS fileDate
  FROM "med-hegp_2015"
  WHERE "CODE POLE" <> ''
)
SELECT * FROM pole_2019
UNION
SELECT * FROM pole_2017
UNION
SELECT * FROM pole_2016
UNION
SELECT * FROM pole_2015;

/* ==============================================================================
 Les données des services départements
 ================================================================================ */
-- NOTE 2019-04-04 CK : Les services et départements du fichier SIRIUS 2017 ne sont pas pris en compte,
--  car les données de 2017 ne contiennent pas de date pour service et département.
CREATE OR REPLACE VIEW serviceDepartement AS
WITH service_2019 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createSincePeriod("DATE EFFET CREA POLE") AS pole_vbx,
    createDuringPeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vbe,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "SERVICE-DEPARTEMENT" as label,
    "TYPE S-D",
    "RESPONSABLE S-D",
    "DATE EFFET CREA S-D",
    "DATE EFFET MOD S-D",
    "DATE EFFET FIN VAL S-D",
    createSincePeriod("DATE EFFET CREA S-D") AS sd_vbx,
    createDuringPeriod("DATE EFFET CREA S-D", "DATE EFFET FIN VAL S-D", "DATE EFFET MOD S-D") AS sd_vbe
    ,'2019' AS fileDate
  FROM "med-hegp_2019"
  WHERE "CODE SERVIDE-DEPARTEMENT" <> ''
), service_2016 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "SERVICE-DEPARTEMENT" as label,
    "TYPE S-D",
    "RESPONSABLE S-D",
    "DATE EFFET CREA S-D",
    "DATE EFFET MOD S-D",
    "DATE EFFET FIN VAL S-D",
    createValidTimePeriod("DATE EFFET CREA S-D", "DATE EFFET FIN VAL S-D", "DATE EFFET MOD S-D") AS sd_vt
     ,'2016' AS fileDate
  FROM "med-hegp_2016"
  WHERE "CODE SERVIDE-DEPARTEMENT" <> '' AND "SERVICE-DEPARTEMENT" <> '******'
), service_2015 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "SERVICE-DEPARTEMENT" as label,
    "TYPE S-D",
    "RESPONSABLE S-D",
    "DATE EFFET CREA S-D",
    "DATE EFFET MOD S-D",
    "DATE EFFET FIN VAL S-D",
    createValidTimePeriod("DATE EFFET CREA S-D", "DATE EFFET FIN VAL S-D", "DATE EFFET MOD S-D") AS sd_vt
    ,'2015' AS fileDate
  FROM "med-hegp_2015"
  WHERE "CODE SERVIDE-DEPARTEMENT" <> '' AND "SERVICE-DEPARTEMENT" <> '******'
)
SELECT * FROM service_2019
UNION
SELECT * FROM service_2016
UNION
SELECT * FROM service_2015;

/* ==============================================================================
 Les données des unités fonctionnelles
 ================================================================================ */
 -- NOTE 2019-04-04 CK : le fichier SIRIUS 2017 ne contient pas des données de spécialités médicales.
CREATE OR REPLACE VIEW SpecialiteMedical AS
WITH spe_2019 AS
(
  SELECT DISTINCT
    "SPE MEDICALE" AS spe_code,
    upper("LIB SPE MEDICALE") AS spe_label
    --,daterange(to_date("DATE EFFET CREA UF", 'DD-MM-YYYY'), NULL) AS vbx
    ,'2019' AS fileDate
  FROM "med-hegp_2019"
  WHERE "SPE MEDICALE" <> ''
), spe_2016 AS
(
  SELECT DISTINCT
    "SPE MEDICALE" AS spe_code,
    upper("LIB SPE MEDICALE") AS spe_label
    --,daterange(to_date("DATE EFFET CREA UF", 'DD-MM-YYYY'), NULL) AS vbx
    ,'2016' AS fileDate
  FROM "med-hegp_2016"
  WHERE "SPE MEDICALE" <> ''
), spe_2015 AS
(
  SELECT DISTINCT
    "SPE MEDICALE" AS spe_code,
    upper("LIB SPE MEDICALE") AS spe_label
    --,daterange(to_date("DATE EFFET CREA UF", 'DD-MM-YYYY'), NULL) AS vbx
    ,'2015' AS fileDate
  FROM "med-hegp_2015"
  WHERE "SPE MEDICALE" <> ''
)
SELECT * FROM spe_2019
UNION
SELECT * FROM spe_2016
UNION
SELECT * FROM spe_2015
-- SELECT spe_code, spe_label, pack(vbx)
-- FROM spe
-- GROUP BY spe_code, spe_label
;

-- NOTE 2019-04-04 CK : Les unités fonctionnelles du fichier SIRIUS 2017 ne sont pas pris en compte,
--  car les données ne contiennent pas de date pour ces unités.
CREATE OR REPLACE VIEW uniteFonctionnelle AS
WITH uf_2019 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "CODE UF" AS uf_code,
    "uf" AS label,
    "TYPE UF",
    "RESPONSABLE UF",
    "SPE MEDICALE" spe_code,
    upper("LIB SPE MEDICALE") spe_label,
    "DATE EFFET CREA UF",
    "DATE EFFET MOD UF",
    "DATE EFFET FIN VAL UF",
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt
    ,'2019' AS fileDate
  FROM "med-hegp_2019"
  WHERE "CODE UF" <> ''
), uf_2016 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "CODE UF" AS uf_code,
    "uf" AS label,
    "TYPE UF",
    "RESPONSABLE UF",
    "SPE MEDICALE" spe_code,
    upper("LIB SPE MEDICALE") spe_label,
    "DATE EFFET CREA UF",
    "DATE EFFET MOD UF",
    "DATE EFFET FIN VAL UF",
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt
    ,'2016' AS fileDate
  FROM "med-hegp_2016"
  WHERE "CODE UF" <> ''
), uf_2015 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "CODE UF" AS uf_code,
    "uf" AS label,
    "TYPE UF",
    "RESPONSABLE UF",
    "SPE MEDICALE" spe_code,
    upper("LIB SPE MEDICALE") spe_label,
    "DATE EFFET CREA UF",
    "DATE EFFET MOD UF",
    "DATE EFFET FIN VAL UF",
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt
    ,'2015' AS fileDate
  FROM "med-hegp_2015"
  WHERE "CODE UF" <> ''
)
SELECT * FROM uf_2019
UNION
SELECT * FROM uf_2016
UNION
SELECT * FROM uf_2015
;

/* ==============================================================================
 Les données des unités de fonctionnelle - services
 ================================================================================ */
-- NOTE 2019-04-04 CK : Les UFs et les SD du fichier SIRIUS 2017 ne sont pas pris en compte,
--  car les données de 2017 ne contiennent pas de date pour ces unités.
CREATE OR REPLACE VIEW uniteFonctionnelle_service_2019 AS
WITH uf_sd_2019 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "SERVICE-DEPARTEMENT" AS sd_label,
    "DATE EFFET CREA S-D",
    "DATE EFFET MOD S-D",
    "DATE EFFET FIN VAL S-D",
    createValidTimePeriod("DATE EFFET CREA S-D", "DATE EFFET FIN VAL S-D", "DATE EFFET MOD S-D") AS sd_vt,
    "CODE UF" AS uf_code,
    "uf" AS uf_label,
    "DATE EFFET CREA UF",
    "DATE EFFET MOD UF",
    "DATE EFFET FIN VAL UF",
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt
    ,'2019' AS fileDate
  FROM "med-hegp_2019"
  WHERE "CODE UF" <> '' AND "CODE SERVIDE-DEPARTEMENT" <> ''
), uf_sd_2016 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "SERVICE-DEPARTEMENT" AS sd_label,
    "DATE EFFET CREA S-D",
    "DATE EFFET MOD S-D",
    "DATE EFFET FIN VAL S-D",
    createValidTimePeriod("DATE EFFET CREA S-D", "DATE EFFET FIN VAL S-D", "DATE EFFET MOD S-D") AS sd_vt,
    "CODE UF" AS uf_code,
    "uf" AS uf_label,
    "DATE EFFET CREA UF",
    "DATE EFFET MOD UF",
    "DATE EFFET FIN VAL UF",
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt
    ,'2016' AS fileDate
  FROM "med-hegp_2016"
  WHERE "CODE UF" <> '' AND "CODE SERVIDE-DEPARTEMENT" <> ''
), uf_sd_2015 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "CODE SERVIDE-DEPARTEMENT" AS sd_code,
    "SERVICE-DEPARTEMENT" AS sd_label,
    "DATE EFFET CREA S-D",
    "DATE EFFET MOD S-D",
    "DATE EFFET FIN VAL S-D",
    createValidTimePeriod("DATE EFFET CREA S-D", "DATE EFFET FIN VAL S-D", "DATE EFFET MOD S-D") AS sd_vt,
    "CODE UF" AS uf_code,
    "uf" AS uf_label,
    "DATE EFFET CREA UF",
    "DATE EFFET MOD UF",
    "DATE EFFET FIN VAL UF",
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt
    ,'2015' AS fileDate
  FROM "med-hegp_2015"
  WHERE "CODE UF" <> '' AND "CODE SERVIDE-DEPARTEMENT" <> ''
)
SELECT * FROM uf_sd_2019
UNION
SELECT * FROM uf_sd_2016
UNION
SELECT * FROM uf_sd_2015
;

/* ==============================================================================
 Les données des unités de gestion
 ================================================================================ */
CREATE OR REPLACE VIEW uniteGestion AS
WITH ug_2019 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE UG" AS ug_code,
    "ug" AS label,
    "TYPE UG",
    "TA UG",
    "DATE EFFET CREA UG",
    "DATE EFFET MOD UG",
    "DATE EFFET FIN VAL UG",
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt
    ,'2019' AS fileDate
  FROM "ges-hegp_2019"
  WHERE "CODE UG" <> ''
), ug_2017 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE UG" AS ug_code,
    "LIBELLE UG" AS label,
    "TYPE UG",
    "TA UG",
    "DATE EFFET CREA UG",
    "DATE EFFET MOD UG",
    "DATE EFFET FIN VAL UG",
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt
    ,'2017' AS fileDate
  FROM "hupo_2017"
  WHERE "CODE HOPITAL" = '075' AND "CODE UG" <> '' AND "CODE UG" <> '-'
), ug_2016 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE UG" AS ug_code,
    "ug" AS label,
    "TYPE UG",
    "TA UG",
    "DATE EFFET CREA UG",
    "DATE EFFET MOD UG",
    "DATE EFFET FIN VAL UG",
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt
    ,'2016' AS fileDate
  FROM "ges-hegp_2016"
  WHERE "CODE UG" <> ''
), ug_2015 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "DATE EFFET CREA POLE",
    "DATE EFFET MOD POLE",
    "DATE EFFET FIN VAL POLE",
    createValidTimePeriod("DATE EFFET CREA POLE", "DATE EFFET FIN VAL POLE", "DATE EFFET MOD POLE") AS pole_vt,
    "CODE UG" AS ug_code,
    "ug" AS label,
    "TYPE UG",
    "TA UG",
    "DATE EFFET CREA UG",
    "DATE EFFET MOD UG",
    "DATE EFFET FIN VAL UG",
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt
    ,'2015' AS fileDate
  FROM "ges-hegp_2015"
  WHERE "CODE UG" <> ''
)
SELECT * FROM ug_2019
UNION
SELECT * FROM ug_2017
UNION
SELECT * FROM ug_2016
UNION
SELECT * FROM ug_2015
;

/* ==============================================================================
 Les données des unités de fonctionnelle - unités de gestion
 ================================================================================ */
-- NOTE 2019-04-04 CK : les données SIRIUS 2017 ne possède pas de date pour les UFs.
-- alors uf_vt = ug_vt pour les données 2017.
CREATE OR REPLACE VIEW uniteFonctionnelle_uniteGestion_2019 AS
WITH uf_ug_2019 AS
(
  SELECT DISTINCT
    ges."CODE HOPITAL" AS hopital_code,
    ges."CODE POLE" AS pole_code,
    "CODE UF" AS uf_code,
    "LIBELLE UF" AS uf_label,
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt,
    "CODE UG" AS ug_code,
    "ug" AS ug_label,
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt
    ,'2019' AS fileDate
  FROM "ges-hegp_2019" AS ges JOIN "med-hegp_2019" AS med
    ON(ges."CODE HOPITAL" = med."CODE HOPITAL"
      AND ges."CODE POLE" = med."CODE POLE"
      AND ges."LIBELLE UF" = med."uf")
  WHERE "CODE UG" <> ''
), uf_ug_2017 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "CR/UF" AS uf_code,
    "LIBELLE CR/UF" AS uf_label,
     createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS uf_vt,
    "CODE UG" AS ug_code,
    "LIBELLE UG" AS ug_label,
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt
    , '2017' AS fileDate
  FROM hupo_2017
  WHERE "CODE HOPITAL" = '075' AND "CODE UG" <> '' AND "CODE UG" <> '-'
), uf_ug_2016 AS
(
  SELECT DISTINCT
    ges."CODE HOPITAL" AS hopital_code,
    ges."CODE POLE" AS pole_code,
    "CODE UF" AS uf_code,
    "LIBELLE UF" AS uf_label,
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt,
    "CODE UG" AS ug_code,
    "ug" AS ug_label,
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt
    ,'2016' AS fileDate
  FROM "ges-hegp_2016" AS ges JOIN "med-hegp_2016" AS med
    ON(ges."CODE HOPITAL" = med."CODE HOPITAL"
      AND ges."CODE POLE" = med."CODE POLE"
      AND ges."LIBELLE UF" = med."uf")
  WHERE "CODE UG" <> ''
), uf_ug_2015 AS
(
  SELECT DISTINCT
    ges."CODE HOPITAL" AS hopital_code,
    ges."CODE POLE" AS pole_code,
    "CODE UF" AS uf_code,
    "LIBELLE UF" AS uf_label,
    createValidTimePeriod("DATE EFFET CREA UF", "DATE EFFET FIN VAL UF", "DATE EFFET MOD UF") AS uf_vt,
    "CODE UG" AS ug_code,
    "ug" AS ug_label,
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt
    ,'2015' AS fileDate
  FROM "ges-hegp_2015" AS ges JOIN "med-hegp_2015" AS med
    ON(ges."CODE HOPITAL" = med."CODE HOPITAL"
      AND ges."CODE POLE" = med."CODE POLE"
      AND ges."LIBELLE UF" = med."uf")
  WHERE "CODE UG" <> ''
)
SELECT * FROM uf_ug_2019
UNION
SELECT * FROM uf_ug_2017
UNION
SELECT * FROM uf_ug_2016
UNION
SELECT * FROM uf_ug_2015
;

WITH
uf_med AS (SELECT DISTINCT "CODE UF" AS code, "uf" AS label FROM "med-hegp_2019"),
uf_ges AS (SELECT DISTINCT "LIBELLE UF" AS label FROM "ges-hegp_2019")
SELECT *
FROM uf_med NATURAL JOIN uf_ges;

WITH
uf_med AS (SELECT DISTINCT "CODE UF" AS code, "uf" AS label FROM "med-hegp_2019"),
uf_ges AS (SELECT DISTINCT "LIBELLE UF" AS label FROM "ges-hegp_2019")
SELECT label FROM uf_med
EXCEPT
SELECT label FROM uf_ges;

WITH
uf_med AS (SELECT DISTINCT "CODE UF" AS code, "uf" AS label FROM "med-hegp_2019"),
uf_ges AS (SELECT DISTINCT "LIBELLE UF" AS label FROM "ges-hegp_2019")
SELECT label FROM uf_ges
EXCEPT
SELECT label FROM uf_med;

/* ==============================================================================
 Les données des unités médico-administrative
 ================================================================================ */
 -- NOTE 2019-04-03 CK : Les UMA non PMSI (type-uma <> C - C/PMSI) ne sont ne possèdent pas de URM clinique.
 -- Attention : quelque uma ont une valeur PMSI sans avoir le type C.
CREATE OR REPLACE VIEW uniteMedicoAdministrative AS
WITH uma_2019 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "CODE UG" AS ug_code,
    "DATE EFFET CREA UG",
    "DATE EFFET MOD UG",
    "DATE EFFET FIN VAL UG",
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt,
    "CODE UMA" AS uma_code,
    "uma" AS label,
    "TYPE UMA",
    "TYPE ACTIVITE",
    "Champ PMSI",
    "URM CLINIQUE",
    "DATE EFFET CREA UMA",
    "DATE EFFET MOD UMA",
    "DATE EFFET FIN VAL UMA",
    createValidTimePeriod("DATE EFFET CREA UMA", "DATE EFFET FIN VAL UMA", "DATE EFFET MOD UMA") AS uma_vt
    ,'2019' AS fileDate
  FROM "ges-hegp_2019"
  WHERE "CODE UMA" <> ''
), uma_2017 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "CODE UG" AS ug_code,
    "DATE EFFET CREA UG",
    "DATE EFFET MOD UG",
    "DATE EFFET FIN VAL UG",
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt,
    "CODE UMA" AS uma_code,
    "LIBELLE UMA" AS label,
    "TYPE UMA",
    "TYPE ACTIVITE",
    "Champ PMSI",
    "URM CLINIQUE",
    "DATE EFFET CREA UMA",
    "DATE EFFET MOD UMA",
    "DATE EFFET FIN VAL UMA",
    createValidTimePeriod("DATE EFFET CREA UMA", "DATE EFFET FIN VAL UMA", "DATE EFFET MOD UMA") AS uma_vt
    ,'2017' AS fileDate
  FROM "hupo_2017"
  WHERE "CODE HOPITAL" = '075' AND "CODE UMA" <> '' AND "CODE UMA" <> '-'
), uma_2016 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "CODE UG" AS ug_code,
    "DATE EFFET CREA UG",
    "DATE EFFET MOD UG",
    "DATE EFFET FIN VAL UG",
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt,
    "CODE UMA" AS uma_code,
    "uma" AS label,
    "TYPE UMA",
    "TYPE ACTIVITE",
    "Champ PMSI",
    "URM CLINIQUE",
    "DATE EFFET CREA UMA",
    "DATE EFFET MOD UMA",
    "DATE EFFET FIN VAL UMA",
    createValidTimePeriod("DATE EFFET CREA UMA", "DATE EFFET FIN VAL UMA", "DATE EFFET MOD UMA") AS uma_vt
    ,'2016' AS fileDate
  FROM "ges-hegp_2016"
  WHERE "CODE UMA" <> ''
), uma_2015 AS
(
  SELECT DISTINCT
    "CODE HOPITAL" AS hopital_code,
    "CODE POLE" AS pole_code,
    "CODE UG" AS ug_code,
    "DATE EFFET CREA UG",
    "DATE EFFET MOD UG",
    "DATE EFFET FIN VAL UG",
    createValidTimePeriod("DATE EFFET CREA UG", "DATE EFFET FIN VAL UG", "DATE EFFET MOD UG") AS ug_vt,
    "CODE UMA" AS uma_code,
    "uma" AS label,
    "TYPE UMA",
    "TYPE ACTIVITE",
    "Champ PMSI",
    "URM CLINIQUE",
    "DATE EFFET CREA UMA",
    "DATE EFFET MOD UMA",
    "DATE EFFET FIN VAL UMA",
    createValidTimePeriod("DATE EFFET CREA UMA", "DATE EFFET FIN VAL UMA", "DATE EFFET MOD UMA") AS uma_vt
    ,'2015' AS fileDate
  FROM "ges-hegp_2015"
  WHERE "CODE UMA" <> ''
)
SELECT * FROM uma_2019
UNION
SELECT * FROM uma_2017
UNION
SELECT * FROM uma_2016
UNION
SELECT * FROM uma_2015
;

/* ==============================================================================
 Les données des unités d'hospitalisation
 ================================================================================ */
-- NOTE 2019-04-03 CK : Les UMA non pas obligatoirement un UH.
CREATE OR REPLACE VIEW uniteHospitaliere AS
WITH uh_2019 AS
(
  SELECT
    "CODE HOPITAL" AS hopital_code,
    "CODE UMA" AS uma_code,
    "DATE EFFET CREA UMA",
    "DATE EFFET MOD UMA",
    "DATE EFFET FIN VAL UMA",
    createValidTimePeriod("DATE EFFET CREA UMA", "DATE EFFET FIN VAL UMA", "DATE EFFET MOD UMA") AS uma_vt,
    "CODE UH" AS uh_code,
    "uh" AS label,
    "DATE EFFET CREA UH",
    "DATE EFFET MOD UH",
    "DATE EFFET FIN VAL UH",
    createValidTimePeriod("DATE EFFET CREA UH", "DATE EFFET FIN VAL UH", "DATE EFFET MOD UH") AS uh_vt
    ,'2019'::CHAR(4) AS fileDate
  FROM "ges-hegp_2019"
  WHERE "CODE UH" <> '' --AND "CODE UMA" <> ''
), uh_2017 AS
(
  SELECT
    "CODE HOPITAL" AS hopital_code,
    "CODE UMA" AS uma_code,
    "DATE EFFET CREA UMA",
    "DATE EFFET MOD UMA",
    "DATE EFFET FIN VAL UMA",
    createValidTimePeriod("DATE EFFET CREA UMA", "DATE EFFET FIN VAL UMA", "DATE EFFET MOD UMA") AS uma_vt,
    "CODE UH" AS uh_code,
    "LIBELLE UH" AS label,
    "DATE EFFET CREA UH",
    "DATE EFFET MOD UH",
    "DATE EFFET FIN VAL UH",
    createValidTimePeriod("DATE EFFET CREA UH", "DATE EFFET FIN VAL UH", "DATE EFFET MOD UH") AS uh_vt
    ,'2017'::CHAR(4) AS fileDate
  FROM "hupo_2017"
  WHERE "CODE HOPITAL" = '075' AND "CODE UH" <> '' AND "CODE UH" <> '-' --AND "CODE UMA" <> ''
), uh_2016 AS
(
  SELECT
    "CODE HOPITAL" AS hopital_code,
    "CODE UMA" AS uma_code,
    "DATE EFFET CREA UMA",
    "DATE EFFET MOD UMA",
    "DATE EFFET FIN VAL UMA",
    createValidTimePeriod("DATE EFFET CREA UMA", "DATE EFFET FIN VAL UMA", "DATE EFFET MOD UMA") AS uma_vt,
    "CODE UH" AS uh_code,
    "uh" AS label,
    "DATE EFFET CREA UH",
    "DATE EFFET MOD UH",
    "DATE EFFET FIN VAL UH",
    createValidTimePeriod("DATE EFFET CREA UH", "DATE EFFET FIN VAL UH", "DATE EFFET MOD UH") AS uh_vt
    ,'2016'::CHAR(4) AS fileDate
  FROM "ges-hegp_2016"
  WHERE "CODE UH" <> '' --AND "CODE UMA" <> ''
), uh_2015 AS
(
  SELECT
    "CODE HOPITAL" AS hopital_code,
    "CODE UMA" AS uma_code,
    "DATE EFFET CREA UMA",
    "DATE EFFET MOD UMA",
    "DATE EFFET FIN VAL UMA",
    createValidTimePeriod("DATE EFFET CREA UMA", "DATE EFFET FIN VAL UMA", "DATE EFFET MOD UMA") AS uma_vt,
    "CODE UH" AS uh_code,
    "uh" AS label,
    "DATE EFFET CREA UH",
    "DATE EFFET MOD UH",
    "DATE EFFET FIN VAL UH",
    createValidTimePeriod("DATE EFFET CREA UH", "DATE EFFET FIN VAL UH", "DATE EFFET MOD UH") AS uh_vt
    ,'2015'::CHAR(4) AS fileDate
  FROM "ges-hegp_2015"
  WHERE "CODE UH" <> '' --AND "CODE UMA" <> ''
)
SELECT * FROM uh_2019
UNION
SELECT * FROM uh_2017
UNION
SELECT * FROM uh_2016
UNION
SELECT * FROM uh_2015
;
