local api = vim.api;

local conf_files = {
    "settings",
    "mappings",
    "plugins/init",
    "autocommands"
}

for _, name in ipairs(conf_files) do
    local path = vim.fn.stdpath("config")
        .. '/' .. name .. '.lua'

    local source_cmd = "source " .. path

    vim.cmd(source_cmd)
end
