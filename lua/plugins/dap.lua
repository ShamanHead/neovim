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
                    port = 9003,
                    -- localSourceRoot = "/home/smhd/docker",
                    -- serverSourceRoot = 'localhost:8081',
                    pathMappings = {
                        ["/src"] = "/home/smhd/docker/consultancy-services/src",
                        ["/var/www/html"] = "${workspaceFolder}",
                        -- ["/var/www"] = "${workspaceFolder}",
                    }
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

            local dap, dapui = require("dap"), require("dapui")

            dapui.setup();
            
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    }
}
