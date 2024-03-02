return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function ()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.bashls.setup({})
      lspconfig.remark_ls.setup({})
    end
  }
}
