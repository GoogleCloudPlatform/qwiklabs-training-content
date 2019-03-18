# Image Classification with a Deep Neural Network Model


## Overview

*Duration is 1 min*


In this lab, you will define a deep neural network model to do image classification.

### What you learn

In this lab, you will learn how to:

* Import the training dataset of MNIST handwritten images
* Reshape and preprocess the image data
* Setup your neural network model with 10 classes (one for each possible digit 0 through 9)
* Define and create your EstimatorSpec in tensorflow to create your custom estimator
* Define and run your train_and_evaluate function to train against the input dataset of 60,000 images and evaluate your model's performance


## Setup


![[/fragments/start-qwiklab]]


## Create Storage Bucket

*Duration is 2 min*


![[/fragments/create-bucket]]


## Launch Cloud Datalab


![[/fragments/setup-datalab]]


## Clone course repo within your Datalab instance


![[/fragments/clone-repo-in-datalab]]

## MNIST Image Classification

*Duration is 15 min*


This lab is organised a little different from lab 1 (linear model). The model code is packaged as a separate python module. You will first complete the model code and then switch to the notebook to set some parameters and run the training job.

__Step 1__

In Cloud Datalab, click on the __Home__ icon, and then navigate to __datalab \> notebooks \> training-data-analyst \> courses \> machine_learning \> deepdive \> 08\_image \> labs \> mnistmodel \> trainer__ and open __model.py__.

<aside class="warning"><p>Note: If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command ‘<strong>datalab connect mydatalabvm</strong>&#39; in your new Cloud Shell. Once connected, try the above step again.</p>
</aside>

__Step 2__

Scroll down to *dnn_model* where you have to replace the #TODO with code to define this dnn model.

If you need more help, you may take a look at the complete solution by navigating to : __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 08\_image \> mnistmodel \> trainer__ and open __model.py__

__Step 3__

Now that you have defined your dnn_model, you are ready to run the training job.

In Cloud Datalab, click on the __Home__ icon, and then navigate to __datalab \> notebooks \> training-data-analyst \> courses \> machine_learning \> deepdive \> 08\_image \> labs__ and open __mnist\_models.ipynb__.

__Step 4__

In Datalab, click on __Clear | Clear all Cells__.

__Step 5__

In the first cell, make sure to replace the project id, bucket and region with your qwiklabs project id, your bucket, and bucket region respectively. Also, change the MODEL_TYPE to *dnn*.

__Step 6__

Now read the narrative in the following cells and execute each cell in turn.

![[/fragments/endqwiklab]]

Last Tested Date: 12-12-2018

Last Updated Date: 12-18-2018

![[/fragments/copyright]]
