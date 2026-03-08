# Repository Guidelines

日本語で回答してください。

## Project Structure & Module Organization
- `flake.nix` orchestrates nixpkgs, Home Manager, Hyprland, fenix, and extra overlays; regenerate `flake.lock` only with `nix flake update`.
- System modules live in `nixos-config/` (core `configuration.nix`, Hyprland wiring, hardware profile). Keep host-specific tweaks here.
- User modules live in `home/`, segmented by concern: `packages.nix`, `zsh.nix`, `starship.nix`, input (`input-method.nix`), compositor settings (`wm/hyprland/`), and editor config (`nixvim/` + `nixvim/plugins/`).
- Temporary build artefacts such as `result/` are produced by Nix; never commit or edit them manually.

## Build, Test, and Development Commands
- `nixos-rebuild build --flake .#nixos` builds the closure without touching the live system.
- `sudo nixos-rebuild test --flake .#nixos` validates options and performs a session-only activation.
- `sudo nixos-rebuild switch --flake .#nixos` deploys changes; capture notable output for reviews.
- `nix flake check` runs eval checks for all modules.
- `nix build .#packages.x86_64-linux.default` refreshes the pinned fenix toolchain.

## Coding Style & Naming Conventions
- Use two-space indentation in `.nix` files; keep short attribute/value pairs on one line.
- File names are hyphen-case (`hyprpanel.nix`), and option namespaces mirror upstream module paths.
- Honour `# keep-sorted` regions (e.g. `home/rust.nix`) and maintain category headers in package lists.
- Use `markdownlint` (via `markdownlint-cli`) for docs and strip trailing whitespace before committing.

## Testing Guidelines
- After editing system or Home Manager modules, run `nixos-rebuild test --flake .#nixos` followed by `nix flake check`.
- For deploy-ready work, finish with `sudo nixos-rebuild switch --flake .#nixos`.
- Touching Neovim modules? Sanity-check with `nvim --headless "+checkhealth" +qall`.

## Commit & Pull Request Guidelines
- Match existing concise Japanese commit summaries, optionally prefixed with the scope (`hyprland: 画面録画の調整`).
- Keep commits focused; reference the affected module path when clarification helps.
- PRs should outline motivation, list the validation commands executed, and include screenshots or notes for Hyprland/UI changes.

## Agent Workflow Tips
- Ensure `fcitx5` stays in `exec-once` for Hyprland sessions and keep `fcitx5-mozc`, `fcitx5-gtk`, and `fcitx5-qt` in sync across system and Home Manager configs.
- When adding new overlays or inputs, document any manual steps so other agents can reproduce the environment.
