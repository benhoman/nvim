return {
	-- {
	-- 	"nvim-neotest/neotest",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"antoinemadec/FixCursorHold.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-neotest/neotest-python",
	-- 	},
	-- 	config = function()
	-- 		require("neotest").setup({
	-- 			adapters = {
	-- 				require("neotest-python")({
	-- 					runner = "ca test",
	-- 				}),
	-- 			},
	-- 		})
	-- 	end,
	-- 	keys = {
	-- 		{
	-- 			"<leader>tn",
	-- 			function()
	-- 				require("neotest").run.run()
	-- 			end,
	-- 			desc = "Test nearest",
	-- 		},
	-- 		{
	-- 			"<leader>tf",
	-- 			function()
	-- 				require("neotest").run.run(vim.fn.expand("%"))
	-- 			end,
	-- 			desc = "Test file",
	-- 		},
	-- 	},
	-- },
}
