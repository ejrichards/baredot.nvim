# Baredot

This is a Neovim plugin to automatically adjust `git` env vars when syncing dotfiles using the "bare git repo" method:

[Dotfiles: Best way to store in a bare git repository](https://www.atlassian.com/git/tutorials/dotfiles)

## Details

When launching and when changing directory (eg. `:cd`), the plugin will detect if the current
directory is in a git repo by searching for a `.git` folder.

- If a `.git` folder is found, the env vars are cleared and `git` will work as normal.
- If a `.git` folder is not found, and we are in `$HOME`, the env vars will be adjusted to use the
bare git repo.  This will let other git plugins function using that repo.

## Setup

lazy.nvim
```lua
{
  "ejrichards/baredot.nvim",
  opts = {
    git_dir = "~/.cfg" -- Change this path
  }
}
```

## Configuration

```lua
{
  -- These two options set the GIT_DIR and GIT_WORK_TREE env vars
  -- They are expanded using "vim.fn.expand"
  git_dir = "~/.cfg",
  git_work_tree = "~",
  -- Filename pattern to find that will disable Baredot
  disable_pattern = "%.git"
}
```

## Commands

- `:BaredotInfo` - Print current status
- `:BaredotToggle` - Manually toggle the env vars on / off

## Functions

- `require("baredot").info()` - Print current status
- `require("baredot").is_enabled()` - Returns current status as boolean
- `require("baredot").toggle()` - Manually toggle the env vars on / off
- `require("baredot").set(boolean)` - Set the env vars on / off
