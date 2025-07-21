# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing Neovim configuration and development scripts. The main components are:

- **Neovim Configuration** (`nvim-config/`): Lua-based configuration using lazy.nvim plugin manager
- **Development Scripts** (`bin/`): AI-powered Git utilities for commit messages and stashing
- **System Setup** (`packages.sh`, `install_scripts/`): Scripts for setting up development environment

## Key Scripts and Commands

### AI Git Utilities
- `git ai-commit` - Generate conventional commit messages using AI (OpenAI GPT-4o)
- `git ai-helper` - Flexible AI helper supporting both OpenAI and Claude for commits/stashes
- `git ai-stash` - Generate descriptive stash messages using AI

These scripts require environment variables:
- `OPENAI_API_KEY` for OpenAI integration
- `ANTHROPIC_API_KEY` for Claude integration
- `AI_PROVIDER` (optional): set to "openai" or "claude" for git-ai-helper

### System Setup
- `./packages.sh` - Full Ubuntu/Debian system setup (Node.js, Neovim, development tools)
- `./install_scripts/install_lazygit.sh` - Install lazygit
- `./install_scripts/install_neovim.sh` - Install Neovim from source

### Commit Convention
Follows conventional commits as defined in `commit-types`:
- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Code formatting
- `refactor:` - Code restructuring
- `perf:` - Performance improvements
- `test:` - Testing changes

## Neovim Configuration Architecture

### Structure
- `init.lua` - Entry point, loads core modules and lazy.nvim
- `lua/core/` - Base configuration (options, keymaps, autocmds, GitLab integration)
- `lua/plugins/` - Plugin configurations (lazy.nvim format)
- `lua/config/` - Shared configuration (lazy.nvim setup, icons)
- `lua/util/` - Utility functions and personal note system

### Key Features
- **Plugin Manager**: lazy.nvim
- **LSP**: Full language server setup with Mason
- **AI Integration**: Multiple AI coding assistants (CodeCompanion, Claude Code, GP.nvim)
- **Git Integration**: Advanced Git workflow tools (Fugitive, GitSigns, LazyGit)
- **Custom Commands**: FluidCleanup function for specific text transformations
- **Leader Key**: Comma (`,`)

### Notable Plugins
- **Navigation**: Telescope, MiniFiles, Treewalker
- **LSP/Completion**: nvim-lspconfig, nvim-cmp, Mason
- **Git**: Fugitive, GitSigns, LazyGit integration
- **AI Tools**: CodeCompanion, Claude Code integration
- **UI**: Lualine, BufferLine, Noice, Which-Key

### Custom Keymaps
- Leader key: `,`
- `<leader>C` - Add console.log for word under cursor
- `<leader>L` - Add log statement for word under cursor  
- `<leader>P` - Paste yanked content in new line
- `mt`, `ms`, `mst` - Navigate to Vue template/script/style blocks
- Split management with `<leader>hjkl`

## Development Workflow

1. Use AI git utilities for consistent commit messages
2. Neovim with full LSP support for development
3. LazyGit for visual git operations
4. Custom FluidCleanup command for specific text processing tasks

## Notes
- GitLab integration available in `core/gitlab.lua`
- Personal note system in `util/notes.lua`
- Minimal init available at `minimal_init.lua` for troubleshooting