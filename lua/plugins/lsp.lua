return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local nvim_lsp = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            --local navic = require('nvim-navic')

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                -- Enable completion triggered by <c-x><c-o>
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                local opts = { noremap = true, silent = true }

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                    opts)
                buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
                buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
                buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
                buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
                buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
            end
            nvim_lsp.emmet_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'php' },
                init_options = {
                    html = {
                        options = {
                            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                            ["bem.enabled"] = true,
                        },
                    },
                }
            })
            nvim_lsp.volar.setup {
                filetypes = { 'vue', 'json' },
                capabilities = capabilities,
                on_attach = on_attach
            }

            nvim_lsp.phpactor.setup({
                -- settings = {
                -- phpactor = {
                --     stubs = {
                --         "bcmath",
                --         "laravel",
                --         "bz2",
                --         "Core",
                --         "curl",
                --         "date",
                --         "dom",
                --         "fileinfo",
                --         "filter",
                --         "gd",
                --         "gettext",
                --         "hash",
                --         "iconv",
                --         "imap",
                --         "intl",
                --         "json",
                --         "libxml",
                --         "mbstring",
                --         "mcrypt",
                --         "mysql",
                --         "mysqli",
                --         "password",
                --         "pcntl",
                --         "pcre",
                --         "PDO",
                --         "pdo_mysql",
                --         "Phar",
                --         "readline",
                --         "regex",
                --         "session",
                --         "SimpleXML",
                --         "sockets",
                --         "sodium",
                --         "standard",
                --         "superglobals",
                --         "tokenizer",
                --         "xml",
                --         "xdebug",
                --         "xmlreader",
                --         "xmlwriter",
                --         "yaml",
                --         "zip",
                --         "zlib",
                --         "wordpress-stubs",
                --         "woocommerce-stubs",
                --         "acf-pro-stubs",
                --         "wordpress-globals",
                --         "wp-cli-stubs",
                --         "genesis-stubs",
                --         "polylang-stubs"
                --     },
                --     files = {
                --         maxSize = 5000000,
                --     },
                -- },
                -- },
                filetypes = {
                    "html", 'php'
                },
                capabilities = capabilities,
                on_attach = on_attach
            });
            nvim_lsp.html.setup {
                on_attach = on_attach,
                filetypes = {
                    "html", 'svelte', 'php'
                },
                capabilities = capabilities,
            }
            nvim_lsp.tsserver.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
            nvim_lsp.tailwindcss.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
            nvim_lsp.csharp_ls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            };
            nvim_lsp.lua_ls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            };
            nvim_lsp.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true
                        },
                    }
                }
            })
            nvim_lsp.clangd.setup {}
            -- nvim_lsp.volar.setup{}
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "1.2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    {
        'hrsh7th/nvim-cmp',
        event = { "BufReadPre", "BufNewFile" },

    },
    {
        "hrsh7th/cmp-nvim-lsp",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local luasnip = require 'luasnip'
            local cmp = require 'cmp'

            cmp.setup {
                completion = {
                    autocomplete = false
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = function(fallback)
                        if vim.fn.pumvisible() == 1 then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
                        elseif luasnip.expand_or_jumpable() then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true,
                                true), '')
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = function(fallback)
                        if vim.fn.pumvisible() == 1 then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
                        elseif luasnip.jumpable(-1) then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true),
                                '')
                        else
                            fallback()
                        end
                    end,
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' }
                }
            }
        end
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        opts = {
            ensure_installed = {
                "rust-analyzer",
                "intelephense",
                "typescript-language-server",
                "lua-language-server"
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },

        config = function()
            require "lint".linters_by_ft =
            {
                -- php = { 'phpcs' }
            }
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = 'TroubleToggle',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    }
}
