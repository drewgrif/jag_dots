-- snippet engine.
return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
    require("luasnip/loaders/from_vscode").lazy_load()
    require("luasnip").setup({
      updateevents = "TextChanged, TextChangedI",
    })
  end,
}
