---
id: ISS-35
title: Give the home page a hero photograph above the fold
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
parent: ISS-32
relatedTo:
  - ISS-30
checklist: []
log: []
createdAt: 2026-08-20T21:10:30.174Z
updatedAt: 2026-08-20T21:10:30.174Z
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
