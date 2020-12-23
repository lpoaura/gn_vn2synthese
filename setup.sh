#!/bin/bash

logFile=setup.log
logCommand () {
    tee -a $logFile
}

if [ -f $logFile ]; then
    echo "# rm Log file"
    rm $logFile
fi

touch $logFile

echo "##########################################" | tee -a $logFile
echo "# VisioNature 2 GeoNature synthese setup #" | tee -a $logFile
echo "##########################################" | tee -a $logFile
echo "" | tee -a $logFile



. settings.ini

connectionString="postgresql://$dbUser:$dbPwd@$dbHost:$dbPort/$dbName"


echo "# db connexion string is $connectionString" | tee -a $logFile
echo "" | tee -a $logFile

echo "# check dbConnection" | tee -a $logFile
pgReady=`pg_isready -h $dbHost -p $dbPort -d $dbName`
pgReadyStatus=$?
echo "pgReadyStatus $pgReadyStatus"

if [ $pgReadyStatus != 0 ]; then
    echo "# ERROR Check db connection settings" | tee -a $logFile
    exit
else
  echo "Database exists" | tee -a $logFile
fi



# psql $connectionString
if [ -d tmp ]; then
    echo "# Directory tmp exists, remove old tmp directory" | tee -a $logFile
    echo "" | tee -a $logFile
    rm -rf tmp | tee -a $logFile
fi

echo "# Create tmp directory" | tee -a $logFile
mkdir tmp | tee -a $logFile
echo "" | tee -a $logFile

echo "# compile sql files to tmp/run.sql" | tee -a $logFile
#find . -maxdepth 1 -type f -name "*.sql" -print0 | xargs -0 cat >> tmp/run.sql
cp *.sql tmp/ | tee -a $logFile
cd tmp | tee -a $logFile
echo "" | tee -a $logFile
# find . -type f -exec sed "s/src_lpodatas/$schemaName/g" {} \;

echo "# update schemas source schema name" | tee -a $logFile
find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/import_vn/$schemaSource/g"

echo "# update schemas destination schema name" | tee -a $logFile
find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/src_lpodatas/$schemaDestination/g"
echo "" | tee -a $logFile

echo "# update db username" | tee -a $logFile
find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/geonatadmin/$dbOwner/g"
echo "" | tee -a $logFile

echo "# Check if source schema exists" | tee -a $logFile
schemaSourceExists=`psql  $connectionString  -X -A -t -c "SELECT exists(select schema_name FROM information_schema.schemata WHERE schema_name = '$schemaSource');"` | tee -a $logFile
echo "schemaSourceExists $schemaSourceExists"| tee -a $logFile

if [ "$sourceSchemaExists" = "0" ]; then
    echo "# Schema  $sourceSchema exists, continue" | tee -a $logFile
else
    echo "# Schema  $sourceSchema doesn't exists, exit" | tee -a $logFile
fi

echo "# Check if destination schema exists" | tee -a $logFile
schemaDestinationExists=`psql  $connectionString  -X -A -t -c "SELECT exists(select schema_name FROM information_schema.schemata WHERE schema_name = '$schemaDestination'); "` | tee -a $logFile
echo $schemaDestinationExists | tee -a $logFile

