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
--vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { desc = "Terminal" })
--vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
