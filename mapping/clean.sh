#
#Set the value of variable
database="UHF_test"
# ====
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "START CLEANING. $dt"
# ====
echo "Dropping mapping functions..."
psql -q -d $database &> clean_log.txt -f ../ots/HORG-FR_HISTORY_del-table_v0_20190417-1527.sql
psql -v ON_ERROR_STOP=1 -d $database &> clean_log.txt -f extraction/sirius_data-structure_drp.sql
psql -v ON_ERROR_STOP=1 -d $database &> clean_log.txt -f initialization/mapping_procedure_drp.sql
# ====
if [ $? -eq 0 ]; then
    echo CLEANING SUCCESS
else
    echo CLEANING FAILED
fi
# ====
echo "END CLEANING. See log file for details. $dt"
