#!/bin/bash
DEVSHELL_PROJECT_ID=$(gcloud config get-value project)
# Enable the Compute Engine and Deployment Manager API
gcloud -q services enable compute.googleapis.com
# Deploy a web server VM instance
gcloud compute --project=$DEVSHELL_PROJECT_ID instances create bloghost --zone=us-central1-a --machine-type=n1-standard-1 --subnet=default --metadata=startup-script=apt-get\ update$'\n'apt-get\ install\ apache2\ php\ php-mysql\ -y$'\n'service\ apache2\ restart --tags=http-server --image=debian-9-stretch-v20180716 --image-project=debian-cloud
gcloud compute --project=$DEVSHELL_PROJECT_ID firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server
# Create a Cloud Storage bucket using the gsutil command line
export LOCATION=US
gsutil mb -l $LOCATION gs://$DEVSHELL_PROJECT_ID
gsutil cp gs://cloud-training/gcpfci/my-excellent-blog.png my-excellent-blog.png
gsutil cp my-excellent-blog.png gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
gsutil acl ch -u AllUsers:R gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
# Create Cloud SQL instance
gcloud sql instances create blog-db --gce-zone us-central1-a
# Set the password to the Cloud SQL instance
gcloud sql users set-password root % --instance=blog-db --password=root
gcloud sql users create blogdbuser --instance=blog-db, -i blog-db --host=% --password=rootuser
INSTANCE_IP=$(gcloud compute instances list --filter 'name=bloghost' --format="value(EXTERNAL_IP)")
gcloud sql instances patch blog-db --quiet --authorized-networks=$INSTANCE_IP/32
SQL_IP=$(gcloud sql instances describe blog-db --format='value(ipAddresses[ipAddress])')
# Configure an application in a Compute Engine instance to use Cloud SQL a Cloud Storage object
gcloud compute config-ssh --quiet
ssh bloghost.us-central1-a.$DEVSHELL_PROJECT_ID -o StrictHostKeyChecking=no <<EOF
sudo chmod -R 777 /var/www/html/
cd /var/www/html/
sudo cat >> index.php <<'EOT'
<html>
<head><title>Welcome to my excellent blog</title></head>
<body>
<img src='https://storage.googleapis.com/$DEVSHELL_PROJECT_ID/my-excellent-blog.png'>
<h1>Welcome to my excellent blog</h1>
<?php
\$dbserver = "$SQL_IP";
\$dbuser = "blogdbuser";
\$dbpassword = "rootuser";
// In a production blog, we would not store the MySQL
// password in the document root. Instead, we would store it in a
// configuration file elsewhere on the web server VM instance.

\$conn = new mysqli(\$dbserver, \$dbuser, \$dbpassword);

if (mysqli_connect_error()) {
        echo ("Database connection failed: " . mysqli_connect_error());
} else {
        echo ("Database connection succeeded.");
}
?>
</body></html>
EOT
sudo service apache2 restart
EOF
