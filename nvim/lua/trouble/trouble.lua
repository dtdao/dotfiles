-- Lua
-- vim.api.nvim_set_keymap('n', '<Leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', {})
vim.keymap.set("n", "<leader>xx", '<cmd>Trouble diagnostics toggle<cr>') 
-- vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
-- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", '<cmd>Trouble qflist toggle<cr>')
-- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "<leader>cl", '<cmd>Trouble lsp toggle focus=false wind.position=right<cr>')

require("trouble").setup {}
