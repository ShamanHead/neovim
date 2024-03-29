return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require("telescope").setup {
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        no_ignore = true,
                        mappings = {},
                    },
                },
            }
            require('telescope').load_extension('projects')
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        cmd = 'Telescope find_files',
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension("file_browser")
        end
    },
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
        cmd = {'Telescope live_grep_args'},
        config = function()
            require("telescope").load_extension("live_grep_args");
        end
    }
}
