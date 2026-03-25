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

### Cursor agent skill (`mdp`)

This repo vendors the upstream **[Markdown Projects](https://www.markdownprojects.com/)** skill under **[`.cursor/skills/mdp/`](.cursor/skills/mdp/)** (Cursor discovers skills from [`.cursor/skills`](https://cursor.com/docs/context/skills)). To refresh or reinstall from upstream (non-interactive, copy mode):

```bash
npx skills add varunpandey0502/markdown-projects -a cursor -y --copy --skill mdp
```

The `skills` CLI may install to `.agents/skills/` first; move **`mdp/`** to **`.cursor/skills/mdp/`** and rely on **`.gitignore`** for `.agents/` if you re-run the command. Global skills (not used here) would live under `~/.cursor/skills/`.

Commit **`.mdp/`** with git so planning stays versioned alongside `docs/`.
