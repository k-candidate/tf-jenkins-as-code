#!/bin/bash

if [ -z $jenkins_admin_id ]; then
    read -p "jenkins_admin_id value: " jenkins_admin_id
    export TF_VAR_jenkins_admin_id=$jenkins_admin_id
fi

if [ -z $jenkins_admin_password ]; then
    read -sp "jenkins_admin_password value: " jenkins_admin_password
    export TF_VAR_jenkins_admin_password=$jenkins_admin_password
    echo 
fi

terraform init
if [ $? -ne 0 ]; then
    exit 1
fi
terraform validate
if [ $? -ne 0 ]; then
    exit 1
fi
terraform plan
if [ $? -ne 0 ]; then
    exit 1
fi
terraform apply -auto-approve
