---
id: ISS-33
title: Put a booking CTA within reach on mobile
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
parent: ISS-32
relatedTo:
  - ISS-29
checklist: []
log: []
createdAt: 2026-08-20T21:10:08.297Z
updatedAt: 2026-08-20T21:10:08.297Z
---

## Requirement

The sticky rail works on desktop and does nothing useful below 900px. Split
from ISS-32, which holds the measurements this is based on.

`_hh.scss:255` collapses `.hh-grid` to one column and sets `.hh-book {
position: static; }`, so the card drops out of the grid and lands after the
article, above the footer. Measured at 390x844 on the built site, the first CTA
sits 75-86% down every post. Only 8 of 22 posts carry an inline `{{< book >}}`;
on the other 14 that card is the only booking control on the page.

Desktop behaviour is worth keeping as it is. Scrolling a post from 0 to 2400px,
the rail card stays pinned at `top=219` the whole way.

## Either approach works

- A slim sticky bar fixed to the bottom of the viewport below 900px.
- Move the card into the article flow after the second or third paragraph when
  the rail collapses.

## The telemetry constraint

Give the mobile placement its own `?pos=` value — not `rail`, not `inline`.

`partials/booking-url.html` takes `Position` in its dict and writes it to
`&pos=`; `src/worker.js:47` reads it and stores it as blob4. The Grafana panel
groups on blob4, so a mobile sticky bar reporting as `rail` cannot be told
apart from the desktop card, and the comparison this issue exists to enable is
lost. `partials/booking-cta.html:8` is where `"rail"` is currently passed.

Note blob4 is appended rather than inserted, deliberately: rows written before
the rail existed carry three blobs. Keep that property.

## Acceptance

- On a 390px viewport, every post puts a booking control within the first
  screen or two, not at the foot of the page.
- The mobile placement reports a `?pos=` value distinct from `rail` and
  `inline`, and the clicks dashboard groups on it.
- Desktop is unchanged: the rail still sticks at `top=24` from the grid.
