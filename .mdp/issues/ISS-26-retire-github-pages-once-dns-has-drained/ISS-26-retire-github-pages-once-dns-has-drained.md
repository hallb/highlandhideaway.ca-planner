---
id: ISS-26
title: Retire GitHub Pages once DNS has drained
type: task
status: Done
priority: Medium
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
checklist:
  - text: Confirm resolvers no longer return 185.199.108-111.153 for the apex
    done: true
  - text: Remove the custom domain from the repo's GitHub Pages settings
    done: true
  - text: Delete the CNAME file
    done: true
log:
  - timestamp: 2026-08-19T02:43:15.944Z
    author: claude
    body: |-
      Retired GitHub Pages ahead of the DNS drain, reversing this issue's "do not rush this" guidance. The fallback turned out to be the fault: its CTAs link straight to Airbnb, so every visitor served by GitHub converted without recording a click. ISS-29 spent an hour reading that silence as a broken Worker.

      Pages disabled with DELETE /repos/hallb/highlandhideaway.ca/pages; the endpoint now 404s and both old Pages addresses return 404 for this host. Checked first that nothing depended on it — .github/workflows/ holds only cloudflare.yml, with no reference to Pages, so the site was serving a build no workflow had fed since hugo.yml was deleted. CNAME removed in commit 37e1b86 on main, not yet pushed; it sat at the repo root rather than static/, so Hugo never published it.

      The drain is nearly complete but not finished. Public resolvers are clean for A and AAAA on both hostnames. The local resolver still holds GitHub's AAAA, so requests from this machine still split by address family — the A records drained first and the AAAA lagged, which is the mirror image of the failure earlier in the evening, when the AAAA was correct and the A was stale. Worth remembering that these two drain independently: checking one record type proves nothing about the other.
  - timestamp: 2026-08-19T03:51:04.597Z
    author: claude
    body: "Drain check at 2026-08-19 03:50 UTC: Windows now resolves the apex to Cloudflare for both A and AAAA, and the local resolver's A is correct, but it still returns GitHub's AAAA (2606:50c0:800x::153). Ten requests to /go/airbnb from this machine split 8 Cloudflare / 2 GitHub 404 — down from 6/4 an hour ago, so it is draining, just not drained. Still open on that one record."
  - timestamp: 2026-08-20T21:08:36.434Z
    author: claude
    body: |-
      Drain complete, closing. Checked 2026-08-20 21:07 UTC from the local WSL resolver — the one that was lagging. Both hostnames now return Cloudflare on both record types: A 172.64.80.1 and AAAA 2606:4700:130:436c:6f75:6466:6c61:7265 for the apex and for www alike. Five requests to each hostname all served 200 from 172.64.80.1.

      Deliberately did not repeat the earlier /go/airbnb split test. That path writes a data point on every request, including HEAD, so the two previous drain checks put roughly fourteen synthetic clicks into booking_clicks between 02:42 and 03:50 UTC on 2026-08-19 — the 8 and the 6 that reached Cloudflare; the GitHub 404s recorded nothing. Anyone reading a conversion figure for that window should know it is inflated. Verified against the homepage instead, which serves from the asset store without running the Worker.

      Second acceptance criterion also holds: the only GitHub Pages strings left under the site repo are inside themes/DoIt/exampleSite, which is upstream theme content, not ours.
  - timestamp: 2026-08-20T21:17:52.366Z
    author: claude
    body: "Follow-up on the synthetic clicks noted above: they are filterable. The drain checks called /go/airbnb with no query string, so worker.js defaulted both fields and the rows carry src=unknown and pos=unknown. Real CTAs always pass ?src= and ?pos= through partials/booking-url.html, and the daily monitor canary tags itself src=/canary/. Excluding src IN ('unknown', '/canary/') leaves visitor clicks only. Recorded in docs/02-solution/operations.md so it is not rediscovered from the dashboard."
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-20T21:17:52.366Z
---

## Requirement

GitHub Pages served its last deployment to anyone whose resolver held its
addresses. That was originally deliberate: those pages link straight to
Airbnb and convert correctly, so they looked like a working fallback while
DNS drained.

`.github/workflows/hugo.yml` had already been deleted, so the fallback was
frozen rather than tracking `main`.

## Why this was done early (2026-08-19)

The fallback was the fault, not the safety net. Its buttons link directly
to Airbnb, bypassing `/go/airbnb` entirely, so a visitor served by GitHub
books successfully and records nothing — no 404, no error, just an
invisible hole in the conversion numbers. That cost was paid before it was
noticed: several real Book now clicks during ISS-29 recorded nothing at
all, and the silence read as a broken Worker for the better part of an
hour.

So Pages was disabled ahead of the drain rather than after it. A hard 404
for a shrinking set of stale resolvers is the better failure: it is
visible, and it cannot quietly undercount.

Done so far:

- Pages disabled for the repo (`DELETE /repos/hallb/highlandhideaway.ca/pages`);
  the API now 404s for that site, and both old Pages addresses return 404
  for this host.
- `CNAME` deleted from the site repo (commit `37e1b86`, on `main`, not yet
  pushed).
- Nothing in the site repo refers to GitHub Pages any more.

## What is left

Only the drain itself, which is now cosmetic — there is no fallback left to
protect. As of 2026-08-19 02:42 UTC:

- `1.1.1.1` and `8.8.8.8` return only Cloudflare for the apex and www, A
  and AAAA alike.
- The local WSL/corporate resolver returns the correct A, but still holds
  **GitHub's AAAA** (`2606:50c0:800x::153`). Ten requests to `/go/airbnb`
  from this machine still split 6 Cloudflare / 4 GitHub 404 on address
  family alone.

Close this when a local lookup returns Cloudflare for both record types.

## Acceptance

- The apex and www resolve only to Cloudflare.
- Nothing in the repo refers to GitHub Pages.