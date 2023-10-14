#!/bin/bash
#
#a really simple script to monitor for site uptime using curl

if [ -z "$1" ] ;
then
  echo "Usage: ./monitor.sh [url]"
else
  URL="$1"

  # Counters
  UP_COUNT=0
  DOWN_COUNT=0

  # Start monitoring
  while true; do
      # Send a GET request and check if the response status is 200
      if curl -s -o /dev/null -w "%{http_code}" $URL | grep -q "200"; then
          UP_COUNT=$((UP_COUNT+1))
          echo "$(date): Site is UP. Total UP times: $UP_COUNT"
      elif curl -s -o /dev/null -w "%{http_code}" $URL | grep -q "301"; then
          UP_COUNT=$((UP_COUNT+1))
          echo "$(date): Site is UP (HTTP 301). Total UP times: $UP_COUNT"
      elif curl -s -o /dev/null -w "%{http_code}" $URL | grep -q "302"; then
          UP_COUNT=$((UP_COUNT+1))
          echo "$(date): Site is UP. (HTTP 302) Total UP times: $UP_COUNT"
      elif curl -s -o /dev/null -w "%{http_code}" $URL | grep -q "308"; then
          UP_COUNT=$((UP_COUNT+1))
          echo "$(date): Site is UP (HTTP 308). Total UP times: $UP_COUNT"
      else
          DOWN_COUNT=$((DOWN_COUNT+1))
          echo "$(date): Site is NOT RESPONSIVE. Total DOWN times: $DOWN_COUNT"
      fi
      
      # Wait for some time before checking again
      sleep 10
  done
fi
