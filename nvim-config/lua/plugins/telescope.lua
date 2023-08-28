local Util = require("util")

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
        telescope.load_extension("ui-select")
        telescope.load_extension("advanced_git_search")
        telescope.load_extension("notify")
        telescope.load_extension("luasnip")
        telescope.load_extension("aerial")

        telescope.setup(opts)
    end,
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = {
                i = {
                    ["<PageUp>"] = "preview_scrolling_up",
                    ["<PageDown>"] = "preview_scrolling_down",
                    ["<C-h>"] = "select_vertical",
                    ["<C-j>"] = "select_horizontal",
                },
                n = {
                    ["<h>"] = "select_vertical",
                },
            },
        },
        pickers = {
            find_files = {
                theme = "dropdown",
                hidden = true,
            },
        },
        extensions = {
            file_browser = {
                theme = "dropdown",
                hijack_netrw = true,
            },
            ["ui-select"] = {
                theme = "dropdown",
            },
        },
    },
    keys = {
        { "<leader>,",  "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "ff",         Util.telescope("files"),                            desc = "[F]ind [F]iles" },
        { "<leader>fg", Util.telescope("live_grep"),                        desc = "[F]ind by [G]rep" },
        { "<leader>fw", Util.telescope("grep_string"),                      desc = "[F] current [W]ord" },
        { "<leader>fr", Util.telescope("resume"),                           desc = "[F]ind [Resume] last telescope" },

        -- git
        { "<leader>gb", Util.telescope("git_branches"),                     desc = "[G]it [B]rances" },

        -- aerial
        { "<leader>a",  "<cmd>Telescope aerial<cr>",                        desc = "Open [A]erial using telescope" },
        { "<leader>A",  require("aerial").toggle,                           desc = "Open [A]erial" },
        --		{
        --			"<leader>gf",
        --			require("telescope").extensions.advanced_git_search.diff_commit_file,
        --			{ desc = "[G]it commits for [F]ile" },
        --		},
    },
}
