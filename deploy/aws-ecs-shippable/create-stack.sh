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

# execute for initial stack creation
aws cloudformation create-stack --stack-name $StackName --template-body file://$(pwd)/cloudformation.json --parameters ParameterKey="EcsInstanceType",ParameterValue="t2.medium" ParameterKey="Scale",ParameterValue=4 ParameterKey="KeyName",ParameterValue=$KeyName ParameterKey="DeployExampleApp",ParameterValue="Yes" ParameterKey="WeaveCloudServiceToken",ParameterValue="" --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

printf "creating stack ."
sleep 1

STACK_STATUS=""
while [ "$STACK_STATUS" != "CREATE_COMPLETE" ]; do
  STACK_STATUS=$(aws cloudformation describe-stacks --stack-name $StackName --query 'Stacks[*].StackStatus' --output text)
  printf "."
  sleep 1
done

printf "stack created"
