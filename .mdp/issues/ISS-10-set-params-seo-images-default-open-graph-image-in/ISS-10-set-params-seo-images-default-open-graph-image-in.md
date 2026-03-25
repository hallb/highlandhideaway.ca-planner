---
id: ISS-10
title: Set params.seo.images / default Open Graph image in hugo.toml
type: task
status: To Do
priority: Medium
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo: []
checklist: []
log: []
createdAt: 2026-03-25T03:01:36.132Z
updatedAt: 2026-03-25T03:25:09.209Z
---

## Requirement

Improve default **Open Graph / Twitter** metadata so link previews are consistent when pages do not set their own image.

### Intended implementation (reverted locally)

- Set `[params] version` to match the checked-out **DoIt** submodule (e.g. `0.4.2`) so footer/theme strings stay honest.
- Set `[params.seo] images` to a default static path (e.g. `["/images/welcome.jpg"]`) once that file exists under `static/`.
- Set `[params.seo.twitter] card` to `summary_large_image` when a default hero image is available.

### Acceptance

- Sharing the home URL shows title, description, and a representative image in Slack/iMessage/X.