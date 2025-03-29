return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
	config = function()
		local tc = require("todo-comments")
		tc.setup()

		vim.keymap.set("n", "]t", function()
			tc.jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			tc.jump_prev()
		end, { desc = "Previous todo comment" })
	end,
  keys = {
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
  },
}
