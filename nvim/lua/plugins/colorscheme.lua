--[[
Possible choices
- tokyonight
- gruvbox
- catppuccin
- onedark
- cyberdream
- github_dark, github_dark_default, github_dark_dimmed
- rose-pine, rose-pine-moon, rose-pine-dawn
- kanagawa, kanagawa-wave, kanagawa-dragon, kanagawa-lotus
- nord
- vscode
- dracula, dracula-soft
]]

local colorscheme = "rose-pine"

return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    opts = {
      transparent = true,
      styles = { sidebars = "transparent", floats = "transparent" },
    },
    lazy = colorscheme ~= "tokyonight",
  },
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    opts = {},
    lazy = colorscheme ~= "gruvbox",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = { flavour = "macchiato" },
    lazy = colorscheme ~= "catppuccin",
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    priority = 1000,
    opts = { style = "darker" },
    lazy = colorscheme ~= "onedark",
  },
  {
    "scottmckendry/cyberdream.nvim",
    name = "cyberdream",
    priority = 1000,
    opts = { transparent = true },
    lazy = colorscheme ~= "cyberdream",
  },
  {
    name = "nord",
    "shaunsingh/nord.nvim",
    priority = 1000,
    lazy = colorscheme ~= "nord",
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    priority = 1000,
    lazy = not vim.startswith(colorscheme, "github_"),
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    -- opts = { styles = { transparency = true } },
    lazy = not vim.startswith(colorscheme, "rose-pine"),
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    opts = {},
    lazy = not vim.startswith(colorscheme, "kanagawa"),
  },
  {
    "Mofiqul/vscode.nvim",
    name = "vscode-theme",
    priority = 1000,
    lazy = colorscheme ~= "vscode",
  },
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    priority = 1000,
    lazy = not vim.startswith(colorscheme, "dracula"),
  },

  -- select colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
