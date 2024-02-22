return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"folke/neodev.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		"hrsh7th/cmp-nvim-lsp",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		require("neodev").setup()

		--  This function gets run when an LSP connects to a particular buffer.
		local on_attach = function(_, bufnr)
			-- We create a function that lets us more easily define mappings specific
			-- for LSP related items. It sets the mode, buffer and description for us each time.
			local nmap = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			-- Important LSP Navigation keybinds
			--
			-- Jump to the definition of the word under your cursor.
			--  To jump back, press <C-T>.
			local builtin = require("telescope.builtin")
			nmap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
			nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
			nmap("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
			nmap("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
			nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
			nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

			-- NOTE: This is not Goto Definition, this is Goto Declaration.
			--  For example, in C this would take you to the header
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

			-- Rename the variable under your cursor
			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

			-- Execute a code action, usually your cursor needs to be on top of an error
			-- or a suggestion from your LSP for this to activate.
			nmap("<leader>ca", function()
				vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
			end, "[C]ode [A]ction")

			-- See `:help K` for why this keymap
			nmap("K", vim.lsp.buf.hover, "Hover Documentation")

			-- Show the signature of the function you're currently completing.
			nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
		end

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP Specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilties with nvim cmp, and then broadcast that to the servers.
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		-- Enable the following language servers
		local servers = {
			-- clangd = {},
			gopls = {},
			pyright = {},
			rust_analyzer = {},
			tsserver = {},
			html = { filetypes = { "html", "twig", "hbs" } },

			jsonls = {},

			lua_ls = {
				-- cmd = {...},
				-- filetypes { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
		}

		-- Ensure the servers above are installed
		require("mason").setup()

		local installed = { "jsonls", "pyright", "stylua", "ruff" }
		vim.list_extend(installed, vim.tbl_keys(servers))
		require("mason-tool-installer").setup({ ensure_installed = installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					require("lspconfig")[server_name].setup({
						cmd = server.cmd,
						settings = server.settings,
						filetypes = server.filetypes,
						on_attach = on_attach,
						-- TODO: Think about what we wanna do here.
						-- capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities),
						capabilities = server.capabilities or capabilities,
					})
				end,
			},
		})
	end,
}
