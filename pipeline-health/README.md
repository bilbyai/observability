# Pipeline Health Dashboard

## Overview

The Pipeline Health Dashboard provides operational monitoring of our data
pipeline infrastructure. It's designed to answer the critical question **"Is the
pipeline running ok?"** within 30 seconds of viewing.

The dashboard follows a hierarchical information architecture:

- **Top to Bottom**: From critical metrics to granular details
- **Left to Right**: Following the pipeline's data flow stages
- **Color Coding**: Red/orange for issues, green for healthy metrics

![pipeline structure](https://github.com/bilbyai/observability/blob/main/pipeline-health/screenshots/structure.png?raw=true)

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

To see which documents need to be translated, we use the following formula:

$$
\text{field}\ \wedge\ \lnot\text{field\_en}
$$

This is the same as:

$$
\text{field}\ AND\ NOT\ \text{field\_en}
$$

in KQL, this is: `field:* AND NOT field_en:*`

In plain english, this means that the document has the field, but the English
version of the field is not present.

For example, if the document has a `title` field, but the English translation of
that field, `title_en`, is not present, then the document is considered to be
missing a translation.

If the original language field is null, then there is nothing to be translated,
so it is considered to be okay. However, this means that if the document is
missing that field in the first place, that may be an issue with upstream
scrapers.

#### In-House ML Inference Metrics

- **In-House ML Inference Rate**: Coverage of ML predictions (Target: 100%)

### Level 2: Component Performance (Middle Section)

Provides detailed breakdowns of each pipeline stage:

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

1. **Warehouse Documents by Time**
   - Bar chart with 7-day moving average
   - Identifies trends and anomalies in document flow

2. **Translation Coverage Analysis**
   - Documents with vs without translations
   - Breakdown by news line and source

3. **ML Inference Gaps**
   - Missing predictions by category (sentiment, policy stage, importance,
     sector)
   - Helps prioritize ML model improvements

4. **Source-Specific Issues**
   - Treemap visualizations showing problematic sources
   - Industry Association and official_line breakdowns

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

Percentage of documents with completed translations. Critical for multi-language
content accessibility.

The translation rate is calculated by seeing if the original content is there
and if the translated content is also there. If the original content is there
but the translated content is not, it is considered a missing translation.

### ML Inference Rate

Coverage of machine learning predictions across all required fields (sentiment,
sector, policy stage).

## Using the Dashboard

### Quick Health Check (30 seconds)

1. Check Level 1 metrics - all should be green or near 100%
2. Any red/orange metrics indicate immediate attention needed
3. Note the "Last Scraper Run" time - should be within expected intervals

### Troubleshooting Issues (2-5 minutes)

1. Identify problematic metrics in Level 1
2. Navigate to corresponding Level 2 section for component details
3. Use Level 3 visualizations to identify specific sources or time periods

### Deep Dive Analysis

For detailed investigation, click the Kibana Discover link at the bottom to
access raw data and perform custom queries.

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
