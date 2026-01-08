# MOVED

I have moved all my personal projects over to [tangled.org](https://tangled.org/ejri.dev/) and [sourcehut](https://sr.ht/~ejri/).

I will be adding redirects to a domain that I own so I'm not tied to one single git forge, so if you still want to use the plugin, you can use this url:

lazy.nvim
```lua
{
  "https://plugins.ejri.dev/baredot.nvim",
  opts = {
    git_dir = "~/.cfg" -- Change this path
  }
}
```

# Baredot

This is a Neovim plugin to automatically adjust `git` env vars when syncing dotfiles using the "bare git repo" method:

[Dotfiles: Best way to store in a bare git repository](https://www.atlassian.com/git/tutorials/dotfiles)
