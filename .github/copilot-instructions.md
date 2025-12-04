<!-- Copilot / AI agent guidance for the `blog` repository -->
# Copilot Instructions

This repository is a Quarto-based static website. The guidance below focuses on concrete, discoverable patterns so an AI coding agent can be productive immediately.

- **Project type & build output**: `_quarto.yml` sets `project.type: website` and `output-dir: docs`. The `docs/` folder is the generated site (served/published).
- **Local build**: use the Quarto CLI installed locally. Common commands:
  - Build: `quarto render` (generates/updates `docs/`).
  - Dev server: `quarto preview --port 5555 --host 0.0.0.0` (the `docker-compose` uses port `5555`).
- **Docker**: `Dockerfile` installs Quarto v1.7.33 (linux-arm64) and runs `quarto render`. `docker-compose.yml` runs `quarto preview` with `5555` exposed. Example commands:
  - Build + run with compose: `docker-compose up --build`
  - Build only: `docker build -t blog .`

- **Primary source directories**:
  - Content sources: `posts/` (one subfolder per post, e.g. `posts/huggingface/cat_dog_model.md`). Edit these source files — do not hand-edit `docs/` HTML files.
  - Static assets: `images/` and `styles.css` at repo root; `_quarto.yml` references `images/jesus.png` as the favicon.
  - Quarto extensions (repo copy): `_extensions/mcanouil/iconify` — the repo also runs `quarto add mcanouil/quarto-iconify` in the Dockerfile. Be mindful of the duplicate extension source.

- **Generated site artifacts**:
  - `docs/` contains generated HTML and `site_libs/` (Quarto assets). This repository keeps `docs/` committed (used for GitHub Pages). When making content changes, regenerate `docs/` before pushing.

- **Authoring conventions**:
  - Posts use front-matter: `title`, `date`, `author`, `categories`, `image` (see `posts/huggingface/cat_dog_model.md`).
  - Content can be Markdown (`.md`) or Quarto Markdown (`.qmd`). Keep media under `images/` and refer via relative paths.

- **Styling & theme**:
  - `_quarto.yml` sets theme list (`cosmo`, `brand`) and references `styles.css`. Prefer editing `styles.css` for site-wide overrides.

- **What to change vs what to leave**:
  - Edit: files under `posts/`, `_quarto.yml`, `styles.css`, and `_extensions/` when adjusting content, layout, or extensions.
  - Regenerate: always run `quarto render` (or `quarto preview`) to update `docs/` before making deployment commits.
  - Avoid manual edits inside `docs/` unless fixing deployment-only issues; treat `docs/` as generated output.

- **Quarto version and architecture note**:
  - The `Dockerfile` fetches `quarto-1.7.33-linux-arm64.deb`. On non-arm64 hosts (for example x86_64 macOS), prefer using a local Quarto CLI installation or update the Dockerfile to the matching artifact.

- **Quick examples**:
  - Add a new post: create `posts/<slug>/index.md` with front-matter, add images to `images/`, then run:

```bash
quarto render
# or for dev: quarto preview --port 5555
```

- **Files to inspect when debugging**:
  - `_quarto.yml` — site config and nav
  - `Dockerfile` / `docker-compose.yml` — CI/container build & dev server
  - `_extensions/` — custom quarto extensions shipped with the repo
  - `posts/` and `docs/` — source vs generated output

If anything here is unclear or you want other sections (commit hooks, PR checklist, or contribution flow), tell me which area to expand. 
