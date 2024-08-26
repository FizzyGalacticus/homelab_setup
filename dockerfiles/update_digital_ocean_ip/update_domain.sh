#!/bin/bash

#################### VARIABLES SET IN DOCKER ENVIRONMENT ####################
# TOKEN
# DOMAIN
# RECORD_ID
# LOG_FILE
########################################################################

CURRENT_IPV4="$(dig +short myip.opendns.com @resolver1.opendns.com)"
LAST_IPV4="$(tail -1 $DIGITAL_OCEAN_LOG_FILE | awk -F, '{print $2}')"

echo "Current: $CURRENT_IPV4"
echo "Last: $LAST_IPV4"

if [ "$CURRENT_IPV4" = "$LAST_IPV4" ]; then
    echo "IP has not changed ($CURRENT_IPV4)"
else
    echo "IP has changed: $CURRENT_IPV4"
    echo "$(date),$CURRENT_IPV4" >> "$DIGITAL_OCEAN_LOG_FILE"

    PAYLOAD='{"data":"'"$CURRENT_IPV4"'"}'
    ENDPOINT="https://api.digitalocean.com/v2/domains/$DIGITAL_OCEAN_DOMAIN/records/$DIGITAL_OCEAN_RECORD_ID"

    echo -e "Sending payload to '$ENDPOINT':\n$PAYLOAD"

    curl -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITAL_OCEAN_TOKEN" -d $PAYLOAD $ENDPOINT | jq
fi