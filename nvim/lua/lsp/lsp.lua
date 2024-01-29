-- lsp lsp_signature
require("lsp_signature").setup{}
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.diagnostic.config({
    float = {
        max_width = 120
    },
    virtual_text = {
        spacing = 20,
        prefix = '▎'  -- '●' -- Could be '■', '▎', 'x'
    }
})
local on_attach = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, {buffer=0})
        vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, {buffer=0})
        vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, {buffer=0})
end
-- Native LSP
-- golang
require('lspconfig')['gopls'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
-- TSconfig
require('lspconfig')['tsserver'].setup{
    capabilities = capabilities,
    on_attach = on_attach
}

-- markdown
require'lspconfig'.marksman.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

-- eslint
require('lspconfig')['eslint'].setup{
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })  
    end
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

-- rust 
require('lspconfig')["rust_analyzer"].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        "rustup", "run", "stable", "rust-analyzer",
    }
}

-- lualine status bar
require("lualine").setup {
    options = {
        theme = "everforest"
    }
}

-- lua language server
require('lspconfig')["lua_ls"].setup {
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

require("lspconfig")["yamlls"].setup{}

vim.opt.completeopt={"menu", "menuone", "noselect"}
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  local luasnip = require("luasnip")

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
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
