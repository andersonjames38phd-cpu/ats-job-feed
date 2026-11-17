"""ATS Jobs Feed - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Engineering jobs at three startups, posted this week
run = client.actor("Turboextract/ats-job-feed").call(run_input={
    "companies": [
        "airbnb",
        "https://jobs.lever.co/palantir",
        "https://jobs.ashbyhq.com/ramp"
    ],
    "keywords": [
        "engineer"
    ],
    "postedWithinDays": 7
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("company"), item.get("title"), item.get("location"), item.get("applyUrl"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
