#!/bin/bash
#SecurityTrails DNS enumeration scan
#bash scripty by AJR 05/10/2023
apikey='REPLACEWITHYOURSECURITYTRAILSAPIKEY'

echo "DNS enumeration scan by AJR..."
if [ -z "$1" ]
then
	echo "args: st-dnsenum.sh fqdn.com"
else
	domain=$1
	curl --request GET \
--url "https://api.securitytrails.com/v1/history/$domain/dns/a?apikey=$apikey"

curl --request GET \
     --url "https://api.securitytrails.com/v1/domain/$domain/subdomains?children_only=false&include_inactive=true" \
     --header "APIKEY: $apikey" \
     --header "accept: application/json"
fi
