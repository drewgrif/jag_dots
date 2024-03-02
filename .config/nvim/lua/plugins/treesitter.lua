return
{
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "rasi", "bash", "go" },

      auto_install = true,

      highlight = {
        enable = true,
      },
    })
  end,
}
