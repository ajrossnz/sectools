#!/bin/bash
# haveibeenpwned.sh 
# bash script to check email addresses against the haveibeenpwned API
# You need to purchase a haveibeenpwned API key
# by Alistair Ross
# version 0.1   // 5th October 2023

API_BASE="https://haveibeenpwned.com/api/v3"
API_KEY="PUT YOUR HAVEIBEENPWNED API KEY IN HERE"
USER_AGENT="MyPwnedChecker"
SLEEP_TIME=1.5  # Adjust according to rate limiting requirements

function check_email() {
    local email=$1
    response=$(curl -s -H "hibp-api-key: ${API_KEY}" -H "user-agent: ${USER_AGENT}" "${API_BASE}/breachedaccount/${email}")

    # Check if the response is a valid JSON (this will also check for empty response)
    if echo "$response" | jq empty > /dev/null 2>&1; then
        # Parse the JSON response using jq
        echo $response | jq -r ".[] | \"$email,\" + .Name + \",\" + .BreachDate + \",\" + .Description"
    else
        # No breaches or error in response
        echo "$email,Error or No Breaches,,"
    fi
}

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_emails.txt output_results.csv"
    exit 1
fi

input_file="$1"
output_file="$2"

echo "Email,BreachName,BreachDate,Description" > "$output_file"

while IFS= read -r email
do
    check_email "$email" >> "$output_file"
    sleep $SLEEP_TIME
done < "$input_file"
