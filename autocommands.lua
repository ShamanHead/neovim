local api = vim.api
--- This function is taken from https://github.com/norcalli/nvim_utils
function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local autocmds = {
    --reload_vimrc = {
    --    -- Reload vim config automatically
    --    {"BufWritePost",[[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]};
    --};
    --packer = {
    --    { "BufWritePost", "plugins.lua", "PackerCompile" };
    --};
    terminal_job = {
        { "TermOpen", "*", [[tnoremap <buffer> <A-Esc> <c-\><c-n>]] };
        { "TermOpen", "*", "startinsert" };
        { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" };
    };
    restore_cursor = {
        { 'BufRead', '*', [[call setpos(".", getpos("'\""))]] };
    };
    --save_shada = {
    --    {"VimLeave", "*", "wshada!"};
    --};
    --resize_windows_proportionally = {
    --    { "VimResized", "*", ":wincmd =" };
    --};
    --toggle_search_highlighting = {
    --    { "InsertEnter", "*", "setlocal nohlsearch" };
    --};
    --lua_highlight = {
    --    { "TextYankPost", "*", [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=400}]] };
    --};
    --ansi_esc_log = {
    --    { "BufEnter", "*.log", ":AnsiEsc" };
    --};
}

nvim_create_augroups(autocmds)
