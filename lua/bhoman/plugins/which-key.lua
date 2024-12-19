return { -- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		enabled = true,
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup()

			-- document existing key chains
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>h", group = "Git [H]unk" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>w", group = "[W]orkspace" },
			})
		end,
	},
}
