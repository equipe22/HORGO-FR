#
#Set the value of variable
database="UHF_test"

start=$(date '+%d/%m/%Y %H:%M:%S');
echo START BUILDING. $start
# ====
psql -d $database &> build_log.txt -f HORG-FR_HISTORY_cre-table_v0_20190417-1527.sql
psql -d $database &> build_log.txt -f HORG-FR_HISTORY_cre-historicalViews_v0_20190417-1527.sql
psql -d $database &> build_log.txt -f HORG-FR_HISTORY_cre-TemporalConstraints_v0_20190417-1527.sql
psql -d $database &> build_log.txt -f ontology-views_cre.sql &> build_log.txt
# ====
echo "Building core organizational structure definitions..."
psql -d $database &> build_log.txt -f structureDef_cre.sql
psql -d $database &> build_log.txt -f structureDef_ins.sql
# ====
echo "Building hospitals organizational structures..."
psql -d $database &> build_log.txt -f all-structure_req.sql
psql -d $database &> build_log.txt -f hegp-structure_req.sql
psql -d $database &> build_log.txt -f hap-structure_req.sql
# ====
echo "Building functions..."
psql -d $database &> build_log.txt -f structureBuilder_fct.sql
# ====
if [ $? -eq 0 ]; then
    echo BUILDING SUCCESS
else
    echo BUILDING FAILED
fi
# ====
end=$(date '+%d/%m/%Y %H:%M:%S');
echo END BUILDING $end. See log files for details.
