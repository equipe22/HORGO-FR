#
#Set the value of variable
database="UHF_test"
# ====
start=$(date '+%d/%m/%Y %H:%M:%S');
echo "START TESTING. $start"
# ====
echo "Testing mapping..."
psql -v ON_ERROR_STOP=1 -d $database &> execution/test_log.txt -c 'SET client_min_messages TO WARNING;' -f execution/mapping_test.sql
# ====
if [ $? -eq 0 ]; then
    echo TEST SUCCESS
else
    echo TEST FAILED
fi
# ====
end=$(date '+%d/%m/%Y %H:%M:%S');
echo "END TESTING. See log file for details. $end"
