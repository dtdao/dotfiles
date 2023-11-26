vim.g.loaded_ts_context_commentstring = true
require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
    -- context_commentstring = { enable = true}
}
require("ts_context_commentstring").setup{}
