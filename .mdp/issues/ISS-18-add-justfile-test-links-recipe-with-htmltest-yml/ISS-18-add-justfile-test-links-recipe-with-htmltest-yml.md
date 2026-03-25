---
id: ISS-18
title: Add justfile test-links recipe with .htmltest.yml
type: task
status: Backlog
priority: Medium
labels: []
assignee: null
milestone: M-2
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-6
checklist:
  - text: Add .htmltest.yml for scanning public/
    done: false
  - text: Add justfile recipe test-links (build then htmltest)
    done: false
log: []
createdAt: 2026-03-25T03:09:34.854Z
updatedAt: 2026-03-25T03:09:34.854Z
---

Implement local link checking for the Hugo site.

## Scope

- Add `.htmltest.yml` configuring htmltest to scan `public/` after build.
- Add `test-links` recipe to the site `justfile`: run `hugo --minify` (or build), then `htmltest` on output.

## Related

Complements ISS-6 (CI htmltest); keep local and CI configs aligned.