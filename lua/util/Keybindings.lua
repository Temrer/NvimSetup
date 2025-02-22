local keymap = vim.keymap

local lsp_saga_keybinds = {
	-- keybinds for navigation in lspsaga window
	move_in_saga = { prev = "<C-k>", next = "<C-j>" },
	-- use enter to open file with finder
	finder_action_keys = {
		open = "<CR>",
	},
	-- use enter to open file with definition preview
	definition_action_keys = {
		edit = "<CR>",
	},
}

local autocomplete = function(cmp)
	-- keybindings for nvim-cmp
	return {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}
end

local telescope = {
	mappings = {
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
	},
	keys = {
		keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>"),
		keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>"),
		keymap.set("n", "<leader>ff", ":Telescope find_files<CR>"),
		keymap.set("n", "<leader>fa", ":Telescope <CR>"),
		keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>"),
		keymap.set("n", "<leader>fb", ":Telescope buffers<CR>"),
	},
}

local lspconfig = function(client, buffer)
	local opts = { noremap = true, silent = true, buffer = buffer }

	-- set keybinds
	vim.keymap.set("n", "gf", "<cmd>Lspsaga lasp_finder<CR>", opts)
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration<CR>", opts)
	vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev <CR>", opts)
	vim.keymap.set("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_next <CR>", opts)
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	vim.keymap.set("n", "<leader>lo", "<cmd>LSoutlineToggle<CR>", opts)
end

local module = {
	["lsp_saga_keybinds"] = lsp_saga_keybinds,
	["autocomplete"] = autocomplete,
	["telescope"] = telescope,
    ["lspconfig"] = lspconfig
}
return module
