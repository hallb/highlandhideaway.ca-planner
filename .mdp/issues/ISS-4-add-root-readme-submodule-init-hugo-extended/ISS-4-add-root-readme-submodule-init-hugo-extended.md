---
id: ISS-4
title: "Add root README: submodule init, Hugo Extended"
type: task
status: To Do
priority: Medium
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
createdAt: 2026-03-25T03:01:30.814Z
updatedAt: 2026-03-25T03:25:30.542Z
---

## Requirement

Add a **root README** so contributors know how to clone submodules, run **Hugo Extended**, and build locally.

### Intended implementation (reverted locally)

- Document `git clone --recurse-submodules` and `git submodule update --init --recursive`.
- Document `hugo --minify` and that output goes to `public/` (gitignored).
- Optional: short section on **Goldmark `unsafe`** and trusted editors (cross-link ISS-14).
- Optional: how to bump the DoIt submodule (cross-link ISS-5).

### Acceptance

- A new maintainer can build the site from README alone.