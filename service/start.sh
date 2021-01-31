#!/bin/bash

readonly regex="^[0-9]+,[a-zA-Z0-9.-]+,[0-9]+$"

grep -E "${regex}" < /etc/6tunnel/config | while IFS= read -r config
do
  LOCAL_PORT=$(echo "${config}" | awk -F',' '{print $1}')
  TARGET_HOST=$(echo "${config}" | awk -F',' '{print $2}')
  TARGET_PORT=$(echo "${config}" | awk -F',' '{print $3}')
  6tunnel "${LOCAL_PORT}" "${TARGET_HOST}" "${TARGET_PORT}"
done