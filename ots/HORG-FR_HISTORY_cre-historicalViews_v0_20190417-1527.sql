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
  Create historical views for HORG-FR_HISTORY
-- =========================================================================== A
*/

SET SCHEMA 'HORG-FR_HISTORY';

CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY".vxe(endDate "HORG-FR_HISTORY"."POINT")
  RETURNS "HORG-FR_HISTORY"."PERIOD"
  AS 'SELECT daterange(null, endDate, ''[]'')::"HORG-FR_HISTORY"."PERIOD";'
  LANGUAGE SQL
  IMMUTABLE
  RETURNS NULL ON NULL INPUT;

 CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY".vbx(beginDate "HORG-FR_HISTORY"."POINT")
  RETURNS "HORG-FR_HISTORY"."PERIOD"
  AS 'SELECT daterange(beginDate, null)::"HORG-FR_HISTORY"."PERIOD";'
  LANGUAGE SQL
  IMMUTABLE
  RETURNS NULL ON NULL INPUT;

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000009_history" AS
  SELECT "T0001_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0034"
  UNION
  SELECT "T0001_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0035"
  UNION
  SELECT "T0001_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0036"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000009_history" IS 'Unité de gestion:: history view';

CREATE VIEW "HORG-FR_HISTORY"."OrganizationalUnit_history" AS
  SELECT "T0002_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0037"
  UNION
  SELECT "T0002_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0038"
  UNION
  SELECT "T0002_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0039"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."OrganizationalUnit_history" IS 'Unité organisationnelle:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000012_history" AS
  SELECT "T0003_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H003a"
  UNION
  SELECT "T0003_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H003b"
  UNION
  SELECT "T0003_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H003c"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000012_history" IS 'Unité hospitalière:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000025_history" AS
  SELECT "T0004_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H003d"
  UNION
  SELECT "T0004_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H003e"
  UNION
  SELECT "T0004_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H003f"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000025_history" IS 'Unité administrative:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000026_history" AS
  SELECT "T0005_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0040"
  UNION
  SELECT "T0005_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0041"
  UNION
  SELECT "T0005_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0042"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000026_history" IS 'Identification d''un établisement de santé:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000004_history" AS
  SELECT "T0006_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0043"
  UNION
  SELECT "T0006_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0044"
  UNION
  SELECT "T0006_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0045"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000004_history" IS 'Hopital:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000027_history" AS
  SELECT "T0007_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0046"
  UNION
  SELECT "T0007_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0047"
  UNION
  SELECT "T0007_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0048"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000027_history" IS 'Identification d''une unité:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000005_history" AS
  SELECT "T0008_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0049"
  UNION
  SELECT "T0008_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H004a"
  UNION
  SELECT "T0008_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H004b"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000005_history" IS 'Pôle de santé:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000038_history" AS
  SELECT "T0009_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H004c"
  UNION
  SELECT "T0009_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H004d"
  UNION
  SELECT "T0009_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H004e"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000038_history" IS 'Unité de responsabilité médicale clinique:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000016_history" AS
  SELECT "T000a_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H004f"
  UNION
  SELECT "T000a_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0050"
  UNION
  SELECT "T000a_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0051"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000016_history" IS 'Unité fonctionnelle:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000006_history" AS
  SELECT "T000b_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0052"
  UNION
  SELECT "T000b_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0053"
  UNION
  SELECT "T000b_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0054"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000006_history" IS 'Service et département:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000017_history" AS
  SELECT "T000c_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0055"
  UNION
  SELECT "T000c_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0056"
  UNION
  SELECT "T000c_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0057"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000017_history" IS 'Spécialité médicale:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000039_history" AS
  SELECT "T000d_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0058"
  UNION
  SELECT "T000d_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0059"
  UNION
  SELECT "T000d_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H005a"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000039_history" IS 'Discipline:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000018_history" AS
  SELECT "T000e_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H005b"
  UNION
  SELECT "T000e_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H005c"
  UNION
  SELECT "T000e_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H005d"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000018_history" IS 'Groupe hospitalier:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000043_history" AS
  SELECT "T000f_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H005e"
  UNION
  SELECT "T000f_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H005f"
  UNION
  SELECT "T000f_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0060"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000043_history" IS 'Identification d''un agent:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000011_history" AS
  SELECT "T0010_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0061"
  UNION
  SELECT "T0010_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0062"
  UNION
  SELECT "T0010_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0063"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000011_history" IS 'Unité médico-administrative:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000017_HORG-FR_000001_string_history" AS
  SELECT "T000c_dbid",
    "T0011_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0064"
  UNION
  SELECT "T000c_dbid",
    "T0011_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0065"
  UNION
  SELECT "T000c_dbid",
    "T0011_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0066"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000017_HORG-FR_000001_string_history" IS 'Spécialité médicale a etiquette string:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000043_identifier_AGENTID_history" AS
  SELECT "T000f_dbid",
    "T0013_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0067"
  UNION
  SELECT "T000f_dbid",
    "T0013_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0068"
  UNION
  SELECT "T000f_dbid",
    "T0013_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0069"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000043_identifier_AGENTID_history" IS 'Identification d''un agent identifier Identifiant d''un agent:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000039_HORG-FR_000000_DISCIPLINECODE_history" AS
  SELECT "T000d_dbid",
    "T0015_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H006a"
  UNION
  SELECT "T000d_dbid",
    "T0015_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H006b"
  UNION
  SELECT "T000d_dbid",
    "T0015_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H006c"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000039_HORG-FR_000000_DISCIPLINECODE_history" IS 'Discipline a code Code type d''unité:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000043_HORG-FR_000001_AGENTLABEL_history" AS
  SELECT "T000f_dbid",
    "T0017_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H006d"
  UNION
  SELECT "T000f_dbid",
    "T0017_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H006e"
  UNION
  SELECT "T000f_dbid",
    "T0017_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H006f"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000043_HORG-FR_000001_AGENTLABEL_history" IS 'Identification d''un agent a etiquette Libellé d''un agent:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000039_HORG-FR_000001_string_history" AS
  SELECT "T000d_dbid",
    "T0011_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0070"
  UNION
  SELECT "T000d_dbid",
    "T0011_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0071"
  UNION
  SELECT "T000d_dbid",
    "T0011_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0072"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000039_HORG-FR_000001_string_history" IS 'Discipline a etiquette string:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000038_HORG-FR_000000_PMSI_history" AS
  SELECT "T0009_dbid",
    "T001a_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0073"
  UNION
  SELECT "T0009_dbid",
    "T001a_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0074"
  UNION
  SELECT "T0009_dbid",
    "T001a_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0075"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000038_HORG-FR_000000_PMSI_history" IS 'Unité de responsabilité médicale clinique a code Champ PMSI:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000017_HORG-FR_000000_MEDICALSPECODE_history" AS
  SELECT "T000c_dbid",
    "T001c_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0076"
  UNION
  SELECT "T000c_dbid",
    "T001c_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0077"
  UNION
  SELECT "T000c_dbid",
    "T001c_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0078"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000017_HORG-FR_000000_MEDICALSPECODE_history" IS 'Spécialité médicale a code Code de spécialité médicale:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000009_unitOf_HORG-FR_000005_history" AS
  SELECT "T0001_dbid",
    "T0008_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0079"
  UNION
  SELECT "T0001_dbid",
    "T0008_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H007a"
  UNION
  SELECT "T0001_dbid",
    "T0008_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H007b"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000009_unitOf_HORG-FR_000005_history" IS 'Unité de gestion unitOf Pôle de santé:: history view';

CREATE VIEW "HORG-FR_HISTORY"."OrganizationalUnit_HORG-FR_000042_HORG-FR_000027_history" AS
  SELECT "T0002_dbid",
    "T0007_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H007c"
  UNION
  SELECT "T0002_dbid",
    "T0007_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H007d"
  UNION
  SELECT "T0002_dbid",
    "T0007_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H007e"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."OrganizationalUnit_HORG-FR_000042_HORG-FR_000027_history" IS 'Unité organisationnelle a identifiant Identification d''une unité:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000006_history" AS
  SELECT "T0003_dbid",
    "T000b_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H007f"
  UNION
  SELECT "T0003_dbid",
    "T000b_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0080"
  UNION
  SELECT "T0003_dbid",
    "T000b_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0081"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000006_history" IS 'Unité hospitalière linkedTo Service et département:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000012_unitOf_HORG-FR_000011_history" AS
  SELECT "T0003_dbid",
    "T0010_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0082"
  UNION
  SELECT "T0003_dbid",
    "T0010_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0083"
  UNION
  SELECT "T0003_dbid",
    "T0010_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0084"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000012_unitOf_HORG-FR_000011_history" IS 'Unité hospitalière unitOf Unité médico-administrative:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000025_history" AS
  SELECT "T0003_dbid",
    "T0004_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0085"
  UNION
  SELECT "T0003_dbid",
    "T0004_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0086"
  UNION
  SELECT "T0003_dbid",
    "T0004_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0087"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000025_history" IS 'Unité hospitalière linkedTo Unité administrative:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000006_history" AS
  SELECT "T0004_dbid",
    "T000b_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0088"
  UNION
  SELECT "T0004_dbid",
    "T000b_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0089"
  UNION
  SELECT "T0004_dbid",
    "T000b_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H008a"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000006_history" IS 'Unité administrative linkedTo Service et département:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000025_unitOf_HORG-FR_000009_history" AS
  SELECT "T0004_dbid",
    "T0001_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H008b"
  UNION
  SELECT "T0004_dbid",
    "T0001_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H008c"
  UNION
  SELECT "T0004_dbid",
    "T0001_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H008d"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000025_unitOf_HORG-FR_000009_history" IS 'Unité administrative unitOf Unité de gestion:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000025_HORG-FR_000028_HORG-FR_000039_history" AS
  SELECT "T0004_dbid",
    "T000d_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H008e"
  UNION
  SELECT "T0004_dbid",
    "T000d_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H008f"
  UNION
  SELECT "T0004_dbid",
    "T000d_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0090"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000025_HORG-FR_000028_HORG-FR_000039_history" IS 'Unité administrative a une valeur spécifiée Discipline:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000011_history" AS
  SELECT "T0004_dbid",
    "T0010_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0091"
  UNION
  SELECT "T0004_dbid",
    "T0010_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0092"
  UNION
  SELECT "T0004_dbid",
    "T0010_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0093"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000011_history" IS 'Unité administrative linkedTo Unité médico-administrative:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000004_HORG-FR_000042_HORG-FR_000026_history" AS
  SELECT "T0006_dbid",
    "T0005_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0094"
  UNION
  SELECT "T0006_dbid",
    "T0005_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0095"
  UNION
  SELECT "T0006_dbid",
    "T0005_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0096"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000004_HORG-FR_000042_HORG-FR_000026_history" IS 'Hopital a identifiant Identification d''un établisement de santé:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000027_HORG-FR_000028_HORG-FR_000026_history" AS
  SELECT "T0007_dbid",
    "T0005_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H0097"
  UNION
  SELECT "T0007_dbid",
    "T0005_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H0098"
  UNION
  SELECT "T0007_dbid",
    "T0005_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H0099"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000027_HORG-FR_000028_HORG-FR_000026_history" IS 'Identification d''une unité a une valeur spécifiée Identification d''un établisement de santé:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000005_unitOf_HORG-FR_000004_history" AS
  SELECT "T0008_dbid",
    "T0006_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H009a"
  UNION
  SELECT "T0008_dbid",
    "T0006_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H009b"
  UNION
  SELECT "T0008_dbid",
    "T0006_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H009c"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000005_unitOf_HORG-FR_000004_history" IS 'Pôle de santé unitOf Hopital:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000038_HORG-FR_000028_HORG-FR_000039_history" AS
  SELECT "T0009_dbid",
    "T000d_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H009d"
  UNION
  SELECT "T0009_dbid",
    "T000d_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H009e"
  UNION
  SELECT "T0009_dbid",
    "T000d_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H009f"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000038_HORG-FR_000028_HORG-FR_000039_history" IS 'Unité de responsabilité médicale clinique a une valeur spécifiée Discipline:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000038_unitOf_HORG-FR_000011_history" AS
  SELECT "T0009_dbid",
    "T0010_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00a0"
  UNION
  SELECT "T0009_dbid",
    "T0010_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00a1"
  UNION
  SELECT "T0009_dbid",
    "T0010_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00a2"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000038_unitOf_HORG-FR_000011_history" IS 'Unité de responsabilité médicale clinique unitOf Unité médico-administrative:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000016_HORG-FR_000028_HORG-FR_000017_history" AS
  SELECT "T000a_dbid",
    "T000c_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00a3"
  UNION
  SELECT "T000a_dbid",
    "T000c_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00a4"
  UNION
  SELECT "T000a_dbid",
    "T000c_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00a5"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000016_HORG-FR_000028_HORG-FR_000017_history" IS 'Unité fonctionnelle a une valeur spécifiée Spécialité médicale:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000016_unitOf_HORG-FR_000005_history" AS
  SELECT "T000a_dbid",
    "T0008_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00a6"
  UNION
  SELECT "T000a_dbid",
    "T0008_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00a7"
  UNION
  SELECT "T000a_dbid",
    "T0008_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00a8"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000016_unitOf_HORG-FR_000005_history" IS 'Unité fonctionnelle unitOf Pôle de santé:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000006_history" AS
  SELECT "T000a_dbid",
    "T000b_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00a9"
  UNION
  SELECT "T000a_dbid",
    "T000b_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00aa"
  UNION
  SELECT "T000a_dbid",
    "T000b_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00ab"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000006_history" IS 'Unité fonctionnelle linkedTo Service et département:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000009_history" AS
  SELECT "T000a_dbid",
    "T0001_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00ac"
  UNION
  SELECT "T000a_dbid",
    "T0001_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00ad"
  UNION
  SELECT "T000a_dbid",
    "T0001_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00ae"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000009_history" IS 'Unité fonctionnelle linkedTo Unité de gestion:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000006_unitOf_HORG-FR_000004_history" AS
  SELECT "T000b_dbid",
    "T0006_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00af"
  UNION
  SELECT "T000b_dbid",
    "T0006_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00b0"
  UNION
  SELECT "T000b_dbid",
    "T0006_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00b1"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000006_unitOf_HORG-FR_000004_history" IS 'Service et département unitOf Hopital:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000006_linkedTo_HORG-FR_000005_history" AS
  SELECT "T000b_dbid",
    "T0008_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00b2"
  UNION
  SELECT "T000b_dbid",
    "T0008_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00b3"
  UNION
  SELECT "T000b_dbid",
    "T0008_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00b4"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000006_linkedTo_HORG-FR_000005_history" IS 'Service et département linkedTo Pôle de santé:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000018_HORG-FR_000042_HORG-FR_000043_history" AS
  SELECT "T000e_dbid",
    "T000f_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00b5"
  UNION
  SELECT "T000e_dbid",
    "T000f_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00b6"
  UNION
  SELECT "T000e_dbid",
    "T000f_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00b7"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000018_HORG-FR_000042_HORG-FR_000043_history" IS 'Groupe hospitalier a identifiant Identification d''un agent:: history view';

CREATE VIEW "HORG-FR_HISTORY"."HORG-FR_000011_unitOf_HORG-FR_000009_history" AS
  SELECT "T0010_dbid",
    "T0001_dbid"
    ,  vxe(vxe) AS vt
  FROM "HORG-FR_HISTORY"."H00b8"
  UNION
  SELECT "T0010_dbid",
    "T0001_dbid"
    ,  vbe AS vt
  FROM "HORG-FR_HISTORY"."H00b9"
  UNION
  SELECT "T0010_dbid",
    "T0001_dbid"
    ,  vbx(vbx) AS vt
  FROM "HORG-FR_HISTORY"."H00ba"
;

COMMENT ON VIEW "HORG-FR_HISTORY"."HORG-FR_000011_unitOf_HORG-FR_000009_history" IS 'Unité médico-administrative unitOf Unité de gestion:: history view';
