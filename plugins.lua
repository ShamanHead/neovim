return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    use 'goolord/alpha-nvim'
    use 's1n7ax/nvim-terminal'

    use 'nvim-tree/nvim-web-devicons'

    use {
        'junegunn/fzf',
        config = function() vim.cmd("fzf#install()") end
    }
    use 'junegunn/fzf.vim'

    use {
        'kkoomen/vim-doge',
        config = function() vim.cmd("doge#install()") end
    }

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    use {
        "L3MON4D3/LuaSnip",
        tag = "v<CurrentMajor>.*",
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
        config = function() io.popen('make') end
    }

    use 'nvim-telescope/telescope-file-browser.nvim'

    use 'sindrets/diffview.nvim'

    use 'EdenEast/nightfox.nvim'
end)
