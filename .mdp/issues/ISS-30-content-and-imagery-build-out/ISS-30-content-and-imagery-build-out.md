---
id: ISS-30
title: Content and imagery build-out
type: task
status: Done
priority: High
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-6
  - ISS-10
checklist: []
log:
  - date: 2026-08-18
    note: >-
      Delivered in repo commit bd783ae. 21 pages written from 11-22 word stubs,
      41 images published, and the htmltest ignore that had been concealing the
      problem removed. Verified: htmltest passes across 126 documents with no
      image ignore in place.
createdAt: 2026-08-18T21:55:00.000Z
updatedAt: 2026-08-18T21:55:00.000Z
---

## What this was

Never filed as an issue, which is why the largest piece of work in the
project was invisible to this planner.

Every post was an 11-22 word stub, and 18 hero images referenced across 19
posts did not exist. `.htmltest.yml` carried `IgnoreURLs: ["^/images/"]`,
sanctioned by ISS-6 as "assets not in repo yet", which meant the link check
passed while every post shipped a broken image.

## Delivered

- 21 pages written, including three new ones: the grounds, spring at the
  hideaway, and a photos gallery.
- 41 images converted from tiled HEIC and published at 1600px with EXIF
  stripped, since several carried GPS for a private residence.
- The `^/images/` ignore deleted, so the gate tells the truth.
- Post dates spread across Oct 2024 - Jul 2026, with each seasonal post in
  its own season.

## Note on the source images

The HEICs are tiled: each photo is 48 separate 512x512 HEVC streams. A naive
`ffmpeg -i x.heic out.jpg` silently yields one 512x512 corner tile, and every
file also carries an `irot` rotation the filter path bypasses. Both failures
produce a plausible-looking image, so they need checking by eye rather than by
exit code.
