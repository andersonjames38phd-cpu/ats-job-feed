#!/usr/bin/env bash
# ATS Jobs Feed - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~ats-job-feed"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Engineering jobs at three startups, posted this week (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "companies": [
      "airbnb",
      "https://jobs.lever.co/palantir",
      "https://jobs.ashbyhq.com/ramp"
    ],
    "keywords": [
      "engineer"
    ],
    "postedWithinDays": 7
  }'

# 2. Remote jobs posted today, with descriptions (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "companies": [
      "ramp",
      "airbnb"
    ],
    "remoteOnly": true,
    "postedWithinDays": 1,
    "includeDescription": true
  }'

# 3. Every open sales role at a list of companies (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "companies": [
      "ramp",
      "airbnb",
      "huggingface"
    ],
    "departments": [
      "sales"
    ],
    "maxResults": 1000
  }'
