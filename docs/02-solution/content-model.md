# Content model

Satisfies **REQ-010**–**REQ-014**, **REQ-020**–**REQ-021**.

## Layout

| Path | Role |
|------|------|
| `content/_index.md` | Home page (welcome, guide links, booking CTA) |
| `content/posts/*.md` | Blog/guide articles |
| `static/` | Static files served at site root (e.g. `manifest.json`, favicons) |

Images are referenced from content (e.g. `/images/...`) with assets under the site’s static or asset pipeline as configured in the theme.

## Front matter (typical post)

Posts use YAML front matter including:

- `title`, `description`, `date` (where used)
- `categories` — e.g. Cottage Info, Events, Local Activities, Food & Cooking, Relaxation, Seasonal, How-Tos
- `tags` — for discovery and taxonomy pages
- Optional: `featuredImage`, theme-specific flags (`toc`, `comment`, etc.)

## Taxonomies

Hugo default **categories** and **tags** drive section URLs under `categories/` and `tags/` in the built site.

## Adding a new post

1. Add `content/posts/<slug>.md` with front matter and body.
2. Run `hugo` locally or push to `main` to publish via CI.
3. Link from home or related posts if it is a core guest guide.

## Gaps to align with navigation

- **About (`/about/`):** menu expects a page; add `content/about/_index.md` (or equivalent) if the menu entry should work.
- **Contact (`/posts/contact/`):** home page may link here; add `content/posts/contact.md` or change links to a real URL (**REQ-027**).
