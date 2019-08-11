/* ================================================================================================
 Création des vues et des fonctions d'alimentation de la base de données historicisées des organisations.

 SGBD          : PostgreSQL 9.6+
 Auteur        : Christina.Khnaisser@usherbrooke.ca
 Date création : 2019-04-02
 Version       : 0.0.1
================================================================================================ */
SET SCHEMA 'HORG-FR_HISTORY';
-- ===================================
--
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_agentId"(_value "HORG-FR_HISTORY"."AGENTID")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    agentIdDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
  BEGIN
    SELECT "T0013_dbid" INTO agentIdDbid
    FROM "HORG-FR_HISTORY"."T0013"
    WHERE "AGENTID" = _value;
    IF agentIdDbid IS NULL THEN
      agentIdDbid := nextval('"HORG-FR_HISTORY".typeId_seq');
      RAISE NOTICE 'Creating Agent id = % %', agentIdDbid, _value;
      INSERT INTO "HORG-FR_HISTORY"."T0013"("T0013_dbid", "AGENTID") VALUES (agentIdDbid, _value);
    END IF;
    RETURN agentIdDbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT;
    RAISE EXCEPTION 'Adding agent id Failed %', err_msg;
  END;
  $$
  LANGUAGE 'plpgsql';
-- ===================================
--
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_agentLabel"(_value "HORG-FR_HISTORY"."AGENTLABEL")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    labelIdDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
  BEGIN
    SELECT "T0017_dbid" INTO labelIdDbid
    FROM "HORG-FR_HISTORY"."T0017"
    WHERE "AGENTLABEL" = _value;
    IF labelIdDbid IS NULL THEN
      labelIdDbid := nextval('"HORG-FR_HISTORY".typeId_seq');
      RAISE NOTICE 'Creating Agent label = % %', labelIdDbid, _value;
      INSERT INTO "HORG-FR_HISTORY"."T0017"("T0017_dbid", "AGENTLABEL") VALUES (labelIdDbid, _value);
    END IF;
    RETURN labelIdDbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT;
    RAISE EXCEPTION 'Adding agent label Failed %', err_msg;
  END;
  $$
  LANGUAGE 'plpgsql';
  -- ===================================
  --
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_hospital_identification"
  (_id "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    dbid "HORG-FR_HISTORY".dbid_domain;
    agentIdDbid "HORG-FR_HISTORY".dbid_domain;
    labelDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000026-Hospital identification % % %', _id, _label, _vt;
    SELECT "hospitalIdentification_dbid", "hospitalId_dbid", "hospitalLabel_dbid"
      INTO dbid, agentIdDbid, labelDbid
    FROM "HORG-FR_HISTORY"."HospitalIdentification_history"
    WHERE "hospitalId" = _id;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');
      SELECT "HORG-FR_HISTORY"."add_agentId"(_id) INTO agentIdDbid;
      SELECT "HORG-FR_HISTORY"."add_agentLabel"(_label) INTO labelDbid;
    END IF;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000026-Hospital identification vxe';
      INSERT INTO "HORG-FR_HISTORY"."H005e"("T000f_dbid", vxe) VALUES(dbid, upper(_vt)); -- Agent Identification
      INSERT INTO "HORG-FR_HISTORY"."H0040"("T0005_dbid", vxe) VALUES(dbid, upper(_vt)); -- Hospital identification
      INSERT INTO "HORG-FR_HISTORY"."H0067"("T000f_dbid", "T0013_dbid", vxe) VALUES(dbid, agentIdDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H006d"("T000f_dbid", "T0017_dbid", vxe) VALUES(dbid, labelDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000026-Hospital identification vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0060"("T000f_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0042"("T0005_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0069"("T000f_dbid", "T0013_dbid", vbx) VALUES(dbid, agentIdDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H006f"("T000f_dbid", "T0017_dbid", vbx) VALUES(dbid, labelDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000026-Hospital identification vbe';
      INSERT INTO "HORG-FR_HISTORY"."H005f"("T000f_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0041"("T0005_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0068"("T000f_dbid", "T0013_dbid", vbe) VALUES(dbid, agentIdDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H006e"("T000f_dbid", "T0017_dbid", vbe) VALUES(dbid, labelDbid, _vt);
    END IF;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000026-Hospital identification failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';
-- ===================================
--
-- TODO 2019-04-01 CK : permettre de modification d'étiquette _label d'un même type d'unité.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_unitIdentification"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID",
   _unitId "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    hospitalIdftDbid "HORG-FR_HISTORY".dbid_domain;
    unitIdftDbid "HORG-FR_HISTORY".dbid_domain;
    labelDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    vtDbid "HORG-FR_HISTORY"."PERIOD";
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000027-Unit identification % % % %', _hospitalId, _unitId, _label, _vt;
    SELECT "unitIdentification_dbid", "hospitalIdentification_dbid", "unitId_dbid", "unitLabel_dbid", "unitIdentification_dbid VT"
      INTO dbid, hospitalIdftDbid, unitIdftDbid, labelDbid, vtDbid
    FROM "HORG-FR_HISTORY"."UnitIdentification_history"
    WHERE "hospitalId" = _hospitalId AND "unitId" = _unitId AND "unitLabel" = _label ;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "hospitalIdentification_dbid" INTO hospitalIdftDbid
      FROM "HORG-FR_HISTORY"."HospitalIdentification_history"
      WHERE "hospitalId" = _hospitalId;

      IF hospitalIdftDbid IS NOT NULL THEN
        SELECT "HORG-FR_HISTORY"."add_agentId"(_unitId) INTO unitIdftDbid;
        SELECT "HORG-FR_HISTORY"."add_agentLabel"(_label) INTO labelDbid;
      ELSE
        RAISE EXCEPTION 'Adding HORG-FR_000027-Unit identification failed : Hospital % does not exist.', _hospitalId;
      END IF;
    ELSE
      vtDbid := vtDbid + _vt;
      RAISE NOTICE 'Valid time union % U % for HORG-FR_000027-Unit identification % %', vtDbid, _vt, _hospitalId, _unitId;
      IF lower(_vt) IS NULL THEN
        RAISE NOTICE 'Updating HORG-FR_000027-Unit identification % % % vxe', dbid, _hospitalId, _unitId;
        UPDATE "HORG-FR_HISTORY"."H005e" SET vxe = upper(vtDbid) WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0046" SET vxe = upper(vtDbid) WHERE "T0007_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0067" SET vxe = upper(vtDbid) WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H006d" SET vxe = upper(vtDbid) WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0097" SET vxe = upper(vtDbid) WHERE "T0007_dbid" = dbid;
       ELSEIF upper(vtDbid) IS NULL THEN
        RAISE NOTICE 'Updating HORG-FR_000027-Unit identification % % % vbx', dbid, _hospitalId, _unitId;
        UPDATE "HORG-FR_HISTORY"."H0060" SET vbx = lower(vtDbid) WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0048" SET vbx = lower(vtDbid) WHERE "T0007_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0069" SET vbx = lower(vtDbid) WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H006f" SET vbx = lower(vtDbid) WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0099" SET vbx = lower(vtDbid) WHERE "T0007_dbid" = dbid;
       ELSE
        RAISE NOTICE 'Updating HORG-FR_000027-Unit identification % % % vbe', dbid, _hospitalId, _unitId;
        UPDATE "HORG-FR_HISTORY"."H005f" SET vbe = vtDbid WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0047" SET vbe = vtDbid WHERE "T0007_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0068" SET vbe = vtDbid WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H006e" SET vbe = vtDbid WHERE "T000f_dbid" = dbid;
        UPDATE "HORG-FR_HISTORY"."H0098" SET vbe = vtDbid WHERE "T0007_dbid" = dbid;
      END IF;
      RETURN dbid;
    END IF;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000027-Unit identification vxe';
      INSERT INTO "HORG-FR_HISTORY"."H005e"("T000f_dbid", vxe) VALUES(dbid, upper(_vt)); -- Agent identification
      INSERT INTO "HORG-FR_HISTORY"."H0046"("T0007_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0067"("T000f_dbid", "T0013_dbid", vxe) VALUES(dbid, unitIdftDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H006d"("T000f_dbid", "T0017_dbid", vxe) VALUES(dbid, labelDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0097"("T0007_dbid", "T0005_dbid", vxe) VALUES(dbid, hospitalIdftDbid, upper(_vt));
    ELSEIF upper(vtDbid) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000027-Unit identification vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0060"("T000f_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0048"("T0007_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0069"("T000f_dbid", "T0013_dbid", vbx) VALUES(dbid, unitIdftDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H006f"("T000f_dbid", "T0017_dbid", vbx) VALUES(dbid, labelDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0099"("T0007_dbid", "T0005_dbid", vbx) VALUES(dbid, hospitalIdftDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000027-Unit identification vbe';
      INSERT INTO "HORG-FR_HISTORY"."H005f"("T000f_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0047"("T0007_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0068"("T000f_dbid", "T0013_dbid", vbe) VALUES(dbid, unitIdftDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H006e"("T000f_dbid", "T0017_dbid", vbe) VALUES(dbid, labelDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0098"("T0007_dbid", "T0005_dbid", vbe) VALUES(dbid, hospitalIdftDbid, _vt);
    END IF;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000027-Unit identification failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* ==============================================================================
 Alimentation Établissement de santé (Hopital)
 ================================================================================ */
-- Hypothèse 2019-04-19 CK : L'identifiant de l'hopital (hospitalId) n'est pas réutilisable.
--  alors hospitalIdentification_dbid VT = hospita_dbid VT en tout temps et
--  le couple hospitalIdentification_dbid réfère toujours au même hospitalId_dbid et hospitalId.
--  Ce qui implque de hospitalId peut être utilisé comme clé globale.
-- ===================================
--
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_hospital"
  (_id "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    rangeDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000004-Hospital % % %', _id, _label, _vt;
    SELECT "hospital_dbid", "hospitalIdentification_dbid"
      INTO dbid, rangeDbid
    FROM "HORG-FR_HISTORY"."Hospital_history"
    WHERE "hospitalId" = _id;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "hospitalIdentification_dbid" INTO rangeDbid
      FROM "HORG-FR_HISTORY"."HospitalIdentification_history"
      WHERE "hospitalId" = _id;

      IF rangeDbid IS NULL THEN
        -- RAISE EXCEPTION 'Adding ORG-FR_000004 Failed : ORG-FR_000026 does not exist';
        SELECT "HORG-FR_HISTORY"."add_hospital_identification"(_id, _label, _vt) INTO rangeDbid;
      END IF;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000004-Hospital vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0043"("T0006_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0094"("T0006_dbid", "T0005_dbid", vxe) VALUES(dbid, rangeDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000004-Hospital vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0045"("T0006_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0096"("T0006_dbid", "T0005_dbid", vbx) VALUES(dbid, rangeDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000004-Hospital vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0044"("T0006_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0095"("T0006_dbid", "T0005_dbid", vbe) VALUES(dbid, rangeDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000004-Hospital failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* ==============================================================================
 Alimentation pole de santé
 ================================================================================ */
 -- NOTE 2019-04-19 CK : un unitIdentification est uniquement déterminé par le couple hospital_dbid et unitId.
 -- Une unité peut changer de unitIdentification.
-- ===================================
--
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_healthcareDivision"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID",
   _unitId "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    hospitalDbid "HORG-FR_HISTORY".dbid_domain;
    unitIdDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000005-Healthcare division % % % %', _hospitalId, _unitId, _label, _vt;
    SELECT "division_dbid", "hospital_dbid", "unitIdentification_dbid"
      INTO dbid, hospitalDbid, unitIdDbid
    FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
    WHERE "divisionHospitalId" = _hospitalId AND "divisionId" = _unitId;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "hospital_dbid" INTO hospitalDbid
      FROM "HORG-FR_HISTORY"."Hospital_history"
      WHERE "hospitalId" = _hospitalId;
      IF hospitalDbid IS NULL THEN
        RAISE EXCEPTION 'Adding HORG-FR_000005-Healthcare division failed : HORG-FR_000004-Hospital does not exist';
      ELSE
        SELECT "unitIdentification_dbid" INTO unitIdDbid
        FROM "HORG-FR_HISTORY"."UnitIdentification_history"
        WHERE "hospitalId" = _hospitalId AND "unitId" = _unitId; --FIXME : AND "unitLabel" = _label;
        IF unitIdDbid IS NULL THEN
          SELECT "HORG-FR_HISTORY"."add_unitIdentification"(_hospitalId, _unitId, _label, _vt) INTO unitIdDbid;
        END IF;
      END IF;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000005-Healthcare division vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0037"("T0002_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007c"("T0002_dbid", "T0007_dbid", vxe) VALUES(dbid, unitIdDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0049"("T0008_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H009a"("T0008_dbid", "T0006_dbid", vxe) VALUES(dbid, hospitalDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000005-Healthcare division vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0039"("T0002_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007e"("T0002_dbid", "T0007_dbid", vbx) VALUES(dbid, unitIdDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H004b"("T0008_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H009c"("T0008_dbid", "T0006_dbid", vbx) VALUES(dbid, hospitalDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000005-Healthcare division vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0038"("T0002_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H007d"("T0002_dbid", "T0007_dbid", vbe) VALUES(dbid, unitIdDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H004a"("T0008_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H009b"("T0008_dbid", "T0006_dbid", vbe) VALUES(dbid, hospitalDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000005-Healthcare division failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* ==============================================================================
 Alimentation service et département
 ================================================================================ */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_serviceDepartement"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID",
   _unitId "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    hospitalDbid "HORG-FR_HISTORY".dbid_domain;
    unitIdDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000006-Service Departement % % % %', _hospitalId, _unitId, _label, _vt;
    SELECT "serviceDepartement_dbid", "hospital_dbid", "unitIdentification_dbid"
      INTO dbid, hospitalDbid, unitIdDbid
    FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    WHERE "serviceDepartmentHospitalId" = _hospitalId AND "serviceDepartmentId" = _unitId;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "hospital_dbid" INTO hospitalDbid
      FROM "HORG-FR_HISTORY"."Hospital_history"
      WHERE "hospitalId" = _hospitalId;
      IF hospitalDbid IS NULL THEN
        RAISE EXCEPTION 'Adding HORG-FR_000006-Service Departement failed : HORG-FR_000004-Hospital does not exist';
      ELSE
        SELECT "unitIdentification_dbid" INTO unitIdDbid
        FROM "HORG-FR_HISTORY"."UnitIdentification_history"
        WHERE "hospitalId" = _hospitalId AND "unitId" = _unitId;
        IF unitIdDbid IS NULL THEN
          SELECT "HORG-FR_HISTORY"."add_unitIdentification"(_hospitalId, _unitId, _label, _vt) INTO unitIdDbid;
        END IF;
      END IF;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000006-Service Departement vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0037"("T0002_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007c"("T0002_dbid", "T0007_dbid", vxe) VALUES(dbid, unitIdDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0052"("T000b_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H00af"("T000b_dbid", "T0006_dbid", vxe) VALUES(dbid, hospitalDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000006-Service Departement vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0039"("T0002_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007e"("T0002_dbid", "T0007_dbid", vbx) VALUES(dbid, unitIdDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0054"("T000b_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H00b1"("T000b_dbid", "T0006_dbid", vbx) VALUES(dbid, hospitalDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000006-Service Departement vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0038"("T0002_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H007d"("T0002_dbid", "T0007_dbid", vbe) VALUES(dbid, unitIdDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0053"("T000b_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H00b0"("T000b_dbid", "T0006_dbid", vbe) VALUES(dbid, hospitalDbid, _vt);
    END IF;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000006-Service Departement failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- Lien entre service et pole
-- NOTE 2019-04-01 : Les services et département ne sont pas obligatoirement rattachés à un pole.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_serviceDepartement-division"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _poleId "HORG-FR_HISTORY"."AGENTID", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    serviceDbid "HORG-FR_HISTORY".dbid_domain;
    divisionDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000006 linkedTo HORG-FR_000005 Service Departement linkedTo division %:% unitOf %:% for %',
      _hospitalId, _unitId, _hospitalId, _poleId, _vt;

    SELECT "serviceDepartement_dbid" INTO serviceDbid
    FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    WHERE "hospitalId" = _hospitalId AND "serviceDepartmentId" = _unitId;
    IF serviceDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000006 linkedTo HORG-FR_000005 Service Departement linkedTo division failed : HORG-FR_000006-Service Departement %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "division_dbid" INTO divisionDbid
    FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
    WHERE "hospitalId" = _hospitalId AND "divisionId" = _poleId;
    IF divisionDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000006 linkedTo HORG-FR_000005 Service Departement linkedTo division failed : HORG-FR_000005-Healthcare division %:% does not exist'
         , _hospitalId, _poleId;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000006 linkedTo HORG-FR_000005 Service Departement linkedTo division vxe';
      INSERT INTO "HORG-FR_HISTORY"."H00b2"("T000b_dbid", "T0008_dbid", vxe) VALUES(serviceDbid, divisionDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000006 linkedTo HORG-FR_000005 Service Departement linkedTo division vbx';
      INSERT INTO "HORG-FR_HISTORY"."H00b4"("T000b_dbid", "T0008_dbid", vbx) VALUES(serviceDbid, divisionDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000006 linkedTo HORG-FR_000005 Service Departement linkedTo division vbe';
      INSERT INTO "HORG-FR_HISTORY"."H00b3"("T000b_dbid", "T0008_dbid", vbe) VALUES(serviceDbid, divisionDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000006 unitOf HORG-FR_000005 Service Departement unitOf division failed % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* ==============================================================================
 Alimentation unité de gestion
 ================================================================================ */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_managementUnit"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _divisionId "HORG-FR_HISTORY"."AGENTID",
   _unitId "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    rangeDbid "HORG-FR_HISTORY".dbid_domain;
    unitIdDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000009-Management unit % % % %', _hospitalId, _unitId, _label, _vt;
    SELECT "managementUnit_dbid", "division_dbid", "unitIdentification_dbid"
      INTO dbid, rangeDbid, unitIdDbid
    FROM "HORG-FR_HISTORY"."ManagementUnit_history"
    WHERE "managementUnitHospitalId" = _hospitalId AND "managementUnitId" = _unitId;
    -- FIXME AND "divisionId" = _divisionId;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "division_dbid" INTO rangeDbid
      FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
      WHERE "hospitalId" = _hospitalId AND "divisionId" = _divisionId;
      IF rangeDbid IS NULL THEN
        RAISE EXCEPTION 'Adding HORG-FR_000009-Management unit % % failed: HORG-FR_000005-Division % does not exist'
        , _hospitalId, _unitId, _divisionId;
      END IF;

      SELECT "HORG-FR_HISTORY"."add_unitIdentification"(_hospitalId, _unitId, _label, _vt) INTO unitIdDbid;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000009-Management unit vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0037"("T0002_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007c"("T0002_dbid", "T0007_dbid", vxe) VALUES(dbid, unitIdDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0034"("T0001_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0079"("T0001_dbid", "T0008_dbid", vxe) VALUES(dbid, rangeDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000009-Management unit vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0039"("T0002_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007e"("T0002_dbid", "T0007_dbid", vbx) VALUES(dbid, unitIdDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0036"("T0001_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007b"("T0001_dbid", "T0008_dbid", vbx) VALUES(dbid, rangeDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000009-Management unit vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0038"("T0002_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H007d"("T0002_dbid", "T0007_dbid", vbe) VALUES(dbid, unitIdDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0035"("T0001_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H007a"("T0001_dbid", "T0008_dbid", vbe) VALUES(dbid, rangeDbid, _vt);
    END IF;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000009-Management unit failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* ==============================================================================
 Alimentation unité fonctionnelle
 ================================================================================ */
-- NOTE 2019-04-02 CK : les spécialités médicales ne sont pas historicisées. Seule la table vbx est utilisé avec la
-- date = 1860-01-01
-- TODO 2019-04-02 CK : tenir compte du changement des labels du même code spécialité
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_medicalSpeciality"(_id "HORG-FR_HISTORY"."MEDICALSPECODE", _label "HORG-FR_HISTORY"."string")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    speDbid "HORG-FR_HISTORY".dbid_domain;
    speCodeDbid "HORG-FR_HISTORY".dbid_domain;
    speLabelDbid "HORG-FR_HISTORY".dbid_domain;
    vt "HORG-FR_HISTORY"."PERIOD";
    err_msg TEXT;
  BEGIN
    SELECT "medicalSpeciality_dbid", "medicalSpecialityCode_dbid", "medicalSpecialityLabel_dbid"
      INTO speDbid, speCodeDbid, speLabelDbid
    FROM "HORG-FR_HISTORY"."MedicalSpeciality"
    WHERE "medicalSpecialityCode" = _id;

    vt := daterange('1990-01-01', null);
    IF speDbid IS NULL THEN
      speDbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "T001c_dbid" INTO speCodeDbid
      FROM "HORG-FR_HISTORY"."T001c"
      WHERE "MEDICALSPECODE" = _id;
      IF speCodeDbid IS NULL THEN
        speCodeDbid := nextval('"HORG-FR_HISTORY".dbid_seq');
        INSERT INTO "HORG-FR_HISTORY"."T001c"("T001c_dbid", "MEDICALSPECODE") VALUES(speCodeDbid, _id);
      END IF;

      SELECT "T0011_dbid" INTO speLabelDbid
      FROM "HORG-FR_HISTORY"."T0011"
      WHERE "string" = _label;
      IF speLabelDbid IS NULL THEN
        speLabelDbid := nextval('"HORG-FR_HISTORY".dbid_seq');
        INSERT INTO "HORG-FR_HISTORY"."T0011"("T0011_dbid", string) VALUES(speLabelDbid, _label);
      END IF;

      RAISE NOTICE 'Creating Medical speciality %: % %', speDbid, _id, _label;
      INSERT INTO "HORG-FR_HISTORY"."H0057"("T000c_dbid", vbx) VALUES (speDbid, lower(vt));
      INSERT INTO "HORG-FR_HISTORY"."H0078"("T000c_dbid", "T001c_dbid", vbx) VALUES (speDbid, speCodeDbid, lower(vt));
      INSERT INTO "HORG-FR_HISTORY"."H0066"("T000c_dbid", "T0011_dbid", vbx) VALUES (speDbid, speLabelDbid, lower(vt));
    END IF;
    RETURN speDbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT;
    RAISE EXCEPTION 'Adding medical speciality failed %', err_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- =================================== HORG-FR_0000016
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_functionalUnit"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _divisionId "HORG-FR_HISTORY"."AGENTID",
   _unitId "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    rangeDbid "HORG-FR_HISTORY".dbid_domain;
    unitIdDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000016-Functional unit % % % %', _hospitalId, _unitId, _label, _vt;
    SELECT "functionalUnit_dbid", "division_dbid", "unitIdentification_dbid"
      INTO dbid, rangeDbid, unitIdDbid
    FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
    WHERE "functionalUnitHospitalId" = _hospitalId AND "functionalUnitId" = _unitId;
      -- FIXME : AND "divisionId" = _divisionId;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "division_dbid" INTO rangeDbid
      FROM "HORG-FR_HISTORY"."HealthcareDivision_history"
      WHERE "hospitalId" = _hospitalId AND "divisionId" = _divisionId;
      IF rangeDbid IS NULL THEN
        RAISE EXCEPTION 'Adding HORG-FR_000016-Functional unit % % failed : HORG-FR_000005-Division % does not exist'
        , _hospitalId, _unitId, _divisionId;
      END IF;

      SELECT "HORG-FR_HISTORY"."add_unitIdentification"(_hospitalId, _unitId, _label, _vt) INTO unitIdDbid;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000016-Functional unit vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0037"("T0002_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007c"("T0002_dbid", "T0007_dbid", vxe) VALUES(dbid, unitIdDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H004f"("T000a_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H00a6"("T000a_dbid", "T0008_dbid", vxe) VALUES(dbid, rangeDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000016-Functional unit vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0039"("T0002_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007e"("T0002_dbid", "T0007_dbid", vbx) VALUES(dbid, unitIdDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0051"("T000a_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H00a8"("T000a_dbid", "T0008_dbid", vbx) VALUES(dbid, rangeDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000016-Functional unit vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0038"("T0002_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H007d"("T0002_dbid", "T0007_dbid", vbe) VALUES(dbid, unitIdDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0050"("T000a_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H00a7"("T000a_dbid", "T0008_dbid", vbe) VALUES(dbid, rangeDbid, _vt);
    END IF;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000016-Functional unit failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* -- Vérifier si une unité fonctionnelle est relié à un seul pole
SELECT uf_code, count(pole_code)
FROM unitfonctionnelle
WHERE filedate = '2019'
GROUP BY uf_code
*/
-- Récupérer le lien unité fonctionnelle spécialité
-- NOTE 2019-04-01 : Les unités fonctionnelles n'ont pas obligatoirement une spécialité.
--   Le vt est la date de validité de la création de l'unité.
-- TODO 2019-04-02 CK : détecter les variations de spécialités.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_functionalUnit-speciality"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _speCode "HORG-FR_HISTORY"."MEDICALSPECODE", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    unitDbid "HORG-FR_HISTORY".dbid_domain;
    speDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000016 HORG-FR_000028 HORG-FR_000017 Functional unit %:% has specified value medical speciality %:% during',
      _hospitalId, _unitId, _speCode, _vt;

    SELECT "functionalUnit_dbid" INTO unitDbid
    FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
    WHERE "functionalUnitHospitalId" = _hospitalId AND "functionalUnitId" = _unitId;
    IF unitDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000016 HORG-FR_000028  HORG-FR_000017 Functional unit has specified value medical speciality failed : HORG-FR_000016-Functional unit %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "medicalSpeciality_dbid" INTO speDbid
    FROM "HORG-FR_HISTORY"."MedicalSpeciality"
    WHERE "medicalSpecialityCode" = _speCode;
    IF speDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000016 HORG-FR_000028 HORG-FR_000017 Functional unit has specified value medical speciality failed : HORG-FR_000017-Medical speciality % does not exist'
         , _speCode;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000016 HORG-FR_000028 HORG-FR_000017 Functional unit has specified value medical speciality vxe';
      INSERT INTO "HORG-FR_HISTORY"."H00a3"("T000a_dbid", "T000c_dbid", vxe) VALUES(unitDbid, speDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000016 HORG-FR_000028 HORG-FR_000017 Functional unit has specified value medical speciality vbx';
      INSERT INTO "HORG-FR_HISTORY"."H00a5"("T000a_dbid", "T000c_dbid", vbx) VALUES(unitDbid, speDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT hORG-FR_000016 HORG-FR_000028 HORG-FR_000017 Functional unit has specified value medical speciality vbe';
      INSERT INTO "HORG-FR_HISTORY"."H00a4"("T000a_dbid", "T000c_dbid", vbe) VALUES(unitDbid, speDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding ORG-FR_000016 HORG-FR_000028 ORG-FR_000017 Functional unit has specified value medical speciality failed % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- Liens entre unité fonctionnelles et services
-- NOTE 2019-04-01 : Les unités fonctionnelles n'ont pas obligatoirement liées à un service.
--   Le vt est la date de validité de la création du service
-- TODO 2019-04-02 CK : détecter les variations de services.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_functionalUnit-service"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _serviceId "HORG-FR_HISTORY"."AGENTID", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    unitDbid "HORG-FR_HISTORY".dbid_domain;
    serviceDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000016 unitOf HORG-FR_000006 Functional unit %:% linkedTo Service Departement %:% during',
      _hospitalId, _unitId, _serviceId, _vt;

    SELECT "functionalUnit_dbid" INTO unitDbid
    FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
    WHERE "functionalUnitHospitalId" = _hospitalId AND "functionalUnitId" = _unitId;
    IF unitDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000016 unitOf HORG-FR_000006 Functional unit linkedTo Service Departement failed : HORG-FR_000016-Functional unit %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "serviceDepartement_dbid" INTO serviceDbid
    FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    WHERE "hospitalId" = _hospitalId AND "serviceDepartmentId" = _serviceId;
    IF serviceDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000016 unitOf HORG-FR_000006 Functional unit linkedTo Service Departement failed : HORG-FR_000006-Service Departement % does not exist'
         , _serviceId;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000016 unitOf HORG-FR_000006 Functional unit linkedTo Service Departement vxe';
      INSERT INTO "HORG-FR_HISTORY"."H00a9"("T000a_dbid", "T000b_dbid", vxe) VALUES(unitDbid, serviceDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000016 unitOf HORG-FR_000006 Functional unit linkedTo Service Departement vbx';
      INSERT INTO "HORG-FR_HISTORY"."H00ab"("T000a_dbid", "T000b_dbid", vbx) VALUES(unitDbid, serviceDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000016 unitOf HORG-FR_000006 Functional unit linkedTo Service Departement vbe';
      INSERT INTO "HORG-FR_HISTORY"."H00aa"("T000a_dbid", "T000b_dbid", vbe) VALUES(unitDbid, serviceDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000016 unitOf HORG-FR_000006 Functional unit linkedTo Service Departement failed % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- Liens entre unité fonctionnelles et unité de gestion
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_functionalUnit-managementUnit"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _managmentUnitId "HORG-FR_HISTORY"."AGENTID", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    unitDbid "HORG-FR_HISTORY".dbid_domain;
    serviceDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000016 unitOf HORG-FR_000009 Functional unit %:% linkedTo Management unit %:% during',
      _hospitalId, _unitId, _managmentUnitId, _vt;

    SELECT "functionalUnit_dbid" INTO unitDbid
    FROM "HORG-FR_HISTORY"."FunctionalUnit_history"
    WHERE "functionalUnitHospitalId" = _hospitalId AND "functionalUnitId" = _unitId;
    IF unitDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000016 unitOf HORG-FR_000009 Functional unit linkedTo Management unit failed : HORG-FR_000016-Functional unit %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "managementUnit_dbid" INTO serviceDbid
    FROM "HORG-FR_HISTORY"."ManagementUnit_history"
    WHERE "managementUnitHospitalId" = _hospitalId AND "managementUnitId" = _managmentUnitId;
    IF serviceDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000016 unitOf HORG-FR_000009 Functional unit linkedTo Service Departement failed : HORG-FR_000009-Management unit % does not exist'
         , _managmentUnitId;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000016 unitOf HORG-FR_000009 Functional unit linkedTo Management unit vxe';
      INSERT INTO "HORG-FR_HISTORY"."H00ac"("T000a_dbid", "T0001_dbid", vxe) VALUES(unitDbid, serviceDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000016 unitOf HORG-FR_000009 Functional unit linkedTo Management unit vbx';
      INSERT INTO "HORG-FR_HISTORY"."H00ae"("T000a_dbid", "T0001_dbid", vbx) VALUES(unitDbid, serviceDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000016 unitOf HORG-FR_000009 Functional unit linkedTo Management unit vbe';
      INSERT INTO "HORG-FR_HISTORY"."H00ad"("T000a_dbid", "T0001_dbid", vbe) VALUES(unitDbid, serviceDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000016 unitOf HORG-FR_000009 Functional unit linkedTo Management unit failed % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* ==============================================================================
 Alimentation unité de médico-administrative
 ================================================================================ */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_medicoAdministrativeUnit"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _managementUnitId "HORG-FR_HISTORY"."AGENTID",
   _unitId "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    rangeDbid "HORG-FR_HISTORY".dbid_domain;
    unitIdDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000011-Medico-administrative unit % % % %', _hospitalId, _unitId, _label, _vt;
    SELECT "medicoAdministrativeUnit_dbid", "managementUnit_dbid", "unitIdentification_dbid"
      INTO dbid, rangeDbid, unitIdDbid
    FROM "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history"
    WHERE "medicoAdministrativeUnitHospitalId" = _hospitalId AND "medicoAdministrativeUnitId" = _unitId;
      --FIXME : AND "managementUnitId" = _managementUnitId;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "managementUnit_dbid" INTO rangeDbid
      FROM "HORG-FR_HISTORY"."ManagementUnit_history"
      WHERE "managementUnitHospitalId" = _hospitalId AND "managementUnitId" = _managementUnitId;
      IF rangeDbid IS NULL THEN
        RAISE EXCEPTION 'Adding HORG-FR_000011-Medico-administrative unit % % failed : ORG-FR_000009-Management unit % does not exist'
        , _hospitalId, _unitId, _managementUnitId;
      END IF;

      SELECT "HORG-FR_HISTORY"."add_unitIdentification"(_hospitalId, _unitId, _label, _vt) INTO unitIdDbid;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000011-Medico-administrative unit vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0037"("T0002_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007c"("T0002_dbid", "T0007_dbid", vxe) VALUES(dbid, unitIdDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0061"("T0010_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H00b8"("T0010_dbid", "T0001_dbid", vxe) VALUES(dbid, rangeDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000011-Medico-administrative unitvbx';
      INSERT INTO "HORG-FR_HISTORY"."H0039"("T0002_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007e"("T0002_dbid", "T0007_dbid", vbx) VALUES(dbid, unitIdDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0063"("T0010_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H00ba"("T0010_dbid", "T0001_dbid", vbx) VALUES(dbid, rangeDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000011-Medico-administrative unit vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0038"("T0002_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H007d"("T0002_dbid", "T0007_dbid", vbe) VALUES(dbid, unitIdDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0062"("T0010_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H00b9"("T0010_dbid", "T0001_dbid", vbe) VALUES(dbid, rangeDbid, _vt);
    END IF;
    END IF ;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding ORG-FR_000011-Medico-administrative unit failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* ==============================================================================
 Procédure d'alimentation unité administrative
 ================================================================================ */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_administrativeUnit"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _managementUnitId "HORG-FR_HISTORY"."AGENTID",
   _unitId "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    rangeDbid "HORG-FR_HISTORY".dbid_domain;
    unitIdDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000025-Administrative unit % % % %', _hospitalId, _unitId, _label, _vt;
    SELECT "administrativeUnit_dbid", "managementUnit_dbid", "unitIdentification_dbid"
      INTO dbid, rangeDbid, unitIdDbid
    FROM "HORG-FR_HISTORY"."AdministrativeUnit_history"
    WHERE "administrativeUnitHospitalId" = _hospitalId AND "administrativeUnitId" = _unitId;
      --AND "managementUnitId" = _managementUnitId;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "managementUnit_dbid" INTO rangeDbid
      FROM "HORG-FR_HISTORY"."ManagementUnit_history"
      WHERE "managementUnitHospitalId" = _hospitalId AND "managementUnitId" = _managementUnitId;
      IF rangeDbid IS NULL THEN
        RAISE EXCEPTION 'Adding HORG-FR_000025-Administrative unit % % failed: HORG-FR_000009-Management unit % does not exist'
        , _hospitalId, _unitId, _managementUnitId;
      END IF;

      SELECT "HORG-FR_HISTORY"."add_unitIdentification"(_hospitalId, _unitId, _label, _vt) INTO unitIdDbid;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000025-Administrative unit vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0037"("T0002_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007c"("T0002_dbid", "T0007_dbid", vxe) VALUES(dbid, unitIdDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H003d"("T0004_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H008b"("T0004_dbid", "T0001_dbid", vxe) VALUES(dbid, rangeDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000025-Administrative unit vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0039"("T0002_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007e"("T0002_dbid", "T0007_dbid", vbx) VALUES(dbid, unitIdDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H003f"("T0004_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H008d"("T0004_dbid", "T0001_dbid", vbx) VALUES(dbid, rangeDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000025-Administrative unit vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0038"("T0002_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H007d"("T0002_dbid", "T0007_dbid", vbe) VALUES(dbid, unitIdDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H003e"("T0004_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H008c"("T0004_dbid", "T0001_dbid", vbe) VALUES(dbid, rangeDbid, _vt);
    END IF;
    END IF;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000025-Administrative unit failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- NOTE 2019-04-02 CK : les disiciplines médicales ne sont pas historicisées. Seule la table vbx est utilisé avec la
-- date = 1990-01-01
-- TODO 2019-04-02 CK : tenir compte du changement des labels du même code de discipline.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_medicalDiscipline"
  (_id "HORG-FR_HISTORY"."DISCIPLINECODE", _label "HORG-FR_HISTORY"."string")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    dbid "HORG-FR_HISTORY".dbid_domain;
    codeDbid "HORG-FR_HISTORY".dbid_domain;
    labelDbid "HORG-FR_HISTORY".dbid_domain;
    vt "HORG-FR_HISTORY"."PERIOD";
    err_msg TEXT;
  BEGIN
    SELECT "medicalDiscipline_dbid", "medicalDisciplineCode_dbid", "medicalDisciplineLabel_dbid"
      INTO dbid, codeDbid, labelDbid
    FROM "HORG-FR_HISTORY"."MedicalDiscipline"
    WHERE "medicalDisciplineCode" = _id;

    vt := daterange('1990-01-01', null);
    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "T0015_dbid" INTO codeDbid
      FROM "HORG-FR_HISTORY"."T0015"
      WHERE "DISCIPLINECODE" = _id;
      IF codeDbid IS NULL THEN
        codeDbid := nextval('"HORG-FR_HISTORY".dbid_seq');
        INSERT INTO "HORG-FR_HISTORY"."T0015"("T0015_dbid", "DISCIPLINECODE") VALUES(codeDbid, _id);
      END IF;

      SELECT "T0011_dbid" INTO labelDbid
      FROM "HORG-FR_HISTORY"."T0011"
      WHERE "string" = _label;
      IF labelDbid IS NULL THEN
        labelDbid := nextval('"HORG-FR_HISTORY".dbid_seq');
        INSERT INTO "HORG-FR_HISTORY"."T0011"("T0011_dbid", string) VALUES(labelDbid, _label);
      END IF;

      RAISE NOTICE 'Creating medical discipline %: % %', dbid, _id, _label;
      INSERT INTO "HORG-FR_HISTORY"."H005a"("T000d_dbid", vbx) VALUES (dbid, lower(vt));
      INSERT INTO "HORG-FR_HISTORY"."H006c"("T000d_dbid", "T0015_dbid", vbx) VALUES (dbid, codeDbid, lower(vt));
      INSERT INTO "HORG-FR_HISTORY"."H0072"("T000d_dbid", "T0011_dbid", vbx) VALUES (dbid, labelDbid, lower(vt));
    END IF;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT;
    RAISE EXCEPTION 'Adding medical discipline failed %', err_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- Récupérer le lien unité administrative et discipline
-- NOTE 2019-04-01 : Les unités administratives n'ont pas obligatoirement une discipline.
--   Le vt est la date de validité de la création de l'unité
-- TODO 2019-04-02 CK : détecter les variations de spécialités.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_administrativeUnit-discipline"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _disciplineCode "HORG-FR_HISTORY"."DISCIPLINECODE", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    unitDbid "HORG-FR_HISTORY".dbid_domain;
    disciplineDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000025 HORG-FR_000028 HORG-FR_000039 Administrative unit %:% has specified value medical discipline %:% during',
      _hospitalId, _unitId, _disciplineCode, _vt;

    SELECT "administrativeUnit_dbid" INTO unitDbid
    FROM "HORG-FR_HISTORY"."AdministrativeUnit_history"
    WHERE "administrativeUnitId" = _unitId AND "administrativeUnitHospitalId" = _hospitalId;
    IF unitDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000025 HORG-FR_000028 HORG-FR_000039 Administrative unit has specified value medical discipline failed: HORG-FR_000025-Administrative unit %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "medicalDiscipline_dbid" INTO disciplineDbid
    FROM "HORG-FR_HISTORY"."MedicalDiscipline"
    WHERE "medicalDisciplineCode" = _disciplineCode;
    IF disciplineDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000025 HORG-FR_000028 HORG-FR_000039 Administrative unit has specified value medical discipline failed: HORG-FR_000039-Medical discipline % does not exist'
         , _disciplineCode;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000025 HORG-FR_000028 HORG-FR_000039 Administrative unit has specified value medical discipline vxe';
      INSERT INTO "HORG-FR_HISTORY"."H008e"("T0004_dbid", "T000d_dbid", vxe) VALUES(unitDbid, disciplineDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000025 HORG-FR_000028 HORG-FR_000039 Administrative unit has specified value medical discipline vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0090"("T0004_dbid", "T000d_dbid", vbx) VALUES(unitDbid, disciplineDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000025 HORG-FR_000028 HORG-FR_000039 Administrative unit has specified value medical discipline vbe';
      INSERT INTO "HORG-FR_HISTORY"."H008f"("T0004_dbid", "T000d_dbid", vbe) VALUES(unitDbid, disciplineDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000025 HORG-FR_000028 HORG-FR_000039 Administrative unit has specified value medical discipline failed: % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- NOTE 2019-04-01 : Les unités fonctionnelles n'ont pas obligatoirement liées à un service.
--   Le vt est la date de validité de la création du service
-- TODO 2019-04-02 CK : détecter les variations de services.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_administrativeUnit-service"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _serviceId "HORG-FR_HISTORY"."AGENTID", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    unitDbid "HORG-FR_HISTORY".dbid_domain;
    serviceDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000025 linkedTo HORG-FR_000006 Administrative unit %:% linkedTo Service Departement %:% during',
      _hospitalId, _unitId, _serviceId, _vt;

    SELECT "administrativeUnit_dbid" INTO unitDbid
    FROM "HORG-FR_HISTORY"."AdministrativeUnit_history"
    WHERE "administrativeUnitHospitalId" = _hospitalId AND "administrativeUnitId" = _unitId;
    IF unitDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000025 linkedTo HORG-FR_000006 Administrative unit linkedTo Service Departement failed : HORG-FR_000025-Administrative unit %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "serviceDepartement_dbid" INTO serviceDbid
    FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    WHERE "hospitalId" = _hospitalId AND "serviceDepartmentId" = _serviceId;
    IF serviceDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000025 linkedTo HORG-FR_000006 Administrative unit linkedTo Service Departement failed : HORG-FR_000006-Service Departement % does not exist'
         , _serviceId;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000025 linkedTo HORG-FR_000006 Administrative unit linkedTo Service Departement vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0088"("T0004_dbid", "T000b_dbid", vxe) VALUES(unitDbid, serviceDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000025 linkedTo HORG-FR_000006 Administrative unit linkedTo Service Departement vbx';
      INSERT INTO "HORG-FR_HISTORY"."H008a"("T0004_dbid", "T000b_dbid", vbx) VALUES(unitDbid, serviceDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000025 linkedTo HORG-FR_000006 Administrative unit linkedTo Service Departement vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0089"("T0004_dbid", "T000b_dbid", vbe) VALUES(unitDbid, serviceDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000025 linkedTo HORG-FR_000006 Administrative unit linkedTo Service Departement failed % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';
  -- ===================================
  -- Liens entre unité administratives et les unités médico-administratives
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_administrativeUnit-medicoAdministrativeUnit"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _umaId "HORG-FR_HISTORY"."AGENTID", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    unitDbid "HORG-FR_HISTORY".dbid_domain;
    umaDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000025 linkedTo HORG-FR_000011 Administrative unit %:% linkedTo Medico-administrative unit %:% during',
      _hospitalId, _unitId, _umaId, _vt;

    SELECT "administrativeUnit_dbid" INTO unitDbid
    FROM "HORG-FR_HISTORY"."AdministrativeUnit_history"
    WHERE "administrativeUnitHospitalId" = _hospitalId AND "administrativeUnitId" = _unitId;
    IF unitDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000025 linkedTo HORG-FR_000011 Administrative unit linkedTo Medico-administrative unit faile : HORG-FR_000025-Administrativw unit %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "medicoAdministrativeUnit_dbid" INTO umaDbid
    FROM "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history"
    WHERE "medicoAdministrativeUnitHospitalId" = _hospitalId AND "medicoAdministrativeUnitId" = _umaId;
    IF umaDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000025 linkedTo HORG-FR_000011 Administrative unit linkedTo Medico-administrative unitfailed : HORG-FR_0000011-Medico-Administrative unit % does not exist'
         , _umaId;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000025 linkedTo HORG-FR_000011 Administrative unit linkedTo Medico-administrative unit vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0091"("T0004_dbid", "T0010_dbid", vxe) VALUES(unitDbid, umaDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000025 linkedTo HORG-FR_000011 Administrative unit linkedTo Medico-administrative unit vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0093"("T0004_dbid", "T0010_dbid", vbx) VALUES(unitDbid, umaDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000025 linkedTo HORG-FR_000011 Administrative unit linkedTo Medico-administrative unit vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0092"("T0004_dbid", "T0010_dbid", vbe) VALUES(unitDbid, umaDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000025 linkedTo HORG-FR_000011 Administrative unit linkedTo Medico-administrative unit failed % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

/* ==============================================================================
 Procédure d'alimentation unité hospitalières
 ================================================================================ */
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_hospitalizationUnit"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _medicoAdminUnitId "HORG-FR_HISTORY"."AGENTID",
   _unitId "HORG-FR_HISTORY"."AGENTID", _label "HORG-FR_HISTORY"."AGENTLABEL", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS "HORG-FR_HISTORY".dbid_domain AS
  $$
  DECLARE
    rangeDbid "HORG-FR_HISTORY".dbid_domain;
    unitIdDbid "HORG-FR_HISTORY".dbid_domain;
    dbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000012-Hospitalization unit % % % %', _hospitalId, _unitId, _label, _vt;
    SELECT "hospitalizationUnit_dbid", "medicoAdministrativeUnit_dbid", "unitIdentification_dbid"
      INTO dbid, rangeDbid, unitIdDbid
    FROM "HORG-FR_HISTORY"."HospitalizationUnit_history"
    WHERE "hospitalizationUnitHospitalId" = _hospitalId AND "hospitalizationUnitId" = _unitId;
      --FIXME : AND "medicoAdministrativeUnitId" = _medicoAdminUnitId;

    IF dbid IS NULL THEN
      dbid := nextval('"HORG-FR_HISTORY".dbid_seq');

      SELECT "medicoAdministrativeUnit_dbid" INTO rangeDbid
      FROM "HORG-FR_HISTORY"."MedicoAdministrativeUnit_history"
      WHERE "medicoAdministrativeUnitHospitalId" = _hospitalId AND "medicoAdministrativeUnitId" = _medicoAdminUnitId;
      IF rangeDbid IS NULL THEN
        RAISE EXCEPTION 'Adding HORG-FR_000012-Hospitalization unit % % failed : HORG-FR_000011-Medico-administrative unit % does not exist'
        , _hospitalId, _unitId, _medicoAdminUnitId;
      END IF;

      SELECT "HORG-FR_HISTORY"."add_unitIdentification"(_hospitalId, _unitId, _label, _vt) INTO unitIdDbid;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000012-Hospitalization unit vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0037"("T0002_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007c"("T0002_dbid", "T0007_dbid", vxe) VALUES(dbid, unitIdDbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H003a"("T0003_dbid", vxe) VALUES(dbid, upper(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0082"("T0003_dbid", "T0010_dbid", vxe) VALUES(dbid, rangeDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000012-Hospitalization unit vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0039"("T0002_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H007e"("T0002_dbid", "T0007_dbid", vbx) VALUES(dbid, unitIdDbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H003c"("T0003_dbid", vbx) VALUES(dbid, lower(_vt));
      INSERT INTO "HORG-FR_HISTORY"."H0084"("T0003_dbid", "T0010_dbid", vbx) VALUES(dbid, rangeDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000012-Hospitalization unit vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0038"("T0002_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H007d"("T0002_dbid", "T0007_dbid", vbe) VALUES(dbid, unitIdDbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H003b"("T0003_dbid", vbe) VALUES(dbid, _vt);
      INSERT INTO "HORG-FR_HISTORY"."H0083"("T0003_dbid", "T0010_dbid", vbe) VALUES(dbid, rangeDbid, _vt);
    END IF;
    RETURN dbid;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000011-Medico-administrative unit failed % %', err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- ===================================
-- Liens entre unité administratives et les services
-- TODO 2019-04-02 CK : détecter les variations de services.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_hospitalizationUnit-service"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _serviceId "HORG-FR_HISTORY"."AGENTID", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    unitDbid "HORG-FR_HISTORY".dbid_domain;
    serviceDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000012-ORG linkedTo HORG-FR_000006 Hospitalization unit %:% linkedTo Service Departement %:% during',
      _hospitalId, _unitId, _serviceId, _vt;

    SELECT "hospitalizationUnit_dbid" INTO unitDbid
    FROM "HORG-FR_HISTORY"."HospitalizationUnit_history"
    WHERE "hospitalizationUnitHospitalId" = _hospitalId AND "hospitalizationUnitId" = _unitId;
    IF unitDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000012 linkedTo HORG-FR_000006 Hospitalization unit linkedTo Service Departement failed : HORG-FR_000012-Hospitalization unit %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "serviceDepartement_dbid" INTO serviceDbid
    FROM "HORG-FR_HISTORY"."ServiceDepartement_history"
    WHERE "hospitalId" = _hospitalId AND "serviceDepartmentId" = _serviceId;
    IF serviceDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000012 linkedTo HORG-FR_000006 Hospitalization unit linkedTo Service Departement failed : HORG-FR_000006-Service Departement % does not exist'
         , _serviceId;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000012 linkedTo HORG-FR_000006 Hospitalization unit linkedTo Service Departement vxe';
      INSERT INTO "HORG-FR_HISTORY"."H007f"("T0003_dbid", "T000b_dbid", vxe) VALUES(unitDbid, serviceDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000012 linkedTo HORG-FR_000006 Hospitalization unit linkedTo Service Departement vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0081"("T0003_dbid", "T000b_dbid", vbx) VALUES(unitDbid, serviceDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000012 linkedTo HORG-FR_000006 Hospitalization unit linkedTo Service Departement vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0080"("T0003_dbid", "T000b_dbid", vbe) VALUES(unitDbid, serviceDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000012 linkedTo HORG-FR_000006 Hospitalization unit linkedTo Service Departement failed % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';

-- ===================================
-- Liens entre unité d'hospitalisation et les unité administratives
-- TODO 2019-04-02 CK : détecter les variations de services.
CREATE OR REPLACE FUNCTION "HORG-FR_HISTORY"."add_hospitalizationUnit-administrativeUnit"
  (_hospitalId "HORG-FR_HISTORY"."AGENTID", _unitId "HORG-FR_HISTORY"."AGENTID",
   _adminId "HORG-FR_HISTORY"."AGENTID", _vt "HORG-FR_HISTORY"."PERIOD")
  RETURNS VOID AS
  $$
  DECLARE
    unitDbid "HORG-FR_HISTORY".dbid_domain;
    adminDbid "HORG-FR_HISTORY".dbid_domain;
    err_msg TEXT;
    detail_msg TEXT;
  BEGIN
    RAISE NOTICE 'Add HORG-FR_000012-ORG linkedTo HORG-FR_000025 Hospitalization unit %:% linkedTo Administrative unit %:% during',
      _hospitalId, _unitId, _adminId, _vt;

    SELECT "hospitalizationUnit_dbid" INTO unitDbid
    FROM "HORG-FR_HISTORY"."HospitalizationUnit_history"
    WHERE "hospitalizationUnitHospitalId" = _hospitalId AND "hospitalizationUnitId" = _unitId;
    IF unitDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000012 linkedTo HORG-FR_000025 Hospitalization unit linkedTo Administrative unit failed : HORG-FR_000012-Hospitalization unit %:% does not exist'
        , _hospitalId, _unitId;
    END IF;

    SELECT "administrativeUnit_dbid" INTO adminDbid
    FROM "HORG-FR_HISTORY"."AdministrativeUnit_history"
    WHERE "administrativeUnitHospitalId" = _hospitalId AND "administrativeUnitId" = _adminId;
    IF adminDbid IS NULL THEN
      RAISE EXCEPTION 'Adding HORG-FR_000012 linkedTo HORG-FR_000025 Hospitalization unit linkedTo Administrative unit failed : HORG-FR_000025-Administrative unit% does not exist'
         , _adminId;
    END IF ;

    IF lower(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000012 linkedTo HORG-FR_000025 Hospitalization unit linkedTo Administrative unit vxe';
      INSERT INTO "HORG-FR_HISTORY"."H0085"("T0003_dbid", "T0004_dbid", vxe) VALUES(unitDbid, adminDbid, upper(_vt));
    ELSEIF upper(_vt) IS NULL THEN
      RAISE NOTICE 'INSERT HORG-FR_000012 linkedTo HORG-FR_000025 Hospitalization unit linkedTo Administrative unit vbx';
      INSERT INTO "HORG-FR_HISTORY"."H0087"("T0003_dbid", "T0004_dbid", vbx) VALUES(unitDbid, adminDbid, lower(_vt));
    ELSE
      RAISE NOTICE 'INSERT HORG-FR_000012 linkedTo HORG-FR_000025 Hospitalization unit linkedTo Administrative unit vbe';
      INSERT INTO "HORG-FR_HISTORY"."H0086"("T0003_dbid", "T0004_dbid", vbe) VALUES(unitDbid, adminDbid, _vt);
    END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS err_msg = MESSAGE_TEXT, detail_msg = PG_EXCEPTION_DETAIL;
    RAISE EXCEPTION 'Adding HORG-FR_000012 linkedTo HORG-FR_000025 Hospitalization unit linkedTo Administrative unit failed % %',
      err_msg, detail_msg;
  END;
  $$
  LANGUAGE 'plpgsql';
