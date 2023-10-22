return {
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     config = function()
    --     end
    -- },
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     event = 'VeryLazy'
    -- },
    {
        "navarasu/onedark.nvim",
        config = function()
            require('onedark').setup {
                style = 'deep'
            }
            vim.cmd("colorscheme onedark")
            vim.cmd("set background=light")
        end,
    }
}
