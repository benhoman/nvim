return {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            -- NOTE: `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    -- keys = {
    --     {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file"},
    --     {"<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find file"},
    --     {"<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live grep"},
    --     {"<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Grep string"},
    --     {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffer"},
    --     {"<leader>fg", "<cmd>Telescope help_tags<cr>", desc = "Find help tag"},
    -- },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

            -- Load Extensions
        local load_extension = require("telescope").load_extension
        pcall(load_extension, "fzf")
        pcall(load_extension, "ui-select")


        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        -- Also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular pickers
        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files' })

        -- Shortcut for searching your neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files {
                cwd = vim.fn.stdpath 'config',
            }
        end, { desc = '[S]earch [N]eovim files' })
    end,
}
