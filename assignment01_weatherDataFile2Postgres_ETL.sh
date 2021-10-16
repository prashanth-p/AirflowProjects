# extract the data from source
cat web-server-access-log.txt | tr "#" "," | cut -d"," -f1,2,3,4 > web-server-access-log_extracted.csv

# Load the data to the target postgres

echo "\c template1;\COPY access_log FROM '$(pwd)/web-server-access-log_extracted.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost