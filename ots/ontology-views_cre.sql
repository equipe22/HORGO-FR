/* ================================================================================================
 Création des vues ontologiques historiques. Une vue ontologies est une vue d'une classe avec
 l'ensemble des ses axiomes.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */

-- =================================== HORG-FR_000043
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."AgentIdentification_history" AS
    SELECT "T000f_dbid" AS "agentIdentification_dbid", t43.vt AS "agentIdentification_dbid VT",
      "T0013_dbid" AS "agentId_dbid",
      "AGENTID"    AS "agentId",
      t43_agent.vt AS "agentId VT",
      "T0017_dbid" AS "agentLabel_dbid",
      "AGENTLABEL" AS "agentLabel",
      t43_label.vt AS "agentLabel VT"
    FROM "HORG-FR_HISTORY"."HORG-FR_000043_history" AS t43
      JOIN "HORG-FR_HISTORY"."HORG-FR_000043_identifier_AGENTID_history" AS t43_agent USING ("T000f_dbid")
      JOIN "HORG-FR_HISTORY"."T0013" USING("T0013_dbid")
      JOIN "HORG-FR_HISTORY"."HORG-FR_000043_HORG-FR_000001_AGENTLABEL_history"  AS t43_label USING ("T000f_dbid")
      JOIN "HORG-FR_HISTORY"."T0017" USING ("T0017_dbid")
;

-- =================================== HORG-FR_000026::Identificateur d'un établissement
-- NOTE 2019-04-19 CK : clé naturelle = agentId
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."HospitalIdentification_history" AS
    SELECT t26."T0005_dbid" AS "hospitalIdentification_dbid", t26.vt AS "hospitalIdentification_dbid VT",
      t43."agentId_dbid" AS "hospitalId_dbid",
      t43."agentId"      AS "hospitalId",
      t43."agentId VT"   AS "hospitalId_dbid VT",
      t43."agentLabel_dbid" AS "hospitalLabel_dbid",
      t43."agentLabel"      AS "hospitalLabel" ,
      t43."agentLabel VT"   AS "hospitalLabel_dbid VT"
    FROM "HORG-FR_HISTORY"."HORG-FR_000026_history" AS t26
      JOIN "HORG-FR_HISTORY"."AgentIdentification_history" AS t43 ON ("T0005_dbid" = "agentIdentification_dbid")
;

-- =================================== HORG-FR_000027::Identificateur d'une unité
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."UnitIdentification_history" AS
    SELECT t27."T0007_dbid" AS "unitIdentification_dbid", t27.vt AS "unitIdentification_dbid VT",
      t43."agentId_dbid" AS "unitId_dbid",
      t43."agentId"      AS "unitId",
      t43."agentId VT"   AS "unitId_dbid VT",
      t43."agentLabel_dbid" AS "unitLabel_dbid",
      t43."agentLabel"      AS "unitLabel",
      t43."agentLabel VT"   AS "unitLabel_dbid VT",
      t2726.vt AS "unitIdentification-hospitalIdentification vt",
      t26."hospitalIdentification_dbid",
      t26."hospitalIdentification_dbid VT",
      t26."hospitalId_dbid",
      t26."hospitalId",
      t26."hospitalId_dbid VT",
      t26."hospitalLabel_dbid",
      t26."hospitalLabel",
      t26."hospitalLabel_dbid VT"
    FROM "HORG-FR_HISTORY"."HORG-FR_000027_history" AS t27
      JOIN "HORG-FR_HISTORY"."AgentIdentification_history" AS t43 ON ("T0007_dbid" = "agentIdentification_dbid")
      JOIN "HORG-FR_HISTORY"."HORG-FR_000027_HORG-FR_000028_HORG-FR_000026_history" AS t2726 USING("T0007_dbid")
      JOIN "HORG-FR_HISTORY"."HospitalIdentification_history" AS t26 ON("T0005_dbid" = "hospitalIdentification_dbid")
;
-- =================================== HORG-FR_000004
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."Hospital_history" AS
  SELECT "T0006_dbid" AS "hospital_dbid", t04.vt AS "hospital_dbid VT",
    t0426.vt AS "hospital-hospitalidentification VT",
    t26."hospitalIdentification_dbid",
    t26."hospitalIdentification_dbid VT",
    t26."hospitalId_dbid",
    t26."hospitalId",
    t26."hospitalId_dbid VT",
    t26."hospitalLabel_dbid",
    t26."hospitalLabel",
    t26."hospitalLabel_dbid VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000004_history" AS t04
    JOIN "HORG-FR_HISTORY"."HORG-FR_000004_HORG-FR_000042_HORG-FR_000026_history" AS t0426 USING ("T0006_dbid")
    JOIN "HORG-FR_HISTORY"."HospitalIdentification_history" AS t26 ON("hospitalIdentification_dbid" = "T0005_dbid")
;
-- ===================================  OrganizationalUnit
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."Unit_history" AS
 SELECT tOrg."T0002_dbid" AS "unit_dbid", tOrg.vt AS "unit_dbid VT",
   tUnit27.vt AS "unit-unitIdentification VT",
   t27."unitIdentification_dbid",
   t27."unitIdentification_dbid VT",
   t27."hospitalIdentification_dbid",
   t27."hospitalIdentification_dbid VT",
   t27."hospitalId_dbid",
   t27."hospitalId",
   t27."hospitalId_dbid VT",
   t27."unitId_dbid",
   t27."unitId",
   t27."unitId_dbid VT",
   t27."unitLabel_dbid",
   t27."unitLabel",
   t27."unitLabel_dbid VT"
 FROM "HORG-FR_HISTORY"."OrganizationalUnit_history" AS tOrg
   JOIN "HORG-FR_HISTORY"."OrganizationalUnit_HORG-FR_000042_HORG-FR_000027_history" AS tUnit27 USING ("T0002_dbid")
   JOIN "HORG-FR_HISTORY"."UnitIdentification_history" AS t27 ON ("T0007_dbid" = "unitIdentification_dbid")
;
-- =================================== HORG-FR_000005
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."HealthcareDivision_history" AS
  SELECT t05."T0008_dbid" AS "division_dbid", t05.vt AS "division_dbid VT",
    tOrg."unitIdentification_dbid",
    tOrg."unitIdentification_dbid VT",
    tOrg."hospitalId" AS "divisionHospitalId",
    tOrg."hospitalId_dbid VT" AS "divisionHospitalId_dbid VT",
    tOrg."unitId"         AS "divisionId",
    tOrg."unitId_dbid VT" AS "divisionId_dbid VT",
    tOrg."unitLabel_dbid"    AS "divisionLabel_dbid",
    tOrg."unitLabel"         AS "divisionLabel",
    tOrg."unitLabel_dbid VT" AS "divisionLabel_dbid VT",
    t0504.vt AS "division-hospital VT",
    superUnit."hospital_dbid",
    superUnit."hospitalId",
    superUnit."hospitalId_dbid VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000005_history" AS t05
    JOIN "HORG-FR_HISTORY"."Unit_history" AS tOrg ON ("T0008_dbid" = "unit_dbid")
    JOIN "HORG-FR_HISTORY"."HORG-FR_000005_unitOf_HORG-FR_000004_history" AS t0504 USING ("T0008_dbid")
    JOIN "HORG-FR_HISTORY"."Hospital_history" AS superUnit ON ("T0006_dbid" = "hospital_dbid")
;
-- =================================== HORG-FR_000006
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."ServiceDepartement_history" AS
  SELECT t06."T000b_dbid" AS "serviceDepartement_dbid", t06.vt AS "serviceDepartement_dbid VT",
    tOrg."unitIdentification_dbid",
    tOrg."unitIdentification_dbid VT",
    tOrg."hospitalId" AS "serviceDepartmentHospitalId",
    tOrg."hospitalId_dbid VT" AS "serviceDepartementHospitalId VT",
    tOrg."unitId"         AS "serviceDepartmentId",
    tOrg."unitId_dbid VT" AS "serviceDepartmentId_dbid VT",
    tOrg."unitLabel_dbid"    AS "serviceDepartmentLabel_dbid",
    tOrg."unitLabel"         AS "serviceDepartmentLabel",
    tOrg."unitLabel_dbid VT" AS "serviceDepartmentLabel_dbid VT",
    t0604.vt AS "ServiceDepartement-hospital VT",
    superUnit."hospital_dbid",
    superUnit."hospitalId",
    superUnit."hospitalId_dbid VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000006_history" AS t06
    JOIN "HORG-FR_HISTORY"."Unit_history" AS tOrg ON ("T000b_dbid" = "unit_dbid")
    JOIN "HORG-FR_HISTORY"."HORG-FR_000006_unitOf_HORG-FR_000004_history" AS t0604 USING ("T000b_dbid")
    JOIN "HORG-FR_HISTORY"."Hospital_history" AS superUnit ON ("T0006_dbid" = "hospital_dbid")
;
-- ===================================
-- Lien entre service et pole
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."ServiceDepartement-linkedTo-Division_history" AS
  SELECT service."serviceDepartement_dbid",
    service."serviceDepartmentHospitalId",
    service."serviceDepartmentId",
    service."serviceDepartement_dbid VT",
    division."division_dbid",
    division."divisionHospitalId",
    division."divisionId",
    division."division_dbid VT",
    t0604.vt AS "service-division VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000006_linkedTo_HORG-FR_000005_history" AS t0604
    JOIN "HORG-FR_HISTORY"."HealthcareDivision_history" AS division ON ("T0008_dbid" = "division_dbid")
    JOIN "HORG-FR_HISTORY"."ServiceDepartement_history" AS service ON ("T000b_dbid" = "serviceDepartement_dbid")
;
-- =================================== HORG-FR_0000009
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."ManagementUnit_history" AS
  SELECT "T0001_dbid" AS "managementUnit_dbid", t09.vt AS "managementUnit_dbid VT",
    tOrg."unitIdentification_dbid",
    tOrg."unitIdentification_dbid VT",
    tOrg."hospitalId" AS "managementUnitHospitalId",
    tOrg."hospitalId_dbid VT" AS "managementUnitHospital_dbid VT",
    tOrg."unitId"         AS "managementUnitId",
    tOrg."unitId_dbid VT" AS "managementUnitId_dbid VT",
    tOrg."unitLabel_dbid"    AS "managementUnitLabel_dbid",
    tOrg."unitLabel"         AS "managementUnitLabel",
    tOrg."unitLabel_dbid VT" AS "managementUnitLabel_dbid VT",
    superUnit."division_dbid",
    superUnit."division_dbid VT",
    superUnit."divisionId",
    superUnit."divisionId_dbid VT",
    superUnit."divisionLabel_dbid",
    superUnit."divisionLabel",
    superUnit."divisionLabel_dbid VT",
    t1605.vt AS "managementUnit-division VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000009_history" AS t09
    JOIN "HORG-FR_HISTORY"."Unit_history" AS tOrg ON("T0001_dbid" = "unit_dbid")
    JOIN "HORG-FR_HISTORY"."HORG-FR_000009_unitOf_HORG-FR_000005_history" AS t1605 USING ("T0001_dbid")
    JOIN "HORG-FR_HISTORY"."HealthcareDivision_history" AS superUnit ON ("T0008_dbid" = "division_dbid")
;
-- =================================== HORG-FR_0000017
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."MedicalSpeciality" AS
  SELECT t17."T000c_dbid" "medicalSpeciality_dbid", t17.vt AS "medicalSpeciality_dbid VT",
    t17id."T001c_dbid" AS "medicalSpecialityCode_dbid",
    code."MEDICALSPECODE" AS "medicalSpecialityCode",
    t17label."T0011_dbid" AS "medicalSpecialityLabel_dbid",
    label.string AS "medicalSpecialityLabel"
  FROM "HORG-FR_HISTORY"."HORG-FR_000017_history" AS t17
    JOIN "HORG-FR_HISTORY"."HORG-FR_000017_HORG-FR_000000_MEDICALSPECODE_history" AS t17id USING("T000c_dbid", vt)
    JOIN "HORG-FR_HISTORY"."T001c" AS code USING("T001c_dbid")
    JOIN "HORG-FR_HISTORY"."HORG-FR_000017_HORG-FR_000001_string_history" AS t17label USING ("T000c_dbid", vt)
    JOIN "HORG-FR_HISTORY"."T0011" AS label USING ("T0011_dbid")
;
-- =================================== HORG-FR_0000016
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."FunctionalUnit_history" AS
  SELECT "T000a_dbid" AS "functionalUnit_dbid", t16.vt AS "functionalUnit_dbid VT",
    tOrg."unitIdentification_dbid",
    tOrg."unitIdentification_dbid VT",
    tOrg."hospitalId" AS "functionalUnitHospitalId",
    tOrg."hospitalId_dbid VT" AS "functionalUnitHospitalId_dbid VT",
    tOrg."unitId"         AS "functionalUnitId",
    tOrg."unitId_dbid VT" AS "functionalUnitId_dbid VT",
    tOrg."unitLabel_dbid"    AS "functionalUnitLabel_dbid",
    tOrg."unitLabel"         AS "functionalUnitLabel",
    tOrg."unitLabel_dbid VT" AS "functionalUnitLabel_dbid VT",
    t1605.vt AS "functionalUnit-division VT",
    division."division_dbid",
    division."division_dbid VT",
    division."divisionId",
    division."divisionId_dbid VT",
    division."divisionLabel",
    division."divisionLabel_dbid VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_history" AS t16
    JOIN "HORG-FR_HISTORY"."Unit_history" AS tOrg ON("T000a_dbid" = "unit_dbid")
    JOIN "HORG-FR_HISTORY"."HORG-FR_000016_unitOf_HORG-FR_000005_history" AS t1605 USING ("T000a_dbid")
    JOIN "HORG-FR_HISTORY"."HealthcareDivision_history" AS division ON ("T0008_dbid" = "division_dbid")
;
-- ===================================
-- Liens entre spécialité et unité fonctionnelles
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."FunctionalUnit-Speciality_history" AS
  SELECT tUnit."functionalUnit_dbid",
    tUnit."functionalUnitHospitalId",
    tUnit."functionalUnitId",
    tUnit."functionalUnit_dbid VT",
    spe."medicalSpeciality_dbid",
    spe."medicalSpecialityCode",
    spe."medicalSpeciality_dbid VT",
    t1617.vt AS "functionalUnit-MedicalSpeciality VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_HORG-FR_000028_HORG-FR_000017_history" AS t1617
    JOIN "HORG-FR_HISTORY"."FunctionalUnit_history" AS tUnit ON ("T000a_dbid" = "functionalUnit_dbid")
    JOIN "HORG-FR_HISTORY"."MedicalSpeciality" AS spe ON ("T000c_dbid" = "medicalSpeciality_dbid")
;
-- ===================================
-- Liens entre unité fonctionnelles et services
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."FunctionalUnit-Service_history" AS
  SELECT tUnit."functionalUnit_dbid",
    tUnit."functionalUnitHospitalId",
    tUnit."functionalUnitId",
    tUnit."functionalUnit_dbid VT",
    serv."serviceDepartement_dbid",
    serv."serviceDepartmentHospitalId",
    serv."serviceDepartmentId",
    serv."serviceDepartement_dbid VT",
    t1606.vt AS "functionalUnit-service VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000006_history" AS t1606
    JOIN "HORG-FR_HISTORY"."FunctionalUnit_history" AS tUnit ON ("T000a_dbid" = "functionalUnit_dbid")
    JOIN "HORG-FR_HISTORY"."ServiceDepartement_history" AS serv ON ("T000b_dbid" = "serviceDepartement_dbid")
;
-- ===================================
-- Liens entre unité fonctionnelles et unité de gestion
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."FunctionalUnit-ManagementUnit_history" AS
  SELECT funUnit."functionalUnit_dbid",
    funUnit."functionalUnitHospitalId",
    funUnit."functionalUnitId",
    funUnit."functionalUnit_dbid VT",
    mgeUnit."managementUnit_dbid",
    mgeUnit."managementUnitHospitalId",
    mgeUnit."managementUnitId",
    mgeUnit."managementUnit_dbid VT",
    t1609.vt AS "functionalUnit-managementUnit VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000009_history" AS t1609
    JOIN "HORG-FR_HISTORY"."FunctionalUnit_history" AS funUnit ON ("T000a_dbid" = "functionalUnit_dbid")
    JOIN "HORG-FR_HISTORY"."ManagementUnit_history" AS mgeUnit ON ("T0001_dbid" = "managementUnit_dbid")
;
-- =================================== HORG-FR_0000011
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history" AS
  SELECT "T0010_dbid" AS "medicoAdministrativeUnit_dbid", t11.vt AS "medicoAdministrativeUnit_dbid VT",
    tOrg."unitIdentification_dbid",
    tOrg."unitIdentification_dbid VT",
    tOrg."hospitalId" AS "medicoAdministrativeUnitHospitalId",
    tOrg."hospitalId_dbid VT" AS "medicoAdministrativeUnitHospitalId_dbid VT",
    tOrg."unitId"         AS "medicoAdministrativeUnitId",
    tOrg."unitId_dbid VT" AS "medicoAdministrativeUnitId_dbid VT",
    tOrg."unitLabel_dbid"    AS "medicoAdministrativeUnitLabel_dbid",
    tOrg."unitLabel"         AS "medicoAdministrativeUnitLabel",
    tOrg."unitLabel_dbid VT" AS "medicoAdministrativeUnitLabel_dbid VT",
    superUnit."managementUnit_dbid",
    superUnit."managementUnit_dbid VT",
    superUnit."managementUnitId",
    superUnit."managementUnitId_dbid VT",
    superUnit."managementUnitLabel",
    superUnit."managementUnitLabel_dbid VT",
    t1109.vt AS "medicaAdministrativeUnit-managementUnit VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000011_history" AS t11
    JOIN "HORG-FR_HISTORY"."Unit_history" AS tOrg ON("T0010_dbid" = "unit_dbid")
    JOIN "HORG-FR_HISTORY"."HORG-FR_000011_unitOf_HORG-FR_000009_history" AS t1109 USING ("T0010_dbid")
    JOIN "HORG-FR_HISTORY"."ManagementUnit_history" AS superUnit ON ("T0001_dbid" = "managementUnit_dbid")
;

-- =================================== HORG-FR_0000025
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."AdministrativeUnit_history" AS
 SELECT "T0004_dbid" AS "administrativeUnit_dbid", t11.vt AS "administrativeUnit_dbid VT",
   tOrg."unitIdentification_dbid",
   tOrg."unitIdentification_dbid VT",
   tOrg."hospitalId"         AS "administrativeUnitHospitalId",
   tOrg."hospitalId_dbid VT" AS "administrativeUnitHospital_dbid VT",
   tOrg."unitId"         AS "administrativeUnitId",
   tOrg."unitId_dbid VT" AS "administrativeUnitId VT",
   tOrg."unitLabel_dbid"    AS "administrativeUnitLabel_dbid",
   tOrg."unitLabel"         AS "administrativeUnitLabel",
   tOrg."unitLabel_dbid VT" AS "administrativeUnitLabel_dbid VT",
   superUnit."managementUnit_dbid",
   superUnit."managementUnit_dbid VT",
   superUnit."managementUnitId",
   superUnit."managementUnitId_dbid VT",
   superUnit."managementUnitLabel",
   superUnit."managementUnitLabel_dbid VT",
   t1109.vt AS "medicaAdministrativeUnit-managementUnit VT"
 FROM "HORG-FR_HISTORY"."HORG-FR_000025_history" AS t11
   JOIN "HORG-FR_HISTORY"."Unit_history" AS tOrg ON("T0004_dbid" = "unit_dbid")
   JOIN "HORG-FR_HISTORY"."HORG-FR_000025_unitOf_HORG-FR_000009_history" AS t1109 USING ("T0004_dbid")
   JOIN "HORG-FR_HISTORY"."ManagementUnit_history" AS superUnit ON ("T0001_dbid" = "managementUnit_dbid")
;
-- =================================== HORG-FR_000017 Discipline
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."MedicalDiscipline" AS
  SELECT t17."T000d_dbid" "medicalDiscipline_dbid", t17.vt AS "medicalDiscipline_dbid VT",
    t17id."T0015_dbid" AS "medicalDisciplineCode_dbid",
    code."DISCIPLINECODE" AS "medicalDisciplineCode",
    t17label."T0011_dbid" AS "medicalDisciplineLabel_dbid",
    label.string AS "medicalDisciplineLabel"
  FROM "HORG-FR_HISTORY"."HORG-FR_000039_history" AS t17
    JOIN "HORG-FR_HISTORY"."HORG-FR_000039_HORG-FR_000000_DISCIPLINECODE_history" AS t17id USING("T000d_dbid", vt)
    JOIN "HORG-FR_HISTORY"."T0015" AS code USING("T0015_dbid")
    JOIN "HORG-FR_HISTORY"."HORG-FR_000039_HORG-FR_000001_string_history" AS t17label USING ("T000d_dbid", vt)
    JOIN "HORG-FR_HISTORY"."T0011" AS label USING ("T0011_dbid")
;
-- ===================================
-- Liens entre unité administratives et les disciplines
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."AdministrativeUnit-Discipline_history" AS
  SELECT tUnit."administrativeUnit_dbid",
    tUnit."administrativeUnitHospitalId",
    tUnit."administrativeUnitId",
    tUnit."administrativeUnit_dbid VT",
    spe."medicalDiscipline_dbid",
    spe."medicalDisciplineCode",
    spe."medicalDisciplineLabel",
    spe."medicalDiscipline_dbid VT",
    t1617.vt AS "administrativeUnit-MedicalDiscipline VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000025_HORG-FR_000028_HORG-FR_000039_history" AS t1617
    JOIN "HORG-FR_HISTORY"."AdministrativeUnit_history" AS tUnit ON ("T0004_dbid" = "administrativeUnit_dbid")
    JOIN "HORG-FR_HISTORY"."MedicalDiscipline" AS spe ON ("T000d_dbid" = "medicalDiscipline_dbid")
;
-- ===================================
-- Liens entre unité administratives et les services
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."AdministrativeUnit-Service_history" AS
  SELECT tUnit."administrativeUnit_dbid",
    tUnit."administrativeUnitHospitalId",
    tUnit."administrativeUnitId",
    tUnit."administrativeUnit_dbid VT",
    serv."serviceDepartement_dbid",
    serv."serviceDepartmentHospitalId",
    serv."serviceDepartmentId",
    serv."serviceDepartement_dbid VT",
    t2506.vt AS "administrativeUnit-service VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000006_history" AS t2506
    JOIN "HORG-FR_HISTORY"."AdministrativeUnit_history" AS tUnit ON ("T0004_dbid" = "administrativeUnit_dbid")
    JOIN "HORG-FR_HISTORY"."ServiceDepartement_history" AS serv ON ("T000b_dbid" = "serviceDepartement_dbid")
;
-- ===================================
-- Liens entre unité administratives et les unités médico-administratives
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."AdministrativeUnit-MedicoAdministrativeUnit_history" AS
  SELECT tUnit."administrativeUnit_dbid",
    tUnit."administrativeUnitHospitalId",
    tUnit."administrativeUnitId",
    tUnit."administrativeUnit_dbid VT",
    serv."medicoAdministrativeUnit_dbid",
    serv."medicoAdministrativeUnitHospitalId",
    serv."medicoAdministrativeUnitId",
    serv."medicoAdministrativeUnit_dbid VT",
    t2506.vt AS "administrativeUnit-service VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000011_history" AS t2506
    JOIN "HORG-FR_HISTORY"."AdministrativeUnit_history" AS tUnit ON ("T0004_dbid" = "administrativeUnit_dbid")
    JOIN "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history" AS serv ON ("T0010_dbid" = "medicoAdministrativeUnit_dbid")
;
-- =================================== HORG-FR_000012
--
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."HospitalizationUnit_history" AS
  SELECT "T0003_dbid" AS "hospitalizationUnit_dbid", t12.vt AS "hospitalizationUnit_dbid VT",
    tOrg."unitIdentification_dbid",
    tOrg."unitIdentification_dbid VT",
    tOrg."hospitalId"         AS "hospitalizationUnitHospitalId",
    tOrg."hospitalId_dbid VT" AS "hospitalizationUnitHospital_dbid VT",
    tOrg."unitId"         AS "hospitalizationUnitId",
    tOrg."unitId_dbid VT" AS "hospitalizationUnitId_dbid VT",
    tOrg."unitLabel_dbid"    AS "hospitalizationUnitLabel_dbid",
    tOrg."unitLabel"         AS "hospitalizationUnitLabel",
    tOrg."unitLabel_dbid VT" AS "hospitalizationUnitLabel_dbid VT",
    superUnit."medicoAdministrativeUnit_dbid",
    superUnit."medicoAdministrativeUnit_dbid VT",
    superUnit."medicoAdministrativeUnitId",
    superUnit."medicoAdministrativeUnitId_dbid VT",
    superUnit."medicoAdministrativeUnitLabel",
    superUnit."medicoAdministrativeUnitLabel_dbid VT",
    t1211.vt AS "hospitalizationUnit-medicaAdministrativeUnit VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000012_history" AS t12
    JOIN "HORG-FR_HISTORY"."Unit_history" AS tOrg ON("T0003_dbid" = "unit_dbid")
    JOIN "HORG-FR_HISTORY"."HORG-FR_000012_unitOf_HORG-FR_000011_history" AS t1211 USING ("T0003_dbid")
    JOIN "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history" AS superUnit ON ("T0010_dbid" = "medicoAdministrativeUnit_dbid")
;
-- ===================================
-- Liens entre unité d'hospitalisation et les services
CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."HospitalizationUnit-Service_history" AS
  SELECT tUnit."hospitalizationUnit_dbid",
    tUnit."hospitalizationUnitHospitalId",
    tUnit."hospitalizationUnitId",
    tUnit."hospitalizationUnit_dbid VT",
    serv."serviceDepartement_dbid",
    serv."serviceDepartmentHospitalId",
    serv."serviceDepartmentId",
    serv."serviceDepartement_dbid VT",
    t1206.vt AS "hospitalizationUnit-service VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000006_history" AS t1206
    JOIN "HORG-FR_HISTORY"."HospitalizationUnit_history" AS tUnit ON ("T0003_dbid" = "hospitalizationUnit_dbid")
    JOIN "HORG-FR_HISTORY"."ServiceDepartement_history" AS serv ON ("T000b_dbid" = "serviceDepartement_dbid")
;
-- ===================================
-- Liens entre unité d'hospitalisation et les unité administratives

CREATE OR REPLACE VIEW "HORG-FR_HISTORY"."HospitalizationUnit-AdministrativeUnit_history" AS
  SELECT tUnit."hospitalizationUnit_dbid",
    tUnit."hospitalizationUnitHospitalId",
    tUnit."hospitalizationUnitId",
    tUnit."hospitalizationUnit_dbid VT",
    serv."administrativeUnit_dbid",
    serv."administrativeUnitHospitalId",
    serv."administrativeUnitId",
    serv."administrativeUnit_dbid VT",
    t1225.vt AS "hospitalizationUnit-administrativeUnit VT"
  FROM "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000025_history" AS t1225
    JOIN "HORG-FR_HISTORY"."HospitalizationUnit_history" AS tUnit ON ("T0003_dbid" = "hospitalizationUnit_dbid")
    JOIN "HORG-FR_HISTORY"."AdministrativeUnit_history" AS serv ON ("T0004_dbid" = "administrativeUnit_dbid")
;
