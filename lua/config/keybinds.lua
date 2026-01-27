vim.keymap.set(
  "n",
  "<C-n>",
  "<cmd>:Neotree filesystem reveal left<CR>",
  { desc = "Neo-tree: Toggle file explorer" }
)
vim.keymap.set("n", "<C-g>", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
