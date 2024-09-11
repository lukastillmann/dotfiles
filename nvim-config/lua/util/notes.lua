vim.api.nvim_create_user_command('Todo', function()
    local dir = os.getenv("LOGBOOK_DIR")

    if dir then
        -- Configure the popup window dimensions and position
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        -- Create a floating window
        local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
        vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = width,
            height = height,
            row = row,
            col = col,
            style = 'minimal'
        })

        -- Use vim to open the file
        vim.cmd('edit ' .. dir .. '/todo.md')
    else
        vim.notify('Environment variable LOGBOOK_DIR is not set or is empty', vim.log.levels.ERROR)
    end
end, {})

vim.api.nvim_create_user_command('Log', function()
    local dir = os.getenv("LOGBOOK_DIR")

    if dir then
        -- Configure the popup window dimensions and position
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        -- Create a floating window
        local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
        vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = width,
            height = height,
            row = row,
            col = col,
            style = 'minimal'
        })

        local filename = vim.fn.trim(vim.fn.system('date "+%Y-%m-%d"'))

        -- Use vim to open the file
        vim.cmd('edit ' .. dir .. '/' .. filename .. '.md')
    else
        vim.notify('Environment variable LOGBOOK_DIR is not set or is empty', vim.log.levels.ERROR)
    end
end, {})
