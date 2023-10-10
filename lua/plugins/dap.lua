return {
    {
        'mfussenegger/nvim-dap',
        cmd = 'DapToggleBreakPoint',
        config = function()
            local dap = require("dap")
            dap.adapters.php = {
                type = 'executable',
                command = 'node',
                args = { os.getenv('HOME') .. '/vscode-php-debug/out/phpDebug.js' }
            }

            dap.configurations.php = {
                {
                    type = 'php',
                    request = 'launch',
                    log = true,
                    name = 'Listen for xdebug',
                    port = 9001,
                    localSourceRoot = "/home/smhd/docker/metaform/backend",
                    serverSourceRoot = 'api.app.localdomain'
                }
            }

            require("dap").adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = { "/home/smhd/js-debug/src/dapDebugServer.js", "${port}" },
                }
            }

            require("dap").configurations.javascript = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
            }
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        event = 'VeryLazy',
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end,
    }
}
