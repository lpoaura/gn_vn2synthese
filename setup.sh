#!/bin/bash
echo -e "\e[1;33m##########################################\e[0m" | tee -a $logFile
echo -e "\e[1;33m# VisioNature 2 GeoNature synthese setup #\e[0m" | tee -a $logFile
echo -e "\e[1;33m##########################################\e[0m" | tee -a $logFile
echo -e "\e[1;34m(i)\e[0m version $(cat VERSION)"
echo "" | tee -a $logFile

if [ -f ./settings.ini ]; then
    echo -e "\e[1;34m(i)\e[0m settings.ini already exists, skip edit settings.ini"
else
    cp settings.ini.sample settings.ini
    editor ./settings.ini
fi

logFile=setup.log
logCommand() {
    tee -a $logFile
}

if [ -f $logFile ]; then
    echo -e "\e[1;34m(i)\e[0m rm Log file"
    rm $logFile
fi

touch $logFile

. settings.ini

connectionString="postgresql://$dbUser:$dbPwd@$dbHost:$dbPort/$dbName"

echo -e "\e[1;34m(i)\e[0m db connexion string is $connectionString" | tee -a $logFile
echo "" | tee -a $logFile

echo -e "\e[1;34m(i)\e[0m check dbConnection" | tee -a $logFile
pgReady=$(pg_isready -h $dbHost -p $dbPort -d $dbName)
pgReadyStatus=$?
echo -e "\e[1;34m(i)\e[0m pgReadyStatus $pgReadyStatus"

if [ $pgReadyStatus != 0 ]; then
    echo -e "\e[1;31m[ ] ERROR Check db connection settings\e[0m" | tee -a $logFile
    exit
else
    echo -e "\e[1;32m[X]\e[0m Database exists" | tee -a $logFile
fi
echo "" | tee -a $logFile

# psql $connectionString
if [ -d tmp ]; then
    echo -e "\e[1;34m(i)\e[0m Directory tmp exists, remove old tmp directory" | tee -a $logFile
    rm -rf tmp | tee -a $logFile
fi

echo -e "\e[1;34m(i)\e[0m Create tmp directory" | tee -a $logFile
mkdir tmp | tee -a $logFile
echo "" | tee -a $logFile

echo "# compile sql files to tmp/ subdir" | tee -a $logFile
#find . -maxdepth 1 -type f -name "*.sql" -print0 | xargs -0 cat >> tmp/run.sql
cp *.sql tmp/ | tee -a $logFile
cd tmp | tee -a $logFile
echo "" | tee -a $logFile
# find . -type f -exec sed "s/src_lpodatas/$schemaName/g" {} \;

find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/src_vn_json/$schemaSource/g"
echo -e "\e[1;32m[X]\e[0m source schema name updated" | tee -a $logFile

find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/src_lpodatas/$schemaDestination/g"
echo -e "\e[1;32m[X]\e[0m destination schema name updated" | tee -a $logFile

find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/geonatadmin/$dbOwner/g"
echo -e "\e[1;32m[X]\e[0m db username updated" | tee -a $logFile

echo "" | tee -a $logFile

echo -e "\e[1;34m(i)\e[0m \e[1;32mOpen your preferred SQL tool and execute successively each SQL files from tmp directory \e[0m"
#
#echo "# Check if source schema exists" | tee -a $logFile
#schemaSourceExists=`psql  $connectionString  -X -A -t -c "SELECT exists(select schema_name FROM information_schema.schemata WHERE schema_name = '$schemaSource');"` | tee -a $logFile
#echo "schemaSourceExists $schemaSourceExists"| tee -a $logFile
#
#if [ "$sourceSchemaExists" = "0" ]; then
#    echo "# Schema  $sourceSchema exists, continue" | tee -a $logFile
#else
#    echo "# Schema  $sourceSchema doesn't exists, exit" | tee -a $logFile
#fi
#
#echo "# Check if destination schema exists" | tee -a $logFile
#schemaDestinationExists=`psql  $connectionString  -X -A -t -c "SELECT exists(select schema_name FROM information_schema.schemata WHERE schema_name = '$schemaDestination'); "` | tee -a $logFile
#echo $schemaDestinationExists | tee -a $logFile
