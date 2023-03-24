#!/bin/bash

url="https://nexus3.onap.org/service/rest/v1/search/assets?repository=nuget-group"

json=$(curl -s -X GET --header 'Accept: application/json' "$url" )

# use jq to parse json and get the count of items 
count=`jq '.items | length' <<< $json`

# loop over each item to get details to donwload 
for ((i=0; i<$count; i++)); do
    # get downloadURL from the list of artifacts 
    downloadUrl=`jq -r '.items['$i'].downloadUrl' <<< $json`
    # get path (if there are multiple folders)
    path=`jq -r '.items['$i'].path' <<< $json`
    echo "$downloadUrl is $path"
    
    echo "downloading"
    
    
done
