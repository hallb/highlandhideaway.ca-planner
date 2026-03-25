---
id: ISS-19
title: Add justfile test-a11y recipe with pa11y-ci
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
relatedTo: []
checklist:
  - text: Add .pa11y-ci.json (paths or URLs against local server)
    done: false
  - text: Add justfile recipe test-a11y (Hugo server + pa11y-ci)
    done: false
log: []
createdAt: 2026-03-25T03:09:35.072Z
updatedAt: 2026-03-25T03:09:35.072Z
---

Headless WCAG-oriented checks against the running site.

## Scope

- Add `.pa11y-ci.json` pointing at `http://localhost:1313/` with paths or sitemap as appropriate.
- Add `test-a11y` recipe: start Hugo server, run pa11y-ci, stop server (or use a pattern that works in CI later).

Depends on package.json issue for `pa11y-ci` devDependency.