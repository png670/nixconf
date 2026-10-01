-- nvim-lspconfig just needs to be on runtimepath (via Plug) — it ships
-- per-server configs as lsp/<name>.lua files that vim.lsp.enable() below
-- picks up by name; nothing to require() here.

-- Shared config applied to every server.
vim.lsp.config('*', {
  on_attach = function(_, bufnr)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gr', vim.lsp.buf.references, 'List references')
    map('n', 'K', vim.lsp.buf.hover, 'Hover docs')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
    map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
    map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
  end,
})

-- Turn on whichever of these you actually have the language server binary
-- installed for (ideally via Nix, e.g. home.packages) — enabling one you
-- haven't installed is harmless, it just never attaches to anything.
vim.lsp.enable({
  'lua_ls',
  'bashls',
  'clangd',
  'pyright',
  'rust_analyzer',
  'ts_ls',
  'jsonls',
  'cssls',
  'html',
  'gopls',
})

vim.diagnostic.config({
  virtual_text = { prefix = '●' },
  severity_sort = true,
  float = { border = 'rounded' },
})
