---
id: ISS-32
title: Mobile booking CTA, and finishing the home page
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
relatedTo:
  - ISS-16
  - ISS-30
checklist: []
log:
  - timestamp: 2026-08-20T21:10:54.409Z
    author: claude
    body: |-
      Split into ISS-33, ISS-34 and ISS-35 on 2026-08-20, and retitled. The measurement table stays here; the acceptance criteria moved to the children and are annotated above with which one owns each.

      Reason for the split: the three pieces have different shapes and different blockers. ISS-35 needs the owner to choose a photograph, and while all three sat in one ticket that choice blocked the other two. ISS-34 is the one with a clock on it — Search Console was verified on 2026-08-19 and Google has not crawled the property yet, so eleven h1s on the brand page are worth fixing before the first real crawl rather than after.
  - timestamp: 2026-08-21T02:46:49.374Z
    author: claude
    body: |-
      Two of the three children are branched, 2026-08-21. ISS-33 and ISS-34 are on site repo branch `iss-32-34`, PR https://github.com/hallb/highlandhideaway.ca/pull/7, commits 33f9020 and 3608c85. This stays In Progress: ISS-35 is untouched and still blocked on the owner choosing a photograph, which is the whole reason it was split out.

      The measurement table this issue was meant to keep did not survive the split -- the body was left empty. Restored below, from measurements taken against the built site before and after the two changes, so the parent again holds the numbers its children were written from.
  - timestamp: 2026-08-21T03:44:12.000Z
    author: claude
    body: |-
      All three children are branched, 2026-08-21. ISS-35 is on site repo branch `iss-35-home-hero`, commit 33f07a0, PR https://github.com/hallb/highlandhideaway.ca/pull/8, stacked on PR 7 which carries ISS-33 and ISS-34.

      The blocker that caused the split is gone: the owner chose the home page photograph on 2026-08-21, the same one the welcome post leads with. Nothing in this issue is now waiting on a decision -- it stays In Progress only until the two PRs merge and deploy.

      Home page measurements, updated for the hero. It is 2252px at 390px wide, against 2054px after ISS-34 alone and 9585px before it; still one h1; the hero is 300px tall at 390px and 420px at 1440px, above the fold at both.
createdAt: 2026-08-20T12:06:02.884Z
updatedAt: 2026-08-21T02:46:49.651Z
---

## Measurements

Taken with headless Chromium against the built site: `before` is main at
a921a1d, `after` is branch `iss-32-34`. Posts measured at 390x844, desktop at
1440x900. The children were written from the `before` column.

### The home page (ISS-34)

| | before | after |
|---|---|---|
| Height at 390px | 9585px | 2054px |
| `<h1>` elements | 11 | 1 |
| Post summaries rendered | 10 | 0 |
| `/page/2/` generated | yes | no |

The one remaining `<h1>` is the profile title. The other ten were the
blogroll, one per post summary.

### The first booking control on a post, at 390x844 (ISS-33)

`before` is the distance down the page to the first booking link; nothing was
on the first screen except on /posts/contact/. `after` is the sticky bar,
which is on screen at scroll 0 on every post and stays there while scrolling.

| Post | before | after |
|---|---|---|
| canadian-thanksgiving | inline, 76% | bar, on screen |
| canoe-launch-guide | rail, 90% | bar, on screen |
| contact | inline, 37% | inline, on screen |
| cooking-at-the-cottage | rail, 91% | bar, on screen |
| cottage-pantry-guide | rail, 88% | bar, on screen |
| cozy-night-in | rail, 89% | bar, on screen |
| getting-here-and-parking | rail, 86% | bar, on screen |
| guest-access | rail, 87% | bar, on screen |
| haliburton-studio-tour | inline, 81% | bar, on screen |
| hidden-gems-nearby | rail, 89% | bar, on screen |
| how-to-start-a-campfire | rail, 88% | bar, on screen |
| lighting-the-wood-stove | rail, 90% | bar, on screen |
| minden-pride | inline, 70% | bar, on screen |
| one-week-cottage-meal-plan | rail, 88% | bar, on screen |
| sleeping-arrangements | rail, 92% | bar, on screen |
| spring-at-the-hideaway | inline, 84% | bar, on screen |
| the-grounds | inline, 82% | bar, on screen |
| welcome | inline, 75% | bar, on screen |
| what-to-bring | rail, 91% | bar, on screen |
| whats-nearby | rail, 89% | bar, on screen |
| winter-at-the-hideaway | inline, 86% | bar, on screen |

Fourteen of the 22 posts carry no inline `{{< book >}}`, so on those the
collapsed rail card was the only booking control on the page.

### Desktop, unchanged (ISS-33)

`.hh-book` top offset on /posts/welcome/ at 1440x900, scrolling 0 to 2400:

| scrollY | before | after |
|---|---|---|
| 0 | 524 | 524 |
| 400 | 361 | 361 |
| 1200 | 229 | 229 |
| 2400 | 24 | 24 |

24px is the `top` in the sticky rule, so by 2400 it is pinned. The bar is
`display: none` at this width.

At the bottom of a post at 390x844 the bar comes to rest at 705-772 with the
footer at 772-844, so it never covers it.
