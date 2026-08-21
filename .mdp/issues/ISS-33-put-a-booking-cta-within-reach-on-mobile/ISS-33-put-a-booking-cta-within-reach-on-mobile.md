---
id: ISS-33
title: Put a booking CTA within reach on mobile
type: task
status: Done
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
log:
  - timestamp: 2026-08-21T02:46:49.651Z
    author: claude
    body: |-
      Branched, not yet merged, 2026-08-21. Site repo branch `iss-32-34`, commit 33f9020, PR https://github.com/hallb/highlandhideaway.ca/pull/7. Status stays In Progress until that merges and deploys.

      Built as the first of the two options here -- a slim bar below 900px -- with one design decision the issue left open. It is `position: sticky; bottom: 0` as the last child of `.hh-post`, not `position: fixed`. A sticky element can only travel inside its own parent, so the bar rides the bottom of the viewport for the length of the article and then comes to rest at the end of the post, above the footer. Fixed would have sat over whatever the page ended with, and the usual remedy for that is padding on the footer, which lands on every page at that width whether or not a bar was rendered there. Measured at the very bottom of a post: the bar rests at 705-772 and the footer occupies 772-844, fully visible.

      The second option, moving the card into the article flow, was not taken. It puts the CTA at one fixed point in a page of variable length, and a reader who scrolls past it has nothing after it.

      The placement reports `?pos=bar`. Named for the control rather than the viewport, which keeps it in the same family as `inline` and `rail` and stays accurate if the bar is ever shown at another breakpoint. blob4 is unchanged in shape and still appended, so no row already written is reinterpreted.

      One thing this issue did not ask for and the telemetry constraint turns out to require: the rail card is now hidden below 900px rather than left collapsed at the foot. Left in place it would have been a second booking CTA a screen apart from the first, and -- the load-bearing half -- it would still have reported `?pos=rail`. The dashboard groups on blob4, so those clicks would have gone into the desktop bucket and the rail/bar comparison this issue exists to enable would have been lost from the other direction. `.hh-book__ask` stays visible: it is the only route to the contact page from the foot of a post.

      Acceptance verified in headless Chromium at 390x844 across all 22 posts, not assumed. Before: no booking control on the first screen of any post except /posts/contact/, the first one sitting 75-86% down the page. After: the bar is on screen at scroll 0 on every post, and still on screen mid-scroll. Desktop measured at 1440x900 on the same two builds -- the rail reports top=524/361/229/24 at scrollY 0/400/1200/2400 before and after, identical, and the bar is display:none. Both palettes render; the bar reuses --hh-btn-bg on --hh-surface, pairs already checked for contrast in this file.

      The dashboard needed no query change -- the placement panels group on blob4 generically, so `bar` appears on its own. Their descriptions and grafana/README.md are updated to name it, since both previously said "whatever ISS-33 adds".

      That browser check is not in the repo. It needs Playwright and this repo still has no harness for it: ISS-17 and ISS-20 remain the place for it.
  - timestamp: 2026-08-21T04:02:30.000Z
    author: claude
    body: |-
      Done, 2026-08-21. Merged as b1d8f8c (squash of PR 7) and deployed. Verified against the live site, not the build: https://www.highlandhideaway.ca/posts/welcome/ carries .hh-bookbar, and /go/airbnb?src=%2Fverify-iss33%2F&pos=bar answers 302 to the listing, so the new placement records and redirects end to end.

      One note for whoever reads the dashboard next. That verification click was sent with curl, so the Worker classified it as a bot and it is filtered out of every panel except "Recent clicks", which is deliberately unfiltered so the classifier can be audited. It carries src=/verify-iss33/ and pos=bar. It is not excluded by name the way /canary/ and /verify-iss36/ are, because it does not need to be -- the bot verdict already removes it.
createdAt: 2026-08-20T21:10:08.297Z
updatedAt: 2026-08-21T03:32:22.821Z
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
