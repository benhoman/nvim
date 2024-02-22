return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local tc = require("todo-comments")

		vim.keymap.set("n", "]t", function()
			tc.jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			tc.jump_prev()
		end, { desc = "Previous todo comment" })

		-- You can also specify a list of valid jump keywords

		vim.keymap.set("n", "]t", function()
			tc.jump_next({ keywords = { "ERROR", "WARNING" } })
		end, { desc = "Next error/warning todo comment" })
	end,
}
