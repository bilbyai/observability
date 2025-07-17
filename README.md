# Data Observability on Elastic and Kibana

This project provides (the first iteration of) data observability dashboards built on Elastic and Kibana to monitor, explore, and ensure the quality of our data pipelines.

## Overview

Our observability solution consists of three key dashboards designed to provide complete visibility into your data infrastructure:

| Dashboard        | Purpose                                                              | Description                                                                                                    |
| ---------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Pipeline Health  | Monitor the operational status of your data pipelines in real-time.  | This dashboard answers the critical question: "Is the pipeline running ok?"                                    |
| Data QA          | Ensure data quality by validating the output of your pipelines.      | This dashboard will help answer: "Is the data produced by the pipeline ok?"                                    |
| [Data Exploration](https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/dashboards#/view/8288744a-964d-46c0-af9e-749ddea5ff51?_g=(filters:!(),refreshInterval:(pause:!t,value:60000),time:(from:now-4w,to:now))) | Explore and understand your data through interactive visualizations. | Get insights into data patterns, distributions, and characteristics to answer: "What does the data look like?" |

### 1. Pipeline Health Dashboard

Monitor the operational status of your data pipelines in real-time. This dashboard answers the critical question: "Is the pipeline running ok?"

### 2. Data QA Dashboard (Coming Soon)

Ensure data quality by validating the output of your pipelines. This dashboard will help answer: "Is the data produced by the pipeline ok?"

### 3. Data Exploration Dashboard

Explore and understand your data through interactive visualizations. Get insights into data patterns, distributions, and characteristics to answer: "What does the data look like?"

## Getting Started

Each dashboard comes with its own detailed documentation:

- [Pipeline Health Dashboard](./dashboards/pipeline-health/README.md)
- [Data Exploration Dashboard](./dashboards/data-exploration/README.md)
- Data QA Dashboard - Documentation coming soon

## Prerequisites

- Elasticsearch 7.x or higher
- Kibana 7.x or higher
- Data pipelines configured to send metrics to Elasticsearch

## Architecture

The observability stack leverages Elasticsearch's powerful indexing and search capabilities combined with Kibana's visualization features to provide real-time insights into your data infrastructure.

## Contributing

Please refer to individual dashboard documentation for specific implementation details and contribution guidelines.
