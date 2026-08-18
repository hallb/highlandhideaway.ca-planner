---
id: ISS-23
title: Add About page at /about/ (menu currently 404)
type: task
status: Done
priority: Medium
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo: []
checklist: []
log:
  - date: 2026-08-18
    note: >-
      Delivered by repo commit ac2d98e -- content/about.md exists and /about/
      resolves.
createdAt: 2026-03-25T03:25:42.642Z
updatedAt: 2026-08-18T21:55:00.000Z
---

## Requirement

Main menu includes **About** → `/about/` but there was no page; links 404.

### Intended implementation (reverted locally)

- Add `content/about.md` (or section) describing the property briefly and linking to posts/contact as appropriate.

### Acceptance

- `/about/` resolves; htmltest passes for menu links.