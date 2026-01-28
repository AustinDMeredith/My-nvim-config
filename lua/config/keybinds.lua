vim.keymap.set(
  "n",
  "<C-n>",
  "<cmd>:Neotree toggle<CR>",
  { desc = "Neo-tree: Toggle file explorer" }
)
vim.keymap.set("n", "<C-g>", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
--vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { desc = "Terminal" })
--vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
