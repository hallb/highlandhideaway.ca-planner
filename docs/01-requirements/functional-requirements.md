# Functional requirements

## Navigation and structure

- **REQ-020:** The global menu must reach the guides listing and the agreed top-level pages. Currently: Guides (`/posts/`), The Property (`/photos/`), About (`/about/`).
- **REQ-021:** The home page must surface links to key guides and a visible booking action pointing at the external listing.

## External integrations

- **REQ-022:** **Booking.** The site offers one clear booking path to the canonical short-term-rental listing. The vendor is currently Airbnb and may change; the requirement is the single path, not the vendor. The destination is configured once, in `params.booking.url`.
- **REQ-023:** **Analytics.** The site may load a page-analytics product, subject to the privacy decision in REQ-035. Google Analytics 4 is currently configured via `params.analytics.google.id`; whether it stays is open in ISS-28.
- **REQ-028:** **Booking clicks must be measurable.** Every call to action routes through `/go/airbnb`, a Worker that records the click server-side and then 302s to the listing. This is a first-class requirement rather than an analytics feature: it is the only conversion signal the site has, an external listing gives nothing back, and counting it server-side means ad blockers cannot suppress it and no cookie is involved. Each click records the originating page and which control was used. See [ADR-0006](../02-solution/adr/0006-count-booking-clicks-in-the-worker.md).

  A consequence worth stating: any link that goes straight to the listing instead of through `/go/airbnb` converts invisibly and undercounts silently. That failure has happened once already, in ISS-26.

## Feeds and syndication

- **REQ-024:** RSS or Atom feeds for posts remain available for subscribers and tools, per Hugo defaults.

## Comments

- **REQ-025:** No public comment system is required. Theme comment integrations remain disabled.

## Search

- **REQ-026:** Full-text search is optional. Without it, the menu, the guides index and the on-page links must remain sufficient for discovery. Note that taxonomy pages are no longer indexed by search engines (REQ-039), so they cannot be relied on as the discovery path.

## Forms

- **REQ-027:** No server-side contact form is required. Contact is satisfied by a page linking to off-site channels.

## Monitoring

- **REQ-029:** The live site must be checked on a schedule, not only at deploy time. Production can break with no commit behind it: a route detaching, the listing URL changing, an Analytics Engine binding that stops writing. The click counter in particular fails silently by design, because a failed write must never break a redirect, so it needs a positive check that a row was written rather than an absence of errors. See [`../02-solution/operations.md`](../02-solution/operations.md).
