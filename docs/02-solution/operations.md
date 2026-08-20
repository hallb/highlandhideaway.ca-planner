# Operations

Satisfies **REQ-029**, **REQ-037**, **REQ-038**, and the editorial parts of **REQ-001**–**REQ-003**.

## Content updates

1. Clone `highlandhideaway.ca` with submodules.
2. Edit Markdown under `content/`; add images under `static/images/`.
3. Preview with `hugo server`.
4. Commit and push to `main`. CI builds, link-checks, and deploys.

A failing `htmltest` stops the deploy, so a broken internal link blocks the release rather than reaching production.

## Approvals

Decide within the team who may merge to `main` — property owner or delegated editor. Not enforced in Git by default.

## Monitoring

Workflow: [`highlandhideaway.ca/.github/workflows/monitor.yml`](../../../highlandhideaway.ca/.github/workflows/monitor.yml), driven by `script/monitor`.

CI checks `public/` before it ships. Monitoring checks the thing that exists afterwards, which can rot with no commit behind it: a route detaching, an external link dying, the listing URL changing, an Analytics Engine binding that stopped writing.

| Job | Cadence | Checks |
|-----|---------|--------|
| `endpoints` | Daily 13:17 UTC | `/go/airbnb` still 302s to the listing from Cloudflare; the Airbnb listing URL still resolves |
| `canary` | Daily | Sends a synthetic click, then insists the row appears in `booking_clicks` |
| `links` | Weekly, Sunday | `lychee` crawls the live sitemap |
| `heartbeat` | Daily, if all passed | Pings a dead man's switch |

Four details that are easy to get wrong when editing this:

**The canary is the job that earned the workflow.** `src/worker.js` swallows write failures on purpose, so a booking is never lost to a broken binding. The cost is that a silently failing write looks exactly like a quiet week. Real traffic cannot distinguish them; a synthetic click can, because it knows a row is owed. Canary rows are tagged `src=/canary/`, so they can be excluded when reading real numbers.

**The heartbeat covers the failure the workflow cannot report itself:** not running at all. GitHub disables scheduled workflows after 60 days without repository activity, which for a site touched a few times a year is a realistic way to lose monitoring without noticing. The absence of a ping is the alert.

**The link crawl accepts 403 and 429.** Airbnb and similar consumer sites block datacenter IPs on sight. Treating those as broken would produce a weekly false alarm and train everyone to ignore the job. The booking URL specifically is covered by `script/monitor listing`, where only a 404 or 410 counts as gone.

**Both crons fire on Sunday.** They are separate runs; the `links` job filters itself to the weekly one.

The expected destination is read from `wrangler.toml` rather than hard-coded, so changing `BOOKING_URL` and deploying updates the check with it.

## Reading the booking numbers

Analytics Engine has no UI. Start `grafana/` in this repo:

```bash
cp grafana/.env.example grafana/.env   # account ID + Account Analytics:Read token
just grafana                           # http://localhost:3000, admin/admin
```

See [`../../grafana/README.md`](../../grafana/README.md) for the query constraints — count with `SUM(_sample_interval)`, no JOINs, three-month retention — and for the WSL2 networking notes.

Two known contaminations in the dataset, both from testing rather than visitors:

- Canary rows, daily, tagged `src=/canary/`.
- Roughly 14 rows between 02:42 and 03:50 UTC on 2026-08-19, from DNS drain checks that called `/go/airbnb` directly. They carry `src=unknown` and `pos=unknown`, so they can be filtered out.

## If the site is down

1. Check the [Cloudflare status page](https://www.cloudflarestatus.com/) and the repository Actions tab for failed runs.
2. Check the Worker in the Cloudflare dashboard: is the deployment current, and are both custom domains still attached?
3. Confirm DNS resolves to Cloudflare for the apex and `www`, on both A and AAAA. Those two record types drain and propagate independently, so checking one proves nothing about the other. That has caused a real incident: requests split by address family, with a stale AAAA sending some visitors to a dead host while A was correct.
4. Roll back by reverting the bad commit on `main` and letting CI redeploy. To bypass CI, use the break-glass local deploy in [build-and-deploy.md](build-and-deploy.md).

If the site is up but bookings look wrong, check the canary job before assuming the Worker is broken — and check that every CTA still routes through `/go/airbnb`. A link that goes straight to the listing converts fine and records nothing, which reads as a broken counter. That has also happened, in ISS-26.

## Backups

- **Source of truth:** the Git remote. Match repository access and branch protection to your risk tolerance.
- **Built site:** regenerable from source. Cloudflare holds the current deployment, and wrangler keeps recent versions for rollback.
- **Booking clicks:** three-month retention in Analytics Engine, not backed up. Anything needed beyond that window has to be exported.

## Access

At least one maintainer should hold:

- The **Cloudflare** account (Workers, DNS, Rules, Analytics).
- The **Google Analytics** property `G-M21FZFQ5YJ`, while it remains enabled (REQ-023).
- The **Search Console** Domain property for `highlandhideaway.ca` (ISS-27).
- The **GitHub** repository, including the secrets listed in [build-and-deploy.md](build-and-deploy.md).
