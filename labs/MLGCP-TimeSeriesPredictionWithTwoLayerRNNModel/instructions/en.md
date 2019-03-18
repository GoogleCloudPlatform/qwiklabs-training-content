# Time Series Prediction with a Two-Layer RNN Model


## Overview

*Duration is 1 min*


In this lab, you will define a Two-Layer RNN (Recurrent Neural Network) model to do time series prediction.

### __What you learn__

In this lab, you will learn how to:

* Create a Two-Layer RNN model for time series prediction
* Train and serve the model on Cloud Machine Learning Engine


## Setup



![[/fragments/start-qwiklab]]

## Create storage bucket

*Duration is 2 min*


![[/fragments/create-bucket]]


## Launch Cloud Datalab


![[/fragments/setup-datalab]]



## Clone course repo within your Datalab instance



![[/fragments/clone-repo-in-datalab]]


## Time Series Prediction with a Sequence Model

*Duration is 15 min*


The model code is packaged as a separate python module. You will first complete the model code and then switch to the notebook to set some parameters and run the training job.

__Step 1__

In Cloud Datalab, click on the __Home__ icon, and then navigate to __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 09\_sequence \> labs \> sinemodel__ and open __model.py__.

<aside class="warning"><p>Note: If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command ‘<strong>datalab connect mydatalabvm</strong>&#39; in your new Cloud Shell. Once connected, try the above step again.</p>
</aside>

__Step 2__

Scroll down to the function called *rnn2_model*. Your task is to replace the *TODO* in the code, so that this function returns predictions for an RNN with multiple layers. To construct your model, make use of either the  [LSTMCell](https://www.tensorflow.org/api\_docs/python/tf/nn/rnn\_cell/LSTMCell) or  [GRUCell](https://www.tensorflow.org/api\_docs/python/tf/nn/rnn\_cell/GRUCell) classes, the  [MultiRNNCell](https://www.tensorflow.org/api\_docs/python/tf/nn/rnn\_cell/MultiRNNCell) function, and the  [dynamic\_rnn](https://www.tensorflow.org/api\_docs/python/tf/nn/dynamic\_rnn) function.

If you need more help, you may take a look at the complete solution by navigating to : __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 09\_sequence \> sinemodel__ and open __model.py__

__Step 3__

Now that you have defined your Two-Layer RNN model, you are ready to run the training job.

In Cloud Datalab, click on the __Home__ icon, and then navigate to __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 09\_sequence__ and open __sinewaves.ipynb__.

__Step 4__

In Datalab, click on __Clear | Clear all Cells__.

__Step 5__

In the first cell, make sure to replace the project id, bucket and region with your qwiklabs project id, your bucket, and bucket region respectively.

Also, change the --model = *rnn2*  (linear is the default, be sure to change it)

__Step 6__

Now read the narrative in the following cells and execute each cell in turn.

![[/fragments/endqwiklab]]

Last Tested Date: December 13, 2018

Last Updated Date: December 14, 2018

![[/fragments/copyright]]
