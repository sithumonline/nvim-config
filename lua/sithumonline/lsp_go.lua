-- ~/.config/nvim/lua/lsp_go.lua
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- capabilities (enable LSP-based completion if you use nvim-cmp)
local caps = vim.lsp.protocol.make_client_capabilities()
pcall(function()
  caps = require("cmp_nvim_lsp").default_capabilities(caps)
end)

local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- LSP keymaps
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gr", require("telescope.builtin").lsp_references, "References")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "K",  vim.lsp.buf.hover, "Hover docs")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>f", function() vim.lsp.buf.format({ async = false }) end, "Format")

  -- Inlay hints (Neovim 0.10+)
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Less noisy diagnostics and pretty borders
  vim.diagnostic.config({
    virtual_text = { spacing = 2, prefix = "●" },
    float = { border = "rounded", source = "if_many" },
    severity_sort = true,
  })
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

lspconfig.gopls.setup({
  capabilities = caps,
  on_attach = on_attach,
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      -- Formatting/imports
      gofumpt = true,
      -- Completions
      usePlaceholders = true,
      completeUnimported = true,
      -- Static checks
      staticcheck = true,
      -- Analyses
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
        -- fieldalignment = true,
      },
      -- Codelenses visible in code actions
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      -- Inlay hints
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      -- Ignore noisy dirs
      directoryFilters = { "-**/vendor", "-**/.git", "-**/node_modules", "-**/dist", "-**/build" },
      -- Example: build tags (uncomment if you need tags)
      -- buildFlags = { "-tags=integration" },
    },
  },
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function() vim.lsp.buf.format({ async = false }) end,
})

