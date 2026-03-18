vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
    view = {
        adaptive_size = true,
    },
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        local function edit_or_open()
            local node = api.tree.get_node_under_cursor()
            if node.nodes ~= nil then
                api.node.open.edit()
            else
                api.node.open.edit()
                api.tree.close()
            end
        end

        local function vsplit_preview()
            local node = api.tree.get_node_under_cursor()
            if node == nil then return end
            if node.nodes ~= nil then
                api.node.open.edit()
            else
                api.node.open.vertical()
            end
            api.tree.focus()
        end

        local function tree_actions_menu(node)
            local tree_actions = {
                { name = "Create node",       handler = api.fs.create },
                { name = "Remove node",       handler = api.fs.remove },
                { name = "Trash node",        handler = api.fs.trash },
                { name = "Rename node",       handler = api.fs.rename },
                { name = "Fully rename node", handler = api.fs.rename_sub },
                { name = "Copy",              handler = api.fs.copy.node },
            }

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

            require("telescope.pickers").new({ prompt_title = "Tree menu" }, {
                finder = finder,
                sorter = sorter,
                attach_mappings = function(prompt_buffer_number)
                    local actions = require("telescope.actions")
                    actions.select_default:replace(function()
                        local state = require("telescope.actions.state")
                        local selection = state.get_selected_entry()
                        actions.close(prompt_buffer_number)
                        selection.value.handler(node)
                    end)
                    actions.add_selection:replace(function() end)
                    actions.remove_selection:replace(function() end)
                    actions.toggle_selection:replace(function() end)
                    actions.select_all:replace(function() end)
                    actions.drop_all:replace(function() end)
                    actions.toggle_all:replace(function() end)
                    return true
                end,
            }):find()
        end

        vim.keymap.set("n", "<Enter>",    edit_or_open,                opts("Edit Or Open"))
        vim.keymap.set("n", "I",          vsplit_preview,              opts("Vsplit Preview"))
        vim.keymap.set("n", "h",          api.tree.close,              opts("Close"))
        vim.keymap.set("n", "H",          api.tree.collapse_all,       opts("Collapse All"))
        vim.keymap.set("n", "<C-Space>",  tree_actions_menu,           opts("Open custom menu"))
    end,
})

local function open_nvim_tree(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then return end
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open({ focus = false })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
