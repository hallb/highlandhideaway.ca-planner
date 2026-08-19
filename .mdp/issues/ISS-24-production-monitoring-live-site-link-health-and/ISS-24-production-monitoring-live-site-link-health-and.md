---
id: ISS-24
title: "Production monitoring: live site link health and uptime"
type: task
status: Done
priority: High
labels: []
assignee: null
milestone: M-2
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-7
  - ISS-6
checklist: []
log:
  - date: 2026-08-18
    note: Sharper now that the site is on Cloudflare. Web Analytics (ISS-28) covers traffic and would show an outage by its absence. Link rot on outbound URLs remains uncovered, and there are now eight external links in the content including two Google Maps short links.
  - timestamp: 2026-08-19T01:13:44.489Z
    author: claude
    body: "Related tooling now exists: grafana/ in this repo is a local Grafana over the Analytics Engine SQL API, built for ISS-29. It covers conversion (Book now clicks by page), not link health or uptime, so it does not close any of this issue — but it is the obvious place to hang a panel if monitoring ends up wanting a dashboard rather than a scheduled check. Cloudflare traffic data is not reachable from that data source; it lives in the GraphQL Analytics API and would need the Infinity plugin."
  - timestamp: 2026-08-19T03:51:03.127Z
    author: claude
    body: |-
      Built and verified. `script/monitor` and `.github/workflows/monitor.yml` are on main in the site repo (commits 6f6c6fb and the lychee fix that followed), the schedule is live — endpoints and canary daily at 13:17 UTC, link crawl Sundays — and CF_AE_TOKEN and HEARTBEAT_URL are set as repository secrets.

      Run 32213020224, all four jobs green against production:

      - redirect: 5/5 requests 302 to https://airbnb.ca/h/hideaway-near-haliburton via cloudflare
      - listing: responds 200
      - link crawl: 73 total, 73 unique, 73 OK, 0 errors
      - canary: click sent 03:41:17Z, row present after the 120s ingestion wait
      - heartbeat: pinged

      The first run failed on the lychee install, worth recording because the symptom lied. The pinned version 0.15.1 does not exist; curl without --fail saved GitHub's 404 page and tar reported "not in gzip format", which reads like a corrupt download rather than a bad URL. Rehearsing the install locally then turned up two more that would each have cost another push: the tarball unpacks into a directory named for the target rather than a bare binary, and --exclude-mail was removed in 0.24, where mail is excluded by default and --include-mail opts in. Fixed together, with sha256 verification added since the checksum ships beside the asset.

      One deliberate asymmetry to know about: the heartbeat depends on endpoints and canary only, not the link crawl. A dead external link is not an outage and should not suppress the "monitoring is alive" signal. Change it if that reads wrong later.
createdAt: 2026-03-25T03:37:03.256Z
updatedAt: 2026-08-19T03:51:03.379Z
---

## Requirement

One scheduled workflow that watches production, replacing three overlapping
ideas: link health on the live origin (ISS-7), listing-URL rot (ISS-12), and
proof that booking clicks are still being counted (ISS-29). Both are now
children of this issue.

CI in `cloudflare.yml` checks `./public` before it ships. Nothing checks what
exists afterwards, and production rots without commits: a route detaches, an
external link dies, a listing URL changes, an Analytics Engine binding stops
writing.

## The check that earned this

`src/worker.js` swallows write failures deliberately, so a broken binding
cannot cost a booking. The cost of that choice is that a silently failing
write is indistinguishable from a quiet week — an outage you notice by an
absence, which means months later.

Alerting on "zero clicks in N days" cannot fix that: a cottage rental
legitimately goes quiet, so the threshold either cries wolf or gets tuned
until it never fires. **A synthetic canary can**, because it knows a row is
owed: click our own button, wait out ingestion, then insist on finding the
row. Absence is then a fact, not an inference.

This was not theoretical. On 2026-08-19 several real Book now clicks recorded
nothing, and the silence read as a broken Worker for the better part of an
hour. See ISS-29.

## Shape

`script/monitor` in the site repo, three subcommands, runnable by hand:

| Subcommand | Asserts | Replaces |
| --- | --- | --- |
| `redirect` | 5/5 requests to `/go/airbnb` return 302, to the `BOOKING_URL` in `wrangler.toml`, served by Cloudflare | — |
| `canary` | a click of our own lands a `booking_clicks` row within the ingestion window | ISS-29 item 3 |
| `listing` | the Airbnb URL is not 404/410 | ISS-12 |

`.github/workflows/monitor.yml` runs them: **endpoints and canary daily**,
**lychee crawl of the live sitemap weekly** (ISS-7). Both crons fire on
Sunday; the crawl filters itself to the weekly one.

## Two decisions worth keeping

**Consumer sites block datacenter IPs.** Airbnb answers a GitHub runner with
403 as a matter of course, so lychee accepts 403 and 429, and `listing`
treats only 404/410 as rot. A check that cries wolf weekly is worse than no
check, because it trains you to ignore the one real failure.

**A dead man's switch covers the failure this workflow cannot report: not
running.** GitHub disables scheduled workflows after 60 days without repo
activity, which for a site touched a few times a year is a realistic way to
lose monitoring without noticing. The `heartbeat` job pings only when
everything passed; the missing ping is the alert.

## Secrets

- `CLOUDFLARE_ACCOUNT_ID` — already set, used by the deploy.
- `CF_AE_TOKEN` — **new**, scoped Account · Account Analytics · Read. The
  existing `CLOUDFLARE_API_TOKEN` is Workers Scripts:Edit and 403s against
  the SQL API. The canary job skips itself cleanly until this exists.
- `HEARTBEAT_URL` — optional, a healthchecks.io-style ping URL.

## Acceptance

- A broken write path produces an email within a day, without anyone looking
  at a dashboard.
- A dead external link or a gone listing produces one within a week.
- The workflow silently ceasing to run is itself detectable.
- No check fires on a condition that is merely quiet traffic.