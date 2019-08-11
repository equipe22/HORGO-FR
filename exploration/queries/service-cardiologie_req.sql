/* ================================================================================================
 Requête de récupération de la structure des unités de spécialités cardiologie.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */

-- HEGP Structure pour la spécialité CHIRURGIE CARDIO-VASCULAIRE
WITH medicalCenter AS (
  SELECT '0'::CHAR AS level, 'MC'::CHAR(4) AS unitCategory_en, 'HO'::CHAR(4) AS unitCategory_fr,
    "hospital_dbid" AS dbid,
    "hospitalId" AS id,
    '-'::TEXT AS supId,
    "hospitalLabel" AS label,
    "hospital_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."Hospital_history"
  WHERE "hospitalId" = '075'
),
uf_spe AS
(
  SELECT
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId",
    "functionalUnit_dbid VT"
  FROM "HORG-FR_HISTORY"."FunctionalUnit-Speciality_history"
  WHERE "medicalSpecialityCode" IN ('92319330', '92312020', '92302170')
),
uf AS (
  SELECT '2'::CHAR AS level, 'FU'::CHAR(4) AS unitCategory_en, 'UF'::CHAR(4) AS unitCategory_fr,
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId" AS id,
    "division_dbid" AS supDbid,
    "divisionId" AS supId,
    "functionalUnitLabel" AS label,
    "functionalUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf_spe)
  UNION
  SELECT '2'::CHAR AS level, 'FU'::CHAR(4) AS unitCategory_en, 'UF'::CHAR(4) AS unitCategory_fr,
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId" AS id,
    "serviceDepartement_dbid" AS supDbid,
    "serviceDepartmentId" AS supId,
    "functionalUnitLabel" AS label,
    "functionalUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
    NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-Service_history"
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf_spe)
), -- select * from uf;
pole AS (
  SELECT '1'::CHAR AS level, 'HDIV'::CHAR(4) AS unitCategory_en, 'POLE'::CHAR(4) AS unitCategory_fr,
    "division_dbid" AS dbid,
    "divisionId" AS id,
    "hospitalId" AS supId,
    "divisionLabel" AS label,
    "division_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
  WHERE "hospitalId" = '075'
    AND "division_dbid" IN (SELECT supDbid FROM uf)
),
service AS (
  SELECT '2'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "hospitalId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
  WHERE "serviceDepartement_dbid" IN (SELECT supDbid FROM uf)
),
ug AS (
  SELECT '2'::CHAR AS level, 'MGU'::CHAR(4) AS unitCategory_en, 'UG'::CHAR(4) AS unitCategory_fr,
    "managementUnit_dbid" AS dbid,
    "managementUnitId" AS id,
    "functionalUnitId" AS supId,
    "managementUnitLabel" AS label,
    "managementUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ManagementUnit_history"
   NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-ManagementUnit_history"
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf)
),
uma AS (
  SELECT '3'::CHAR AS level, 'MAU'::CHAR(4) AS unitCategory_en, 'UMA'::CHAR(4) AS unitCategory_fr,
    "medicoAdministrativeUnit_dbid" AS dbid,
    "medicoAdministrativeUnitId" AS id,
    "managementUnitId" AS supId,
    "medicoAdministrativeUnitLabel" AS label,
    "medicoAdministrativeUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history"
  WHERE "managementUnit_dbid" IN (SELECT dbid FROM ug)
),
uh AS (
    SELECT '4'::CHAR AS level, 'HU'::CHAR(4) AS unitCategory_en, 'UH'::CHAR(4) AS unitCategory_fr,
    "hospitalizationUnit_dbid" AS dbid,
    "hospitalizationUnitId" AS id,
    "medicoAdministrativeUnitId" AS supId,
    "hospitalizationUnitLabel" AS label,
    "hospitalizationUnit_dbid VT" AS validtime
  FROM "HORG-FR_HISTORY"."HospitalizationUnit_history"
  WHERE "medicoAdministrativeUnit_dbid" IN (SELECT dbid FROM uma)
), structure AS
(
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM medicalCenter
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM pole
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM service
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uf
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM ug
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uma
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uh
)
SELECT * FROM structure --WHERE validTime @> daterange('2008-01-01', '2015-01-02', '[]')
;


-- Service 38 et 55
WITH medicalCenter AS (
  SELECT '0'::CHAR AS level, 'MC'::CHAR(4) AS unitCategory_en, 'HO'::CHAR(4) AS unitCategory_fr,
    "hospital_dbid" AS dbid,
    "hospitalId" AS id,
    '-'::TEXT AS supId,
    "hospitalLabel" AS label,
    "hospital_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."Hospital_history"
  WHERE "hospitalId" = '075'
),
pole AS (
  SELECT '1'::CHAR AS level, 'HDIV'::CHAR(4) AS unitCategory_en, 'POLE'::CHAR(4) AS unitCategory_fr,
    "division_dbid" AS dbid,
    "divisionId" AS id,
    "hospitalId" AS supId,
    "divisionLabel" AS label,
    "division_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
    NATURAL JOIN "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history"
  WHERE "hospitalId" = '075'
),
service AS (
  SELECT '1'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "hospitalId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
  WHERE "hospitalId" = '075'
),
uf AS (
  SELECT '2'::CHAR AS level, 'FU'::CHAR(4) AS unitCategory_en, 'UF'::CHAR(4) AS unitCategory_fr,
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId" AS id,
    "serviceDepartmentId" AS supId,
    "functionalUnitLabel" AS label,
    "functionalUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
    NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-Service_history"
    NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-Speciality_history"
  WHERE "medicalSpecialityCode" IN ('92319330', '92312020')
    AND "serviceDepartement_dbid" IN (SELECT dbid FROM service)
),
ug AS (
  SELECT '2'::CHAR AS level, 'MGU'::CHAR(4) AS unitCategory_en, 'UG'::CHAR(4) AS unitCategory_fr,
    "managementUnit_dbid" AS dbid,
    "managementUnitId" AS id,
    "functionalUnitId" AS supId,
    "managementUnitLabel" AS label,
    "managementUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ManagementUnit_history"
   NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-ManagementUnit_history"
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf)
  UNION
  SELECT '2'::CHAR AS level, 'MGU'::CHAR(4) AS unitCategory_en, 'UG'::CHAR(4) AS unitCategory_fr,
    "managementUnit_dbid" AS dbid,
    "managementUnitId" AS id,
    "divisionId" AS supId,
    "managementUnitLabel" AS label,
    "managementUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ManagementUnit_history"
  WHERE "division_dbid" IN (SELECT dbid FROM pole)
),
uma AS (
  SELECT '3'::CHAR AS level, 'MAU'::CHAR(4) AS unitCategory_en, 'UMA'::CHAR(4) AS unitCategory_fr,
    "medicoAdministrativeUnit_dbid" AS dbid,
    "medicoAdministrativeUnitId" AS id,
    "managementUnitId" AS supId,
    "medicoAdministrativeUnitLabel" AS label,
    "medicoAdministrativeUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history"
  WHERE "managementUnit_dbid" IN (SELECT dbid FROM ug)
),
uh AS (
    SELECT '4'::CHAR AS level, 'HU'::CHAR(4) AS unitCategory_en, 'UH'::CHAR(4) AS unitCategory_fr,
    "hospitalizationUnit_dbid" AS dbid,
    "hospitalizationUnitId" AS id,
    "medicoAdministrativeUnitId" AS supId,
    "hospitalizationUnitLabel" AS label,
    "hospitalizationUnit_dbid VT" AS validtime
  FROM "HORG-FR_HISTORY"."HospitalizationUnit_history"
  WHERE "medicoAdministrativeUnit_dbid" IN (SELECT dbid FROM uma)
)
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM medicalCenter
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM pole
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM service
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uf
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM ug
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uma
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uh;


-- Structure pole 103 - CVRM
WITH medicalCenter AS (
  SELECT '0'::CHAR AS level, 'MC'::CHAR(4) AS unitCategory_en, 'HO'::CHAR(4) AS unitCategory_fr,
    "hospital_dbid" AS dbid,
    "hospitalId" AS id,
    '-'::TEXT AS supId,
    "hospitalLabel" AS label,
    "hospital_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."Hospital_history"
  WHERE "hospitalId" = '075'
),
pole AS (
  SELECT '1'::CHAR AS level, 'HDIV'::CHAR(4) AS unitCategory_en, 'POLE'::CHAR(4) AS unitCategory_fr,
    "division_dbid" AS dbid,
    "divisionId" AS id,
    "hospitalId" AS supId,
    "divisionLabel" AS label,
    "division_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
    NATURAL JOIN "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history"
  WHERE "hospitalId" = '075'
    AND "divisionId" = '103'
    --AND "serviceDepartmentId" IN ('38', '39', '40', '41', '42', '61', '62', '71', '72')
),
service AS (
  SELECT '1'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "hospitalId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history"
  WHERE "division_dbid" IN (SELECT dbid FROM pole)
),
uf AS (
  SELECT '2'::CHAR AS level, 'FU'::CHAR(4) AS unitCategory_en, 'UF'::CHAR(4) AS unitCategory_fr,
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId" AS id,
    "serviceDepartmentId" AS supId,
    "functionalUnitLabel" AS label,
    "functionalUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
    NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-Service_history"
  WHERE "serviceDepartement_dbid" IN (SELECT dbid FROM service)
),
ug AS (
  SELECT '2'::CHAR AS level, 'MGU'::CHAR(4) AS unitCategory_en, 'UG'::CHAR(4) AS unitCategory_fr,
    "managementUnit_dbid" AS dbid,
    "managementUnitId" AS id,
    "functionalUnitId" AS supId,
    "managementUnitLabel" AS label,
    "managementUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ManagementUnit_history"
   NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-ManagementUnit_history"
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf)
),
uma AS (
  SELECT '3'::CHAR AS level, 'MAU'::CHAR(4) AS unitCategory_en, 'UMA'::CHAR(4) AS unitCategory_fr,
    "medicoAdministrativeUnit_dbid" AS dbid,
    "medicoAdministrativeUnitId" AS id,
    "managementUnitId" AS supId,
    "medicoAdministrativeUnitLabel" AS label,
    "medicoAdministrativeUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history"
  WHERE "managementUnit_dbid" IN (SELECT dbid FROM ug)
),
uh AS (
    SELECT '4'::CHAR AS level, 'HU'::CHAR(4) AS unitCategory_en, 'UH'::CHAR(4) AS unitCategory_fr,
    "hospitalizationUnit_dbid" AS dbid,
    "hospitalizationUnitId" AS id,
    "medicoAdministrativeUnitId" AS supId,
    "hospitalizationUnitLabel" AS label,
    "hospitalizationUnit_dbid VT" AS validtime
  FROM "HORG-FR_HISTORY"."HospitalizationUnit_history"
  WHERE "medicoAdministrativeUnit_dbid" IN (SELECT dbid FROM uma)
)
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM medicalCenter
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM pole
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM service
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uf
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM ug
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uma
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uh;