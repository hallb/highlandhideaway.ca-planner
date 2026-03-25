---
id: ISS-2
title: "Add pull_request workflow: checkout submodules, hugo --minify"
type: task
status: To Do
priority: High
labels: []
assignee: null
milestone: M-1
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo: []
checklist: []
log: []
createdAt: 2026-03-25T03:01:30.475Z
updatedAt: 2026-03-25T03:24:25.284Z
---

## Requirement

Run the same **Hugo build on pull requests** as on `main`, but **do not deploy** to GitHub Pages from PRs.

### Intended implementation (reverted locally)

- Rename/normalize workflow to `Hugo site` (or equivalent).
- Triggers: `pull_request`, `push` to `main`, `workflow_dispatch`.
- **Concurrency:** `group: hugo-${{ github.workflow }}-${{ github.ref }}`, `cancel-in-progress: true`.
- **build** job: `permissions: contents: read`; checkout with `submodules: recursive`, `fetch-depth: 0`; `hugo --minify`.
- **Upload Pages artifact** and **deploy** only when `github.event_name == push` and `ref == refs/heads/main`.
- **deploy** job: `if` guard, `needs: build`, `permissions` for `pages: write` and `id-token: write` (not required on PR builds).

### Acceptance

- PRs get a green build without publishing a Pages artifact for untrusted code paths (fork PRs may need extra `if` — verify org settings).