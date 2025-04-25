-- setup base options and keymaps
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- custom gitlab integration
require("core.gitlab")
-- personal log
require("util.notes")

-- bootstrap lazy.nvim and plugins
require("config.lazy")
