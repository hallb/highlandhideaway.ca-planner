---
id: ISS-28
title: "Cloudflare Web Analytics, and decide on Google Analytics"
type: task
status: To Do
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
  - ISS-11
  - ISS-25
checklist:
  - text: Enable Cloudflare Web Analytics for the zone
    done: false
  - text: Decide whether to keep Google Analytics
    done: false
  - text: If dropping it, set params.analytics.enable = false
    done: false
log: []
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-18T21:40:00.000Z
---

## Requirement

Traffic numbers to sit alongside the conversion counts the Worker already
records. Cloudflare Web Analytics is free, cookieless, and needs no script
tag on a proxied zone.

## The Google Analytics decision

GA is still enabled with `anonymizeIP = true`. Cookieless analytics covers
what this site actually needs, so removing GA would close the consent
question in ISS-11 by removing the thing that raises it, rather than
answering it with a banner and a privacy page.

Cloudflare Web Analytics reports page views, referrers, paths and Core Web
Vitals. It has no custom events — which is why conversions go through the
Worker rather than through any analytics product.

## Acceptance

- Traffic is visible without a consent banner.
- ISS-11 can be closed or narrowed to whatever obligation remains.
