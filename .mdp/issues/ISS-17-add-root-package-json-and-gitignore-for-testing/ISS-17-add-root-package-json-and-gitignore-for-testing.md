---
id: ISS-17
title: Add root package.json and .gitignore for testing toolchain
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
  - text: "Create package.json with devDependencies: pa11y-ci, @playwright/test, @axe-core/playwright"
    done: false
  - text: "Add node_modules/ to highlandhideaway.ca/.gitignore"
    done: false
log: []
createdAt: 2026-03-25T03:09:34.667Z
updatedAt: 2026-03-25T03:09:34.667Z
---

Prerequisite for other test recipes in the Hugo site repo (highlandhideaway.ca/).

## Scope

- Add root `package.json` with pinned devDependencies for pa11y-ci, Playwright, and axe-core Playwright integration.
- Add `node_modules/` to `.gitignore`.

## Context

Deferred from the justfile bootstrap work; tracked here under M-2 Automated quality.