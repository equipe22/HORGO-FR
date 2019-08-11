/* ================================================================================================
 Les fonctions de création de structure et de validation de structure.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
 Références :
   https://explainextended.com/2009/09/24/adjacency-list-vs-nested-sets-postgresql/
================================================================================================ */
SET SCHEMA 'HORG-FR_HISTORY';

/*
	TraceNivSupDir (c : Unité, p : Période) :
REL {u : Unité, q : Période} USING q : KEY {u} CONS N3C3R
DEF (USING q : { (u,q) | (c est une sous-unité directe de u) }) WHERE p ∩ q ≠ {}
*/
/**
 * Construire une structure du niveau supérieure directe d'une unité valide durant une période spécifiée.
 */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureNivSupDirect"
  (_unitCategoryAcronyme "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
   _unitId "HORG-FR_HISTORY"."AGENTID",
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
    WITH sub AS
    (  SELECT *
       FROM "HORG-FR_HISTORY"."ALL_structure"
       WHERE id = _unitId
        AND validtime && _period
        AND (unitcategory_en = _unitCategoryAcronyme OR unitcategory_fr = _unitCategoryAcronyme)
    ), sup AS
    (  SELECT *
       FROM "HORG-FR_HISTORY"."ALL_structure"
       WHERE (hospitalid, id) IN (SELECT hospitalid, supid FROM sub WHERE validtime && _period)
    )SELECT * FROM sub UNION SELECT * FROM sup;
  $$
  LANGUAGE SQL;

CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureNivSupDirect"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID",
   _unitCategoryAcronyme "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
   _unitId "HORG-FR_HISTORY"."AGENTID",
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
    WITH sub AS
    (  SELECT *
       FROM "HORG-FR_HISTORY"."ALL_structure"
       WHERE id = _unitId
        AND hospitalId = _hospitalId
        AND validtime && _period
        AND (unitcategory_en = _unitCategoryAcronyme OR unitcategory_fr = _unitCategoryAcronyme)
    ), sup AS
    (  SELECT *
       FROM "HORG-FR_HISTORY"."ALL_structure"
       WHERE (hospitalid, id) IN (SELECT hospitalid, supid FROM sub WHERE validtime && _period)
    )SELECT * FROM sub UNION SELECT * FROM sup;
  $$
  LANGUAGE SQL;

/*
-- Examples
SELECT *
FROM "HORG-FR_HISTORY"."structureNivSupDirect"('UF', '224', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivSupDirect"('UF', '006', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivSupDirect"('075', 'UF', '006', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivSupDirect"('UMA', '630', daterange('2001-01-01', '2018-01-01', '[]'));
*/

/**
 * Construire une structure du niveau supérieure indirecte d'une unité valide durant une période spécifiée.
 */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureNivSupUndirect"
  (_unitCategoryAcronyme "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
   _unitId "HORG-FR_HISTORY"."AGENTID",
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
    WITH RECURSIVE struc AS
    (
      SELECT *
      FROM "HORG-FR_HISTORY"."ALL_structure"
      WHERE id = _unitId
        AND validtime && _period
        AND (unitcategory_en = _unitCategoryAcronyme OR unitcategory_fr = _unitCategoryAcronyme)
      UNION
      SELECT sup.*
      FROM struc JOIN "HORG-FR_HISTORY"."ALL_structure" AS sup
       ON (sup.hospitalid = struc.hospitalid AND sup.dbid = struc.supdbid AND sup.validtime && _period)
    )
    SELECT * FROM struc
  $$
  LANGUAGE SQL;

CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureNivSupUndirect"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID",
   _unitCategoryAcronyme "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
   _unitId "HORG-FR_HISTORY"."AGENTID",
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
    WITH RECURSIVE struc AS
    (
      SELECT *
      FROM "HORG-FR_HISTORY"."ALL_structure"
      WHERE id = _unitId
        AND hospitalId = _hospitalId
        AND validtime && _period
        AND (unitcategory_en = _unitCategoryAcronyme OR unitcategory_fr = _unitCategoryAcronyme)
      UNION
      SELECT sup.*
      FROM struc JOIN "HORG-FR_HISTORY"."ALL_structure" AS sup
       ON (sup.hospitalid = struc.hospitalid AND sup.dbid = struc.supdbid AND sup.validtime && _period)
    )
    SELECT * FROM struc
  $$
  LANGUAGE SQL;

/*
-- Examples
SELECT *
FROM "HORG-FR_HISTORY"."structureNivSupUndirect"('UF', '224', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivSupUndirect"('UMA', '630', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivSupUndirect"('UF', '006', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivSupUndirect"('075', 'UF', '006', daterange('2001-01-01', '2018-01-01', '[]'));
*/

/*
	TraceNivInfDir (c : Unité, p : Période) :
REL {u : Unité, q : Période} USING q : KEY {u} CONS N3C3R
DEF (USING q : { (u,q) | (u est une sous-unité directe de c) }) WHERE p ∩ q ≠ {}
*/
/**
 * Construire une structure du niveau inférieure directe d'une unité valide durant une période spécifiée.
 */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureNivInfDirect"
  (_unitCategoryAcronyme "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
   _unitId "HORG-FR_HISTORY"."AGENTID",
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
    WITH sup AS
    (  SELECT *
       FROM "HORG-FR_HISTORY"."ALL_structure"
       WHERE id = _unitId
        AND validtime && _period
        AND (unitcategory_en = _unitCategoryAcronyme OR unitcategory_fr = _unitCategoryAcronyme)
    ), sub AS
    (  SELECT *
       FROM "HORG-FR_HISTORY"."ALL_structure"
       WHERE (hospitalid, supId) IN (SELECT hospitalid, id FROM sup WHERE validtime && _period)
    )SELECT * FROM sup UNION SELECT * FROM sub;
  $$
  LANGUAGE SQL;

CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureNivInfDirect"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID",
   _unitCategoryAcronyme "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
   _unitId "HORG-FR_HISTORY"."AGENTID",
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
    WITH sup AS
    (  SELECT *
       FROM "HORG-FR_HISTORY"."ALL_structure"
       WHERE id = _unitId
        AND hospitalId = _hospitalId
        AND validtime && _period
        AND (unitcategory_en = _unitCategoryAcronyme OR unitcategory_fr = _unitCategoryAcronyme)
    ), sub AS
    (  SELECT *
       FROM "HORG-FR_HISTORY"."ALL_structure"
       WHERE (hospitalid, supId) IN (SELECT hospitalid, id FROM sup WHERE validtime && _period)
    )SELECT * FROM sup UNION SELECT * FROM sub;
  $$
  LANGUAGE SQL;

/*
-- Exemple
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfDirect"('UF', '224', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfDirect"('UF', '006', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfDirect"('075', 'UF', '006', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfDirect"('UMA', '630', daterange('2001-01-01', '2018-01-01', '[]'));
*/
/**
 * Construire une structure du niveau inférieure (indirecte) d'une unité valide durant une période spécifiée.
 */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureNivInfUndirect"
  (_unitCategoryAcronyme "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
   _unitId "HORG-FR_HISTORY"."AGENTID",
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
    WITH RECURSIVE struc AS
    (
      SELECT *
      FROM "HORG-FR_HISTORY"."ALL_structure"
      WHERE id = _unitId
        AND validtime && _period
        AND (unitcategory_en = _unitCategoryAcronyme OR unitcategory_fr = _unitCategoryAcronyme)
      UNION
      SELECT sub.*
      FROM struc JOIN "HORG-FR_HISTORY"."ALL_structure" AS sub
       ON (sub.hospitalid = struc.hospitalid AND sub.supdbid = struc.dbid AND sub.validtime && _period)
    )
    SELECT * FROM struc
  $$
  LANGUAGE SQL;

CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureNivInfUndirect"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID",
   _unitCategoryAcronyme "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
   _unitId "HORG-FR_HISTORY"."AGENTID",
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
    WITH RECURSIVE struc AS
    (
      SELECT *
      FROM "HORG-FR_HISTORY"."ALL_structure"
      WHERE id = _unitId
        AND hospitalId = _hospitalId
        AND validtime && _period
        AND (unitcategory_en = _unitCategoryAcronyme OR unitcategory_fr = _unitCategoryAcronyme)
      UNION
      SELECT sub.*
      FROM struc JOIN "HORG-FR_HISTORY"."ALL_structure" AS sub
       ON (sub.hospitalid = struc.hospitalid AND sub.supdbid = struc.dbid AND sub.validtime && _period)
    )
    SELECT * FROM struc
  $$
  LANGUAGE SQL;

/*
-- Exemple
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfUndirect"('UF', '224', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfUndirect"('UF', '006', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfUndirect"('075', 'UF', '006', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfUndirect"('UMA', '630', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfUndirect"('075', 'UG', '0121', daterange('2001-01-01', '2018-01-01', '[]'));
SELECT *
FROM "HORG-FR_HISTORY"."structureNivInfUndirect"('UG', '0121', daterange('2001-01-01', '2018-01-01', '[]'));
*/

/*
	TraceNivInfNT (c : Unité, p : Période) :
REL {u : Unité, q : Période} USING q : KEY {u} CONS N3C3R
DEF (USING q : { (u,q) | (u est une sous-unité non triviale de c) }) WHERE p ∩ q ≠ {}
*/
/*
	TraceComposition (c : Unité, p : Période) :
REL {gu : EnsUnité, q : Période} USING q : KEY {gu} CONS N3C3R
EQV PACK q : (UNPACK q : TraceNivInfNT(c,p)) GROUP u AS gu BY q
 */

/**
 * Contruire une structure selon une spécialité valide durant une période spécifiée.
 * Une unité retenue si sa période de validité chevauche la période spécifiée.
 * Les spécialités sont associées aux unités fonctionnlles. Alors la requête récupère
 * Toutes les unité fonctionnelles pour la spécialité spécifiée et construit la structure
 * complète.
 *
 * Build unit structure by medical speciality for the specified period.
 * A unit is retained if its valid time overlaps the specified period.
 **/
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureBySpeciality"
  (_medSpe TEXT,
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
  DECLARE
    unitSet RECORD;
  BEGIN
    FOR unitSet IN
    (
      SELECT
        "MedicalSpeciality"."medicalSpeciality_dbid",
        "functionalUnitId" unitId,
        "functionalUnit-MedicalSpeciality VT"
      FROM "HORG-FR_HISTORY"."MedicalSpeciality"
        JOIN "HORG-FR_HISTORY"."FunctionalUnit-Speciality_history"
          USING ("medicalSpecialityCode", "medicalSpeciality_dbid VT")
      WHERE "medicalSpecialityLabel" LIKE '%' || _medSpe || '%'
        AND "functionalUnit-MedicalSpeciality VT" && _period
    )
    LOOP
      RETURN QUERY
        SELECT *
        FROM "HORG-FR_HISTORY"."structureNivSupUndirect"('UF', unitSet.unitId, _period)
        UNION
        SELECT *
        FROM "HORG-FR_HISTORY"."structureNivInfUndirect"('UF', unitSet.unitId, _period);
    END LOOP;
  END;
  $$
  LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."structureBySpeciality"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID",
   _medSpe TEXT,
   _period "HORG-FR_HISTORY"."PERIOD")
  RETURNS SETOF "HORG-FR_HISTORY"."ALL_structure" AS
  $$
  DECLARE
    unitSet RECORD;
  BEGIN
    FOR unitSet IN
    (
      SELECT
        "MedicalSpeciality"."medicalSpeciality_dbid",
        "functionalUnitId" unitId,
        "functionalUnit-MedicalSpeciality VT"
      FROM "HORG-FR_HISTORY"."MedicalSpeciality"
        JOIN "HORG-FR_HISTORY"."FunctionalUnit-Speciality_history"
          USING ("medicalSpecialityCode", "medicalSpeciality_dbid VT")
      WHERE "medicalSpecialityLabel" LIKE '%' || _medSpe || '%'
        AND "functionalUnit-MedicalSpeciality VT" && _period
    )
    LOOP
      RETURN QUERY
        SELECT *
        FROM "HORG-FR_HISTORY"."structureNivSupUndirect"(_hospitalId, 'UF', unitSet.unitId, _period)
        UNION
        SELECT *
        FROM "HORG-FR_HISTORY"."structureNivInfUndirect"(_hospitalId, 'UF', unitSet.unitId, _period);
    END LOOP;
  END;
  $$
  LANGUAGE 'plpgsql';
/*
-- Exemple
SELECT DISTINCT *
FROM "HORG-FR_HISTORY"."hegp_structureBySpeciality"('NUTRITION', daterange('2016-01-01', '2018-01-01', '[]'))
ORDER BY level;

SELECT DISTINCT *
FROM "HORG-FR_HISTORY"."structureBySpeciality"('075', 'NUTRITION', daterange('2016-01-01', '2018-01-01', '[]'))
ORDER BY level;

SELECT DISTINCT *
FROM "HORG-FR_HISTORY"."structureBySpeciality"('NUTRITION', daterange('2016-01-01', '2018-01-01', '[]'))
ORDER BY level;

SELECT DISTINCT *
FROM "HORG-FR_HISTORY"."hegp_structureBySpeciality"('CARDIO', daterange('2001-01-01', '2018-01-01', '[]'))
ORDER BY level;
*/
