#!/bin/bash

function check_preconditions() {
  if ! [[ ${UID} == 0 ]]; then
    echo "Script has to be executed with sudo privileges."
    exit 1
  fi

  if [[ -z $(which 6tunnel) ]]; then
    echo "6tunnel binary could not be found. Please install before continuing."
    exit 1
  fi
}

function prepare_environment_variables() {
  readonly SCRIPT_DIR="${0%/*}"
  readonly 6TUNNEL_CONFIG_DIR=/etc/6tunnel
  readonly 6TUNNEL_SERVICE_DIR="${6TUNNEL_CONFIG_DIR}"/service
}

function setup_service() {
  # add config and service scripts
  mkdir -p "${6TUNNEL_SERVICE_DIR}"
  if ! [[ -e ${6TUNNEL_CONFIG_DIR}/config ]]; then
    cp "${SCRIPT_DIR}"/config/config "${6TUNNEL_CONFIG_DIR}"
  fi
  yes | cp "${SCRIPT_DIR}"/service/start.sh "${6TUNNEL_SERVICE_DIR}"
  yes | cp "${SCRIPT_DIR}"/service/stop.sh "${6TUNNEL_SERVICE_DIR}"

  # add service file
  cp "${SCRIPT_DIR}"/service/6tunnel.service /etc/systemd/system/

  systemctl enable 6tunnel
}

function setup_finished() {
  echo "Setup of 6tunnel service finished successfully"
  echo ""
  echo "  1. edit config for your bindings in /etc/6tunnel/config"
  echo "     vi /etc/6tunnel.config"
  echo ""
  echo "  2. start 6tunnel service"
  echo "     systemctl start 6tunnel"
  echo ""
  echo "  3. check if bindings exist"
  echo "     ps -aux | grep 6tunnel"
}

check_preconditions
prepare_environment_variables
setup_service