---
id: ISS-13
title: "Fix DoIt mobile menu: button semantics, aria-expanded, keyboard (override or fork)"
type: task
status: In Progress
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
log:
  - timestamp: 2026-08-21T02:04:13.258Z
    author: claude
    body: |-
      Branched, not yet merged, 2026-08-20. Site repo branch `iss-13-mobile-menu-a11y`, commit e92738e, PR https://github.com/hallb/highlandhideaway.ca/pull/6. Status stays In Progress until that merges and deploys.

      Built as described here with one deliberate departure: theme.ts is not forked. The plan was to copy all nine hundred lines of it to edit initMenuMobile, which would have meant carrying the theme's TypeScript forever to keep two of those lines current. It turned out not to be necessary. The theme closes the menu from three places -- the button, the backdrop mask, and the mobile search's cancel button -- and every one of them goes through the same `active` class on the toggle. A MutationObserver on that one class syncs aria-expanded across all three, and keeps doing so if the theme grows a fourth. That is assets/js/menu-mobile-a11y.js, forty lines, inlined at build time by the partial.

      Escape closes by clicking the button rather than by stripping the classes directly, so the body blur and mask bookkeeping the theme does around the same toggle stays in step. Focus then returns to the button, because the menu it was inside is display:none by that point and focus left on a hidden element strands the keyboard at the top of the document.

      The _custom.scss resets the plan called for were not needed either. Tailwind's preflight, which head/link.html loads first as css/main.css, already zeroes a button's border, padding, margin and background and sets font and colour to inherit. Rendered #header-mobile screenshots came out byte-identical to the previous build in both palettes, so the div-to-button swap is visually a no-op. The one style added is the focus ring, which a div never had a use for.

      The i18n/en.toml `openMenu` string was skipped: the site is single-language, and the label is deliberately "Menu" rather than "Open menu" -- a name that flips to "Close" while aria-expanded also reports "expanded" makes a screen reader announce the same state twice in two vocabularies.

      Acceptance verified in headless Chromium at 375x667, not assumed: Tab reaches the button in two presses, Space and Enter both open it, Escape closes it and returns focus, aria-expanded tracks all three close paths, and the ring renders. Fourteen checks, all passing. `node script/test` still passes and htmltest is clean over 140 documents.

      That browser check is not in the repo. It needs Playwright, and this repo has no package.json and no browser-test harness to put it in -- ISS-17 and ISS-20 are open for exactly that, and it belongs there rather than smuggled in here.
createdAt: 2026-03-25T03:01:36.825Z
updatedAt: 2026-08-21T02:04:13.258Z
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