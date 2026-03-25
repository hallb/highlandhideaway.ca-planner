---
id: ISS-22
title: "Hugo 0.15x: override DoIt init partial (remove .Site.Author check)"
type: task
status: To Do
priority: High
labels: []
assignee: null
milestone: M-1
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo: []
checklist: []
log: []
createdAt: 2026-03-25T03:25:42.448Z
updatedAt: 2026-03-25T03:25:42.448Z
---

## Requirement

**DoIt** `layouts/partials/init.html` references `if .Site.Author`, which **fails on newer Hugo** where `Site.Author` was removed (error: can't evaluate field Author). The site must build on the same Hugo version as CI.

### Intended implementation (reverted locally)

- Copy or override `layouts/partials/init.html` in the **site** repo and remove/guard the deprecated `.Site.Author` block (use `Params.author` only per Hugo guidance).

### Acceptance

- `hugo --minify` succeeds on pinned Extended Hugo without forking DoIt, or bump DoIt submodule if upstream fixed it first.