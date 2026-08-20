---
id: ISS-36
title: Booking clicks count bots; page views do not
type: task
status: To Do
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
  - ISS-29
checklist: []
log: []
createdAt: 2026-08-20T23:18:04.927Z
updatedAt: 2026-08-20T23:18:04.927Z
---

## Requirement

`src/worker.js` records every request to `/go/airbnb`, whatever sent it.
Cloudflare Web Analytics excludes bots. So the conversion rate on the Grafana
dashboard divides a numerator containing machines by a denominator that does
not, and is overstated by an unknown amount.

## The evidence

Clicks by country, the fourteen days to 2026-08-20:

| Country | Clicks |
|---|---|
| CA | 145 |
| US | 49 |
| ZA | 27 |
| NL | 9 |

The ZA rows are not people. They arrive in bursts — ten clicks in seven
seconds across six different pages — with no referer on any of them. That is
a crawler walking the site and following every `/go/airbnb` link it finds.
NL looks the same. Together they are about 16% of all recorded clicks.

## Why the existing filter does not save us

The conversion panels count only rows whose `blob4` carries a placement,
which excludes these particular rows — but only because they predate the
sticky rail. The rail's link is `/go/airbnb?src=...&pos=rail`, so a crawler
following it from now on records `pos=rail` and lands squarely inside the
filter. This gets worse, not better.

## Options

**Record the signal, do not drop the row.** Preferred. Add the bot indicator
as a new blob rather than discarding the request, so history stays and the
dashboard filters. This follows the blob4 precedent: append, never insert,
because existing panels read blob1-3 positionally.

Free-plan Workers do not get `request.cf.botManagement`. What is available
is the user agent, which catches honest crawlers, and `request.cf.asn` or
`verifiedBotCategory` depending on plan. Worth checking what this zone
actually populates before designing the field.

**Do not filter in the Worker by dropping.** A dropped row is invisible, and
this project already has one bug from analytics failing silently — the
GitHub Pages fallback in ISS-26.

## Acceptance

- A recorded click can be identified as bot or not at query time.
- The conversion panels filter to non-bot clicks.
- Rows written before the change still work in every existing panel.
- The monitor canary is unaffected, or is updated with it.
