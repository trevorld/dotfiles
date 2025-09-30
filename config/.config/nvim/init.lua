-- Useful settings
-- Note neovim sets a lot of stuff by default: https://neovim.io/doc/user/vim_diff.html#nvim-defaults
vim.opt.backup = false             -- do not keep a backup file
vim.opt.diffopt:append{"iwhite"}   -- ignore whitespace when diffing
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.maxmempattern = 2000000    -- solves error message
vim.opt.number = true              -- show line numbers
vim.opt.shell = "/bin/bash"
vim.opt.shiftwidth = 4             -- tabs will insert 4 spaces
vim.opt.spell = true
vim.opt.scs = true                 -- don't ignore case if enter uppercase letters
vim.opt.vb = true                  -- set visual beep

-- from: https://github.com/neovim/nvim-lspconfig#suggested-configuration
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.cmd 'colorscheme pablo'

-- Setup plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "R-nvim/R.nvim",
    lazy = false
  },
  "R-nvim/cmp-r",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp").setup({ sources = {{ name = "cmp_r" }}})
      require("cmp_r").setup({ })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "r", "markdown", "rnoweb", "yaml" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
  },
  {
      'cameron-wags/rainbow_csv.nvim',
      config = true,
      ft = {
          'csv',
          'tsv',
          'csv_semicolon',
          'csv_whitespace',
          'csv_pipe',
          'rfc_csv',
          'rfc_semicolon'
      },
      cmd = {
          'RainbowDelim',
          'RainbowDelimSimple',
          'RainbowDelimQuoted',
          'RainbowMultiDelim'
      }
  },
  {
  "nathangrigg/vim-beancount",
  ft = {'bean', 'beancount'}
  },
  "mfussenegger/nvim-lint",
})

require("lint").linters_by_ft = {
	beancount = {"bean_check", },
	python = {"flake8", }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
