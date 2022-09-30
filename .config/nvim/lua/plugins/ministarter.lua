-----------------------------------------------------------
-- mini configuration file
-- ----------------------------------------------------------

-- Plugin:
-- url:

local status_ok, starter = pcall(require, "mini.starter")
if not status_ok then
  return
end

starter.setup({
    evaluate_single = true,
    items = {
        {
            action = "Telescope projects",
            name = "Projects",
            section = "Telescope"
        },
        {
            action = "Telescope file_browser",
            name = "Browser",
            section = "Telescope"
        },
        {
            action = "Telescope find_files",
            name = "Files",
            section = "Telescope"
        },
        -- starter.sections.telescope(),
        starter.sections.recent_files(5, false),
        starter.sections.recent_files(5, true),
        starter.sections.builtin_actions(),
    },
    footer = os.date()
})
