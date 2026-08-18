---
id: ISS-3
title: Enable Dependabot for GitHub Actions on highlandhideaway.ca site repo
type: task
status: Done
priority: Low
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
log:
  - date: 2026-08-18
    note: >-
      Added .github/dependabot.yml, monthly, github-actions. It immediately
      opened five PRs, which is a fair measure of how stale the actions were.
createdAt: 2026-03-25T03:01:30.649Z
updatedAt: 2026-08-18T21:55:00.000Z
---

## Requirement

Keep **GitHub Actions** dependencies current with low friction via Dependabot.

### Intended implementation (reverted locally)

- Add `.github/dependabot.yml` with `package-ecosystem: github-actions`, `directory: /`, `schedule.interval: monthly` (or weekly).

### Acceptance

- Dependabot opens PRs for `actions/checkout`, `peaceiris/actions-hugo`, `actions/upload-pages-artifact`, `actions/deploy-pages`, etc.