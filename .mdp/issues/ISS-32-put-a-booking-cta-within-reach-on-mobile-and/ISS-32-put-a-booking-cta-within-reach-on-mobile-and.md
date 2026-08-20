---
id: ISS-32
title: Put a booking CTA within reach on mobile, and finish the home page
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
relatedTo:
  - ISS-16
  - ISS-30
checklist: []
log: []
createdAt: 2026-08-20T12:06:02.884Z
updatedAt: 2026-08-20T12:06:02.884Z
---

## Requirement

The sticky booking rail landed with the editorial post layout and works well on
desktop. Below 900px it does nothing useful. This issue covers the mobile
placement, and the two home page problems the restyle left behind.

## The mobile CTA

Below 900px the rail drops out of the grid and lands after the article. Measured
against the built site at 390x844:

| Page | Height | CTAs | First CTA |
|---|---|---|---|
| `/` | 9585px | 1 | 524px (5% down) |
| `/posts/welcome/` | 2319px | 2 | 1743px (75%) |
| `/posts/canadian-thanksgiving/` | 3077px | 2 | 2324px (76%) |
| `/posts/haliburton-studio-tour/` | 3683px | 2 | 2967px (81%) |
| `/posts/getting-here-and-parking/` | 1873px | 1 | 1608px (86%) |

Only 8 of the 22 posts carry an inline `{{< book >}}`. On the other 14 the rail
card is the only booking control on the page, sitting below the last paragraph
and above the footer. The restyle also made posts taller, so the first CTA is
now further down than it was before it: the studio tour post moved from 2713px
to 2967px.

Desktop is the opposite, and worth keeping. Scrolling that same post from 0 to
2400px, the rail card stays pinned at `top=219` the whole way.

Either fix works:

- A slim sticky bar at the bottom of the viewport below 900px.
- Move the card into the article flow after the second or third paragraph when
  the rail collapses.

Whichever it is, give it its own `?pos=` value rather than reusing `pos=rail`.
The Grafana panel reads placement from blob4, and a mobile sticky bar that
reports as the desktop rail cannot be told apart from it.

## The home page

Two things, both visible on the live site now.

**The blogroll below the cards.** The guide cards stop around 900px and DoIt's
default post list runs for the remaining 8300. It renders the opening
paragraphs of ten posts, each under its own `<h1>`, so the home page carries
eleven of them. This predates the restyle and is not a regression, but the join
between the styled cards and the theme default is now obvious, and eleven h1s
on the page most likely to rank for the brand is worth fixing on its own.

**Nothing to look at above the fold.** The home page opens on the avatar and
the words "A peaceful retreat". Posts got a full-bleed hero out of this work;
the home page did not, and there are photographs in the library that would do
the job.

## Acceptance

- On a 390px viewport, every post puts a booking control within the first
  screen or two, not at the foot of the page.
- The mobile placement reports a `?pos=` value distinct from `rail` and
  `inline`, and the clicks dashboard groups on it.
- The home page has one `<h1>`.
- The home page shows a photograph of the property above the fold.
