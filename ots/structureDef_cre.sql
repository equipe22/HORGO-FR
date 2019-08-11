/* ================================================================================================
 Création des tables requises pour la définition des catégories des unités et leurs hiérarchies

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */
SET SCHEMA 'HORG-FR_HISTORY';

CREATE DOMAIN "HORG-FR_HISTORY"."UNITCATEGORYACRONYME"
  AS VARCHAR(6);

CREATE TABLE "HORG-FR_HISTORY"."UnitCategory@vbx"
(
  id INT NOT NULL,
  vbx "HORG-FR_HISTORY"."POINT",
  CONSTRAINT unitcategoryVbx_ck0 PRIMARY KEY (id)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategory@vbx"
  IS 'Définition des catégories d''unité existe depuis.'
;

CREATE TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbx"
(
  id INT NOT NULL,
  acronyme_en "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
  vbx "HORG-FR_HISTORY"."POINT",
  CONSTRAINT unitcategoryAcronymeEnVbx_ck0 PRIMARY KEY (id),
  CONSTRAINT unitcategoryAcronymeEnVbx_ck1 UNIQUE (acronyme_en)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbx"
  IS 'Une catégorie identifée par id possède un acronyme en anglais acronyme_en depuis vbx.'
;

CREATE TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbx"
(
  id INT NOT NULL,
  acronyme_fr "HORG-FR_HISTORY"."UNITCATEGORYACRONYME",
  vbx "HORG-FR_HISTORY"."POINT",
  CONSTRAINT unitcategoryAcronymeFrVbx_ck0 PRIMARY KEY (id),
  CONSTRAINT unitcategoryAcronymeFrVbx_ck1 UNIQUE (acronyme_fr)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbx"
  IS 'Une catégorie identifée par id possède un acronyme en français acronyme_fr depuis vbx.'
;

CREATE TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbx"
(
  id INT NOT NULL,
  libelle_fr VARCHAR(64),
  vbx "HORG-FR_HISTORY"."POINT",
  CONSTRAINT unitcategoryLibelleVbxFr_ck0 PRIMARY KEY (id),
  CONSTRAINT unitcategoryLibelleVbxFr_ck1 UNIQUE (libelle_fr)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbx"
  IS 'Une catégorie identifée par id possède un libellé en français libelle_fr depuis vbx.'
;

CREATE TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbx"
(
  id INT NOT NULL,
  libelle_en VARCHAR(64),
  vbx "HORG-FR_HISTORY"."POINT",
  CONSTRAINT unitcategoryLibelleVbxEn_ck0 PRIMARY KEY (id),
  CONSTRAINT unitcategoryLibelleVbxEn_ck1 UNIQUE (libelle_en)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbx"
  IS 'Une catégorie identifée par id possède un libellé en anglais libelle_fr depuis vbx.'
;

CREATE TABLE "HORG-FR_HISTORY"."UnitCategory@vbe"
(
  id INT NOT NULL,
  vbe "HORG-FR_HISTORY"."PERIOD",
  CONSTRAINT unitcategoryVbe_ck0 PRIMARY KEY (id, vbe)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategory@vbe"
  IS 'Définition des catégories d''unité durant.'
;

-- No redundancy constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategory@vbe"
  ADD CONSTRAINT unitCategoryVbe_redundancy
  EXCLUDE USING gist(id WITH =, vbe WITH &&);

 -- No contradiction constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategory@vbe"
  ADD CONSTRAINT unitCategoryVbe_contradiction
  EXCLUDE USING gist(id WITH =, vbe WITH &&);

 -- No circumlocution constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategory@vbe"
  ADD CONSTRAINT unitCategoryVbe_circumlocution
  EXCLUDE USING gist(id WITH =, vbe WITH -|-);

CREATE TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbe"
(
  id INT NOT NULL,
  acronyme_en VARCHAR(12),
  vbe "HORG-FR_HISTORY"."PERIOD",
  CONSTRAINT unitcategoryAcronymeEnVbe_ck0 PRIMARY KEY (id, vbe),
  CONSTRAINT unitcategoryAcronymeEnVbe_ck1 UNIQUE (acronyme_en)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbe"
  IS 'Une catégorie identifée par id possède un acronyme en anglais acronyme_en durant vbe.'
;

-- No redundancy constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbe"
  ADD CONSTRAINT unitcategoryAcronymeEnVbe_redundancy
  EXCLUDE USING gist(id WITH =, acronyme_en WITH =, vbe WITH &&);

 -- No contradiction constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbe"
  ADD CONSTRAINT unitcategoryAcronymeEnVbe_contradiction
  EXCLUDE USING gist(id WITH =, acronyme_en WITH =, vbe WITH &&);

 -- No circumlocution constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbe"
  ADD CONSTRAINT unitcategoryAcronymeEnVbe_circumlocution
  EXCLUDE USING gist(id WITH =, acronyme_en WITH =, vbe WITH -|-);

CREATE TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbe"
(
  id INT NOT NULL,
  acronyme_fr VARCHAR(12),
  vbe "HORG-FR_HISTORY"."PERIOD",
  CONSTRAINT unitcategoryAcronymeFrVbe_ck0 PRIMARY KEY (id, vbe),
  CONSTRAINT unitcategoryAcronymeFrVbe_ck1 UNIQUE (acronyme_fr)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbe"
  IS 'Une catégorie identifée par id possède un acronyme en français acronyme_fr durant vbe.'
;

-- No redundancy constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbe"
  ADD CONSTRAINT unitcategoryAcronymeFrVbe_redundancy
  EXCLUDE USING gist(id WITH =, acronyme_fr WITH =, vbe WITH &&);

 -- No contradiction constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbe"
  ADD CONSTRAINT unitcategoryAcronymeFrVbe_contradiction
  EXCLUDE USING gist(id WITH =, acronyme_fr WITH =, vbe WITH &&);

 -- No circumlocution constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbe"
  ADD CONSTRAINT unitcategoryAcronymeFrVbe_circumlocution
  EXCLUDE USING gist(id WITH =, acronyme_fr WITH =, vbe WITH -|-);

CREATE TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbe"
(
  id INT NOT NULL,
  libelle_fr VARCHAR(64),
  vbe "HORG-FR_HISTORY"."PERIOD",
  CONSTRAINT unitcategoryLibelleFrVbe_ck0 PRIMARY KEY (id, vbe),
  CONSTRAINT unitcategoryLibelleFrVbe_ck1 UNIQUE (libelle_fr)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbe"
  IS 'Une catégorie identifée par id possède un libellé en français libelle_fr durant vbe.'
;

-- No redundancy constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbe"
  ADD CONSTRAINT unitcategoryLibelleFr_redundancy
  EXCLUDE USING gist(id WITH =, libelle_fr WITH =, vbe WITH &&);

 -- No contradiction constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbe"
  ADD CONSTRAINT unitcategoryLibelleFr_contradiction
  EXCLUDE USING gist(id WITH =, libelle_fr WITH =, vbe WITH &&);

 -- No circumlocution constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbe"
  ADD CONSTRAINT unitcategoryLibelleFr_circumlocution
  EXCLUDE USING gist(id WITH =, libelle_fr WITH =, vbe WITH -|-);

CREATE TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbe"
(
  id INT NOT NULL,
  libelle_en VARCHAR(64),
  vbe "HORG-FR_HISTORY"."PERIOD",
  CONSTRAINT unitcategoryLibelleEnVbe_ck0 PRIMARY KEY (id, vbe),
  CONSTRAINT unitcategoryLibelleEnVbe_ck1 UNIQUE (libelle_en)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbe"
  IS 'Une catégorie identifée par id possède un libellé en anglais libelle_en durant vbe.'
;

-- No redundancy constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbe"
  ADD CONSTRAINT unitcategoryLibelleEn_redundancy
  EXCLUDE USING gist(id WITH =, libelle_en WITH =, vbe WITH &&);

 -- No contradiction constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbe"
  ADD CONSTRAINT unitcategoryLibelleEn_contradiction
  EXCLUDE USING gist(id WITH =, libelle_en WITH =, vbe WITH &&);

 -- No circumlocution constraint
ALTER TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbe"
  ADD CONSTRAINT unitcategoryLibelleEn_circumlocution
  EXCLUDE USING gist(id WITH =, libelle_en WITH =, vbe WITH -|-);

CREATE VIEW "HORG-FR_HISTORY"."UnitCategory_history" AS
  SELECT id, uc.vbe AS "unitCategory@vt",
    acronyme_en, ac_en.vbe AS "acronyme_en@vt",
    acronyme_fr, ac_fr.vbe AS "acronyme_fr@vt",
    libelle_en, lib_en.vbe AS "libelle_en@vt",
    libelle_fr, lib_fr.vbe AS "libelle_fr@vt"
  FROM "HORG-FR_HISTORY"."UnitCategory@vbe" AS uc
    JOIN "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbe" AS ac_en USING(id)
    JOIN "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbe" AS ac_fr USING(id)
    JOIN "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbe"  AS lib_en  USING(id)
    JOIN "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbe"  AS lib_fr USING(id)
  UNION
  SELECT id, uc.vbe AS "unitCategory@vt",
    acronyme_en, vbx(ac_en.vbx) AS "acronyme_en@vt",
    acronyme_fr, vbx(ac_fr.vbx) AS "acronyme_fr@vt",
    libelle_en, vbx(lib_en.vbx) AS "libelle_en@vt",
    libelle_fr, vbx(lib_fr.vbx) AS "libelle_fr@vt"
  FROM "HORG-FR_HISTORY"."UnitCategory@vbe" AS uc
    JOIN "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbx" AS ac_en USING(id)
    JOIN "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbx" AS ac_fr USING(id)
    JOIN "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbx"  AS lib_en  USING(id)
    JOIN "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbx"  AS lib_fr USING(id)
;

/** ================================================================ **
 * Définition de structures hospitalières
 ** ================================================================ **/
CREATE TABLE "HORG-FR_HISTORY"."Structure@vbx"
(
  subUnit integer NOT NULL,
  supUnit integer NOT NULL,
  vbx "HORG-FR_HISTORY"."POINT",
  CONSTRAINT structureVbx_ck0 PRIMARY KEY (subunit, supunit)
  --CONSTRAINT structureVbx_fk0 FOREIGN KEY (subUnit) REFERENCES "HORG-FR_HISTORY"."UnitCategory_history"(id),
  --CONSTRAINT structureVbx_fk1 FOREIGN KEY (supUnit) REFERENCES "HORG-FR_HISTORY"."UnitCategory_history"(id)
)
;
COMMENT ON TABLE "HORG-FR_HISTORY"."Structure@vbx"
  IS 'Définition d''une structure organisationnelle représentée par des liens hiérarchiques entre catégories d''unité.
      Une unité subUnit a comme super-unité supUnit depuis vbx'
;

CREATE TABLE "HORG-FR_HISTORY"."Structure@vbe"
(
  subUnit integer NOT NULL,
  supUnit integer NOT NULL,
  vbe "HORG-FR_HISTORY"."PERIOD",
  CONSTRAINT structureVbe_ck0 PRIMARY KEY (subunit, supunit, vbe)
  --CONSTRAINT structureVbe_fk0 FOREIGN KEY (subUnit) REFERENCES "HORG-FR_HISTORY"."UnitCategory_history"(id),
  --CONSTRAINT structureVbe_fk1 FOREIGN KEY (supUnit) REFERENCES "HORG-FR_HISTORY"."UnitCategory_history"(id)
)
;
COMMENT ON TABLE  "HORG-FR_HISTORY"."Structure@vbx"
  IS 'Définition d''une structure organisationnelle représentée par des liens hiérarchiques entre catégories d''unité.
      Une unité subUnit a eu comme super-unité supUnit durant vbe'
;

CREATE VIEW "HORG-FR_HISTORY"."Structure_history" AS
  SELECT subUnit, supUnit, vbe AS vt
  FROM "HORG-FR_HISTORY"."Structure@vbe"
  UNION
  SELECT subUnit, supUnit, vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."Structure@vbx"
;

-- No redundancy constraint
ALTER TABLE "HORG-FR_HISTORY"."Structure@vbe"
  ADD CONSTRAINT structureVbe_redundancy
  EXCLUDE USING gist(subunit WITH =, supunit WITH =, vbe WITH &&);

 -- No contradiction constraint
ALTER TABLE "HORG-FR_HISTORY"."Structure@vbe"
  ADD CONSTRAINT structureVbe_contradiction
  EXCLUDE USING gist(subunit WITH =, supunit WITH =, vbe WITH &&);

 -- No circumlocution constraint
ALTER TABLE "HORG-FR_HISTORY"."Structure@vbe"
  ADD CONSTRAINT structureVbe_circumlocution
  EXCLUDE USING gist(subunit WITH =, supunit WITH =, vbe WITH -|-);
