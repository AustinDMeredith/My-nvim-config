vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = ""
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.updatetime = 250
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.pumblend = 0          -- no transparency on menu
vim.opt.winblend = 0          -- no transparency on floats
vim.opt.pumheight = 10        -- max items shown at once (optional)
vim.opt.spell = false
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-iCursor,r-cr:hor20,o:hor50"
vim.opt.spelllang = "en_us"
-- use OSC 52 for clipboard
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
vim.opt.clipboard = "unnamedplus"
