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
  Create temporal contraints for HORG-FR_HISTORY
-- =========================================================================== A
*/

-- Temporal uniqueness ckeck for : HORG-FR_000009
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000009_checkHUniqueness"()
  RETURNS TABLE("T0001_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0001_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0036" NATURAL JOIN "HORG-FR_HISTORY"."H0035"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0001_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0035" NATURAL JOIN "HORG-FR_HISTORY"."H0034"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0001_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0034" NATURAL JOIN "HORG-FR_HISTORY"."H0036"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0035
ALTER TABLE "HORG-FR_HISTORY"."H0035" 
  ADD CONSTRAINT H0035_redundancy
  EXCLUDE USING gist("T0001_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0035
ALTER TABLE "HORG-FR_HISTORY"."H0035" 
  ADD CONSTRAINT H0035_contradiction
  EXCLUDE USING gist("T0001_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0035
ALTER TABLE "HORG-FR_HISTORY"."H0035" 
  ADD CONSTRAINT H0035_circumlocution
  EXCLUDE USING gist("T0001_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : OrganizationalUnit
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."OrganizationalUnit_checkHUniqueness"()
  RETURNS TABLE("T0002_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0002_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0039" NATURAL JOIN "HORG-FR_HISTORY"."H0038"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0002_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0038" NATURAL JOIN "HORG-FR_HISTORY"."H0037"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0002_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0037" NATURAL JOIN "HORG-FR_HISTORY"."H0039"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0038
ALTER TABLE "HORG-FR_HISTORY"."H0038" 
  ADD CONSTRAINT H0038_redundancy
  EXCLUDE USING gist("T0002_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0038
ALTER TABLE "HORG-FR_HISTORY"."H0038" 
  ADD CONSTRAINT H0038_contradiction
  EXCLUDE USING gist("T0002_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0038
ALTER TABLE "HORG-FR_HISTORY"."H0038" 
  ADD CONSTRAINT H0038_circumlocution
  EXCLUDE USING gist("T0002_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000012
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000012_checkHUniqueness"()
  RETURNS TABLE("T0003_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0003_dbid", vbe
  FROM "HORG-FR_HISTORY"."H003c" NATURAL JOIN "HORG-FR_HISTORY"."H003b"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0003_dbid", vbe
  FROM "HORG-FR_HISTORY"."H003b" NATURAL JOIN "HORG-FR_HISTORY"."H003a"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0003_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H003a" NATURAL JOIN "HORG-FR_HISTORY"."H003c"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H003b
ALTER TABLE "HORG-FR_HISTORY"."H003b" 
  ADD CONSTRAINT H003b_redundancy
  EXCLUDE USING gist("T0003_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H003b
ALTER TABLE "HORG-FR_HISTORY"."H003b" 
  ADD CONSTRAINT H003b_contradiction
  EXCLUDE USING gist("T0003_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H003b
ALTER TABLE "HORG-FR_HISTORY"."H003b" 
  ADD CONSTRAINT H003b_circumlocution
  EXCLUDE USING gist("T0003_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000025
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000025_checkHUniqueness"()
  RETURNS TABLE("T0004_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0004_dbid", vbe
  FROM "HORG-FR_HISTORY"."H003f" NATURAL JOIN "HORG-FR_HISTORY"."H003e"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0004_dbid", vbe
  FROM "HORG-FR_HISTORY"."H003e" NATURAL JOIN "HORG-FR_HISTORY"."H003d"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0004_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H003d" NATURAL JOIN "HORG-FR_HISTORY"."H003f"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H003e
ALTER TABLE "HORG-FR_HISTORY"."H003e" 
  ADD CONSTRAINT H003e_redundancy
  EXCLUDE USING gist("T0004_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H003e
ALTER TABLE "HORG-FR_HISTORY"."H003e" 
  ADD CONSTRAINT H003e_contradiction
  EXCLUDE USING gist("T0004_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H003e
ALTER TABLE "HORG-FR_HISTORY"."H003e" 
  ADD CONSTRAINT H003e_circumlocution
  EXCLUDE USING gist("T0004_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000026
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000026_checkHUniqueness"()
  RETURNS TABLE("T0005_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0005_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0042" NATURAL JOIN "HORG-FR_HISTORY"."H0041"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0005_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0041" NATURAL JOIN "HORG-FR_HISTORY"."H0040"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0005_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0040" NATURAL JOIN "HORG-FR_HISTORY"."H0042"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0041
ALTER TABLE "HORG-FR_HISTORY"."H0041" 
  ADD CONSTRAINT H0041_redundancy
  EXCLUDE USING gist("T0005_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0041
ALTER TABLE "HORG-FR_HISTORY"."H0041" 
  ADD CONSTRAINT H0041_contradiction
  EXCLUDE USING gist("T0005_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0041
ALTER TABLE "HORG-FR_HISTORY"."H0041" 
  ADD CONSTRAINT H0041_circumlocution
  EXCLUDE USING gist("T0005_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000004
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000004_checkHUniqueness"()
  RETURNS TABLE("T0006_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0006_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0045" NATURAL JOIN "HORG-FR_HISTORY"."H0044"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0006_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0044" NATURAL JOIN "HORG-FR_HISTORY"."H0043"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0006_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0043" NATURAL JOIN "HORG-FR_HISTORY"."H0045"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0044
ALTER TABLE "HORG-FR_HISTORY"."H0044" 
  ADD CONSTRAINT H0044_redundancy
  EXCLUDE USING gist("T0006_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0044
ALTER TABLE "HORG-FR_HISTORY"."H0044" 
  ADD CONSTRAINT H0044_contradiction
  EXCLUDE USING gist("T0006_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0044
ALTER TABLE "HORG-FR_HISTORY"."H0044" 
  ADD CONSTRAINT H0044_circumlocution
  EXCLUDE USING gist("T0006_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000027
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000027_checkHUniqueness"()
  RETURNS TABLE("T0007_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0007_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0048" NATURAL JOIN "HORG-FR_HISTORY"."H0047"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0007_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0047" NATURAL JOIN "HORG-FR_HISTORY"."H0046"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0007_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0046" NATURAL JOIN "HORG-FR_HISTORY"."H0048"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0047
ALTER TABLE "HORG-FR_HISTORY"."H0047" 
  ADD CONSTRAINT H0047_redundancy
  EXCLUDE USING gist("T0007_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0047
ALTER TABLE "HORG-FR_HISTORY"."H0047" 
  ADD CONSTRAINT H0047_contradiction
  EXCLUDE USING gist("T0007_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0047
ALTER TABLE "HORG-FR_HISTORY"."H0047" 
  ADD CONSTRAINT H0047_circumlocution
  EXCLUDE USING gist("T0007_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000005
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000005_checkHUniqueness"()
  RETURNS TABLE("T0008_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0008_dbid", vbe
  FROM "HORG-FR_HISTORY"."H004b" NATURAL JOIN "HORG-FR_HISTORY"."H004a"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0008_dbid", vbe
  FROM "HORG-FR_HISTORY"."H004a" NATURAL JOIN "HORG-FR_HISTORY"."H0049"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0008_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0049" NATURAL JOIN "HORG-FR_HISTORY"."H004b"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H004a
ALTER TABLE "HORG-FR_HISTORY"."H004a" 
  ADD CONSTRAINT H004a_redundancy
  EXCLUDE USING gist("T0008_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H004a
ALTER TABLE "HORG-FR_HISTORY"."H004a" 
  ADD CONSTRAINT H004a_contradiction
  EXCLUDE USING gist("T0008_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H004a
ALTER TABLE "HORG-FR_HISTORY"."H004a" 
  ADD CONSTRAINT H004a_circumlocution
  EXCLUDE USING gist("T0008_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000038
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000038_checkHUniqueness"()
  RETURNS TABLE("T0009_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0009_dbid", vbe
  FROM "HORG-FR_HISTORY"."H004e" NATURAL JOIN "HORG-FR_HISTORY"."H004d"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0009_dbid", vbe
  FROM "HORG-FR_HISTORY"."H004d" NATURAL JOIN "HORG-FR_HISTORY"."H004c"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0009_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H004c" NATURAL JOIN "HORG-FR_HISTORY"."H004e"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H004d
ALTER TABLE "HORG-FR_HISTORY"."H004d" 
  ADD CONSTRAINT H004d_redundancy
  EXCLUDE USING gist("T0009_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H004d
ALTER TABLE "HORG-FR_HISTORY"."H004d" 
  ADD CONSTRAINT H004d_contradiction
  EXCLUDE USING gist("T0009_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H004d
ALTER TABLE "HORG-FR_HISTORY"."H004d" 
  ADD CONSTRAINT H004d_circumlocution
  EXCLUDE USING gist("T0009_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000016
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000016_checkHUniqueness"()
  RETURNS TABLE("T000a_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000a_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0051" NATURAL JOIN "HORG-FR_HISTORY"."H0050"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000a_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0050" NATURAL JOIN "HORG-FR_HISTORY"."H004f"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000a_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H004f" NATURAL JOIN "HORG-FR_HISTORY"."H0051"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0050
ALTER TABLE "HORG-FR_HISTORY"."H0050" 
  ADD CONSTRAINT H0050_redundancy
  EXCLUDE USING gist("T000a_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0050
ALTER TABLE "HORG-FR_HISTORY"."H0050" 
  ADD CONSTRAINT H0050_contradiction
  EXCLUDE USING gist("T000a_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0050
ALTER TABLE "HORG-FR_HISTORY"."H0050" 
  ADD CONSTRAINT H0050_circumlocution
  EXCLUDE USING gist("T000a_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000006
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000006_checkHUniqueness"()
  RETURNS TABLE("T000b_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000b_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0054" NATURAL JOIN "HORG-FR_HISTORY"."H0053"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000b_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0053" NATURAL JOIN "HORG-FR_HISTORY"."H0052"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000b_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0052" NATURAL JOIN "HORG-FR_HISTORY"."H0054"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0053
ALTER TABLE "HORG-FR_HISTORY"."H0053" 
  ADD CONSTRAINT H0053_redundancy
  EXCLUDE USING gist("T000b_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0053
ALTER TABLE "HORG-FR_HISTORY"."H0053" 
  ADD CONSTRAINT H0053_contradiction
  EXCLUDE USING gist("T000b_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0053
ALTER TABLE "HORG-FR_HISTORY"."H0053" 
  ADD CONSTRAINT H0053_circumlocution
  EXCLUDE USING gist("T000b_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000017
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000017_checkHUniqueness"()
  RETURNS TABLE("T000c_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000c_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0057" NATURAL JOIN "HORG-FR_HISTORY"."H0056"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000c_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0056" NATURAL JOIN "HORG-FR_HISTORY"."H0055"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000c_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0055" NATURAL JOIN "HORG-FR_HISTORY"."H0057"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0056
ALTER TABLE "HORG-FR_HISTORY"."H0056" 
  ADD CONSTRAINT H0056_redundancy
  EXCLUDE USING gist("T000c_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0056
ALTER TABLE "HORG-FR_HISTORY"."H0056" 
  ADD CONSTRAINT H0056_contradiction
  EXCLUDE USING gist("T000c_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0056
ALTER TABLE "HORG-FR_HISTORY"."H0056" 
  ADD CONSTRAINT H0056_circumlocution
  EXCLUDE USING gist("T000c_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000039
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000039_checkHUniqueness"()
  RETURNS TABLE("T000d_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000d_dbid", vbe
  FROM "HORG-FR_HISTORY"."H005a" NATURAL JOIN "HORG-FR_HISTORY"."H0059"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000d_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0059" NATURAL JOIN "HORG-FR_HISTORY"."H0058"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000d_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0058" NATURAL JOIN "HORG-FR_HISTORY"."H005a"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0059
ALTER TABLE "HORG-FR_HISTORY"."H0059" 
  ADD CONSTRAINT H0059_redundancy
  EXCLUDE USING gist("T000d_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0059
ALTER TABLE "HORG-FR_HISTORY"."H0059" 
  ADD CONSTRAINT H0059_contradiction
  EXCLUDE USING gist("T000d_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0059
ALTER TABLE "HORG-FR_HISTORY"."H0059" 
  ADD CONSTRAINT H0059_circumlocution
  EXCLUDE USING gist("T000d_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000018
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000018_checkHUniqueness"()
  RETURNS TABLE("T000e_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000e_dbid", vbe
  FROM "HORG-FR_HISTORY"."H005d" NATURAL JOIN "HORG-FR_HISTORY"."H005c"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000e_dbid", vbe
  FROM "HORG-FR_HISTORY"."H005c" NATURAL JOIN "HORG-FR_HISTORY"."H005b"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000e_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H005b" NATURAL JOIN "HORG-FR_HISTORY"."H005d"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H005c
ALTER TABLE "HORG-FR_HISTORY"."H005c" 
  ADD CONSTRAINT H005c_redundancy
  EXCLUDE USING gist("T000e_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H005c
ALTER TABLE "HORG-FR_HISTORY"."H005c" 
  ADD CONSTRAINT H005c_contradiction
  EXCLUDE USING gist("T000e_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H005c
ALTER TABLE "HORG-FR_HISTORY"."H005c" 
  ADD CONSTRAINT H005c_circumlocution
  EXCLUDE USING gist("T000e_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000043
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000043_checkHUniqueness"()
  RETURNS TABLE("T000f_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000f_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0060" NATURAL JOIN "HORG-FR_HISTORY"."H005f"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000f_dbid", vbe
  FROM "HORG-FR_HISTORY"."H005f" NATURAL JOIN "HORG-FR_HISTORY"."H005e"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000f_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H005e" NATURAL JOIN "HORG-FR_HISTORY"."H0060"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H005f
ALTER TABLE "HORG-FR_HISTORY"."H005f" 
  ADD CONSTRAINT H005f_redundancy
  EXCLUDE USING gist("T000f_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H005f
ALTER TABLE "HORG-FR_HISTORY"."H005f" 
  ADD CONSTRAINT H005f_contradiction
  EXCLUDE USING gist("T000f_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H005f
ALTER TABLE "HORG-FR_HISTORY"."H005f" 
  ADD CONSTRAINT H005f_circumlocution
  EXCLUDE USING gist("T000f_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000011
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000011_checkHUniqueness"()
  RETURNS TABLE("T0010_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0010_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0063" NATURAL JOIN "HORG-FR_HISTORY"."H0062"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0010_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0062" NATURAL JOIN "HORG-FR_HISTORY"."H0061"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0010_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0061" NATURAL JOIN "HORG-FR_HISTORY"."H0063"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0062
ALTER TABLE "HORG-FR_HISTORY"."H0062" 
  ADD CONSTRAINT H0062_redundancy
  EXCLUDE USING gist("T0010_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0062
ALTER TABLE "HORG-FR_HISTORY"."H0062" 
  ADD CONSTRAINT H0062_contradiction
  EXCLUDE USING gist("T0010_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0062
ALTER TABLE "HORG-FR_HISTORY"."H0062" 
  ADD CONSTRAINT H0062_circumlocution
  EXCLUDE USING gist("T0010_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000017_HORG-FR_000001_string
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000017_HORG-FR_000001_string_checkHUniqueness"()
  RETURNS TABLE("T000c_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000c_dbid", "T0011_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0066" NATURAL JOIN "HORG-FR_HISTORY"."H0065"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000c_dbid", "T0011_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0065" NATURAL JOIN "HORG-FR_HISTORY"."H0064"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000c_dbid", "T0011_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0064" NATURAL JOIN "HORG-FR_HISTORY"."H0066"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0065
ALTER TABLE "HORG-FR_HISTORY"."H0065" 
  ADD CONSTRAINT H0065_redundancy
  EXCLUDE USING gist("T000c_dbid" WITH =, "T0011_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0065
ALTER TABLE "HORG-FR_HISTORY"."H0065" 
  ADD CONSTRAINT H0065_contradiction
  EXCLUDE USING gist("T000c_dbid" WITH =, "T0011_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0065
ALTER TABLE "HORG-FR_HISTORY"."H0065" 
  ADD CONSTRAINT H0065_circumlocution
  EXCLUDE USING gist("T000c_dbid" WITH =, "T0011_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000043_identifier_AGENTID
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000043_identifier_AGENTID_checkHUniqueness"()
  RETURNS TABLE("T000f_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000f_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0069" NATURAL JOIN "HORG-FR_HISTORY"."H0068"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000f_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0068" NATURAL JOIN "HORG-FR_HISTORY"."H0067"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000f_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0067" NATURAL JOIN "HORG-FR_HISTORY"."H0069"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0068
ALTER TABLE "HORG-FR_HISTORY"."H0068" 
  ADD CONSTRAINT H0068_redundancy
  EXCLUDE USING gist("T000f_dbid" WITH =, "T0013_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0068
ALTER TABLE "HORG-FR_HISTORY"."H0068" 
  ADD CONSTRAINT H0068_contradiction
  EXCLUDE USING gist("T000f_dbid" WITH =, "T0013_dbid" WITH <>, vbe WITH &&);

 -- No circumlocution constraint for H0068
ALTER TABLE "HORG-FR_HISTORY"."H0068" 
  ADD CONSTRAINT H0068_circumlocution
  EXCLUDE USING gist("T000f_dbid" WITH =, "T0013_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000039_HORG-FR_000000_UNITTYPECODE
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000039_HORG-FR_000000_UNITTYPECODE_checkHUniqueness"()
  RETURNS TABLE("T000d_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000d_dbid", vbe
  FROM "HORG-FR_HISTORY"."H006c" NATURAL JOIN "HORG-FR_HISTORY"."H006b"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000d_dbid", vbe
  FROM "HORG-FR_HISTORY"."H006b" NATURAL JOIN "HORG-FR_HISTORY"."H006a"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000d_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H006a" NATURAL JOIN "HORG-FR_HISTORY"."H006c"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H006b
ALTER TABLE "HORG-FR_HISTORY"."H006b" 
  ADD CONSTRAINT H006b_redundancy
  EXCLUDE USING gist("T000d_dbid" WITH =, "T0015_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H006b
ALTER TABLE "HORG-FR_HISTORY"."H006b" 
  ADD CONSTRAINT H006b_contradiction
  EXCLUDE USING gist("T000d_dbid" WITH =, "T0015_dbid" WITH <>, vbe WITH &&);

 -- No circumlocution constraint for H006b
ALTER TABLE "HORG-FR_HISTORY"."H006b" 
  ADD CONSTRAINT H006b_circumlocution
  EXCLUDE USING gist("T000d_dbid" WITH =, "T0015_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000043_HORG-FR_000001_AGENTLABEL
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000043_HORG-FR_000001_AGENTLABEL_checkHUniqueness"()
  RETURNS TABLE("T000f_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0017_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000f_dbid", "T0017_dbid", vbe
  FROM "HORG-FR_HISTORY"."H006f" NATURAL JOIN "HORG-FR_HISTORY"."H006e"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000f_dbid", "T0017_dbid", vbe
  FROM "HORG-FR_HISTORY"."H006e" NATURAL JOIN "HORG-FR_HISTORY"."H006d"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000f_dbid", "T0017_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H006d" NATURAL JOIN "HORG-FR_HISTORY"."H006f"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H006e
ALTER TABLE "HORG-FR_HISTORY"."H006e" 
  ADD CONSTRAINT H006e_redundancy
  EXCLUDE USING gist("T000f_dbid" WITH =, "T0017_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H006e
ALTER TABLE "HORG-FR_HISTORY"."H006e" 
  ADD CONSTRAINT H006e_contradiction
  EXCLUDE USING gist("T000f_dbid" WITH =, "T0017_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H006e
ALTER TABLE "HORG-FR_HISTORY"."H006e" 
  ADD CONSTRAINT H006e_circumlocution
  EXCLUDE USING gist("T000f_dbid" WITH =, "T0017_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000039_HORG-FR_000001_string
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000039_HORG-FR_000001_string_checkHUniqueness"()
  RETURNS TABLE("T000d_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0011_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000d_dbid", "T0011_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0072" NATURAL JOIN "HORG-FR_HISTORY"."H0071"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000d_dbid", "T0011_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0071" NATURAL JOIN "HORG-FR_HISTORY"."H0070"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000d_dbid", "T0011_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0070" NATURAL JOIN "HORG-FR_HISTORY"."H0072"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0071
ALTER TABLE "HORG-FR_HISTORY"."H0071" 
  ADD CONSTRAINT H0071_redundancy
  EXCLUDE USING gist("T000d_dbid" WITH =, "T0011_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0071
ALTER TABLE "HORG-FR_HISTORY"."H0071" 
  ADD CONSTRAINT H0071_contradiction
  EXCLUDE USING gist("T000d_dbid" WITH =, "T0011_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0071
ALTER TABLE "HORG-FR_HISTORY"."H0071" 
  ADD CONSTRAINT H0071_circumlocution
  EXCLUDE USING gist("T000d_dbid" WITH =, "T0011_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000038_HORG-FR_000000_PMSI
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000038_HORG-FR_000000_PMSI_checkHUniqueness"()
  RETURNS TABLE("T0009_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0009_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0075" NATURAL JOIN "HORG-FR_HISTORY"."H0074"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0009_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0074" NATURAL JOIN "HORG-FR_HISTORY"."H0073"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0009_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0073" NATURAL JOIN "HORG-FR_HISTORY"."H0075"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0074
ALTER TABLE "HORG-FR_HISTORY"."H0074" 
  ADD CONSTRAINT H0074_redundancy
  EXCLUDE USING gist("T0009_dbid" WITH =, "T001a_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0074
ALTER TABLE "HORG-FR_HISTORY"."H0074" 
  ADD CONSTRAINT H0074_contradiction
  EXCLUDE USING gist("T0009_dbid" WITH =, "T001a_dbid" WITH <>, vbe WITH &&);

 -- No circumlocution constraint for H0074
ALTER TABLE "HORG-FR_HISTORY"."H0074" 
  ADD CONSTRAINT H0074_circumlocution
  EXCLUDE USING gist("T0009_dbid" WITH =, "T001a_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000017_HORG-FR_000000_MEDICALSPECODE
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000017_HORG-FR_000000_MEDICALSPECODE_checkHUniqueness"()
  RETURNS TABLE("T000c_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000c_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0078" NATURAL JOIN "HORG-FR_HISTORY"."H0077"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000c_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0077" NATURAL JOIN "HORG-FR_HISTORY"."H0076"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000c_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0076" NATURAL JOIN "HORG-FR_HISTORY"."H0078"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0077
ALTER TABLE "HORG-FR_HISTORY"."H0077" 
  ADD CONSTRAINT H0077_redundancy
  EXCLUDE USING gist("T000c_dbid" WITH =, "T001c_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0077
ALTER TABLE "HORG-FR_HISTORY"."H0077" 
  ADD CONSTRAINT H0077_contradiction
  EXCLUDE USING gist("T000c_dbid" WITH =, "T001c_dbid" WITH <>, vbe WITH &&);

 -- No circumlocution constraint for H0077
ALTER TABLE "HORG-FR_HISTORY"."H0077" 
  ADD CONSTRAINT H0077_circumlocution
  EXCLUDE USING gist("T000c_dbid" WITH =, "T001c_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000009_unitOf_HORG-FR_000005
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000009_unitOf_HORG-FR_000005_checkHUniqueness"()
  RETURNS TABLE("T0001_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0001_dbid", "T0008_dbid", vbe
  FROM "HORG-FR_HISTORY"."H007b" NATURAL JOIN "HORG-FR_HISTORY"."H007a"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0001_dbid", "T0008_dbid", vbe
  FROM "HORG-FR_HISTORY"."H007a" NATURAL JOIN "HORG-FR_HISTORY"."H0079"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0001_dbid", "T0008_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0079" NATURAL JOIN "HORG-FR_HISTORY"."H007b"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H007a
ALTER TABLE "HORG-FR_HISTORY"."H007a" 
  ADD CONSTRAINT H007a_redundancy
  EXCLUDE USING gist("T0001_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H007a
ALTER TABLE "HORG-FR_HISTORY"."H007a" 
  ADD CONSTRAINT H007a_contradiction
  EXCLUDE USING gist("T0001_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H007a
ALTER TABLE "HORG-FR_HISTORY"."H007a" 
  ADD CONSTRAINT H007a_circumlocution
  EXCLUDE USING gist("T0001_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : OrganizationalUnit_HORG-FR_000042_HORG-FR_000027
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."OrganizationalUnit_HORG-FR_000042_HORG-FR_000027_checkHUniqueness"()
  RETURNS TABLE("T0002_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0002_dbid", vbe
  FROM "HORG-FR_HISTORY"."H007e" NATURAL JOIN "HORG-FR_HISTORY"."H007d"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0002_dbid", vbe
  FROM "HORG-FR_HISTORY"."H007d" NATURAL JOIN "HORG-FR_HISTORY"."H007c"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0002_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H007c" NATURAL JOIN "HORG-FR_HISTORY"."H007e"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H007d
ALTER TABLE "HORG-FR_HISTORY"."H007d" 
  ADD CONSTRAINT H007d_redundancy
  EXCLUDE USING gist("T0002_dbid" WITH =, "T0007_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H007d
ALTER TABLE "HORG-FR_HISTORY"."H007d" 
  ADD CONSTRAINT H007d_contradiction
  EXCLUDE USING gist("T0002_dbid" WITH =, "T0007_dbid" WITH <>, vbe WITH &&);

 -- No circumlocution constraint for H007d
ALTER TABLE "HORG-FR_HISTORY"."H007d" 
  ADD CONSTRAINT H007d_circumlocution
  EXCLUDE USING gist("T0002_dbid" WITH =, "T0007_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000012_linkedTo_HORG-FR_000006
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000006_checkHUniqueness"()
  RETURNS TABLE("T0003_dbid" "HORG-FR_HISTORY"."dbid_domain", "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0003_dbid", "T000b_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0081" NATURAL JOIN "HORG-FR_HISTORY"."H0080"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0003_dbid", "T000b_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0080" NATURAL JOIN "HORG-FR_HISTORY"."H007f"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0003_dbid", "T000b_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H007f" NATURAL JOIN "HORG-FR_HISTORY"."H0081"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0080
ALTER TABLE "HORG-FR_HISTORY"."H0080" 
  ADD CONSTRAINT H0080_redundancy
  EXCLUDE USING gist("T0003_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0080
ALTER TABLE "HORG-FR_HISTORY"."H0080" 
  ADD CONSTRAINT H0080_contradiction
  EXCLUDE USING gist("T0003_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0080
ALTER TABLE "HORG-FR_HISTORY"."H0080" 
  ADD CONSTRAINT H0080_circumlocution
  EXCLUDE USING gist("T0003_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000012_unitOf_HORG-FR_000011
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000012_unitOf_HORG-FR_000011_checkHUniqueness"()
  RETURNS TABLE("T0003_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0003_dbid", "T0010_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0084" NATURAL JOIN "HORG-FR_HISTORY"."H0083"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0003_dbid", "T0010_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0083" NATURAL JOIN "HORG-FR_HISTORY"."H0082"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0003_dbid", "T0010_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0082" NATURAL JOIN "HORG-FR_HISTORY"."H0084"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0083
ALTER TABLE "HORG-FR_HISTORY"."H0083" 
  ADD CONSTRAINT H0083_redundancy
  EXCLUDE USING gist("T0003_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0083
ALTER TABLE "HORG-FR_HISTORY"."H0083" 
  ADD CONSTRAINT H0083_contradiction
  EXCLUDE USING gist("T0003_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0083
ALTER TABLE "HORG-FR_HISTORY"."H0083" 
  ADD CONSTRAINT H0083_circumlocution
  EXCLUDE USING gist("T0003_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000012_linkedTo_HORG-FR_000025
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000012_linkedTo_HORG-FR_000025_checkHUniqueness"()
  RETURNS TABLE("T0003_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0004_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0003_dbid", "T0004_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0087" NATURAL JOIN "HORG-FR_HISTORY"."H0086"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0003_dbid", "T0004_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0086" NATURAL JOIN "HORG-FR_HISTORY"."H0085"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0003_dbid", "T0004_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0085" NATURAL JOIN "HORG-FR_HISTORY"."H0087"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0086
ALTER TABLE "HORG-FR_HISTORY"."H0086" 
  ADD CONSTRAINT H0086_redundancy
  EXCLUDE USING gist("T0003_dbid" WITH =, "T0004_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0086
ALTER TABLE "HORG-FR_HISTORY"."H0086" 
  ADD CONSTRAINT H0086_contradiction
  EXCLUDE USING gist("T0003_dbid" WITH =, "T0004_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0086
ALTER TABLE "HORG-FR_HISTORY"."H0086" 
  ADD CONSTRAINT H0086_circumlocution
  EXCLUDE USING gist("T0003_dbid" WITH =, "T0004_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000025_linkedTo_HORG-FR_000006
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000006_checkHUniqueness"()
  RETURNS TABLE("T0004_dbid" "HORG-FR_HISTORY"."dbid_domain", "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0004_dbid", "T000b_dbid", vbe
  FROM "HORG-FR_HISTORY"."H008a" NATURAL JOIN "HORG-FR_HISTORY"."H0089"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0004_dbid", "T000b_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0089" NATURAL JOIN "HORG-FR_HISTORY"."H0088"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0004_dbid", "T000b_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0088" NATURAL JOIN "HORG-FR_HISTORY"."H008a"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0089
ALTER TABLE "HORG-FR_HISTORY"."H0089" 
  ADD CONSTRAINT H0089_redundancy
  EXCLUDE USING gist("T0004_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0089
ALTER TABLE "HORG-FR_HISTORY"."H0089" 
  ADD CONSTRAINT H0089_contradiction
  EXCLUDE USING gist("T0004_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0089
ALTER TABLE "HORG-FR_HISTORY"."H0089" 
  ADD CONSTRAINT H0089_circumlocution
  EXCLUDE USING gist("T0004_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000025_unitOf_HORG-FR_000009
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000025_unitOf_HORG-FR_000009_checkHUniqueness"()
  RETURNS TABLE("T0004_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0004_dbid", "T0001_dbid", vbe
  FROM "HORG-FR_HISTORY"."H008d" NATURAL JOIN "HORG-FR_HISTORY"."H008c"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0004_dbid", "T0001_dbid", vbe
  FROM "HORG-FR_HISTORY"."H008c" NATURAL JOIN "HORG-FR_HISTORY"."H008b"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0004_dbid", "T0001_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H008b" NATURAL JOIN "HORG-FR_HISTORY"."H008d"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H008c
ALTER TABLE "HORG-FR_HISTORY"."H008c" 
  ADD CONSTRAINT H008c_redundancy
  EXCLUDE USING gist("T0004_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H008c
ALTER TABLE "HORG-FR_HISTORY"."H008c" 
  ADD CONSTRAINT H008c_contradiction
  EXCLUDE USING gist("T0004_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H008c
ALTER TABLE "HORG-FR_HISTORY"."H008c" 
  ADD CONSTRAINT H008c_circumlocution
  EXCLUDE USING gist("T0004_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000025_HORG-FR_000028_HORG-FR_000039
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000025_HORG-FR_000028_HORG-FR_000039_checkHUniqueness"()
  RETURNS TABLE("T0004_dbid" "HORG-FR_HISTORY"."dbid_domain", "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0004_dbid", "T000d_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0090" NATURAL JOIN "HORG-FR_HISTORY"."H008f"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0004_dbid", "T000d_dbid", vbe
  FROM "HORG-FR_HISTORY"."H008f" NATURAL JOIN "HORG-FR_HISTORY"."H008e"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0004_dbid", "T000d_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H008e" NATURAL JOIN "HORG-FR_HISTORY"."H0090"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H008f
ALTER TABLE "HORG-FR_HISTORY"."H008f" 
  ADD CONSTRAINT H008f_redundancy
  EXCLUDE USING gist("T0004_dbid" WITH =, "T000d_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H008f
ALTER TABLE "HORG-FR_HISTORY"."H008f" 
  ADD CONSTRAINT H008f_contradiction
  EXCLUDE USING gist("T0004_dbid" WITH =, "T000d_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H008f
ALTER TABLE "HORG-FR_HISTORY"."H008f" 
  ADD CONSTRAINT H008f_circumlocution
  EXCLUDE USING gist("T0004_dbid" WITH =, "T000d_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000025_linkedTo_HORG-FR_000011
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000025_linkedTo_HORG-FR_000011_checkHUniqueness"()
  RETURNS TABLE("T0004_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0004_dbid", "T0010_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0093" NATURAL JOIN "HORG-FR_HISTORY"."H0092"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0004_dbid", "T0010_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0092" NATURAL JOIN "HORG-FR_HISTORY"."H0091"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0004_dbid", "T0010_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0091" NATURAL JOIN "HORG-FR_HISTORY"."H0093"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0092
ALTER TABLE "HORG-FR_HISTORY"."H0092" 
  ADD CONSTRAINT H0092_redundancy
  EXCLUDE USING gist("T0004_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0092
ALTER TABLE "HORG-FR_HISTORY"."H0092" 
  ADD CONSTRAINT H0092_contradiction
  EXCLUDE USING gist("T0004_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0092
ALTER TABLE "HORG-FR_HISTORY"."H0092" 
  ADD CONSTRAINT H0092_circumlocution
  EXCLUDE USING gist("T0004_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000004_HORG-FR_000042_HORG-FR_000026
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000004_HORG-FR_000042_HORG-FR_000026_checkHUniqueness"()
  RETURNS TABLE("T0006_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0006_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0096" NATURAL JOIN "HORG-FR_HISTORY"."H0095"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0006_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0095" NATURAL JOIN "HORG-FR_HISTORY"."H0094"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0006_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0094" NATURAL JOIN "HORG-FR_HISTORY"."H0096"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0095
ALTER TABLE "HORG-FR_HISTORY"."H0095" 
  ADD CONSTRAINT H0095_redundancy
  EXCLUDE USING gist("T0006_dbid" WITH =, "T0005_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0095
ALTER TABLE "HORG-FR_HISTORY"."H0095" 
  ADD CONSTRAINT H0095_contradiction
  EXCLUDE USING gist("T0006_dbid" WITH =, "T0005_dbid" WITH <>, vbe WITH &&);

 -- No circumlocution constraint for H0095
ALTER TABLE "HORG-FR_HISTORY"."H0095" 
  ADD CONSTRAINT H0095_circumlocution
  EXCLUDE USING gist("T0006_dbid" WITH =, "T0005_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000027_HORG-FR_000028_HORG-FR_000026
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000027_HORG-FR_000028_HORG-FR_000026_checkHUniqueness"()
  RETURNS TABLE("T0007_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0005_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0007_dbid", "T0005_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0099" NATURAL JOIN "HORG-FR_HISTORY"."H0098"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0007_dbid", "T0005_dbid", vbe
  FROM "HORG-FR_HISTORY"."H0098" NATURAL JOIN "HORG-FR_HISTORY"."H0097"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0007_dbid", "T0005_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H0097" NATURAL JOIN "HORG-FR_HISTORY"."H0099"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H0098
ALTER TABLE "HORG-FR_HISTORY"."H0098" 
  ADD CONSTRAINT H0098_redundancy
  EXCLUDE USING gist("T0007_dbid" WITH =, "T0005_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H0098
ALTER TABLE "HORG-FR_HISTORY"."H0098" 
  ADD CONSTRAINT H0098_contradiction
  EXCLUDE USING gist("T0007_dbid" WITH =, "T0005_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H0098
ALTER TABLE "HORG-FR_HISTORY"."H0098" 
  ADD CONSTRAINT H0098_circumlocution
  EXCLUDE USING gist("T0007_dbid" WITH =, "T0005_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000005_unitOf_HORG-FR_000004
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000005_unitOf_HORG-FR_000004_checkHUniqueness"()
  RETURNS TABLE("T0008_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0008_dbid", "T0006_dbid", vbe
  FROM "HORG-FR_HISTORY"."H009c" NATURAL JOIN "HORG-FR_HISTORY"."H009b"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0008_dbid", "T0006_dbid", vbe
  FROM "HORG-FR_HISTORY"."H009b" NATURAL JOIN "HORG-FR_HISTORY"."H009a"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0008_dbid", "T0006_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H009a" NATURAL JOIN "HORG-FR_HISTORY"."H009c"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H009b
ALTER TABLE "HORG-FR_HISTORY"."H009b" 
  ADD CONSTRAINT H009b_redundancy
  EXCLUDE USING gist("T0008_dbid" WITH =, "T0006_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H009b
ALTER TABLE "HORG-FR_HISTORY"."H009b" 
  ADD CONSTRAINT H009b_contradiction
  EXCLUDE USING gist("T0008_dbid" WITH =, "T0006_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H009b
ALTER TABLE "HORG-FR_HISTORY"."H009b" 
  ADD CONSTRAINT H009b_circumlocution
  EXCLUDE USING gist("T0008_dbid" WITH =, "T0006_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000038_HORG-FR_000028_HORG-FR_000039
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000038_HORG-FR_000028_HORG-FR_000039_checkHUniqueness"()
  RETURNS TABLE("T0009_dbid" "HORG-FR_HISTORY"."dbid_domain", "T000d_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0009_dbid", "T000d_dbid", vbe
  FROM "HORG-FR_HISTORY"."H009f" NATURAL JOIN "HORG-FR_HISTORY"."H009e"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0009_dbid", "T000d_dbid", vbe
  FROM "HORG-FR_HISTORY"."H009e" NATURAL JOIN "HORG-FR_HISTORY"."H009d"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0009_dbid", "T000d_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H009d" NATURAL JOIN "HORG-FR_HISTORY"."H009f"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H009e
ALTER TABLE "HORG-FR_HISTORY"."H009e" 
  ADD CONSTRAINT H009e_redundancy
  EXCLUDE USING gist("T0009_dbid" WITH =, "T000d_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H009e
ALTER TABLE "HORG-FR_HISTORY"."H009e" 
  ADD CONSTRAINT H009e_contradiction
  EXCLUDE USING gist("T0009_dbid" WITH =, "T000d_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H009e
ALTER TABLE "HORG-FR_HISTORY"."H009e" 
  ADD CONSTRAINT H009e_circumlocution
  EXCLUDE USING gist("T0009_dbid" WITH =, "T000d_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000038_unitOf_HORG-FR_000011
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000038_unitOf_HORG-FR_000011_checkHUniqueness"()
  RETURNS TABLE("T0009_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0010_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0009_dbid", "T0010_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00a2" NATURAL JOIN "HORG-FR_HISTORY"."H00a1"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0009_dbid", "T0010_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00a1" NATURAL JOIN "HORG-FR_HISTORY"."H00a0"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0009_dbid", "T0010_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00a0" NATURAL JOIN "HORG-FR_HISTORY"."H00a2"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00a1
ALTER TABLE "HORG-FR_HISTORY"."H00a1" 
  ADD CONSTRAINT H00a1_redundancy
  EXCLUDE USING gist("T0009_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00a1
ALTER TABLE "HORG-FR_HISTORY"."H00a1" 
  ADD CONSTRAINT H00a1_contradiction
  EXCLUDE USING gist("T0009_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H00a1
ALTER TABLE "HORG-FR_HISTORY"."H00a1" 
  ADD CONSTRAINT H00a1_circumlocution
  EXCLUDE USING gist("T0009_dbid" WITH =, "T0010_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000016_HORG-FR_000028_HORG-FR_000017
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000016_HORG-FR_000028_HORG-FR_000017_checkHUniqueness"()
  RETURNS TABLE("T000a_dbid" "HORG-FR_HISTORY"."dbid_domain", "T000c_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000a_dbid", "T000c_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00a5" NATURAL JOIN "HORG-FR_HISTORY"."H00a4"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000a_dbid", "T000c_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00a4" NATURAL JOIN "HORG-FR_HISTORY"."H00a3"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000a_dbid", "T000c_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00a3" NATURAL JOIN "HORG-FR_HISTORY"."H00a5"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00a4
ALTER TABLE "HORG-FR_HISTORY"."H00a4" 
  ADD CONSTRAINT H00a4_redundancy
  EXCLUDE USING gist("T000a_dbid" WITH =, "T000c_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00a4
ALTER TABLE "HORG-FR_HISTORY"."H00a4" 
  ADD CONSTRAINT H00a4_contradiction
  EXCLUDE USING gist("T000a_dbid" WITH =, "T000c_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H00a4
ALTER TABLE "HORG-FR_HISTORY"."H00a4" 
  ADD CONSTRAINT H00a4_circumlocution
  EXCLUDE USING gist("T000a_dbid" WITH =, "T000c_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000016_unitOf_HORG-FR_000005
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000016_unitOf_HORG-FR_000005_checkHUniqueness"()
  RETURNS TABLE("T000a_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000a_dbid", "T0008_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00a8" NATURAL JOIN "HORG-FR_HISTORY"."H00a7"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000a_dbid", "T0008_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00a7" NATURAL JOIN "HORG-FR_HISTORY"."H00a6"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000a_dbid", "T0008_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00a6" NATURAL JOIN "HORG-FR_HISTORY"."H00a8"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00a7
ALTER TABLE "HORG-FR_HISTORY"."H00a7" 
  ADD CONSTRAINT H00a7_redundancy
  EXCLUDE USING gist("T000a_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00a7
ALTER TABLE "HORG-FR_HISTORY"."H00a7" 
  ADD CONSTRAINT H00a7_contradiction
  EXCLUDE USING gist("T000a_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H00a7
ALTER TABLE "HORG-FR_HISTORY"."H00a7" 
  ADD CONSTRAINT H00a7_circumlocution
  EXCLUDE USING gist("T000a_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000016_linkedTo_HORG-FR_000006
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000006_checkHUniqueness"()
  RETURNS TABLE("T000a_dbid" "HORG-FR_HISTORY"."dbid_domain", "T000b_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000a_dbid", "T000b_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00ab" NATURAL JOIN "HORG-FR_HISTORY"."H00aa"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000a_dbid", "T000b_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00aa" NATURAL JOIN "HORG-FR_HISTORY"."H00a9"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000a_dbid", "T000b_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00a9" NATURAL JOIN "HORG-FR_HISTORY"."H00ab"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00aa
ALTER TABLE "HORG-FR_HISTORY"."H00aa" 
  ADD CONSTRAINT H00aa_redundancy
  EXCLUDE USING gist("T000a_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00aa
ALTER TABLE "HORG-FR_HISTORY"."H00aa" 
  ADD CONSTRAINT H00aa_contradiction
  EXCLUDE USING gist("T000a_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H00aa
ALTER TABLE "HORG-FR_HISTORY"."H00aa" 
  ADD CONSTRAINT H00aa_circumlocution
  EXCLUDE USING gist("T000a_dbid" WITH =, "T000b_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000016_linkedTo_HORG-FR_000009
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000016_linkedTo_HORG-FR_000009_checkHUniqueness"()
  RETURNS TABLE("T000a_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000a_dbid", "T0001_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00ae" NATURAL JOIN "HORG-FR_HISTORY"."H00ad"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000a_dbid", "T0001_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00ad" NATURAL JOIN "HORG-FR_HISTORY"."H00ac"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000a_dbid", "T0001_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00ac" NATURAL JOIN "HORG-FR_HISTORY"."H00ae"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00ad
ALTER TABLE "HORG-FR_HISTORY"."H00ad" 
  ADD CONSTRAINT H00ad_redundancy
  EXCLUDE USING gist("T000a_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00ad
ALTER TABLE "HORG-FR_HISTORY"."H00ad" 
  ADD CONSTRAINT H00ad_contradiction
  EXCLUDE USING gist("T000a_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H00ad
ALTER TABLE "HORG-FR_HISTORY"."H00ad" 
  ADD CONSTRAINT H00ad_circumlocution
  EXCLUDE USING gist("T000a_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000006_unitOf_HORG-FR_000004
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000006_unitOf_HORG-FR_000004_checkHUniqueness"()
  RETURNS TABLE("T000b_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0006_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000b_dbid", "T0006_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00b1" NATURAL JOIN "HORG-FR_HISTORY"."H00b0"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000b_dbid", "T0006_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00b0" NATURAL JOIN "HORG-FR_HISTORY"."H00af"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000b_dbid", "T0006_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00af" NATURAL JOIN "HORG-FR_HISTORY"."H00b1"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00b0
ALTER TABLE "HORG-FR_HISTORY"."H00b0" 
  ADD CONSTRAINT H00b0_redundancy
  EXCLUDE USING gist("T000b_dbid" WITH =, "T0006_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00b0
ALTER TABLE "HORG-FR_HISTORY"."H00b0" 
  ADD CONSTRAINT H00b0_contradiction
  EXCLUDE USING gist("T000b_dbid" WITH =, "T0006_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H00b0
ALTER TABLE "HORG-FR_HISTORY"."H00b0" 
  ADD CONSTRAINT H00b0_circumlocution
  EXCLUDE USING gist("T000b_dbid" WITH =, "T0006_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000006_linkedTo_HORG-FR_000005
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000006_linkedTo_HORG-FR_000005_checkHUniqueness"()
  RETURNS TABLE("T000b_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0008_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000b_dbid", "T0008_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00b4" NATURAL JOIN "HORG-FR_HISTORY"."H00b3"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000b_dbid", "T0008_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00b3" NATURAL JOIN "HORG-FR_HISTORY"."H00b2"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000b_dbid", "T0008_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00b2" NATURAL JOIN "HORG-FR_HISTORY"."H00b4"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00b3
ALTER TABLE "HORG-FR_HISTORY"."H00b3" 
  ADD CONSTRAINT H00b3_redundancy
  EXCLUDE USING gist("T000b_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00b3
ALTER TABLE "HORG-FR_HISTORY"."H00b3" 
  ADD CONSTRAINT H00b3_contradiction
  EXCLUDE USING gist("T000b_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H00b3
ALTER TABLE "HORG-FR_HISTORY"."H00b3" 
  ADD CONSTRAINT H00b3_circumlocution
  EXCLUDE USING gist("T000b_dbid" WITH =, "T0008_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000018_HORG-FR_000042_HORG-FR_000043
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000018_HORG-FR_000042_HORG-FR_000043_checkHUniqueness"()
  RETURNS TABLE("T000e_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T000e_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00b7" NATURAL JOIN "HORG-FR_HISTORY"."H00b6"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T000e_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00b6" NATURAL JOIN "HORG-FR_HISTORY"."H00b5"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T000e_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00b5" NATURAL JOIN "HORG-FR_HISTORY"."H00b7"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00b6
ALTER TABLE "HORG-FR_HISTORY"."H00b6" 
  ADD CONSTRAINT H00b6_redundancy
  EXCLUDE USING gist("T000e_dbid" WITH =, "T000f_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00b6
ALTER TABLE "HORG-FR_HISTORY"."H00b6" 
  ADD CONSTRAINT H00b6_contradiction
  EXCLUDE USING gist("T000e_dbid" WITH =, "T000f_dbid" WITH <>, vbe WITH &&);

 -- No circumlocution constraint for H00b6
ALTER TABLE "HORG-FR_HISTORY"."H00b6" 
  ADD CONSTRAINT H00b6_circumlocution
  EXCLUDE USING gist("T000e_dbid" WITH =, "T000f_dbid" WITH =, vbe WITH -|-);

 -- Temporal uniqueness ckeck for : HORG-FR_000011_unitOf_HORG-FR_000009
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."HORG-FR_000011_unitOf_HORG-FR_000009_checkHUniqueness"()
  RETURNS TABLE("T0010_dbid" "HORG-FR_HISTORY"."dbid_domain", "T0001_dbid" "HORG-FR_HISTORY"."dbid_domain", errorVt "HORG-FR_HISTORY"."PERIOD") AS
  $$
  SELECT "T0010_dbid", "T0001_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00ba" NATURAL JOIN "HORG-FR_HISTORY"."H00b9"
  WHERE vbx < upper(vbe)
  UNION
  SELECT "T0010_dbid", "T0001_dbid", vbe
  FROM "HORG-FR_HISTORY"."H00b9" NATURAL JOIN "HORG-FR_HISTORY"."H00b8"
  WHERE vxe > lower(vbe)-1
  UNION
  SELECT "T0010_dbid", "T0001_dbid", "HORG-FR_HISTORY".vbx(vbx)
  FROM "HORG-FR_HISTORY"."H00b8" NATURAL JOIN "HORG-FR_HISTORY"."H00ba"
  WHERE vxe > vbx-1;
  $$
  LANGUAGE SQL;

-- No redundancy constraint for H00b9
ALTER TABLE "HORG-FR_HISTORY"."H00b9" 
  ADD CONSTRAINT H00b9_redundancy
  EXCLUDE USING gist("T0010_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH &&);

 -- No contradiction constraint for H00b9
ALTER TABLE "HORG-FR_HISTORY"."H00b9" 
  ADD CONSTRAINT H00b9_contradiction
  EXCLUDE USING gist("T0010_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH &&);

 -- No circumlocution constraint for H00b9
ALTER TABLE "HORG-FR_HISTORY"."H00b9" 
  ADD CONSTRAINT H00b9_circumlocution
  EXCLUDE USING gist("T0010_dbid" WITH =, "T0001_dbid" WITH =, vbe WITH -|-);

 