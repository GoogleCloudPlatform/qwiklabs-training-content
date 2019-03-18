# Invoke Machine Learning APIs

## Overview

In this lab, you use Machine Learning APIs from within Datalab.

### __What you learn__

In this lab, you learn how to invoke ML APIs from Python and use their results.

## Introduction

In this lab, you will invoke ML APIs from Datalab to carry out some representative tasks:

* Vision API to detect text in an image
* Translate API to translate that text into English
* Natural Language API to find the sentiment of some famous quotes
* Speech API to transcribe an audio file

## Setup

![[/fragments/cloudshell]]

## Task 1: Launch Cloud Datalab

To launch Cloud Datalab:

1. In Cloud Shell, type:

  ```bash
  datalab create bdmlvm --zone us-central1-a
  ```
  Datalab will take about 5 minutes to start.

  `Note: follow the prompts during this process.`

## Task 2: Checkout notebook into Cloud Datalab

If necessary, wait for Datalab to finish launching. Datalab is ready when you see a message prompting you to do a "Web Preview".

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

## Task 3: Get API key

To get an API key:

1. In the GCP Console, on the __Navigation menu__ (![8ab244f9cffa6198.png](img/mainmenu.png)), click __APIs & Services__ and click __Library__.

2. In the search box, type __vision__ to find the __Cloud Vision API__ published by Google and click on the hyperlink.

3. Click __Enable__ if necessary.

4. Follow the same process to enable __Cloud Translation API__, __Cloud Speech API__, and __Cloud Natural Language API__, all published by Google.

5. From the GCP console menu, select __APIs and services__ and select __Credentials__.

6. If you do not already have an API key, click the __Create credentials__ button and select __API key__. Once created, copy API key and then click __Close__. You will need this API key in the notebook later.

## Task 4: Invoke ML APIs from Datalab

1. Go back to the Datalab browser and navigate to __training-data-analyst \> CPB100 \> lab4c \> mlapis.ipynb__

2. Read the commentary, Click __Clear | Clear all Cells__, then run the Python snippets (Use __Shift+Enter__ to run each piece of code) in the cell, step by step. Make sure to insert your API Key in the first Python cell.

![[/fragments/endqwiklab]]

Last Updated Date : 2019-03-06

Last Tested Date : 2019-03-06

![[/fragments/copyright]]
