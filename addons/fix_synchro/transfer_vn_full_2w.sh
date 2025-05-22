#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <yaml_file> <service_name>"
    exit 1
fi

yaml_file="$1"
service_name="$2"

# Calculate the date two weeks ago
two_weeks_ago=$(date -d "2 weeks ago" +"%Y-%m-%d")

# Update the start_date in the YAML file
sed -i "s/^    start_date:.*/    start_date: $two_weeks_ago/" $yaml_file

echo "start_date updated to $two_weeks_ago in $yaml_file"
echo "start download from $yaml_file"

source .venv.clientapivn/bin/activate
transfer_vn --full $yaml_file
transfer_vn --schedule $yaml_file

psql service=$service_name -c 'CALL src_vn_json_check.fct_fix_sync(FALSE);'
