return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
    "folke/which-key.nvim",
  },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    require("oil").setup({})

    require("which-key").add({
      {
        "<leader>o",
        "<cmd>Oil<cr>",
        desc = "Oil",
        icon = { icon = "󰏇", color = "yellow" },
        mode = "n",
      },
    })
  end,
}
