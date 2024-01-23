ENV ?= local

$(info ENV is ${ENV}, Loading .env.${ENV} file ...)
include .env.${ENV}

pull-manifest:
	aws s3 cp s3://${S3_BUCKET}/manifest.json .

push-manifest:
	aws s3 cp target/manifest.json s3://${S3_BUCKET}/manifest.json

run-ci:
	dbt deps
	dbt compile
	dbt seed
	dbt run -s +state:modified --state .
	dbt test -s +state:modified --state .

import-packages:
	dbt deps

run:
	dbt run