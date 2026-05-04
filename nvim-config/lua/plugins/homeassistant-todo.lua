return {
    dir = "/Users/lukas/homeassistant-nvim",
    name = "ha_todo",
    cmd = "HATodoOpen",
    keys = {
        { "tt", "<cmd>HATodoOpen<cr>", desc = "Open [T]odo List" },
    },
    config = function()
        require("ha_todo").setup({
            instance = {
                url = "https://ha.tillmann.wien",
                token = "cmd:cat /Volumes/Secrets/keys/homeassistant-nvim",
            },
            picker = "snacks",
            open_cmd = "topleft 40vsplit",
            default_list = "todo.lukas"
        })
    end,
}
