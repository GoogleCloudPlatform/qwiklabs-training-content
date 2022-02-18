# Setup Rentals Data in Cloud SQL

## Overview

In this lab, you populate rentals data in Cloud SQL for the rentals recommendation engine to use.

### What you learn

In this lab, you will:

* Create Cloud SQL instance
* Create database tables by importing .sql files from Cloud Storage
* Populate the tables by importing .csv files from Cloud Storage
* Allow access to Cloud SQL
* Explore the rentals data using SQL statements from CloudShell

## Introduction

In this lab, you populate rentals data in Cloud SQL for the rentals recommendation engine to use. The recommendations engine itself will run on Dataproc using Spark ML, and you will set that up in the next lab.

![[/fragments/startqwiklab]]

## Setup

![[/fragments/cloudshell]]

## Task 1: Access lab code

To explore the lab code in Cloud Shell:

1. In Cloud Shell, type:

    ```
    git clone https://github.com/GoogleCloudPlatform/training-data-analyst
    ```

    This downloads the code from github.

2. Navigate to the folder corresponding to this lab:

    ```
    cd training-data-analyst/CPB100/lab3a
    ```

3. Examine the table creation file using __less__:

    ```
    less cloudsql/table_creation.sql
    ```

    The __less__ command allows you to view the file (Press the __spacebar__ to scroll down; the letter __b__ to back up a page; the letter __q__ to quit).

4. Fill out this information (the first line has been filled out for you):

    | Table Name | Columns |
    |---|---|
    | Accommodation | Id, title, location, price, rooms, rating, type |
    | ____Rating____________? | _______userId,accoId,rating,________? |
    | __________Recommendation______? | ___userId, accoId, prediction_____________? |

    How do these relate to the rentals recommendation scenario? Fill the following blanks:

    * When a user rates a house (giving it four stars for example), an entry is added to the ________________ table.
    * General information about houses, such as the number of rooms they have and their average rating is stored in the ________________ table.
    * The job of the recommendation engine is to fill out the ________________ table for each user and house: this is the predicted rating of that house by that user.

5. Examine the data files using __head__:

    ```
    head cloudsql/*.csv
    ```

    The __head__ command shows you the first few lines of each file.

## Task 2: Create bucket

1. In the GCP Console, on the __Navigation menu__ (![8ab244f9cffa6198.png](img/mainmenu.png)).

2. Click __Storage__.

3. Click __Create Bucket__.

4. For __Name__, enter your __Project ID__. Select __Set object-level and bucket-level permissions__ under __Access control model__, then click __Create__. To find your __Project ID__, click the project in the top menu of the GCP Console and copy the value under __ID__ for your selected project.

    Note the name of your bucket. In the remainder of the lab, replace `<BUCKET-NAME>` with your unique bucket name.

## Task 3: Stage .sql and .csv files into Cloud Storage

Stage the table definition and data files into Cloud Storage, so that you can later import them into Cloud SQL:

1. From Cloud Shell within the __lab3a__ directory, type:

    ```
    gsutil cp cloudsql/* gs://<BUCKET-NAME>/sql/
    ```

    substituting the name of the bucket.

2. From the GCP console, navigate to __Storage__, then your bucket and verify that the `.sql` and `.csv` files now exist.

## Task 4: Create Cloud SQL instance

1. In the GCP console, click __SQL__ (in the Storage section).

2. Click  __Create instance__.

3. Choose __MySQL__. Click __Next__ if required.

4. For __Instance ID__, type __rentals__.

    ![ab1cdf08212ecadf.png](img/ab1cdf08212ecadf.png)

5. Scroll down and specify a root password. Before you forget, note down the root password.

6. Click __Create__ to create the instance. It will take a minute or so for your Cloud SQL instance to be provisioned.


## Task 5: Create tables

1. In __Cloud SQL__, click __rentals__ to view instance information.

2. Click  __Import__(on the top menu bar).

3. Click __Browse__. This will bring up a list of buckets. Click on the bucket you created, then navigate into __sql__ and click __table_creation.sql__.

4. Click __Select__, then click __Import__.

    <aside class="warning"><p>
    <strong>Note</strong>: If <code>.sql</code> or <code>.csv</code> files import fails in first attempt, try again.
    </p>
    </aside>

## Task 6: Populate tables

1. To import CSV files from Cloud Storage, from the GCP console page with the Cloud SQL instance details, click __Import__ (top menu).

2. Click __Browse__, browse in the bucket you created to __sql__, then click __accommodation.csv__. Click __Select__.

3. For __Database__, select __recommendation_spark__.

4. For __Table__, type __Accommodation__.

    ![c899adb7fdb39f17.png](img/c899adb7fdb39f17.png)

5. Click  __Import__.

6. Repeat the __Import__ (steps 1 - 5) for __rating.csv__, but for __Table__, type __Rating__.

## Task 7: Explore Cloud SQL

1. To explore Cloud SQL, you can use the mysql CLI. In Cloud Shell, type the following:

    ```
    wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
    chmod +x cloud_sql_proxy
    ```
2. In the GCP Console, find the SQL __Instance connection name__ in the Overview tab and copy it. In the command below, replace <INSTANCE_CONNECTION_NAME> with this value and run it.

  ```
 ./cloud_sql_proxy -instances=<INSTANCE_CONNECTION_NAME>=tcp:3306 &
 ```

3. Connect to the Cloud SQL instance using mysql:

  ```
  mysql -u root -p --host 127.0.0.1
  ```

4. MySQL will prompt you for the root password. Enter the password when prompted.

5. In Cloud Shell, at the mysql prompt, type:

    ```
    use recommendation_spark;
    ```

    This sets the database in the mysql session.

6. View the list of tables you created. This will be helpful to prevent any typos in your query in step 4.

    ```
    show tables;
    ```

7. Let's verify that the data was loaded.

    ```
    select * from Rating;
    ```

    Example output:

    ```
    | 23     | 99     |      5 |
    | 4      | 99     |      4 |
    | 7      | 99     |      5 |
    | 8      | 99     |      5 |
    +--------+--------+--------+
    1186 rows in set (0.03 sec)
    ```

8. Let's see if there is a great deal out there somewhere.

    ```
    select * from Accommodation where type = 'castle' and price < 1500;
    ```

    All the cheap castles are rated poorly.

9. You may exit the mysql prompt by typing __exit__.

![[/fragments/endqwiklab]]

Last Manual Updated Date: 2019-03-06

Last Tested Date: 2019-03-06

![[/fragments/copyright]]
