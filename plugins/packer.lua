return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    use 'goolord/alpha-nvim'
    use 's1n7ax/nvim-terminal'

    use 'nvim-tree/nvim-web-devicons'

    use {
        'junegunn/fzf',
        run = "<cmd>call fzf#install()<cr>"
    }

    use {
        'kkoomen/vim-doge',
        run = "<cmd>call doge#install()<cr>"
    }

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    use {
        "L3MON4D3/LuaSnip",
        run = "make install_jsregexp"
    }

    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require 'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require 'luasnip'.lsp_expand(args.body)
                    end
                },

                sources = {
                    { name = 'luasnip' },
                    { name = 'nvim_cmp' },
                },
            }
        end
    }

    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'saadparwaiz1/cmp_luasnip' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
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
end)
