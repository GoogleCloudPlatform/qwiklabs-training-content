# Invoking Machine Learning APIs


## Overview

*Duration is 1 min*


In this lab, you use Machine Learning APIs from within Datalab.

### __What you learn__

In this lab, you learn how to invoke ML APIs from Datalab and use their results.


## Introduction

*Duration is 1 min*


In this lab, you will first

* Clone the code repo within your Cloud Datalab environment

and then invoke ML APIs from Datalab to carry out some representative tasks:

* Vision API to detect text in an image
* Translate API to translate that text into English
* Natural Language API to find the sentiment of some famous quotes
* Speech API to transcribe an audio file

ML APIs are microservices. When we build ML models ourselves, it should be our goal to make them so easy to use and stand-alone.


## Enable APIs




* Ensure the __Cloud Source Repositories__ API is enabled:  [https://console.cloud.google.com/apis/library/sourcerepo.googleapis.com/?q=Repositories](https://console.cloud.google.com/apis/library/sourcerepo.googleapis.com/?q=Repositories)


## Setup


![[/fragments/start-qwiklab]]


## Launch Cloud Datalab


![[/fragments/setup-datalab]]


## Clone course repo within your Datalab instance


![[/fragments/clone-repo-in-datalab]]


## Enable APIs and Get API key

*Duration is 1 min*


To get an API key:

__Step 1__

From the GCP console menu, select __APIs and services__ and select __Library__.

__Step 2__

In the search box, type __vision__ to find the __Google Cloud Vision API__ and click on the hyperlink.

__Step 3__

Click __Enable__ if necessary.

__Step 4__

Follow the same process to enable __Translate API, Speech API, and Natural Language__ APIs.

__Step 5__

From the GCP console menu, select __APIs and services__ and select __Credentials__.

__Step 6__

If you do not already have an API key, click the __Create credentials__ button and select __API key__. Once created, click close. You will need this API key in the notebook later.


## Invoke ML APIs from Datalab

*Duration is 8 min*


__Step 1__

In the Datalab browser, navigate to __training-data-analyst \> courses \> machine\_learning \> deepdive \> 01\_googleml \> mlapis.ipynb__

<aside class="warning"><p><strong>Note</strong>: If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command ‘<strong>datalab connect mydatalabvm</strong>&#39; in your new Cloud Shell. Once connected, try the above step again.</p>
</aside>

__Step 2__

Read the commentary, then run the Python snippets (Use Shift+Enter to run each piece of code) in the cell, step by step. Make sure to insert your API Key in the first Python cell.

![[/fragments/endqwiklab]]

Last Tested Date: 12-03-2018

Last Updated Date: 12-03-2018

![[/fragments/copyright]]
