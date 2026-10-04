require("nvim-tree").setup({
    view = {
        width = 25,
        side = "left",
        signcolumn = "no",
        preserve_window_proportions = true,
    },
    renderer = {
        indent_markers = {
            enable = false,
            inline_arrows = false,
        },
        icons = {
            padding = {
                icon = " ",
                folder_arrow = " ",
            },
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
})

vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus file explorer" })
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file explorer" })
