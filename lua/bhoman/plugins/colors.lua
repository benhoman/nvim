return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{
		"rose-pine/neovim",
		enabled = false,
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})

			vim.cmd("colorscheme rose-pine")
		end,
	},
}
