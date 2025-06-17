#!/bin/bash

# Check if port number is provided
if [ $# -ne 1 ]; then
    echo "Usage: get_preview_url.sh <port>"
    echo "Port must be a number between 200 and 20000"
    exit 1
fi

# Check if port is a number
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Usage: get_preview_url.sh <port>"
    echo "Port must be a number between 200 and 20000"
    exit 1
fi

# Check port range
if [ $1 -lt 200 ] || [ $1 -gt 20000 ]; then
    echo "Usage: get_preview_url.sh <port>"
    echo "Port must be a number between 200 and 20000"
    exit 1
fi

# Check if yaml file exists
if [ ! -f "/var/run/cloudstudio/space.yaml" ]; then
    echo "Configuration file not found"
    exit 1
fi

# Read values from yaml file
spacekey=$(yq -r '.spacekey' "/var/run/cloudstudio/space.yaml")
region=$(yq -r '.region' "/var/run/cloudstudio/space.yaml")
host=$(yq -r '.host' "/var/run/cloudstudio/space.yaml")

# Check if any value is empty
if [ -z "$spacekey" ] || [ -z "$region" ] || [ -z "$host" ]; then
    echo "Failed to read configuration"
    exit 1
fi

# Output URL
echo "https://${spacekey}--$1.${region}.${host}"