#!/bin/bash
DEVSHELL_PROJECT_ID=$(gcloud config get-value project)
HOSTNAME=$(hostname)
# Enable required APIs
gcloud -q services enable compute.googleapis.com storage-component.googleapis.com sql-component.googleapis.com dataproc.googleapis.com
sudo apt-get update
sudo apt-get -y -qq install git
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
#part1
# Create Compute Engine instance with the necessary API access
gcloud compute instances create instance-1 --zone us-central1-a --scopes=https://www.googleapis.com/auth/cloud-platform
# Check the status of instance
while :
do
INSTANCE_STATUS=$(gcloud compute instances list --filter 'name=instance-1' --format="value(status)")
  if [ "$INSTANCE_STATUS" == 'RUNNING' ]
  then  
    break
  fi
sleep 10s
done
gcloud compute config-ssh --quiet
# ssh into the instance
ssh instance-1.us-central1-a.$DEVSHELL_PROJECT_ID -o StrictHostKeyChecking=no <<EOF 

# Install software and Ingest USGS data
sudo apt-get update
sudo apt-get -y -qq install git
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

#part2
cd ~/training-data-analyst/CPB100/lab2b
# Transform the data
bash ingest.sh 
# Install the required python packages
yes Y |bash install_missing.sh
python3 transform.py
# Create bucket and store the data
gsutil mb -l us-central1 gs://$DEVSHELL_PROJECT_ID/
gsutil cp earthquakes.* gs://$DEVSHELL_PROJECT_ID/earthquakes/
# Publish Cloud Storage files to web
gsutil acl ch -u AllUsers:R gs://$DEVSHELL_PROJECT_ID/earthquakes/*
EOF

#part 3
cd ~/training-data-analyst/CPB100/lab3a
# Stage .sql and .csv files into Cloud Storage
gsutil cp cloudsql/* gs://$DEVSHELL_PROJECT_ID/sql/
# Create Cloud SQL instance
gcloud sql instances create rentals --gce-zone us-central1-a
gcloud sql users set-password root --host=% --instance=rentals --password=root
# Give permission to the Bucket and its data
INSTANCE_SA=$(gcloud sql instances describe rentals --format='value(serviceAccountEmailAddress)')
gsutil acl ch -u $INSTANCE_SA:W gs://$DEVSHELL_PROJECT_ID
gsutil acl ch -u $INSTANCE_SA:R gs://$DEVSHELL_PROJECT_ID/sql/*
# Import tables in SQL instance
gcloud sql import sql rentals gs://$DEVSHELL_PROJECT_ID/sql/table_creation.sql --quiet
# Populate tables in SQL instance
gcloud sql import csv rentals gs://$DEVSHELL_PROJECT_ID/sql/accommodation.csv --database=recommendation_spark --table=Accommodation --quiet
gcloud sql import csv rentals gs://$DEVSHELL_PROJECT_ID/sql/rating.csv --database=recommendation_spark --table=Rating --quiet

#part 4
# Create Dataproc Cluster
gcloud dataproc clusters create test-cluster --region='global' --zone='us-central1-a' --master-machine-type='n1-standard-2' --worker-machine-type='n1-standard-2'
# Check the status of master and worker instances
while :
do
INSTANCE_STATUS=$(gcloud compute instances list --filter 'status=RUNNING AND name:test-cluster-*' --format 'value(Name)')
if [[ $INSTANCE_STATUS = *"m"*"w-0"*"w-1" ]]
 then
  break
 fi
sleep 10s
done
cd ../lab3b
# Authorize all the Dataproc nodes to be able to access your Cloud SQL instance
yes Y | bash authorize_dataproc.sh test-cluster us-central1-a 2
# Replace the values in file
INSTANCE_IP=$(gcloud sql instances describe rentals --format='value(ipAddresses[ipAddress])')
sed -i "s/104.155.188.32/$INSTANCE_IP/g" sparkml/train_and_apply.py
while :
do
gsutil cp sparkml/tr*.py gs://$DEVSHELL_PROJECT_ID/
gcloud dataproc jobs submit pyspark gs://$DEVSHELL_PROJECT_ID/train_and_apply.py --cluster=test-cluster --region=global --format 'value(status.state)' --async
sleep 120s
JOB_ID=$(gcloud dataproc jobs list --format 'value(status.state)')
if [[ $JOB_ID = *'DONE'* ]]
 then
  break
fi
done

if [ $? -ne 0 ]; then
  gcloud beta runtime-config configs variables set \
              failure/${HOSTNAME} dataprocfail --config-name ${HOSTNAME}-config
else
  gcloud beta runtime-config configs variables set \
              success/${HOSTNAME} dataprocsuccess --config-name ${HOSTNAME}-config
fi
