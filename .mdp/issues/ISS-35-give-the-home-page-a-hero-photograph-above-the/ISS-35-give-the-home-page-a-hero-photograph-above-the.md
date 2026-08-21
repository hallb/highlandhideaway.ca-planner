---
id: ISS-35
title: Give the home page a hero photograph above the fold
type: task
status: In Progress
priority: Medium
labels: []
assignee: null
milestone: M-4
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: ISS-32
relatedTo:
  - ISS-30
checklist: []
log:
  - timestamp: 2026-08-21T03:44:12.000Z
    author: claude
    body: |-
      Branched, not yet merged, 2026-08-21. Site repo branch `iss-35-home-hero`, commit 33f07a0, PR https://github.com/hallb/highlandhideaway.ca/pull/8, stacked on PR 7 because it builds on the home page changes in ISS-34. Status stays In Progress until both merge and deploy.

      The blocker cleared rather than being worked around: the owner chose the photograph on 2026-08-21 -- the same one the welcome post leads with, `/images/dock-autumn.jpg`. `content/_index.md` already named it as `featuredImage` and nothing rendered it, so most of this was wiring.

      Built as the notes here asked: the existing `.hh-hero` treatment, reused rather than reinvented. The hero markup moved out of `layouts/posts/single.html` into `partials/hero.html` and both layouts now call it, which is the only way "reuse the treatment" stays true a year from now. The extraction is a pure refactor and was checked as one -- every post page in the built site is byte for byte identical after it.

      This did need the `layouts/index.html` that ISS-34 deliberately did not add. That decision was right for ISS-34 and stopped being right here: the theme's home layout cannot put a hero above the content, so there was nothing left to configure. It is written the way `single.html` is -- a purpose-built replacement with the partials it calls listed in the header, not a copy of DoIt's home to keep in step forever.

      The find worth carrying forward: `params.home.posts.enable = false` from ISS-34 is not made redundant by the new layout, and removing it is a live trap. `baseof.html` calls `head/paginator.html` before any layout runs, so the home page gets paginated whether or not a layout draws a paginator. With the flag removed the build published /page/1/, /page/2/ and /page/3/ again, each a full copy of the new home page at its own URL -- three near-duplicates of the brand page, days before the first crawl (ISS-27). Caught by diffing the built output against the previous build, not by reading the template. Both the flag and the layout header now say so.

      Alt text is a new `heroAlt` front matter key describing the photograph rather than the property. The page description, which is what the alt fell back to, describes the cottage and tells a screen reader nothing about the image standing in for it. Posts read the same key through the shared partial; none set it yet, which is why their output did not move.

      DoIt's profile block is no longer drawn -- the hero carries the title, and the page is allowed exactly one h1. Its config stays in hugo.toml so deleting `layouts/index.html` restores the old home page exactly. The home page `<head>` was diffed and is byte-identical, so no Open Graph, canonical or JSON-LD moved with it.

      Acceptance verified in headless Chromium, not assumed: the photograph is above the fold at 390x844 (300px tall) and at 1440x900 (420px), carries the 800/1200/1600w WebP srcset with loading=eager and explicit dimensions, and has the alt text. One h1, eleven cards, every internal link resolves, no /page/N/ published, both palettes render, `node script/test` passes.
createdAt: 2026-08-20T21:10:30.174Z
updatedAt: 2026-08-21T03:10:38.214Z
---

## Requirement

The home page opens on the site avatar and the words "A peaceful retreat".
Split from ISS-32.

Posts got a full-bleed hero out of the editorial restyle — `.hh-hero`, 420px
tall and 300px under 900px, with the title and a "Category · Region" eyebrow
over a gradient. The home page did not, and there are photographs in the
library that would do the job. `content/_index.md` already sets
`featuredImage: /images/dock-autumn.jpg`, which nothing on the home page
currently renders.

## Blocked on a choice

Which photograph. That is the owner's call, not a decision to make from the
filenames, and it is why this is split from the rest of ISS-32 rather than
bundled with it.

## Notes for whoever picks it up

`layouts/posts/single.html` builds the hero: `fill 800x267 / 1200x400 /
1600x533 webp q80` with `Smart` as the anchor, explicit Width/Height so the
browser reserves the right box, and `Loading: eager`. Reuse that rather than
inventing a second hero treatment — the CSS contract in `_hh.scss` is already
written and `.hh-hero--textonly` covers the no-image case.

This will most likely land together with ISS-34, since both touch how the home
page is laid out, but it is a separate acceptance test and a separate blocker.

## Acceptance

- The home page shows a photograph of the property above the fold.
- It uses the existing `.hh-hero` treatment and responsive sources.
- The image has meaningful alt text.
