local opts = {
    ensure_installed = {
        "efm",
        "lua_ls"
    },
    automatic_installation = true
}

return {
    "williamboman/mason-lspconfig.nvim",
    opts = opts,
    event = "BufReadPre",
    dpendencies = "williamboman/mason.nvim"
}
