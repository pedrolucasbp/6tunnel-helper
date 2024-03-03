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
  readonly CONFIG_DIR="/etc/6tunnel"
  readonly SERVICE_DIR="${CONFIG_DIR}/service"
}

function setup_service() {
  # add config and service scripts
  mkdir -p "${SERVICE_DIR}"
  if ! [[ -e ${CONFIG_DIR}/config ]]; then
    cp "${SCRIPT_DIR}"/config/config "${CONFIG_DIR}"
  fi
  yes | cp "${SCRIPT_DIR}"/service/start.sh "${SERVICE_DIR}"
  yes | cp "${SCRIPT_DIR}"/service/stop.sh "${SERVICE_DIR}"
  chown -R root:root "${SERVICE_DIR}"
  chmod -R 744 "${SERVICE_DIR}"

  # add service file
  cp "${SCRIPT_DIR}"/service/6tunnel.service /etc/systemd/system/

  systemctl enable 6tunnel | exit 1
}

function setup_finished() {
  echo "Setup of 6tunnel service finished successfully"
  echo ""
  echo "  1. edit config for your bindings in /etc/6tunnel/config"
  echo "     sudo vi /etc/6tunnel/config"
  echo ""
  echo "  2. start 6tunnel service"
  echo "     sudo systemctl start 6tunnel"
  echo ""
  echo "  3. check if bindings exist"
  echo "     ps -aux | grep 6tunnel"
  echo ""
}

check_preconditions
prepare_environment_variables
setup_service
setup_finished