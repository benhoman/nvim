return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		-- "nvim-telescope/telescope.nvim", -- optional
	},
	config = true,
	keys = {
		-- {
		-- 	"<leader>gs",
		-- 	function()
		-- 		require("neogit").open()
		-- 	end,
		-- 	desc = "Neogit status",
		-- },
		-- {
		-- 	"<leader>gc",
		-- 	"<cmd>Neogit commit<cr>",
		-- 	silent = true,
		-- 	noremap = true,
		-- 	desc = "Neogit commit",
		-- },
		{
			"<leader>gp",
			"<cmd>Neogit pull<cr>",
			silent = true,
			noremap = true,
			desc = "Neogit pull",
		},
		{
			"<leader>gP",
			"<cmd>Neogit push<cr>",
			silent = true,
			noremap = true,
			desc = "Neogit push",
		},
	},
}
