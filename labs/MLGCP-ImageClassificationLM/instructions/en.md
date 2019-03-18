# Image Classification with a Linear Model


## Overview

*Duration is 1 min*


In this lab, you will define a simple linear image model on MNIST using the Estimator API to do image classification.

### __What you learn__

In this lab, you will learn how to:

* Import the training dataset of MNIST handwritten images
* Reshape and preprocess the image data
* Setup your linear classifier model with 10 classes (one for each possible digit 0 through 9)
* Define and create your EstimatorSpec in tensorflow to create your custom estimator
* Define and run your train\_and\_evaluate function to train against the input dataset of 60,000 images and evaluate your model's performance


## Setup


![[/fragments/start-qwiklab]]


## Launch Cloud Datalab


![[/fragments/setup-datalab]]


## Clone course repo within your Datalab instance


![[/fragments/clone-repo-in-datalab]]


## MNIST Image Classification using a linear model

*Duration is 15 min*


__Step 1__

In Cloud Datalab, click on the __Home__ icon, and then navigate to __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 08\_image \> labs__ and open __mnist\_linear.ipynb__.

<aside class="warning"><p>Note: If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command ‘<strong>datalab connect mydatalabvm</strong>&#39; in your new Cloud Shell. Once connected, try the above step again.</p>
</aside>

__Step 2__

In Datalab, click on __Clear | Clear all Cells__. Now read the narrative and execute each cell in turn:

* Some lab tasks include starter code. In such cells, look for lines marked *\#TODO*. Specifically, you need to write code to define the *linear\_model* and  the *eval\_input\_fn* function.
* If you need more help, you may take a look at the complete solution by navigating to : __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 08\_image__ and open the notebook: __mnist\_linear.ipynb__

<aside class="warning"><p>Note: When doing copy/paste of python code, please be careful about indentation</p>
</aside>

![[/fragments/endqwiklab]]

Last Tested Date: 12-12-2018

Last Updated Date: 12-18-2018

![[/fragments/copyright]]
