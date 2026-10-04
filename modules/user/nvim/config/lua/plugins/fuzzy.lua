require('fzf-lua').setup({
  winopts = { height = 0.5, width = 0.6 },
})

local fzf = require('fzf-lua')
local function map(lhs, fn, desc)
  vim.keymap.set('n', lhs, fn, { silent = true, desc = desc })
end

map('<leader>ff', fzf.files, 'Find files')
map('<leader>fg', fzf.live_grep, 'Live grep')
map('<leader>fb', fzf.buffers, 'Buffers')
map('<leader>fh', fzf.help_tags, 'Help tags')
