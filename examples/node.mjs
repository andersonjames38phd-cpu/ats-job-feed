// ATS Jobs Feed - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Remote jobs posted today, with descriptions
const run = await client.actor('Turboextract/ats-job-feed').call({
    "companies": [
        "ramp",
        "airbnb"
    ],
    "remoteOnly": true,
    "postedWithinDays": 1,
    "includeDescription": true
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.company, item.title, item.location, item.applyUrl);
}
