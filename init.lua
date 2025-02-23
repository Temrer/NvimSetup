require("config.lazy")
vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
require("config.options")
require("config.keymaps")


vim.o.ttyfast = true
vim.o.lazyredraw = false
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.cmd("redraw!")
    end,
})
