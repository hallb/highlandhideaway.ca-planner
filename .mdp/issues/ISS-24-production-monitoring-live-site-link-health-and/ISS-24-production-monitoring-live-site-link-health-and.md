---
id: ISS-24
title: "Production monitoring: live site link health and uptime"
type: task
status: To Do
priority: Low
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
log: []
createdAt: 2026-03-25T03:37:03.256Z
updatedAt: 2026-03-25T03:37:37.505Z
---

## Requirement

Define and implement **production monitoring** for the deployed site, beyond PR-time **htmltest** on static output (ISS-6).

### Scope (future)

- **Link health** on the live origin (recursive crawl or sitemap-based checks).
- Optional **uptime** or synthetic checks and alerting.

### Tool options (evaluate when implementing)

- **[Muffet](https://github.com/raviqqe/muffet)** — HTTP crawler from production base URL(s).
- **[lychee](https://github.com/lycheeverse/lychee)** — sitemap or URL list; see **ISS-7** for a scheduled workflow sketch.
- External uptime / status services if desired.

### Notes

- Complements **ISS-6** (CI on `./public`) and **ISS-7** (optional scheduled prod link check); consolidate tooling where it makes sense.