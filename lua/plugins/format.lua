return {
    {
        "kkoomen/vim-doge",
        event = 'VeryLazy',
        config = function()
            vim.cmd("call doge#install()")
        end,
    },
    {
        'mhartington/formatter.nvim',
        cmd = {'Format'},
        config = function()
            local util = require "formatter.util"

            require("formatter").setup {
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    php =
                        function()
                            return {
                                exe = "pint",
                                args = {
                                    "",
                                    util.escape_path(util.get_current_buffer_file_path()),
                                },
                            }
                        end,
                    ["*"] = {
                        require("formatter.filetypes.any").remove_trailing_whitespace
                    }
                }
            }
        end
    }
    -- {
    --     'stevearc/conform.nvim',
    --     config = function()
    --         require("conform").setup({
    --             formatters_by_ft = {
    --                 -- lua = { "stylua" },
    --                 -- Conform will run multiple formatters sequentially
    --                 -- python = { "isort", "black" },
    --                 -- Use a sub-list to run only the first available formatter
    --                 -- javascript = { { "prettierd", "prettier" } },
    --                 php = { 'php-cs-fixer' }
    --             },
    --         })
    --     end,
    -- }
}
