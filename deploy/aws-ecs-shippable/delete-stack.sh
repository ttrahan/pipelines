#! /bin/bash -e

# source helper scripts
for f in helpers/* ; do
  source $f ;
done

# input parameters
JOB=$1
SCRIPT_REPO=$2
PARAMS_RESOURCE=$3
INTEGRATION=$4

# execute
install_tools
install_awscli
extract_previous_state $JOB
load_params $PARAMS_RESOURCE
extract_integration $INTEGRATION

# # delete cloudformation stack
aws cloudformation delete-stack --stack-name ecs-weave-shippable

printf "deleting stack ... this may take a few minutes"
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME
printf "\nstack deleted"
