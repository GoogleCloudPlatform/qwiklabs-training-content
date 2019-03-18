#!/bin/bash
#part1
DEVSHELL_PROJECT_ID=$(gcloud config get-value project)
HOSTNAME=$(hostname)

gcloud -q services enable vision.googleapis.com translate.googleapis.com speech.googleapis.com language.googleapis.com compute.googleapis.com
sudo apt-get install google-cloud-sdk-datalab
#Create Datalab Instance
datalab create bdmlvm --no-connect --no-create-repository --zone us-central1-a < <(yes y)
gcloud compute config-ssh --quiet
while :
do
STATUS_CHECK=`ssh bdmlvm.us-central1-a.$DEVSHELL_PROJECT_ID -o StrictHostKeyChecking=no 'sudo docker ps --filter "name=datalab" --filter "status=running" --format '{{.Names}}''`
  if [ "$STATUS_CHECK" == 'datalab' ]
  then
    break
  fi
sleep 20s
done
# Download the notebook in the docker container
ssh bdmlvm.us-central1-a.$DEVSHELL_PROJECT_ID -o StrictHostKeyChecking=no <<EOF
docker container exec -i datalab sh -c "cd /content/datalab/ && git clone https://github.com/GoogleCloudPlatform/training-data-analyst"

if [ $? -ne 0 ]; then
  gcloud beta runtime-config configs variables set \
              failure/${HOSTNAME} datalabfail --config-name ${HOSTNAME}-config
else
  gcloud beta runtime-config configs variables set \
              success/${HOSTNAME} datalabsuccess --config-name ${HOSTNAME}-config
fi
