local config = function ()
    require("util.debuggers.c-cpp-rust")
    require("util.Keybindings").DAP()
end




return {
	"mfussenegger/nvim-dap",
    config = config,
}
