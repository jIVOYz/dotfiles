return {
  -- Catppuccin theme
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({ flavour = "latte" })
  end,
}
