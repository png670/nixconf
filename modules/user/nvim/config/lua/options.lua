vim.opt.termguicolors = false
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

vim.opt.undofile = true    -- undo history survives closing the file
vim.opt.updatetime = 250   -- faster CursorHold events (diagnostics, gitsigns)
vim.opt.signcolumn = "yes" -- gutter reserved up front, text doesn't shift
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 4
vim.opt.wrap = false
