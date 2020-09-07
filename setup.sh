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

echo "##########################################" | logCommand
echo "# VisioNature 2 GeoNature synthese setup #" | logCommand
echo "##########################################" | logCommand
echo "" | logCommand

touch $logFile


. settings.ini

connectionString="postgresql://$dbUser:$dbPwd@$dbHost:$dbPort/$dbName"


echo "# db connexion string is $connectionString" | logCommand
echo "" | logCommand

echo "# check dbConnection" | logCommand
pgReady=`pg_isready -h $dbHost -p $dbPort -d $dbName`
pgReadyStatus=$?

if [ $pgReadyStatus != 0 ]; then
    echo "# ERROR Check db connection settings"
    exit
fi


# psql $connectionString
if [ -d tmp ]; then
    echo "# Directory tmp exists, remove old tmp directory" | logCommand
    echo "" | logCommand
    rm -rf tmp
fi

echo "# Create tmp directory" | logCommand
mkdir tmp
echo "" | logCommand

echo "# Copy sql files to tmp" | logCommand
cp *.sql tmp/
cd tmp
echo "" | logCommand
# find . -type f -exec sed "s/src_lpodatas/$schemaName/g" {} \;

echo "# update schemas source schema name" | logCommand
find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/import_vn/$sourceSchema/g"

echo "# update schemas destination schema name" | logCommand
find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/src_lpodatas/$schemaName/g"
echo "" | logCommand

echo "# Check if source schema exists" | logCommand
schemaSourceExists=`psql  $connectionString  -X -A -t -c "SELECT exists(select schema_name FROM information_schema.schemata WHERE schema_name = '$schemaSource');"` | logCommand
echo "$schemaSourceExists" | logCommand

if [ "$sourceSchemaExists" = "t" ]; then
    echo "# Schema  $sourceSchema exists, continue" | logCommand
fi

echo "# Check if destination schema exists" | logCommand
schemaDestinationExists=`psql  $connectionString  -X -A -t -c "SELECT exists(select schema_name FROM information_schema.schemata WHERE schema_name = '$schemaDestination'); "` | logCommand
echo $schemaDestinationExists | logCommand
