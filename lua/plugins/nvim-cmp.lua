local setup = function(cmp)
	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert(require("util.Keybindings").autocomplete(cmp)),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		}),
		-- configure lspkind for vs-like icons
		formatting = {
			format = require("lspkind").cmp_format({
				maxwidth = 50,
				ellipsis_char = "...",
			}),
		},
	})
end

return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip/loaders/from_vscode").lazy_load()

		vim.opt.completeopt = "menu,menuone,noselect"

		setup(cmp)
	end,
	dependencies = {
		"onsails/lspkind.nvim",
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- Bridge cmp with LuaSnip
		"hrsh7th/cmp-nvim-lsp", -- MISSING LSP SOURCE!
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
}
