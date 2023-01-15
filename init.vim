set mouse=a " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7

set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix

set clipboard+=unnamedplus

if(exists("g:neovide"))
    set guifont=Fira\ Code\ Nerd\ Font:h12
    " let g:neovide_transparency = 0.85
    let g:neovide_refresh_rate_idle = 5 
    let g:neovide_cursor_animation_length=0.15
    let g:neovide_cursor_trail_size = 0.05
else
    au ColorScheme * hi Normal ctermbg=none guibg=none
    au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red
endif

filetype indent on      " load filetype-specific indent files

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3

" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview
inoremap qwr <esc>

let g:python3_host_prog = '/usr/bin/python3.9'

call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
" Plug 'mattn/emmet-vim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'sindrets/diffview.nvim'
Plug 'captbaritone/better-indent-support-for-php-with-html'

Plug 'maxmellon/vim-jsx-pretty'

" color schemas
Plug 'EdenEast/nightfox.nvim'
Plug 'yunlingz/equinusocio-material.vim'
Plug 'marko-cerovac/material.nvim'

call plug#end()

if (has('termguicolors'))
  set termguicolors
endif

let g:neovide_scale_factor=0.65

function! ChangeScaleFactor(delta)
    let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
endfunction

nnoremap <expr><C-=> ChangeScaleFactor(1.25)
nnoremap <expr><C--> ChangeScaleFactor(1/1.25)

function! OpenExplorer(what)
    execute "Vexplore " a:what
    vertical resize 30;
endfunction

nmap <a-c> "+y
vmap <a-c> "+y
nmap <a-v> "+p
inoremap <a-v> <c-r>+
cnoremap <a-v> <c-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <a-v>

nnoremap ,<space> :nohlsearch<CR>

nnoremap <A-t> :call OpenExplorer('%:h')<cr>
nnoremap <A-f> :call OpenExplorer('.')<cr>

nnoremap <A-c> :q<cr>

nnoremap ,ff <cmd>Telescope find_files<cr>
nnoremap ,fg <cmd>Telescope live_grep<cr>

nnoremap ,df <cmd>DiffviewFileHistory %<cr>
nnoremap ,db <cmd>DiffviewFileHistory<cr>

nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

nnoremap <A-s> <cmd>wa<cr><ESC>

lua << EOF

require('telescope').load_extension('fzf');

vim.g.material_style = "Palenight"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.lsp.set_log_level("debug")

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
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
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF

lua << EOF

require("mason").setup()
require("mason-lspconfig").setup()

local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
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
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
    html = {
    options = {
-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
    },
    },
    }
})
 nvim_lsp.intelephense.setup({
     settings = {
         intelephense = {
             stubs = {
                 "bcmath",
                 "bz2",
                 "Core",
                 "curl",
                 "date",
                 "dom",
                 "fileinfo",
                 "filter",
                 "gd",
                 "gettext",
                 "hash",
                 "iconv",
                 "imap",
                 "intl",
                 "json",
                 "libxml",
                 "mbstring",
                 "mcrypt",
                 "mysql",
                 "mysqli",
                 "password",
                 "pcntl",
                 "pcre",
                 "PDO",
                 "pdo_mysql",
                 "Phar",
                 "readline",
                 "regex",
                 "session",
                 "SimpleXML",
                 "sockets",
                 "sodium",
                 "standard",
                 "superglobals",
                 "tokenizer",
                 "xml",
                 "xdebug",
                 "xmlreader",
                 "xmlwriter",
                 "yaml",
                 "zip",
                 "zlib",
                 "wordpress-stubs",
                 "woocommerce-stubs",
                 "acf-pro-stubs",
                 "wordpress-globals",
                 "wp-cli-stubs",
                 "genesis-stubs",
                 "polylang-stubs"
             },
             -- environment = {
             --   includePaths = {'/home/mte90/.composer/vendor/php-stubs/', '/home/mte90/.composer/vendor/wpsyntex/'}
             -- },
             files = {
                 maxSize = 5000000;
             };
         };
     },
     capabilities = capabilities,
     on_attach = on_attach
     });
nvim_lsp.cssls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
nvim_lsp.html.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
nvim_lsp.tsserver.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
nvim_lsp.tailwindcss.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
nvim_lsp.csharp_ls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
};
nvim_lsp.sumneko_lua.setup{
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
            globals = {'vim'},
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


EOF

" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)

nnoremap <silent> <Leader>bd :Bclose<CR>

map gn :bn<cr>
map gp :bp<cr>
map gw :Bclose<cr>

set colorcolumn=79

colorscheme duskfox 
