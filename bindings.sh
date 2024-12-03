#!/bin/bash

bindings=""

# Check if .env.local exists
if [ ! -f .env.local ]; then
  echo "Error: .env.local file not found."
  exit 1
fi

while IFS= read -r line || [ -n "$line" ]; do
  if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
    name=$(echo "$line" | cut -d '=' -f 1)
    value=$(echo "$line" | cut -d '=' -f 2-)
    value=$(echo $value | sed 's/^"\(.*\)"$/\1/')
    bindings+="--binding ${name}=${value} "
  fi
done < .env.local

bindings=$(echo $bindings | sed 's/[[:space:]]*$//')

echo $bindings
