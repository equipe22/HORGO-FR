/* ================================================================================================
 Requête de construction de la structure de tous les hopitaux de la base de données.
 La requête représente les liens entre toutes les unités de la structures.
 Structure(level, unitCategory_en, unitCategory_fr, id, supId, label)
 Chaque tuple représente
   le niveau hiérarchique de l'unité,
   l'acronyme de la catégorie en anglais et en français
   l'identifiant de l'unité,
   l'identifiant de l'unité supérieure directe,
   le libellé de l'unité et
   la date de sa création.

 All hospital organizational structure query
 The query represents linkes bewtween all units of the structure.
 Structure(level, unitCategory_en, unitCategory_fr, id, supId, label)
 Each tuple represents
   the hierarchy level,
   the unit category acronym in english and in french
   the unit identifier
   the direct super-unit identifier
   the unit label
   the creation date of the unit.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */
SET SCHEMA 'HORG-FR_HISTORY';
--DROP MATERIALIZED VIEW "HORG-FR_HISTORY"."ALL_structure" CASCADE;
CREATE MATERIALIZED VIEW IF NOT EXISTS "HORG-FR_HISTORY"."ALL_structure" AS
WITH hospital AS (
  SELECT '0'::CHAR AS level, 'MC'::CHAR(4) AS unitCategory_en, 'HO'::CHAR(4) AS unitCategory_fr,
    "hospital_dbid" AS dbid,
    "hospitalId" AS hospitalId,
    "hospitalId" AS id,
    0 AS supdbid,
    '-'::TEXT AS supId,
    "hospitalLabel" AS label,
    "hospital_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."Hospital_history"
),
pole AS (
  SELECT '1'::CHAR AS level, 'HDIV'::CHAR(4) AS unitCategory_en, 'POLE'::CHAR(4) AS unitCategory_fr,
    "division_dbid" AS dbid,
    "divisionHospitalId" AS hospitalId,
    "divisionId" AS id,
    "hospital_dbid" AS supdbid,
    "hospitalId" AS supId,
    "divisionLabel" AS label,
    "division_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
),
service AS (
  SELECT '1'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentHospitalId" AS hospitalId,
    "serviceDepartmentId" AS id,
    "hospital_dbid" AS supdbid,
    "hospitalId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
  WHERE "hospital_dbid" IN (SELECT dbid FROM hospital)
  UNION
    SELECT '1'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentHospitalId" AS hospitalId,
    "serviceDepartmentId" AS id,
    "division_dbid" AS supdbid,
    "divisionId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history"
  WHERE "division_dbid" IN (SELECT dbid FROM pole)
),
uf AS (
  SELECT '2'::CHAR AS level, 'FU'::CHAR(4) AS unitCategory_en, 'UF'::CHAR(4) AS unitCategory_fr,
    "functionalUnit_dbid" AS dbid,
    "functionalUnitHospitalId" AS hospitalId,
    "functionalUnitId" AS id,
    "division_dbid" AS supdbid,
    "divisionId" AS supId,
    "functionalUnitLabel" AS label,
    "functionalUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
  WHERE "division_dbid" IN (SELECT dbid FROM pole)
  UNION
  SELECT '2'::CHAR AS level, 'FU'::CHAR(4) AS unitCategory_en, 'UF'::CHAR(4) AS unitCategory_fr,
    "functionalUnit_dbid" AS dbid,
    "functionalUnitHospitalId" AS hospitalId,
    "functionalUnitId" AS id,
    "serviceDepartement_dbid" AS supdbid,
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
    "managementUnitHospitalId" AS hospitalId,
    "managementUnitId" AS id,
    "division_dbid" AS supdbid,
    "divisionId" AS supId,
    "managementUnitLabel" AS label,
    "managementUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ManagementUnit_history"
  WHERE "division_dbid" IN (SELECT dbid FROM pole)
),
uma AS (
  SELECT '3'::CHAR AS level, 'MAU'::CHAR(4) AS unitCategory_en, 'UMA'::CHAR(4) AS unitCategory_fr,
    "medicoAdministrativeUnit_dbid" AS dbid,
    "medicoAdministrativeUnitHospitalId" AS hospitalId,
    "medicoAdministrativeUnitId" AS id,
    "managementUnit_dbid" AS supdbid,
    "managementUnitId" AS supId,
    "medicoAdministrativeUnitLabel" AS label,
    "medicoAdministrativeUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history"
  WHERE "managementUnit_dbid" IN (SELECT dbid FROM ug)
),
ua AS (
  SELECT '3'::CHAR AS level, 'AU'::CHAR(4) AS unitCategory_en, 'UA'::CHAR(4) AS unitCategory_fr,
    "administrativeUnit_dbid" AS dbid,
    "administrativeUnitHospitalId" AS hospitalId,
    "administrativeUnitId" AS id,
    "managementUnit_dbid" AS supdbid,
    "managementUnitId" AS supId,
    "administrativeUnitLabel" AS label,
    "administrativeUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."AdministrativeUnit_history"
  WHERE "managementUnit_dbid" IN (SELECT dbid FROM ug)
),
uh AS (
    SELECT '4'::CHAR AS level, 'HU'::CHAR(4) AS unitCategory_en, 'UH'::CHAR(4) AS unitCategory_fr,
    "hospitalizationUnit_dbid" AS dbid,
    "hospitalizationUnitHospitalId" AS hospitalId,
    "hospitalizationUnitId" AS id,
    "medicoAdministrativeUnit_dbid" AS supdbid,
    "medicoAdministrativeUnitId" AS supId,
    "hospitalizationUnitLabel" AS label,
    "hospitalizationUnit_dbid VT" AS validtime
  FROM "HORG-FR_HISTORY"."HospitalizationUnit_history"
  WHERE "medicoAdministrativeUnit_dbid" IN (SELECT dbid FROM uma)
)
SELECT * FROM hospital
UNION
SELECT * FROM pole
UNION
SELECT * FROM service
UNION
SELECT * FROM uf
UNION
SELECT * FROM ug
UNION
SELECT * FROM uma
UNION
SELECT * FROM ua
UNION
SELECT * FROM uh;

CREATE UNIQUE INDEX "all_structure_idx01"
  ON "HORG-FR_HISTORY"."ALL_structure" (dbid, supdbid);

CREATE UNIQUE INDEX "all_structure_idx02"
  ON "HORG-FR_HISTORY"."ALL_structure" (dbid, supdbid, validTime);
