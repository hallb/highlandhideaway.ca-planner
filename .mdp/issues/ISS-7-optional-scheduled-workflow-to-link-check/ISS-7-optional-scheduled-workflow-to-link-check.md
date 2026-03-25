---
id: ISS-7
title: "Optional: scheduled workflow to link-check production URL"
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
relatedTo: []
checklist: []
log: []
createdAt: 2026-03-25T03:01:35.487Z
updatedAt: 2026-03-25T03:25:10.502Z
---

## Requirement

Periodically verify **production** URLs still respond and link correctly (scheduled smoke), separate from PR-time htmltest on `public/`.

### Intended implementation (reverted locally)

- Workflow `link-check-prod.yml` on `schedule` (e.g. weekly) + `workflow_dispatch`.
- Use **lychee** (or similar) against `https://highlandhideaway.ca/sitemap.xml` with a polite User-Agent and bounded concurrency.

### Acceptance

- Failures notify the team that prod or external links broke (Airbnb, CDN, etc.).