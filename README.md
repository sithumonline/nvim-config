# 🚀 Minimal Go-Focused Neovim Configuration

A clean, fast, and productive Neovim setup optimized for Go development with LSP, completion, fuzzy finding, and quality-of-life improvements.

## ✨ Features

- **🎯 Go-First**: Optimized for Go development with `gopls` LSP
- **🔍 Telescope**: Fast fuzzy finding for files, grep, buffers, and more
- **💡 Smart Completion**: Enhanced `nvim-cmp` with LSP, snippets, and ghost text
- **📝 Grammar & Spell Check**: Harper-LS for writing and documentation
- **🎨 High-Contrast Theme**: Tokyonight with LSP-friendly diagnostics
- **⚡ Minimal & Fast**: Only essential plugins, quick startup
- **🛠️ Quality of Life**: Sensible defaults, ergonomic keymaps

## 📦 Plugin List

| Plugin                                                                                   | Purpose                     |
| ---------------------------------------------------------------------------------------- | --------------------------- |
| [gruvbox](https://github.com/gruvbox-community/gruvbox)                                  | Fallback colorscheme        |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)                              | Primary high-contrast theme |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)                       | Fuzzy finder                |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF sorter for Telescope    |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                               | LSP configuration           |
| [Harper-LS](https://github.com/elijah-potter/harper)                                     | Grammar and spell checking  |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                          | Completion engine           |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                           | Snippet engine              |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)                     | Snippet collection          |

## 🔧 Installation

### Prerequisites

- Neovim 0.8+
- Git
- A Nerd Font (for icons)
- Go 1.19+ with `gopls` installed:
  ```bash
  go install golang.org/x/tools/gopls@latest
  ```
- Harper-LS for grammar checking:
  ```bash
  # Using npm
  npm install -g @harper-ls/harper-ls
  # Or using cargo
  cargo install harper-ls --locked
  ```

### Setup

1. **Backup existing config** (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:

   ```bash
   git clone https://github.com/yourusername/nvim-config ~/.config/nvim
   ```

3. **Install vim-plug** (if not already installed):

   ```bash
   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```

4. **Install plugins**:

   ```bash
   nvim +PlugInstall +qall
   ```

5. **Build telescope-fzf-native**:
   ```bash
   cd ~/.config/nvim/plugged/telescope-fzf-native.nvim && make
   ```

## ⌨️ Key Mappings

### Leader Key: `<Space>`

#### Files & Navigation

| Key          | Action       |
| ------------ | ------------ |
| `<leader>ff` | Find files   |
| `<leader>fg` | Live grep    |
| `<leader>fb` | List buffers |
| `<leader>fh` | Help tags    |
| `<leader>fr` | Recent files |

#### LSP (Go Development)

| Key          | Action                      |
| ------------ | --------------------------- |
| `gd`         | Go to definition            |
| `gD`         | Go to declaration           |
| `gi`         | Go to implementation        |
| `gr`         | Find references (Telescope) |
| `K`          | Hover documentation         |
| `<leader>rn` | Rename symbol               |
| `<leader>ca` | Code actions                |
| `<leader>f`  | Format buffer               |
| `<leader>hf` | Harper grammar fix          |
| `]d` / `[d`  | Next/previous diagnostic    |

#### Window Management

| Key           | Action               |
| ------------- | -------------------- |
| `<C-h/j/k/l>` | Move between windows |
| `<leader>w`   | Save file            |
| `<leader>q`   | Quit                 |
| `<leader>bd`  | Delete buffer        |

#### Completion

| Key               | Action                        |
| ----------------- | ----------------------------- |
| `<C-Space>`       | Trigger completion            |
| `<C-n>` / `<C-p>` | Navigate items                |
| `<Tab>`           | Expand snippet / jump forward |
| `<S-Tab>`         | Jump backward                 |
| `<CR>`            | Confirm selection             |

## 🎨 Theme

Uses **Tokyonight Night** for high contrast and readability:

- Clear diagnostic highlighting with undercurls
- Enhanced LSP reference highlighting
- Optimized completion menu colors
- Fallback to Gruvbox (hard contrast) if Tokyonight unavailable

## 📁 File Structure

```
~/.config/nvim/
├── init.vim                    # Main configuration
├── lua/sithumonline/
│   ├── telescope.lua          # Telescope setup
│   ├── lsp_go.lua            # Go LSP configuration
│   ├── harper.lua            # Harper-LS grammar checking
│   ├── cmp.lua               # Completion setup
│   └── colors.lua            # Theme configuration
├── docs/
│   └── go_nvim_cheatsheet.tex # Printable cheat sheet
└── README.md                  # This file
```

## 🚀 Go Development Workflow

1. **Open project**: `nvim .` or `<leader>ff` to find files
2. **Navigate code**: Use LSP mappings (`gd`, `gr`, `gi`)
3. **Search**: `<leader>fg` for project-wide search
4. **Format on save**: Automatic with `gofumpt`
5. **Run tests**: `:!go test` or `:!go test ./...`
6. **Build**: `:!go build`

## 📝 Customization

### Add More LSP Servers

Edit `lua/sithumonline/lsp_go.lua` and add configurations for other languages.

### Change Theme Style

In `lua/sithumonline/colors.lua`, change:

```lua
style = 'night' -- Try 'storm', 'day', or 'moon'
```

### Modify Keymaps

Add custom mappings in `init.vim` or the respective Lua files.

## 🔧 Troubleshooting

### LSP Not Working

- Ensure `gopls` is installed: `which gopls`
- Check LSP status: `:LspInfo`
- Restart LSP: `:LspRestart`

### Telescope Slow

- Build fzf native: `cd ~/.config/nvim/plugged/telescope-fzf-native.nvim && make`
- Install `fd` for faster file finding: `brew install fd`

### Completion Issues

- Update plugins: `:PlugUpdate`
- Check sources: `:CmpStatus`

### Harper-LS Issues

- Ensure Harper-LS is installed: `which harper-ls`
- Toggle Harper: `:HarperToggle`
- Check LSP status: `:LspInfo`

## 📚 Learning Resources

- [Neovim LSP Guide](https://neovim.io/doc/user/lsp.html)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim#usage)
- [Go Development with Neovim](https://github.com/golang/tools/blob/master/gopls/doc/vim.md)

## 🤝 Contributing

Feel free to open issues or submit pull requests for improvements!

## 📄 License

MIT License - feel free to use and modify as needed.

---

_Happy coding with Go and Neovim! 🎯_
