return {
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {},
    build = function()
      require("typst-preview").update()
    end,
  },
}
