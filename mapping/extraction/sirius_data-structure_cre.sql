CREATE SCHEMA IF NOT EXISTS "sirius";

CREATE TABLE "sirius".ges_2011
(
	hopital text,
	pole text,
	type_pole text,
	date_effet_crea_pole text,
	date_effet_mod_pole text,
	date_effet_fin_val_pole text,
	ancien_lien_rsn2 text,
	type_rsn2 text,
	ug text,
	type_ug text,
	ta_ug text,
	compte_c9_ug text,
	lib_cc9_ug text,
	activite_analytique text,
	compte_autorise_ug text,
	compte_c9_2008 text,
	code_crp text,
	section_budgetaire text,
	date_effet_crea_ug text,
	date_effet_mod_ug text,
	date_effet_fin_val_ug text,
	ua text,
	ta_ua text,
	compte_c9_ua text,
	lib_cc9_ua text,
	compte_autorise_ua text,
	deq text,
	lien_ua_uma text,
	code_budgtaire text,
	discipline_autorise text,
	date_effet_crea_ua text,
	date_effet_mod_ua text,
	date_effet_fin_val_ua text,
	uma text,
	type_uma text,
	type_activite text,
	autorisation_t2a text,
	nb_de_lits_ou_places_exploitables text,
	compte_c9_uma text,
	lib_cc9_uma text,
	urm_clinique text,
	discipline_equipement text,
	champ_pmsi text,
	date_effet_crea_uma text,
	date_effet_mod_uma text,
	date_effet_fin_val_uma text,
	uh text,
	date_effet_crea_uh text,
	date_effet_mod_uh text,
	date_effet_fin_val_uh text
)
;

CREATE TABLE "sirius".ges_2010
(
	hopital text,
	pole text,
	type_pole text,
	date_effet_crea_pole text,
	date_effet_mod_pole text,
	date_effet_fin_val_pole text,
	ancien_lien_rsn2 text,
	type_rsn2 text,
	ug text,
	type_ug text,
	ta_ug text,
	compte_c9_ug text,
	lib_cc9_ug text,
	activite_analytique text,
	compte_autorise text,
	compte_c9_2008 text,
	code_crp text,
	section_budgetaire text,
	date_effet_crea text,
	date_effet_mod text,
	date_effet_fin_val text,
	ua text,
	ta_ua text,
	compte_c9_ua text,
	lib_cc9_ua text,
	compte_autorise_ua text,
	deq text,
	lien_ua_uma text,
	date_effet_crea_ua text,
	date_effet_mod_ua text,
	date_effet_fin_val_ua text,
	uma text,
	type_uma text,
	type_activite text,
	autorisation_t2a text,
	nb_de_lits_ou_places_exploitables text,
	compte_c9_uma text,
	lib_cc9_uma text,
	urm_clinique text,
	discipline_equipement text,
	date_effet_crea_uma text,
	date_effet_mod_uma text,
	date_effet_fin_val_uma text,
	uh text,
	date_effet_crea_uh text,
	date_effet_mod_uh text,
	date_effet_fin_val_uh text
)
;

CREATE TABLE "sirius"."ges-hegp_2019"
(
	"CODE GH" text,
	"Libelle GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"ANCIEN LIEN RSN2" text,
	"LIBELLE UF" text,
	"TYPE RSN2" text,
	"CODE UG" text,
	ug text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Activite analytique" text,
	"Compte Autorise" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	"CODE UA" text,
	ua text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budgetaire" text,
	"Discipline autorisee" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	"CODE UMA" text,
	uma text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"AUTORISATION SSR" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libelle COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"CODE UH" text,
	uh text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;

CREATE TABLE "sirius"."med-hegp_2019"
(
	"CODE GH" text,
	gh text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"COMMENTAIRE POLE" text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"CODE SERVIDE-DEPARTEMENT" text,
	"SERVICE-DEPARTEMENT" text,
	"TYPE S-D" text,
	"RESPONSABLE S-D" text,
	"COMMENTAIRE S-D" text,
	"DATE EFFET CREA S-D" text,
	"DATE EFFET MOD S-D" text,
	"DATE EFFET FIN VAL S-D" text,
	"CODE UF" text,
	uf text,
	"TYPE UF" text,
	"RESPONSABLE UF" text,
	"SPE MEDICALE" text,
	"LIB SPE MEDICALE" text,
	"SPE COMPARAISON" text,
	"LIB SPE COMPARAISON" text,
	"COMMENTAIRE UF" text,
	"DATE EFFET CREA UF" text,
	"DATE EFFET MOD UF" text,
	"DATE EFFET FIN VAL UF" text,
	"CODE UC" text,
	uc text,
	"COMMENTAIRE UC" text,
	"DATE EFFET CREA UC" text,
	"DATE EFFET MOD UC" text,
	"DATE EFFET FIN VAL UC" text
)
;

CREATE TABLE "sirius"."med-hegp_2016"
(
	"CODE GH" text,
	"Libellé GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"COMMENTAIRE POLE" text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"CODE SERVIDE-DEPARTEMENT" text,
	"SERVICE-DEPARTEMENT" text,
	"TYPE S-D" text,
	"RESPONSABLE S-D" text,
	"COMMENTAIRE S-D" text,
	"DATE EFFET CREA S-D" text,
	"DATE EFFET MOD S-D" text,
	"DATE EFFET FIN VAL S-D" text,
	"CODE UF" text,
	uf text,
	"TYPE UF" text,
	"RESPONSABLE UF" text,
	"SPE MEDICALE" text,
	"LIB SPE MEDICALE" text,
	"SPE COMPARAISON" text,
	"LIB SPE COMPARAISON" text,
	"COMMENTAIRE UF" text,
	"DATE EFFET CREA UF" text,
	"DATE EFFET MOD UF" text,
	"DATE EFFET FIN VAL UF" text,
	"CODE UC" text,
	uc text,
	"COMMENTAIRE UC" text,
	"DATE EFFET CREA UC" text,
	"DATE EFFET MOD UC" text,
	"DATE EFFET FIN VAL UC" text
)
;

CREATE TABLE "sirius"."med-hegp_2015"
(
	"CODE GH" text,
	"Libellé GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"COMMENTAIRE POLE" text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"CODE SERVIDE-DEPARTEMENT" text,
	"SERVICE-DEPARTEMENT" text,
	"TYPE S-D" text,
	"RESPONSABLE S-D" text,
	"COMMENTAIRE S-D" text,
	"DATE EFFET CREA S-D" text,
	"DATE EFFET MOD S-D" text,
	"DATE EFFET FIN VAL S-D" text,
	"CODE UF" text,
	uf text,
	"TYPE UF" text,
	"RESPONSABLE UF" text,
	"SPE MEDICALE" text,
	"LIB SPE MEDICALE" text,
	"SPE COMPARAISON" text,
	"LIB SPE COMPARAISON" text,
	"COMMENTAIRE UF" text,
	"DATE EFFET CREA UF" text,
	"DATE EFFET MOD UF" text,
	"DATE EFFET FIN VAL UF" text,
	"CODE UC" text,
	uc text,
	"COMMENTAIRE UC" text,
	"DATE EFFET CREA UC" text,
	"DATE EFFET MOD UC" text,
	"DATE EFFET FIN VAL UC" text
)
;

CREATE TABLE "sirius".hegp_2017
(
	"CODE GH" text,
	"Libellé GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"ANCIEN LIEN RSN2" text,
	"LIBELLE UF" text,
	"TYPE RSN2" text,
	"CODE UG" text,
	ug text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Activité analytique" text,
	"Compte Autorisé" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	"CODE UA" text,
	ua text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budgétaire" text,
	"Discipline autorisée" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	"CODE UMA" text,
	uma text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"AUTORISATION SSR" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libellé COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"CODE UH" text,
	uh text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;

CREATE TABLE "sirius"."ges-hegp_2016"
(
	"CODE GH" text,
	"Libellé GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"ANCIEN LIEN RSN2" text,
	"LIBELLE UF" text,
	"TYPE RSN2" text,
	"CODE UG" text,
	ug text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Activité analytique" text,
	"Compte Autorisé" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	"CODE UA" text,
	ua text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budgétaire" text,
	"Discipline autorisée" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	"CODE UMA" text,
	uma text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"AUTORISATION SSR" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libellé COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"CODE UH" text,
	uh text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;

CREATE TABLE "sirius"."ges-hegp_2015"
(
	"CODE GH" text,
	"Libellé GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"ANCIEN LIEN RSN2" text,
	"LIBELLE UF" text,
	"TYPE RSN2" text,
	"CODE UG" text,
	ug text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Activité analytique" text,
	"Compte Autorisé" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	"CODE UA" text,
	ua text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budgétaire" text,
	"Discipline autorisée" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	"CODE UMA" text,
	uma text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"AUTORISATION SSR" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libellé COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"CODE UH" text,
	uh text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;

CREATE TABLE "sirius"."ges-hegp_2014"
(
	"CODE GH" text,
	"Libelle GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"ANCIEN LIEN RSN2" text,
	"LIBELLE UF" text,
	"TYPE RSN2" text,
	"CODE UG" text,
	ug text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Activité analytique" text,
	"Compte Autorisé" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	"CODE UA" text,
	ua text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budgétaire" text,
	"Discipline autoris�e" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	"CODE UMA" text,
	uma text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"AUTORISATION SSR" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libelle COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"CODE UH" text,
	uh text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;

CREATE TABLE "sirius"."ges-hegp_2013"
(
	"CODE GH" text,
	"Libellé GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"ANCIEN LIEN RSN2" text,
	"LIBELLE UF" text,
	"TYPE RSN2" text,
	"CODE UG" text,
	ug text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Activité analytique" text,
	"Compte Autorisé" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	"CODE UA" text,
	ua text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budg�taire" text,
	"Discipline autoris�e" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	"CODE UMA" text,
	uma text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"AUTORISATION SSR" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libellé COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"CODE UH" text,
	uh text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;

CREATE TABLE "sirius"."ges-hegp_2012"
(
	hopital text,
	pole text,
	type_pole text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"ANCIEN LIEN RSN2" text,
	"TYPE RSN2" text,
	ug text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Activité analytique" text,
	"Compte Autorise" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	ua text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budgétaire" text,
	"Discipline autorisée" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	uma text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libellé COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"Code UH" text,
	uh text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;

CREATE TABLE "sirius".hupo_2017
(
	"CODE SERV" text,
	"LIBELLE SERV" text,
	"STATUT SERV" text,
	"CODE GH" text,
	"LIBELLE GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	"CHEF POLE" text,
	cpp text,
	cap text,
	"TYPE POLE" text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"CR/UF" text,
	"LIBELLE CR/UF" text,
	"TYPE RSN2" text,
	"CODE UG" text,
	"LIBELLE UG" text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Act. analyt." text,
	"Compte Autorisé" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	"CODE UA" text,
	"LIBELLE UA" text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budgétaire" text,
	"Discipline autorisée" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	"CODE UMA" text,
	"LIBELLE UMA" text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"AUTORISATION SSR" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libellé COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"CODE UH" text,
	"LIBELLE UH" text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;

CREATE TABLE "sirius"."med-hap_2019"
(
	"CODE GH" text,
	"Libelle GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"COMMENTAIRE POLE" text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"CODE SERVIDE-DEPARTEMENT" text,
	"SERVICE-DEPARTEMENT" text,
	"TYPE S-D" text,
	"RESPONSABLE S-D" text,
	"COMMENTAIRE S-D" text,
	"DATE EFFET CREA S-D" text,
	"DATE EFFET MOD S-D" text,
	"DATE EFFET FIN VAL S-D" text,
	"CODE UF" text,
	uf text,
	"TYPE UF" text,
	"RESPONSABLE UF" text,
	"SPE MEDICALE" text,
	"LIB SPE MEDICALE" text,
	"SPE COMPARAISON" text,
	"LIB SPE COMPARAISON" text,
	"COMMENTAIRE UF" text,
	"DATE EFFET CREA UF" text,
	"DATE EFFET MOD UF" text,
	"DATE EFFET FIN VAL UF" text,
	"CODE UC" text,
	uc text,
	"COMMENTAIRE UC" text,
	"DATE EFFET CREA UC" text,
	"DATE EFFET MOD UC" text,
	"DATE EFFET FIN VAL UC" text
)
;

CREATE TABLE "sirius"."ges-hap_2019"
(
	"CODE GH" text,
	"Libelle GH" text,
	"CODE HOPITAL" text,
	hopital text,
	"CODE POLE" text,
	pole text,
	type_pole text,
	"DATE EFFET CREA POLE" text,
	"DATE EFFET MOD POLE" text,
	"DATE EFFET FIN VAL POLE" text,
	"ANCIEN LIEN RSN2" text,
	"LIBELLE UF" text,
	"TYPE RSN2" text,
	"CODE UG" text,
	ug text,
	"TYPE UG" text,
	"TA UG" text,
	"COMPTE CLASSE9 UG" text,
	"LIB CC9 UG" text,
	"Activite analytique" text,
	"Compte Autorise" text,
	"COMPTE CLASSE 9 (2008)" text,
	"CODE CRP" text,
	"SECTION BUDGETAIRE" text,
	"DATE EFFET CREA UG" text,
	"DATE EFFET MOD UG" text,
	"DATE EFFET FIN VAL UG" text,
	"CODE UA" text,
	ua text,
	"TA UA" text,
	"COMPTE CLASSE9 UA" text,
	"LIB CC9 UA" text,
	"COMPTE AUTORISE UA" text,
	deq text,
	"LIEN UA-UMA" text,
	"Code budgetaire" text,
	"Discipline autorisee" text,
	"DATE EFFET CREA UA" text,
	"DATE EFFET MOD UA" text,
	"DATE EFFET FIN VAL UA" text,
	"CODE UMA" text,
	uma text,
	"TYPE UMA" text,
	"TYPE ACTIVITE" text,
	"AUTORISATION T2A" text,
	"AUTORISATION SSR" text,
	"Nb de lits ou places exploitables" text,
	"COMPTE CLASSE9 UMA" text,
	"Libelle COMPTE CLASSE9 UMA" text,
	"URM CLINIQUE" text,
	"DISCIPLINE EQUIPEMENT" text,
	"Champ PMSI" text,
	"DATE EFFET CREA UMA" text,
	"DATE EFFET MOD UMA" text,
	"DATE EFFET FIN VAL UMA" text,
	"CODE UH" text,
	uh text,
	"DATE EFFET CREA UH" text,
	"DATE EFFET MOD UH" text,
	"DATE EFFET FIN VAL UH" text
)
;
