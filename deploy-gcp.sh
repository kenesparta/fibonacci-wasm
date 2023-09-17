#!/bin/bash

gcloud run deploy fibonacci-wasm-front-"${ID}" \
  --image us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-"${ID}"/fibonacci-wasm-front:0.0.1 \
  --region us-central1 \
  --project dockerayacucho \
  --allow-unauthenticated \
  --platform managed

gcloud run services add-iam-policy-binding fibonacci-wasm-front-"${ID}" \
  --region=us-central1 \
  --member=allUsers \
  --role=roles/run.invoker \
  --project dockerayacucho

gcloud run services delete fibonacci-wasm-front-"${ID}" \
  --region=us-central1 \
  --project dockerayacucho
