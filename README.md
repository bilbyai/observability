# Data Observability on Elastic and Kibana

This repo provides information about our data observability dashboards that
monitor, explore, and ensure the quality of our data pipelines built on Elastic
and Kibana.

## Overview

Our observability solution consists of three dashboards designed to provide
visibility into our infra:

| Dashboard                                                                                                                                                                                                                                 | Documentation Link                                                                   | Purpose                                      | Description                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | -------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| [Pipeline Health](<https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/dashboards#/view/7770cea6-8100-4b25-ac13-be8f265624ad?_g=(filters:!(),refreshInterval:(pause:!t,value:60000),time:(from:now-2w,to:now))>)  | [Documentation](https://github.com/bilbyai/observability/tree/main/pipeline-health)  | Quickly see the status of our pipelines.     | This dashboard answers the critical question within 30 seconds: "Is the pipeline running ok?"                  |
| Data QA                                                                                                                                                                                                                                   | (This dashboard is not yet implemented)                                              | Determine the quality of our data pipelines. | This dashboard will help answer: "Is the data produced by the pipeline ok?"                                    |
| [Data Exploration](<https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/dashboards#/view/8288744a-964d-46c0-af9e-749ddea5ff51?_g=(filters:!(),refreshInterval:(pause:!t,value:60000),time:(from:now-4w,to:now))>) | [Documentation](https://github.com/bilbyai/observability/tree/main/data-exploration) | Explore and understand our data.             | Get insights into data patterns, distributions, and characteristics to answer: "What does the data look like?" |
| [Kibana Discover](https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/discover#/)                                                                                                                                 | [Documentation](https://github.com/bilbyai/observability/tree/main/kibana-discover)  | For in-depth investigations                  | This is used to find specific data points via filters.                                                         |

> 🚨 For in-depth investigations, please use
> [Kibana Discover](https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/discover#/)
> to directly query the data.

### 1. ⚠️ Pipeline Health Dashboard

Monitor the operational status of your data pipelines in real-time.

This dashboard answers the critical question: "Is the pipeline running ok?"

### 2. 🎯 Data QA Dashboard (Coming Soon)

Ensure data quality by validating the output of your pipelines.

This dashboard will help answer: "Is the data produced by the pipeline ok?"

### 3. 📊 Data Exploration Dashboard

Explore and understand your data through interactive visualizations. Get
insights into data patterns, distributions, and characteristics to answer: "What
does the data look like?"

### 4. 🔍 Kibana Discover

For detailed data exploration and custom queries, use
[Kibana Discover](https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/discover#/)
to directly search and analyze your data.

## Architecture

We've decided to go with Elasticsearch and Kibana for the observability stack.
This allows us to create visualizations with our date pretty easily, and data
analysts and non-technical users can build visualizations on their own without
needing to think about data pipeline and infrastructure.

## Contributing

Please refer to individual dashboard documentation for specific implementation
details, as shown above.

If you'd like to build your own dashboard, please feel free! Tell us about it!
