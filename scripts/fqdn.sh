#!/bin/sh
# Generate FQDN Data
# Can Elkatmis
# June 2017

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

data_file="/data/fqdn.json"
debug=1


# generate_list <account_name> <owner_id> <default_region> <access_key> <access_secret>
generate_list() {

        aws configure set default.region $3
        aws configure set aws_access_key_id $4
        aws configure set aws_secret_access_key $5
        aws configure set output json

        hosted_zones=`aws route53 list-hosted-zones --query "HostedZones[].Id" --output text`
        [ $debug ] && echo "`date "+%F %T | "` $1 domain hosted zone list: $hosted_zones"

        for hz in ${hosted_zones}; do

                [ $debug ] && echo "`date "+%F %T | "`Generating $hz hosted zone record sets of $1 domain..."

                record_sets=`aws route53 list-resource-record-sets --hosted-zone-id $hz --query "ResourceRecordSets[*].[Name, ResourceRecords[].Value]"`

                [ $debug ] && echo "`date "+%F %T | "`$record_sets"

                #clear first and last bracket
                record_sets="${record_sets:1:${#record_sets}-2}"

                if [ "$record_sets" ]; then
                        echo $record_sets >> $data_file.new
                        echo "," >> $data_file.new
                fi
        done
}

# Main
echo '{"data":[ ' > $data_file.new

printf "$0 - Please wait while generating data..."
generate_list <account_name> <account-id> <default_region> <access_key> <secret_key>

#clear last comma
sed -i '$ s/,$//g' $data_file.new

echo "]}" >> $data_file.new

[[ -f $data_file ]] && cp $data_file $data_file.backup_$(date +%F.%T)
mv -f $data_file.new $data_file
