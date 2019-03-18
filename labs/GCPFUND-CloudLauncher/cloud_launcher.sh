#!/bin/bash
DEVSHELL_PROJECT_ID=$(gcloud config get-value project)
# Enable the Compute Engine and Deployment Manager API
gcloud -q services enable deploymentmanager.googleapis.com compute.googleapis.com
sudo apt-get install unzip -y
curl -O https://storage.googleapis.com/cloud-training/labtesting/lampstack.zip
unzip lampstack.zip
cd lampstack
# Deploy a LAMP stack
gcloud deployment-manager deployments create lampstack --config=config.yaml
gcloud compute config-ssh --quiet
ssh lampstack-vm.us-central1-a.$DEVSHELL_PROJECT_ID -o StrictHostKeyChecking=no <<EOF
cd /opt/bitnami
sudo cp docs/phpinfo.php apache2/htdocs
EOF
