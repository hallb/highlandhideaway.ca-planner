# Domain and analytics

Satisfies **REQ-023**, **REQ-033**–**REQ-035**.

## URLs and DNS

| Item | Current / observed |
|------|---------------------|
| **`baseURL`** | `https://highlandhideaway.ca/` in [`hugo.toml`](../../../highlandhideaway.ca/hugo.toml) |
| **`CNAME`** (repo root and `public/`) | `www.highlandhideaway.ca` |

**Implication:** Apex and `www` should redirect or resolve consistently so links, RSS, and GA reporting use one canonical host. Align DNS (A/AAAA for apex, CNAME for `www`) and optionally set `baseURL` or redirects to match the chosen canonical URL (**REQ-034**).

## SEO metadata

- Site title/description/keywords in **`[params]`** and page-level front matter.
- Twitter Card type **`summary`** under **`[params.seo.twitter]`** (global OG images list may be empty—can be filled per page or globally).

## Google Analytics

- **Enabled** in theme params: **`[params.analytics] enable = true`**
- **Measurement ID:** `G-M21FZFQ5YJ` in **`[params.analytics.google] id`**
- **`anonymizeIP`:** configurable (currently `false`); align with privacy policy (**REQ-035**).

Treat the GA ID as **non-secret** but document ownership of the GA property in operations.
