-- lsp lsp_signature
require("lsp_signature").setup{}
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.diagnostic.config({
    float = { max_width = 120 },
    virtual_text = {
        spacing = 20,
        prefix = '▎'
    }
})

local on_attach = function(_, bufnr)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=bufnr})
    vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, {buffer=bufnr})
    vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, {buffer=bufnr})
    vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, {buffer=bufnr})
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, {buffer=bufnr})
    vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, {buffer=bufnr})
end

vim.lsp.config('gopls', { capabilities = capabilities, on_attach = on_attach })

vim.lsp.config('ts_ls', { capabilities = capabilities, on_attach = on_attach })

vim.lsp.config('sourcekit', { capabilities = capabilities, on_attach = on_attach })

vim.lsp.config('marksman', { capabilities = capabilities, on_attach = on_attach })

vim.lsp.config('eslint', {
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})

vim.lsp.config('jsonls', {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
})

-- ruby: MAKE SURE TO SET CONFIG FILE (.solargraph.yml)
vim.lsp.config('solargraph', {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { 'solargraph', 'stdio' },
    settings = { solargraph = { diagnostics = true } },
    init_options = { formatting = true },
    filetypes = { 'ruby' },
    root_dir = function(fname)
        return vim.fs.root(fname, { 'Gemfile', '.git' })
    end,
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
            completion = { callSnippet = 'Replace' },
        },
    },
})

vim.lsp.config('yamlls', {})

vim.lsp.enable({
    'gopls', 'ts_ls', 'sourcekit', 'marksman',
    'eslint', 'jsonls', 'rust_analyzer', 'solargraph',
    'lua_ls', 'yamlls',
})

-- lualine status bar
require("lualine").setup {
    options = { theme = "gruvbox" }
}

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
