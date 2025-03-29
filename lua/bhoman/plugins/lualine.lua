return {
  -- Set lualine as statusline
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "|",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_c = { { "filename", path = 1 } },
    },
  },
}
