return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = {
			-- { "nvim-tree/nvim-web-devicons" },
			{ "echasnovski/mini.icons" },
			{ "junegunn/fzf", build = "./install --bin" },
		},
		config = function()
			-- calling `setup` is optional for customization
			local fzf_lua = require("fzf-lua")
			local actions = fzf_lua.actions

			fzf_lua.setup({
				winopts = {
					fullscreen = true,
					-- height = 0.9,
					-- width = 0.95,
				},
				fzf_opts = {
					-- ["--layout"] = "default",
				},
				keymap = {
					fzf = {
						-- use cltr-q to select all items and convert to quickfix list
						["ctrl-q"] = "select-all+accept",
					},
				},
				grep = {
					actions = {
						["ctrl-q"] = {
							fn = actions.file_edit_or_qf,
							prefix = "select-all+",
						},
					},
				},
				-- files = {
				-- 	rg_opts = "--color=never --files --hidden --follow --no-ignore -g '!.git'",
				-- },
			})

			fzf_lua.register_ui_select()
		end,
		keys = {
			{ "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
			{ "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
			{
				"<leader>,",
				"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Switch Buffer",
			},
			{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
			-- find
			{ "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "[F]ind [F]iles (cwd)" },
			{ "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "[F]ind [G]it Files (git-files)" },
			{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "[F]ind [R]ecent Files" },
			{ "<leader>ft", "<cmd>FzfLua treesitter<cr>", desc = "[F]ind [T]reesitter" },
			{
				"<leader>fc",
				function()
					require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "[F]ind [C]onfig File",
			},
			-- git
			{ "<leader>gb", "<cmd>FzfLua git_branches<CR>", desc = "[G]it [B]ranches" },
			{ "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "[G]it [C]ommits" },
			{ "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "[G]it [S]tatus" },
			-- search
			{ '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
			{ "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
			{ "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "[S]earch [G]rep (cwd)" },
			{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
			{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
			{ "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
			{ "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
			{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
			{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "[S]earch [W]ord (cwd)" },
			{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", mode = "v", desc = "[S]earch [W]ord selected (cwd)" },
			{
				"gd",
				"<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>",
				desc = "Goto Definition",
			},
			{
				"gr",
				"<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>",
				desc = "References",
				nowait = true,
			},
			{
				"gI",
				"<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
				desc = "Goto Implementation",
			},
			{
				"gy",
				"<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>",
				desc = "Goto T[y]pe Definition",
			},
		},
	},
}
