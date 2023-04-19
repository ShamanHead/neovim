local api = vim.api;

local conf_files = {
    "nvim-cmp.lua",
    "nvim-colorizer.lua",
    "telescope.lua",
    "nvim-terminal.lua",
    "lualine.lua",
    "lsp.lua",
    "packer.lua",
    "projectmanager.lua",
    "tree-sitter.lua",
    "bufferline.lua",
    "dap.lua",
    "dap-virtual-text.lua"
}

for _, name in ipairs(conf_files) do
    local path = vim.fn.stdpath("config") .. '/plugins/' .. name

    local source_cmd = "source " .. path

    vim.cmd(source_cmd)
end
