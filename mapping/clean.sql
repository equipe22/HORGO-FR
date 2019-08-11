\echo START CLEANING
\timing

\echo Dropping mapping functions...
\i extraction/sirius_data-structure_drp.sql
\o clean_log.txt

\i initialization/mapping_procedure_drp.sql
\o clean_log.txt

\cd ..
\i ots/HORG-FR_HISTORY_del-table_v0_20190417-1527.sql
\o clean_log.txt

\echo END CLEANING
