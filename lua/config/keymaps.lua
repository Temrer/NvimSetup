local kmap = vim.keymap
local opts = { noremap = true, silent = true } -- Directory navigation
kmap.set("n", "<leader>m", ":NvimTreeFocus<CR>", opts)
kmap.set("n", "<leader>f", ":NvimTreeToggle<CR>", opts)

-- Pane Navigation
kmap.set("n", "<C-h>", "<C-w>h", opts)
kmap.set("n", "<C-j>", "<C-w>j", opts)
kmap.set("n", "<C-k>", "<C-w>k", opts)
kmap.set("n", "<C-l>", "<C-w>l", opts)

kmap.set("t", "<C-h>", "[[<Cmd>wincmd h<CR>]]", opts)
kmap.set("t", "<C-j>", "[[<Cmd>wincmd j<CR>]]", opts)
kmap.set("t", "<C-k>", "[[<Cmd>wincmd k<CR>]]", opts)
kmap.set("t", "<C-l>", "[[<Cmd>wincmd l<CR>]]", opts)

kmap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
kmap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
kmap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
kmap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)


-- Window SPlit

kmap.set("n", "<leader>sv", ":vsplit<CR>", opts)
kmap.set("n", "<leader>sh", ":split<CR>", opts)
kmap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts)
vim.keymap.set("n", "lhl", function() -- open window in rightmost cell
	local api = require("nvim-tree.api")

	-- Get the node under the cursor in NvimTree
	local node = api.tree.get_node_under_cursor()
	if not node or node.type ~= "file" then
		print("No file selected!")
		return
	end

	-- Move to the rightmost split
	vim.cmd("wincmd b")

	-- Count the number of windows
	local win_count = #vim.api.nvim_list_wins()

	-- If fewer than 3 windows, create a vertical split
	if win_count < 3 then
		vim.cmd("vsplit") -- Create new vertical split
		vim.cmd("wincmd b")
	end

	-- Open the file in the rightmost split
	vim.cmd("edit " .. node.absolute_path)
end, { noremap = true, silent = true })

vim.keymap.set("n", "lhh", function() -- open window in leftmost cell
	local api = require("nvim-tree.api")

	-- Get the node under the cursor in NvimTree
	local node = api.tree.get_node_under_cursor()
	if not node or node.type ~= "file" then
		print("No file selected!")
		return
	end
	vim.cmd("NvimTreeToggle")

	-- Move to the leftmost split
	vim.cmd("wincmd w")

	-- Count the number of windows
	local win_count = #vim.api.nvim_list_wins()

	-- If fewer than 3 windows, create a vertical split
	if win_count < 3 then
		vim.cmd("vsplit") -- Create new vertical split
		vim.cmd("wincmd w")
	end

	-- Open the file in the rightmost split
	vim.cmd("edit " .. node.absolute_path)
	vim.cmd("NvimTreeToggle")
	vim.cmd("wincmd l")
end, { noremap = true, silent = true })

-- Run Manim
vim.keymap.set("n", "<leader>rr", function()
	f = vim.fn.expand("%") -- store current file
	vim.cmd("wincmd h") -- Move to left split (assuming terminal is there)
	vim.cmd("terminal manim " .. f .. " -p") -- Run manim with the current file
	vim.cmd("startinsert") -- Enter terminal mode
	vim.defer_fn(function()
		vim.cmd("wincmd l") -- Move back to the file after a short delay
	end, 500) -- Adjust delay if needed (in milliseconds)
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>rs", function() -- Save manim output
	local file = vim.fn.expand("%")
	local name = vim.fn.input("Output filename: ")

	if name == "" then
		return
	end -- Exit if no name is given

	vim.cmd("wincmd h")
	vim.cmd("terminal manim " .. file .. " -p -o " .. name)
	vim.cmd("startinsert")

	vim.defer_fn(function()
		vim.cmd("wincmd l")
	end, 500)
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>rv", function() -- Review last render
	vim.cmd("wincmd h")
	vim.cmd(
		'call jobstart(["mpv", "--geometry=50%:50%", "/tem/projects/BlenderPluginVIdeo/Source/MathSection/media/videos/Vectors/1080p60/DimensionalGraphScene.mp4"], {"detach": v:true})'
    )
	vim.cmd("startinsert")

	vim.defer_fn(function()
		vim.cmd("wincmd l")
	end, 500)
end, { noremap = true, silent = true })

-- Comments

vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap(
	"i",
	"<C-_>",
	"<Esc>:lua require('Comment.api').toggle.linewise.current()<CR>i",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })
