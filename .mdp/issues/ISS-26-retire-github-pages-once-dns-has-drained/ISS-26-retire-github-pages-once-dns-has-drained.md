---
id: ISS-26
title: Retire GitHub Pages once DNS has drained
type: task
status: To Do
priority: Medium
labels: []
assignee: null
milestone: M-5
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-25
checklist:
  - text: Confirm resolvers no longer return 185.199.108-111.153 for the apex
    done: false
  - text: Remove the custom domain from the repo's GitHub Pages settings
    done: false
  - text: Delete the CNAME file
    done: false
log: []
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-18T21:40:00.000Z
---

## Requirement

GitHub Pages still serves its last deployment to anyone whose resolver
holds its addresses. That is deliberate: those pages link straight to
Airbnb and convert correctly, so they are a working fallback while DNS
drains.

`.github/workflows/hugo.yml` has already been deleted, so the fallback is
frozen rather than tracking `main`.

## Do not rush this

Removing the custom domain from GitHub Pages takes the fallback away. Do
it once stale resolvers have expired — a day or two is ample — not before.

## Acceptance

- The apex and www resolve only to Cloudflare.
- Nothing in the repo refers to GitHub Pages.
