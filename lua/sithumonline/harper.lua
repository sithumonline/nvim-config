-- Harper-LS configuration for grammar and spell checking
local lspconfig = require("lspconfig")

-- capabilities (enable LSP-based completion if you use nvim-cmp)
local caps = vim.lsp.protocol.make_client_capabilities()
pcall(function()
  caps = require("cmp_nvim_lsp").default_capabilities(caps)
end)

local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- LSP keymaps for Harper
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gr", require("telescope.builtin").lsp_references, "References")
  map("n", "K",  vim.lsp.buf.hover, "Hover docs")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  
  -- Harper-specific actions
  map("n", "<leader>hf", function() vim.lsp.buf.code_action() end, "Harper fix")
  
  -- Less noisy diagnostics for writing
  vim.diagnostic.config({
    virtual_text = { spacing = 2, prefix = "📝" },
    float = { border = "rounded", source = "if_many" },
    severity_sort = true,
  })
end

-- Harper-LS setup
lspconfig.harper_ls.setup({
  capabilities = caps,
  on_attach = on_attach,
  settings = {
    ["harper-ls"] = {
      -- Language for spell checking
      language = "en-US",
      
      -- Enabled linters
      linters = {
        spell_check = true,
        an_a = true,
        sentence_capitalization = true,
        unclosed_quotes = true,
        wrong_quotes = true,
        long_sentences = true,
        repeated_words = true,
        spaces = true,
        matcher = true,
      },
      
      -- Diagnostics configuration
      diagnostics = {
        -- Show diagnostics on save
        on_save = true,
        -- Show diagnostics on change (can be noisy)
        on_change = false,
      },
    },
  },
  
  -- File types to attach Harper to
  filetypes = { 
    "markdown", 
    "text", 
    "tex", 
    "rst", 
    "html", 
    "gitcommit",
    "go" -- For Go comments and strings
  },
  
  -- Root directory patterns
  root_dir = function(fname)
    return vim.loop.cwd()
  end,
  
  -- Single file support
  single_file_support = true,
})

-- Auto-commands for Harper
vim.api.nvim_create_augroup("Harper", { clear = true })

-- Enable Harper for specific file types
vim.api.nvim_create_autocmd("FileType", {
  group = "Harper",
  pattern = { "markdown", "text", "tex", "rst", "html", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Toggle Harper diagnostics
vim.api.nvim_create_user_command("HarperToggle", function()
  local clients = vim.lsp.get_active_clients({ name = "harper_ls" })
  if #clients > 0 then
    for _, client in ipairs(clients) do
      vim.lsp.stop_client(client.id)
    end
    print("Harper-LS stopped")
  else
    vim.cmd("LspStart harper_ls")
    print("Harper-LS started")
  end
end, { desc = "Toggle Harper-LS" })

