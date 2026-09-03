---
id: ISS-51
title: Flesh out the sleeping arrangements page
type: task
status: In Progress
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
  - ISS-31
  - ISS-45
checklist:
  - text: Resolve the cot and trundle contradiction between the home page card and this post
    done: true
  - text: Get the maximum occupancy from the Airbnb listing and make the site agree with it
    done: true
  - text: Get the seated capacity of the dining table -- also answers Q11 on ISS-45
    done: true
  - text: Get an honest hot water answer to replace normal residential size
    done: false
  - text: Room by room -- who each suits, noise between them, blinds, locks, cooling
    done: false
  - text: Settle the linens policy across this page, the home page card and what-to-bring
    done: true
  - text: Build, run htmltest, and grep the whole build output for comment leakage
    done: true
log:
  - timestamp: 2026-09-03T02:03:23.271Z
    author: claude
    body: |-
      Written and live. Ben answered the interrogation list on 2026-09-02 and the post was rewritten the same day: 129 words to 366. Site repo working tree, not yet committed.

      His answers, and what each one did to the page.

      The cot and trundle contradiction is resolved, and both were real. There is a folding bed in the side bedroom's closet and a trundle under the bed in the main bedroom, both singles. Ben asked for "folding bed" rather than "cot", because a cot reads as a small child's bed. The home page card now says "Three queens, plus a folding bed and a trundle" and the post describes both where they live.

      Maximum occupancy on the Airbnb listing is six, and the two singles do not raise it. That was the trap in this issue: three queens plus two singles reads as eight to anybody counting beds. The page says six, then says what the singles are for, so the arithmetic cannot be done wrong.

      Seated capacity is six at the dining table and six in The Sanctuary, more if people are willing to be crowded. This was already on /posts/cooking-at-the-cottage/ and had been since 2026-08-18, so the claim in this issue that no seated capacity appeared anywhere on the site was wrong. Not repeated on this page. It also answers Q11 on ISS-45.

      Rooms are all close in size, the main only a little larger, and the curtains darken them properly. That turns into a section saying which room to take matters less than you would think, which is more useful to a group booking than three furniture descriptions were.

      Cooling and heat are new and are the strongest practical content on the page. Ceiling fan in every bedroom, portable fans to move around, baseboards and thermostats keeping every room comfortable with or without the wood stove. The summer advice is his, near enough verbatim: open the windows overnight, close them as the outside temperature climbs unless there is a breeze, because open windows do not cool the place when it is hotter outside than in.

      One bathroom, no second toilet, stated plainly with a line about agreeing an order the night before. No crib and no pack-n-play, so guests bring their own.

      Linens are unchanged and re-confirmed: none supplied, pillows and duvets are here, guests bring sheets, pillow cases, duvet covers and towels. The page now also says to bring single bedding if the folding bed or the trundle is going to be used, which follows from the policy and had not been said anywhere.

      Two items stay open, and neither is writing.

      Hot water. Asked, and Ben does not know how many showers back to back the tank gives. The old line "the hot water tank is a normal residential size" was removed rather than kept: it reads as reassurance and tells a party of six nothing. The page now says nothing about hot water, which is the honest position until somebody measures it. Marked as a TODO comment in the file.

      Noise between rooms, and whether the bedroom doors lock. Not answered, so the page says nothing either way. Both matter to a group of adults sharing a booking. Also a TODO comment in the file.

      Verified: hugo --gc --minify builds clean, htmltest passes on 182 documents. Comment leakage checked by taking every five-word window unique to the source comments on the five edited files and scanning all 558 files in the build output, feeds and sitemap included. One phrase matched, "posts cooking at the cottage", which is the URL /posts/cooking-at-the-cottage/ appearing as a link across the site, not comment text. No comment markers anywhere except theme.min.js.
createdAt: 2026-08-31T17:07:51.862Z
updatedAt: 2026-09-03T02:03:23.271Z
---

## Requirement

`content/posts/sleeping-arrangements.md` carries **125 words**. It is the page
that answers "will my group fit", which is the question most likely to decide a
booking, and it does not currently answer it.

## Where it stands

Three bedrooms, all on one floor, each with a queen bed, "each room sleeps two
comfortably". One paragraph each on the side room, the corner room and the main
bedroom, mostly describing furniture. Then linens (guests bring their own
towels and queen linens; blankets and duvets are in two closets; two pillows a
bed) and the bathroom (one, shared, tub and shower, "the hot water tank is a
normal residential size").

## There is a contradiction to resolve first

The home page card for this post reads:

> Sleeping arrangements — **Three queens, plus a cot and a trundle**

The post itself mentions no cot and no trundle. One of the two is wrong, and
they disagree about sleeping capacity, which is the single most consequential
number on the site. Resolve this before writing anything else, and fix whichever
page is wrong.

## Why this one

Twice in the last fortnight this page was the only source for a capacity claim
and had nothing to give. Both the Corduroy and the American Thanksgiving posts
needed "how many people, sleeping and seated", and both had to fall back on
"three bedrooms, three queens, one bathroom" because that is all there is.

The gaps that matter are not decorative:

- no seated capacity anywhere on the site, so a group of eight cannot tell
  whether it can eat together
- one bathroom for six is a real constraint and is stated as a fact rather than
  addressed
- "a normal residential size" hot water tank tells a party of six nothing about
  whether the last person gets a cold shower
- nothing about which room suits whom, which is what people planning a shared
  booking actually need

## Interrogate Ben

- **The cot and the trundle.** Do they exist? Where are they stored, what sizes,
  what weight or age are they suitable for, and do they change the maximum
  occupancy?
- **What is the maximum occupancy on the Airbnb listing?** The site should not
  contradict it.
- **How many does the dining table seat?** This also answers Q11 on ISS-45, so
  the answer closes work in two places.
- **The bathroom.** One for six. Is there a second toilet anywhere, and what is
  the realistic morning routine for a full house?
- **Hot water.** How many showers back to back before it runs out? An honest
  number beats "normal residential size".
- **Room by room**: which suits a couple, which suits children, how much noise
  passes between them, do the doors lock, are there blinds that actually darken
  the room, is there a fan or any cooling in summer.
- **Winter heat per room.** The baseboard heaters do the work, but is every
  bedroom equally warm?
- **Infants.** Is there a crib or pack-n-play, or should people bring one?
- **The linens policy.** Guests bringing their own towels and queen linens is
  unusual for a rental at this level and is a genuine conversion risk. Is it
  still true, is there a rental or supply option, and does Ben want it softened
  or stated more plainly? It currently appears on this page, on the home page
  card, and in what-to-bring, so a change touches three places.

## House rules that bite here

- **Voice.** Load the `writing-as-ben` skill. Plain, short declaratives,
  Canadian spelling, no marketing adjectives.
- **This page is mostly promises.** Every sentence about capacity or comfort is
  something a guest will hold Ben to on arrival. If a fact is not confirmed,
  leave it out and mark it as an HTML comment rather than guessing. Precedent:
  the Corduroy post, where the whole basecamp section was cut rather than
  written from assumption.
- **Never state the Airbnb minimum stay.**
- Owner-only facts go in HTML comments; they are stripped from pages and feeds
  since site commit 03269fd, but verify with a grep over the whole build output.
  See ISS-31.
- Keep the existing photographs. They are original and there is one per room.
- **Build and run htmltest** before committing.

## Acceptance criteria

- The cot and trundle contradiction is resolved and both pages agree.
- Sleeping capacity and seated capacity are both stated.
- The one-bathroom constraint and the hot water reality are addressed honestly
  rather than left as bare facts.
- Each room has something useful about who it suits, not only its furniture.
- Every new claim is confirmed by Ben and attributed in a source comment with
  the date.
- Builds clean, htmltest passes, no comment text in the build output.
