# Pipeline Health Dashboard

## Overview

The Pipeline Health Dashboard provides operational monitoring of our data
pipeline infrastructure. It's designed to answer the critical question **"Is the
pipeline running ok?"** within 30 seconds of viewing.

![pipeline structure](https://github.com/bilbyai/observability/blob/main/pipeline-health/screenshots/structure.png?raw=true)

The dashboard follows a hierarchical information architecture:

- **Top to Bottom**: From critical metrics to granular details (Level 1, Level
  2, Level 3)
- **Left to Right**: Following the pipeline's data flow stages
- **Color Coding**: 🟢 Green for healthy, 🟡 Yellow for warning, 🔴 Red for
  critical

Levels (Top to Bottom) are defined as follows:

- **Level 1**: Critical Health Indicators
- **Level 2**: Component Performance
- **Level 3**: Detailed Analysis (Kibana Discover)

## Using the Dashboard

### Quick Health Check (30 seconds)

1. Check Level 1 metrics - all should be green or near 100%
2. Any red/orange metrics indicate immediate attention needed
3. Note the "Last Scraper Run" time - should be within expected intervals

### Troubleshooting Issues (2-5 minutes)

1. Identify problematic metrics in Level 1
2. Navigate to corresponding Level 2 section for component details
3. Use Level 2 visualizations to identify specific sources or time periods

### Deep Dive Analysis

For detailed investigation, click the Kibana Discover in the sidebar to access
raw data and perform custom queries.

## Dashboard Structure

### Level 1: Critical Health Indicators (Top Section)

The top section displays the most critical metrics that determine overall
pipeline health:

#### Scraping Metrics

- **Last Scraper Run**: Time since the last successful scraper execution. This
  number may lag behind the actual time since the last scraper run, because the
  BigQuery to Elastic sync only happens once a day. This is OK, because a 1 day
  lag is considered acceptable.

#### Text Operations Metrics

- **Summary Generation Ratio**: Percentage of documents with generated summaries
  (Target: 100%)
- **Baidu Sentiment Ratio**: Coverage of sentiment analysis (Target: 100%)
- **Translation Rate**: Percentage of documents successfully translated (Target:
  100%)

##### Explanation of Translation Rate

To see which documents need to be translated, we use the following formula:

$$
\text{field}\ \wedge\ \lnot\text{field\\_en}
$$

This is the same as:

$$
\text{field}\ AND\ NOT\ \texttt{field\\_en}
$$

in KQL, this is: `field:* AND NOT field_en:*`.

In plain english, we are looking for documents that have the field that needs to
be translated, but does not have the English translation of that field.

For example, if the document has a `title` field, but the English translation of
that field, `title_en`, is not present, then the document is considered to be
missing a translation.

> 📣 If the original language field is null, then there is nothing to be
> translated, so it is considered to be okay. However, this means that if the
> document is missing that field in the first place, that may be an issue with
> upstream scrapers.

#### In-House ML Inference Metrics

- **In-House ML Inference Rate**: Coverage of ML predictions (Target: 100%)

> 📒 TODO: add v2 models.

### Level 2: Component Performance (Middle Section)

Provides more detailed breakdowns of each pipeline stage:

#### Scraping Performance

- **Scraper Triggers**: Weekly trigger count and success rate
- **Document Throughput**: Weekly document processing volume and rate
- **Component Status**: Individual scraper and DAG health indicators (Data not
  yet available)

#### Text Operations Performance

The Level 2 metrics for text operations and translation are split by news line.

#### In-House ML Inference Performance

The Level 2 metrics for in-house ML inference are split by model.

We currently have 4 in-house ML models:

- **Sentiment**
- **Sector**
- **Policy Stage**
- **Importance**

#### Granular visualizations for root cause analysis

Below the above, we have a few visualizations that help us understand the root
cause of issues.

### Level 3: Detailed Analysis

Detailed analysis are to be done in the
[Kibana Discover page](https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/discover#/).

## Key Definitions Explained

### Warehouse Document

Documents stored in the `article_warehouse` table, representing individual
articles.

### Stale Scraper

Scrapers that haven't produced new data in the last 7 days, indicating potential
collection issues.

### Translation Rate

The translation rate shows the percentage of documents that have been
successfully translated, if the text to be translated is present.

### ML Inference Rate

Coverage of machine learning predictions across all required fields (sentiment,
sector, policy stage).

## Common Issues and Solutions

### Low Translation Rate

- Check the "Missing translations by news line" treemap
- Industry Association content often has the highest volume of untranslated
  documents
- Review translation service capacity and error logs

### Stale Scrapers

- Monitor the "Scraper Triggers" metric
- Check individual scraper status in Level 2
- Review scraper logs for authentication or parsing errors

### ML Inference Gaps

- Use the "Documents Missing ML Inference" chart
- Identify which models are underperforming
- Check model service health and processing queues

## Dashboard Access

Access the live dashboard:
[Pipeline Health Dashboard](<https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/dashboards#/view/7770cea6-8100-4b25-ac13-be8f265624ad?_g=(filters:!(),refreshInterval:(pause:!t,value:60000),time:(from:now-2w,to:now))>)

## Related Resources

- [Kibana Discover](https://bilby.kb.asia-southeast1.gcp.elastic-cloud.com/s/official-china/app/discover#/) -
  For custom queries and raw data access
- [Data Exploration Dashboard](../data-exploration/README.md) - For content
  analysis
- Data QA Dashboard (Coming Soon) - For data quality validation
