return {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-night")

      -- You can configure highlights by doing something like
      vim.cmd.hi("Comment gui=none")
    end,
  },
}
