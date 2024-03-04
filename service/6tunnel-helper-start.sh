#!/bin/env bash


readonly regex="^[0-9]+,.*,[0-9]+$"

for conf_file in $(find /etc/6tunnel-helper/conf.d/ -type f -name "*.conf") 

  OPTIONS="$(grep "OPTIONS" "${conf_file}" | cut -d "=" -f 2 | tr -d \")"
  
  for config in $(grep -E "^[0-9]+.*\,[0-9]+$" ${conf_file}); do

    LOCAL_PORT=$(echo "${config}" | awk -F',' '{print $1}')
    TARGET_HOST=$(echo "${config}" | awk -F',' '{print $2}')
    TARGET_PORT=$(echo "${config}" | awk -F',' '{print $3}')
    
    6tunnel "${OPTIONS}" "${LOCAL_PORT}" "${TARGET_HOST}" "${TARGET_PORT}"
  done

done
