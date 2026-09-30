vim.g.mapleader = ","
 
local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
  vim.cmd('silent !curl -fLo ' .. data_dir .. '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end
 
pcall(vim.loader.enable)

vim.opt.termguicolors = false

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('decaycs/decay.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('folke/which-key.nvim')
Plug('3rd/image.nvim')
Plug('mfussenegger/nvim-lint') 
Plug('OXY2DEV/markview.nvim')
Plug('nvim-tree/nvim-tree.lua')
Plug('lewis6991/gitsigns.nvim')
Plug('ron-rs/ron.vim')
-- Plug('norcalli/nvim-colorizer.lua')
Plug('numToStr/Comment.nvim')
vim.call('plug#end')
 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
 
vim.opt.bg = "light" 
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
    name = 'wl-clipboard',
    copy = {
        ['+'] = 'wl-copy --type text/plain',
        ['*'] = 'wl-copy --type text/plain',
    },
    paste = {
        ['+'] = 'wl-paste --no-newline',
        ['*'] = 'wl-paste --no-newline',
    },
    cache_enabled = 1,
}
vim.opt.swapfile = false
vim.opt.smoothscroll = true
vim.opt.title = true
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.showmode = false
 
local function map(m, k, v)
    vim.keymap.set(m, k, v, { noremap = true, silent = true })
end
 
-- NvimTree keybinds
-- map("n", "<leader>f", ":NvimTreeFocus<CR>") 
-- map("n", "<leader>t", ":NvimTreeToggle<CR>")
map("n", "<leader>P", ":PlugInstall<CR>") 
map("n", "<leader>u", ':silent !xdg-open "<cWORD>" &<CR>')

-- Load plugin configurations
-- require("plugins.colorizer")
-- require("plugins.lualine")
require("plugins.nvim-tree")
require("plugins.which-key")
