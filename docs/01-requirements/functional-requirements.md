# Functional requirements

## Navigation and structure

- **REQ-020:** Global menu must include access to the **posts listing** and any agreed top-level pages (e.g. About).
- **REQ-021:** Home page must surface **links to key guides** and a visible **booking** action pointing to the external listing.

## External integrations

- **REQ-022:** **Booking:** Primary CTA may link to the canonical short-term-rental listing (e.g. Airbnb). URL may change; requirement is “one clear booking path,” not a specific vendor forever.
- **REQ-023:** **Analytics:** Site may load **Google Analytics 4** (or successor) with a property ID configured in site params, subject to privacy decisions in non-functional requirements.

## Feeds and syndication

- **REQ-024:** **RSS/Atom** (or theme-equivalent feeds) for posts should remain available for subscribers and tools, consistent with Hugo defaults.

## Comments

- **REQ-025:** **No public comment system** is required on posts unless business requirements change; theme comment integrations remain unused/disabled.

## Search

- **REQ-026:** Full-text **search** is optional. If not implemented, navigation + posts index + tags/categories must remain usable for discovery.

## Forms

- **REQ-027:** No server-side contact form is required for MVP; **contact** may be satisfied by mailto, external messaging, or a future page—see content/solution alignment for “Contact” link targets.
