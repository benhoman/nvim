return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- extras
		"folke/neodev.nvim",
		{
			"j-hui/fidget.nvim",
			opts = {},
			-- opts = {
			-- 	notification = {
			-- 		window = { winblend = 0 },
			-- 	},
			-- },
		},

		-- dependencies
		"hrsh7th/cmp-nvim-lsp",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		require("neodev").setup()

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local builtin = require("telescope.builtin")

				-- Important LSP Navigation keybinds
				--
				-- Jump to the definition of the word under your cursor.
				--  To jump back, press <C-T>.
				map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
				map("gr", builtin.lsp_references, "[G]oto [R]eferences")
				map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Rename the variable under your cursor
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", function()
					vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
				end, "[C]ode [A]ction")

				-- See `:help K` for why this keymap
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				-- Show the signature of the function you"re currently completing.
				map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
			end,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		local servers = {
			clangd = {},
			gopls = {},
			pyright = {},
			rust_analyzer = {},
			html = { filetypes = { "html", "twig", "hbs" } },
			tsserver = {},
			zls = {},

			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						-- You can toggle below to ignore Lua_LS"s noisy `missing-fields` warnings
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"jsonls",
			"pyright",
			"flake8",
			"ruff",
		})

		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					require("lspconfig")[server_name].setup({
						cmd = server.cmd,
						settings = server.settings,
						filetypes = server.filetypes,
						capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
					})
				end,
			},
		})
	end,
}
