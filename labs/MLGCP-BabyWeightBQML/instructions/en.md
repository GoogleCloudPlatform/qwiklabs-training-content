# Predict Baby Weight using BQML

## Overview  

BigQuery is Google's fully managed, NoOps, low cost analytics database. With BigQuery you can query terabytes and terabytes of data without having any infrastructure to manage or needing a database administrator. BigQuery uses SQL and can take advantage of the pay-as-you-go model. BigQuery allows you to focus on analyzing data to find meaningful insights.

[BigQuery Machine Learning](https://cloud.google.com/bigquery/docs/bigqueryml-analyst-start) (BQML, product in beta) is a new feature in BigQuery where data analysts can create, train, evaluate, and predict with machine learning models with minimal coding.

### Objectives

In this lab, you learn to perform the following tasks:

* Use BigQuery to explore the natality dataset
* Create a training and evaluation dataset for prediction
* Create a regression (linear regression) model in BQML
* Evaluate the performance of your machine learning model
* Use feature engineering to improve model accuracy
* Predict baby weight from a set of features

## Introduction

In this lab, you will be using the CDC's natality data to build a model to predict baby weights based on a handful of features known at pregnancy. Because we're predicting a continuous value, this is a regression problem, and for that, we'll use the linear regression model built into BQML.

## Setup

![[/fragments/start-qwiklab]]

![[/fragments/cloudshell]]

## Launch Cloud Datalab

To launch Cloud Datalab:

1. In __Cloud Shell__, type:

  ```
  gcloud compute zones list
  ```

2. Pick a zone in a geographically closeby region.

3. In __Cloud Shell__, type:
  ```
  datalab create bdmlvm --zone <ZONE>
  ```

  Datalab will take about 5 minutes to start.

  `Note: Follow the prompts during this process.`

## Checkout notebook into Cloud Datalab

If necessary, wait for Datalab to finish launching. Datalab is ready when you see a message prompting you to do a "Web Preview".

1. Click on the __Web Preview__ icon on the top-right corner of the Cloud Shell ribbon. Click on the __Change port__. Switch to port __8081__ using the __Change Preview Port__ dialog box, and then click on __Change and Preview__.

 ![ChangePort.png](img/ChangePort.png)

 ![ChangePreviewPort.png](img/ChangePreviewPort.png)

 __Note:__ The connection to your Datalab instance remains open for as long as the datalab command is active. If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command `datalab connect bdmlvm` in your new Cloud Shell.

![[/fragments/clone-repo-in-datalab]]

## Open a Datalab notebook

1. In the Datalab browser, navigate to __datalab > notebooks > training-data-analyst \> courses \> machine_learning \> deepdive \> 06_structured \> 5_train_bqml.ipynb__.

2. Read the commentary, click __Clear | Clear all Cells__, then run the Python snippets (Use __Shift+Enter__ to run each piece of code) in the cell, step by step.

![[/fragments/endqwiklab]]

Last Tested Date: 12-11-2018

Last Updated Date: 12-12-2018

![[/fragments/copyright]]
