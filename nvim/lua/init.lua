require("treesitter.treesitter")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local telescope_builtin = require('telescope.builtin')

local on_attach = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, {buffer=0})
        vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {buffer=0})
        vim.keymap.set("n", "gi", telescope_builtin.lsp_type_definitions, {buffer=0})
        vim.keymap.set("n", "gy", telescope_builtin.lsp_implementations, {buffer=0})

        vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<Leader>dl", telescope_builtin.diagnostics, {buffer=0})
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
-- eslint
require('lspconfig')['eslint'].setup{
    capabilities = capabilities,
    on_attach = on_attach
}

-- lspconfig
require('lspconfig')['jsonls'].setup {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

-- lua
require('lspconfig')["sumneko_lua"].setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- lsp lsp_signature
require("lsp_signature").setup{}

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
      ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
              cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
          else
              fallback()
          end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
             fallback()
          end
      end, { 'i', 's' }),
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
