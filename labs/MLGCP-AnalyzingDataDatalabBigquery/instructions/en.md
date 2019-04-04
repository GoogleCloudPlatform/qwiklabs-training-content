# Analyzing data using Datalab and BigQuery


## Overview

*Duration is 1 min*


In this lab you analyze a large (70 million rows, 8 GB) airline dataset using Google BigQuery and Cloud Datalab.

### __What you learn__

In this lab, you:

* Launch Cloud Datalab
* Invoke a BigQuery query
* Create graphs in Datalab

This lab illustrates how you can carry out data exploration of large datasets, but continue to use familiar tools like Pandas and Juypter. The "trick" is to do the first part of your aggregation in BigQuery, get back a Pandas dataset and then work with the smaller Pandas dataset locally.  Cloud Datalab provides a managed Jupyter experience, so that you don't need to run notebook servers yourself.


## Setup

![[/fragments/start-qwiklab]]

## Launch Cloud Datalab

![[/fragments/setup-datalab]]

## Enable APIs


* Ensure the __Cloud Source Repositories__ API is enabled:  [https://console.cloud.google.com/apis/library/sourcerepo.googleapis.com/?q=Repositories](https://console.cloud.google.com/apis/library/sourcerepo.googleapis.com/?q=Repositories)


## Invoke BigQuery




To invoke a BigQuery query:

__Step 1__

Navigate to the BigQuery console by selecting __Navigation menu > BigQuery__ from the top-left-corner (![7a91d354499ac9f1.png](img/7a91d354499ac9f1.png)) menu and click __Done__.


__Step 2__

In __More__ dropdown click __Query Settings__.

Under __Additional Settings__ ensure that the __Legacy__ is NOT selected (we will be using Standard SQL).

__Step 3__

In the query textbox, type:

```sql
#standardSQL
SELECT
  departure_delay,
  COUNT(1) AS num_flights,
  APPROX_QUANTILES(arrival_delay, 5) AS arrival_delay_quantiles
FROM
  `bigquery-samples.airline_ontime_data.flights`
GROUP BY
  departure_delay
HAVING
  num_flights > 100
ORDER BY
  departure_delay ASC
```

Click __Run__.

What is the median arrival delay for flights left 35 minutes early?

(Answer: the typical flight that left 35 minutes early arrived 28 minutes early.)


__Step 4 (Optional)__

Can you write a query to find the airport pair (departure and arrival airport) that had the maximum number of flights between them?

__Hint:__ you can group by multiple fields.

One possible answer:

```sql
#standardSQL
SELECT
  departure_airport,
  arrival_airport,
  COUNT(1) AS num_flights
FROM
  `bigquery-samples.airline_ontime_data.flights`
GROUP BY
  departure_airport,
  arrival_airport
ORDER BY
  num_flights DESC
LIMIT
  10
```


## Draw graphs in Cloud Datalab




__Step 1__

In Cloud Datalab home page (browser), navigate into __notebooks__.  You should now be in __datalab/notebooks/__.

__Step 2__

Start a new notebook by clicking on the __+Notebook__ icon.  Rename the notebook to be __flights__.

__Step 3__

In a cell in Datalab, type the following, then click __Run__.

```python
query="""
SELECT
  departure_delay,
  COUNT(1) AS num_flights,
  APPROX_QUANTILES(arrival_delay, 10) AS arrival_delay_deciles
FROM
  `bigquery-samples.airline_ontime_data.flights`
GROUP BY
  departure_delay
HAVING
  num_flights > 100
ORDER BY
  departure_delay ASC
"""

import google.datalab.bigquery as bq
df = bq.Query(query).execute().result().to_dataframe()
df.head()
```

Note that we have gotten the results from BigQuery as a Pandas dataframe.

In what Python data structure are the deciles in?

__Step 4__

In the next cell in Datalab, type the following, then click __Run__.

```python
import pandas as pd
percentiles = df['arrival_delay_deciles'].apply(pd.Series)
percentiles = percentiles.rename(columns = lambda x : str(x*10) + "%")
df = pd.concat([df['departure_delay'], percentiles], axis=1)
df.head()
```

What has the above code done to the columns in the Pandas DataFrame?

__Step 5__

In the next cell in Datalab, type the following, then click __Run__.

```python
without_extremes = df.drop(['0%', '100%'], 1)
without_extremes.plot(x='departure_delay', xlim=(-30,50), ylim=(-50,50));
```

Suppose we were creating a machine learning model to predict the arrival delay of a flight. Do you think departure delay is a good input feature? Is this true at all ranges of departure delays?

__Hint__: Try removing the xlim and ylim from the plotting command.


## Cleanup (Optional)




__Step 1__

You could leave Datalab instance running until your class ends. The default machine type is relatively inexpensive. However, if you want to be frugal, you can stop and restart the instance between labs or when you go home for the day.  To do so, follow the next two steps.

__Step 2__

Click on the person icon in the top-right corner of your Datalab window and click on the button to __STOP VM__.

__Step 3__

You are not billed for stopped VMs. Whenever you want to restart Datalab, open Cloud Shell and type in:

```bash
datalab connect mydatalabvm
```

This will restart the virtual machine and launch the Docker image that runs Datalab.


## Summary




In this lab, you learned how to carry out data exploration of large datasets using BigQuery, Pandas, and Juypter. The "trick" is to do the first part of your aggregation in BigQuery, get back a Pandas dataset and then work with the smaller Pandas dataset locally.  Cloud Datalab provides a managed Jupyter experience, so that you don't need to run notebook servers yourself.

![[/fragments/endqwiklab]]

##### Manual Last Updated: Marc 27, 2019

##### Lab Last Tested: March 27, 2019

![[/fragments/copyright]]
