#! /bin/bash -e

STACK_NAME=ecs-weave-shippable
AWS_KEY_NAME=kp-us-east-1

# execute if cloudformation.json is updated
aws cloudformation update-stack --stack-name $STACK_NAME --template-body file://$(pwd)/cloudformation.json --parameters  ParameterKey="EcsInstanceType",ParameterValue="t2.medium" ParameterKey="Scale",ParameterValue=4 ParameterKey="KeyName",ParameterValue=$AWS_KEY_NAME ParameterKey="DeployExampleApp",ParameterValue="Yes" ParameterKey="WeaveCloudServiceToken",ParameterValue="" --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

printf "updating stack ."
sleep 1

STACK_STATUS=""
while [ "$STACK_STATUS" != "UPDATE_COMPLETE" ]; do
  STACK_STATUS=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[*].StackStatus' --output text)
  printf "."
  sleep 1
done

printf "stack updated"
