#! /bin/bash

# Install tools
install_tools() {
  echo -e "\n*** installing Ubuntu tools ***"
  sudo apt-get update && sudo apt-get install jq unzip curl
}
