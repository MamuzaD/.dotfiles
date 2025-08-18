return {
  "sindrets/diffview.nvim",
  config = function()
    local function toggle_diffview()
      local view = require("diffview.lib").get_current_view()
      if view then
        vim.cmd("DiffviewClose")
      else
        vim.cmd("DiffviewOpen")
        vim.cmd("DiffviewToggleFiles")
      end
    end

    require("which-key").add({
      {
        "<leader>gd",
        toggle_diffview,
        desc = "Diffview",
        icon = { icon = "󰊢", color = "orange" },
        mode = "n",
      },
    })
  end,
}
