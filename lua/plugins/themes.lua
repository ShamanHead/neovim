return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            vim.cmd("colorscheme catppuccin-mocha")
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        event = 'VeryLazy'
    }
}
