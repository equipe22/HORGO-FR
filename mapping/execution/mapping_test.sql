/* ================================================================================================
 @fr: Requête de vérification et validation de l'alimentation.
 @en: Verification queries for mapping procedures.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-09
 Version       : 0.0.1
================================================================================================ */

-- ================================================== VERIFICATION
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."AdministrativeUnit-Discipline_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."AdministrativeUnit-MedicoAdministrativeUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."AdministrativeUnit-Service_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."FunctionalUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."HealthcareDivision_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."FunctionalUnit-Speciality_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."FunctionalUnit-Service_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."FunctionalUnit-ManagementUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."AgentIdentification_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."AdministrativeUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."Hospital_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."HospitalIdentification_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."HospitalizationUnit-AdministrativeUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."HospitalizationUnit-Service_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."HospitalizationUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."ManagementUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."MedicalDiscipline";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."MedicalSpeciality";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."OrganizationalUnit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."ServiceDepartement_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."Structure_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."Unit_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."UnitCategory_history";
SELECT COUNT(*) FROM "HORG-FR_HISTORY"."UnitIdentification_history";

-- ================================================== VALIDATION
-- Validation de l'alimentation des poles
WITH horg AS
(
  SELECT count(DISTINCT "T0008_dbid") AS org_count
  FROM "HORG-FR_HISTORY"."HORG-FR_000005_history"
),
hegp AS
(
  SELECT count(DISTINCT pole_code) AS hegp_count
  FROM "sirius"."hegp_pole"
),
hap AS
(
  SELECT count(DISTINCT pole_code) AS hap_count
  FROM "sirius"."hap_pole"
)
SELECT *, org_count = hegp_count + hap_count AS division_isValid
FROM horg, hegp, hap
;

-- Vérification de l'alimentation des service et département
WITH horg AS
(
  SELECT count(DISTINCT "T000b_dbid") AS org_count
  FROM "HORG-FR_HISTORY"."HORG-FR_000006_history"
),
hegp AS
(
  SELECT count(DISTINCT sd_code) AS hegp_count
  FROM "sirius"."hegp_serviceDepartement"
),
hap AS
(
  SELECT count(DISTINCT sd_code) AS hap_count
  FROM "sirius"."hap_serviceDepartement"
)
SELECT *, org_count = hegp_count + hap_count AS serviceDepartement_isValid
FROM horg, hegp, hap
;

-- Vérification de l'alimentation des unités fonctionnelle
WITH horg AS
(
  SELECT count(DISTINCT "T000a_dbid") AS org_count
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_history"
),
hegp AS
(
  SELECT count(DISTINCT uf_code) AS hegp_count
  FROM "sirius"."hegp_uniteFonctionnelle"
),
hap AS
(
  SELECT count(DISTINCT uf_code) AS hap_count
  FROM "sirius"."hap_uniteFonctionnelle"
)
SELECT *, org_count = hegp_count + hap_count AS functionalUnit_isValid
FROM horg, hegp, hap
;

-- Vérification de l'alimentation des unités de gestion
WITH horg AS
(
  SELECT count(DISTINCT "T0001_dbid") AS org_count
  FROM "HORG-FR_HISTORY"."HORG-FR_000009_history"
),
hegp AS
(
  SELECT count(DISTINCT ug_code) AS hegp_count
  FROM "sirius"."hegp_uniteGestion"
),
hap AS
(
  SELECT count(DISTINCT ug_code) AS hap_count
  FROM "sirius"."hap_uniteGestion"
)
SELECT *, org_count = hegp_count + hap_count AS managementUnit_isValid
FROM horg, hegp, hap
;

-- Vérification de l'alimentation des unités administratives
WITH horg AS
(
  SELECT count(DISTINCT "T0004_dbid") AS org_count
  FROM "HORG-FR_HISTORY"."HORG-FR_000025_history"
),
hegp AS
(
  SELECT count(DISTINCT ua_code) AS hegp_count
  FROM "sirius"."hegp_uniteAdministrative"
),
hap AS
(
  SELECT count(DISTINCT ua_code) AS hap_count
  FROM "sirius"."hap_uniteAdministrative"
)
SELECT *, org_count = hegp_count + hap_count AS administrativeUnit_isValid
FROM horg, hegp, hap
;

-- Vérification de l'alimentation des unités médico-administratives
WITH horg AS
(
  SELECT count(DISTINCT "T0010_dbid") AS org_count
  FROM "HORG-FR_HISTORY"."HORG-FR_000011_history"
),
hegp AS
(
  SELECT count(DISTINCT uma_code) AS hegp_count
  FROM "sirius"."hegp_uniteMedicoAdministrative"
),
hap AS
(
  SELECT count(DISTINCT uma_code) AS hap_count
  FROM "sirius"."hap_uniteMedicoAdministrative"
)
SELECT *, org_count = hegp_count + hap_count AS medicoAdministrativeUnit_isValid
FROM horg, hegp, hap
;

-- Vérification de l'alimentation des unités hospitalières
WITH horg AS
(
  SELECT count(DISTINCT "T0003_dbid") AS org_count
  FROM "HORG-FR_HISTORY"."HORG-FR_000012_history"
),
hegp AS
(
  SELECT count(DISTINCT uh_code) AS hegp_count
  FROM "sirius"."hegp_uniteHospitaliere"
),
hap AS
(
  SELECT count(DISTINCT uh_code) AS hap_count
  FROM "sirius"."hap_uniteHospitaliere"
)
SELECT *, org_count = hegp_count + hap_count AS HospitalizationUnit_isValid
FROM horg, hegp, hap
;
