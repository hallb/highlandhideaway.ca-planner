---
id: ISS-20
title: Add justfile test-browser recipe with Playwright + axe-core
type: task
status: Backlog
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
  - ISS-9
checklist:
  - text: Add playwright.config.ts and initial tests in site repo
    done: false
  - text: Add justfile recipe test-browser (server + npx playwright test)
    done: false
  - text: Wire @axe-core/playwright for a11y assertions
    done: false
log: []
createdAt: 2026-03-25T03:09:35.290Z
updatedAt: 2026-03-25T03:09:35.290Z
---

Browser smoke and axe-based a11y checks for the Hugo site (not the DoIt theme submodule).

## Scope

- Add `playwright.config.ts`, initial spec(s), and `test-browser` just recipe that serves Hugo and runs Playwright.
- Use `@axe-core/playwright` for in-browser a11y assertions where useful.

## Related

Overlaps ISS-9 (Playwright + axe-core); implement at site root alongside justfile.