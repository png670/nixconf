
require("nvim-tree").setup({
    view = {
        width = 25,
        side = "left",
        signcolumn = "no",           -- removes the sign column line
        preserve_window_proportions = true,
    },
    renderer = {
        indent_markers = {
            enable = false,          -- disable vertical indent lines
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
