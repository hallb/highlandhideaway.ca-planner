---
id: ISS-3
title: Enable Dependabot for GitHub Actions on highlandhideaway.ca site repo
type: task
status: To Do
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
log: []
createdAt: 2026-03-25T03:01:30.649Z
updatedAt: 2026-03-25T03:25:09.983Z
---

## Requirement

Keep **GitHub Actions** dependencies current with low friction via Dependabot.

### Intended implementation (reverted locally)

- Add `.github/dependabot.yml` with `package-ecosystem: github-actions`, `directory: /`, `schedule.interval: monthly` (or weekly).

### Acceptance

- Dependabot opens PRs for `actions/checkout`, `peaceiris/actions-hugo`, `actions/upload-pages-artifact`, `actions/deploy-pages`, etc.