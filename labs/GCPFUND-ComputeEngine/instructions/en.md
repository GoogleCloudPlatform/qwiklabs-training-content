# Getting Started with Compute Engine

## Overview

In this lab, you will create virtual machines (VMs) and connect to them.  You will also create connections between the instances.

## Objectives

In this lab, you will learn how to perform the following tasks:

* Create a Compute Engine virtual machine using the Google Cloud Platform (GCP) Console.
* Create a Compute Engine virtual machine using the gcloud command-line interface.
* Connect between the two instances.

## Task 1: Sign in to the Google Cloud Platform (GCP) Console

![[/fragments/startqwiklab]]

## Task 2: Create a virtual machine using  the GCP Console

1. In the __Navigation menu__ (![Navigation menu](img/menu.png)), click __Compute Engine__ \> __VM instances__.
2. Click __Create__.
3. On the __Create an Instance__ page, for __Name__, type ```my-vm-1```
4. For __Region__ and __Zone__, select the region and zone assigned by Qwiklabs.
5. For __Machine type__, accept the default.
6. For __Boot disk__, if the __Image__ shown is not __Debian GNU/Linux 9 (stretch)__, click __Change__ and select __Debian GNU/Linux 9 (stretch)__.
7. Leave the defaults for Identity and API access unmodified.
8. For Firewall, click __Allow HTTP traffic__.
9. Leave all other defaults unmodified.
10. To create and launch the VM, click __Create__.

  <aside class="special">
    <p><strong>Note</strong>: The VM can take about two minutes to launch and be fully available for use.</p>
  </aside>


Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=1>
       Create a virtual machine using the GCP Console
  </ql-activity-tracking>

## Task 3: Create a virtual machine using  the gcloud command line

1. On the __Google Cloud Platform__ menu, click __Activate Cloud Shell__ ![Activate Cloud Shell](img/devshell.png). If a dialog box appears, click __Start Cloud Shell__.
2. To display a list of all the zones in the region to which Qwiklabs assigned you, enter this partial command ```gcloud compute zones list | grep``` followed by the region that Qwiklabs or your instructor assigned you to.

    Your completed command will look like this:
    ```
    gcloud compute zones list | grep us-central1
    ```

3. Choose a zone from that list other than the zone to which Qwiklabs assigned you. For example, if Qwiklabs assigned you to region ```us-central1``` and zone ```us-central1-a``` you might choose zone ```us-central1-b```.

4. To set your default zone to the one you just chose, enter this partial command ```gcloud config set compute/zone``` followed by the zone you chose.

    Your completed command will look like this:

    ```
    gcloud config set compute/zone us-central1-b
    ```

5. To create a VM instance called __my-vm-2__ in that zone, execute this command:

    ```
    gcloud compute instances create "my-vm-2" \
    --machine-type "n1-standard-1" \
    --image-project "debian-cloud" \
    --image "debian-9-stretch-v20190213" \
    --subnet "default"
    ```

    <aside class="special">
      <p><strong>Note</strong>: The VM can take about two minutes to launch and be fully available for use.</p>
    </aside>


6. To close the Cloud Shell, execute the following command:

    ```
    exit
    ```

Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=2>
       Create a virtual machine using the gcloud command line
  </ql-activity-tracking>

## Task 4: Connect between VM instances

1. In the __Navigation menu__ (![Navigation menu](img/menu.png)), click __Compute Engine \> VM instances__.

    You will see the two VM instances you created, each in a different zone.

    Notice that the Internal IP addresses of these two instances share the first three bytes in common. They reside on the same subnet in their Google Cloud VPC even though they are in different zones.

2. To open a command prompt on the __my-vm-2__ instance, click __SSH__ in its row in the __VM instances__ list.
3. Use the `ping` command to confirm that __my-vm-2__ can reach __my-vm-1__ over the network:

    ```
    ping my-vm-1
    ```

    Notice that the output of the ```ping``` command reveals that the complete hostname of __my-vm-1__ is __my-vm-1.c.PROJECT_ID.internal__, where PROJECT_ID is the name of your Google Cloud Platform project. GCP automatically supplies Domain Name Service (DNS) resolution for the internal IP addresses of VM instances.

4. Press __Ctrl+C__ to abort the ping command.

5. Use the __ssh__ command to open a command prompt on __my-vm-1__:

    ```
    ssh my-vm-1
    ```

    If you are prompted about whether you want to continue connecting to a host with unknown authenticity, enter __yes__ to confirm that you do.

6. At the command prompt on __my-vm-1__, install the Nginx web server:

    ```
    sudo apt-get install nginx-light -y
    ```

7. Use the __nano__ text editor to add a custom message to the home page of the web server:

    ```
    sudo nano /var/www/html/index.nginx-debian.html
    ```

8. Use the arrow keys to move the cursor to the line just below the ```h1``` header.  Add text like this, and replace YOUR_NAME with your name:

    ```
    Hi from YOUR_NAME
    ```

9. Press __Ctrl+O__ and then press __Enter__ to save your edited file, and then press __Ctrl+X__ to exit the nano text editor.

10. Confirm that the web server is serving your new page. At the command prompt on __my-vm-1__, execute this command:

    ```
    curl http://localhost/
    ```

    The response will be the HTML source of the web server's home page, including your line of custom text.

11. To exit the command prompt on __my-vm-1__, execute this command:

    ```
    exit
    ```

    You will return to the command prompt on __my-vm-2__

12. To confirm that __my-vm-2__ can reach the web server on __my-vm-1__, at the command prompt on __my-vm-2__, execute this command:

    ```
    curl http://my-vm-1/
    ```

    The response will again be the HTML source of the web server's home page, including your line of custom text.

13. In the __Navigation menu__ (![Navigation menu](img/menu.png)), click __Compute Engine \> VM instances__.

14. Copy the External IP address for __my-vm-1__ and paste it into the address bar of a new browser tab. You will see your web server's home page, including your custom text.

<aside class="special"><p>If you forgot to click <b>Allow HTTP traffic</b> when you created the <b>my-vm-1</b> VM instance, your attempt to reach your web server's home page will fail. You can add a <a href="https://cloud.google.com/vpc/docs/firewalls" target="_blank">firewall rule</a> to allow inbound traffic to your instances, although this topic is out of scope for this course.</p></aside>


## Congratulations!

In this lab, you created virtual machine (VM) instances in two different zones and connected to them using ping, ssh, and HTTP.

![[/fragments/endqwiklab]]

##### Manual Last Updated: April 01, 2019

##### Lab Last Tested: April 01, 2019

![[/fragments/copyright]]

## More Resources

Read the  [Google Cloud Platform documentation on Google Compute Engine](https://cloud.google.com/compute/docs/).

Read about  [Google Cloud Platform Virtual Private Cloud (VPC)](https://cloud.google.com/compute/docs/vpc/).

![827b33e18db55754.png](img/827b33e18db55754.png)
