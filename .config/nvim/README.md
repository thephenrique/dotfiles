# Awesome Neovim configuration

Just the necessary. \ (•◡•) /

## Structure

### Neovim startup configurations.

- `~/.config/nvim/init.lua`
  - Mapping Leader key.
  - Bootstrap default Neovim editor settings.
  - Bootstrap the plugin manager.
  - Load the plugins.

### Default Neovim editor settings.

- `~/.config/nvim/lua/thephenrique/default/builtin.lua`
  - Settings of builtin plugins.
- `~/.config/nvim/lua/thephenrique/default/options.lua`
  - Settings of Neovim options.
- `~/.config/nvim/lua/thephenrique/default/mappings.lua`
  - Neovim global mappings.
- `~/.config/nvim/lua/thephenrique/default/commands.lua`
  - Neovim global commands.

### Neovim load plugins.

- `~/.config/nvim/lua/thephenrique/plugins/init.lua`
  - Load/unload `Lazy.nvim` plugins.
- `~/.config/nvim/lua/thephenrique/plugins/[PLUGIN_NAME].lua`
- `~/.config/nvim/lua/thephenrique/plugins/*`

### Neovim setup and mapping plugins.

- `~/.config/nvim/after/plugin/[PLUGIN_NAME].lua`
- `~/.config/nvim/after/plugin/*`

## Plugins:

### UI.

- `zenburn`.
  - Awesome theme.
- `lualine.nvim`.
  - Awesome Statusline theme helper.
- `nvim-tree`.
  - Awesome File Tree helper.
- `fidget.nvim`.
  - Show progress and notifications.

### LSP (Language Server Protocol).

- `nvim-lspconfig`.
  - Native LSP.
- `mason.nvim` and `mason-lspconfig`.
  - LSP servers manager.
- `neodev.nvim` and `LuaSnip`.
  - Lua LSP configuraton helper.
- `conform.nvim`.
  - Formatter.

### Completions.

- `nvim-cmp` and `...`.
  - Completion engine.
- `lspkind.nvim`.
  - Icons for completions.
- `LuaSnip`.
  - Lua snippet engine.

### Coding helpers.

- `telescope.nvim`.
  - Awesome finder.
- `treesitter.nvim`.
  - Syntax highlighting and folding support.
- `vim-visual-multi`.
  - Awesome multiple cursors.
- `nvim-ufo`.
  - Fold.
- `Comment.nvim`.
  - Automate line and block comments.
- `nvim-autopairs`.
  - Close pairs.
- `nvim-colorizar`.
  - Show HEX color background in editor.
- `vim-matchup`.
  - Matching keys extend features.

### Git helpers.

- `neogit`.
  - Git user interface.

- `gitsigns.nvim`.
  - Git decorations inside of Buffer.

### Markdown helpers.

- `markdown-preview.nvim`.
  - Render markdown.

## TODO:

- The `eslint-lsp` is a quite slow on first Neovim load. Replace?
- Styled Components hover and completions not working. Missing some LSP?
