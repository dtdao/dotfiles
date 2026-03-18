require("treesitter-context").setup({
  enable = true,
})

require("nvim-treesitter").setup({
    sync_install = true,
    ensure_installed = {
     "c",
     "lua",
     "vim",
     "vimdoc",
     "query",
     "typescript",
     "javascript",
     "go",
    },
    highlight = { enable = true },
    auto_install = true,

    incremental_selection = { enable = true },
})

require("ts_context_commentstring").setup({})

