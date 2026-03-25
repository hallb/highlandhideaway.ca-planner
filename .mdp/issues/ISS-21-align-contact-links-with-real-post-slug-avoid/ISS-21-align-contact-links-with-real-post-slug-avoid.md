---
id: ISS-21
title: Align Contact links with real post slug (avoid broken /posts/contact/)
type: task
status: To Do
priority: High
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-6
checklist: []
log: []
createdAt: 2026-03-25T03:25:30.902Z
updatedAt: 2026-03-25T03:25:30.902Z
---

## Requirement

Home page and nav must link to a **published** contact post URL. The previous target `/posts/contact/` may not exist or may conflict with Hugo/DoIt when using certain slugs (investigate build errors when adding `contact.md`).

### Intended implementation (reverted locally)

- Update `[content/_index.md](highlandhideaway.ca/content/_index.md)` links from `/posts/contact/` to a working slug (example used: `/posts/contact-us/`).
- Ensure a matching Markdown file exists under `content/posts/` with that slug, or add `aliases` from old URL.

### Acceptance

- `htmltest` and manual click-through show no 404 for “Contact” from the home page.
- Document chosen slug and any Hugo constraint in ISS or README.