local config = function()
    local lspconfig = require("lspconfig")
    
    local signs = {
        Error = "",
        Warn = "",
        Hint = "ﱛ",
        Info = ""
    }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
    end
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    
    -- keybinds
    local on_attch = require("util.Keybindings").lspconfig

        


    -- lua
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attch,
        settings = { --custom settings for lua
            Lua  = {
                -- make the language recognize "vim" global
                diagnostics = {
                    globals = {"vim"}
                },
                workspace = {
                    -- make language server aware of runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true
                    }
                },
                format = {enable = true}
            }
        }
    })
    
    -- python
    lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attch,
        settings = {
            pyright = {
                disableOrganizedImports = false,
                analysis = {
                    useLibraryCodeForTypes = true,
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    autoImportCompletions = true
                }
            }
        }

    })


    local luacheck = require("efmls-configs.linters.luacheck")
    local stylua  = require("efmls-configs.formatters.stylua")
    local flake8 = require("efmls-configs.linters.flake8")
    local black  = require("efmls-configs.formatters.black")

    -- configure efm server
    lspconfig.efm.setup({
        filetypes = {"lua", "python"},
        init_options = {
        documentFormatting = true,
            documentRangeFormatting = true,
            hover = true,
            documentSumbol = true,
            codeAction = true,
            completion = true,
        },
        settings = {
            languages = {
                lua = {luacheck, stylua},
                python = {flake8, black}
            }
        },
    }) 

    -- Format on save 
    local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup",{})
    vim.api.nvim_create_autocmd("BufWritePost", {
        group  = lsp_fmt_group,
        callback = function()
            local efm = vim.lsp.get_active_clients({name = "efm"})
            if vim.tbl_isempty(efm) then return end
            vim.lsp.buf.format({name = "efm"})
        end
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
        "hrsh7th/cmp-nvim-lsp"
    }
}
