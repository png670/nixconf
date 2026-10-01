
pcall(vim.loader.enable)

vim.g.mapleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- Look
Plug('decaycs/decay.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')

-- Navigation / editing
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-tree/nvim-tree.lua')
Plug('folke/which-key.nvim')
Plug('numToStr/Comment.nvim')
Plug('lewis6991/gitsigns.nvim')
Plug('windwp/nvim-autopairs')
Plug('ibhagwan/fzf-lua')

-- LSP / completion / linting
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')
Plug('mfussenegger/nvim-lint')

-- Misc
Plug('OXY2DEV/markview.nvim')
Plug('ron-rs/ron.vim')
-- Plug('norcalli/nvim-colorizer.lua')

vim.call('plug#end')

require("options")
require("keymaps")

-- Plugin configurations
require("plugins.lualine")
require("plugins.nvim-tree")
require("plugins.which-key")
require("plugins.treesitter")
require("plugins.gitsigns")
require("plugins.comment")
require("plugins.lint")
require("plugins.lsp")
require("plugins.completion")
require("plugins.autopairs")
require("plugins.fuzzy")
require("plugins.markview")
