# Content model

Satisfies **REQ-010**–**REQ-014**, **REQ-020**–**REQ-021**, **REQ-039**.

## Layout

| Path | Role |
|------|------|
| `content/_index.md` | Home page: intro, curated guide cards, booking CTA |
| `content/posts/*.md` | Guide articles |
| `content/photos/` | The property gallery |
| `content/about/` | About page |
| `static/` | Served at the site root (favicons, `manifest.json`, `images/`) |

`static/images/` is mounted twice, as `static` and as `assets`, so the same files publish verbatim and are also resolvable by Hugo Pipes for WebP srcsets. See [tech-stack.md](tech-stack.md).

## Front matter (typical post)

- `title`, `description`, `date`
- `categories` — Cottage Info, Events, Local Activities, Food & Cooking, Relaxation, Seasonal, How-Tos
- `tags`
- Optional: `featuredImage`, `hero`, `heroAnchor`, and theme flags (`toc`, `comment`, `draft`)

`hero` overrides `featuredImage` for the post header image. `heroAnchor` sets the crop anchor, defaulting to `Smart`, which is what keeps portrait images usable in a 3:1 hero.

## Taxonomies

Hugo's default categories and tags still generate pages under `/categories/` and `/tags/`. They carry `noindex, follow` and are excluded from the sitemap — see [ADR-0007](adr/0007-keep-taxonomies-out-of-the-index.md).

They remain useful as internal navigation and are still crawled for their links. They are no longer a search-discovery path, so anything that must be findable needs a real page and a real link to it.

## Adding a new post

1. Add `content/posts/<slug>.md` with front matter and body.
2. Preview with `hugo server`.
3. Push to `main`. CI link-checks and deploys.
4. Link it from the home page cards or a related post if it is a core guest guide. The home page cards are curated by hand in `content/_index.md`, so a new post does not appear there on its own.

## Booking calls to action

Two controls, and they must stay distinguishable in the click data:

- `{{< book >}}` — the inline shortcode, placed by hand in prose. Reports `pos=inline`.
- The sticky rail card, rendered on every post by `partials/booking-cta.html`. Reports `pos=rail`.

Both build their URL through `partials/booking-url.html`, so the destination and the tracking parameters cannot drift apart. Never link to the listing directly: that converts invisibly. See REQ-028.

## Drafts

`draft: true` posts are not built. Currently parked: `fall-colours`, `haliburton-galleries`, `american-thanksgiving`. ISS-31 tracks what each needs.

## Content TODOs

Six content files carry TODO comments marking facts only the owner knows. They are HTML comments and Hugo's minifier strips them, so nothing reaches visitors — verified as 8 pages carrying them without `--minify` and zero with. If the `--minify` flag is ever dropped from the build, they become visible in page source. Tracked in ISS-31.
