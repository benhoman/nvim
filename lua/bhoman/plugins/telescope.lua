return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                              , branch = '0.1.x',
      dependencies = {
	      'nvim-lua/plenary.nvim',
	      {
		    "nvim-telescope/telescope-fzf-native.nvim",
		    build = "make",
		    config = function()
		      require("telescope").load_extension("fzf")
		    end,
		  },
      },
      keys = {
          {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file"},
          {"<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find file"},
          {"<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live grep"},
          {"<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Grep string"},
          {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffer"},
          {"<leader>fg", "<cmd>Telescope help_tags<cr>", desc = "Find help tag"},
      },
    }
