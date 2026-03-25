# Non-functional requirements

## Performance

- **REQ-030:** Static HTML output; assets should be **minified** in production builds where supported (e.g. `hugo --minify`).
- **REQ-031:** No hard numeric Core Web Vitals SLA in this doc; goal is “typical static site” performance on GitHub Pages CDN.

## Accessibility

- **REQ-032:** Strive for **reasonable accessibility** for informational content (semantic HTML from theme, alt text on meaningful images in content). Formal WCAG conformance level not mandated here unless legally required later.

## SEO

- **REQ-033:** Pages should have **titles and descriptions** (front matter / theme defaults) suitable for search and social previews.
- **REQ-034:** **Canonical URL strategy** must be documented and enforced (apex vs `www`, `baseURL` alignment)—see `02-solution/domain-and-analytics.md`.

## Privacy and cookies

- **REQ-035:** Use of **Google Analytics** implies disclosure appropriate to the jurisdiction (e.g. privacy policy or cookie notice if required). IP anonymization is configurable in theme; business to decide—currently configurable in `hugo.toml`.

## Availability and hosting

- **REQ-036:** Hosted on **GitHub Pages** (or documented successor) with deploy on **main** branch as defined in CI.
- **REQ-037:** No explicit uptime SLA; expectation is GitHub Pages default availability.

## Security

- **REQ-038:** No secrets in public repository content (API keys, passwords). Build uses OIDC to Pages where applicable; no long-lived deploy tokens in repo.
