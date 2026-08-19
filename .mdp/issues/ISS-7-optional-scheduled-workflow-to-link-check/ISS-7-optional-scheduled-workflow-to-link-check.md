---
id: ISS-7
title: "Optional: scheduled workflow to link-check production URL"
type: task
status: Done
priority: Low
labels: []
assignee: null
milestone: M-2
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: ISS-24
relatedTo: []
checklist: []
log:
  - timestamp: 2026-08-19T03:16:28.456Z
    author: claude
    body: Folded into ISS-24 as a child. The scheduled lychee crawl of the live sitemap is now one job in .github/workflows/monitor.yml rather than its own workflow, sharing a cadence and a failure channel with the redirect, listing and booking-clicks checks. The sketch here — weekly schedule plus workflow_dispatch, lychee against the production sitemap, polite user agent, bounded concurrency — survived intact; the one addition is accepting 403 and 429, because Airbnb and similar consumer sites block datacenter IPs on sight and a weekly false alarm would train everyone to ignore the job.
  - timestamp: 2026-08-19T03:51:03.618Z
    author: claude
    body: "Closed with its parent ISS-24. The weekly lychee crawl of the live sitemap runs in .github/workflows/monitor.yml and passed its first run clean: 73 URLs, 0 errors."
createdAt: 2026-03-25T03:01:35.487Z
updatedAt: 2026-08-19T03:51:03.843Z
---

## Requirement

Periodically verify **production** URLs still respond and link correctly (scheduled smoke), separate from PR-time htmltest on `public/`.

### Intended implementation (reverted locally)

- Workflow `link-check-prod.yml` on `schedule` (e.g. weekly) + `workflow_dispatch`.
- Use **lychee** (or similar) against `https://highlandhideaway.ca/sitemap.xml` with a polite User-Agent and bounded concurrency.

### Acceptance

- Failures notify the team that prod or external links broke (Airbnb, CDN, etc.).