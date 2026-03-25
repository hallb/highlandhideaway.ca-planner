# highlandhideaway.ca-planner

Project documentation and planning for [Highland Hideaway](https://highlandhideaway.ca/). The live Hugo site lives in the sibling repo **`highlandhideaway.ca/`** (not this folder).

## Docs

Structured under [`docs/`](docs/):

- [`docs/01-requirements/`](docs/01-requirements/) — what the site must do
- [`docs/02-solution/`](docs/02-solution/) — how it is built and operated (includes [`adr/`](docs/02-solution/adr/) for architecture decision records)

Start at [`docs/README.md`](docs/README.md).

## Just

This repo uses [Just](https://github.com/casey/just) for repeatable commands. List recipes:

```bash
just --list
```

After a fresh clone on Debian/Ubuntu, run **`./script/bootstrap`** once (installs **Just** via `apt` when possible, then runs **`just bootstrap`**). On other systems, [install Just](https://github.com/casey/just#installation), then:

```bash
just setup
```

Common recipes: `just bootstrap`, `just setup`, `just update`, `just test`, `just cibuild`.

## Markdown Projects (MDP)

Operational issues and milestones are tracked with **[Markdown Projects](https://www.markdownprojects.com/)** — plain Markdown under **`.mdp/`** (no database). The CLI is **`mdp`** (installed by **`just bootstrap`** via [Bun](https://bun.sh/)).

Examples:

```bash
mdp issue list
mdp milestone list
```

Optional: install the upstream skill for agents (see [Getting Started](https://www.markdownprojects.com/getting-started)):

```bash
npx skills add varunpandey0502/markdown-projects/
```

Commit **`.mdp/`** with git so planning stays versioned alongside `docs/`.
