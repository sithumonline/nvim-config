-- Leader must be set before any mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Hard-require telescope; fail gracefully if plugin isn't loaded yet
local ok_telescope, telescope = pcall(require, "telescope")
if not ok_telescope then
  vim.notify("telescope.nvim not found", vim.log.levels.WARN)
  return
end

local ok_builtin, builtin = pcall(require, "telescope.builtin")
if not ok_builtin then
  vim.notify("telescope.builtin not found", vim.log.levels.WARN)
  return
end

-- Keymaps
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Telescope: live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Telescope: buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Telescope: help tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles,   { desc = "Telescope: recent files" })

-- Setup
telescope.setup({
  defaults = {
    prompt_prefix = "  ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-u>"] = false,  -- keep macOS terminal <C-u> clean if you prefer
      },
    },
  },
  pickers = {
    find_files = {
      -- if you install `fd`, this is faster and respects .gitignore
      find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- Load fzf extension if present (no error if missing)
pcall(telescope.load_extension, "fzf")

