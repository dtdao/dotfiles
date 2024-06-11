local telescope_builtin = require('telescope.builtin')
-- local actions = require('telescope.actions')
local trouble = require('trouble.sources.telescope')

vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, {})
vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {})
vim.keymap.set("n", "gi", telescope_builtin.lsp_type_definitions, {})
vim.keymap.set("n", "gy", telescope_builtin.lsp_implementations, {})
vim.keymap.set("n", "<Leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<Leader>fg", telescope_builtin.live_grep, {})
vim.keymap.set("n", "<Leader>fb", telescope_builtin.buffers,{})
vim.keymap.set("n", "<Leader>fh",telescope_builtin.help_tags,{})
vim.keymap.set("n", "<Leader>fr", telescope_builtin.resume, {})

vim.keymap.set("i", "<c-t>", trouble.open, {})


require("telescope").setup {
    pickers = {
        find_files= {
            hidden = true,
        },
    }
}

require('telescope').load_extension('fzf')
