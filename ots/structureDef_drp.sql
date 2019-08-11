/* ================================================================================================
 Suppression des tables requises pour la définition des catégories des unités et leurs hiérarchies.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */

DROP TABLE "HORG-FR_HISTORY"."UnitCategory@vbx" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategory@vbe" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbx" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_en@vbe" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbx" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategoryAcronyme_fr@vbe" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbx" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_en@vbe" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbe" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."UnitCategoryLibelle_fr@vbx" CASCADE;
--
DROP TABLE "HORG-FR_HISTORY"."Structure@vbx" CASCADE;
DROP TABLE "HORG-FR_HISTORY"."Structure@vbe" CASCADE;
--
DROP DOMAIN "HORG-FR_HISTORY"."UNITCATEGORYACRONYME";
--
DROP MATERIALIZED VIEW "HORG-FR_HISTORY"."ALL_structure" CASCADE;
DROP MATERIALIZED VIEW "HORG-FR_HISTORY"."HEGP_structure" CASCADE;
DROP MATERIALIZED VIEW "HORG-FR_HISTORY"."HAP_structure" CASCADE;
