#!/bin/bash
# This script should run in the root of the repo.

# exit on error
set -e

# read .env 
source .env

# run dataflow job
gcloud \
  dataflow flex-template \
  run david-full-sync-bq-elastic-$(date +%Y%m%d%H%M%S) \
  --template-file-gcs-location gs://dataflow-templates-asia-southeast1/latest/flex/BigQuery_to_Elasticsearch \
  --region asia-southeast1 \
  --num-workers 2 \
  --parameters \
connectionUrl=$ELASTIC_CLOUD_ID,\
apiKey=$ELASTIC_API_KEY,\
propertyAsId=uuid,\
bulkInsertMethod=INDEX,\
index=bilbyai-prod.newspapers_dbt_deploy.article_warehouse,\
query='SELECT * FROM `bilbyai-prod.newspapers_dbt_deploy.article_warehouse` WHERE inserted_at <= CURRENT_TIMESTAMP()'
