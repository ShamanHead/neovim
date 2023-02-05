-- If neovide, then change some settings
if vim.g.neovide then
    vim.opt.guifont = { "Fira Code Nerd", "h12" }
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_scale_factor = 0.65
    vim.g.neovide_cursor_animation_length = 0.15
    vim.g.neovide_cursor_trail_size = 0.05
end

vim.cmd("set encoding=utf-8")
vim.cmd("set number")
vim.cmd("set noswapfile")
vim.cmd("set scrolloff=7")

vim.cmd("set autoindent")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set autoindent")
vim.cmd("set fileformat=unix")

vim.cmd("set clipboard+=unnamedplus")

vim.cmd("colorscheme duskfox")

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
