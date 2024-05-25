return {
	"f-person/git-blame.nvim",
	config = function()
		vim.keymap.set("n", "<leader>tb", ":GitBlameToggle<cr>")
	end,
}
