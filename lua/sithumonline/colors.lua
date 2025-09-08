-- LSP-friendly theme setup: prefer tokyonight, fallback to gruvbox
local ok_tn, tokyonight = pcall(require, 'tokyonight')

if ok_tn then
  tokyonight.setup({
    style = 'night', -- darker, higher contrast
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = false },
      keywords = { italic = false, bold = true },
      functions = { bold = true },
      variables = {},
      types = { bold = true },
    },
    dim_inactive = false,
    lualine_bold = true,
    on_colors = function(colors)
      -- make diagnostics clearer
      colors.error = '#ff6b6b'
      colors.warning = '#f6c177'
      colors.info = '#7aa2f7'
      colors.hint = '#9ece6a'
    end,
    on_highlights = function(hl, c)
      -- underline + colored virtual text for diagnostics
      hl.DiagnosticVirtualTextError = { fg = c.error, bg = c.bg_highlight }
      hl.DiagnosticVirtualTextWarn  = { fg = c.warning, bg = c.bg_highlight }
      hl.DiagnosticVirtualTextInfo  = { fg = c.info, bg = c.bg_highlight }
      hl.DiagnosticVirtualTextHint  = { fg = c.hint, bg = c.bg_highlight }
      hl.DiagnosticUnderlineError   = { sp = c.error, undercurl = true }
      hl.DiagnosticUnderlineWarn    = { sp = c.warning, undercurl = true }
      hl.DiagnosticUnderlineInfo    = { sp = c.info, undercurl = true }
      hl.DiagnosticUnderlineHint    = { sp = c.hint, undercurl = true }
      -- Cursor line and numbers
      hl.CursorLine   = { bg = c.bg_highlight }
      hl.CursorLineNr = { fg = c.yellow, bold = true }
      hl.LineNr       = { fg = c.fg_gutter }
      -- LSP references more visible
      hl.LspReferenceText  = { bg = c.bg_highlight }
      hl.LspReferenceRead  = { bg = c.bg_highlight }
      hl.LspReferenceWrite = { bg = c.bg_highlight, underline = true }
      -- Popups & borders
      hl.NormalFloat = { bg = c.bg_dark }
      hl.FloatBorder = { fg = c.border_highlight, bg = c.bg_dark }
      hl.WinSeparator = { fg = c.fg_gutter }
      -- Completion menu readability
      hl.Pmenu     = { bg = c.bg_dark, fg = c.fg }
      hl.PmenuSel  = { bg = c.blue, fg = c.bg }
      hl.PmenuSbar = { bg = c.bg_highlight }
      hl.PmenuThumb= { bg = c.blue }
      -- Inlay hints subtle but readable
      hl.InlayHint    = { fg = c.comment, bg = c.bg_highlight }
      hl.LspInlayHint = { fg = c.comment, bg = c.bg_highlight }
      -- Search highlights pop
      hl.Search    = { bg = c.orange, fg = c.black }
      hl.IncSearch = { bg = c.yellow, fg = c.black }
    end,
  })
  vim.cmd('colorscheme tokyonight')
else
  -- Fallback: gruvbox tweaks for better LSP contrast
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.g.gruvbox_italic = 0
  pcall(vim.cmd, 'colorscheme gruvbox')
  -- Diagnostic highlights to improve visibility
  local function set_hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end
  set_hi('DiagnosticVirtualTextError', { fg = '#fb4934', bg = '#2a2827' })
  set_hi('DiagnosticVirtualTextWarn',  { fg = '#fabd2f', bg = '#2a2a22' })
  set_hi('DiagnosticVirtualTextInfo',  { fg = '#83a598', bg = '#273035' })
  set_hi('DiagnosticVirtualTextHint',  { fg = '#b8bb26', bg = '#282c26' })
  set_hi('DiagnosticUnderlineError',   { undercurl = true, sp = '#fb4934' })
  set_hi('DiagnosticUnderlineWarn',    { undercurl = true, sp = '#fabd2f' })
  set_hi('DiagnosticUnderlineInfo',    { undercurl = true, sp = '#83a598' })
  set_hi('DiagnosticUnderlineHint',    { undercurl = true, sp = '#b8bb26' })
  -- Cursor/line numbers & menu
  set_hi('CursorLine',   { bg = '#1d2021' })
  set_hi('CursorLineNr', { fg = '#fabd2f', bold = true })
  set_hi('LineNr',       { fg = '#665c54' })
  set_hi('NormalFloat',  { bg = '#1d2021' })
  set_hi('FloatBorder',  { fg = '#928374', bg = '#1d2021' })
  set_hi('Pmenu',        { bg = '#1d2021', fg = '#ebdbb2' })
  set_hi('PmenuSel',     { bg = '#458588', fg = '#1d2021' })
end
