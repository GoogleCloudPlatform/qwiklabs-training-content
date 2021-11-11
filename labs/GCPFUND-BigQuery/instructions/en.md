# Getting Started with BigQuery

## Overview

In this lab, you load a web server log into a BigQuery table. After loading the data, you query it using the BigQuery web user interface and the BigQuery CLI.

BigQuery helps you perform interactive analysis of petabyte-scale databases, and it enables near-real time analysis of massive datasets. It offers a familiar SQL 2011 query language and functions.

Data stored in BigQuery is highly durable. Google stores your data in a replicated manner by default and at no additional charge for replicas. With BigQuery, you pay only for the resources you use. Data storage in BigQuery is inexpensive. Queries incur charges based on the amount of data they process:  when you submit a query, you pay for the compute nodes only for the duration of that query. You don't have to pay to keep a compute cluster up and running.

Using BigQuery involves interacting with a number of Google Cloud Platform resources, including projects (covered elsewhere in this course), datasets, tables, and jobs. This lab introduces you to some of these resources, and this brief introduction summarizes their role in interacting with BigQuery.

__Datasets:__ A dataset is a grouping mechanism that holds zero or more tables. A dataset is the lowest level unit of access control. Datasets are owned by GCP projects. Each dataset can be shared with individual users.

__Tables:__ A table is a row-column structure that contains actual data. Each table has a schema that describes strongly typed columns of values. Each table belongs to a dataset.

## Objectives

In this lab, you learn how to perform the following tasks:

* Load data from Cloud Storage into BigQuery.
* Perform a query on the data in BigQuery.

## Task 1: Sign in to the Google Cloud Platform (GCP) Console

![[/fragments/startqwiklab]]

Make a note of whether your assigned region is closer to the United States or to Europe.

## Task 2: Load data from Cloud Storage into BigQuery

1. In the Console, on the __Navigation menu__ (![Navigation menu](img/menu.png)), click __BigQuery__ then click __Done__.

2. Create a new dataset within your project by selecting your project in the Resources section, then clicking on __CREATE DATASET__ on the right.

3. In the __Create Dataset__ dialog, for __Dataset ID__, type __logdata__.

4. For __Data location__, select the continent closest to the region. click __Create dataset__.

5. Create a new table in the __logdata__ to store the data from the CSV file.

6. Click on __Create Table__. On the __Create Table__ page, in the __Source__ section:

  * For Create table from, choose select Google Cloud Storage, and in the field, type `cloud-training/gcpfci/access_log.csv`.
  * Verify File format is set to CSV.


  __Note__: When you have created a table previously, the Create from Previous Job option allows you to quickly use your settings to create similar tables.

7. In the __Destination__ section:

  * For __Dataset name__, leave __logdata__ selected.

  * For __Table name__, type __accesslog__.

  * For __Table type, Native table__ should be selected and unchangeable.

8. Under __Schema__ section, for __Auto detect__ check the __Schema and input Parameters__.

9. Accept the remaining default values and click __Create Table__.

  BigQuery creates a load job to create the table and upload data into the table (this may take a few seconds).

10. (Optional) To track job progress, click __Job History__.

11. When the load job is complete, click __logdata__ > __accesslog__.

12. On the __Table Details__ page, click __Details__ to view the table properties, and then click __Preview__ to view the table data.

    Each row in this table logs a hit on a web server. The first field, __string_field_0__, is the IP address of the client. The fourth through ninth fields log the day, month, year, hour, minute, and second at which the hit occurred. In this activity, you will learn about the daily pattern of load on this web server.

Click _Check my progress_ to verify the objective.
  <ql-activity-tracking step=1>
        Load data from Cloud Storage into BigQuery
  </ql-activity-tracking>

## Task 3: Perform a query on the data using the BigQuery web UI

In this section of the lab, you use the BigQuery web UI to query the __accesslog__ table you created previously.

1. In the __Query editor__ window, type (or copy-and-paste) the following query:

2. Because you told BigQuery to automatically discover the schema when you load the data, the hour of the day during which each web hit arrived is in a field called __int_field_6__.

    ```
    select int64_field_6 as hour, count(*) as hitcount from logdata.accesslog
    group by hour
    order by hour
    ```

    Notice that the Query Validator tells you that the query syntax is valid (indicated by the green check mark) and indicates how much data the query will process. The amount of data processed allows you to determine the price of the query using the  [Cloud Platform Pricing Calculator](https://cloud.google.com/products/calculator/).

3. Click __Run__ and examine the results. At what time of day is the website busiest? When is it least busy?

## Task 4: Perform a query on the data using the bq command

In this section of the lab, you use the bq command in Cloud Shell to query the __accesslog__ table you created previously.

1. On the __Google Cloud Platform__ menu, click __Activate Cloud Shell__ ![Activate Cloud Shell](img/devshell.png).
If a dialog box appears, click __Start Cloud Shell__.

2. At the Cloud Shell prompt, enter this command:

    ```
    bq query "select string_field_10 as request, count(*) as requestcount from logdata.accesslog group by request order by requestcount desc"
    ```

    The first time you use the ```bq``` command, it caches your Google Cloud Platform credentials, and then asks you to choose your default project. Choose the project that Qwiklabs assigned you to. Its name will look like ```qwiklabs-gcp-``` followed by a hexadecimal number.

    The `bq` command then performs the action requested on its command line. What URL offered by this web server was most popular? Which was least popular?


## Congratulations!

In this lab, you loaded data stored in Cloud Storage into a table hosted by Google BigQuery. You then queried the data to discover patterns.

![[/fragments/endqwiklab]]

##### Manual Last Updated: April 01, 2019

##### Lab Last Tested: April 01, 2019

![[/fragments/copyright]]

## More resources

Read the  [Google Cloud Platform documentation on BigQuery](https://cloud.google.com/bigquery/docs/).

![827b33e18db55754.png](img/827b33e18db55754.png)
