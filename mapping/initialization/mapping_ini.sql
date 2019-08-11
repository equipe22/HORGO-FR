/* ================================================================================================
 Script d'initialisation de l'alimentation.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-09
 Version       : 0.0.1
================================================================================================ */
-- Création du package d'indexage temporels.
CREATE EXTENSION btree_gist;

-- Création des séquences.
CREATE SEQUENCE "HORG-FR_HISTORY".typeId_seq START 1;
CREATE SEQUENCE "HORG-FR_HISTORY".dbid_seq START 1;

-- Initialisation des séquences.
SELECT setval('"HORG-FR_HISTORY".typeId_seq', 1);
SELECT setval('"HORG-FR_HISTORY".dbid_seq', 1);
