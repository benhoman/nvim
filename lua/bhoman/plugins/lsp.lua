return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              -- You can toggle below to ignore Lua_LS"s noisy `missing-fields` warnings
              diagnostics = { disable = { "missing-fields" } },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                }
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- "stylua",
        "jsonls",
        "ruff",
      })

      require("mason").setup()
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            lspconfig[server_name].setup({
              cmd = server.cmd,
              settings = server.settings,
              filetypes = server.filetypes,
              capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
            })
          end,
        },
      })

      -- vim.api.nvim_create_autocmd("LspAttach", {
      -- 	callback = function(args)
      -- 		local c = vim.lsp.get_client_by_id(args.data.client_id)
      -- 		if not c then
      -- 			return
      -- 		end
      --
      -- 		-- Format the current buffer on save
      -- 		vim.api.nvim_create_autocmd("BufWritePre", {
      -- 			buffer = args.buf,
      -- 			callback = function()
      -- 				vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
      -- 			end,
      -- 		})
      --
      -- 		local map = function(keys, func, desc)
      -- 			vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
      -- 		end
      --
      -- 		map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
      -- 	end,
      -- })
    end,
  },
}
