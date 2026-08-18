---
id: M-5
title: Cloudflare migration
status: Active
priority: High
labels: []
startDate: 2026-08-18
dueDate: null
checklist: []
log:
  - date: 2026-08-18
    note: >-
      Cutover completed the same day it started. The site now serves from a
      Cloudflare Worker with static assets; GitHub Pages is retained,
      unmaintained, as a fallback while resolvers still hold its addresses.
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-18T21:40:00.000Z
---

## Goals

Move highlandhideaway.ca off GitHub Pages onto Cloudflare, and make the
one conversion the site can measure — an outbound click to the Airbnb
listing — countable.

Airbnb gives hosts no booking attribution, so the funnel ends at the
click. Everything here exists to make that click observable and to keep
the htmltest gate in front of production.

## Shape

Static assets deploy as a Worker via `wrangler deploy` + `[assets]`,
matching `tools-portfolio/sites/rural`. It diverges from that repo on one
axis deliberately: GitHub Actions deploys rather than Cloudflare's Git
integration, so the deploy job's `needs: build` makes the link check
structural instead of a branch-protection setting kept outside the repo.
