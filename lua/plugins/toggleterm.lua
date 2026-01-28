return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-t>]],
        direction = "float", -- "horizontal" | "vertical" | "float"
        float_opts = {
          border = "rounded",
        },
        shade_terminals = true,
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      })
    end,
  },
}
