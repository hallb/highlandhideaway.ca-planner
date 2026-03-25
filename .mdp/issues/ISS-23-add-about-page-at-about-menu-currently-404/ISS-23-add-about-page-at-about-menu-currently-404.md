---
id: ISS-23
title: Add About page at /about/ (menu currently 404)
type: task
status: To Do
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
log: []
createdAt: 2026-03-25T03:25:42.642Z
updatedAt: 2026-03-25T03:25:42.642Z
---

## Requirement

Main menu includes **About** → `/about/` but there was no page; links 404.

### Intended implementation (reverted locally)

- Add `content/about.md` (or section) describing the property briefly and linking to posts/contact as appropriate.

### Acceptance

- `/about/` resolves; htmltest passes for menu links.