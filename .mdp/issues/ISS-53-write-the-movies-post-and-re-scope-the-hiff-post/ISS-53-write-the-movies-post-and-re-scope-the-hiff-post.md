---
id: ISS-53
title: Write the movies post, and re-scope the HIFF post around it
type: task
status: To Do
priority: Medium
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: 2026-10-15
blockedBy: []
parent: null
relatedTo: []
checklist:
  - text: "Decide the hook: broad movies page vs HIFF-only page"
    done: false
  - text: Measure the drive to Northern Lights Performing Arts Pavilion
    done: true
  - text: Measure the drive to Highlands Cinemas in Kinmount
    done: true
  - text: Confirm the 2026 closing date for Highlands Cinemas by phone
    done: false
  - text: Re-check thoseothermovies.com for the 2026 lineup and pass sales
    done: false
  - text: Resolve the Friday-versus-Saturday single ticket opening
    done: false
  - text: Confirm Highlands Cinemas still runs five screens
    done: false
  - text: Swap the placeholder featuredImage
    done: true
  - text: Re-date the front matter at publish
    done: false
  - text: Confirm the Thursdays with TOM ticket price, not published on their page
    done: false
  - text: Re-check the January and June 2027 TOM dates, contradictory at source
    done: false
log: []
createdAt: 2026-09-01T00:41:25.613Z
updatedAt: 2026-09-01T00:41:25.613Z
---

## Requirement

Write `content/posts/movies-near-haliburton.md`. It is the fourth of the
November/December posts the brief proposed, but not in the shape the
brief proposed it.

Brief: `docs/haliburton_nov_dec_events_brief.md`, §2.1 and Post B.
Source: <https://www.thoseothermovies.com/hiff>,
<https://www.highlandscinemas.com/>.

## What changed on 31 August 2026

Two things, both checked against the sites themselves.

**HIFF 2026 dates are published.** Friday 6 to Sunday 8 November 2026,
Northern Lights Performing Arts Pavilion, Haliburton. Three days, seven
films. The lineup is not up yet. ISS-49 carried a checklist item to
check from early September; it is answered, and the post is unblocked.

**The venue split is gone.** The brief built Post B on the 2025
festival's own admission that opening night in Kinmount is a long drive
home. The 2026 page names one venue, in Haliburton. So Post B has lost
its spine, exactly as the brief said it might.

## Why the hook moves

A HIFF-only page is worth nothing after 8 November and has to be re-cut
every year to be worth anything again. Watching a film is a year-round
answer to bad weather, and it has three tiers that do not compete: the
cottage TV with a guest's own streaming login, Highlands Cinemas in
Kinmount through the warm months, and HIFF for one weekend in November.

One page carries all three without splitting a query, because the two
named draws are seasonally separate. Split HIFF back out if it earns the
volume.

## Acceptance Criteria

- The post answers "when is HIFF" in its own section, with dates, venue
  and pass prices, so it can still win the event query.
- No drive time appears anywhere on the page until somebody has measured
  it. This applies to Kinmount and to the pavilion.
- No claim that Highlands Cinemas closes at the end of the summer. Their
  own About page puts the season at May to Thanksgiving, and the 2025
  closing notice went up in October.
- Live before the end of September, so it indexes ahead of the November
  searches.
- URL carries no year.

## Answered 2026-08-31

Drive times, both Ben's: the pavilion is **10 minutes**, Highlands
Cinemas at Kinmount is **40**. Both are in the post. That clears the
no-unmeasured-proximity rule for this page.

## Thursdays with TOM

<https://www.thoseothermovies.com/thursdayswithtom>. The monthly series,
second Thursday of most months at the pavilion, two screenings a night
at 4:15pm and 7:15pm. The 2026/27 season is published: 10 Sept, 8 Oct
and 10 Dec 2026 are named films, 2027 is mostly to be confirmed, and
Doc(k) Day is Sat 3 April 2027.

This is the part of the page that works in February, and it settles the
hook argument. A cinema night ten minutes away nine or ten times a year
is a better reason for this page to exist than one weekend in November.
The brief's note that titles were published only through June 2026 is
now stale.

Their page contradicts itself on the January entry (headed the 14th,
detailed as the 10th) and the June entry (headed 10 June, detailed as
"Thursday, January 10"). The post names only the three consistent 2026
dates. No Event schema for the series -- too many unannounced films and
two bad dates for structured data nobody re-reads.

## Hero image, 2026-08-31

`static/images/cinema-seats.jpg`, by Tima Miroshnichenko on Pexels,
resized to 1600px and stripped of EXIF. Replaces the living-room.jpg
placeholder that was shared with the cozy-night-in post.

No visible credit on the page. Ben confirmed, and it matches the call he
made for the fly-in post's aircraft-autumn.jpg on 2026-08-24: the Pexels
licence does not require attribution, and the hero partial has no
caption slot. Adding one would need a change to `partials/hero.html` and
`_hh.scss` in the site repo, and the fly-in post would want the same
treatment so the two do not diverge. Not done.

Still worth doing, not tracked as a checklist item because it depends on
somebody being in the right place with a camera: an original photograph
of the Kinmount marquee or the pavilion would replace the stock hero and
would also fix the HIFF Event schema image, which currently points at a
cinema that is not the venue.
