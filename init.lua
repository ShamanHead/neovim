local api = vim.api;

local conf_files = {
    "plugins.lua",
    "settings.lua",
    "mappings.lua",
    "plugins/init.lua",
}

for _, name in ipairs(conf_files) do
    local path = vim.fn.stdpath("config") .. '/' .. name

    local source_cmd = "source " .. path

    vim.cmd(source_cmd)
end
