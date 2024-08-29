-- Function to escape special pattern characters
local function escape_pattern(text)
    return text:gsub("([^%w])", "%%%1")
end

-- Function to find the Git root directory
local function find_git_root()
    local current_file_dir = vim.fn.expand("%:p:h")
    while current_file_dir ~= "/" do
        if vim.fn.isdirectory(current_file_dir .. "/.git") == 1 then
            return escape_pattern(current_file_dir)
        end
        current_file_dir = vim.fn.fnamemodify(current_file_dir, ":h")
    end
    return nil
end

-- Function to extract the GitLab project directory from the remote URL
local function get_gitlab_project_directory()
    local git_remote_cmd = "git remote get-url origin"
    local handle = io.popen(git_remote_cmd)
    local git_remote_url = handle:read("*a"):gsub("%s+", "")
    handle:close()

    if git_remote_url == "" then
        print("Unable to find remote origin URL.")
        return nil
    end

    -- Remove the protocol part (e.g., https:// or git@) and the ".git" suffix
    git_remote_url = git_remote_url:gsub("^[^:]+://", ""):gsub("^[^@]+@", "")
    git_remote_url = git_remote_url:gsub("%.git$", "")

    -- Extract the project directory (everything after the colon)
    local project_directory = git_remote_url:gsub("^[^:]*:", "")

    if project_directory == nil then
        print("Failed to parse GitLab project directory.")
        return nil
    end

    return project_directory
end


-- Function to generate a GitLab URL based on the current file and line number
local function generate_gitlab_url()
    -- Retrieve GitLab repository URL from environment variable (edit the variable name if needed)
    local gitlab_repo_url = os.getenv("GITLAB_URL")

    if gitlab_repo_url == nil or gitlab_repo_url == "" then
        print("GITLAB_REPO_URL environment variable is not set.")
        return
    end

    -- Get the Git root directory
    local git_root = find_git_root()

    if git_root == "" then
        print("Not inside a Git repository.")
        return
    end

    -- Get the GitLab project directory
    local project_directory = get_gitlab_project_directory()

    if project_directory == nil then
        return
    end

    -- Get the current file path relative to the Git root
    local current_file = vim.fn.expand("%:p")
    local relative_file_path = current_file:gsub("^" .. git_root .. "/", "")

    -- Get the current line number
    local line_number = vim.fn.line(".")

    -- Construct the URL
    local gitlab_url = gitlab_repo_url ..
        "/" .. project_directory .. "/-/blob/main/" .. relative_file_path .. "#L" .. line_number

    -- Print the URL or copy it to the clipboard
    vim.fn.setreg("+", gitlab_url)
    print("GitLab URL: " .. gitlab_url .. " (copied to clipboard)")
end

-- Map the function to a command (you can change the command name if desired)
vim.api.nvim_create_user_command('GenerateGitLabURL', generate_gitlab_url, {})

-- Optionally, you can map this command to a keybinding
vim.api.nvim_set_keymap('n', '<leader>gu', ':GenerateGitLabURL<CR>', { noremap = true, silent = true })
