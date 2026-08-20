# ADR 0006: Count booking clicks in the Worker, not in an analytics product

## Status

Accepted, 2026-08-18. Satisfies REQ-028.

## Context

Booking happens on Airbnb. The listing reports nothing back, so the site's last observable step is the click that leaves it. That click is the only conversion signal available.

Measuring it client-side — a GA event on the button — has two problems. Ad blockers suppress analytics scripts, and the users most likely to block are not a random sample. And it ties conversion measurement to whichever analytics product is installed, which is a decision still open (see [ADR-0008](0008-page-analytics.md)).

## Decision

Point every call to action at `/go/airbnb` instead of at the listing. A Worker records the click and 302s onward.

Rows go to the Analytics Engine dataset `booking_clicks`. Each carries the originating page (`?src=`), the referer, the country, and which control was clicked (`?pos=`).

Every booking URL on the site is built by one partial, `partials/booking-url.html`, so the destination and the tracking parameters cannot drift apart. The destination itself is configured once, in `params.booking.url`.

## Consequences

The count is server-side, so ad blockers cannot suppress it. No cookie is involved, so it raises no consent question and is unaffected by the GA decision.

Conversion measurement is now independent of any analytics vendor.

The redirect must never be cached, or the count silently under-reports. `Cache-Control: no-store, no-cache, must-revalidate` is on the response for that reason.

A failed write must never cost a booking, so `recordClick` is wrapped in try/catch and returns early if the binding is missing. The consequence is that a broken binding looks exactly like a quiet week. That is why [REQ-029](../../01-requirements/functional-requirements.md) exists and why the monitor workflow sends a synthetic click daily and insists on the row.

Any link that bypasses `/go/airbnb` converts invisibly. That is the sharp edge of this design, and it has caused one real incident: the stale GitHub Pages build linked straight to Airbnb, and the resulting silence was read as a broken Worker for the better part of an hour.

Adding a new CTA placement means adding a new `?pos=` value. Reusing an existing one makes the two indistinguishable in the dashboard. blob4 was appended rather than inserted so that rows predating the sticky rail — which carry three blobs — keep working with every existing panel.

Analytics Engine has no UI; the SQL API is the only way to read the data, which is why `grafana/` exists. Retention is three months on the free plan.
