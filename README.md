# Neovim config

A personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim), using
Neovim's native LSP client (`vim.lsp.config` / `vim.lsp.enable`, no `nvim-lspconfig` plugin) with
[mason.nvim](https://github.com/mason-org/mason.nvim) managing language server installs.

This document explains how to get a working setup from a blank machine.

## 1. Prerequisites

Install these before touching the config.

| Requirement | Why |
| --- | --- |
| Neovim 0.11 or newer (0.12.x recommended) | This config uses `vim.lsp.config`/`vim.lsp.enable`, which don't exist before 0.11 |
| `git` | Bootstraps `lazy.nvim` and clones every plugin |
| A C compiler (`gcc` or `clang`) | Needed by `nvim-treesitter` to build parsers |
| `ripgrep` (`rg`) | Powers Telescope's live grep |
| A [Nerd Font](https://www.nerdfonts.com/), set as your terminal's font | File icons, git status symbols, and diagnostic signs are glyphs from a Nerd Font; without one you'll see boxes or missing characters |
| Node.js + `npm` | Several Mason-installed language servers (`pyright`, `ts_ls`, `perlnavigator`) are npm packages |
| `lazygit` | The `<C-g>` keybind just shells out to the `lazygit` CLI; it must be installed and on `PATH` separately |

Optional, depending on what you work on:

- A JDK (17+) if you'll use Java support — see the Java-specific notes below.
- `tmux`, if you want pane navigation via `nvim-tmux-navigator`.
- `fd`, for faster file finding (Telescope falls back to its own file walker without it).

Install Neovim itself via your OS package manager, or from the
[official releases](https://github.com/neovim/neovim/releases) if your package manager's version
is too old.

### Installing prerequisites on Windows

The table above still applies — Windows just needs different install commands and, for the C
compiler, a bit more care. From a PowerShell prompt, using
[winget](https://learn.microsoft.com/windows/package-manager/winget/) (built into Windows 10/11):

```powershell
winget install Neovim.Neovim
winget install Git.Git
winget install BurntSushi.ripgrep.MSVC
winget install OpenJS.NodeJS.LTS
winget install jesseduffield.lazygit
```

For the C compiler `nvim-treesitter` needs to build parsers, the simplest options are:

- Install the [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/) with the
  "Desktop development with C++" workload, which gives you `cl.exe`, or
- Install [Zig](https://ziglang.org/) (`winget install zig.zig`) — `nvim-treesitter` can use
  `zig cc` as a drop-in compiler and it's a much smaller download than the Build Tools.

Install a [Nerd Font](https://www.nerdfonts.com/) (e.g. `winget install DEVCOM.JetBrainsMonoNerdFont`)
and set it as the font in whatever terminal you use — Windows Terminal is recommended, since it
also supports the OSC 52 clipboard integration this config relies on (see `lua/config/options.lua`).

Alternatively, if you'd rather avoid the native-Windows compiler setup entirely, install Neovim
inside [WSL](https://learn.microsoft.com/windows/wsl/install) and follow the Linux instructions in
this README from within it — that also sidesteps any Windows-specific path differences below.

## 2. Install the config

### macOS / Linux

Neovim looks for its config at `~/.config/nvim`. If you already have something there, move it out
of the way first:

```sh
mv ~/.config/nvim ~/.config/nvim.bak   # only if one already exists
git clone <this-repo-url> ~/.config/nvim
```

### Windows

On native Windows (outside WSL), Neovim looks for its config at `%LOCALAPPDATA%\nvim`, i.e.
`~\AppData\Local\nvim`. From PowerShell:

```powershell
# only if a config already exists there
Rename-Item $env:LOCALAPPDATA\nvim nvim.bak

git clone <this-repo-url> $env:LOCALAPPDATA\nvim
```

## 3. First launch

```sh
nvim
```

On the very first run:

1. `lua/core/lazy.lua` bootstraps `lazy.nvim` itself (clones it with `git`).
2. `lazy.nvim` reads every file under `lua/plugins/` and installs all plugins. You'll see the
   Lazy UI window while this happens — wait for it to finish, then press `q` to close it.
3. In the background, `mason.nvim` and `mason-lspconfig.nvim` (from `lua/plugins/mason.lua`)
   download the configured language servers into `~/.local/share/nvim/mason/` and add them to
   `PATH`. This can take a minute the first time. Check progress or status any time with `:Mason`.

Restart Neovim once everything settles, then run `:checkhealth` to confirm there's nothing
missing (missing Nerd Font glyphs, missing `rg`, etc. will show up here).

## 4. How the LSP setup works

There's no `nvim-lspconfig` plugin in this config. Instead it uses Neovim's built-in LSP config
system directly:

- Each server has a config file in `lsp/<name>.lua` (e.g. `lsp/pyright.lua`, `lsp/clangd.lua`).
  These define `cmd`, `filetypes`, `root_markers`, and `capabilities` for that server. Neovim
  auto-loads a file from here the first time that server name is referenced.
- `lua/plugins/mason.lua` lists the servers to install under `ensure_installed`. On startup,
  `mason-lspconfig.nvim` installs anything missing from that list and then calls
  `vim.lsp.enable(name)` for each one automatically as it becomes available. That call just
  registers the server to start lazily when a matching filetype is opened — it does nothing on
  its own if there's no matching `lsp/<name>.lua` config to tell Neovim how to run it.

Currently managed this way: `clangd`, `lua_ls`, `pyright`, `ts_ls`, `perlnavigator`.

Two servers are handled outside this flow and are worth knowing about:

- **Java (`jdtls`)** goes through the `nvim-jdtls` plugin (`lua/plugins/jdtls.lua`) instead, which
  starts the server itself via a `FileType` autocommand rather than `vim.lsp.enable`. See the
  Java section below — it has machine-specific paths that need editing.
- **`pylsp`** has a config file (`lsp/pylsp.lua`) but isn't in `ensure_installed` and is never
  enabled. It's there as a ready-made alternative to `pyright` if you ever want to switch; it's
  currently inert.

### Adding a new language server

1. Add its Mason package name to `ensure_installed` in `lua/plugins/mason.lua`.
2. If it's not one of the handful of servers Neovim or `mason-lspconfig` ship a bundled default
   config for, add `lsp/<name>.lua` yourself, following the pattern of the existing files (set
   `cmd`, `filetypes`, `root_markers`, `capabilities`). `lsp/perlnavigator.lua` is a minimal
   example to copy.
3. Restart Neovim. `mason-lspconfig` installs the package and calls `vim.lsp.enable` for you.

If a filetype has an LSP running but you see no diagnostics or `:LspInfo` shows no client, the
most common cause is a missing `lsp/<name>.lua` file — `vim.lsp.enable` silently no-ops without
one.

## 5. Java-specific setup

`lua/plugins/jdtls.lua` currently hardcodes two things that are specific to the original
machine this config was written on, and will need to be changed (or removed) for Java support to
work for you:

- A Lombok jar path passed as a JVM arg:
  `/home/austin/.m2/repository/org/projectlombok/lombok/1.18.42/lombok-1.18.42.jar`
- A JDK runtime path via `sdkman`: `~/.sdkman/candidates/java/current`, labeled `JavaSE-21`

Point these at wherever your JDK and (optionally) Lombok jar actually live, or delete the
Lombok `--jvm-arg` line entirely if you don't use Lombok.

## 6. Themes

Colorschemes are declared in `lua/plugins/colorschemes.lua` and switched at runtime with
[themery.nvim](https://github.com/zaldih/themery.nvim):

- `<C-s>` opens the theme picker (live preview as you move through the list).
- Selecting a theme persists it, so it's applied automatically on the next launch.

## 7. Keybindings

Leader key is `<Space>`.

| Key | Mode | Action |
| --- | --- | --- |
| `<C-n>` | Normal | Toggle the Neo-tree file explorer |
| `<C-p>` | Normal | Telescope: find files |
| `<leader>fg` | Normal | Telescope: live grep |
| `gd` | Normal | Go to definition (via Telescope, or `vim.lsp.buf.definition` in Java files) |
| `gD` | Normal | Open definition in a vertical split |
| `gi` | Normal | Go to implementation |
| `gt` | Normal | Go to type definition |
| `gr` | Normal | Show references |
| `<leader>d` | Normal | Show diagnostic float for the line under the cursor |
| `[d` / `]d` | Normal | Jump to previous/next diagnostic |
| `<C-s>` | Normal | Open the theme switcher |
| `<leader>?` | Normal | Show all keybindings (which-key) |
| `<leader>tm` | Normal | Toggle the mouse on/off |
| `<leader>ts` | Normal | Toggle spell checking |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal | Move between windows |
| `<C-t>` | Normal, Terminal | Toggle a floating terminal |
| `<C-g>` | Normal, Terminal | Toggle a floating LazyGit window |
| `<Esc>` | Terminal | Exit terminal mode |

On top of these, Neovim 0.11+ ships default LSP keymaps whenever a language server attaches to a
buffer, including `K` (hover), `grn` (rename), `gra` (code action), `grr` (references), `gri`
(implementation), and `<C-s>` in insert mode (signature help). Run `:help lsp-defaults` for the
full list.

## 8. Plugin overview

| Plugin | Purpose |
| --- | --- |
| `lazy.nvim` | Plugin manager; everything else is installed through it |
| `mason.nvim`, `mason-lspconfig.nvim` | Installs and manages language server binaries |
| `nvim-cmp` + friends (`cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `LuaSnip`, `cmp_luasnip`, `lspkind.nvim`) | Autocompletion, including LSP-driven completion and snippets |
| `nvim-treesitter` | Syntax highlighting and indentation |
| `telescope.nvim` | Fuzzy finder for files, grep, and LSP results |
| `neo-tree.nvim` | File explorer sidebar |
| `nvim-jdtls` | Java language server integration (separate from the Mason-managed servers) |
| `toggleterm.nvim` | Floating/split terminal management |
| `lazygit.nvim` | Wraps the `lazygit` CLI in a floating window |
| `which-key.nvim` | Shows available keybindings as you type a prefix |
| `lualine.nvim` | Status line |
| `noice.nvim`, `nvim-notify` | Redesigned command line, messages, and LSP hover/signature UI |
| `nvim-autopairs` | Auto-closes brackets/quotes |
| `nvim-tmux-navigator` | Pane navigation between Neovim splits and tmux panes |
| `themery.nvim` + colorscheme plugins | Theme switching (see Themes section above) |

## 9. Troubleshooting

- `:checkhealth` — general environment check (missing binaries, Nerd Font issues, etc).
- `:Lazy` — plugin status, updates, and install logs.
- `:Mason` — language server install status; retry a failed install from here.
- `:LspInfo` — which LSP clients are attached to the current buffer, and why not if none are.
- `:messages` — recent errors/notifications if something silently failed on startup.
