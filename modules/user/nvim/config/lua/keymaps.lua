local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map("n", "<leader>P", ":PlugInstall<CR>", "Install plugins")
map("n", "<leader>u", ':silent !xdg-open "<cWORD>" &<CR>', "Open URL under cursor")

-- NvimTree keybinds
-- map("n", "<leader>f", ":NvimTreeFocus<CR>")
-- map("n", "<leader>t", ":NvimTreeToggle<CR>")

map("n", "<Esc>", ":nohlsearch<CR>", "Clear search highlight")
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")
map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
