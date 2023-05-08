return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            --mode = "tabs", -- set to "tabs" to only show tabpages instead
            themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
            numbers = "none",
            indicator = {
                style = 'underline',
            },
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            --- name_formatter can be used to change the buffer's label in the bufferline.
            --- Please note some names can/will break the
            --- bufferline so use this at your discretion knowing that it has
            --- some limitations that will *NOT* be fixed.
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            truncate_names = true, -- whether or not tab names should be truncated
            tab_size = 18,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "[" .. count .. "]"
            end,
            color_icons = true,
            --separator_style = "thick",
            always_show_bufferline = true,
            show_tab_indicators = false,
            sort_by = 'insert_after_current'
            -- add custom logic
        }
    }
}
