#!/bin/sh
set -e

helpFunction()
{
   echo ""
   echo "Usage: $0 -u username -p password -a address"
   echo -e "\t-u NetApp API username"
   echo -e "\t-p NetApp API password"
   echo -e "\t-a NetApp API address hostname:port"
   exit 1 # Exit script after printing help
}

while getopts "u:p:a:d:" opt
do
   case "$opt" in
      u ) parameterU="$OPTARG" ;;
      p ) parameterP="$OPTARG" ;;
      a ) parameterA="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$parameterU" ] || [ -z "$parameterP" ] || [ -z "$parameterA" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
#sed -i 's/<username>/'"$parameterU"'/g' /app/netapp_filers.yaml
#sed -i 's/<password>/'"$parameterP"'/g' /app/netapp_filers.yaml
#sed -i 's/<address>/'"$parameterA"'/g' /app/netapp_filers.yaml

sed -i.bak "s/<username>/$parameterU/" /app/config/netapp_filers.yaml && rm /app/config/netapp_filers.yaml.bak
sed -i.bak "s/<password>/$parameterP/" /app/config/netapp_filers.yaml && rm /app/config/netapp_filers.yaml.bak
sed -i.bak "s/<address>/$parameterA/" /app/config/netapp_filers.yaml && rm /app/config/netapp_filers.yaml.bak

/app/netapp-api-exporter --debug --config=./config/netapp_filers.yaml

