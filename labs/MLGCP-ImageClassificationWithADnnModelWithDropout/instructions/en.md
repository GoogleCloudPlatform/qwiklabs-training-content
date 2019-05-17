# Image Classification with a DNN Model with Dropout


## Overview

*Duration is 1 min*


In this lab, you will define a DNN with dropout on MNIST to do image classification.

### __What you learn__

In this lab, you will learn how to:

* Import the training dataset of MNIST handwritten images
* Reshape and preprocess the image data
* Setup your neural network model with 10 classes (one for each possible digit 0 through 9)
* Add a Dropout layer
* Define and create your EstimatorSpec in tensorflow to create your custom estimator
* Define and run your train\_and\_evaluate function to train against the input dataset of 60,000 images and evaluate your model's performance


## Setup


![[/fragments/start-qwiklab]]


## Create storage bucket and store data file

*Duration is 2 min*


Create a bucket using the GCP console:

__Step 1__

In your GCP Console, click on the __Navigation menu__ (![menu.png](/images/menu.png)), and select __Storage__.


__Step 2__

Click on __Create bucket__.

__Step 3__

Choose a Regional bucket and set a unique name (use your project ID because it is unique).

__Step 4__

For location, select from the following: `europe-west1, us-central1, us-east1`

__Step 5__

Click __Create__.


## Launch Cloud Datalab


![[/fragments/setup-datalab]]


## Clone course repo within your Datalab instance


![[/fragments/clone-repo-in-datalab]]


## MNIST Image Classification

*Duration is 15 min*


This lab uses the same files as lab 2 (dnn model). The model code is packaged as a separate python module. You will first complete the model code and then switch to the notebook to set some parameters and run the training job.

__Step 1__

In Cloud Datalab, click on the __Home__ icon, and then navigate to __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 08\_image \> labs \> mnistmodel \> trainer__ and open __model.py__.

<aside class="warning"><p><strong>Note:</strong> If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command ‘<strong>datalab connect mydatalabvm</strong>&#39; in your new Cloud Shell. Once connected, try the above step again.</p>
</aside>

__Step 2__

Scroll down to *dnn\_dropout\_model* where you have to replace the *#TODO* with code to define this dnn model with dropout.

If you need more help, you may take a look at the complete solution by navigating to : __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 08\_image \> mnistmodel \> trainer__ and open __model.py__.

__Step 3__

Now that you have defined your dnn\_dropout\_model, you are ready to run the training job.

In Cloud Datalab, click on the __Home__ icon, and then navigate to __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 08\_image \> labs__ and open __mnist\_models.ipynb__.

__Step 4__

In Datalab, click on __Clear | Clear all Cells__.

__Step 5__

In the first cell, make sure to replace the project ID, bucket and region with your Qwiklabs project ID, your bucket, and bucket region respectively. Also, change the MODEL\_TYPE to *dnn\_dropout*.

__Step 6__

Now read the narrative in the following cells and execute each cell in turn.

![[/fragments/endqwiklab]]

Last Tested Date: 05-01-2019

Last Updated Date: 05-01-2019

![[/fragments/copyright]]
