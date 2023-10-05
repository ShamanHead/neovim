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
map("n", ",fl", "<cmd>Telescope live_grep_args<cr>")

map("n", ",er", "<cmd>Telescope file_browser<cr>")
map("n", ",ee", "<cmd>Telescope file_browser path=%:p:h<cr>")

map("n", ",rt", "<cmd>Telescope projects<cr>");
map("n", ",tt", "<cmd>Telescope buffers<cr>");

-- Git 

map("n", ",df", "<cmd>DiffviewFileHistory %<cr>")
map("n", ",db", "<cmd>DiffviewFileHistory<cr>")
map("n", ",dc", "<cmd>DiffviewClose<cr>")
map("n", ",gs", "<cmd>Gitsigns toggle_current_line_blame<cr>")

-- LSP

map("n", ",gd", "<cmd><buffer> gd tab LspDefinition<cr>")

-- Buffer

map("n", "gn", "<cmd>bn<cr>")
map("n", "gp", "<cmd>bp<cr>")
map("n", "gw", "<cmd>Bclose<cr>")

-- cd to new directory

map("n", ",cd", "<cmd>cd %:p:h<cr>")

-- Tabnew on current file directory / loaded directory

map("n", ",ww", "<cmd>tabnew | e %:p:h<cr>")
map("n", ",we", "<cmd>tabnew | e .<cr>")

-- Open new tab with console

map("n", ",wt", "<cmd>tabnew | te<cr>")

-- Floated Windows (lazygit, bpytop)

map("n", "flg", "<cmd>FloatermNew --height=37 --width=120 lazygit -p " .. vim.fn.getcwd() .. "<cr>")
map("n", "fbp", "<cmd>FloatermNew --height=37 --width=120 bpytop<cr>")

-- DAP

map("n", ",so", "<cmd>lua require('dapui').open()<cr>")
map("n", ",sx", "<cmd>lua require('dapui').close()<cr>")

map("n", ",sd", "<cmd>DapToggleBreakpoint<cr>")
map("n", ",sc", "<cmd>DapContinue<cr>")

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Neovide change scale factor

vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
end)
vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
end)
