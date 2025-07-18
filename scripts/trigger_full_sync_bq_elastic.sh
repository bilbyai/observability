#!/bin/bash
# Does a full sync of article_warehouse table in BigQuery to Elasticsearch.
# This script should run in the root of the repo.

# exit on error
set -e

# read .env 
source .env

# run dataflow job

gcloud dataflow flex-template \
  run david-full-sync-bq-elastic-$(date +%Y%m%d%H%M%S) \
  --template-file-gcs-location gs://dataflow-templates-asia-southeast1/latest/flex/BigQuery_to_Elasticsearch \
  --region asia-southeast1 \
  --additional-user-labels "" \
  --parameters \
query='SELECT * FROM `bilbyai-prod.newspapers_dbt_deploy.article_warehouse` WHERE inserted_at <= CURRENT_TIMESTAMP()',\
useLegacySql=false,\
connectionUrl=$ELASTIC_CLOUD_ID,\
apiKey=$ELASTIC_API_KEY,\
index=bilbyai-prod.newspapers_dbt_deploy.article_warehouse,\
bulkInsertMethod=INDEX,\
propertyAsId=uuid,\
usePartialUpdate=false,\
batchSize=50,\
batchSizeBytes=5242880,\
trustSelfSignedCerts=false,\
disableCertificateValidation=false,\
apiKeySource=PLAINTEXT

# batch size 50 is important because it does not crash the job.
# We have been getting timeout errors on Elasticsearch with larger batch sizes.
