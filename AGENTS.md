# AGENTS.md — SilkCircuit

Neovim colorscheme + generated `extras/` ports (terminals, CLI tools, VS Code, Chrome). `CLAUDE.md` is a symlink to this file.

## Commands

- `make setup` — install pinned toolchain via mise + git hooks (first run only).
- `make check` — the pre-push/CI gate: `lint` + `fmt-check` + `test`. Must pass.
- `make test` / `scripts/test` — headless Neovim suite (`nvim --clean -u tests/minimal_init.lua -l tests/run.lua`).
- `scripts/test --filter <name>` or `make test FILTER=<name>` — run one spec file.
- `make fmt` / `make fmt-check` — stylua (Lua) + ruff (scripts/) + prettier (json/jsonc/yaml/md).
- `make build && make docs` — regenerate `extras/` + README/docs tables. CI fails on drift.
- `make preview VARIANT=glow` — open Neovim with the working-tree theme.
- `SILKCIRCUIT_UPDATE_SNAPSHOTS=1 scripts/test --filter snapshot` — refresh highlight snapshots after intentional change; read the diff before committing (shrinking = lost styling).

## Architecture

- `lua/silkcircuit/variants.lua` is canonical color truth. `lua/silkcircuit/palette.lua` exposes it + semantic roles (`keyword`, `func`, `string`, …).
- `lua/silkcircuit/extra/init.lua` (registry) + `lua/silkcircuit/extra/<target>.lua` (string-returning module) generate everything under `extras/`. `extras/chrome-theme/` additionally reads JSON in `palette/`.
- `lua/silkcircuit/integrations/init.lua` is the single integration registry (`{name, modules, plugin}`); `lua/silkcircuit/integrations/<name>.lua` exposes `M.get(colors, opts)`. `lua/silkcircuit/config.lua` holds the matching `integrations.<name>` defaults.
- Core flow: `colors/silkcircuit.lua` → `lua/silkcircuit/init.lua` → `theme.lua` + integrations → `util.lua` (`pcall`-wrapped `nvim_set_hl`). Lualine theme at `lua/lualine/themes/silkcircuit.lua` is loaded by lualine itself. AstroNvim helper at `lua/silkcircuit/contrib/astronvim.lua`.
- Tests live in `tests/spec/*_spec.lua` with shared helpers in `tests/helpers.lua`; snapshots in `tests/snapshots/<variant>.txt`.

## Gotchas — read before changing color

- Never hand-edit `extras/`, `palette/*.json`, or `tests/snapshots/`. Fix `variants.lua` or the `extra/<target>.lua` mapping, then `make build && make docs`.
- Detection is passive: highlights load whether or not the plugin is installed. Never gate highlight definitions on detection; `modules`/`plugin` in the registry exist only for `:SilkCircuitIntegrations` and `:checkhealth` reporting.
- New integration = module + registry entry (with `modules`/`plugin` for reporting) + `config.lua` default key. New extras target = registry entry + generator module + install fn in both `install.sh` and `install.ps1` + `docs/extras/` page with an `extras:start` block.
- Every change ships all 5 variants (`neon`, `vibrant`, `soft`, `glow`, `dawn`); `dawn` is light, rest are dark. Verify contrast (`:SilkCircuitContrast`, WCAG AA 4.5:1) on the variant you use least, especially `dawn` vs `glow`.
- In generators use semantic roles (`${divider}`, `${accent_border}`) over raw primitives (`${purple}`); if a role is missing, add it to every variant in `variants.lua`, never derive it inside one generator.
- `terminal_*` keys map 1:1 to `terminal_color_0..15` (0 black, 1 red, 2 green, 3 yellow, 4 blue, 5 magenta, 6 cyan, 7 white, 8–15 brights). Keep the hue — a pink `terminal_red` lies in every terminal buffer diff/log. Only 6-digit hex (flatten alpha onto `bg`; `nvim_set_hl` rejects anything else).
- Tests sandbox XDG dirs and require `termguicolors` (theme refuses to load without it). Neovim 0.10+; CI covers 0.10/stable/nightly.
- Conventional Commits with a why-body; never touch `CHANGELOG.md` or version numbers (release-please generates them). Visual PRs need before/after screenshots; read `CONTRIBUTING.md` first.
