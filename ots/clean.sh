#
#Set the value of variable
database="UHF_test"
# ====
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "START CLEANING. $dt"
# ====
psql -d $database &> clean_log.txt -f HORG-FR_HISTORY_drp-table_v0_20190417-1527.sql
psql -d $database &> clean_log.txt -f structureDef_drp.sql
# ====
if [ $? -eq 0 ]; then
    echo CLEANING SUCCESS
else
    echo CLEANING FAILED
fi
# ====
echo "END CLEANING. See log file for details. $dt"
