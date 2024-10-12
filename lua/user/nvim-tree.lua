-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
-- vim.opt.termguicolors = true

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, tree_api = pcall(require, "nvim-tree.api")
if not config_status_ok then
	return
end

local function edit_or_open()
	local node = tree_api.tree.get_node_under_cursor()

	if node.nodes ~= nil then
		-- expand or collapse folder
		tree_api.node.open.edit()
	else
		-- open file
		tree_api.node.open.edit()
		-- Close the tree if file was opened
		tree_api.tree.close()
	end
end

-- open as vsplit on current node
local function vsplit_preview()
	local node = tree_api.tree.get_node_under_cursor()

	if node.nodes ~= nil then
		-- expand or collapse folder
		tree_api.node.open.edit()
	else
		-- open file as vsplit
		tree_api.node.open.vertical()
	end

	-- Finally refocus on tree if it was lost
	tree_api.tree.focus()
end

local function my_on_attach(bufnr)
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	tree_api.config.mappings.default_on_attach(bufnr)

	-- on_attach
	vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
	vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
	vim.keymap.set("n", "h", tree_api.tree.close, opts("Close"))
	vim.keymap.set("n", "H", tree_api.tree.collapse_all, opts("Collapse All"))
end

nvim_tree.setup({
	on_attach = my_on_attach,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		root_folder_modifier = ":t",
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		-- width = 30,
		adaptive_size = true,
		side = "left",
		-- mappings = {
		--   list = {
		--     { key = { "l", "<CR>", "o" }, edit_or_open, opts("Edit or Open") },
		--     { key = "h", tree_api.tree.close, opts("Close") },
		--     { key = "v", vsplit_preview(), opts("Vsplit Preview") },
		--   },
		-- },
	},
})
