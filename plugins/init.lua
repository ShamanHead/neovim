local api = vim.api;

local conf_files = {
    "packer.lua",
    "telescope.lua",
    "alpha.lua",
    "nvim-terminal.lua",
    "nvim-cmp.lua",
    "lsp.lua",
}

for _, name in ipairs(conf_files) do
    local path = vim.fn.stdpath("config") .. '/plugins/' .. name

    local source_cmd = "source " .. path

    vim.cmd(source_cmd)
end
