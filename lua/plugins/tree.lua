return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { '<leader>e', '<cmd>NvimTreeToggle<cr>' }
    },
    opts = {
        view = {
            width = 30,
            side = 'left',
        },
        renderer = {
            group_empty = true, -- Compact empty folders
            icons = {
                show = {
                    git = true,
                    folder = true,
                    file = true,
                },
            },
        },
        filters = {
            dotfiles = false, -- Show hidden files
            custom = { '.git', 'node_modules', '.cache' },
        },
        actions = {
            open_file = {
                quit_on_open = true, -- Close tree when opening file
            },
        },
    }
}
