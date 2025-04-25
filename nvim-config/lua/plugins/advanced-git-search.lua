----------------------------------------------------------
-- Search your git history by commit message, content and author in Neovim
--
-- Source: https://github.com/aaronhallaert/advanced-git-search.nvim
----------------------------------------------------------
--
-- 📖 Open a picker
-- :AdvancedGitSearch or :AdvancedGitSearch {command}
--
-- 🔎 Enter a query
--
-- Your usual search experience. See the individual commands for the grep behaviour.
--
-- ✏️ Further search on commit author with @
--
-- The prompt is split on @. Everything following the @ is the pattern for the author name.
--

return {
    "aaronhallaert/advanced-git-search.nvim",
    requires = { "nvim-telescope/telescope.nvim", "tpope/vim-fugitive" },
}
