# Using pre-trained embeddings with TensorFlow Hub


## Overview

*Duration is 1 min*


In this lab, you will build a model using pre-trained embeddings from TensorFlow hub.

TensorFlow Hub is a library for the publication, discovery, and consumption of reusable parts of machine learning models. A module is a self-contained piece of a TensorFlow graph, along with its weights and assets, that can be reused across different tasks in a process known as transfer learning, which we covered as part of the course on Image Models.

### __What you learn__

In this lab, you will learn how to:

* How to instantiate a TensorFlow Hub module
* How to find pre-trained TensorFlow Hub modules for a variety of purposes
* How to examine the embeddings of a Hub module
* How one Hub module composes representations of sentences from individual words
* How to assess word embeddings using a semantic similarity test


## Setup


![[/fragments/start-qwiklab]]


## Create storage bucket

*Duration is 2 min*

![[/fragments/create-bucket]]


## Launch Cloud Datalab


![[/fragments/setup-datalab]]


## Clone course repo within your Datalab instance



![[/fragments/clone-repo-in-datalab]]

## Using pre-trained embeddings with TensorFlow Hub

*Duration is 15 min*


__Step 1__

In Cloud Datalab, click on the __Home__ icon, and then navigate to __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 09\_sequence \> labs__ and open __reusable-embeddings.ipynb__.

<aside class="warning"><p><strong>Note</strong>: If the cloud shell used for running the datalab command is closed or interrupted, the connection to your Cloud Datalab VM will terminate. If that happens, you may be able to reconnect using the command ‘<strong>datalab connect mydatalabvm</strong>&#39; in your new Cloud Shell. Once connected, try the above step again.</p>
</aside>

__Step 2__

Read through the assignment steps required in the first notebook cell and complete them in your notebook.

If you need more help, you may take a look at the complete solution by navigating to : __datalab \> notebooks \> training-data-analyst \> courses \> machine\_learning \> deepdive \> 09\_sequence__  and open __reusable-embeddings.ipynb__.

![[/fragments/endqwiklab]]

Last Tested Date: December 14, 2018

Last Updated Date: December 14, 2018

![[/fragments/copyright]]
