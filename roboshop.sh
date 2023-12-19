#!/bin/bash
AMI=ami-03265a0778a880afb
SG_ID=sg-0e14f3052c0b91d72
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
ZONE_ID=Z02918111ALBYFFM6O4SB
DOMAIN_NAME=venkatdevps.site
for i in "${INSTANCES[@]}"
do
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi

 IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)

echo "$i: $IP_ADDRESS"