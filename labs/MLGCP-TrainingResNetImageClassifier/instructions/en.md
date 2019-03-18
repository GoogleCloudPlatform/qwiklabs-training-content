# Training a ResNet Image Classifier from Scratch using TPUs and Cloud MLE


## Overview:




In this lab, you will train a state-of-the-art image classification model on your own data using Google's Cloud TPUs from CloudShell. Please read  [this blog post](https://cloud.google.com/blog/big-data/2018/07/how-to-train-a-resnet-image-classifier-from-scratch-on-tpus-on-cloud-ml-engine) for more background.

### What you learn

In this lab, you learn how to:

* Convert JPEG files into TensorFlow records
* Train a ResNet image classifier
* Deploy the trained model as a web service
* Invoke the web service by sending it a JPEG image

The total cost to run this lab on Google Cloud is about $3.


## A brief primer on ResNet and TPUs




The more layers you have in a neural network, the more accurate it should be at image classification. However, deep neural networks are harder to train -- in practice, this difficulty overwhelms the optimization algorithm and so, as you increase the number of layers, the training error starts to increase. One way to address this optimization problem is to introduce a "shortcut" connection that does an identity mapping and ask the optimizer to focus on the residual (or difference):

![b379c97ff0377d93.png](img/b379c97ff0377d93.png)

*Image from * [Deep Residual Learning for Image Recognition](https://arxiv.org/abs/1512.03385)

A neural network consisting of such blocks turns out to be easier to train even if it has just as many layers as a deep neural network without the shortcut connections. Such deep residual networks swept the field of image and object recognition competitions and are now considered state-of-the-art models for image analysis tasks.

Tensor Processing Units (TPUs) are application-specific integrated circuit (ASIC) hardware accelerators for machine learning. They were custom-designed by Google to carry out TensorFlow operations and can provide significant speedups in machine learning tasks that are compute-bound (rather than I/O bound). Training deep residual networks for image classification is one such task. In  [independent tests conducted by Stanford University](https://dawn.cs.stanford.edu/benchmark/), the ResNet-50 model trained on a TPU was the fastest to achieve a desired accuracy on a standard datasets\[1\]. If you use TPUs on serverless infrastructure as Cloud ML Engine, this also translates to lower cost, since you pay only for what you use and don't have to keep any machines up and running.

![2a62e08cede0f5b6.png](img/2a62e08cede0f5b6.png)

*TPUs can speed up training of state-of-the-art models.*

### Test your understanding:

1. ResNet has a repeating structure of blocks that include \_\_\_\_.
2. TPUs are custom designed to carry out \_\_\_\_ operations efficiently.
3. It's a good idea to use TPUs on machine learning tasks that are I/O bound. True or False?
4. TPUs provide the fastest, most cost-effective way to train state-of-the-art image models. True or False?

### Answers to "Test your understanding":

1. Shortcut connections that do identity mapping and residual layers that are trainable.
2. TensorFlow.
3. No. It's not a good idea to have your TPU waiting for data. Use a slower processor (CPU or GPU) for such tasks. Examples of ML tasks that are I/O bound include the relatively shallow networks (3-4 layers) with millions of input nodes that are common in recommendation systems.
4. True.


## Setup


![[/fragments/start-qwiklab]]


## Setup your environment




![[/fragments/cloudshell]]

## Enable the Cloud Machine Learning Engine API

Navigate to  [https://console.cloud.google.com/apis/library](https://console.cloud.google.com/apis/library), search for __Cloud Machine Learning Engine__ and click on ENABLE button if it is not already enabled.

## Enable the Dataflow API

Navigate to  [https://console.cloud.google.com/apis/library](https://console.cloud.google.com/apis/library), search for __Dataflow API__ and click on ENABLE button if it is not already enabled.

## Clone repository

In CloudShell, type:

```
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
```


## Explore data




![7221191ec60f55f6.png](img/7221191ec60f55f6.png)

[Sunflowers](https://www.flickr.com/photos/calliope/1008566138/)* by Liz West is licensed under * [CC BY 2.0](https://creativecommons.org/licenses/by/2.0/)

You have about 3,600 flower images in five categories. The images are randomly split into a training set with 90% data and an evaluation set with 10% data listed in CSV files:

* Training set:  [train\_set.csv](https://storage.cloud.google.com/cloud-ml-data/img/flower\_photos/train\_set.csv)
* Evaluation set:  [eval\_set.csv](https://storage.cloud.google.com/cloud-ml-data/img/flower\_photos/eval\_set.csv)

Let's explore the format and contents of these files.

__Step 1: Explore train.csv__

In CloudShell, type:

```
gsutil cat gs://cloud-ml-data/img/flower_photos/train_set.csv | head -5 > /tmp/input.csv
cat /tmp/input.csv
```

What's the format of the file? \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

How would you find all the types of flowers in the training dataset? \_\_\_\_\_\_\_\_\_\_\_\_\_

Answer: it's a comma-separated file. The first field is the GCS location of the image file, and the second field is the label. In this case, the label is the type of flower. See Step 2 for one possible answer to the second question.

__Step 2: Find dictionary of labels__

The set of all the labels is called the dictionary.

```
gsutil cat gs://cloud-ml-data/img/flower_photos/train_set.csv  | sed 's/,/ /g' | awk '{print $2}' | sort | uniq > /tmp/labels.txt
cat /tmp/labels.txt
```

What does label=3 correspond to? \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Answer: The label file is used to translate labels into internal ID numbers in the following processes such as daisy=0, dandelion=1, etc. (it is 0-based). So, label=3 would correspond to sunflowers. The code extracts the second field out of the CSV file and determines the unique list.

__Step 3: View image__

Because this Google Cloud Storage bucket is public, you can view the images using http. An GCS URI such as:

gs://cloud-ml-data/img/flower\_photos/daisy/754296579\_30a9ae018c\_n.jpg

is published on http as:

[https://storage.cloud.google.com/cloud-ml-data/img/flower\_photos/daisy/754296579\_30a9ae018c\_n.jpg](https://storage.cloud.google.com/cloud-ml-data/img/flower\_photos/daisy/754296579\_30a9ae018c\_n.jpg)

Click on the above link to view the image. What type of flower is it? \_\_\_\_\_\_\_\_\_\_\_

Answer: This is the first line of the train\_set.csv, and the label states that it is a daisy. I hope that is correct!


## Convert JPEG images to TensorFlow records




We do not want our training to be limited by I/O speed, so let's convert the JPEG image data into TensorFlow records. These are an efficient format particularly suitable for batch reads by the machine learning framework.

The conversion will be carried in Cloud Dataflow, the serverless ETL service on Google Cloud Platform.

__Step 1: Get ResNet code__

In CloudShell, type:

```
cd ~/training-data-analyst/quests/tpu
bash ./copy_resnet_files.sh 1.9
```

The 1.9 refers to the version of TensorFlow.

__Step 2: Examine what has been copied over__

In CloudShell, type:

```
ls mymodel/trainer
```

Notice that ResNet model code has been copied over from  [https://github.com/tensorflow/tpu/tree/master/models/official/resnet](https://github.com/tensorflow/tpu/tree/master/models/official/resnet)

There are a number of other pre-built models for various other tasks in that repository.

__Step 3: Create an output bucket for holding the TensorFlow records__

From the GCP navigation menu, go to __Storage \> Browser__ and create a new bucket. Bucket names have to be unique, but the UI will tell you if a bucket name has already been taken.

__Step 4: Set BUCKET environment variable__

Specify an environment variable for your bucket name and for your project id.

```
export BUCKET=<BUCKET>
export PROJECT=$(gcloud config get-value project)
echo $BUCKET $PROJECT
```

__Step 5: Install the Apache Beam Python package__

In CloudShell, type:

```
sudo pip install 'apache-beam[gcp]'
```

Apache Beam is the open-source library for code that is executed by Cloud Dataflow.

__Step 6: Run the conversion program__

In CloudShell, type:

```
export PYTHONPATH=${PYTHONPATH}:${PWD}/mymodel
gsutil -m rm -rf gs://${BUCKET}/tpu/resnet/data
python -m trainer.preprocess \
       --train_csv gs://cloud-ml-data/img/flower_photos/train_set.csv \
       --validation_csv gs://cloud-ml-data/img/flower_photos/eval_set.csv \
       --labels_file /tmp/labels.txt \
       --project_id $PROJECT \
       --output_dir gs://${BUCKET}/tpu/resnet/data
```

__Step 7: Wait for the Dataflow job to finish__

Navigate to  [https://console.cloud.google.com/dataflow](https://console.cloud.google.com/dataflow) and look at the submitted jobs. Wait for the recently submitted job to finish. This will take 15-20 minutes.


## Train model




__Step 1: Verify that the TensorFlow records exist__

In CloudShell, type:

```
gsutil ls gs://${BUCKET}/tpu/resnet/data
```

What files are present? \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Answer: You should see train-\* and validation-\* files. If no files are present, wait for the Dataflow job in the previous section to finish.

__Step 2: Enable the Cloud TPU account__

In CloudShell, type:

```
bash enable_tpu_mlengine.sh
```

__Step 3: Submit the training job:__

In CloudShell, type:

```
TOPDIR=gs://${BUCKET}/tpu/resnet
REGION=us-central1
OUTDIR=${TOPDIR}/trained
JOBNAME=imgclass_$(date -u +%y%m%d_%H%M%S)
echo $OUTDIR $REGION $JOBNAME
gsutil -m rm -rf $OUTDIR  # Comment out this line to continue training from the last time
gcloud ml-engine jobs submit training $JOBNAME \
 --region=$REGION \
 --module-name=trainer.resnet_main \
 --package-path=$(pwd)/mymodel/trainer \
 --job-dir=$OUTDIR \
 --staging-bucket=gs://$BUCKET \
 --scale-tier=BASIC_TPU \
 --runtime-version=1.9 \
 -- \
 --data_dir=${TOPDIR}/data \
 --model_dir=${OUTDIR} \
 --resnet_depth=18 \
 --train_batch_size=128 --eval_batch_size=32 --skip_host_call=True \
 --steps_per_eval=250 --train_steps=1000 \
 --num_train_images=3300  --num_eval_images=370  --num_label_classes=5 \
 --export_dir=${OUTDIR}/export
```

Please see  [this blog post](https://cloud.google.com/blog/big-data/2018/07/how-to-train-a-resnet-image-classifier-from-scratch-on-tpus-on-cloud-ml-engine) for more details about what this command is doing, and what things you can change.

__Step 4: Wait for the ML Engine job to finish__

Navigate to  [https://console.cloud.google.com/mlengine](https://console.cloud.google.com/mlengine) and look at the submitted jobs. Wait for the recently submitted job to finish. This will take 15-20 minutes.


## Examine training outputs




__Step 1: View training graph__

In CloudShell, launch TensorBoard by typing in:

```
tensorboard --logdir gs://${BUCKET}/tpu/resnet/trained --port=8080
```

__Step 2: Open TensorBoard__

From the __Web Preview__ menu at the top of CloudShell, select __Preview on Port 8080__.

![aab2c519c5686f61.png](img/aab2c519c5686f61.png)

As your models get larger, and you export more checkpoints, you may need to wait 1-2 minutes for TensorBoard to load the data.

__Step 3: View training graph__

Change to scalar graphs and view the loss and top\_1\_accuracy plots.

Does the loss curve show that the train loss has plateaued? \_\_\_\_\_\_\_\_\_\_\_\_\_

Does the evaluation loss indicate overfitting? \_\_\_\_\_\_\_\_\_\_\_\_

Is the top\_1\_accuracy sufficient? \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

How would you use the answers to the above questions?

Answers:

If the loss curve has not plateaued, re-run the training job for more training steps. Make sure you are not deleting the output directory, so that the training commences from the previous point.

![45a6dfedd82cf324.png](img/45a6dfedd82cf324.png)

If the evaluation loss (blue curve) is much higher than the training loss (orange curve), especially if the evaluation loss starts to increase, stop training (do an early-stop), reduce the ResNet model depth, or increase the size of your datasets.

If the top\_1\_accuracy is insufficient, increase the size of your dataset.

![dfb2993675727a79.png](img/dfb2993675727a79.png)


## Deploy model




__Step 1: View exported model__

In CloudShell, hit __Ctrl+C__ if necessary to get back to the command prompt and type:

```
gsutil ls gs://${BUCKET}/tpu/resnet/trained/export/
```

__Step 2: Deploy trained model as a web service__

In CloudShell, type:

```
MODEL_NAME="flowers"
MODEL_VERSION=resnet
MODEL_LOCATION=$(gsutil ls gs://${BUCKET}/tpu/resnet/trained/export/ | tail -1)
echo "Deleting and deploying $MODEL_NAME $MODEL_VERSION from $MODEL_LOCATION ... this will take a few minutes"
gcloud ml-engine models create ${MODEL_NAME} --regions $REGION
gcloud ml-engine versions create ${MODEL_VERSION} --model ${MODEL_NAME} --origin ${MODEL_LOCATION} --runtime-version=1.9
```

This will take 4-5 minutes.


## Invoke the model




In CloudShell, type:

```
python invoke_model.py  --project=$PROJECT --jpeg=gs://cloud-ml-data/img/flower_photos/sunflowers/1022552002_2b93faf9e7_n.jpg
```

The first image will take about a minute as service loads. Subsequent calls will be faster. Try other images.


## Clean up




When you take a lab, all of your resources will be deleted for you when you're finished. But in the real world, you need to do it yourself to avoid incurring charges.

![[/fragments/endqwiklab]]

Manual Last Updated: January 18, 2019

Lab Last Tested: January 9, 2019

![[/fragments/copyright]]
