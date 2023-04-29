return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            ''
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
            require("telescope").load_extension("file_browser")
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension("file_browser")
        end
    }
}
