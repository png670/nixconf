require('nvim-autopairs').setup({})

-- Auto-close brackets play nicely with cmp's confirm (e.g. typing a function
-- call's opening paren from a completion entry doesn't double up).
local ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if ok then
  require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
end
