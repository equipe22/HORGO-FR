/* ================================================================================================
 Création des requêtes d'alimentation depuis les vues SIRIUS.
 Note l'utilisation : le fichier Alimentation_procedure doit être exécuter en premier.
 Loading time estimation : 30 min
 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */
--
-- Création des établissements
--
WITH etablissement AS
    (
    SELECT DISTINCT
    "CODE HOPITAL" as code,
    "hopital" as label,
    daterange('2001-01-01', null) AS vt
    FROM "sirius"."ges-hegp_2019"
    )
SELECT "HORG-FR_HISTORY"."add_hospital"(code, label, vt)
FROM etablissement
;
--
-- Création des poles
--
WITH division AS (
  SELECT DISTINCT
    hopital_code,
    pole_code,
    label,
    vt
  FROM "sirius"."hegp_pole"
  WHERE filedate = '2019'
)
-- SELECT * FROM pole
SELECT "HORG-FR_HISTORY"."add_healthcareDivision"(hopital_code, pole_code, label, vt)
FROM division
;
--
-- Création des services et départements
--
WITH service AS
(
  SELECT DISTINCT
    hopital_code,
    --pole_code,
    sd_code,
    label,
    sd_vt
  FROM "sirius"."hegp_serviceDepartement"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_serviceDepartement"(hopital_code, sd_code, label, sd_vt)
FROM service
;
-- Création des liens service-pole
-- NOTE 2019-04-04 CK : La période de validité du lien entre une UF et UG est la période de validité la plus petite
--   des deux unités.
WITH servicePole AS
(
  SELECT DISTINCT
    hopital_code,
    pole_code,
    sd_code,
    label,
    CASE WHEN sd_vt <@ pole_vt THEN sd_vt ELSE pole_vt END AS vt
  FROM "sirius"."hegp_serviceDepartement"
  WHERE filedate = '2019' AND pole_code <> ''
)
SELECT "HORG-FR_HISTORY"."add_serviceDepartement-division"(hopital_code, sd_code, pole_code, vt)
FROM servicePole;
--
-- Création des unités de gestion
--
WITH ug AS
(
  SELECT DISTINCT
    hopital_code,
    pole_code,
    --sd_code,
    ug_code,
    label,
    --spe_code,
    --spe_label,
    ug_vt
  FROM "sirius"."hegp_uniteGestion"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_managementUnit"(hopital_code, pole_code, ug_code, label, ug_vt)
FROM ug
;
--
-- Création des spécialités médicales
--
WITH spe AS
(
  SELECT DISTINCT spe_code, spe_label
  FROM "sirius"."hegp_SpecialiteMedical"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_medicalSpeciality"(spe_code, spe_label)
FROM spe;
--
-- Création des unités fonctionnelles
--
WITH uf AS
(
  SELECT DISTINCT
    hopital_code,
    pole_code,
    pole_vt,
    --sd_code,
    uf_code,
    label,
    --spe_code,
    --spe_label,
    uf_vt
  FROM "sirius"."hegp_uniteFonctionnelle"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_functionalUnit"(hopital_code, pole_code, uf_code, label, uf_vt)
FROM uf
;
-- Création des liens unité fonctionnelle - specialité médicale
-- NOTE 2019-04-04 : La période de validité entre une unité fonctionnelle est la spécialité est la période de validité
--  de l'unité.
WITH ufspe AS
(
  SELECT DISTINCT
    hopital_code,
    --pole_code,
    --sd_code,
    uf_code,
    --label,
    spe_code,
    --spe_label,
    uf_vt
  FROM "sirius"."hegp_uniteFonctionnelle"
  WHERE filedate = '2019' AND spe_code <> ''
)
SELECT "HORG-FR_HISTORY"."add_functionalUnit-speciality"(hopital_code, uf_code, spe_code, uf_vt)
FROM ufspe
;
-- Création des liens unité fonctionnelle - service
WITH ufService AS
(
  SELECT DISTINCT
    hopital_code,
    --pole_code,
    sd_code,
    uf_code,
    --label,
    --spe_code,
    --spe_label,
    CASE WHEN uf_vt <@ sd_vt THEN uf_vt ELSE sd_vt END AS vt
  FROM "sirius"."hegp_uniteFonctionnelle-service"
  WHERE filedate = '2019' AND sd_code <> ''
)
SELECT "HORG-FR_HISTORY"."add_functionalUnit-service"(hopital_code, uf_code, sd_code, vt)
FROM ufService
;

-- Création des liens unités fonctionnelles - unité de gestion
-- NOTE 2019-04-04 CK : La période de validité du lien entre une UF et UG est la période de validité la plus petite
--   des deux unités.
WITH ufManagement AS
(
  SELECT DISTINCT
    hopital_code,
    uf_code,
    uf_label,
    ug_code,
    ug_label,
    CASE WHEN uf_vt <@ ug_vt THEN uf_vt ELSE ug_vt END AS vt
  FROM "sirius"."hegp_uniteFonctionnelle-uniteGestion"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_functionalUnit-managementUnit"(hopital_code, uf_code, ug_code, vt)
FROM ufManagement
;
--
-- Création des unités médico-administratives
--
WITH uma AS
(
  SELECT DISTINCT
    hopital_code,
    --pole_code,
    ug_code,
    uma_code,
    label,
    uma_vt
  FROM "sirius"."hegp_uniteMedicoAdministrative"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_medicoAdministrativeUnit"(hopital_code, ug_code, uma_code, label, uma_vt)
FROM uma
;
--
-- Création des unités administratives
--
WITH ua AS
(
  SELECT DISTINCT
    hopital_code,
    ug_code,
    ug_vt,
    ua_code,
    deq,
    split_part(deq,' - ', 1) displine_code,
    split_part(deq,' - ', 2) displine_label,
    label,
    ua_vt
  FROM "sirius"."hegp_uniteAdministrative"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_administrativeUnit"(hopital_code, ug_code, ua_code, label, ua_vt)
FROM ua
;
-- Création des displines
WITH discipline AS
(
  SELECT DISTINCT
    deq,
    split_part(deq,' - ', 1) discipline_code,
    split_part(deq,' - ', 2) discipline_label
  FROM "sirius"."hegp_uniteAdministrative"
)
SELECT "HORG-FR_HISTORY"."add_medicalDiscipline"(discipline_code, discipline_label)
FROM discipline
;
-- Création des liens ua - discplines
WITH uaDiscipline AS
(
  SELECT DISTINCT
    hopital_code,
    ua_code,
    deq,
    split_part(deq,' - ', 1) discipline_code,
    ua_vt
  FROM "sirius"."hegp_uniteAdministrative"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_administrativeUnit-discipline"(hopital_code, ua_code, discipline_code, ua_vt)
FROM uaDiscipline
;
-- Création des liens unités administratives - unités médico-Administrative
--
WITH ua_uma AS
(
  SELECT DISTINCT
    hopital_code,
    ua_code,
    ua_label,
    uma_code,
    uma_label,
    CASE WHEN ua_vt <@ uma_vt THEN ua_vt ELSE uma_vt END AS vt
  FROM "sirius"."hegp_uniteAdministrative-unitMedicoAdministrative"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_administrativeUnit-medicoAdministrativeUnit"(hopital_code, ua_code, uma_code, vt)
FROM ua_uma
;
-- Création des liens unités administratives - service et département
--
WITH ua_sd AS
(
  SELECT DISTINCT
    hopital_code,
    ua_code,
    ua_label,
    sd_code,
    sd_label,
    CASE WHEN ua_vt <@ sd_vt THEN ua_vt ELSE sd_vt END AS vt
  FROM "sirius"."hegp_uniteAdministrative-service"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_administrativeUnit-service"(hopital_code, ua_code, sd_code, vt)
FROM ua_sd
;
--
-- Création des unités hospitalières
--
WITH uh AS
(
  SELECT DISTINCT
    hopital_code,
    --pole_code,
    uma_code,
    uh_code,
    label,
    uh_vt
  FROM "sirius"."hegp_uniteHospitaliere"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_hospitalizationUnit"(hopital_code, uma_code, uh_code, label, uh_vt)
FROM uh
;
-- Création des liens unités hospitalières - service et département
--
WITH uh_sd AS
(
  SELECT DISTINCT
    hopital_code,
    uh_code,
    uh_label,
    sd_code,
    sd_label,
    CASE WHEN uh_vt <@ sd_vt THEN uh_vt ELSE sd_vt END AS vt
  FROM "sirius"."hegp_uniteHospitaliere-service"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_hospitalizationUnit-service"(hopital_code, uh_code, sd_code, vt)
FROM uh_sd
;

-- Création des liens unités hospitalières - service et département
--
WITH uh_ua AS
(
  SELECT DISTINCT
    hopital_code,
    uh_code,
    uh_label,
    ua_code,
    ua_label,
    CASE WHEN uh_vt <@ ua_vt THEN uh_vt ELSE ua_vt END AS vt
  FROM "sirius"."hegp_uniteHospitaliere-uniteAdministrative"
  WHERE filedate = '2019'
)
SELECT "HORG-FR_HISTORY"."add_hospitalizationUnit-administrativeUnit"(hopital_code, uh_code, ua_code, vt)
FROM uh_ua
;
