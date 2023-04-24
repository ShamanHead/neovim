return require('packer').startup(function(use)
    use 'lewis6991/impatient.nvim'

    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    use 's1n7ax/nvim-terminal'

    use 'nvim-tree/nvim-web-devicons'

    use {
        'samjwill/nvim-unception',
    }

    use {
        'norcalli/nvim-colorizer.lua'
    }

    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = ' Apps',
                            group = 'DiagnosticHint',
                            action = 'Telescope app',
                            key = 'a',
                        },
                        {
                            desc = ' dotfiles',
                            group = 'Number',
                            action = 'Telescope dotfiles',
                            key = 'd',
                        },
                    },
                },
            }
        end,
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    use {
        'ahmedkhalf/project.nvim',
    }

    use {
        'kkoomen/vim-doge',
        run = '<cmd>call doge#install()<cr>'
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use({
        'L3MON4D3/LuaSnip',
        -- follow latest release.
        tag = 'v<CurrentMajor>.*',
        -- install jsregexp (optional!:).
        run = 'make install_jsregexp'
    })

    use {
        'hrsh7th/nvim-cmp',
    }

    use { 'hrsh7th/cmp-nvim-lsp' }

    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'mhartington/formatter.nvim'
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0'
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use 'nvim-telescope/telescope-file-browser.nvim'

    use 'sindrets/diffview.nvim'

    use 'EdenEast/nightfox.nvim'

    use {
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        requires = 'nvim-tree/nvim-web-devicons'
    }
end)
