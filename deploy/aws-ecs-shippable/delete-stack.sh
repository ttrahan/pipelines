#! /bin/bash -e

STACK_NAME=ecs-weave-shippable
AWS_KEY_NAME=kp-us-east-1

# execute to destroy and delete stack
aws cloudformation delete-stack --stack-name ecs-weave-shippable

printf "deleting stack ... this may take a few minutes"
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME
printf "\nstack deleted"
