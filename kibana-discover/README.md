# Kibana Discover User Guide

## Overview

Kibana Discover is a powerful data exploration tool that allows you to search,
filter, and analyze your data stored in Elasticsearch. This guide will help you
navigate and use Discover effectively for data analysis and troubleshooting.

## Table of Contents

- [Kibana Discover User Guide](#kibana-discover-user-guide)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
    - [Accessing Discover](#accessing-discover)
    - [First Time Setup](#first-time-setup)
  - [Understanding the Interface](#understanding-the-interface)
    - [Main Components](#main-components)
    - [Key Areas](#key-areas)
  - [Search and Query](#search-and-query)
    - [Via the visual editor](#via-the-visual-editor)
    - [Kibana Query Language (KQL)](#kibana-query-language-kql)
      - [Basic Syntax](#basic-syntax)
      - [Examples](#examples)
      - [Fields](#fields)
  - [Saving and Sharing](#saving-and-sharing)
    - [Save Searches](#save-searches)
    - [Export Data](#export-data)
  - [Additional Resources](#additional-resources)

## Getting Started

### Accessing Discover

1. Navigate to Kibana in your browser
2. Click on **Discover** in the left navigation menu
3. Select your data view (index pattern) from the dropdown

![Accessing Discover](https://github.com/bilbyai/observability/blob/main/kibana-discover/screenshots/SCR-20250717-mfdg.png?raw=true)

### First Time Setup

If this is your first time using Discover:

1. Ensure you have at least one data view configured (you probably want to set
   your data view as
   `bilbyai-prod.newspapers_dbt_deploy.article_warehouse-timestamped-by-date`)
2. Set your default time range (typically something like "Last 2 weeks" or "Last
   10 Years")
3. Familiarize yourself with the layout.

## Understanding the Interface

### Main Components

![Kibana Discover Interface](https://github.com/bilbyai/observability/blob/main/kibana-discover/screenshots/SCR-20250717-mlzp.png?raw=true)

### Key Areas

1. **Data View Selector**: Choose which index pattern to explore
2. **Time Range Picker**: Set the time window for your data
3. **Search Bar**: Enter queries using KQL or Lucene syntax
4. **Filters**: Add visual filters to refine results
5. **Fields Sidebar**: Browse and select fields to display
6. **Document Table**: View your search results

## Search and Query

### Via the visual editor

Click on the "Visualize" button in the top right corner.

![Visualize](https://github.com/bilbyai/observability/blob/main/kibana-discover/screenshots/SCR-20250717-mpfu.png?raw=true)

This will open the visual editor.

![Visual Editor](https://github.com/bilbyai/observability/blob/main/kibana-discover/screenshots/SCR-20250717-mpmd.png?raw=true)

You can then select the type of filter you want to create.

### Kibana Query Language (KQL)

KQL is the default query language in Discover. It's simple and intuitive:

#### Basic Syntax

```
field:value
```

```
"text_to_search"
```

> 📒 Pro tip: Text fields sometimes have a `.keyword` suffix. This is a special
> field that stores the value as a keyword (like a category, rather than free
> text), which is useful for exact matches.

> 🚨 Warning: Certain documents' body field exceed the 1 million character
> length, and will fail to search.

#### Examples

- Find all documents in the official line: `news_line.keyword:"official_line"`
- Find documents in the procurement line that mention drugs:
  `news_line.keyword:"procurement" AND "药品"`
- Documents with policy stage >= 5 and negative sentiment:
  `policyLifecyclePrediction >= 5 AND marketSentimentPrediction.keyword:"negative" `
- Documents with a bunch of keywords: ``

You can do cool stuff like this! Finding documents that have a policy stage >= 5
and negative sentiment, and getting the distribution of news_line.

![image](https://github.com/bilbyai/observability/blob/main/kibana-discover/screenshots/SCR-20250717-mwjz.png?raw=true)

#### Fields

<!--

### Lucene Query Syntax

For more complex queries, switch to Lucene:

1. Click the KQL/Lucene toggle in the search bar
2. Use Lucene syntax:
   - Fuzzy search: `message:timeout~`
   - Proximity search: `"quick brown"~5`
   - Regular expressions: `/joh?n(ath[oa]n)/`

### ES|QL Mode

For advanced analytical queries, use ES|QL:

1. Switch to ES|QL mode from the application menu
2. Write queries like:
   ````sql
   FROM logs-*
   | WHERE level == "error"
   | STATS count = COUNT(*) BY service
   | SORT count DESC
   ``` -->

## Saving and Sharing

### Save Searches

1. Click "Save" in the toolbar
2. Name your search, and under tags, I recommend adding your own name, like
   "owner:david" to denote to others that you are the owner of the search.
3. Optionally save:
   - Time range

### Export Data

1. **CSV Export**:
   - Click on the "Export icon" on the top-right corner.
   - Click on the "Export" tab.
   - Click on "Generate CSV".
     ![image](https://github.com/bilbyai/observability/blob/main/kibana-discover/screenshots/SCR-20250717-mzqz.png?raw=true)
   - WHen it's ready, it's available to download immediately through the
     notification, or in "Stack Management > Reporting".
     ![image](https://github.com/bilbyai/observability/blob/main/kibana-discover/screenshots/SCR-20250717-mszn.png?raw=true)

> ⚠️ Note: Large (>10000 documents) queries will take a long time to export, or
> may not work at all. If sharing internally, I recommend using the direct link.

1. **Copy a direct link to the search**:
   - Like the above, click on the "Export icon" on the top-right corner.
   - Click "Copy link" to copy a direct link to the search.

## Additional Resources

- [Official Elastic Documentation](https://www.elastic.co/guide/en/kibana/current/discover.html)
- [KQL Reference](https://www.elastic.co/guide/en/kibana/current/kuery-query.html)
- [ES|QL Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/esql.html)
