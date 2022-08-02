require("treesitter.treesitter")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local telescope_builtin = require('telescope.builtin')

local on_attach = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
        vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {buffer=0})
        vim.keymap.set("n", "gi", vim.lsp.buf.type_definition, {buffer=0})
        vim.keymap.set("n", "gy", vim.lsp.buf.implementation, {buffer=0})

        vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<Leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
        vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, {buffer=0})

        vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, {buffer=0})
end

-- Native LSP
-- golang
require('lspconfig')['gopls'].setup{
    capabilities = capabilities,
    on_attach = on_attach 
}
-- TSconfig
require('lspconfig')['tsserver'].setup{
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['eslint'].setup{
    capabilities = capabilities,
    on_attach = on_attach
}
vim.opt.completeopt={"menu", "menuone", "noselect"}
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
     end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- for luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })
