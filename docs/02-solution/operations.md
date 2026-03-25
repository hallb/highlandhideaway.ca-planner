# Operations

Satisfies **REQ-037**, **REQ-038**, and editorial aspects of **REQ-001**–**REQ-003**.

## Content updates

1. Clone **`highlandhideaway.ca`** with submodules.
2. Edit Markdown under `content/`; add images to the appropriate static or asset paths per theme conventions.
3. Preview with `hugo server` locally.
4. Commit and push to **`main`**; CI deploys automatically.

## Approvals

Define in your team who may merge to `main` (property owner, delegated editor). Not enforced in Git by default.

## Backups

- **Source of truth:** Git remote (e.g. GitHub). Ensure repo access and branch protection match your risk tolerance.
- **Built site:** Regenerable from source; Pages holds current artifact only.

## If the site is down

1. Check [GitHub Status](https://www.githubstatus.com/) and the repository **Actions** tab for failed workflows.
2. Verify **DNS** and **Pages** settings for the org/repo.
3. Roll back by reverting the bad commit on `main` and redeploying.

## Analytics access

Ensure at least one maintainer has access to the **Google Analytics** property matching ID `G-M21FZFQ5YJ` for traffic review (**REQ-023**).
