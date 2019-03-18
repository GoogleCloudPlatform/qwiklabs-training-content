# Create ML Dataset with BigQuery

## Overview

In this lab, you use BigQuery from within Datalab to create a Pandas dataframe that will be the training data for predicting taxicab demand.

### __What you learn__

In this lab, you will:

* Use BigQuery and Datalab to explore and visualize data
* Build a Pandas dataframe that will be used as the training dataset for machine learning using TensorFlow

## Introduction

In this lab and the next, you will build a demand forecast system using machine learning. You plan to use TensorFlow to predict taxicab demand on a day-by-day basis. In order to do that, you will first need a training dataset that consists of the factors that affect taxi demand ("input features") and the actual demand ("target") on days in the past. You will use this data to train a neural network that can then predict the demand on days in the future given those features as input.

In this lab, you will use BigQuery in Datalab to build the dataset that we will use in the next lab to carry out the machine learning.

## Setup

![[/fragments/cloudshell]]

## Task 1: Launch Cloud Datalab

To launch Cloud Datalab:

1. In __Cloud Shell__, type:

    ```bash
  datalab create bdmlvm --zone us-central1-a
    ```

Datalab will take about 5 minutes to start.

`Note: follow the prompts during this process.`

If you are not yet familiar with Datalab, what follows is a graphical cheat sheet for the main Datalab functionality:

![369bf7e045b084ed.png](img/369bf7e045b084ed.png)

## Task 2: Checkout notebook into Cloud Datalab

Note: If necessary, wait for Datalab to finish launching. Datalab is ready when you see a message prompting you to do a "Web Preview".

1. Click on the __Web Preview__ icon on the top-right corner of the Cloud Shell ribbon. Click on __Change port__. Switch to port __8081__ using the __Change Preview Port__ dialog box, and then click on __Change and Preview__.

    ![ChangePort.png](img/ChangePort.png)

    ![ChangePreviewPort.png](img/ChangePreviewPort.png)

    Note: The connection to your Datalab instance remains open for as long as the datalab command is active. If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command `datalab connect bdmlvm` in your new Cloud Shell.

2. In __Datalab__, click on the icon for __Open ungit__ in the top-right ribbon.

    ![fc5c4f63c40f83f.png](img/fc5c4f63c40f83f.png)

3. In the Ungit window, select the text that reads __/content/datalab/notebooks__ and remove the __notebooks__ so that it reads __/content/datalab__, then hit __Enter__.

    ![dbeb32393b0874e4.png](img/dbeb32393b0874e4.png)

4. In the panel that comes up, type the following as the GitHub repository to __Clone from__:

    ```bash
    https://github.com/GoogleCloudPlatform/training-data-analyst
    ```

5. Click __Clone repository__.

## Task 3: Open a Datalab notebook

1. In the Datalab browser, navigate to __training-data-analyst \> CPB100 \> lab4a \> demandforecast.ipynb__.

2. Read the commentary, Click __Clear | Clear all Cells__, then run the Python snippets (Use __Shift+Enter__ to run each piece of code) in the cell, step by step.

3. When you reach the section __Machine Learning with Tensorflow__, please stop -- that is the next lab.

![[/fragments/endqwiklab]]

Last Manual Updated Date: 2019-03-06

Last Tested Date: 2019-03-06

![[/fragments/copyright]]
