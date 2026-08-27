------ NEOTREE ------
-- open neotree on the left
vim.keymap.set(
  "n",
  "<C-n>",
  "<cmd>:Neotree toggle<CR>",
  { desc = "Neo-tree: Toggle file explorer" }
)


------ DEFINITIONS ------
-- go to definition
vim.keymap.set("n", "gd", function()
  if vim.bo.filetype == "java" then
    vim.lsp.buf.definition()
  else
    require("telescope.builtin").lsp_definitions()
  end
end, { desc = "Go to definition" })
-- open definition in split window
vim.keymap.set("n", "gD", "<cmd>vsplit | Telescope lsp_definitions<CR>")
-- go to type def
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
-- go to implementation
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
-- show references in current project
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })


------ THEME ------
-- open theme switcher
vim.keymap.set("n", "<C-s>", "<cmd>Themery<CR>", { desc = "Theme switcher" })


------ DIAGNOSTICS ------
-- diagnostic floating window
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
-- go to previous diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
-- go to next diagnostic
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })


------ SHOW KEY BINDS ------
-- open key bind helper
vim.keymap.set("n", "<leader>?", "<cmd>WhichKey<CR>", { desc = "Show all keybinds" })


------ MOUSE ------
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

------ NAVIGATION ------
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

------ SPELL CHECKER ------
-- toggle spell checker
vim.keymap.set("n", "<leader>ts", function()
  vim.opt.spell = not vim.opt.spell:get()
  print("Spell check: " .. (vim.opt.spell:get() and "enabled" or "disabled"))
end, { desc = "Toggle spell check" })
