# Tech stack

Satisfies **REQ-030**, **REQ-036**, and technical items in [`../01-requirements/constraints.md`](../01-requirements/constraints.md).

## Core

| Layer | Choice | Notes |
|-------|--------|--------|
| Generator | **Hugo** | Static builds; `hugo.toml` at repo root |
| Build flavor | **Extended** | CI uses `peaceiris/actions-hugo` with `extended: true` |
| Theme | **DoIt** (`0.4.0` in `params.version`) | Submodule: `themes/DoIt` |
| Languages | **English only** | `defaultContentLanguage = "en"`, `languageCode = "en-us"` |

## Notable `hugo.toml` settings

- **`baseURL`:** `https://highlandhideaway.ca/`
- **Menu:** `Posts` → `/posts/`, `About` → `/about/`
- **Theme params:** `defaultTheme = "light"`, home profile title/subtitle, `dateFormat`, SEO/twitter card type `summary`
- **Goldmark:** `unsafe = true` allows raw HTML in Markdown (e.g. booking button on home page)
- **Build:** `writeStats = true`; `noChmod` / `noTimes` set

## Why static Hugo

- Fast builds, no runtime database, easy hosting on GitHub Pages (**REQ-036**).
- Content in Git supports review and history for guest-facing copy.
