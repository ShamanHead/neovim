local dap = require 'dap'

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/home/smhd/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
        localSourceRoot = vim.fn.expand("%:p:h") .. "/",
        serverSourceRoot = vim.fn.expand("%:p:h") .. "/",
    }
}
