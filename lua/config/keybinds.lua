vim.keymap.set(
  "n",
  "<C-n>",
  "<cmd>:Neotree toggle<CR>",
  { desc = "Neo-tree: Toggle file explorer" }
)

-- go to definition
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")

-- open definition in split window
vim.keymap.set("n", "gD", "<cmd>vsplit | Telescope lsp_definitions<CR>")

-- open theme switcher
vim.keymap.set("n", "<C-s>", "<cmd>Themery<CR>", { desc = "Theme switcher" })

-- diagnostic floating window
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- open keybind helper
vim.keymap.set("n", "<leader>?", "<cmd>WhichKey<CR>", { desc = "Show all keybinds" })

-- toggle mouse
vim.keymap.set("n", "<leader>tm", function()
  if vim.opt.mouse:get() == "" then
    vim.opt.mouse = "a"
    print("Mouse enabled")
  else
    vim.opt.mouse = ""
    print("Mouse disabled")
  end
end, { desc = "Toggle mouse" })
--vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { desc = "Terminal" })
--vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
