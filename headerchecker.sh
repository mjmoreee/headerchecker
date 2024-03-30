#!/bin/bash

# Array of HTTP methods
methods=("GET" "POST" "PUT" "DELETE" "PATCH" "HEAD" "OPTIONS")

# Read host URLs from stdin
while IFS= read -r host || [[ -n "$host" ]]; do
    # Loop through each HTTP method
    for method in "${methods[@]}"
    do
        # Perform curl request with the current method silently
        response=$(curl -s -X"$method" "$host" -I -k 2>&1)

        # Check if the response contains "405 Method Not Allowed" or "403 Forbidden"
        if [[ ! $response =~ "405" ]] && [[ ! $response =~ "403" ]]; then
            # If not, save the response to headers-results.txt
            echo "Response for $method $host:" >> headers-results.txt
            echo "$response" >> headers-results.txt
            echo "---------------------------------" >> headers-results.txt
        fi
    done
done
