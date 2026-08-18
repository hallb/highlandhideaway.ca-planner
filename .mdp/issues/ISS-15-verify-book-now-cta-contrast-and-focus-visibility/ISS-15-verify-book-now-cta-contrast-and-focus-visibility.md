---
id: ISS-15
title: Verify Book now CTA contrast and focus visibility
type: task
status: Done
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
log:
  - date: 2026-08-18
    note: >-
      assets/css/_custom.scss gives .book-cta__link a :focus-visible outline
      with offset, and the colours are documented against WCAG AA: #1d4ed8 on
      white is 7.0:1 either way.
createdAt: 2026-03-25T03:01:37.026Z
updatedAt: 2026-08-18T21:55:00.000Z
---

## Requirement

Ensure the home **Book now on Airbnb** control (inline `<a>` in `_index.md`) is perceivable and operable for keyboard users.

### Intended implementation (reverted locally)

- Add `_custom.scss` rules for `:focus-visible` on the Airbnb link (outline + offset) so focus is not lost against the blue button styling.

### Acceptance

- Visible focus ring on keyboard tab; contrast still meets WCAG for text + background (verify).