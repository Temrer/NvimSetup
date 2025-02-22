local keymaps = require("util.Keybindings").telescope

local config = function()
local telescope = require('telescope')
    telescope.setup({
        defaults = {
            mappings = {
                i = keymaps.mappings
            },
        },
        pickers = {
            find_files = {
                theme = "dropdown",
                previewer = false,
                hidden = true,
            },
            live_grep = {
                theme = "dropdown",
                previewer = false,
            },
            find_buffers = {
                theme = "dropdown",
                previewer = false,
            },
        },
    })
end


return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    lazy = false,
    dependencies = {'nvim-lua/plenary.nvim'},
    config = config,
    keys = keymaps.keys
}
