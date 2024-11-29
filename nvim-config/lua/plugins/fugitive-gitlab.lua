return {
    "shumphrey/fugitive-gitlab.vim",
    config = function()
        vim.g.fugitive_gitlab_domains = { "https://git.orf.apa.net" }
        local token = os.getenv("GITLAB_TOKEN")
        vim.g.gitlab_api_keys = { ["git.orf.apa.net"] = token }
    end
}
