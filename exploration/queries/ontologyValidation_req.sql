/* ================================================================================================
 Les fonctions de validation de l'ontologie par rapport au données.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */

-- =================================================  Validation UnifOf restrictions
--
-- VQ1: 'Healthcare division' 'unit Of' exactly 1 'Hospital'
--
WITH data AS (
  SELECT domain."T0008_dbid" domaindbid, domain.vt AS domainvt,
         range."T0006_dbid" rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000005_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000005_unitOf_HORG-FR_000004_history" AS axiom
      ON(domain."T0008_dbid" = axiom."T0008_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000004_history" AS range
      ON(range."T0006_dbid" = axiom."T0006_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS unitOfCount,
    COUNT(rangedbid) = 1 AS isUnitOf_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE isUnitOf_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE NOT isUnitOf_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = unitOfCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ2: 'Service and department' 'unit Of' exactly 1 'Hospital'
--
WITH data AS (
  SELECT domain."T000b_dbid" domaindbid, domain.vt AS domainvt,
         range."T0006_dbid" rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000006_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000006_unitOf_HORG-FR_000004_history" AS axiom
      ON(domain."T000b_dbid" = axiom."T000b_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000004_history" AS range
      ON(range."T0006_dbid" = axiom."T0006_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS unitOfCount,
    COUNT(rangedbid) = 1 AS isUnitOf_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE isUnitOf_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE NOT isUnitOf_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = unitOfCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ3: 'Functional unit' 'unit Of' exactly 1 'Healthcare division'
--
WITH data AS (
  SELECT domain."T000a_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0008_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000016_unitOf_HORG-FR_000005_history" AS axiom
      ON(domain."T000a_dbid" = axiom."T000a_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000005_history" AS range
      ON(range."T0008_dbid" = axiom."T0008_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS unitOfCount,
    COUNT(rangedbid) = 1 AS isUnitOf_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE isUnitOf_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE NOT isUnitOf_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = unitOfCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ4: 'Management unit' 'unit Of' exactly 1 'Healthcare division'
--
WITH data AS (
  SELECT domain."T0001_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0008_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000009_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000009_unitOf_HORG-FR_000005_history" AS axiom
      ON(domain."T0001_dbid" = axiom."T0001_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000005_history" AS range
      ON(range."T0008_dbid" = axiom."T0008_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS unitOfCount,
    COUNT(rangedbid) = 1 AS isUnitOf_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE isUnitOf_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE NOT isUnitOf_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = unitOfCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ5: 'Medico-administrative unit' 'unit Of' exactly 1 'Management unit'
--
WITH data AS (
  SELECT domain."T0010_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0001_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000011_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000011_unitOf_HORG-FR_000009_history" AS axiom
      ON(domain."T0010_dbid" = axiom."T0010_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000009_history" AS range
      ON(range."T0001_dbid" = axiom."T0001_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS unitOfCount,
    COUNT(rangedbid) = 1 AS isUnitOf_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE isUnitOf_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE NOT isUnitOf_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = unitOfCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ6: 'Administrative unit' 'unit Of' some 'Management unit'
--
WITH data AS (
  SELECT domain."T0004_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0001_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000025_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000025_unitOf_HORG-FR_000009_history" AS axiom
      ON(domain."T0004_dbid" = axiom."T0004_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000009_history" AS range
      ON(range."T0001_dbid" = axiom."T0001_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS unitOfCount,
    COUNT(rangedbid) = 1 AS isUnitOf_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE isUnitOf_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE NOT isUnitOf_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = unitOfCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ7: 'Hospitalization unit' 'unit Of' exactly 1 'Medico-administrative unit'
--
WITH data AS (
  SELECT domain."T0003_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0010_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000012_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000012_unitOf_HORG-FR_000011_history" AS axiom
      ON(domain."T0003_dbid" = axiom."T0003_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000011_history" AS range
      ON(range."T0010_dbid" = axiom."T0010_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS unitOfCount,
    COUNT(rangedbid) = 1 AS isUnitOf_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE isUnitOf_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isUnitOf_validCount) FROM res WHERE NOT isUnitOf_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = unitOfCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- =================================================  Validation hasUnit restrictions
--
-- VQ8: 'Hospital' 'has Unit' some 'Healthcare division'
--
WITH data AS (
  SELECT domain."T0008_dbid" domaindbid, domain.vt AS domainvt,
         range."T0006_dbid" rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000005_history" AS domain
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000005_unitOf_HORG-FR_000004_history" AS axiom
      ON(domain."T0008_dbid" = axiom."T0008_dbid")
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000004_history" AS range
      ON(range."T0006_dbid" = axiom."T0006_dbid")
), vqa AS
(
  SELECT rangedbid, COUNT(domaindbid) AS hasUnitCount,
    COUNT(domaindbid) >= 1 AS isHasUnit_validCount
  FROM data
  GROUP BY rangedbid, rangevt
)
, vqb AS
(
  SELECT rangedbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT rangedbid, COUNT(domaindbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS valid
  FULL JOIN
    (SELECT rangedbid, COUNT(domaindbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS invalid
  USING(rangedbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(rangedbid)
)
-- SELECT * FROM res
SELECT
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE isHasUnit_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE NOT isHasUnit_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = hasUnitCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ09: 'Hospital' 'has Unit' some 'Service and department'
--
WITH data AS (
  SELECT domain."T000b_dbid" domaindbid, domain.vt AS domainvt,
         range."T0006_dbid" rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000006_history" AS domain
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000006_unitOf_HORG-FR_000004_history" AS axiom
      ON(domain."T000b_dbid" = axiom."T000b_dbid")
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000004_history" AS range
      ON(range."T0006_dbid" = axiom."T0006_dbid")
), vqa AS
(
  SELECT rangedbid, COUNT(domaindbid) AS hasUnitCount,
    COUNT(domaindbid) >= 1 AS isHasUnit_validCount
  FROM data
  GROUP BY rangedbid, rangevt
)
, vqb AS
(
  SELECT rangedbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT rangedbid, COUNT(domaindbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS valid
  FULL JOIN
    (SELECT rangedbid, COUNT(domaindbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS invalid
  USING(rangedbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(rangedbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE isHasUnit_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE NOT isHasUnit_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = hasUnitCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ10: 'Healthcare division' 'has Unit' some 'Functional unit',
--
WITH data AS (
  SELECT domain."T000a_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0008_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_history" AS domain
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000016_unitOf_HORG-FR_000005_history" AS axiom
      ON(domain."T000a_dbid" = axiom."T000a_dbid")
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000005_history" AS range
      ON(range."T0008_dbid" = axiom."T0008_dbid")
), vqa AS
(
  SELECT rangedbid, COUNT(domaindbid) AS hasUnitCount,
    COUNT(domaindbid) >= 1 AS isHasUnit_validCount
  FROM data
  GROUP BY rangedbid, rangevt
)
, vqb AS
(
  SELECT rangedbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT rangedbid, COUNT(domaindbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS valid
  FULL JOIN
    (SELECT rangedbid, COUNT(domaindbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS invalid
  USING(rangedbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(rangedbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE isHasUnit_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE NOT isHasUnit_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = hasUnitCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ11: 'Healthcare division' 'has Unit' some 'Management unit'
--
WITH data AS (
  SELECT domain."T0001_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0008_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000009_history" AS domain
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000009_unitOf_HORG-FR_000005_history" AS axiom
      ON(domain."T0001_dbid" = axiom."T0001_dbid")
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000005_history" AS range
      ON(range."T0008_dbid" = axiom."T0008_dbid")
), vqa AS
(
  SELECT rangedbid, COUNT(domaindbid) AS hasUnitCount,
    COUNT(domaindbid) >= 1 AS isHasUnit_validCount --  BETWEEN 0 AND 1
  FROM data
  GROUP BY rangedbid, rangevt
)
, vqb AS
(
  SELECT rangedbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT rangedbid, COUNT(domaindbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS valid
  FULL JOIN
    (SELECT rangedbid, COUNT(domaindbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS invalid
  USING(rangedbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(rangedbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE isHasUnit_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE NOT isHasUnit_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = hasUnitCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ12: 'Management unit' 'has Unit' some 'Medico-administrative unit'
--
WITH data AS (
  SELECT domain."T0010_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0001_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000011_history" AS domain
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000011_unitOf_HORG-FR_000009_history" AS axiom
      ON(domain."T0010_dbid" = axiom."T0010_dbid")
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000009_history" AS range
      ON(range."T0001_dbid" = axiom."T0001_dbid")
), vqa AS
(
  SELECT rangedbid, COUNT(domaindbid) AS hasUnitCount,
    COUNT(domaindbid) BETWEEN 0 AND 1 AS isHasUnit_validCount -->= 1
  FROM data
  GROUP BY rangedbid, rangevt
)
, vqb AS
(
  SELECT rangedbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT rangedbid, COUNT(domaindbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS valid
  FULL JOIN
    (SELECT rangedbid, COUNT(domaindbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS invalid
  USING(rangedbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(rangedbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE isHasUnit_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE NOT isHasUnit_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = hasUnitCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ13 : 'Management unit' 'has Unit' some 'Administrative unit'
--
WITH data AS (
  SELECT domain."T0004_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0001_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000025_history" AS domain
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000025_unitOf_HORG-FR_000009_history" AS axiom
      ON(domain."T0004_dbid" = axiom."T0004_dbid")
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000009_history" AS range
      ON(range."T0001_dbid" = axiom."T0001_dbid")
), vqa AS
(
  SELECT rangedbid, COUNT(domaindbid) AS hasUnitCount,
    COUNT(domaindbid) >= 1 AS isHasUnit_validCount
  FROM data
  GROUP BY rangedbid, rangevt
)
, vqb AS
(
  SELECT rangedbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT rangedbid, COUNT(domaindbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS valid
  FULL JOIN
    (SELECT rangedbid, COUNT(domaindbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS invalid
  USING(rangedbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(rangedbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE isHasUnit_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE NOT isHasUnit_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = hasUnitCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- VQ14 : 'Medico-administrative unit' 'has Unit' some 'Hospitalization unit'
--
WITH data AS (
  SELECT domain."T0003_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0010_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000012_history" AS domain
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000012_unitOf_HORG-FR_000011_history" AS axiom
      ON(domain."T0003_dbid" = axiom."T0003_dbid")
    RIGHT JOIN "HORG-FR_HISTORY"."HORG-FR_000011_history" AS range
      ON(range."T0010_dbid" = axiom."T0010_dbid")
), vqa AS
(
  SELECT rangedbid, COUNT(domaindbid) AS hasUnitCount,
    COUNT(domaindbid) >= 1 AS isHasUnit_validCount
  FROM data
  GROUP BY rangedbid, rangevt
)
, vqb AS
(
  SELECT rangedbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT rangedbid, COUNT(domaindbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS valid
  FULL JOIN
    (SELECT rangedbid, COUNT(domaindbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY rangedbid, rangevt) AS invalid
  USING(rangedbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(rangedbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE isHasUnit_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isHasUnit_validCount) FROM res WHERE NOT isHasUnit_validCount) AS unitRestriction_invalidCount,
  (SELECT COUNT(densness_validCount) FROM res WHERE densness_validCount = hasUnitCount) AS unitDenseness_validCount,
  (SELECT COUNT(densness_invalidCount) FROM res WHERE NOT densness_invalidCount = 0) AS unitDenseness_invalidCount
;
--
-- =================================================  Validation LinkedTo restrictions
--
-- VQ15: 'Service and department' 'linked to' exactly 1 'Healthcare division'
--
WITH data AS (
  SELECT domain."T000b_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0008_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000006_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000006_linkedTo_HORG-FR_000005_history" AS axiom
      ON(domain."T000b_dbid" = axiom."T000b_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000005_history" AS range
      ON(range."T0008_dbid" = axiom."T0008_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS linkCount,
    COUNT(rangedbid) BETWEEN 0 AND 1 AS isLink_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
-- SELECT * FROM res
SELECT
  (SELECT COUNT(isLink_validCount) FROM res WHERE isLink_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isLink_validCount) FROM res WHERE NOT isLink_validCount) AS unitRestriction_invalidCount,
  (SELECT SUM(densness_validCount) FROM res) AS unitDenseness_validCount,
  (SELECT SUM(densness_invalidCount) FROM res) AS unitDenseness_invalidCount
;
--
-- VQ16: 'Functional unit' 'linked to' max 1 'Management unit'
--
WITH data AS (
  SELECT domain."T000a_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0001_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000009_history" AS axiom
      ON(domain."T000a_dbid" = axiom."T000a_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000009_history" AS range
      ON(range."T0001_dbid" = axiom."T0001_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS linkCount,
    COUNT(rangedbid) <= 1 AS isLink_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isLink_validCount) FROM res WHERE isLink_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isLink_validCount) FROM res WHERE NOT isLink_validCount) AS unitRestriction_invalidCount,
  (SELECT SUM(densness_validCount) FROM res) AS unitDenseness_validCount,
  (SELECT SUM(densness_invalidCount) FROM res) AS unitDenseness_invalidCount
;
--
-- VQ17: 'Functional unit' 'linked to' max 1 'Service and department'
--
WITH data AS (
  SELECT domain."T000a_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T000b_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000016_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000006_history" AS axiom
      ON(domain."T000a_dbid" = axiom."T000a_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000006_history" AS range
      ON(range."T000b_dbid" = axiom."T000b_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS linkCount,
    COUNT(rangedbid) <= 1 AS isLink_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isLink_validCount) FROM res WHERE isLink_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isLink_validCount) FROM res WHERE NOT isLink_validCount) AS unitRestriction_invalidCount,
  (SELECT SUM(densness_validCount) FROM res) AS unitDenseness_validCount,
  (SELECT SUM(densness_invalidCount) FROM res) AS unitDenseness_invalidCount
;
--
-- VQ18: 'Administrative unit' 'linked to' max 1 'Medico-administrative unit'
--
WITH data AS (
  SELECT domain."T0004_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0010_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000025_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000011_history" AS axiom
      ON(domain."T0004_dbid" = axiom."T0004_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000011_history" AS range
      ON(range."T0010_dbid" = axiom."T0010_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS linkCount,
    COUNT(rangedbid) <= 1 AS isLink_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isLink_validCount) FROM res WHERE isLink_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isLink_validCount) FROM res WHERE NOT isLink_validCount) AS unitRestriction_invalidCount,
  (SELECT SUM(densness_validCount) FROM res) AS unitDenseness_validCount,
  (SELECT SUM(densness_invalidCount) FROM res) AS unitDenseness_invalidCount
;
--
-- VQ19: 'Administrative unit' 'linked to' max 1 'Service and department'
--
WITH data AS (
  SELECT domain."T0004_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T000b_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000025_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000006_history" AS axiom
      ON(domain."T0004_dbid" = axiom."T0004_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000006_history" AS range
      ON(range."T000b_dbid" = axiom."T000b_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS linkCount,
    COUNT(rangedbid) <= 1 AS isLink_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isLink_validCount) FROM res WHERE isLink_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isLink_validCount) FROM res WHERE NOT isLink_validCount) AS unitRestriction_invalidCount,
  (SELECT SUM(densness_validCount) FROM res) AS unitDenseness_validCount,
  (SELECT SUM(densness_invalidCount) FROM res) AS unitDenseness_invalidCount
;
--
-- VQ20: 'Hospitalization unit' 'linked to' exactly 1 'Administrative unit'
--
WITH data AS (
  SELECT domain."T0003_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T0004_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000012_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000025_history" AS axiom
      ON(domain."T0003_dbid" = axiom."T0003_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000025_history" AS range
      ON(range."T0004_dbid" = axiom."T0004_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS linkCount,
    COUNT(rangedbid) = 1 AS isLink_validCount
  FROM data
  GROUP BY domaindbid, domainvt
)
, vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
), res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isLink_validCount) FROM res WHERE isLink_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isLink_validCount) FROM res WHERE NOT isLink_validCount) AS unitRestriction_invalidCount,
  (SELECT SUM(densness_validCount) FROM res) AS unitDenseness_validCount,
  (SELECT SUM(densness_invalidCount) FROM res) AS unitDenseness_invalidCount
;
--
-- VQ21: 'Hospitalization unit' 'linked to' max 1 'Service and department'
--
WITH data AS (
  SELECT domain."T0003_dbid" AS domaindbid, domain.vt AS domainvt,
         range."T000b_dbid" AS rangedbid, range.vt AS rangevt,
         axiom.vt AS propertvt,
         domain.vt <@ range.vt
  FROM "HORG-FR_HISTORY"."HORG-FR_000012_history" AS domain
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000006_history" AS axiom
      ON(domain."T0003_dbid" = axiom."T0003_dbid")
    LEFT JOIN "HORG-FR_HISTORY"."HORG-FR_000006_history" AS range
      ON(range."T000b_dbid" = axiom."T000b_dbid")
), vqa AS
(
  SELECT domaindbid, COUNT(rangedbid) AS linkCount,
    COUNT(rangedbid) <= 1 AS isLink_validCount
  FROM data
  GROUP BY domaindbid, domainvt
), vqb AS
(
  SELECT domaindbid,
    COALESCE(validCount, 0) AS densness_validCount,
    COALESCE(invalidCount, 0) AS densness_invalidCount
  FROM
    (SELECT domaindbid, COUNT(rangedbid) AS validCount
    FROM data
    WHERE domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS valid
  FULL JOIN
    (SELECT domaindbid, COUNT(rangedbid) AS invalidCount
    FROM data
    WHERE NOT domainvt <@ rangevt
    GROUP BY domaindbid, domainvt) AS invalid
  USING(domaindbid)
)
, res AS
(
  SELECT * FROM vqa FULL JOIN vqb USING(domaindbid)
)
--SELECT * FROM res
SELECT
  (SELECT COUNT(isLink_validCount) FROM res WHERE isLink_validCount) AS unitRestriction_validCount,
  (SELECT COUNT(isLink_validCount) FROM res WHERE NOT isLink_validCount) AS unitRestriction_invalidCount,
  (SELECT SUM(densness_validCount) FROM res) AS unitDenseness_validCount,
  (SELECT SUM(densness_invalidCount) FROM res) AS unitDenseness_invalidCount
;
