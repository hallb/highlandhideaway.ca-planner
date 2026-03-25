---
id: ISS-8
title: Add Lighthouse CI with assertions on built site
type: task
status: To Do
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
checklist: []
log: []
createdAt: 2026-03-25T03:01:35.672Z
updatedAt: 2026-03-25T03:24:26.402Z
---

## Requirement

Add **Lighthouse CI** to the pipeline with assertions on **accessibility**, **best-practices**, and **SEO** categories against the static `public/` output.

### Intended implementation (reverted locally)

- Add `lighthouserc.json` at repo root (`ci.collect.staticDistDir: ./public`, `ci.assert` thresholds appropriate for a static blog).
- In CI: `actions/setup-node` (e.g. Node 22), then `npx @lhci/cli@0.14.0 autorun` (pin major/minor as needed).

### Acceptance

- Fails the build on severe a11y/SEO regressions; tune scores so flaky perf does not block unrelated edits.