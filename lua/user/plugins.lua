local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" })  -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs" })  -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "nvim-tree/nvim-web-devicons" })
  use({ "nvim-tree/nvim-tree.lua" })
  use({ "akinsho/bufferline.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "akinsho/toggleterm.nvim" })
  use({ "ahmedkhalf/project.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "goolord/alpha-nvim" })
  use({ "folke/which-key.nvim" })

  -- Colorschemes
  use({ "folke/tokyonight.nvim" })
  use({ "lunarvim/darkplus.nvim" })
  use {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  }
  -- Cmp
  use({ "hrsh7th/nvim-cmp" })         -- The completion plugin
  use({ "hrsh7th/cmp-buffer" })       -- buffer completions
  use({ "hrsh7th/cmp-path" })         -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })

  -- Snippets
  use({ "L3MON4D3/LuaSnip" })             --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig" })   -- enable LSP
  use({ "williamboman/mason.nvim" }) -- simple to use language server installer
  use({ "williamboman/mason-lspconfig.nvim" })
  -- use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use { 'mhartington/formatter.nvim' }
  use({ "RRethy/vim-illuminate" })
  use({ "p00f/clangd_extensions.nvim" }) -- Adds more clangd functions

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- Markdown Preview
  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  -- ALE for linting
  -- use {
  --  'w0rp/ale',
  --  ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
  --  cmd = 'ALEEnable',
  --  config = 'vim.cmd[[ALEEnable]]'
  --}

  -- Install Harpoon for file navigation
  -- use('theprimeagen/harpoon')

  -- Install undo tree
  -- use('mbbill/undotree')

  -- Install cphelper for competitive programming
  use({ "p00f/cphelper.nvim" })

  -- Install inlay_hints
  use({ "lvimuser/lsp-inlayhints.nvim" })

  -- Install debugger --> Still missing keymaps and configurations
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
  use({ "theHamsta/nvim-dap-virtual-text" })

  -- Install Bazel plugins
  -- use { 'google/vim-maktaba' }
  -- use { 'bazelbuild/vim-bazel' }
  -- use { 'alexander-born/bazel-vim' }
  -- use { 'alexander-born/cmp-bazel' }

  -- doxygen generator
  use({ "danymat/neogen" })

  -- Install orgmode for note taking
  -- use({ "nvim-orgmode/orgmode" })

  -- Instll aerial for C/C++ tags browsing
  use({ "stevearc/aerial.nvim" })

  -- Install git-worktree
  -- use {"ThePrimeagen/git-worktree.nvim"}

  -- setup for notify is not complete
  use({ "rcarriga/nvim-notify" })

  -- use({
  --	"epwalsh/pomo.nvim",
  --	tag = "*", -- Recommended, use latest release instead of latest commit
  --	requires = {
  --		-- Optional, but highly recommended if you want to use the "Default" timer
  --		"rcarriga/nvim-notify",
  --	},
  -- })

  use({
    "folke/noice.nvim",
    tag = "*", -- Recommended, use latest release instead of latest commit
    requires = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
      "MunifTanjim/nui.nvim",
    },
  })

  use({ "rmagatti/goto-preview" })
  -- LLM gen model config is not complete
  use({ "David-Kunz/gen.nvim" })

  -- install Zen-mode plugin https://github.com/folke/zen-mode.nvim

  -- Git related plugins
  -- use({ "tpope/vim-fugitive" })

  -- Enable smartyank
  use({ "ibhagwan/smartyank.nvim" })

  --   use({
  --   "epwalsh/obsidian.nvim",
  --   tag = "*",  -- recommended, use latest release instead of latest commit
  --   requires = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --
  --     -- see below for full list of optional dependencies 👇
  --   },
  --   config = function()
  --     require("obsidian").setup({
  --       workspaces = {
  --         {
  --           name = "personal",
  --           path = "~/vaults/personal",
  --         },
  --         {
  --           name = "work",
  --           path = "~/vaults/work",
  --         },
  --       },
  --
  --       -- see below for full list of options 👇
  --     })
  --   end,
  -- })
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  use({ "mistricky/codesnap.nvim", run = "make" })
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
