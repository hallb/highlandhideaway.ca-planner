---
id: ISS-1
title: Pin Hugo version in GitHub Actions (reproducible builds)
type: task
status: Done
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
log:
  - date: 2026-08-18
    note: >-
      Pinned to Hugo 0.159.0 with actions-hugo v3, repo commit 3760091. The
      pin now lives in .github/workflows/cloudflare.yml; hugo.yml was deleted
      when GitHub Pages stopped being the deploy target.
createdAt: 2026-03-25T03:01:30.299Z
updatedAt: 2026-08-18T21:55:00.000Z
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