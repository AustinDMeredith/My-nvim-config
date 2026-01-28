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
      local Terminal = require("toggleterm.terminal").Terminal

      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = { border = "rounded" },
      })

      local function toggle_lazygit()
        lazygit:toggle()
      end

      -- Map in BOTH normal and terminal mode
      vim.keymap.set({ "n", "t" }, "<C-g>", toggle_lazygit, { desc = "Toggle LazyGit", silent = true })
    end,
  },
}
