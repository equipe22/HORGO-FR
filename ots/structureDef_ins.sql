/* ================================================================================================
 Création des données requises pour la définition des catégories des unités et leurs hiérarchies.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */

-- Catégorie des unités
INSERT INTO "HORG-FR_HISTORY"."UnitCategory@vbx"(id, vbx) VALUES
  (1, '2007-01-01'),
  (2, '2000-01-01'),
  (3, '2000-01-01'),
  (4, '2000-01-01'),
  (5, '2000-01-01'),
  (6, '2000-01-01'),
  (7, '2000-01-01'),
  (8, '2000-01-01')
;

INSERT INTO "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbx"(id, acronyme_en, vbx) VALUES
  (1, 'HVID', '2007-01-01'),
  (2, 'SD'  , '2000-01-01'),
  (3, 'MGU' , '2000-01-01'),
  (4, 'FU'  , '2000-01-01'),
  (5, 'MAU' , '2000-01-01'),
  (6, 'AU'  , '2000-01-01'),
  (7, 'CMRU', '2000-01-01'),
  (8, 'HU'  , '2000-01-01')
;

INSERT INTO "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbx"(id, acronyme_fr, vbx) VALUES
  (1, 'POLE', '2007-01-01'),
  (2, 'SD'  , '2000-01-01'),
  (3, 'UG'  , '2000-01-01'),
  (4, 'UF'  , '2000-01-01'),
  (5, 'UMA' , '2000-01-01'),
  (6, 'UA'  , '2000-01-01'),
  (7, 'URMC', '2000-01-01'),
  (8, 'UH'  , '2000-01-01')
;

INSERT INTO "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbx"(id, libelle_en, vbx) VALUES
  (1, 'Healthcare division', '2007-01-01'),
  (2, 'Service et departement', '2000-01-01'),
  (3, 'Managment unit', '2000-01-01'),
  (4, 'Functional unit','2000-01-01'),
  (5, 'Medico-administrative unit','2000-01-01'),
  (6, 'Administrative unit', '2000-01-01'),
  (7, 'Clinical medical responsability unit', '2000-01-01'),
  (8, 'Hospitalization unit', '2000-01-01')
;

INSERT INTO "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbx"(id, libelle_fr, vbx) VALUES
  (1, 'Pole de santé', '2007-01-01'),
  (2, 'Service et département', '2000-01-01'),
  (3, 'Unité de gestion', '2000-01-01'),
  (4, 'Unité fonctionnelle','2000-01-01'),
  (5, 'Unité médico-administrative','2000-01-01'),
  (6, 'Unité administrative', '2000-01-01'),
  (7, 'Unité de responsabilité clinique', '2000-01-01'),
  (8, 'Unité hospitalière', '2000-01-01')
;

-- Définition de la structure
INSERT INTO "HORG-FR_HISTORY"."Structure@vbx"(subunit, supunit, vbx) VALUES
  (8, 5, '2007-01-01'),
  (7, 5, '2007-01-01'),
  (5, 3, '2007-01-01'),
  (6, 3, '2007-01-01'),
  (2, 1, '2007-01-01'),
  (3, 1, '2007-01-01'),
  (4, 1, '2007-01-01')
;
