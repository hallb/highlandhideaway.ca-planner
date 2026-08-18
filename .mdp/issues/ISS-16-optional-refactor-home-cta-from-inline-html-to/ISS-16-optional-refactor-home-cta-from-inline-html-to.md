---
id: ISS-16
title: "Optional: refactor home CTA from inline HTML to theme CSS/shortcode"
type: task
status: Done
priority: Low
labels: []
assignee: null
milestone: M-4
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
      Replaced the inline HTML CTA with a {{< book >}} shortcode reading
      params.booking.url. That indirection is what made routing every button
      through /go/airbnb a one-line config change.
createdAt: 2026-03-25T03:01:37.277Z
updatedAt: 2026-08-18T21:55:00.000Z
---
