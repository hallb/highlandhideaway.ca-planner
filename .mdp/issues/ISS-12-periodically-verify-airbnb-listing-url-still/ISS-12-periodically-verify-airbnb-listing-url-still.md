---
id: ISS-12
title: Periodically verify Airbnb listing URL still resolves to property
type: task
status: Done
priority: Low
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: ISS-24
relatedTo: []
checklist: []
log:
  - date: 2026-08-18
    note: "The listing URL now lives in one place, params.booking.url, and all ten CTAs reach it through the Worker at /go/airbnb. That makes a rot check cheap to add. Still nothing verifies it: .htmltest.yml sets CheckExternal: false, so CI checks none of the eight outbound links in the content."
  - timestamp: 2026-08-19T03:16:28.754Z
    author: claude
    body: "Folded into ISS-24 as a child. Covered two ways now: script/monitor listing checks the booking URL directly, reading it from BOOKING_URL in wrangler.toml so the check follows the config rather than duplicating it, and the weekly lychee crawl covers the other outbound links that .htmltest.yml skips with CheckExternal: false. Only 404 and 410 count as rot — Airbnb answers datacenter IPs with 403 routinely, and treating that as failure would be a weekly false alarm."
  - timestamp: 2026-08-19T03:51:04.098Z
    author: claude
    body: "Closed with its parent ISS-24. script/monitor listing checks the booking URL daily, reading it from BOOKING_URL in wrangler.toml; the weekly crawl covers the other outbound links htmltest skips. First run: the listing responded 200."
createdAt: 2026-03-25T03:01:36.683Z
updatedAt: 2026-08-19T03:51:04.353Z
---
