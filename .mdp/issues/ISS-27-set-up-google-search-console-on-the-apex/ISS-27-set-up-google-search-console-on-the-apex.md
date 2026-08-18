---
id: ISS-27
title: Set up Google Search Console on the apex
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
  - ISS-25
checklist:
  - text: Verify a Domain property by TXT record in Cloudflare DNS
    done: false
  - text: Submit https://highlandhideaway.ca/sitemap.xml
    done: false
  - text: Check Coverage for "Page with redirect" on any www URLs
    done: false
log: []
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-18T21:40:00.000Z
---

## Requirement

Search Console is the only tool that reports the queries people used to
find the site, which is what should decide the next posts. It is free and
has no privacy cost.

## Use the apex, not www

`baseURL` and every canonical tag now say the apex; www 301s to it. A
Domain property covers both hostnames and survives that redirect, so it is
the right choice here.

## Note

DNS is on Cloudflare, so the TXT verification is a two-minute job.
