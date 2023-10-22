return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.indentscope').setup()
            require('mini.cursorword').setup({delay = 0})
            require('mini.jump').setup()
        end,
    },
}
