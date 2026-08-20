# Non-functional requirements

## Performance

- **REQ-030:** Static HTML output. Assets are minified in production builds (`hugo --minify`).
- **REQ-031:** No hard numeric Core Web Vitals SLA. The goal is typical static-site performance served from the Cloudflare edge. Cloudflare Web Analytics reports Core Web Vitals once enabled, which is the measurement this requirement would be judged against.

## Accessibility

- **REQ-032:** Aim for reasonable accessibility on informational content: semantic HTML from the theme, alt text on meaningful images. Formal WCAG conformance is not mandated unless it becomes a legal requirement. Known gaps are tracked as issues rather than waived here — see ISS-13 for the mobile menu.

## SEO

- **REQ-033:** Pages carry titles and descriptions suitable for search and social previews, from front matter or theme defaults.
- **REQ-034:** The canonical URL strategy must be documented and enforced. The apex is canonical; see [ADR-0005](../02-solution/adr/0005-make-the-apex-canonical.md) and [`../02-solution/domain-and-analytics.md`](../02-solution/domain-and-analytics.md).
- **REQ-039:** Only pages worth ranking belong in the sitemap and the index. Auto-generated taxonomy pages carry `noindex, follow` and are excluded from the sitemap. See [ADR-0007](../02-solution/adr/0007-keep-taxonomies-out-of-the-index.md).

## Privacy and cookies

- **REQ-035:** Analytics must not create a consent obligation that the site does not meet. Met by using only cookieless analytics: Cloudflare Web Analytics for traffic, and the server-side counter in the Worker for booking clicks. Google Analytics was dropped for this reason rather than wrapped in a consent banner — see [ADR-0008](../02-solution/adr/0008-page-analytics.md). Not yet deployed; GA is still live until ISS-28 completes.

## Availability and hosting

- **REQ-036:** Hosted on **Cloudflare Workers**, deployed from `main` by GitHub Actions.
- **REQ-037:** No explicit uptime SLA. The expectation is Cloudflare's default availability. Liveness is checked daily rather than assumed — see [`../02-solution/operations.md`](../02-solution/operations.md).

## Security

- **REQ-038:** No secrets in public repository content. Deployment uses long-lived Cloudflare API tokens held as GitHub repository secrets, which replaced the OIDC flow that GitHub Pages provided. Each token is scoped to the narrowest permission that works: `CLOUDFLARE_API_TOKEN` is Workers Scripts:Edit, and `CF_AE_TOKEN` is Account Analytics:Read. They are separate because the deploy token returns 403 against the Analytics Engine SQL API.
