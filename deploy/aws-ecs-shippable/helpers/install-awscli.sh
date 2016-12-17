#! /bin/bash

echo -e "\n*** installing AWS CLI ***"
install_awscli() {
  local FILE_NAME=awscli-bundle.zip
  wget "https://s3.amazonaws.com/aws-cli/$FILE_NAME" -o $FILE_NAME
  unzip $FILE_NAME
  sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
}
