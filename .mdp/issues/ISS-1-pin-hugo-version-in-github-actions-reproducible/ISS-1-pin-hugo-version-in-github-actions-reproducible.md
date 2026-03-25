---
id: ISS-1
title: Pin Hugo version in GitHub Actions (reproducible builds)
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
createdAt: 2026-03-25T03:01:30.299Z
updatedAt: 2026-03-25T03:24:24.895Z
---

## Requirement

Pin the **Extended Hugo** version used in GitHub Actions so production builds are reproducible and not subject to silent `latest` drift.

### Intended implementation (reverted locally)

- Define `env.HUGO_VERSION` (example value used: `0.159.0`) at the workflow level.
- Pass `hugo-version: ${{ env.HUGO_VERSION }}` to `peaceiris/actions-hugo`.
- Bump `peaceiris/actions-hugo` from **v2** to **v3** when applying the pin.

### Acceptance

- CI and local docs agree on a single pinned minor/patch line for Extended Hugo.
- Bumping Hugo is an explicit commit, not an accidental CI change.