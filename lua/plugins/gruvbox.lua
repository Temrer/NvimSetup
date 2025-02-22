return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true, -- Enable colors for the terminal
      contrast = "hard", -- Can be "hard", "medium", or "soft"
      overrides = {}, -- Custom highlights (optional)
    })
    vim.cmd("colorscheme gruvbox") -- Apply the colorscheme
  end
}
