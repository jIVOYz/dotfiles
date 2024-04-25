return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = function()
    -- local builtin = require("telescope.builtin")
    return {
      { ";f", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { ";g", "<cmd>Telescope live_grep<CR>",  desc = "Live Grep" },
      { ";b", "<cmd>Telescope buffers<CR>",    desc = "Buffers" },
    }
  end,
}
