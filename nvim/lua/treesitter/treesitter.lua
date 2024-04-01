require('treesitter-context').setup{
    enable = true
}
vim.g.loaded_ts_context_commentstring = true

require'nvim-treesitter.configs'.setup {
    sync_install = true,
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "javascript", "go" },
    highlight = { enable = true },
    auto_install = true,
    incremental_selection = { enable = true },
    textobjects = { enable = true },
    context_commentstring = { enable = true}
}

require("ts_context_commentstring").setup{}

