# Dotfiles

Cross-platform dotfiles managed by [chezmoi](https://www.chezmoi.io/), targeting **Windows**, **WSL2 (Debian)**, and **Linux (Debian)**.

## Architecture

### Platform Strategy

| Layer | Windows | Linux / WSL2 |
|---|---|---|
| System packages | [WinGet](pkg/winget.json) | [APT](pkg/apt.txt) + Docker Engine |
| CLI tools | [Scoop](pkg/scoop.json) | [Homebrew](pkg/brewfile) |
| Runtimes & LSPs | [mise](dot_config/mise/config.toml) | [mise](dot_config/mise/config.toml) |
| Shell | PowerShell 7 | Zsh (primary) / Bash |
| Editor | Helix (+ VS Code) | Helix (+ VS Code) |
| Multiplexer | Zellij | Zellij |
| Prompt | Starship | Starship |

### File Layout

```shell
.chezmoi.toml.tmpl          # Chezmoi config — data, prompts, OS detection
.chezmoiignore.tmpl         # OS-conditional file exclusion
.chezmoiscripts/
  run_onchange_linux.sh.tmpl      # APT, Docker, Homebrew package install
  run_onchange_linux_wsl.sh.tmpl  # WSL: wsl.conf + SSH key copy
  run_onchange_win.ps1.tmpl       # WinGet + Scoop package install
appdata/roaming/
  symlink_dot_terraformrc         # Windows AppData → ~/.terraformrc
documents/
  symlink_microsoft.powershell_profile.ps1.tmpl  # Documents → profile.ps1
dot_bashrc                  # Bash RC (Linux)
dot_zshrc                   # Zsh RC (Linux)
dot_config/
  atuin/config.toml         # Atuin shell history
  helix/
    config.toml             # Editor settings + keybindings
    languages.toml          # Language servers + formatters
  mise/config.toml          # Runtime versions + tools
  powershell/profile.ps1    # PowerShell profile (Windows)
  scoop/config.json         # Scoop settings
  shell/
    aliases.sh              # Shared aliases (bash/zsh)
    env.sh                  # Environment variables
    functions.sh            # Shared functions
    init.sh                 # Completions + tool activation
  starship.toml             # Prompt configuration
  wsl/wsl.conf.tmpl         # WSL2 /etc/wsl.conf
  zellij/config.kdl         # Terminal multiplexer config
dot_editorconfig            # EditorConfig
dot_gitconfig.tmpl          # Git config (templated)
dot_gitconfiglnrisk.tmpl    # Git overrides for risk-* repos (work)
dot_gitconfigwork.tmpl      # Git overrides for work orgs
dot_gitignore               # Global gitignore
dot_jjconfig.tmpl           # Jujutsu VCS config
dot_saml2aws                # AWS SAML auth (work)
dot_ssh/config.tmpl         # SSH config (templated)
dot_terraformrc             # Terraform CLI config
dot_wslconf                 # Windows-side .wslconf (WSL2 VM settings)
dot_yamlfmt                 # yamlfmt formatter config
pkg/
  apt.txt                   # Debian packages (inc. Docker Engine)
  brewfile                  # Homebrew formulas
  scoop.json                # Scoop apps + buckets
  winget.json               # WinGet system apps
```

### Template Data

Chezmoi prompts for `Work machine` on init and auto-detects OS/WSL. Template variables:

| Variable | Purpose |
|---|---|
| `.name` / `.email` | Git identity |
| `.username` | OS username (for WSL paths) |
| `.key` / `.work.key` | SSH key paths |
| `.isWSL` | Auto-detected WSL2 flag |
| `.work.enabled` | Enables work git configs, SSH keys, saml2aws |
| `.code.path` | Code directory (`~/Code` Win, `~/code` Linux) |

### Conditional Behaviour

- **Windows**: Ignores shell configs, apt, brewfile. Deploys PowerShell profile, Scoop config, AppData symlinks.
- **Linux**: Ignores PowerShell, Scoop, WinGet, AppData, Documents. Deploys shell configs, runs apt + brew.
- **WSL2 only**: Copies `wsl.conf` to `/etc/`, copies SSH keys from Windows host.
- **Work only**: Deploys `.gitconfigwork`, `.gitconfiglnrisk`, `.saml2aws`, enables work SSH key.

### VCS Setup

- **Git**: SSH signing, difftastic (external diff + tool), mergiraf (merge tool + driver), VS Code as alternate diff/merge tool.
- **Jujutsu (jj)**: SSH signing, difftastic diff, mergiraf merge editor.

### Mise-managed Runtimes

| Runtime | Tools installed via it |
|---|---|
| Go | gopls, goimports, dlv, golangci-lint, gofumpt |
| Node (LTS) | yaml-language-server, vscode-langservers-extracted, prettier, copilot-language-server, bash-language-server |
| Rust (stable) | just-lsp |
| Hugo | — |
| Terraform | — |
| OpenTofu | — |

## Onboarding a New Machine

### Prerequisites

| Platform | Required before chezmoi |
|---|---|
| Windows | [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/) (built-in), [Scoop](https://scoop.sh/) |
| Linux | [Homebrew](https://brew.sh/) |
| WSL2 | [Homebrew](https://brew.sh/), Debian distro installed, SSH keys on Windows host |

### Windows

```powershell
# Install chezmoi and apply
scoop install chezmoi
chezmoi init --apply hipwells
```

This will:

1. Prompt for "Work machine" (yes/no)
2. Deploy all config files
3. Run `winget import` and `scoop import` to install packages

After apply, install mise-managed tools:

```powershell
mise install
```

### Linux / WSL2

```bash
# Install chezmoi and apply
brew install chezmoi
chezmoi init --apply hipwells
```

This will:

1. Prompt for "Work machine" (yes/no)
2. Deploy all config files
3. Set up Docker's APT source and install all APT packages (including Docker Engine)
4. Run `brew bundle` to install Homebrew formulas
5. **(WSL2 only)** Copy `wsl.conf` to `/etc/` and SSH keys from Windows

After apply:

```bash
# Install mise-managed runtimes and tools
mise install

# If Docker was just installed, activate group membership
newgrp docker
```

For WSL2, restart the distro after first apply for `wsl.conf` changes to take effect:

```powershell
# From Windows
wsl --shutdown
```

## Extending the Configuration

### Adding a package

| Platform | Action |
|---|---|
| APT | Add to `pkg/apt.txt` (alpha-sorted) |
| Homebrew | Add to `pkg/brewfile` (alpha-sorted) |
| Scoop | Add to `pkg/scoop.json` apps array (alpha-sorted) |
| WinGet | Add to `pkg/winget.json` Packages array (alpha-sorted) |
| mise | Add to `dot_config/mise/config.toml` (alpha-sorted within block) |

Then run `chezmoi apply` to trigger the `run_onchange` scripts.

### Adding a shell alias

- **Bash/Zsh**: Add to `dot_config/shell/aliases.sh`
- **PowerShell**: Add `Set-Alias` or function to `dot_config/powershell/profile.ps1`

### Adding a Helix language

1. Add `[[language]]` block to `dot_config/helix/languages.toml`
2. Add `[language-server.name]` definition if not built-in
3. Install the language server via mise, brew, or scoop as appropriate

### Adding a git includeIf

Add to the work-conditional block at the bottom of `dot_gitconfig.tmpl`:

```shell
[includeIf "gitdir:{{ .code.path }}/github.com/org-name/"]
  path = ~/.gitconfigwork
```

### Adding a new dotfile

```bash
# Add an existing file to chezmoi
chezmoi add ~/.some-config

# Add a template
chezmoi add --template ~/.some-config.tmpl
```

Chezmoi uses naming conventions: `dot_` → `.`, `.tmpl` → template, `symlink_` → symlink.

## Day-to-Day Usage

### Mise

```bash
mise install          # Install all tools defined in config.toml
mise upgrade          # Upgrade all tools to latest matching versions
mise upgrade go node  # Upgrade specific tools
mise outdated         # Show tools with newer versions available
mise use go@latest    # Pin a tool version
mise ls               # List installed tools
```

For pinned versions (e.g. `hugo`, `terraform`), update the version in `dot_config/mise/config.toml` first, then run `mise install`.

### Chezmoi

```bash
chezmoi diff          # Preview what would change
chezmoi apply         # Apply changes to home directory
chezmoi edit          # Open source dir in $EDITOR (Helix)
chezmoi cd            # cd into source directory
chezmoi add <file>    # Add a file from ~ to chezmoi
chezmoi update        # Pull latest from remote and apply
chezmoi data          # Show template data values
chezmoi doctor        # Diagnose issues
```

After editing files in the source directory, apply with:

```bash
chezmoi apply
```

To commit and push changes:

```bash
chezmoi cd
git add -A && git commit -m "description" && git push
```

### Shell Aliases

| Alias | Command | Available |
|---|---|---|
| `h` | `hx` | Shell + PowerShell |
| `zj` | `zellij` | Shell + PowerShell |
| `za` | `zellij attach \|\| zellij` | Shell + PowerShell |
| `g` | `git` | Shell + PowerShell |
| `k` | `kubectl` | Shell + PowerShell |
| `cm` | `chezmoi` | Shell + PowerShell |
| `gr` | `go run .` | Shell + PowerShell |
| `gt` | `go test ./...` | Shell + PowerShell |
| `gfmt` | `golangci-lint --fix` | Shell + PowerShell |
| `repl` | `bash --norc` | Shell only |
| `docker` | `podman` | PowerShell only |

### Helix

```
hx <file>             # Open file
hx .                  # Open file picker in current directory
```

Key bindings:

| Key | Action |
|---|---|
| `Ctrl-s` | Save (normal or insert mode) |
| `Space s` | Save |
| `Space S` | Save all buffers |
| `Space q` | Quit |
| `Space Q` | Force quit |

#### IDE Features

| Key | Action |
|---|---|
| `Space f` | File picker |
| `Space F` | File picker (current directory) |
| `Space b` | Buffer picker |
| `Space /` | Global search (grep) |
| `Space k` | Show docs for symbol under cursor |
| `Space r` | Rename symbol |
| `Space a` | Code actions |
| `g d` | Go to definition |
| `g r` | Go to references |
| `g i` | Go to implementation |
| `g y` | Go to type definition |
| `Space d` | Show diagnostics picker |
| `] d` / `[ d` | Next / previous diagnostic |
| `Space s` | Symbol picker (current file) |
| `Space S` | Symbol picker (workspace) |

#### Selections & Editing

| Key | Action |
|---|---|
| `x` | Select line |
| `s` | Select within selection (regex) |
| `S` | Split selection (regex) |
| `&` | Align selections |
| `C` | Copy selection below |
| `,` | Remove secondary cursors |
| `(` / `)` | Rotate selection contents |
| `Space y` / `Space p` | Yank / paste to system clipboard |

#### Configured Languages

All languages have Copilot as a secondary language server.

| Language | LSP | Formatter | Auto-format |
|---|---|---|---|
| Bash | bash-language-server | shfmt | Yes |
| Go | gopls (gofumpt) | goimports | Yes |
| HCL/Terraform | terraform-ls | — | Yes |
| JSON | vscode-json-language-server | prettier | — |
| Just | just-lsp | — | — |
| Markdown | marksman + markdown-oxide + rumdl | rumdl | — |
| Rust | rust-analyzer | — | Yes |
| TOML | tombi | tombi | — |
| YAML | yaml-language-server | yamlfmt | — |
| Helm templates | helm-ls | yamlfmt | — |

#### Tips

- `:lsp-workspace-command` — run LSP-specific commands (e.g. gopls `tidy`, `generate`)
- `:theme` — switch theme interactively (configured: `catppuccin_macchiato`)
- `Space ?` — show command palette / key bindings
- `:config-open` — open Helix config for editing
- `:log-open` — open log file for debugging LSP issues
- `:reload` — reload config without restarting

### Zellij

```shell
zj                    # Start new session
za                    # Attach to existing session or start new
```

Key bindings:

| Key | Action |
|---|---|
| `Alt h/j/k/l` | Navigate panes |
| `Alt H/J/K/L` | Resize panes |
| `Alt 1-4` | Switch tabs |
| `Alt n` | New tab |
| `Alt w` | Close pane |
| `Ctrl g` | Toggle lock mode (pass all keys to inner app) |

### Git

```bash
g st                  # git status -sb
g ll                  # git log --oneline
g last                # Last commit details
g hist                # Decorated branch graph
g sha                 # Current HEAD SHA
g patch               # Diff without external diff tool
g difftool            # Side-by-side diff with difftastic
```
