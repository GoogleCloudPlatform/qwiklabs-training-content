# Getting Started with Cloud Storage and Cloud SQL

## Overview

In this lab, you create a Cloud Storage bucket and place an image in it. You'll also configure an application running in Compute Engine to use a database managed by Cloud SQL. For this lab, you will configure a web server with PHP, a web development environment that is the basis for popular blogging software. Outside this lab, you will use analogous techniques to configure these packages.

You also configure the web server to reference the image in the Cloud Storage bucket.

## Objectives

In this lab, you learn how to perform the following tasks:

* Create a Cloud Storage bucket and place an image into it.
* Create a Cloud SQL instance and configure it.
* Connect to the Cloud SQL instance from a web server.
* Use the image in the Cloud Storage bucket on a web page.

## Task 1: Sign in to the Google Cloud Platform (GCP) Console

![[/fragments/startqwiklab]]

## Task 2: Deploy a web server VM instance

1. In the GCP Console, on the __Navigation menu__ (![Navigation menu](img/menu.png)), click __Compute Engine__ \> __VM instances__.

2. Click __Create__.

3. On the __Create an Instance__ page, for __Name__, type ```bloghost```

4. For __Region__ and __Zone__, select the zone assigned by Qwiklabs.

5. For __Machine type__, accept the default.

6. For __Boot disk__, if the __Image__ shown is not __Debian GNU/Linux 9 (stretch)__, click __Change__ and select __Debian GNU/Linux 9 (stretch)__.

7. Leave the defaults for Identity and API access unmodified.

8. For __Firewall__, click __Allow HTTP traffic__.

9. Click __Management, security, disks, networking, sole tenancy__ to open that section of the dialog.

10. Enter the following script as the value for __Startup script__:

```
apt-get update
apt-get install apache2 php php-mysql -y
service apache2 restart
```

<aside class="special"><p>Be sure to supply that script as the value of the <b>Startup script</b> field. If you accidentally put it into another field, it won't be executed when the VM instance starts.</p></aside>

11. Leave the remaining settings as their defaults, and click __Create__.

<aside class="special"><p>Instance can take about two minutes to launch and be fully available for use.</p></aside>

12. On the __VM instances__ page, copy the __bloghost__ VM instance's internal and external IP addresses to a text editor for use later in this lab.


Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=1>
       Deploy a web server VM instance
  </ql-activity-tracking>


## Task 3: Create a Cloud Storage bucket using the gsutil command line

All Cloud Storage bucket names must be globally unique. To ensure that your bucket name is unique, these instructions will guide you to give your bucket the same name as your Cloud Platform project ID, which is also globally unique.

Cloud Storage buckets can be associated with either a region or a multi-region location: __US__, __EU__, or __ASIA__. In this activity, you associate your bucket with the multi-region closest to the region and zone that Qwiklabs or your instructor assigned you to.

1. On the __Google Cloud Platform__ menu, click __Activate Cloud Shell__ ![Activate Cloud Shell](img/devshell.png). If a dialog box appears, click __Start Cloud Shell__.

2. For convenience, enter your chosen location into an environment variable called LOCATION. Enter one of these commands:

```
export LOCATION=US
```

Or

```
export LOCATION=EU
```

Or

```
export LOCATION=ASIA
```

3. In Cloud Shell, the DEVSHELL_PROJECT_ID environment variable contains your project ID. Enter this command to make a bucket named after your project ID:

```
gsutil mb -l $LOCATION gs://$DEVSHELL_PROJECT_ID
```

4. Retrieve a banner image from a publicly accessible Cloud Storage location:

```
gsutil cp gs://cloud-training/gcpfci/my-excellent-blog.png my-excellent-blog.png
```

5. Copy the banner image to your newly created Cloud Storage bucket:

```
gsutil cp my-excellent-blog.png gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
```

6. Modify the Access Control List of the object you just created so that it is readable by everyone:

```
gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
```

Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=2>
       Create a Cloud Storage bucket using the gsutil command line
  </ql-activity-tracking>



## Task 4: Create the Cloud SQL instance

1. In the GCP Console, on the __Navigation menu__ (![Navigation menu](img/menu.png)), click __Storage__ \> __SQL__.

2. Click __Create instance__.

3. For __Choose a database engine__, select __MySQL__.

4. For __Instance ID__, type __blog-db__, and for __Root password__ type a password of your choice.

<aside class="special"><p>Choose a password that you remember. There's no need to obscure the password because you'll use mechanisms to connect that aren't open access to everyone.</p></aside>

5. Set the region and zone assigned by Qwiklabs.

<aside class="special"><p>This is the same region and zone into which you launched the <b>bloghost</b> instance. The best performance is achieved by placing the client and the database close to each other.</p></aside>

6. Click __Create__.

<aside class="special"><p>Wait for the instance to finish deploying. It will take a few minutes.</p></aside>

7. Click on the name of the instance, __blog-db__, to open its details page.

8. From the SQL instances details page, copy the __Public IP address__ for your SQL instance to a text editor for use later in this lab.

9. Click the __Users__ tab, and then click __Create user account__.

10. For __User name__, type ```blogdbuser```

11. For __Password__, type a password of your choice. Make a note of it.

12. Click __Create__ to create the user account in the database.

<aside class="special"><p>Wait for the user to be created.</p></aside>

13. Click the __Connections__ tab, and then click __Add network__.

<aside class="special"><p>If you are offered the choice between a <b>Private IP</b> connection and a <b>Public IP</b> connection, choose <b>Public IP</b> for purposes of this lab. The <b>Private IP</b> feature is in beta at the time this lab was written.</p></aside>

<aside class="special"><p>The <b>Add network</b> button may be grayed out if the user account creation is not yet complete.</p></aside>

14. For __Name__, type ```web front end```

15. For __Network__, type the external IP address of your __bloghost__ VM instance, followed by ```/32```

The result will look like this:

```
35.192.208.2/32
```

<aside class="special"><p>Be sure to use the external IP address of your VM instance followed by /32. Do not use the VM instance's internal IP address. Do not use the sample IP address shown here.</p></aside>

16. Click __Done__ to finish defining the authorized network.

17. Click __Save__ to save the configuration change.


Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=3>
       Create the Cloud SQL instance
  </ql-activity-tracking>


## Task 5: Configure an application in a Compute Engine instance to use Cloud SQL

1. On the __Navigation menu__ (![Navigation menu](img/menu.png)), click __Compute Engine__ \> __VM instances__.

2. In the VM instances list, click __SSH__ in the row for your VM instance __bloghost__.

3. In your ssh session on __bloghost__, change your working directory to the document root of the web server:

```
cd /var/www/html
```

4. Use the __nano__ text editor to edit a file called __index.php__:

```
sudo nano index.php
```

5. Paste the content below into the file:

```
<html>
<head><title>Welcome to my excellent blog</title></head>
<body>
<h1>Welcome to my excellent blog</h1>
<?php
$dbserver = "CLOUDSQLIP";
$dbuser = "blogdbuser";
$dbpassword = "DBPASSWORD";
// In a production blog, we would not store the MySQL
// password in the document root. Instead, we would store it in a
// configuration file elsewhere on the web server VM instance.

$conn = new mysqli($dbserver, $dbuser, $dbpassword);

if (mysqli_connect_error()) {
        echo ("Database connection failed: " . mysqli_connect_error());
} else {
        echo ("Database connection succeeded.");
}
?>
</body></html>
```

<aside class="special"><p>In a later step, you will insert your Cloud SQL instance's IP address and your database password into this file. For now, leave the file unmodified.</p></aside>

6. Press __Ctrl+O__, and then press __Enter__ to save your edited file.

7. Press __Ctrl+X__ to exit the nano text editor.

8. Restart the web server:

```
sudo service apache2 restart
```

9. Open a new web browser tab and paste into the address bar your __bloghost__ VM instance's external IP address followed by __/index.php__. The URL will look like this:

```
35.192.208.2/index.php
```

<aside class="special"><p>Be sure to use the external IP address of your VM instance followed by /index.php. Do not use the VM instance's internal IP address. Do not use the sample IP address shown here.</p></aside>

When you load the page, you will see that its content includes an error message beginning with the words:

```
Database connection failed: ...
```

<aside class="special"><p>This message occurs because you have not yet configured PHP's connection to your Cloud SQL instance.</p></aside>

10. Return to your ssh session on __bloghost__. Use the __nano__ text editor to edit __index.php__ again.

```
sudo nano index.php
```

11. In the __nano__ text editor, replace ```CLOUDSQLIP``` with the Cloud SQL instance Public IP address that you noted above. Leave the quotation marks around the value in place.

12. In the __nano__ text editor, replace ```DBPASSWORD``` with the Cloud SQL database password that you defined above. Leave the quotation marks around the value in place.

13. Press __Ctrl+O__, and then press __Enter__ to save your edited file.

14. Press __Ctrl+X__ to exit the nano text editor.

15. Restart the web server:

```
sudo service apache2 restart
```

16. Return to the web browser tab in which you opened your __bloghost__ VM instance's external IP address. When you load the page, the following message appears:

```
Database connection succeeded.
```

<aside class="special"><p>In an actual blog, the database connection status would not be visible to blog visitors. Instead, the database connection would be managed solely by the administrator.</p></aside>

## Task 6: Configure an application in a Compute Engine instance to use a Cloud Storage object

1. In the GCP Console, click __Storage \> Browser__.

2. Click on the bucket that is named after your GCP project.

3. In this bucket, there is an object called __my-excellent-blog.png__. Copy the URL behind the link icon that appears in that object's __Public access__ column, or behind the words "Public link" if shown.

<aside class="special"><p>If you see neither a link icon nor a "Public link", try refreshing the browser. If you still do not see a link icon, return to Cloud Shell and confirm that your attempt to change the object's Access Control list with the <b>gsutil acl ch</b> command was successful.</p></aside>

4. Return to your ssh session on your __bloghost__ VM instance.

5. Enter this command to set your working directory to the document root of the web server:

```
cd /var/www/html
```

6. Use the __nano__ text editor to edit __index.php__:

```
sudo nano index.php
```

7. Use the arrow keys to move the cursor to the line that contains the __h1__ element. Press __Enter__ to open up a new, blank screen line, and then paste the URL you copied earlier into the line.

8. Paste this HTML markup immediately before the URL:

```
<img src='
```

9. Place a closing single quotation mark and a closing angle bracket at the end of the URL:

```
'>
```

The resulting line will look like this:

```
<img src='https://storage.googleapis.com/qwiklabs-gcp-0005e186fa559a09/my-excellent-blog.png'>
```

The effect of these steps is to place the line containing ```<img src='...'>``` immediately before the line containing ```<h1>...</h1>```

<aside class="special"><p>Do not copy the URL shown here. Instead, copy the URL shown by the Storage browser in your own Cloud Platform project.</p></aside>

10. Press __Ctrl+O__, and then press __Enter__ to save your edited file.

11. Press __Ctrl+X__ to exit the nano text editor.

12. Restart the web server:

```
sudo service apache2 restart
```

13. Return to the web browser tab in which you opened your __bloghost__ VM instance's external IP address. When you load the page, its content now includes a banner image.



## Congratulations!

In this lab, you configured a Cloud SQL instance and connected an application in a Compute Engine instance to it. You also worked with a Cloud Storage bucket.


![[/fragments/endqwiklab]]

##### Manual Last Updated: April 01, 2019

##### Lab Last Tested: April 01, 2019

![[/fragments/copyright]]

## More resources

Read the  [Google Cloud Platform documentation on Cloud SQL](https://cloud.google.com/sql/docs/).

Read the  [Google Cloud Platform documentation on Cloud Storage](https://cloud.google.com/storage/docs/).

![827b33e18db55754.png](img/827b33e18db55754.png)
