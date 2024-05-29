local jestConfigFile = function(file)
  if string.find(file, "/packages/") then
    return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
  end

  return vim.fn.getcwd() .. "/jest.config.ts"
end

local cwd = function(file)
      if string.find(file, "/packages/") then
    return string.match(file, "(.-/[^/]+/)src")
  end
  return vim.fn.getcwd()
end


require('neotest').setup{
    discovery = {
      enabled = false
    },
    adapters = {
        require('neotest-jest'){
          jest_test_discovery = false,
          jestConfigFile = jestConfigFile,
          cwd = cwd
        },
        require("neotest-rspec")
    }
}

local t = require('neotest')

vim.api.nvim_set_keymap('n', '<Leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', {})
