#!/bin/bash
DEVSHELL_PROJECT_ID=$(gcloud config get-value project)
# Enable the Compute Engine and Deployment Manager API
gcloud -q services enable compute.googleapis.com
# Create a virtual machine using the GCP Console
gcloud compute --project=$DEVSHELL_PROJECT_ID instances create my-vm-1 --zone=us-central1-a --tags=http-server --machine-type=n1-standard-1 --image=debian-9-stretch-v20180716 --image-project=debian-cloud --subnet=default
gcloud compute --project=$DEVSHELL_PROJECT_ID firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server
# Create a virtual machine using the gcloud command line
gcloud config set compute/zone us-central1-b
gcloud compute --project=$DEVSHELL_PROJECT_ID instances create "my-vm-2" --machine-type "n1-standard-1" --image-project "debian-cloud" --image "debian-9-stretch-v20170918" --subnet "default"
# Connect between VM instances
gcloud compute config-ssh --quiet
ssh my-vm-1.us-central1-a.$DEVSHELL_PROJECT_ID -o StrictHostKeyChecking=no <<EOF
sudo apt-get install nginx-light -y
sudo sed -i 's/<\/h1>/<\/h1>\nHi from GCP Fundamentals/g' /var/www/html/index.nginx-debian.html
EOF
