
-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

-- Neovim Tag find in new tab
map("n", "<silent><Leader><C-]>", "<C-w><C-]><C-w>T")

-- Fast close
map("n", "<a-x>", "<cmd>bd<cr>")

-- Fast escape
map("i", "<a-s>", "<cmd>wa<cr><esc>")

-- Disable search
map("n", ",<space>", "<cmd>nohlsearch<cr>")

-- Copy/Paste (xclip needed)
map("i", "<a-v>", "<c-r>+")
map("c", "<a-v>", "<c-r>+")

map("n", "<a-c>", "\"+y")
map("n", "<a-v>", "\"+p")

-- Telescope
map("n", ",ff", "<cmd>Telescope find_files<cr>")
map("n", ",fg", "<cmd>Telescope live_grep<cr>")

map("n", ",er", "<cmd>Telescope file_browser<cr>")
map("n", ",ee", "<cmd>Telescope file_browser path=%:p:h<cr>")

-- Diff

map("n", ",df", "<cmd>DiffviewFileHistory %<cr>")
map("n", ",db", "<cmd>DiffviewFileHistory<cr>")

-- Neovide change scale factor

vim.keymap.set("n", "<C-->", function() 
    change_scale_factor(1/1.25)
end)
vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
end)
