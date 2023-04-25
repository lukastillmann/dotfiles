local Util = require("util")

return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("advanced_git_search")

--        -- enable telescope for aerial
--        telescope.load_extension('aerial')
--
    end,
    defaults = {
        mappings = {
            i = {
                -- ["<PageUp>"] = "preview_scrolling_up",
                -- ["<PageDown>"] = "preview_scrolling_down",
                ['<C-h>'] = "select_vertical",
                ['<C-j>'] = "select_horizontal",
              },
        },
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            hidden = true
        },
    },
    extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true
        },
        ["ui-select"] = {
          theme = "dropdown"
        },
    },
    keys = {
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer" }},
      { "ff", Util.telescope("files"), {desc = "[F]ind [F]iles" }},
      { "<leader>fg", Util.telescope("live_grep"), { desc = "[F]ind by [G]rep" }},
      { "<leader>fr", Util.telescope("resume"), { desc = "[F]ind [Resume] last telescope" }},

      -- git
      { "<leader>gb", Util.telescope("git_branches"), { desc = "[G]it [B]rances" } },
      { "<leader>gf", require("telescope").extensions.advanced_git_search.diff_commit_file, { desc = "[G]it commits for [F]ile" } }
    },
}
