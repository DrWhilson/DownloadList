return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "User AstroFile",
  config = function()
    require("todo-comments").setup {
      -- здесь можно указать ваши настройки или оставить пустыми для дефолтных
    }
  end,
}
