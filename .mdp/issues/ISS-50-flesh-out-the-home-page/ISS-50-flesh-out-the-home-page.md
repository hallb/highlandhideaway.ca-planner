---
id: ISS-50
title: Flesh out the home page
type: task
status: To Do
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
  - ISS-27
  - ISS-31
checklist:
  - text: Ask Ben the questions under Interrogate Ben before drafting anything
    done: false
  - text: Settle whether the home page sells, routes, or does both
    done: false
  - text: Load the writing-as-ben skill before writing prose
    done: false
  - text: Draft the prose; keep the existing card navigation intact
    done: false
  - text: Attribute every fact Ben supplies in a dated source comment
    done: false
  - text: Build, run htmltest, and grep the whole build output for comment leakage
    done: false
log: []
createdAt: 2026-08-31T17:07:01.351Z
updatedAt: 2026-08-31T17:07:01.351Z
---

## Requirement

`content/_index.md` in the site repo carries **73 words of prose**. Everything
else on it is card navigation. It is the thinnest important page on the site
and the highest-leverage one to fix.

Write it out to something that can rank and can sell, without inventing
anything.

## Where it stands

The prose is two paragraphs:

> Highland Hideaway is a cottage on 23 acres of forest near Haliburton,
> Ontario. Three bedrooms, one bathroom, a wood stove, and a fire pit with
> benches.
>
> The guides below cover the things guests usually ask about before they
> arrive: where to park, which bed is which, and how to get the stove going on
> the first try.

Then `{{< book >}}`, then three card groups (Before you arrive / While you are
here / The area), then a line pointing at `/posts/contact/`.

Be fair to what is there. The hub structure is good, the hero and the mobile
booking bar landed in ISS-33/34/35, and `heroAlt` is set properly. The page is
not broken. It simply has almost no content, so there is nothing for a search
engine to match and nothing for a visitor to be persuaded by.

## Why this one first

Measured across the whole site, the median published page is 208 words and 20
of 28 are under 300. The home page is the worst of them at 73, and it is also:

- the strongest candidate for the head query, some variant of "Haliburton
  cottage rental", which is the query with the most volume and the most intent
- where direct, social and any future paid traffic lands
- the page Google weighs most heavily for the site as a whole
- the page that already has the conversion furniture, so substance is the only
  missing part

The August audit concluded that depth on the pages worth ranking is the work,
and rated it well above anything else on the board. Nothing since has changed
that.

This one does not need to wait for Search Console. It is obviously
under-written and the work is the same whatever the queries say. ISS-27 is
closed and query data was estimated to land between 2 and 16 September; use it
to steer the *area* pages, not this one.

## Interrogate Ben

None of the below is guessable and the page will be generic without it. Ask,
and do not fill in from memory or from what other rental listings say.

- **Who does it suit, and who does it not suit?** Couples, families with small
  children, groups of six adults, dog owners. The honest negative is as useful
  as the positive and stops bad bookings.
- **What do guests actually say?** If there are Airbnb reviews, the recurring
  phrases in them are the real copy. What do people mention unprompted?
- **What makes it different** from the other rentals in the Highlands? One
  concrete thing, not an adjective.
- **The story.** Why this place, how long, what was it before. A rental with a
  person behind it converts better than an anonymous listing, and `about.md` is
  111 words, so there is little to borrow.
- **Which seasons are underbooked?** The home page should lean toward the
  season being sold, not the one in the photographs.
- **Is there a direct-booking path**, or is it Airbnb only? It changes the call
  to action.
- **The basics guests filter on**: pets, smoking, quiet hours. ISS-39 is still
  open and covers this; if he answers here, close part of that too.
- **Does he want the home page to sell or to route?** Right now it routes. The
  recommendation is that it should do both, but it is his call and it changes
  the shape.

## House rules that bite here

- **Voice.** There is a `writing-as-ben` skill. Load it. Plain language, short
  declaratives, Canadian spelling (colour, favour, ploughed), no idioms, no
  marketing adjectives, dry humour in small asides only.
- **No unverified numbers.** Precedent: the drive to Gooderham sat in a brief
  as "30 minutes" on the owner's say-so and turned out to be 22. Measure, or
  attribute and date it.
- **Owner-only facts get marked as HTML comments** in the Markdown. That is the
  site convention. They are stripped from the built pages and, since site
  commit 03269fd, from the feeds too. Verify with a grep over the *whole* build
  output, not just the HTML. See ISS-31, whose caveat was wrong about this for
  months.
- **Never state the Airbnb minimum stay.** Ben expects to keep changing it and
  does not want a number on the site that goes stale. It was removed from two
  pages on 2026-08-31.
- **Promise nothing he has not confirmed.** Precedent: on the Corduroy post he
  declined to claim trailer parking, bike washing or gear drying, and a
  disclaimer drafted in their place was also cut. Silence is an acceptable
  answer.
- **Check link targets exist and are not drafts** before publishing. A previous
  post shipped with two links stripped because the target was still a draft.
- **Build and run htmltest** before committing: `hugo --gc --minify` then
  `htmltest -c .htmltest.yml public`.
- Commit messages in this repo are long-form and explain the reasoning, not
  just the change.

## Acceptance criteria

- The prose says what the place is, who it suits, what the area gives you, and
  why to come in the season being sold.
- Every factual claim is either already published elsewhere on the site, or
  supplied by Ben and attributed in a source comment with the date.
- No invented amenity, distance, or superlative.
- The card navigation survives. It works, and the new prose sits with it rather
  than replacing it.
- Builds clean, htmltest passes, no comment text anywhere in the build output.
