return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	-- Uncomment following to auto auth
	-- build = ":Copilot auth",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}
