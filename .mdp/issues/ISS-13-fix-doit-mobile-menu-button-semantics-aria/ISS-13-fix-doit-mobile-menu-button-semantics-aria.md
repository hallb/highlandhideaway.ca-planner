---
id: ISS-13
title: "Fix DoIt mobile menu: button semantics, aria-expanded, keyboard (override or fork)"
type: task
status: To Do
priority: High
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
createdAt: 2026-03-25T03:01:36.825Z
updatedAt: 2026-03-25T03:26:02.790Z
---

## Requirement

Fix the mobile **hamburger** control so it is keyboard-accessible and exposes state to assistive tech.

### Intended implementation (reverted locally)

- Override `layouts/partials/header.html`: replace `<div id="menu-toggle-mobile">` with `<button type="button" … aria-controls="menu-mobile" aria-expanded="false" aria-label="…">`.
- Add `i18n/en.toml` string `openMenu` for the label (or use a fixed English string if single-language).
- Override `assets/js/theme.ts` (copied from DoIt): in `initMenuMobile`, toggle `aria-expanded` when opening/closing; sync on mask close and search-cancel path; on **Escape**, close menu and return focus to the button.
- Add `assets/css/_custom.scss` resets for `button.menu-toggle` (transparent background, border, focus-visible outline).

### Acceptance

- Focusable via Tab; Space/Enter toggles; Escape closes; screen readers announce expanded/collapsed.