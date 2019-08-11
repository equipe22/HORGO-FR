/* ================================================================================================
 Requête de récupération des unités du service 63 de l'HEGP.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */

-- HEGP Service de nutrition [id:63]
WITH hospital AS (
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
  WHERE "hospitalId" = '075' AND "serviceDepartmentId" = '63'
),
service AS (
  SELECT '1'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "hospitalId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
  WHERE "hospitalId" = '075' AND "serviceDepartmentId" = '63'
  UNION
  SELECT '2'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "divisionId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history"
  WHERE "hospitalId" = '075' AND "serviceDepartmentId" = '63'
),
uf AS (
  SELECT '2'::CHAR AS level, 'FU'::CHAR(4) AS unitCategory_en, 'UF'::CHAR(4) AS unitCategory_fr,
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId" AS id,
    "divisionId" AS supId,
    "functionalUnitLabel" AS label,
    "functionalUnit_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
    NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-Service_history"
  WHERE "serviceDepartement_dbid" IN (SELECT dbid FROM service)
   AND "division_dbid" IN (SELECT dbid FROM pole)
), --select * from uf UNION select * from service;
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
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM hospital
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


-- Les unités dont la spécialité est NUTRITION dans tous les hopitaux de la BD.
WITH hospital AS (
  SELECT '0'::CHAR AS level, 'MC'::CHAR(4) AS unitCategory_en, 'HO'::CHAR(4) AS unitCategory_fr,
    "hospital_dbid" AS dbid,
    "hospitalId" AS id,
    '-'::TEXT AS supId,
    "hospitalLabel" AS label,
    "hospital_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."Hospital_history"
),
uf_spe AS
(
  SELECT
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId",
    "functionalUnit_dbid VT"
  FROM "HORG-FR_HISTORY"."FunctionalUnit-Speciality_history"
  WHERE "medicalSpecialityCode" = '92302080'
),
uf AS (
  SELECT '2'::CHAR AS level, 'FU'::CHAR(4) AS unitCategory_en, 'UF'::CHAR(4) AS unitCategory_fr,
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId" AS id,
    "division_dbid" AS subDbid,
    "divisionId" AS supId,
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
  WHERE division_dbid IN (SELECT subDbid FROM uf)
), -- select * from pole;
service AS (
  SELECT '1'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "hospitalId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-Service_history"
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf)
  UNION
  SELECT '2'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "divisionId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history"
  WHERE "division_dbid" IN (SELECT dbid FROM pole)
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
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM hospital
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

-- Les unités dont la spécialité est NUTRITION pour 075:HEGP
WITH hospital AS (
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
  WHERE "medicalSpecialityCode" = '92302080'
),
uf_allHospital AS (
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
uf_hegp AS
(
  SELECT *
  FROM uf_allHospital
  WHERE dbid IN (SELECT dbid FROM "HORG-FR_HISTORY"."HEGP_structure" WHERE unitCategory_en = 'FU')
),
pole AS (
  SELECT '1'::CHAR AS level, 'HDIV'::CHAR(4) AS unitCategory_en, 'POLE'::CHAR(4) AS unitCategory_fr,
    "division_dbid" AS dbid,
    "divisionId" AS id,
    "hospitalId" AS supId,
    "divisionLabel" AS label,
    "division_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
  WHERE division_dbid IN (SELECT supDbid FROM uf_hegp)
    AND "hospitalId" = '075'
), -- select * from pole;
service AS (
  SELECT '1'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "hospitalId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-Service_history"
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf_hegp)
    AND "hospitalId" = '075'
  UNION
  SELECT '2'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "divisionId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history"
  WHERE "division_dbid" IN (SELECT dbid FROM pole)
   AND "serviceDepartement_dbid" IN (SELECT supDbid FROM uf_hegp)
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
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf_hegp)
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
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM hospital
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM pole
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM service
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uf_hegp
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM ug
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uma
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uh
)
SELECT * FROM structure --WHERE validTime @> daterange('2008-01-01', '2015-01-02', '[]')
;

-- Les unités dont la spécialité est NUTRITION pour 014:HAP
WITH hospital AS (
  SELECT '0'::CHAR AS level, 'MC'::CHAR(4) AS unitCategory_en, 'HO'::CHAR(4) AS unitCategory_fr,
    "hospital_dbid" AS dbid,
    "hospitalId" AS id,
    '-'::TEXT AS supId,
    "hospitalLabel" AS label,
    "hospital_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."Hospital_history"
  WHERE "hospitalId" = '014'
),
uf_spe AS
(
  SELECT
    "functionalUnit_dbid" AS dbid,
    "functionalUnitId",
    "functionalUnit_dbid VT"
  FROM "HORG-FR_HISTORY"."FunctionalUnit-Speciality_history"
  WHERE "medicalSpecialityCode" = '92302080'
),
uf_allHospital AS (
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
uf_hap AS
(
  SELECT *
  FROM uf_allHospital
  WHERE dbid IN (SELECT dbid FROM "HORG-FR_HISTORY"."HAP_structure" WHERE unitCategory_en = 'FU')
),
pole AS (
  SELECT '1'::CHAR AS level, 'HDIV'::CHAR(4) AS unitCategory_en, 'POLE'::CHAR(4) AS unitCategory_fr,
    "division_dbid" AS dbid,
    "divisionId" AS id,
    "hospitalId" AS supId,
    "divisionLabel" AS label,
    "division_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
  WHERE division_dbid IN (SELECT supDbid FROM uf_hap)
    AND "hospitalId" = '014'
), -- select * from pole;
service AS (
  SELECT '1'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "hospitalId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."FunctionalUnit-Service_history"
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf_hap)
    AND "hospitalId" = '014'
  UNION
  SELECT '2'::CHAR AS level, 'SD'::CHAR(4) AS unitCategory_en, 'SD'::CHAR(4) AS unitCategory_fr,
    "serviceDepartement_dbid" AS dbid,
    "serviceDepartmentId" AS id,
    "divisionId" AS supId,
    "serviceDepartmentLabel" AS label,
    "serviceDepartement_dbid VT" AS validTime
  FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    NATURAL JOIN "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history"
  WHERE "division_dbid" IN (SELECT dbid FROM pole)
   AND "serviceDepartement_dbid" IN (SELECT supDbid FROM uf_hap)
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
  WHERE "functionalUnit_dbid" IN (SELECT dbid FROM uf_hap)
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
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM hospital
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM pole
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM service
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uf_hap
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM ug
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uma
UNION
SELECT level, unitCategory_en, unitCategory_fr, id, supId, label, validTime FROM uh
)
SELECT * FROM structure --WHERE validTime @> daterange('2008-01-01', '2015-01-02', '[]')
;