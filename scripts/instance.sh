#!/bin/sh
# Generate Instance Data
# Can Elkatmis
# June 2017

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

data_file="/data/instance.json"
debug=1

# generate_list <account_name> <owner_id> <default_region> <access_key> <access_secret>
generate_list() {

        aws configure set default.region $3
        aws configure set aws_access_key_id $4
        aws configure set aws_secret_access_key $5
        aws configure set output json

        region_list=`aws ec2 describe-regions --query 'Regions[].{Name:RegionName}' --output text`
        [ $debug ] && echo "`date "+%F %T | "` $1 domain region list: $region_list"

        for region in ${region_list}; do

                [ $debug ] && echo "`date "+%F %T | "`Generating $region region of $1 domain..."

                data=`aws ec2 describe-instances --query "Reservations[*].[OwnerId, Instances[*].[Placement.AvailabilityZone, [Tags[?Key=='Name'].Value] [0][0], InstanceId, State.Name, InstanceType, PublicIpAddress, NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress, KeyName, [Tags[?Key=='Rundeck-Tags'].Value] [0][0] ]]" --output json  --region $region`

                [ $debug ] && echo "`date "+%F %T | "`$data"

                #clear first and last bracket
                data="${data:1:${#data}-2}"

                if [ "$data" ]; then
                        echo $data >> $data_file.new
                        echo "," >> $data_file.new
                fi
        done

        #replace owner-id with the account name
        sed -i "s/$2/$1/g" $data_file.new
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
