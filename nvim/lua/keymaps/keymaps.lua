local nvmimTreeApi= require("nvim-tree.api")

-- vim-fugitive
vim.keymap.set("n" , "<Leader>gb",  '<CMD>Git blame<CR>', {})

local toggleAndFind = function()
    return nvmimTreeApi.tree.toggle({find_file = true, focus = true})
end

vim.keymap.set("n" , "<Leader>n",  nvmimTreeApi.tree.open, {})
vim.keymap.set("n" , "<C-n>",  nvmimTreeApi.tree.toggle, {})
vim.keymap.set("n" , "<C-f>", toggleAndFind, {})


--  Window navigation
vim.keymap.set("n" , "<C-J>", "<C-W><C-J>", {})
vim.keymap.set("n" , "<C-K>", "<C-W><C-K>", {})
vim.keymap.set("n" , "<C-L>", "<C-W><C-L>", {})
vim.keymap.set("n" , "<C-H>", "<C-W><C-H>", {})


vim.keymap.set("n" , "<Leader>+", "<CMD>vertical resize +5", {})
vim.keymap.set("n" , "<Leader>-", "<CMD>vertical resize -5", {})


