---
id: ISS-29
title: Confirm booking_clicks is actually recording
type: review
status: Done
priority: High
labels: []
assignee: null
milestone: M-5
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-25
  - ISS-24
checklist:
  - text: Click a real Book now button and find the row in booking_clicks
    done: true
  - text: Confirm ?src= distinguishes the page the click came from
    done: true
  - text: Decide how the numbers get looked at, and how often
    done: true
log:
  - timestamp: 2026-08-19T01:13:29.705Z
    author: claude
    body: |-
      Verified over the SQL API that booking_clicks is recording: 104 data points, newest 2026-08-18 21:44:32 UTC, split across four blob1 values. Second acceptance criterion met. Every row has an empty blob2 referer, so all traffic so far is curl, not a browser button — the first criterion still needs one real click.

      Built a local Grafana to read it (grafana/ in this repo, `just grafana`): Altinity ClickHouse plugin against the SQL API, provisioned data source plus a four-panel dashboard. Health check OK with usePOST: true, and both panel queries return real data through the proxy, so $timeFilter and $timeSeries expand server-side. Notes in grafana/README.md.

      Two dead ends worth not repeating. Grafana published to 127.0.0.1 is unreachable from a Windows browser under WSL2 — it binds the VM's loopback — so the compose file now publishes on 0.0.0.0 via GRAFANA_BIND. And the container's admin password drifts from GF_SECURITY_ADMIN_PASSWORD, because Grafana only applies that variable when it first creates the user; reset it with `docker exec hh-grafana grafana cli --homepath /usr/share/grafana admin reset-admin-password admin`.

      A browser click made during this session recorded nothing, which looked like the DNS records were wrong. They are not. Both Cloudflare nameservers, AA bit set, return exactly one A (172.64.80.1) and one AAAA (2606:4700:130:436c:...) for the apex and www, no GitHub Pages records. The stale answers were cached in the local WSL/corporate resolver chain from before the cutover, with GitHub's 3600s TTL still counting down; roughly one request in three was landing on GitHub Pages, where /go/airbnb 404s. This is ISS-25 gotcha 3 again — check the origin with `curl -sI` and look for cf-ray before believing a fault.

      To pick this up: confirm the cache has drained (ten requests to /go/airbnb should all answer 302 with server: cloudflare), click Book now from two different pages in a browser, then query for rows with a populated blob2. That closes the first criterion. The third — how often the numbers get looked at — is still an open decision; the Grafana dashboard is the candidate answer.
  - timestamp: 2026-08-19T02:24:43.760Z
    author: claude
    body: |-
      Both acceptance criteria are now met by real browser clicks. Two rows landed at 2026-08-19 02:09:45 and 02:09:54 UTC — blob1 `/` and `/about/`, each with its own page as blob2 referer, country CA. Verified twice: raw SQL API, and the Clicks by page panel query run through Grafana's /api/ds/query, where $timeFilter expands server-side and returns the same numbers.

      Why the earlier clicks recorded nothing, and it was not the write path. GitHub Pages is still serving the pre-cutover build (last-modified 2026-08-18 21:15Z), whose Book now button is a direct href to airbnb.ca with no /go/airbnb in it. A click on that copy works perfectly, reaches the listing, and counts nothing — no 404, no error, nothing to notice. The local resolver chain still had the stale GitHub A records (185.199.108-111.153) while the AAAA was already correct Cloudflare, so requests alternated between the two origins by address family.

      The write path itself was never broken: synthetic requests that got a 302 appeared in the dataset roughly 60 seconds later, every time. Ingestion lag is the thing to remember — query too soon and an empty result reads exactly like a failed write.

      What actually unstuck it: a hard refresh was not enough, a private window was. No service worker is involved (checked both builds); it was plain HTTP caching of GitHub Pages' `cache-control: max-age=600` HTML, so it self-clears rather than sticking to returning visitors.

      Two mechanical notes. The Grafana admin password had drifted from .env again — reset in the container to the GRAFANA_ADMIN_PASSWORD value, per the README gotcha. And the dataset now carries synthetic rows from this session: /win-probe/ 6, /probe/ 4, /headers-probe/ 2, /getprobe/ 2, /diagnostic 1, and 32 of the 33 hits on `/`. Only one click on `/` and one on `/about/` are real. There is no delete on Analytics Engine; they age out with the three-month window.

      Still open: the third criterion, how often the numbers get looked at. The dashboard ships with refresh off deliberately, so it is a pull, not a push — that decision is unmade.
  - timestamp: 2026-08-19T03:16:40.364Z
    author: claude
    body: |-
      Third criterion decided, which closes this issue: the numbers do not get looked at on a schedule — they raise their hand. A synthetic canary in .github/workflows/monitor.yml clicks the button daily and fails the run if no booking_clicks row appears, so a broken write path becomes an email instead of an absence nobody notices. Grafana stays what it always was, a place to look when you want to, not the thing standing watch. Specified and tracked in ISS-24.

      Validated end to end before committing: the click returned 302 at 03:10:10Z and the exact query script/monitor runs found its row. The canary writes blob1 = '/canary/', which the three aggregate Grafana panels now exclude; Recent clicks still shows it, so the heartbeat stays visible in the raw feed.
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-19T03:16:40.657Z
---

## Requirement

The redirect is verified — 20/20 requests return 302 to the listing. What
is not yet verified is that `writeDataPoint` is landing rows in the
`booking_clicks` dataset.

The Worker swallows write failures on purpose, so that a broken binding can
never cost a booking. The cost of that choice is that a silently failing
write looks exactly like no traffic.

## Query shape

Analytics Engine is queried over its SQL API. `blob1` is the `src` page
path, `blob2` the referrer, `blob3` the country.

## Where it stands (2026-08-19)

**Writes are landing.** `SHOW TABLES` returns `booking_clicks`, and the
dataset held 104 data points as of 2026-08-18 21:44:32 UTC:

| `blob1` | clicks | first seen | last seen |
| --- | --- | --- | --- |
| `unknown` | 73 | 20:16:09 | 21:42:34 |
| `/` | 28 | 20:40:17 | 21:44:32 |
| `/test/` | 2 | 20:09:13 | 20:49:27 |
| `/posts/winter-at-the-hideaway/` | 1 | 21:44:30 | 21:44:30 |

`unknown` is the fallback for requests with no `?src=`, i.e. the curl loops
from the ISS-25 verification.

Second acceptance criterion is met: three distinct page paths, cleanly
separated by `blob1`. The first is **not yet met** — every row has an empty
`blob2`, so every write so far came from curl, never from a browser button.

## How to check

Two ways, same API underneath.

Curl, with an **Account · Account Analytics · Read** token (the
`CLOUDFLARE_API_TOKEN` in GitHub secrets is Workers Scripts:Edit and 403s
here):

```bash
curl "https://api.cloudflare.com/client/v4/accounts/$CF_ACCOUNT_ID/analytics_engine/sql" \
  --header "Authorization: Bearer $CF_AE_TOKEN" \
  --data "SELECT timestamp, blob1 AS src, blob2 AS referer, blob3 AS country
          FROM booking_clicks
          WHERE timestamp >= NOW() - INTERVAL '1' HOUR
          ORDER BY timestamp DESC FORMAT JSONEachRow"
```

Or Grafana — `just grafana` in this repo, then Dashboards → Highland
Hideaway → Booking clicks. See `grafana/README.md`. Count with
`SUM(_sample_interval)`, never `COUNT(*)`.

## Acceptance

- A click made by hand appears as a row.
- Two clicks from different pages are distinguishable by `blob1`.