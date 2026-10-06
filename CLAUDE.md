# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration based on LazyVim but heavily customized. The configuration uses Lua and follows a modular plugin architecture with lazy.nvim as the plugin manager. The config lives in `~/.config/nvim` and is structured around the `tvl` namespace.

## Architecture

### Core Structure

- **Entry point**: `init.lua` loads `tvl.core.lazy`
- **Namespace**: All custom code lives under the `tvl` namespace in `lua/tvl/`
- **Plugin manager**: lazy.nvim with plugin specs imported from `tvl.plugins`
- **LSP setup**: Using Neovim's native LSP (0.11+) with `vim.lsp.enable()`, not lspconfig/mason-lspconfig

### Key Directories

```
lua/tvl/
├── core/           # Core configuration (keymaps, icons, lazy.nvim bootstrap)
├── config/         # Subsystem configs (lsp, lualine, dashboard, alpha)
├── plugins/        # Plugin specifications (loaded by lazy.nvim)
├── cmp.lua         # Completion utilities (blink.cmp integration)
└── util.lua        # Utility functions (root detection, telescope themes, etc.)

lsp/                # Native LSP configurations (julials, pyright, jetls, etc.)
format/             # Custom formatters (e.g., runic for Julia)
LuaSnip/            # Custom snippets
ftplugin/           # Filetype-specific settings
```

## LSP Configuration

This config has **transitioned from nvim-lspconfig to native Neovim LSP** (requires Neovim 0.11+). Key points:

1. **Native LSP activation**: LSP servers are enabled via `vim.lsp.enable()` in `lua/tvl/core/lazy.lua:42`
   ```lua
   vim.lsp.enable({ "jetls", "lua_ls", "bashls", "texlab", "pyright" })
   ```

2. **LSP configurations**: Individual LSP configs live in `lsp/*.lua` as standalone files that return `vim.lsp.Config` tables
   - Example: `lsp/julials.lua`, `lsp/pyright.lua`, `lsp/jetls.lua`

3. **Server settings table**: `lua/tvl/config/lsp/servers.lua` contains settings for various LSP servers but is currently not actively used due to the native LSP transition

4. **LSP attach callbacks**: Custom on_attach logic is in `tvl.util.on_attach()` and handles keymaps, inlay hints, and gitsigns integration

5. **Plugin status**: The `nvim-lspconfig` plugin is **disabled** (`lua/tvl/plugins/lsp.lua:4`)

### Adding New LSP Servers

1. Create a new config file in `lsp/<servername>.lua` returning a `vim.lsp.Config` table
2. Add the server name to the `vim.lsp.enable()` call in `lua/tvl/core/lazy.lua:42`
3. Optionally add settings to `lua/tvl/config/lsp/servers.lua` for reference

## Formatting

- **Primary formatter**: conform.nvim (replaces none-ls/null-ls which is disabled)
- **Configured formatters**:
  - `stylua` for Lua
  - `runic` for Julia (custom formatter in `lua/format/runic.lua`)
- **Format keybinding**: `<leader>W` formats with conform and saves the buffer

## Completion

- **Completion engine**: blink.cmp (nvim-cmp is disabled)
- **Snippet engine**: LuaSnip
- **Integration**: Custom completion utilities in `lua/tvl/cmp.lua` handle snippet expansion, preview, and auto-brackets
- **AI completion**: Copilot is configured with custom keybindings (`<C-;>` to accept line)

## Key Patterns

### Root Detection

The `tvl.util.get_root()` function detects project roots using:
1. LSP workspace folders
2. Fallback to patterns: `.git`, `lua`, `package.json`, `mvnw`, `gradlew`, `pom.xml`, `build.gradle`, `release`, `.project`

### Telescope Integration

Many commands use `Util.telescope(builtin, type, opts)` helper for consistent theming. Example:
```lua
{ "<leader><leader>", Util.telescope("find_files"), desc = "Find files" }
```

### Plugin Modularity

Each plugin category has its own file in `lua/tvl/plugins/`:
- `lsp.lua` - LSP and formatters
- `coding.lua` - Completion, snippets, autopairs, surround
- `editor.lua` - File navigation, search, git integration
- `ui.lua` - Statusline, bufferline, indent guides
- `treesitter.lua` - Treesitter configuration
- `tools.lua` - Additional tools

### Disabled Plugins

Several plugins are disabled but kept in config for reference:
- nvim-lspconfig, mason-lspconfig (replaced by native LSP)
- none-ls/null-ls (replaced by conform.nvim)
- nvim-cmp (replaced by blink.cmp)
- Telescope (currently disabled, consider re-enabling or removing)
- neo-tree (currently disabled, using oil.nvim instead)

## Language-Specific Notes

### Julia
- LSP: LanguageServer.jl via native config in `lsp/julials.lua`
- Installation path: `~/.julia/environments/nvim-lspconfig`
- Custom command: `:LspJuliaActivateEnv` to switch Julia environments
- Formatter: runic via conform.nvim

### Python
- LSP: pyright via `lsp/pyright.lua`

### LaTeX
- Plugin: vimtex with Skim viewer
- Shell escape enabled by default for TikZ/PGF compilation
- Custom utility: `tvl.util.find_tikzpicture()` extracts TikZ pictures to separate files

## Common Tasks

### Modifying Keymaps
- Core keymaps: `lua/tvl/core/keymaps.lua`
- Plugin-specific keymaps: Defined in respective plugin spec files in `lua/tvl/plugins/`
- Leader key: `<Space>` (configured implicitly by which-key)

### Adding a New Plugin
1. Add plugin spec to appropriate file in `lua/tvl/plugins/`
2. Use lazy.nvim spec format with `keys`, `cmd`, `event`, etc. for lazy loading
3. Add which-key group mappings in `lua/tvl/plugins/editor.lua` if needed

### Updating Icons
- All icons centralized in `lua/tvl/core/icons.lua`
- Used by: diagnostics, completion (kinds), git signs, lualine, etc.

## Development Notes

- This config uses Neovim 0.11+ features (native LSP via `vim.lsp.enable()`)
- Many experimental features from LazyVim have been adopted (blink.cmp, Snacks.nvim toggles)
- The config is in active transition from lspconfig to native LSP - some references to old patterns may remain
