return {
    "echasnovski/mini.nvim",
    config = function()
        -- require("mini.ai").setup({ n_lines = 500 })
        require("mini.surround").setup()
        -- require("mini.statusline").setup({
        --     set_vim_settings = false,
        --     laststatus = 2,
        -- })
    end,
}
