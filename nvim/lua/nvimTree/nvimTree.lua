local nvmimTreeApi= require("nvim-tree.api")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- nvim tree custom stuff
local tree_actions = {
	{
		name = "Create node",
		handler = require("nvim-tree.api").fs.create,
	},
	{
		name = "Remove node",
		handler = require("nvim-tree.api").fs.remove,
	},
	{
		name = "Trash node",
		handler = require("nvim-tree.api").fs.trash,
	},
	{
		name = "Rename node",
		handler = require("nvim-tree.api").fs.rename,
	},
	{
		name = "Fully rename node",
		handler = require("nvim-tree.api").fs.rename_sub,
	},
	{
		name = "Copy",
		handler = require("nvim-tree.api").fs.copy.node,
	},
}
local function tree_actions_menu(node)
	local entry_maker = function(menu_item)
		return {
			value = menu_item,
			ordinal = menu_item.name,
			display = menu_item.name,
		}
	end

	local finder = require("telescope.finders").new_table({
		results = tree_actions,
		entry_maker = entry_maker,
	})

	local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()

	local default_options = {
		finder = finder,
		sorter = sorter,
		attach_mappings = function(prompt_buffer_number)
			local actions = require("telescope.actions")

			-- On item select
			actions.select_default:replace(function()
				local state = require("telescope.actions.state")
				local selection = state.get_selected_entry()
				-- Closing the picker
				actions.close(prompt_buffer_number)
				-- Executing the callback
				selection.value.handler(node)
			end)

			-- The following actions are disabled in this example
			-- You may want to map them too depending on your needs though
			actions.add_selection:replace(function() end)
			actions.remove_selection:replace(function() end)
			actions.toggle_selection:replace(function() end)
			actions.select_all:replace(function() end)
			actions.drop_all:replace(function() end)
			actions.toggle_all:replace(function() end)

			return true
		end,
	}

	-- Opening the menu
	require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
end

local function edit_or_open()
  local node = nvmimTreeApi.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    nvmimTreeApi.node.open.edit()
  else
    -- open file
    nvmimTreeApi.node.open.edit()
    -- Close the tree if file was opened
    nvmimTreeApi.tree.close()
  end
end

-- open as vsplit on current node
local function vsplit_preview()
  local node = nvmimTreeApi.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    nvmimTreeApi.node.open.edit()
  else
    -- open file as vsplit
    nvmimTreeApi.node.open.vertical()
  end

  -- Finally refocus on tree if it was lost
  nvmimTreeApi.tree.focus()
end
-- nvim-tree custom stuff end
local on_attach = function(bufnr)
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        vim.keymap.set("n", "<Enter>", edit_or_open,          opts("Edit Or Open"))
        vim.keymap.set("n", "I", vsplit_preview,        opts("Vsplit Preview"))
        vim.keymap.set("n", "h", nvmimTreeApi.tree.close,        opts("Close"))
        vim.keymap.set("n", "H", nvmimTreeApi.tree.collapse_all, opts("Collapse All"))
        vim.keymap.set("n", "<C-Space>", tree_actions_menu, opts("Open custom menu"))
    end

local function open_nvim_tree(data)
      -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open({focus = false})
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
    group_empty = true,
  },
  filters = {
      dotfiles = false,
  },
  git = {
      ignore = false,
  },
  on_attach = on_attach,
  view = {
      adaptive_size = true,
    }
})
