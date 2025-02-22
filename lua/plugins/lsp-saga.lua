return {
    "glepnir/lspsaga.nvim",
    lazy = false,
    config = function()
        require("lspsaga").setup(require("util/Keybindings").lsp_saga_keybinds)
    end
}
