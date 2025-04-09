#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <interface>"
  exit 1
fi

INTERFACE="$1"

if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
  echo "Error: Interface '$INTERFACE' does not exist."
  exit 1
fi

source .env

IP=$(ip -o -4 addr show "$INTERFACE" | awk '{print $4}' | cut -d/ -f1)

curl "https://www.duckdns.org/update?domains=${ROOT_PREFIX}&token=${DUCKDNS_TOKEN}&ip=$(ip -o -4 addr show wlp0s20f3 | awk '{print $4}' | cut -d/ -f1)"

docker compose up
