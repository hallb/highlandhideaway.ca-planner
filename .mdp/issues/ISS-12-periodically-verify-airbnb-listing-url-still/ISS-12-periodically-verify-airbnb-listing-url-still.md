---
id: ISS-12
title: Periodically verify Airbnb listing URL still resolves to property
type: task
status: To Do
priority: Low
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
log:
  - date: 2026-08-18
    note: >-
      The listing URL now lives in one place, params.booking.url, and all ten
      CTAs reach it through the Worker at /go/airbnb. That makes a rot check
      cheap to add. Still nothing verifies it: .htmltest.yml sets
      CheckExternal: false, so CI checks none of the eight outbound links in
      the content.
createdAt: 2026-03-25T03:01:36.683Z
updatedAt: 2026-08-18T21:55:00.000Z
---
