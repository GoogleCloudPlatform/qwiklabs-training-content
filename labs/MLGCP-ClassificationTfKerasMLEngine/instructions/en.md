# Text Classification using TensorFlow/Keras on Cloud ML Engine


## Overview

*Duration is 1 min*


In this lab, you will define a text classification model to look at the titles of articles and figure out whether the article came from the New York Times, TechCrunch or GitHub.

### __What you learn__

In this lab, you will learn how to:

* Creating datasets for Machine Learning using BigQuery
* Creating a text classification model using the Estimator API with a Keras model
* Training on Cloud ML Engine
* Deploying the model
* Predicting with model
* Rerun with pre-trained embedding

## Setup


![[/fragments/start-qwiklab]]


## Create Storage Bucket

*Duration is 2 min*


![[/fragments/create-bucket]]


## Launch Cloud Datalab


![[/fragments/setup-datalab]]


## Clone course repo within your Datalab instance


![[/fragments/clone-repo-in-datalab]]


## Building a Sequence Model for Text Classification

*Duration is 15 min*


The model code is packaged as a separate python module. You will first complete the model code and then switch to the notebook to set some parameters and run the training job.

__Step 1__

In Cloud Datalab, click on the Home icon, and then navigate to __datalab \> notebooks  \> training-data-analyst \> courses \> machine\_learning  \> deepdive  \> 09\_sequence  \> labs__ and open __text\_classification.ipynb__.

<aside class="warning"><p>Note: If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command ‘<strong>datalab connect mydatalabvm</strong>&#39; in your new Cloud Shell. Once connected, try the above step again.</p>
</aside>

__Step 2__

Read through the assignment steps required in the first notebook cell and complete them in your notebook.

Be sure to complete the *\#TODO*s in the companion model.py notebook found in __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 09\_sequence \> labs \> txtclsmodel \> trainer \> model.py__.

If you need more help, you may take a look at the complete solution by navigating __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 09\_sequence \> txtclsmodel \> trainer \> model.py__.

![[/fragments/endqwiklab]]

Last Tested Date: 12-13-2018

Last Updated Date: 12-18-2018

![[/fragments/copyright]]
