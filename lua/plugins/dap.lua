return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require("dap")
            dap.adapters.php = {
                type = 'executable',
                command = 'node',
                args = { '/home/smhd/vscode-php-debug/out/phpDebug.js' }
            }

            dap.configurations.php = {
                {
                    type = 'php',
                    request = 'launch',
                    name = 'Listen for Xdebug',
                    port = 9000
                }
            }
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {"mfussenegger/nvim-dap"},
        config = function()
            require("dapui").setup()
        end;
    }
}
