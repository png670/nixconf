local lint = require('lint')

-- Adjust per language — these just need the linter binary on $PATH
-- (install via Nix for the same reason LSP servers should be).
lint.linters_by_ft = {
  python = { 'ruff' },
  sh = { 'shellcheck' },
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
  callback = function()
    lint.try_lint()
  end,
})
