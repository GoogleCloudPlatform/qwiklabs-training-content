# Getting Started with Deployment Manager and Stackdriver

## Overview

In this lab, you create a deployment using Deployment Manager and use it to maintain a consistent state of your deployment. You will also view resource usage in a VM instance using Stackdriver.

## Objectives

In this lab, you will learn how to perform the following tasks:

* Create a Deployment Manager deployment.
* Update a Deployment Manager deployment.
* View the load on a VM instance using Stackdriver.

## Task 1: Sign in to the Google Cloud Platform (GCP) Console

![[/fragments/startqwiklab]]

## Task 2: Confirm that needed APIs are enabled

1.  Make a note of the name of your GCP project. This value is shown in the top bar of the Google Cloud Platform Console. It will be of the form `qwiklabs-gcp-` followed by hexadecimal numbers.

2. In the GCP Console, on the __Navigation menu__(![Navigation menu](img/menu.png)), click __APIs & services__.

3. Scroll down in the list of enabled APIs, and confirm that these APIs are enabled:

* Google Cloud Deployment Manager v2 API
* Cloud Runtime Configuration API
* Stackdriver Monitoring API

4. If one or more APIs is missing, click the __Enable APIs and Services__ button at top. Search for the above APIs by name and enable each for your current project. (You noted the name of your GCP project above.)

## Task 3: Create a Deployment Manager deployment

1. On the __Google Cloud Platform__ menu, click __Activate Google Cloud Shell__ (![Activate Cloud Shell](img/devshell.png)). If a dialog box appears, click __Start Cloud Shell__.

2. For your convenience, place the zone that Qwiklabs assigned you to into an environment variable called MY_ZONE. At the Cloud Shell prompt, type this partial command:

  ```
  export MY_ZONE=
  ```

  followed by the zone that Qwiklabs assigned you to. Your complete command will look like this:

  ```
  export MY_ZONE=us-central1-f
  ```

3. At the Cloud Shell prompt, download an editable Deployment Manager template:

  ```
  gsutil cp gs://cloud-training/gcpfcoreinfra/mydeploy.yaml mydeploy.yaml
  ```

4. Insert your Google Cloud Platform project ID into the file in place of the string ```PROJECT_ID``` using this command:

  ```
  sed -i -e 's/PROJECT_ID/'$DEVSHELL_PROJECT_ID/ mydeploy.yaml
  ```

5. Insert your assigned Google Cloud Platform zone into the file in place of the string ```ZONE``` using this command:

  ```
  sed -i -e 's/ZONE/'$MY_ZONE/ mydeploy.yaml
  ```

6. View the ```mydeploy.yaml``` file, with your modifications, with this command:

  ```
  cat mydeploy.yaml
  ```
  
  The file will look something like this:
  
 <pre>
  resources:
  - name: my-vm
    type: compute.v1.instance
    properties:
      zone: us-central1-a
      machineType: zones/us-central1-a/machineTypes/n1-standard-1
      metadata:
        items:
        - key: startup-script
          value: "apt-get update"
      disks:
      - deviceName: boot
        type: PERSISTENT
        boot: true
        autoDelete: true
        initializeParams:
          sourceImage: https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-9-stretch-v20180806
      networkInterfaces:
      - network: https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-dcdf854d278b50cd/global/networks/default
        accessConfigs:
        - name: External NAT
          type: ONE_TO_ONE_NAT
</pre>

<aside class="special"><p>Do not use the above text literally in your own <b>mydeploy.yaml</b> file. Be sure that the zone that is named on the <b>zone:</b> and <b>machineType:</b> lines in your file matches the zone to which Qwiklabs assigned you. Be sure that the GCP project ID on the <b>network:</b> line in your file matches the project ID to which Qwiklabs assigned you, not the one in this example.</p></aside>

7. Build a deployment from the template:

  ```
  gcloud deployment-manager deployments create my-first-depl --config mydeploy.yaml
  ```

  When the deployment operation is complete, the __gcloud__ command displays a list of the resources named in the template and their current state.

8. Confirm that the deployment was successful. In the GCP Console, on the __Navigation menu__(![Navigation menu](img/menu.png)), click __Compute Engine \> VM instances__.
  You will see that a VM instance called __my-vm__ has been created, as specified by the template.

9. Click on the VM instance's name to open its VM instance details screen.

10. Scroll down to the __Custom metadata__ section. Confirm that the startup script you specified in your Deployment Manager template has been installed.


Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=1>
       Create a Deployment Manager deployment 
  </ql-activity-tracking>
  

## Task 4: Update a Deployment Manager deployment

1. Return to your Cloud Shell prompt. Launch the __`nano`__ text editor to edit the __mydeploy.yaml__ file:

  ```
  nano mydeploy.yaml
  ```

2. Find the line that sets the value of the startup script, ```value: "apt-get update"```, and edit it so that it looks like this:

  ```
        value: "apt-get update; apt-get install nginx-light -y"
  ```

  Do not disturb the spaces at the beginning of the line. The YAML templating language relies on indented lines as part of its syntax. As you edit the file, be sure that the ```v``` in the word ```value``` in this new line is immediately below the ```k``` in the word ```key``` on the line above it.

3. Press __Ctrl+O__ and then press __Enter__ to save your edited file.

4. Press __Ctrl+X__ to exit the __nano__ text editor.

5.  Return to your Cloud Shell prompt. Enter this command to cause Deployment Manager to update your deployment to install the new startup script:

  ```
  gcloud deployment-manager deployments update my-first-depl --config mydeploy.yaml
  ```

  Wait for the __gcloud__ command to display a message confirming that the update operation was completed successfully.

6. In the GCP console, on the __Navigation menu__(![Navigation menu](img/menu.png)), click __Compute Engine \> VM instances__.

7. Click on the __my-vm__ VM instance's name to open its __VM instance details__ pane.

8. Scroll down to the __Custom metadata__ section. Confirm that the startup script has been updated to the value you declared in your Deployment Manager template.

Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=2>
       Update the Deployment Manager deployment 
  </ql-activity-tracking>


## Task 5: View the Load on a VM using Stackdriver

1. In the GCP Console, on the __Navigation menu__(![Navigation menu](img/menu.png)), click __Compute Engine__ \> __VM instances__.

2. To open a command prompt on the __my-vm__ instance, click __SSH__ in its row in the __VM instances__ list.

3. In the ssh session on __my-vm__, execute this command to create a CPU load:

  ```
  dd if=/dev/urandom | gzip -9 >> /dev/null &
  ```

  This Linux pipeline forces the CPU to work on compressing a continuous stream of random data.

  <aside class="special"><p>Leave the window containing your ssh open while you proceed with the lab.</p></aside>

4. In the GCP Console, on the __Navigation menu__(![Navigation menu](img/menu.png)), under __Stackdriver__, click __Monitoring__.

5. On the Stackdriver welcome screen (__Create your free Stackdriver account__), confirm that the Google Cloud Platform project shown is the one to which Qwiklabs assigned you. Click __Create account__.

6. In the __Add Google Cloud Platform projects to monitor__ dialog, confirm that the GCP project that Qwiklabs created for you is shown as selected, and then click __Continue__.

7. In the __Monitor AWS accounts__ dialog, click __Skip AWS Setup__.

8. In the __Install the Stackdriver Agents__ dialog, click __Continue__.

  Installing the Stackdriver agents into your VM instances is generally recommended, because it allows Stackdriver to monitor and log more information. But this action is not required for this lab.

9. On the __Get Reports by Email__ screen, click __No reports__, and then click __Continue__.
After a short delay, Stackdriver displays the message __Finished initial collection__

10. Click __Launch monitoring__.

11. On the __Welcome to Stackdriver Monitoring__ screen, click __Resources \> Metrics Explorer__.

12. In the __Metrics Explorer__'s __Metric__ pane, select the resource type __GCE VM instance__ and the metric __CPU usage__. 

  In the resulting graph, notice that CPU usage increased sharply a few minutes ago.

13. Terminate your workload generator. Return to your ssh session on __my-vm__ and enter this command:

  ```
  kill %1
  ```

![[/fragments/endqwiklab]]

## Congratulations!

In this lab, you used Deployment Manager to create a deployment using a template, and you demonstrated Deployment Manager's ability to bring a deployment into compliance with a template. You also used Stackdriver to view resource consumption on a VM instance.

## More resources

Read the  [documentation on Google Cloud Deployment Manager](https://cloud.google.com/deployment-manager/docs/).

Read the  [documentation on Stackdriver](https://cloud.google.com/stackdriver/docs/).

![827b33e18db55754.png](img/827b33e18db55754.png)
