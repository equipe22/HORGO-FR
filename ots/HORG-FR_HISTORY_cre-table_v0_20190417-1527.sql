/*
-- =========================================================================== A
Schema : HORG-FR_HISTORY
Creation Date : 20190417-1527
Encoding : UTF-8, sans BOM, fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.6
Responsable : OntoRelA
Version : v0
Status : dev
Objet :
  Create domains and tables
-- =========================================================================== A
*/

CREATE SCHEMA IF NOT EXISTS "HORG-FR_HISTORY";

COMMENT ON SCHEMA "HORG-FR_HISTORY" IS 'Schéma HORG-FR_HISTORY créé le 20190417-1527';

-- POINT domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."POINT" AS DATE;

-- PERIOD domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."PERIOD" AS DATERANGE;

-- dbid_domain domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."dbid_domain" AS BIGINT;

-- value_domain domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."value_domain" AS TEXT;

-- ACTIVITYTYPECODE domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."ACTIVITYTYPECODE" AS VARCHAR(4);

-- MEDICALSPECODE domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."MEDICALSPECODE" AS CHAR(8);

-- PMSI domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."PMSI" AS CHAR(3);

-- DISCIPLINECODE domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."DISCIPLINECODE" AS VARCHAR(4);

-- langString domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."langString" AS TEXT;

-- string domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."string" AS TEXT;

-- AGENTLABEL domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."AGENTLABEL" AS VARCHAR(64);

-- AGENTID domain definition
CREATE DOMAIN "HORG-FR_HISTORY"."AGENTID" AS VARCHAR(4);

-- table T0017 definition
CREATE TABLE "HORG-FR_HISTORY"."T0017"
(
  "T0017_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "AGENTLABEL" "HORG-FR_HISTORY"."AGENTLABEL"  NOT NULL,
  CONSTRAINT key_T0017 PRIMARY KEY ("T0017_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."T0017" IS 'Libellé d''un agent::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T0017"."T0017_dbid" IS 'dbid Libellé d''un agent::Clé primaire par défaut de Libellé d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T0017"."AGENTLABEL" IS 'Libellé d''un agent::null';

-- table T0011 definition
CREATE TABLE "HORG-FR_HISTORY"."T0011"
(
  "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "string" "HORG-FR_HISTORY"."string"  NOT NULL,
  CONSTRAINT key_T0011 PRIMARY KEY ("T0011_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."T0011" IS 'string::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T0011"."T0011_dbid" IS 'dbid string::Clé primaire par défaut de string';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T0011"."string" IS 'string::null';

-- table T001a definition
CREATE TABLE "HORG-FR_HISTORY"."T001a"
(
  "T001a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "PMSI" "HORG-FR_HISTORY"."PMSI"  NOT NULL,
  CONSTRAINT key_T001a PRIMARY KEY ("T001a_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."T001a" IS 'Champ PMSI::Champs possibles : MCO::Mécedine, chirurgie et obstétrique ou PSY::Phsychiatrie ou SSR::Soins de suite et de réadaptation ou HAD::Hospitalisation à domicile.';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T001a"."T001a_dbid" IS 'dbid Champ PMSI::Clé primaire par défaut de Champ PMSI';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T001a"."PMSI" IS 'Champ PMSI::null';

-- table T001c definition
CREATE TABLE "HORG-FR_HISTORY"."T001c"
(
  "T001c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "MEDICALSPECODE" "HORG-FR_HISTORY"."MEDICALSPECODE"  NOT NULL,
  CONSTRAINT key_T001c PRIMARY KEY ("T001c_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."T001c" IS 'Code de spécialité médicale::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T001c"."T001c_dbid" IS 'dbid Code de spécialité médicale::Clé primaire par défaut de Code de spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T001c"."MEDICALSPECODE" IS 'Code de spécialité médicale::null';

-- table T0013 definition
CREATE TABLE "HORG-FR_HISTORY"."T0013"
(
  "T0013_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "AGENTID" "HORG-FR_HISTORY"."AGENTID"  NOT NULL,
  CONSTRAINT key_T0013 PRIMARY KEY ("T0013_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."T0013" IS 'Identifiant d''un agent::Agent identifier';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T0013"."T0013_dbid" IS 'dbid Identifiant d''un agent::Clé primaire par défaut de Identifiant d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T0013"."AGENTID" IS 'Identifiant d''un agent::null';

-- table T0015 definition
CREATE TABLE "HORG-FR_HISTORY"."T0015"
(
  "T0015_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "DISCIPLINECODE" "HORG-FR_HISTORY"."DISCIPLINECODE"  NOT NULL,
  CONSTRAINT key_T0015 PRIMARY KEY ("T0015_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."T0015" IS 'Code de discipline médicale::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T0015"."T0015_dbid" IS 'dbid Code de discipline médicale::Clé primaire par défaut de Code de discipline médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."T0015"."DISCIPLINECODE" IS 'Code de discipline médicale::null';

-- table H0034 definition
CREATE TABLE "HORG-FR_HISTORY"."H0034"
(
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0034 PRIMARY KEY ("T0001_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0034" IS 'Unité de gestion@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0034"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0034"."vxe" IS 'jusqua::null';

-- table H0035 definition
CREATE TABLE "HORG-FR_HISTORY"."H0035"
(
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0035 PRIMARY KEY ("T0001_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0035" IS 'Unité de gestion@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0035"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0035"."vbe" IS 'durant::null';

-- table H0036 definition
CREATE TABLE "HORG-FR_HISTORY"."H0036"
(
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0036 PRIMARY KEY ("T0001_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0036" IS 'Unité de gestion@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0036"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0036"."vbx" IS 'depuis::null';

-- table H0037 definition
CREATE TABLE "HORG-FR_HISTORY"."H0037"
(
  "T0002_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0037 PRIMARY KEY ("T0002_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0037" IS 'Unité organisationnelle@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0037"."T0002_dbid" IS 'dbid Unité organisationnelle::Clé primaire par défaut de Unité organisationnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0037"."vxe" IS 'jusqua::null';

-- table H0038 definition
CREATE TABLE "HORG-FR_HISTORY"."H0038"
(
  "T0002_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0038 PRIMARY KEY ("T0002_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0038" IS 'Unité organisationnelle@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0038"."T0002_dbid" IS 'dbid Unité organisationnelle::Clé primaire par défaut de Unité organisationnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0038"."vbe" IS 'durant::null';

-- table H0039 definition
CREATE TABLE "HORG-FR_HISTORY"."H0039"
(
  "T0002_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0039 PRIMARY KEY ("T0002_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0039" IS 'Unité organisationnelle@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0039"."T0002_dbid" IS 'dbid Unité organisationnelle::Clé primaire par défaut de Unité organisationnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0039"."vbx" IS 'depuis::null';

-- table H003a definition
CREATE TABLE "HORG-FR_HISTORY"."H003a"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H003a PRIMARY KEY ("T0003_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H003a" IS 'Unité hospitalière@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003a"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003a"."vxe" IS 'jusqua::null';

-- table H003b definition
CREATE TABLE "HORG-FR_HISTORY"."H003b"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H003b PRIMARY KEY ("T0003_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H003b" IS 'Unité hospitalière@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003b"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003b"."vbe" IS 'durant::null';

-- table H003c definition
CREATE TABLE "HORG-FR_HISTORY"."H003c"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H003c PRIMARY KEY ("T0003_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H003c" IS 'Unité hospitalière@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003c"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003c"."vbx" IS 'depuis::null';

-- table H003d definition
CREATE TABLE "HORG-FR_HISTORY"."H003d"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H003d PRIMARY KEY ("T0004_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H003d" IS 'Unité administrative@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003d"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003d"."vxe" IS 'jusqua::null';

-- table H003e definition
CREATE TABLE "HORG-FR_HISTORY"."H003e"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H003e PRIMARY KEY ("T0004_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H003e" IS 'Unité administrative@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003e"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003e"."vbe" IS 'durant::null';

-- table H003f definition
CREATE TABLE "HORG-FR_HISTORY"."H003f"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H003f PRIMARY KEY ("T0004_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H003f" IS 'Unité administrative@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003f"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H003f"."vbx" IS 'depuis::null';

-- table H0040 definition
CREATE TABLE "HORG-FR_HISTORY"."H0040"
(
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0040 PRIMARY KEY ("T0005_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0040" IS 'Identification d''un établisement de santé@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0040"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0040"."vxe" IS 'jusqua::null';

-- table H0041 definition
CREATE TABLE "HORG-FR_HISTORY"."H0041"
(
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0041 PRIMARY KEY ("T0005_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0041" IS 'Identification d''un établisement de santé@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0041"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0041"."vbe" IS 'durant::null';

-- table H0042 definition
CREATE TABLE "HORG-FR_HISTORY"."H0042"
(
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0042 PRIMARY KEY ("T0005_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0042" IS 'Identification d''un établisement de santé@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0042"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0042"."vbx" IS 'depuis::null';

-- table H0043 definition
CREATE TABLE "HORG-FR_HISTORY"."H0043"
(
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0043 PRIMARY KEY ("T0006_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0043" IS 'Hopital@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0043"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0043"."vxe" IS 'jusqua::null';

-- table H0044 definition
CREATE TABLE "HORG-FR_HISTORY"."H0044"
(
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0044 PRIMARY KEY ("T0006_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0044" IS 'Hopital@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0044"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0044"."vbe" IS 'durant::null';

-- table H0045 definition
CREATE TABLE "HORG-FR_HISTORY"."H0045"
(
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0045 PRIMARY KEY ("T0006_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0045" IS 'Hopital@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0045"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0045"."vbx" IS 'depuis::null';

-- table H0046 definition
CREATE TABLE "HORG-FR_HISTORY"."H0046"
(
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0046 PRIMARY KEY ("T0007_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0046" IS 'Identification d''une unité@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0046"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0046"."vxe" IS 'jusqua::null';

-- table H0047 definition
CREATE TABLE "HORG-FR_HISTORY"."H0047"
(
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0047 PRIMARY KEY ("T0007_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0047" IS 'Identification d''une unité@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0047"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0047"."vbe" IS 'durant::null';

-- table H0048 definition
CREATE TABLE "HORG-FR_HISTORY"."H0048"
(
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0048 PRIMARY KEY ("T0007_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0048" IS 'Identification d''une unité@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0048"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0048"."vbx" IS 'depuis::null';

-- table H0049 definition
CREATE TABLE "HORG-FR_HISTORY"."H0049"
(
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0049 PRIMARY KEY ("T0008_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0049" IS 'Pôle de santé@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0049"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0049"."vxe" IS 'jusqua::null';

-- table H004a definition
CREATE TABLE "HORG-FR_HISTORY"."H004a"
(
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H004a PRIMARY KEY ("T0008_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H004a" IS 'Pôle de santé@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004a"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004a"."vbe" IS 'durant::null';

-- table H004b definition
CREATE TABLE "HORG-FR_HISTORY"."H004b"
(
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H004b PRIMARY KEY ("T0008_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H004b" IS 'Pôle de santé@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004b"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004b"."vbx" IS 'depuis::null';

-- table H004c definition
CREATE TABLE "HORG-FR_HISTORY"."H004c"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H004c PRIMARY KEY ("T0009_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H004c" IS 'Unité de responsabilité médicale clinique@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004c"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004c"."vxe" IS 'jusqua::null';

-- table H004d definition
CREATE TABLE "HORG-FR_HISTORY"."H004d"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H004d PRIMARY KEY ("T0009_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H004d" IS 'Unité de responsabilité médicale clinique@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004d"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004d"."vbe" IS 'durant::null';

-- table H004e definition
CREATE TABLE "HORG-FR_HISTORY"."H004e"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H004e PRIMARY KEY ("T0009_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H004e" IS 'Unité de responsabilité médicale clinique@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004e"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004e"."vbx" IS 'depuis::null';

-- table H004f definition
CREATE TABLE "HORG-FR_HISTORY"."H004f"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H004f PRIMARY KEY ("T000a_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H004f" IS 'Unité fonctionnelle@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004f"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H004f"."vxe" IS 'jusqua::null';

-- table H0050 definition
CREATE TABLE "HORG-FR_HISTORY"."H0050"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0050 PRIMARY KEY ("T000a_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0050" IS 'Unité fonctionnelle@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0050"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0050"."vbe" IS 'durant::null';

-- table H0051 definition
CREATE TABLE "HORG-FR_HISTORY"."H0051"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0051 PRIMARY KEY ("T000a_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0051" IS 'Unité fonctionnelle@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0051"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0051"."vbx" IS 'depuis::null';

-- table H0052 definition
CREATE TABLE "HORG-FR_HISTORY"."H0052"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0052 PRIMARY KEY ("T000b_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0052" IS 'Service et département@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0052"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0052"."vxe" IS 'jusqua::null';

-- table H0053 definition
CREATE TABLE "HORG-FR_HISTORY"."H0053"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0053 PRIMARY KEY ("T000b_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0053" IS 'Service et département@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0053"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0053"."vbe" IS 'durant::null';

-- table H0054 definition
CREATE TABLE "HORG-FR_HISTORY"."H0054"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0054 PRIMARY KEY ("T000b_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0054" IS 'Service et département@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0054"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0054"."vbx" IS 'depuis::null';

-- table H0055 definition
CREATE TABLE "HORG-FR_HISTORY"."H0055"
(
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0055 PRIMARY KEY ("T000c_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0055" IS 'Spécialité médicale@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0055"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0055"."vxe" IS 'jusqua::null';

-- table H0056 definition
CREATE TABLE "HORG-FR_HISTORY"."H0056"
(
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0056 PRIMARY KEY ("T000c_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0056" IS 'Spécialité médicale@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0056"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0056"."vbe" IS 'durant::null';

-- table H0057 definition
CREATE TABLE "HORG-FR_HISTORY"."H0057"
(
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0057 PRIMARY KEY ("T000c_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0057" IS 'Spécialité médicale@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0057"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0057"."vbx" IS 'depuis::null';

-- table H0058 definition
CREATE TABLE "HORG-FR_HISTORY"."H0058"
(
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0058 PRIMARY KEY ("T000d_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0058" IS 'Discipline@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0058"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0058"."vxe" IS 'jusqua::null';

-- table H0059 definition
CREATE TABLE "HORG-FR_HISTORY"."H0059"
(
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0059 PRIMARY KEY ("T000d_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0059" IS 'Discipline@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0059"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0059"."vbe" IS 'durant::null';

-- table H005a definition
CREATE TABLE "HORG-FR_HISTORY"."H005a"
(
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H005a PRIMARY KEY ("T000d_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H005a" IS 'Discipline@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005a"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005a"."vbx" IS 'depuis::null';

-- table H005b definition
CREATE TABLE "HORG-FR_HISTORY"."H005b"
(
  "T000e_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H005b PRIMARY KEY ("T000e_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H005b" IS 'Groupe hospitalier@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005b"."T000e_dbid" IS 'dbid Groupe hospitalier::Clé primaire par défaut de Groupe hospitalier';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005b"."vxe" IS 'jusqua::null';

-- table H005c definition
CREATE TABLE "HORG-FR_HISTORY"."H005c"
(
  "T000e_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H005c PRIMARY KEY ("T000e_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H005c" IS 'Groupe hospitalier@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005c"."T000e_dbid" IS 'dbid Groupe hospitalier::Clé primaire par défaut de Groupe hospitalier';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005c"."vbe" IS 'durant::null';

-- table H005d definition
CREATE TABLE "HORG-FR_HISTORY"."H005d"
(
  "T000e_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H005d PRIMARY KEY ("T000e_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H005d" IS 'Groupe hospitalier@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005d"."T000e_dbid" IS 'dbid Groupe hospitalier::Clé primaire par défaut de Groupe hospitalier';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005d"."vbx" IS 'depuis::null';

-- table H005e definition
CREATE TABLE "HORG-FR_HISTORY"."H005e"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H005e PRIMARY KEY ("T000f_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H005e" IS 'Identification d''un agent@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005e"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005e"."vxe" IS 'jusqua::null';

-- table H005f definition
CREATE TABLE "HORG-FR_HISTORY"."H005f"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H005f PRIMARY KEY ("T000f_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H005f" IS 'Identification d''un agent@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005f"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H005f"."vbe" IS 'durant::null';

-- table H0060 definition
CREATE TABLE "HORG-FR_HISTORY"."H0060"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0060 PRIMARY KEY ("T000f_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0060" IS 'Identification d''un agent@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0060"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0060"."vbx" IS 'depuis::null';

-- table H0061 definition
CREATE TABLE "HORG-FR_HISTORY"."H0061"
(
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0061 PRIMARY KEY ("T0010_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0061" IS 'Unité médico-administrative@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0061"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0061"."vxe" IS 'jusqua::null';

-- table H0062 definition
CREATE TABLE "HORG-FR_HISTORY"."H0062"
(
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0062 PRIMARY KEY ("T0010_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0062" IS 'Unité médico-administrative@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0062"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0062"."vbe" IS 'durant::null';

-- table H0063 definition
CREATE TABLE "HORG-FR_HISTORY"."H0063"
(
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0063 PRIMARY KEY ("T0010_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0063" IS 'Unité médico-administrative@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0063"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0063"."vbx" IS 'depuis::null';

-- table H0064 definition
CREATE TABLE "HORG-FR_HISTORY"."H0064"
(
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0064 PRIMARY KEY ("T000c_dbid", "T0011_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0064" IS 'Spécialité médicale a etiquette string@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0064"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0064"."T0011_dbid" IS 'dbid string::Clé primaire par défaut de string';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0064"."vxe" IS 'jusqua::null';

-- table H0065 definition
CREATE TABLE "HORG-FR_HISTORY"."H0065"
(
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0065 PRIMARY KEY ("T000c_dbid", "T0011_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0065" IS 'Spécialité médicale a etiquette string@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0065"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0065"."T0011_dbid" IS 'dbid string::Clé primaire par défaut de string';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0065"."vbe" IS 'durant::null';

-- table H0066 definition
CREATE TABLE "HORG-FR_HISTORY"."H0066"
(
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0066 PRIMARY KEY ("T000c_dbid", "T0011_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0066" IS 'Spécialité médicale a etiquette string@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0066"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0066"."T0011_dbid" IS 'dbid string::Clé primaire par défaut de string';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0066"."vbx" IS 'depuis::null';

-- table H0067 definition
CREATE TABLE "HORG-FR_HISTORY"."H0067"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0013_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0067 PRIMARY KEY ("T000f_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0067" IS 'Identification d''un agent identifier Identifiant d''un agent@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0067"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0067"."T0013_dbid" IS 'dbid Identifiant d''un agent::Clé primaire par défaut de Identifiant d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0067"."vxe" IS 'jusqua::null';

-- table H0068 definition
CREATE TABLE "HORG-FR_HISTORY"."H0068"
(
  "T0013_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0068 PRIMARY KEY ("T000f_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0068" IS 'Identification d''un agent identifier Identifiant d''un agent@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0068"."T0013_dbid" IS 'dbid Identifiant d''un agent::Clé primaire par défaut de Identifiant d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0068"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0068"."vbe" IS 'durant::null';

-- table H0069 definition
CREATE TABLE "HORG-FR_HISTORY"."H0069"
(
  "T0013_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0069 PRIMARY KEY ("T000f_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0069" IS 'Identification d''un agent identifier Identifiant d''un agent@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0069"."T0013_dbid" IS 'dbid Identifiant d''un agent::Clé primaire par défaut de Identifiant d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0069"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0069"."vbx" IS 'depuis::null';

-- table H006a definition
CREATE TABLE "HORG-FR_HISTORY"."H006a"
(
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0015_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H006a PRIMARY KEY ("T000d_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H006a" IS 'Discipline a code Code de discipline médicale@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006a"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006a"."T0015_dbid" IS 'dbid Code de discipline médicale::Clé primaire par défaut de Code de discipline médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006a"."vxe" IS 'jusqua::null';

-- table H006b definition
CREATE TABLE "HORG-FR_HISTORY"."H006b"
(
  "T0015_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H006b PRIMARY KEY ("T000d_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H006b" IS 'Discipline a code Code de discipline médicale@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006b"."T0015_dbid" IS 'dbid Code de discipline médicale::Clé primaire par défaut de Code de discipline médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006b"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006b"."vbe" IS 'durant::null';

-- table H006c definition
CREATE TABLE "HORG-FR_HISTORY"."H006c"
(
  "T0015_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H006c PRIMARY KEY ("T000d_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H006c" IS 'Discipline a code Code de discipline médicale@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006c"."T0015_dbid" IS 'dbid Code de discipline médicale::Clé primaire par défaut de Code de discipline médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006c"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006c"."vbx" IS 'depuis::null';

-- table H006d definition
CREATE TABLE "HORG-FR_HISTORY"."H006d"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0017_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H006d PRIMARY KEY ("T000f_dbid", "T0017_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H006d" IS 'Identification d''un agent a etiquette Libellé d''un agent@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006d"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006d"."T0017_dbid" IS 'dbid Libellé d''un agent::Clé primaire par défaut de Libellé d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006d"."vxe" IS 'jusqua::null';

-- table H006e definition
CREATE TABLE "HORG-FR_HISTORY"."H006e"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0017_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H006e PRIMARY KEY ("T000f_dbid", "T0017_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H006e" IS 'Identification d''un agent a etiquette Libellé d''un agent@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006e"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006e"."T0017_dbid" IS 'dbid Libellé d''un agent::Clé primaire par défaut de Libellé d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006e"."vbe" IS 'durant::null';

-- table H006f definition
CREATE TABLE "HORG-FR_HISTORY"."H006f"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0017_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H006f PRIMARY KEY ("T000f_dbid", "T0017_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H006f" IS 'Identification d''un agent a etiquette Libellé d''un agent@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006f"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006f"."T0017_dbid" IS 'dbid Libellé d''un agent::Clé primaire par défaut de Libellé d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H006f"."vbx" IS 'depuis::null';

-- table H0070 definition
CREATE TABLE "HORG-FR_HISTORY"."H0070"
(
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0070 PRIMARY KEY ("T000d_dbid", "T0011_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0070" IS 'Discipline a etiquette string@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0070"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0070"."T0011_dbid" IS 'dbid string::Clé primaire par défaut de string';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0070"."vxe" IS 'jusqua::null';

-- table H0071 definition
CREATE TABLE "HORG-FR_HISTORY"."H0071"
(
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0071 PRIMARY KEY ("T000d_dbid", "T0011_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0071" IS 'Discipline a etiquette string@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0071"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0071"."T0011_dbid" IS 'dbid string::Clé primaire par défaut de string';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0071"."vbe" IS 'durant::null';

-- table H0072 definition
CREATE TABLE "HORG-FR_HISTORY"."H0072"
(
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0072 PRIMARY KEY ("T000d_dbid", "T0011_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0072" IS 'Discipline a etiquette string@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0072"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0072"."T0011_dbid" IS 'dbid string::Clé primaire par défaut de string';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0072"."vbx" IS 'depuis::null';

-- table H0073 definition
CREATE TABLE "HORG-FR_HISTORY"."H0073"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T001a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0073 PRIMARY KEY ("T0009_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0073" IS 'Unité de responsabilité médicale clinique a code Champ PMSI@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0073"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0073"."T001a_dbid" IS 'dbid Champ PMSI::Clé primaire par défaut de Champ PMSI';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0073"."vxe" IS 'jusqua::null';

-- table H0074 definition
CREATE TABLE "HORG-FR_HISTORY"."H0074"
(
  "T001a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0074 PRIMARY KEY ("T0009_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0074" IS 'Unité de responsabilité médicale clinique a code Champ PMSI@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0074"."T001a_dbid" IS 'dbid Champ PMSI::Clé primaire par défaut de Champ PMSI';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0074"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0074"."vbe" IS 'durant::null';

-- table H0075 definition
CREATE TABLE "HORG-FR_HISTORY"."H0075"
(
  "T001a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0075 PRIMARY KEY ("T0009_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0075" IS 'Unité de responsabilité médicale clinique a code Champ PMSI@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0075"."T001a_dbid" IS 'dbid Champ PMSI::Clé primaire par défaut de Champ PMSI';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0075"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0075"."vbx" IS 'depuis::null';

-- table H0076 definition
CREATE TABLE "HORG-FR_HISTORY"."H0076"
(
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T001c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0076 PRIMARY KEY ("T000c_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0076" IS 'Spécialité médicale a code Code de spécialité médicale@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0076"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0076"."T001c_dbid" IS 'dbid Code de spécialité médicale::Clé primaire par défaut de Code de spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0076"."vxe" IS 'jusqua::null';

-- table H0077 definition
CREATE TABLE "HORG-FR_HISTORY"."H0077"
(
  "T001c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0077 PRIMARY KEY ("T000c_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0077" IS 'Spécialité médicale a code Code de spécialité médicale@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0077"."T001c_dbid" IS 'dbid Code de spécialité médicale::Clé primaire par défaut de Code de spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0077"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0077"."vbe" IS 'durant::null';

-- table H0078 definition
CREATE TABLE "HORG-FR_HISTORY"."H0078"
(
  "T001c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0078 PRIMARY KEY ("T000c_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0078" IS 'Spécialité médicale a code Code de spécialité médicale@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0078"."T001c_dbid" IS 'dbid Code de spécialité médicale::Clé primaire par défaut de Code de spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0078"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0078"."vbx" IS 'depuis::null';

-- table H0079 definition
CREATE TABLE "HORG-FR_HISTORY"."H0079"
(
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0079 PRIMARY KEY ("T0001_dbid", "T0008_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0079" IS 'Unité de gestion unitOf Pôle de santé@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0079"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0079"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0079"."vxe" IS 'jusqua::null';

-- table H007a definition
CREATE TABLE "HORG-FR_HISTORY"."H007a"
(
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H007a PRIMARY KEY ("T0001_dbid", "T0008_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H007a" IS 'Unité de gestion unitOf Pôle de santé@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007a"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007a"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007a"."vbe" IS 'durant::null';

-- table H007b definition
CREATE TABLE "HORG-FR_HISTORY"."H007b"
(
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H007b PRIMARY KEY ("T0001_dbid", "T0008_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H007b" IS 'Unité de gestion unitOf Pôle de santé@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007b"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007b"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007b"."vbx" IS 'depuis::null';

-- table H007c definition
CREATE TABLE "HORG-FR_HISTORY"."H007c"
(
  "T0002_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H007c PRIMARY KEY ("T0002_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H007c" IS 'Unité organisationnelle a identifiant Identification d''une unité@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007c"."T0002_dbid" IS 'dbid Unité organisationnelle::Clé primaire par défaut de Unité organisationnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007c"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007c"."vxe" IS 'jusqua::null';

-- table H007d definition
CREATE TABLE "HORG-FR_HISTORY"."H007d"
(
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0002_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H007d PRIMARY KEY ("T0002_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H007d" IS 'Unité organisationnelle a identifiant Identification d''une unité@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007d"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007d"."T0002_dbid" IS 'dbid Unité organisationnelle::Clé primaire par défaut de Unité organisationnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007d"."vbe" IS 'durant::null';

-- table H007e definition
CREATE TABLE "HORG-FR_HISTORY"."H007e"
(
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0002_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H007e PRIMARY KEY ("T0002_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H007e" IS 'Unité organisationnelle a identifiant Identification d''une unité@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007e"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007e"."T0002_dbid" IS 'dbid Unité organisationnelle::Clé primaire par défaut de Unité organisationnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007e"."vbx" IS 'depuis::null';

-- table H007f definition
CREATE TABLE "HORG-FR_HISTORY"."H007f"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H007f PRIMARY KEY ("T0003_dbid", "T000b_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H007f" IS 'Unité hospitalière linkedTo Service et département@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007f"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007f"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H007f"."vxe" IS 'jusqua::null';

-- table H0080 definition
CREATE TABLE "HORG-FR_HISTORY"."H0080"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0080 PRIMARY KEY ("T0003_dbid", "T000b_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0080" IS 'Unité hospitalière linkedTo Service et département@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0080"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0080"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0080"."vbe" IS 'durant::null';

-- table H0081 definition
CREATE TABLE "HORG-FR_HISTORY"."H0081"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0081 PRIMARY KEY ("T0003_dbid", "T000b_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0081" IS 'Unité hospitalière linkedTo Service et département@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0081"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0081"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0081"."vbx" IS 'depuis::null';

-- table H0082 definition
CREATE TABLE "HORG-FR_HISTORY"."H0082"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0082 PRIMARY KEY ("T0003_dbid", "T0010_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0082" IS 'Unité hospitalière unitOf Unité médico-administrative@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0082"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0082"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0082"."vxe" IS 'jusqua::null';

-- table H0083 definition
CREATE TABLE "HORG-FR_HISTORY"."H0083"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0083 PRIMARY KEY ("T0003_dbid", "T0010_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0083" IS 'Unité hospitalière unitOf Unité médico-administrative@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0083"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0083"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0083"."vbe" IS 'durant::null';

-- table H0084 definition
CREATE TABLE "HORG-FR_HISTORY"."H0084"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0084 PRIMARY KEY ("T0003_dbid", "T0010_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0084" IS 'Unité hospitalière unitOf Unité médico-administrative@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0084"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0084"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0084"."vbx" IS 'depuis::null';

-- table H0085 definition
CREATE TABLE "HORG-FR_HISTORY"."H0085"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0085 PRIMARY KEY ("T0003_dbid", "T0004_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0085" IS 'Unité hospitalière linkedTo Unité administrative@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0085"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0085"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0085"."vxe" IS 'jusqua::null';

-- table H0086 definition
CREATE TABLE "HORG-FR_HISTORY"."H0086"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0086 PRIMARY KEY ("T0003_dbid", "T0004_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0086" IS 'Unité hospitalière linkedTo Unité administrative@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0086"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0086"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0086"."vbe" IS 'durant::null';

-- table H0087 definition
CREATE TABLE "HORG-FR_HISTORY"."H0087"
(
  "T0003_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0087 PRIMARY KEY ("T0003_dbid", "T0004_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0087" IS 'Unité hospitalière linkedTo Unité administrative@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0087"."T0003_dbid" IS 'dbid Unité hospitalière::Clé primaire par défaut de Unité hospitalière';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0087"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0087"."vbx" IS 'depuis::null';

-- table H0088 definition
CREATE TABLE "HORG-FR_HISTORY"."H0088"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0088 PRIMARY KEY ("T0004_dbid", "T000b_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0088" IS 'Unité administrative linkedTo Service et département@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0088"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0088"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0088"."vxe" IS 'jusqua::null';

-- table H0089 definition
CREATE TABLE "HORG-FR_HISTORY"."H0089"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0089 PRIMARY KEY ("T0004_dbid", "T000b_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0089" IS 'Unité administrative linkedTo Service et département@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0089"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0089"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0089"."vbe" IS 'durant::null';

-- table H008a definition
CREATE TABLE "HORG-FR_HISTORY"."H008a"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H008a PRIMARY KEY ("T0004_dbid", "T000b_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H008a" IS 'Unité administrative linkedTo Service et département@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008a"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008a"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008a"."vbx" IS 'depuis::null';

-- table H008b definition
CREATE TABLE "HORG-FR_HISTORY"."H008b"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H008b PRIMARY KEY ("T0004_dbid", "T0001_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H008b" IS 'Unité administrative unitOf Unité de gestion@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008b"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008b"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008b"."vxe" IS 'jusqua::null';

-- table H008c definition
CREATE TABLE "HORG-FR_HISTORY"."H008c"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H008c PRIMARY KEY ("T0004_dbid", "T0001_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H008c" IS 'Unité administrative unitOf Unité de gestion@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008c"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008c"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008c"."vbe" IS 'durant::null';

-- table H008d definition
CREATE TABLE "HORG-FR_HISTORY"."H008d"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H008d PRIMARY KEY ("T0004_dbid", "T0001_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H008d" IS 'Unité administrative unitOf Unité de gestion@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008d"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008d"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008d"."vbx" IS 'depuis::null';

-- table H008e definition
CREATE TABLE "HORG-FR_HISTORY"."H008e"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H008e PRIMARY KEY ("T0004_dbid", "T000d_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H008e" IS 'Unité administrative a une valeur spécifiée Discipline@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008e"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008e"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008e"."vxe" IS 'jusqua::null';

-- table H008f definition
CREATE TABLE "HORG-FR_HISTORY"."H008f"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H008f PRIMARY KEY ("T0004_dbid", "T000d_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H008f" IS 'Unité administrative a une valeur spécifiée Discipline@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008f"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008f"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H008f"."vbe" IS 'durant::null';

-- table H0090 definition
CREATE TABLE "HORG-FR_HISTORY"."H0090"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0090 PRIMARY KEY ("T0004_dbid", "T000d_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0090" IS 'Unité administrative a une valeur spécifiée Discipline@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0090"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0090"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0090"."vbx" IS 'depuis::null';

-- table H0091 definition
CREATE TABLE "HORG-FR_HISTORY"."H0091"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0091 PRIMARY KEY ("T0004_dbid", "T0010_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0091" IS 'Unité administrative linkedTo Unité médico-administrative@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0091"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0091"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0091"."vxe" IS 'jusqua::null';

-- table H0092 definition
CREATE TABLE "HORG-FR_HISTORY"."H0092"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0092 PRIMARY KEY ("T0004_dbid", "T0010_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0092" IS 'Unité administrative linkedTo Unité médico-administrative@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0092"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0092"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0092"."vbe" IS 'durant::null';

-- table H0093 definition
CREATE TABLE "HORG-FR_HISTORY"."H0093"
(
  "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0093 PRIMARY KEY ("T0004_dbid", "T0010_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0093" IS 'Unité administrative linkedTo Unité médico-administrative@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0093"."T0004_dbid" IS 'dbid Unité administrative::Clé primaire par défaut de Unité administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0093"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0093"."vbx" IS 'depuis::null';

-- table H0094 definition
CREATE TABLE "HORG-FR_HISTORY"."H0094"
(
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0094 PRIMARY KEY ("T0006_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0094" IS 'Hopital a identifiant Identification d''un établisement de santé@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0094"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0094"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0094"."vxe" IS 'jusqua::null';

-- table H0095 definition
CREATE TABLE "HORG-FR_HISTORY"."H0095"
(
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0095 PRIMARY KEY ("T0006_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0095" IS 'Hopital a identifiant Identification d''un établisement de santé@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0095"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0095"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0095"."vbe" IS 'durant::null';

-- table H0096 definition
CREATE TABLE "HORG-FR_HISTORY"."H0096"
(
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0096 PRIMARY KEY ("T0006_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0096" IS 'Hopital a identifiant Identification d''un établisement de santé@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0096"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0096"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0096"."vbx" IS 'depuis::null';

-- table H0097 definition
CREATE TABLE "HORG-FR_HISTORY"."H0097"
(
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0097 PRIMARY KEY ("T0007_dbid", "T0005_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0097" IS 'Identification d''une unité a une valeur spécifiée Identification d''un établisement de santé@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0097"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0097"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0097"."vxe" IS 'jusqua::null';

-- table H0098 definition
CREATE TABLE "HORG-FR_HISTORY"."H0098"
(
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H0098 PRIMARY KEY ("T0007_dbid", "T0005_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0098" IS 'Identification d''une unité a une valeur spécifiée Identification d''un établisement de santé@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0098"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0098"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0098"."vbe" IS 'durant::null';

-- table H0099 definition
CREATE TABLE "HORG-FR_HISTORY"."H0099"
(
  "T0007_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H0099 PRIMARY KEY ("T0007_dbid", "T0005_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H0099" IS 'Identification d''une unité a une valeur spécifiée Identification d''un établisement de santé@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0099"."T0007_dbid" IS 'dbid Identification d''une unité::Clé primaire par défaut de Identification d''une unité';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0099"."T0005_dbid" IS 'dbid Identification d''un établisement de santé::Clé primaire par défaut de Identification d''un établisement de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H0099"."vbx" IS 'depuis::null';

-- table H009a definition
CREATE TABLE "HORG-FR_HISTORY"."H009a"
(
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H009a PRIMARY KEY ("T0008_dbid", "T0006_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H009a" IS 'Pôle de santé unitOf Hopital@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009a"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009a"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009a"."vxe" IS 'jusqua::null';

-- table H009b definition
CREATE TABLE "HORG-FR_HISTORY"."H009b"
(
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H009b PRIMARY KEY ("T0008_dbid", "T0006_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H009b" IS 'Pôle de santé unitOf Hopital@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009b"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009b"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009b"."vbe" IS 'durant::null';

-- table H009c definition
CREATE TABLE "HORG-FR_HISTORY"."H009c"
(
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H009c PRIMARY KEY ("T0008_dbid", "T0006_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H009c" IS 'Pôle de santé unitOf Hopital@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009c"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009c"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009c"."vbx" IS 'depuis::null';

-- table H009d definition
CREATE TABLE "HORG-FR_HISTORY"."H009d"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H009d PRIMARY KEY ("T0009_dbid", "T000d_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H009d" IS 'Unité de responsabilité médicale clinique a une valeur spécifiée Discipline@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009d"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009d"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009d"."vxe" IS 'jusqua::null';

-- table H009e definition
CREATE TABLE "HORG-FR_HISTORY"."H009e"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H009e PRIMARY KEY ("T0009_dbid", "T000d_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H009e" IS 'Unité de responsabilité médicale clinique a une valeur spécifiée Discipline@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009e"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009e"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009e"."vbe" IS 'durant::null';

-- table H009f definition
CREATE TABLE "HORG-FR_HISTORY"."H009f"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H009f PRIMARY KEY ("T0009_dbid", "T000d_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H009f" IS 'Unité de responsabilité médicale clinique a une valeur spécifiée Discipline@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009f"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009f"."T000d_dbid" IS 'dbid Discipline::Clé primaire par défaut de Discipline';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H009f"."vbx" IS 'depuis::null';

-- table H00a0 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a0"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00a0 PRIMARY KEY ("T0009_dbid", "T0010_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a0" IS 'Unité de responsabilité médicale clinique unitOf Unité médico-administrative@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a0"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a0"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a0"."vxe" IS 'jusqua::null';

-- table H00a1 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a1"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00a1 PRIMARY KEY ("T0009_dbid", "T0010_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a1" IS 'Unité de responsabilité médicale clinique unitOf Unité médico-administrative@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a1"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a1"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a1"."vbe" IS 'durant::null';

-- table H00a2 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a2"
(
  "T0009_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00a2 PRIMARY KEY ("T0009_dbid", "T0010_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a2" IS 'Unité de responsabilité médicale clinique unitOf Unité médico-administrative@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a2"."T0009_dbid" IS 'dbid Unité de responsabilité médicale clinique::Clé primaire par défaut de Unité de responsabilité médicale clinique';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a2"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a2"."vbx" IS 'depuis::null';

-- table H00a3 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a3"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00a3 PRIMARY KEY ("T000a_dbid", "T000c_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a3" IS 'Unité fonctionnelle a une valeur spécifiée Spécialité médicale@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a3"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a3"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a3"."vxe" IS 'jusqua::null';

-- table H00a4 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a4"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00a4 PRIMARY KEY ("T000a_dbid", "T000c_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a4" IS 'Unité fonctionnelle a une valeur spécifiée Spécialité médicale@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a4"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a4"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a4"."vbe" IS 'durant::null';

-- table H00a5 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a5"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00a5 PRIMARY KEY ("T000a_dbid", "T000c_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a5" IS 'Unité fonctionnelle a une valeur spécifiée Spécialité médicale@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a5"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a5"."T000c_dbid" IS 'dbid Spécialité médicale::Clé primaire par défaut de Spécialité médicale';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a5"."vbx" IS 'depuis::null';

-- table H00a6 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a6"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00a6 PRIMARY KEY ("T000a_dbid", "T0008_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a6" IS 'Unité fonctionnelle unitOf Pôle de santé@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a6"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a6"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a6"."vxe" IS 'jusqua::null';

-- table H00a7 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a7"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00a7 PRIMARY KEY ("T000a_dbid", "T0008_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a7" IS 'Unité fonctionnelle unitOf Pôle de santé@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a7"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a7"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a7"."vbe" IS 'durant::null';

-- table H00a8 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a8"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00a8 PRIMARY KEY ("T000a_dbid", "T0008_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a8" IS 'Unité fonctionnelle unitOf Pôle de santé@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a8"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a8"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a8"."vbx" IS 'depuis::null';

-- table H00a9 definition
CREATE TABLE "HORG-FR_HISTORY"."H00a9"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00a9 PRIMARY KEY ("T000a_dbid", "T000b_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00a9" IS 'Unité fonctionnelle linkedTo Service et département@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a9"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a9"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00a9"."vxe" IS 'jusqua::null';

-- table H00aa definition
CREATE TABLE "HORG-FR_HISTORY"."H00aa"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00aa PRIMARY KEY ("T000a_dbid", "T000b_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00aa" IS 'Unité fonctionnelle linkedTo Service et département@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00aa"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00aa"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00aa"."vbe" IS 'durant::null';

-- table H00ab definition
CREATE TABLE "HORG-FR_HISTORY"."H00ab"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00ab PRIMARY KEY ("T000a_dbid", "T000b_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00ab" IS 'Unité fonctionnelle linkedTo Service et département@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ab"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ab"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ab"."vbx" IS 'depuis::null';

-- table H00ac definition
CREATE TABLE "HORG-FR_HISTORY"."H00ac"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00ac PRIMARY KEY ("T000a_dbid", "T0001_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00ac" IS 'Unité fonctionnelle linkedTo Unité de gestion@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ac"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ac"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ac"."vxe" IS 'jusqua::null';

-- table H00ad definition
CREATE TABLE "HORG-FR_HISTORY"."H00ad"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00ad PRIMARY KEY ("T000a_dbid", "T0001_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00ad" IS 'Unité fonctionnelle linkedTo Unité de gestion@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ad"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ad"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ad"."vbe" IS 'durant::null';

-- table H00ae definition
CREATE TABLE "HORG-FR_HISTORY"."H00ae"
(
  "T000a_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00ae PRIMARY KEY ("T000a_dbid", "T0001_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00ae" IS 'Unité fonctionnelle linkedTo Unité de gestion@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ae"."T000a_dbid" IS 'dbid Unité fonctionnelle::Clé primaire par défaut de Unité fonctionnelle';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ae"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ae"."vbx" IS 'depuis::null';

-- table H00af definition
CREATE TABLE "HORG-FR_HISTORY"."H00af"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00af PRIMARY KEY ("T000b_dbid", "T0006_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00af" IS 'Service et département unitOf Hopital@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00af"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00af"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00af"."vxe" IS 'jusqua::null';

-- table H00b0 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b0"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00b0 PRIMARY KEY ("T000b_dbid", "T0006_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b0" IS 'Service et département unitOf Hopital@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b0"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b0"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b0"."vbe" IS 'durant::null';

-- table H00b1 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b1"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00b1 PRIMARY KEY ("T000b_dbid", "T0006_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b1" IS 'Service et département unitOf Hopital@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b1"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b1"."T0006_dbid" IS 'dbid Hopital::Clé primaire par défaut de Hopital';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b1"."vbx" IS 'depuis::null';

-- table H00b2 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b2"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00b2 PRIMARY KEY ("T000b_dbid", "T0008_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b2" IS 'Service et département linkedTo Pôle de santé@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b2"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b2"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b2"."vxe" IS 'jusqua::null';

-- table H00b3 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b3"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00b3 PRIMARY KEY ("T000b_dbid", "T0008_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b3" IS 'Service et département linkedTo Pôle de santé@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b3"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b3"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b3"."vbe" IS 'durant::null';

-- table H00b4 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b4"
(
  "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00b4 PRIMARY KEY ("T000b_dbid", "T0008_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b4" IS 'Service et département linkedTo Pôle de santé@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b4"."T000b_dbid" IS 'dbid Service et département::Clé primaire par défaut de Service et département';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b4"."T0008_dbid" IS 'dbid Pôle de santé::Clé primaire par défaut de Pôle de santé';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b4"."vbx" IS 'depuis::null';

-- table H00b5 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b5"
(
  "T000e_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00b5 PRIMARY KEY ("T000e_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b5" IS 'Groupe hospitalier a identifiant Identification d''un agent@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b5"."T000e_dbid" IS 'dbid Groupe hospitalier::Clé primaire par défaut de Groupe hospitalier';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b5"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b5"."vxe" IS 'jusqua::null';

-- table H00b6 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b6"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000e_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00b6 PRIMARY KEY ("T000e_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b6" IS 'Groupe hospitalier a identifiant Identification d''un agent@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b6"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b6"."T000e_dbid" IS 'dbid Groupe hospitalier::Clé primaire par défaut de Groupe hospitalier';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b6"."vbe" IS 'durant::null';

-- table H00b7 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b7"
(
  "T000f_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T000e_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00b7 PRIMARY KEY ("T000e_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b7" IS 'Groupe hospitalier a identifiant Identification d''un agent@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b7"."T000f_dbid" IS 'dbid Identification d''un agent::Clé primaire par défaut de Identification d''un agent';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b7"."T000e_dbid" IS 'dbid Groupe hospitalier::Clé primaire par défaut de Groupe hospitalier';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b7"."vbx" IS 'depuis::null';

-- table H00b8 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b8"
(
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vxe" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00b8 PRIMARY KEY ("T0010_dbid", "T0001_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b8" IS 'Unité médico-administrative unitOf Unité de gestion@jusqua::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b8"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b8"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b8"."vxe" IS 'jusqua::null';

-- table H00b9 definition
CREATE TABLE "HORG-FR_HISTORY"."H00b9"
(
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbe" "HORG-FR_HISTORY"."PERIOD"  NOT NULL,
  CONSTRAINT key_H00b9 PRIMARY KEY ("T0010_dbid", "T0001_dbid", "vbe")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00b9" IS 'Unité médico-administrative unitOf Unité de gestion@durant::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b9"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b9"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00b9"."vbe" IS 'durant::null';

-- table H00ba definition
CREATE TABLE "HORG-FR_HISTORY"."H00ba"
(
  "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain"  NOT NULL,
  "vbx" "HORG-FR_HISTORY"."POINT"  NOT NULL,
  CONSTRAINT key_H00ba PRIMARY KEY ("T0010_dbid", "T0001_dbid")
);

COMMENT ON TABLE "HORG-FR_HISTORY"."H00ba" IS 'Unité médico-administrative unitOf Unité de gestion@depuis::null';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ba"."T0010_dbid" IS 'dbid Unité médico-administrative::Clé primaire par défaut de Unité médico-administrative';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ba"."T0001_dbid" IS 'dbid Unité de gestion::Clé primaire par défaut de Unité de gestion';

COMMENT ON COLUMN "HORG-FR_HISTORY"."H00ba"."vbx" IS 'depuis::null';

-- Unique key definition : T0017
ALTER TABLE "HORG-FR_HISTORY"."T0017"
  ADD CONSTRAINT ck1_T0017 UNIQUE ("AGENTLABEL");

-- Unique key definition : T0011
ALTER TABLE "HORG-FR_HISTORY"."T0011"
  ADD CONSTRAINT ck1_T0011 UNIQUE ("string");

-- Unique key definition : T001a
ALTER TABLE "HORG-FR_HISTORY"."T001a"
  ADD CONSTRAINT ck1_T001a UNIQUE ("PMSI");

-- Unique key definition : T001c
ALTER TABLE "HORG-FR_HISTORY"."T001c"
  ADD CONSTRAINT ck1_T001c UNIQUE ("MEDICALSPECODE");

-- Unique key definition : T0013
ALTER TABLE "HORG-FR_HISTORY"."T0013"
  ADD CONSTRAINT ck1_T0013 UNIQUE ("AGENTID");

-- Unique key definition : T0015
ALTER TABLE "HORG-FR_HISTORY"."T0015"
  ADD CONSTRAINT ck1_T0015 UNIQUE ("DISCIPLINECODE");

-- Foreign key definition : H0064 -> T0011
ALTER TABLE "HORG-FR_HISTORY"."H0064"
  ADD CONSTRAINT fk0_H0064 FOREIGN KEY ("T0011_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0011" ("T0011_dbid");

COMMENT ON CONSTRAINT fk0_H0064 ON "HORG-FR_HISTORY"."H0064" IS 'Spécialité médicale a etiquette string@jusqua -> string';

-- Foreign key definition : H0065 -> T0011
ALTER TABLE "HORG-FR_HISTORY"."H0065"
  ADD CONSTRAINT fk0_H0065 FOREIGN KEY ("T0011_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0011" ("T0011_dbid");

COMMENT ON CONSTRAINT fk0_H0065 ON "HORG-FR_HISTORY"."H0065" IS 'Spécialité médicale a etiquette string@durant -> string';

-- Foreign key definition : H0066 -> T0011
ALTER TABLE "HORG-FR_HISTORY"."H0066"
  ADD CONSTRAINT fk0_H0066 FOREIGN KEY ("T0011_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0011" ("T0011_dbid");

COMMENT ON CONSTRAINT fk0_H0066 ON "HORG-FR_HISTORY"."H0066" IS 'Spécialité médicale a etiquette string@depuis -> string';

-- Foreign key definition : H0067 -> T0013
ALTER TABLE "HORG-FR_HISTORY"."H0067"
  ADD CONSTRAINT fk0_H0067 FOREIGN KEY ("T0013_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0013" ("T0013_dbid");

COMMENT ON CONSTRAINT fk0_H0067 ON "HORG-FR_HISTORY"."H0067" IS 'Identification d''un agent identifier Identifiant d''un agent@jusqua -> Identifiant d''un agent';

-- Foreign key definition : H0068 -> T0013
ALTER TABLE "HORG-FR_HISTORY"."H0068"
  ADD CONSTRAINT fk0_H0068 FOREIGN KEY ("T0013_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0013" ("T0013_dbid");

COMMENT ON CONSTRAINT fk0_H0068 ON "HORG-FR_HISTORY"."H0068" IS 'Identification d''un agent identifier Identifiant d''un agent@durant -> Identifiant d''un agent';

-- Foreign key definition : H0069 -> T0013
ALTER TABLE "HORG-FR_HISTORY"."H0069"
  ADD CONSTRAINT fk0_H0069 FOREIGN KEY ("T0013_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0013" ("T0013_dbid");

COMMENT ON CONSTRAINT fk0_H0069 ON "HORG-FR_HISTORY"."H0069" IS 'Identification d''un agent identifier Identifiant d''un agent@depuis -> Identifiant d''un agent';

-- Foreign key definition : H006a -> T0015
ALTER TABLE "HORG-FR_HISTORY"."H006a"
  ADD CONSTRAINT fk0_H006a FOREIGN KEY ("T0015_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0015" ("T0015_dbid");

COMMENT ON CONSTRAINT fk0_H006a ON "HORG-FR_HISTORY"."H006a" IS 'Discipline a code Code de discipline médicale@jusqua -> Code de discipline médicale';

-- Foreign key definition : H006b -> T0015
ALTER TABLE "HORG-FR_HISTORY"."H006b"
  ADD CONSTRAINT fk0_H006b FOREIGN KEY ("T0015_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0015" ("T0015_dbid");

COMMENT ON CONSTRAINT fk0_H006b ON "HORG-FR_HISTORY"."H006b" IS 'Discipline a code Code de discipline médicale@durant -> Code de discipline médicale';

-- Foreign key definition : H006c -> T0015
ALTER TABLE "HORG-FR_HISTORY"."H006c"
  ADD CONSTRAINT fk0_H006c FOREIGN KEY ("T0015_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0015" ("T0015_dbid");

COMMENT ON CONSTRAINT fk0_H006c ON "HORG-FR_HISTORY"."H006c" IS 'Discipline a code Code de discipline médicale@depuis -> Code de discipline médicale';

-- Foreign key definition : H006d -> T0017
ALTER TABLE "HORG-FR_HISTORY"."H006d"
  ADD CONSTRAINT fk0_H006d FOREIGN KEY ("T0017_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0017" ("T0017_dbid");

COMMENT ON CONSTRAINT fk0_H006d ON "HORG-FR_HISTORY"."H006d" IS 'Identification d''un agent a etiquette Libellé d''un agent@jusqua -> Libellé d''un agent';

-- Foreign key definition : H006e -> T0017
ALTER TABLE "HORG-FR_HISTORY"."H006e"
  ADD CONSTRAINT fk0_H006e FOREIGN KEY ("T0017_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0017" ("T0017_dbid");

COMMENT ON CONSTRAINT fk0_H006e ON "HORG-FR_HISTORY"."H006e" IS 'Identification d''un agent a etiquette Libellé d''un agent@durant -> Libellé d''un agent';

-- Foreign key definition : H006f -> T0017
ALTER TABLE "HORG-FR_HISTORY"."H006f"
  ADD CONSTRAINT fk0_H006f FOREIGN KEY ("T0017_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0017" ("T0017_dbid");

COMMENT ON CONSTRAINT fk0_H006f ON "HORG-FR_HISTORY"."H006f" IS 'Identification d''un agent a etiquette Libellé d''un agent@depuis -> Libellé d''un agent';

-- Foreign key definition : H0070 -> T0011
ALTER TABLE "HORG-FR_HISTORY"."H0070"
  ADD CONSTRAINT fk0_H0070 FOREIGN KEY ("T0011_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0011" ("T0011_dbid");

COMMENT ON CONSTRAINT fk0_H0070 ON "HORG-FR_HISTORY"."H0070" IS 'Discipline a etiquette string@jusqua -> string';

-- Foreign key definition : H0071 -> T0011
ALTER TABLE "HORG-FR_HISTORY"."H0071"
  ADD CONSTRAINT fk0_H0071 FOREIGN KEY ("T0011_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0011" ("T0011_dbid");

COMMENT ON CONSTRAINT fk0_H0071 ON "HORG-FR_HISTORY"."H0071" IS 'Discipline a etiquette string@durant -> string';

-- Foreign key definition : H0072 -> T0011
ALTER TABLE "HORG-FR_HISTORY"."H0072"
  ADD CONSTRAINT fk0_H0072 FOREIGN KEY ("T0011_dbid")
    REFERENCES "HORG-FR_HISTORY"."T0011" ("T0011_dbid");

COMMENT ON CONSTRAINT fk0_H0072 ON "HORG-FR_HISTORY"."H0072" IS 'Discipline a etiquette string@depuis -> string';

-- Foreign key definition : H0073 -> T001a
ALTER TABLE "HORG-FR_HISTORY"."H0073"
  ADD CONSTRAINT fk0_H0073 FOREIGN KEY ("T001a_dbid")
    REFERENCES "HORG-FR_HISTORY"."T001a" ("T001a_dbid");

COMMENT ON CONSTRAINT fk0_H0073 ON "HORG-FR_HISTORY"."H0073" IS 'Unité de responsabilité médicale clinique a code Champ PMSI@jusqua -> Champ PMSI';

-- Foreign key definition : H0074 -> T001a
ALTER TABLE "HORG-FR_HISTORY"."H0074"
  ADD CONSTRAINT fk0_H0074 FOREIGN KEY ("T001a_dbid")
    REFERENCES "HORG-FR_HISTORY"."T001a" ("T001a_dbid");

COMMENT ON CONSTRAINT fk0_H0074 ON "HORG-FR_HISTORY"."H0074" IS 'Unité de responsabilité médicale clinique a code Champ PMSI@durant -> Champ PMSI';

-- Foreign key definition : H0075 -> T001a
ALTER TABLE "HORG-FR_HISTORY"."H0075"
  ADD CONSTRAINT fk0_H0075 FOREIGN KEY ("T001a_dbid")
    REFERENCES "HORG-FR_HISTORY"."T001a" ("T001a_dbid");

COMMENT ON CONSTRAINT fk0_H0075 ON "HORG-FR_HISTORY"."H0075" IS 'Unité de responsabilité médicale clinique a code Champ PMSI@depuis -> Champ PMSI';

-- Foreign key definition : H0076 -> T001c
ALTER TABLE "HORG-FR_HISTORY"."H0076"
  ADD CONSTRAINT fk0_H0076 FOREIGN KEY ("T001c_dbid")
    REFERENCES "HORG-FR_HISTORY"."T001c" ("T001c_dbid");

COMMENT ON CONSTRAINT fk0_H0076 ON "HORG-FR_HISTORY"."H0076" IS 'Spécialité médicale a code Code de spécialité médicale@jusqua -> Code de spécialité médicale';

-- Foreign key definition : H0077 -> T001c
ALTER TABLE "HORG-FR_HISTORY"."H0077"
  ADD CONSTRAINT fk0_H0077 FOREIGN KEY ("T001c_dbid")
    REFERENCES "HORG-FR_HISTORY"."T001c" ("T001c_dbid");

COMMENT ON CONSTRAINT fk0_H0077 ON "HORG-FR_HISTORY"."H0077" IS 'Spécialité médicale a code Code de spécialité médicale@durant -> Code de spécialité médicale';

-- Foreign key definition : H0078 -> T001c
ALTER TABLE "HORG-FR_HISTORY"."H0078"
  ADD CONSTRAINT fk0_H0078 FOREIGN KEY ("T001c_dbid")
    REFERENCES "HORG-FR_HISTORY"."T001c" ("T001c_dbid");

COMMENT ON CONSTRAINT fk0_H0078 ON "HORG-FR_HISTORY"."H0078" IS 'Spécialité médicale a code Code de spécialité médicale@depuis -> Code de spécialité médicale';

