return {
    "ravitemer/mcphub.nvim",
    cmd = "MCPHub",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
        require("mcphub").setup()
    end
}
