# Getting Started with Cloud Marketplace

## Overview

In this lab, you use Cloud Marketplace to quickly and easily deploy a LAMP stack on a Compute Engine instance. The Bitnami LAMP Stack provides a complete web development environment for Linux that can be launched in one click.

| Component | Role |
|---|---|
| Linux | Operating system |
| Apache HTTP Server | Web server |
| MySQL | Relational database |
| PHP | Web application framework |
| phpMyAdmin | PHP administration tool |

For more information on the Bitnami LAMP stack, see
[https://docs.bitnami.com/google/infrastructure/lamp/](https://docs.bitnami.com/google/infrastructure/lamp/)

## Objectives

In this lab, you learn how to perform the following task:

* Launch a solution using Cloud Marketplace.

## Task 1: Sign in to the Google Cloud Platform (GCP) Console

![[/fragments/startqwiklab]]

## Task 2: Use Cloud Marketplace to deploy a LAMP stack

1. In the GCP Console, on the __Navigation menu__ (![Navigation menu](img/menu.png)), click __Marketplace__.

2. In the search bar, type ```LAMP```

3. In the search results, click __LAMP Certified by Bitnami__.

    If you choose another LAMP stack, such as the Google Click to Deploy offering, the lab instructions will not work as expected.

4. On the LAMP page, click __Launch on Compute Engine__.

    If this is your first time using Compute Engine, the Compute Engine API must be initialized before you can continue.

5. For __Zone__, select the deployment zone that Qwiklabs assigned to you.

6. Leave the remaining settings as their defaults.

7. If you are prompted to accept the GCP Marketplace Terms of Service, do so.

8. Click __Deploy__.

9. If a __Welcome to Deployment Manager__ message appears, click __Close__ to dismiss it.

    The status of the deployment appears in the console window: __lampstack-1 is being deployed__. When the deployment of the infrastructure is complete, the status changes to __lampstack-1 has been deployed__.

    After the software is installed, a summary of the details for the instance, including the site address, is displayed.

Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=1>
       Use Cloud Marketplace to deploy a LAMP stack
  </ql-activity-tracking>


## Task 3: Verify your deployment

1. When the deployment is complete, click the __Site address__ link in the right pane.

    Alternatively, you can click __Visit the site__ in the __Get started with LAMP Certified by Bitnami__ section of the page.
    A new browser tab displays a congratulations message. This page confirms that, as part of the LAMP stack, the Apache HTTP Server is running.

2. Close the congratulations browser tab.

3. On the GCP Console, under __Get started with LAMP Certified by Bitnami__, click __SSH__.

    In a new window, a secure login shell session on your virtual machine appears.

4. In the just-created SSH window, to change the current working directory to ```/opt/bitnami```, execute the following command:

    ```
    cd /opt/bitnami
    ```

5. To copy the ```phpinfo.php``` script from the installation directory to a publicly accessible location under the web server document root, execute the following command:

    ```
    sudo cp docs/phpinfo.php apache2/htdocs
    ```

    The phpinfo.php script displays your PHP configuration. It is often used to verify a new PHP installation.

6. To close the SSH window, execute the following command:

    ```
    exit
    ```

7. Open a new browser tab.

8. Type the following URL, and replace ```SITE_ADDRESS``` with the URL in the __Site address__ field in the right pane of the __lampstack__ page.

    ```
    http://SITE_ADDRESS/phpinfo.php
    ```

    A summary of the PHP configuration of your server is displayed.

9. Close the phpinfo tab.


## Congratulations!

In this lab you deployed a LAMP stack to a Compute Engine instance.

![[/fragments/endqwiklab]]

##### Manual Last Updated: April 01, 2019

##### Lab Last Tested: April 01, 2019

![[/fragments/copyright]]

## More resources

Read the  [Google Cloud Platform documentation on Cloud Marketplace](https://cloud.google.com/marketplace/docs/).

![827b33e18db55754.png](img/827b33e18db55754.png)
