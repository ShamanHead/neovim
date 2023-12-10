return {
    {
        "kkoomen/vim-doge",
        event = 'VeryLazy',
        config = function()
            vim.cmd("call doge#install()")
        end,
    },
    {
        'stevearc/conform.nvim',
        cmd = { 'Format' },
        config = function()
            require("conform").setup({
                -- Map of filetype to formatters
                formatters_by_ft = {
                    php = { "pint" },
                    
                    -- Use the "*" filetype to run formatters on all filetypes.
                    ["*"] = { "codespell" },
                    -- Use the "_" filetype to run formatters on filetypes that don't
                    -- have other formatters configured.
                    ["_"] = { "trim_whitespace" },
                },
                -- If this is set, Conform will run the formatter on save.
                -- It will pass the table to conform.format().
                -- This can also be a function that returns the table.
                -- format_on_save = {
                --     -- I recommend these options. See :help conform.format for details.
                --     lsp_fallback = true,
                --     timeout_ms = 500,
                -- },
                -- -- If this is set, Conform will run the formatter asynchronously after save.
                -- -- It will pass the table to conform.format().
                -- -- This can also be a function that returns the table.
                -- format_after_save = {
                --     lsp_fallback = true,
                -- },
                -- Set the log level. Use `:ConformInfo` to see the location of the log file.
                log_level = vim.log.levels.ERROR,
                -- Conform will notify you when a formatter errors
                notify_on_error = true,
                -- Custom formatters and changes to built-in formatters
                formatters = {}})
                vim.api.nvim_create_user_command("Format", function(args)
                  local range = nil
                  if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                      start = { args.line1, 0 },
                      ["end"] = { args.line2, end_line:len() },
                    }
                  end
                  require("conform").format({ async = true, lsp_fallback = true, range = range })
                end, { range = true })
            -- You can set formatters_by_ft and formatters directly
        end
    }
}
