local config = function()
	local lspconfig = require("lspconfig")

	local signs = {
		Error = "",
		Warn = "",
		Hint = "ﱛ",
		Info = "",
	}
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- keybinds
	local on_attach = require("util.Keybindings").lspconfig

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
				format = { enable = true },
			},
		},
	})

	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizedImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- C Cpp
	lspconfig.clangd.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = function()
			local filetype = vim.bo.filetype
			if filetype == "cpp" then
				return { "clangd", "--background-index", "--clang-tidy", "--log=verbose", "--std=c++17" }
			elseif filetype == "c" then
				return { "clangd", "--background-index", "--clang-tidy", "--log=verbose", "--std=c11" }
			else
				return { "clangd", "--background-index", "--clang-tidy", "--log=verbose" }
			end
		end,
	})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local cpplint = require("efmls-configs.linters.cpplint")
	local clang_format = {
		formatCommand = "clang-format -style=Google",
		formatStdin = true,
	}

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = { "lua", "python", "c", "cpp" },
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, black },
				c = { cpplint, clang_format },
				cpp = { cpplint, clang_format },
			},
		},
	})

	-- Format on save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })
			if vim.tbl_isempty(efm) then
				return
			end
			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",

	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
}
