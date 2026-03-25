---
id: ISS-15
title: Verify Book now CTA contrast and focus visibility
type: task
status: To Do
priority: Medium
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
log: []
createdAt: 2026-03-25T03:01:37.026Z
updatedAt: 2026-03-25T03:26:03.070Z
---

## Requirement

Ensure the home **Book now on Airbnb** control (inline `<a>` in `_index.md`) is perceivable and operable for keyboard users.

### Intended implementation (reverted locally)

- Add `_custom.scss` rules for `:focus-visible` on the Airbnb link (outline + offset) so focus is not lost against the blue button styling.

### Acceptance

- Visible focus ring on keyboard tab; contrast still meets WCAG for text + background (verify).