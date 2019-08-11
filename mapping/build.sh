#
#Set the value of variable
database="UHF_test"
# ====
start=$(date '+%d/%m/%Y %H:%M:%S');
echo START MAPPING. $start
# ====
echo Importing data sources...
psql -q -d $database &> extraction/build_log.txt -f extraction/sirius_data-structure_cre.sql
psql -q -d $database &> extraction/build_log.txt -f extraction/sirius_hupo_2017.sql
psql -q -d $database &> extraction/build_log.txt -f extraction/sirius_hegp_2017.sql
psql -q -d $database &> extraction/build_log.txt -f extraction/sirius_hegp-views_cre.sql
psql -q -d $database &> extraction/build_log.txt -f extraction/sirius_hap-views_cre.sql
cat extraction/sirius_med*.sql | psql -d $database &> extraction/build_log.txt
cat extraction/sirius_ges*.sql | psql -d $database &> extraction/build_log.txt
# ====
echo Mapping initialization...
psql -q -d $database -f initialization/mapping_ini.sql &> initialization/build_log.txt
psql -q -d $database -f initialization/mapping_procedure_cre.sql &> initialization/build_log.txt
# ====
echo Mapping execution...
hegp_start=$(date '+%d/%m/%Y %H:%M:%S');
echo >> HEGP mapping start: $hegp_start and takes about 35 minutes.
psql -v ON_ERROR_STOP=1 -q -d $database &> execution/build-HEGP_log.txt -c 'SET client_min_messages TO WARNING;' -f execution/mapping_execution-HEGP.sql
hegp_end=$(date '+%d/%m/%Y %H:%M:%S');
echo >> HEGP mapping end: $hegp_end
#
hap_start=$(date '+%d/%m/%Y %H:%M:%S');
echo >> HAP mapping start: $hap_start and takes about 35 minutes.
psql -v ON_ERROR_STOP=1 -q -d $database &> execution/build-HAP_log.txt -c 'SET client_min_messages TO WARNING;' -f execution/mapping_execution-HAP.sql
hap_end=$(date '+%d/%m/%Y %H:%M:%S');
echo >> HAP mapping end: $hap_end
# ====
if [ $? -eq 0 ]; then
    echo MAPPING SUCCESS
else
    echo MAPPING FAILED
fi
# ====
end=$(date '+%d/%m/%Y %H:%M:%S');
echo END MAPPING $end. See log files for details.
